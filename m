Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135871AbRECR60>; Thu, 3 May 2001 13:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135879AbRECR52>; Thu, 3 May 2001 13:57:28 -0400
Received: from smtp.alacritech.com ([209.10.208.82]:32786 "EHLO
	smtp.alacritech.com") by vger.kernel.org with ESMTP
	id <S135871AbRECRzn>; Thu, 3 May 2001 13:55:43 -0400
Message-ID: <3AF19A17.19C2741F@alacritech.com>
Date: Thu, 03 May 2001 10:49:11 -0700
From: "Matt D. Robinson" <yakker@alacritech.com>
Organization: Alacritech, Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: smp_send_stop() and disable_local_APIC()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like around 2.3.30 or so, someone added the call
disable_local_APIC() to smp_send_stop().  I'm not sure what the
intention was, but I'm getting some strange behavior as a result
based on some code I'm writing.

Basically, I'm doing the following ...

    panic()
    {
        /* do whatever you want, notifier list, etc. */
        smp_send_stop();
        write_system_memory();
        /* then do whatever */
    }

write_system_memory() does a write of all system memory pages to some
block device.  It uses kiobufs as the way to get the pages to disk,
doing brw_kiovec() on those pages (using either the IDE or SCSI
driver to write the data).

The wierd behavior I see is that sometimes, smp_send_stop()
being called causes the system to hang up (not every time).  If
we don't call smp_send_stop() on those systems, everything works fine.
This looks to be directly caused by the disabling of the APIC, which
we may need to dump pages to local disk.  This only applies to some
people's systems -- not everyone displays the same behavior.

I'm sure it's good to disable the APIC, but there's no clean way to
wait on disabling the APIC until after I'm done writing pages out.

My questions are:

1) Why was disable_local_APIC() added to stop_this_cpu()
   and smp_send_stop()?  Completeness?

2) Is there a better way around this to disable all the
   other CPUs without disabling the APIC?

Thanks for any feedback.

--Matt
