Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262123AbTKQXyU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 18:54:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262130AbTKQXyU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 18:54:20 -0500
Received: from 64-52-142-65.client.cypresscom.net ([64.52.142.65]:51343 "EHLO
	scsoftware.sc-software.com") by vger.kernel.org with ESMTP
	id S262123AbTKQXyS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 18:54:18 -0500
Date: Mon, 17 Nov 2003 15:53:19 -0800 (PST)
From: John Heil <kerndev@sc-software.com>
To: <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>
cc: John Heil <johnhscs@scsoftware.sc-software.com>
Subject: [PATCH] [USB2] 2.6.0-test9-mm2 HiSpd Isoc 1024KB submits: -EMSGSIZE
Message-ID: <Pine.LNX.4.33.0311171529030.5878-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


High speed isochronous URB submits fail w -EMSGSIZE when packet
size is 1024KB (which is permitted by the USB 2.0 Std).

Max Packet Size is conveyed to the host controller via the iTD's
Buffer Pointer Page 1 field, @ offset +0x28[10:0].

drivers/usb/core/urb.c: usb_submit_urb incorrectly scales this
value w an AND mask of 0x03ff while determining the count of
packets. usb/host/ehci-sched.c repeats the error.

This fix corrects the AND mask allowing 1024K packets to flow.


[root@localhost src]# less usb2-isoc-1024.patch
diff -Nru 2.6.0-t9-mm2.orig/drivers/usb/core/urb.c
2.6.0-t9-mm2/drivers/usb/core/urb.c
--- 2.6.0-t9-mm2.orig/drivers/usb/core/urb.c    2003-10-25
14:43:54.000000000 -0400
+++ 2.6.0-t9-mm2/drivers/usb/core/urb.c 2003-11-17 13:25:32.000000000
-0500
@@ -268,7 +268,7 @@
                /* "high bandwidth" mode, 1-3 packets/uframe? */
                if (dev->speed == USB_SPEED_HIGH) {
                        int     mult = 1 + ((max >> 11) & 0x03);
-                       max &= 0x03ff;
+                       max &= 0x07ff;
                        max *= mult;
                }

diff -Nru 2.6.0-t9-mm2.orig/drivers/usb/host/ehci-sched.c
2.6.0-t9-mm2/drivers/usb/host/ehci-sched.c
--- 2.6.0-t9-mm2.orig/drivers/usb/host/ehci-sched.c     2003-10-25
14:43:19.000000000 -0400
+++ 2.6.0-t9-mm2/drivers/usb/host/ehci-sched.c  2003-11-17
13:27:08.000000000 -0500
@@ -580,10 +580,10 @@
                maxp = urb->dev->epmaxpacketout [epnum];
                buf1 = 0;
        }
-       buf1 |= (maxp & 0x03ff);
+       buf1 |= (maxp & 0x07ff);
        multi = 1;
        multi += (maxp >> 11) & 0x03;
-       maxp &= 0x03ff;
+       maxp &= 0x07ff;
        maxp *= multi;

        /* transfer can't fit in any uframe? */



-
-----------------------------------------------------------------
John Heil
South Coast Software
Custom systems software for UNIX and IBM MVS mainframes
1-714-774-6952
johnhscs@sc-software.com
http://www.sc-software.com
-----------------------------------------------------------------


