Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbUDEKfw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 06:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbUDEKfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 06:35:52 -0400
Received: from wsp.xs4all.nl ([80.126.33.14]:9600 "EHLO wsprwl.xs4all.nl")
	by vger.kernel.org with ESMTP id S261728AbUDEKfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 06:35:43 -0400
Message-ID: <4071367B.2060103@xs4all.nl>
Date: Mon, 05 Apr 2004 12:35:39 +0200
From: Ruud Linders <rkmp@xs4all.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.x kernels and ttyS45 for 6 serial ports ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some time ago I reported that serial ports numbering on 2.5.x/2.6.x
was rather weird when used with a 4-serial port PCI card and 2
standard onboard serial ports.
I got devices ttyS0/1/14/15/2/3 or something.

Now checking this on 2.6.5 it got more confusing, I now have with
total of 6 serial ports a device number ttyS45 !?

The way this device numbering seems to work is that many device names
are reserved in include/asm/serial.h for devices like fourport/boca/hub6.
Anything else (=all PCI cards?) gets a number still unassigned.

Note that eg. the SCSI disk equivalent of this strategy would be to
reserver eg. sda-sde for IBM disks and other brands start
numbering at sdf !

Attached patch 'fixes' this for me, been using it for past
6 months or so.

Regards,
         Ruud Linders

__

Dmesg from 2.6.5
================
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS14 at I/O 0xb800 (irq = 21) is a 16550A
ttyS15 at I/O 0xb808 (irq = 21) is a 16550A
ttyS44 at I/O 0xb810 (irq = 21) is a 16550A
ttyS45 at I/O 0xb818 (irq = 21) is a 16550A

Applied this patch on stock 2.6.5
=================================
--- serial_core.c.ORIG  2004-03-19 18:29:20.000000000 +0100
+++ serial_core.c       2004-04-05 12:32:33.000000000 +0200
@@ -2306,17 +2306,6 @@
                         return &drv->state[i];

         /*
-        * We didn't find a matching entry, so look for the first
-        * free entry.  We look for one which hasn't been previously
-        * used (indicated by zero iobase).
-        */
-       for (i = 0; i < drv->nr; i++)
-               if (drv->state[i].port->type == PORT_UNKNOWN &&
-                   drv->state[i].port->iobase == 0 &&
-                   drv->state[i].count == 0)
-                       return &drv->state[i];
-
-       /*
          * That also failed.  Last resort is to find any currently
          * entry which doesn't have a real port associated with it.
          */


And now I get this more logical numbering
=========================================
Serial: 8250/16550 driver $Revision: 1.90 $ 48 ports, IRQ sharing enabled
ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
ttyS2 at I/O 0xb800 (irq = 21) is a 16550A
ttyS3 at I/O 0xb808 (irq = 21) is a 16550A
ttyS4 at I/O 0xb810 (irq = 21) is a 16550A
ttyS5 at I/O 0xb818 (irq = 21) is a 16550A

