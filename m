Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266271AbSL1Plr>; Sat, 28 Dec 2002 10:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266274AbSL1Plr>; Sat, 28 Dec 2002 10:41:47 -0500
Received: from uranus.lan-ks.de ([194.45.71.1]:61708 "EHLO uranus.lan-ks.de")
	by vger.kernel.org with ESMTP id <S266271AbSL1Plo>;
	Sat, 28 Dec 2002 10:41:44 -0500
X-MDaemon-Deliver-To: <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: module locking for pcnet_cs
X-Face: ""xJff<P[R~C67]V?J|X^Dr`YigXK|;1wX<rt^>%{>hr-{:QXl"Xk2O@@(+F]e{"%EYQiW@mUuvEsL>=mx96j12qW[%m;|:B^n{J8k?Mz[K1_+H;$v,nYx^1o_=4M,L+]FIU~[[`-w~~xsy-BX,?tAF_.8u&0y*@aCv;a}Y'{w@#*@iwAl?oZpvvv
X-Message-Flag: This space is intentionally left blank
X-Noad: Please don't send me ad's by mail.  I'm bored by this type of mail.
X-Note: sending SPAM is a violation of both german and US law and will
	at least trigger a complaint at your provider's postmaster.
X-GPG: 1024D/77D4FC9B 2000-08-12 Jochen Hein (28 Jun 1967, Kassel, Germany) 
     Key fingerprint = F5C5 1C20 1DFC DEC3 3107  54A4 2332 ADFC 77D4 FC9B
X-BND-Spook: RAF Taliban BND BKA Bombe Waffen Terror AES GPG
X-No-Archive: yes
From: Jochen Hein <jochen@jochen.org>
Date: Sat, 28 Dec 2002 16:16:39 +0100
Message-ID: <8765texjfs.fsf@jupiter.jochen.org>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.2
 (i386-debian-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I got the "unsafe" module init message von pcnet_cs and decided to
evaluate it.  When I remove the MOD_INC_USE_COUNT and
MOD_DEC_USE_COUNT[1] the message vanishes.  Bad news is that removing the
module with still active eth0 loops rmmod (removing after "ifconfig
eth0 down" works as expected).  

Use count in lsmod is zero, so I think it is not that correct.
Playing[2] with try_module_get() doesn't help me either.

Jochen

[1] This is the probably broken patch:

--- linux-2.5.53/drivers/net/pcmcia/pcnet_cs.c.jh	2002-12-28 10:15:45.000000000 +0100
+++ linux-2.5.53/drivers/net/pcmcia/pcnet_cs.c	2002-12-28 10:16:15.000000000 +0100
@@ -1030,7 +1030,6 @@
 	return -ENODEV;
 
     link->open++;
-    MOD_INC_USE_COUNT;
 
     set_misc_reg(dev);
     request_irq(dev->irq, ei_irq_wrapper, SA_SHIRQ, dev_info, dev);
@@ -1064,8 +1063,6 @@
     if (link->state & DEV_STALE_CONFIG)
 	mod_timer(&link->release, jiffies + HZ/20);
 
-    MOD_DEC_USE_COUNT;
-
     return 0;
 } /* pcnet_close */
 

[2] Yet another broken patch:

--- linux-2.5.53/drivers/net/pcmcia/pcnet_cs.c.jh	2002-12-28 10:15:45.000000000 +0100
+++ linux-2.5.53/drivers/net/pcmcia/pcnet_cs.c	2002-12-28 11:04:08.000000000 +0100
@@ -1029,8 +1029,8 @@
     if (!DEV_OK(link))
 	return -ENODEV;
 
+    try_module_get(dev->owner);
     link->open++;
-    MOD_INC_USE_COUNT;
 
     set_misc_reg(dev);
     request_irq(dev->irq, ei_irq_wrapper, SA_SHIRQ, dev_info, dev);
@@ -1064,7 +1064,7 @@
     if (link->state & DEV_STALE_CONFIG)
 	mod_timer(&link->release, jiffies + HZ/20);
 
-    MOD_DEC_USE_COUNT;
+    module_put(dev->owner);
 
     return 0;
 } /* pcnet_close */

-- 
#include <~/.signature>: permission denied
