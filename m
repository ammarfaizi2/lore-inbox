Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135636AbRDSMEF>; Thu, 19 Apr 2001 08:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135638AbRDSMD4>; Thu, 19 Apr 2001 08:03:56 -0400
Received: from hitpro.hitachi.co.jp ([133.145.224.7]:35309 "EHLO
	hitpro.hitachi.co.jp") by vger.kernel.org with ESMTP
	id <S135636AbRDSMDn>; Thu, 19 Apr 2001 08:03:43 -0400
To: linux-kernel@vger.kernel.org
Subject: Kernel panics on raw I/O stress test
From: Takanori Kawano <t-kawano@ebina.hitachi.co.jp>
X-Mailer: Mew version 1.94.1 on Emacs 20.4 / Mule 4.1 (AOI)
Reply-To: t-kawano@ebina.hitachi.co.jp
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Message-Id: <20010419210153Z.t-kawano@ebina.hitachi.co.jp>
Date: Thu, 19 Apr 2001 21:01:53 +0900 (JST)
X-Dispatcher: imput version 990905(IM130)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When I ran raw I/O SCSI read/write test with 2.4.1 kernel 
on our IA64 8way SMP box, kernel paniced and following 
message was displayed.

  Aiee, killing interrupt handler!

No stack trace and register dump are displayed.

Then I analyze FSB traces around the panic, and found that 
following functions are called before panic().


   CPU0:                              CPU1:

      ・                                  ・
      ・                                  ・
      ・                                rw_raw_dev()
      ・                                  ・
      ・                                  ・
      ・                                 brw_kiovec()
      ・                                  ・
      ・                                  ・
      ・                                 free_kiovec()
      ・                                  ・
      ・                                  ・
    end_kio_request()
     __wake_up()
     ia64_do_page_fault()
      do_exit()
       panic()

I suppose that free_kiobuf() is called on CPU1 before 
end_kio_request() is called on CPU0 for the same kiobuf
and resulted in the panic.
In 2.4.1 source code, I think there is no assurance 
that free_kiovec() in rw_raw_dev() is called after 
end_kio_request() is done.

I tried following two workarounds. 

(1) Wait in rw_raw_dev() while io_count is positive. 

--- drivers/char/raw.c        Mon Oct  2 12:35:15 2000
+++ drivers/char/raw.c.workaround       Thu Apr 19 16:54:26 2001
@@ -333,6 +333,11 @@
                        break;
        }

+       while(atomic_read(&iobuf->io_count)) {
+         set_task_state(current, TASK_UNINTERRUPTIBLE);
+         schedule();
+       }
+
        free_kiovec(1, &iobuf);

        if (transferred) {



(2) Keep buffer lock until end_kio_request() is done.

--- fs/buffer.c       Tue Jan 16 05:42:32 2001
+++ fs/buffer.c.workaround      Thu Apr 19 17:22:19 2001
@@ -1990,8 +1990,8 @@
        mark_buffer_uptodate(bh, uptodate);

        kiobuf = bh->b_private;
-       unlock_buffer(bh);
        end_kio_request(kiobuf, uptodate);
+       unlock_buffer(bh);
 }



Both of them worked well for our raw I/O testing,
but I'm not sure they are right.

Does anybody have comments? 

regards,

---
Takanori Kawano
Hitachi Ltd,
Internet Systems Platform Division
t-kawano@ebina.hitachi.co.jp

