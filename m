Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbTKKUcq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 15:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263785AbTKKUcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 15:32:43 -0500
Received: from smtp2.fre.skanova.net ([195.67.227.95]:5874 "EHLO
	smtp2.fre.skanova.net") by vger.kernel.org with ESMTP
	id S263784AbTKKUci (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 15:32:38 -0500
To: linux-kernel@vger.kernel.org
Cc: Vojtech Pavlik <vojtech@suse.cz>,
       Dmitry Torokhov <dtor_core@ameritech.net>,
       Peter Berg Larsen <pebl@math.ku.dk>
Subject: [PATCH] Fix synaptics driver for PowerPro C 3:16
From: Peter Osterlund <petero2@telia.com>
Date: 11 Nov 2003 21:32:18 +0100
Message-ID: <m2llqmy7cd.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

A user reported that the synaptics touchpad driver didn't work on his
PowerPro C 3:16 laptop. Some debugging revealed that the patch below
is necessary to make the driver compatible with his touchpad.

For some reason bit 3 in byte 1 and 4 in the synaptics packets are set
to 1, which fails because the driver follows the documentation which
says that the bit is 0.

Hardware properties: (reported by synclient -h)
     Model Id     = 009d48b1
     Capabilities = 00904713
     Identity     = 00084715

With this patch, the touchpad works as expected. As far as I can see,
this patch can not break anything for other touchpads, so it should be
safe. Does anyone see a problem with this patch?

--- linux/drivers/input/mouse/synaptics.c.old	2003-11-11 20:41:15.000000000 +0100
+++ linux/drivers/input/mouse/synaptics.c	2003-11-11 20:41:29.000000000 +0100
@@ -581,7 +581,7 @@
 
 	switch (psmouse->pktcnt) {
 	case 1:
-		if (newabs ? ((data & 0xC8) != 0x80) : ((data & 0xC0) != 0xC0)) {
+		if (newabs ? ((data & 0xC0) != 0x80) : ((data & 0xC0) != 0xC0)) {
 			printk(KERN_WARNING "Synaptics driver lost sync at 1st byte\n");
 			goto bad_sync;
 		}
@@ -593,7 +593,7 @@
 		}
 		break;
 	case 4:
-		if (newabs ? ((data & 0xC8) != 0xC0) : ((data & 0xC0) != 0x80)) {
+		if (newabs ? ((data & 0xC0) != 0xC0) : ((data & 0xC0) != 0x80)) {
 			printk(KERN_WARNING "Synaptics driver lost sync at 4th byte\n");
 			goto bad_sync;
 		}

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
