Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbVBMQDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbVBMQDa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 11:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261284AbVBMQDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 11:03:30 -0500
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:2029 "EHLO
	mail-in-05.arcor-online.net") by vger.kernel.org with ESMTP
	id S261283AbVBMQCz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 11:02:55 -0500
Date: Sun, 13 Feb 2005 17:03:46 +0100 (CET)
From: Bodo Eggert <7eggert@gmx.de>
To: sailer@ife.ee.ethz.ch
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [RESUBMIT] [PATCH] [BUGFIX] sound/oss/es1371.c: Don't print joystick
 address before it's set.
In-Reply-To: <Pine.LNX.4.58.0501221801040.3801@be1.lrz>
Message-ID: <Pine.LNX.4.58.0502131634410.3469@be1.lrz>
References: <Pine.LNX.4.58.0501221801040.3801@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Resubmit because of no feedback nor inclusion in the latest changelogs.
I'm not sure wether this patch qualifies for the patch monkey, so I still
omit it.

Changed to apply with -p1 instead of -p0 after reading a unrelated hint on 
LKML (maybe this should be mentioned in the SubmittingPatches?) and added 
more explanation why I feel this patch is needed.



This patch was created against Version: 2.6.10-ac9

The old code printed the joystick address before it was set, possibly 
before the field was initialized.

This caused me to search for the reason why the f...ine joystic port
didn't work (it did, but it was hidden) instead of simply loading the
module for the attached device.

Old output was: (from memory)
es1371: found es1371 rev 2 at io 0xec00 irq 5 joystick 0x0

New output is:
es1371: found es1371 rev 2 at io 0xec00 irq 5
es1371: es1371 joystick at 0x218

Signed-off-by: Bodo Eggert <7eggert@gmx.de>

--- sound/oss/es1371.c.ori	2005-01-22 17:38:10.000000000 +0100
+++ sound/oss/es1371.c	2005-02-13 16:41:19.196704432 +0100
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
-- 
A bone to the dog is not charity. Charity is the bone shared with the dog, when you are
just as hungry as the dog.	-- Jack London
