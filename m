Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129230AbQKQDVO>; Thu, 16 Nov 2000 22:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130692AbQKQDVE>; Thu, 16 Nov 2000 22:21:04 -0500
Received: from mail2.rdc3.on.home.com ([24.2.9.41]:57334 "EHLO
	mail2.rdc3.on.home.com") by vger.kernel.org with ESMTP
	id <S130663AbQKQDUy>; Thu, 16 Nov 2000 22:20:54 -0500
Message-ID: <3A149D00.9D38FA24@home.com>
Date: Thu, 16 Nov 2000 21:50:40 -0500
From: John Cavan <johncavan@home.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] (new for ppa and imm) Re: [PATCH] Re: Patch to fix lockup on ppa 
 insert
In-Reply-To: <3A13D4BA.AD4A580B@home.com> <3A13D8D6.8C12E31A@home.com> <20001116162027.C597@suse.de>
Content-Type: multipart/mixed;
 boundary="------------0A70F280F0F9958FF507D7EF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------0A70F280F0F9958FF507D7EF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Jens Axboe wrote:
> Wouldn't it be more interesting to fix the reason the new error
> handling code dies with imm and ppa?

Yes it would... :o) I think I've got it here.

The new error handling code spinlocks the IRQ which cause the lowlevel
parport driver to choke. This patch unlocks, allows the lowlevel driver
to do it's probes, and then relocks. It could probably be more granular
in the parport_pc code, but my own home tests show it to be working
fine.

John
--------------0A70F280F0F9958FF507D7EF
Content-Type: text/plain; charset=us-ascii;
 name="zip.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="zip.patch"

diff -urN -X /usr/src/dontdiff linux.clean/drivers/scsi/imm.c linux.current/drivers/scsi/imm.c
--- linux.clean/drivers/scsi/imm.c	Thu Nov 16 07:25:29 2000
+++ linux.current/drivers/scsi/imm.c	Thu Nov 16 21:39:10 2000
@@ -122,7 +122,15 @@
     struct Scsi_Host *hreg;
     int ports;
     int i, nhosts, try_again;
-    struct parport *pb = parport_enumerate();
+    struct parport *pb;
+
+    /*
+     * unlock to allow the lowlevel parport driver to probe
+     * the irqs
+     */
+    spin_unlock_irq(&io_request_lock);
+    pb = parport_enumerate();
+    spin_lock_irq(&io_request_lock);
 
     printk("imm: Version %s\n", IMM_VERSION);
     nhosts = 0;
diff -urN -X /usr/src/dontdiff linux.clean/drivers/scsi/ppa.c linux.current/drivers/scsi/ppa.c
--- linux.clean/drivers/scsi/ppa.c	Thu Nov 16 07:25:29 2000
+++ linux.current/drivers/scsi/ppa.c	Thu Nov 16 21:37:33 2000
@@ -111,7 +111,15 @@
     struct Scsi_Host *hreg;
     int ports;
     int i, nhosts, try_again;
-    struct parport *pb = parport_enumerate();
+    struct parport *pb;
+
+    /*
+     * unlock to allow the lowlevel parport driver to probe
+     * the irqs
+     */
+    spin_unlock_irq(&io_request_lock);
+    pb = parport_enumerate();
+    spin_lock_irq(&io_request_lock);
 
     printk("ppa: Version %s\n", PPA_VERSION);
     nhosts = 0;

--------------0A70F280F0F9958FF507D7EF--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
