Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262692AbVAVSLt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262692AbVAVSLt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 13:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262614AbVAVSLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 13:11:31 -0500
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:34260 "EHLO
	mail-in-08.arcor-online.net") by vger.kernel.org with ESMTP
	id S262624AbVAVSJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 13:09:13 -0500
Date: Sat, 22 Jan 2005 19:09:18 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: sailer@ife.ee.ethz.ch
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] oss/es1371.c: Don't print joystick address before it's set.
Message-ID: <Pine.LNX.4.58.0501221801040.3801@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel-Version: 2.6.10-ac9

The Old code printed the joystick address before it was set, possibly 
before the field was initialized.

Old output was: (from memory)
es1371: found es1371 rev 2 at io 0xec00 irq 5 joystick 0x0

New output is:
es1371: found es1371 rev 2 at io 0xec00 irq 5
es1371: es1371 joystick at 0x218

Signed-off-by: Bodo Eggert <7eggert@gmx.de>

--- sound/oss/es1371.c.ori	2005-01-22 17:38:10.180308592 +0100
+++ sound/oss/es1371.c	2005-01-22 18:11:25.919910056 +0100
@@ -105,6 +105,8 @@
  *                       Fix SETTRIGGER non OSS API conformity
  *    14.07.2001   0.31  Add list of laptops needing amplifier control
  *    03.01.2003   0.32  open_mode fixes from Georg Acher <acher@in.tum.de>
+ *    22.01.2004   0.33  fix output of joystick address
+ *                       by Bodo Eggert <7eggert@gmx.de>
  */
 
 /*****************************************************************************/
@@ -2849,8 +2851,8 @@ static int __devinit es1371_probe(struct
 		printk(KERN_ERR PFX "irq %u in use\n", s->irq);
 		goto err_irq;
 	}
-	printk(KERN_INFO PFX "found es1371 rev %d at io %#lx irq %u joystick %#x\n",
-	       s->rev, s->io, s->irq, s->gameport.io);
+	printk(KERN_INFO PFX "found es1371 rev %d at io %#lx irq %u\n",
+	       s->rev, s->io, s->irq);
 	/* register devices */
 	if ((res=(s->dev_audio = register_sound_dsp(&es1371_audio_fops,-1)))<0)
 		goto err_dev1;
@@ -2886,6 +2888,8 @@ static int __devinit es1371_probe(struct
 		if (request_region(i, JOY_EXTENT, "es1371")) {
 			s->ctrl |= CTRL_JYSTK_EN | (((i >> 3) & CTRL_JOY_MASK) << CTRL_JOY_SHIFT);
 			s->gameport.io = i;
+			printk(KERN_INFO PFX "es1371 joystick at %#x\n",
+				s->gameport.io);
 			break;
 		}
 	}
