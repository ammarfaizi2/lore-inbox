Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268598AbTBZPlU>; Wed, 26 Feb 2003 10:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268666AbTBZPlU>; Wed, 26 Feb 2003 10:41:20 -0500
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:10895 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id <S268598AbTBZPlT>; Wed, 26 Feb 2003 10:41:19 -0500
Date: Wed, 26 Feb 2003 10:51:21 -0500
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Message-Id: <200302261551.h1QFpLYa004976@locutus.cmf.nrl.navy.mil>
To: jgarzik@pobox.com
Subject: [PATCH][ATM] suni_init shouldnt be __init and remove mod inc/dec
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

exporting a symbol declared as __init is bogus.  additonally, suni
doesnt need to modify its ref counts, to quote:

Q: My code use "MOD_INC_USE_COUNT".  Do I still need to adjust my
   module count when someone calls one of my functions?
A: No ...
           ... It could be another module using one of your
   EXPORT_SYMBOL'ed functions, in which case you cannot be removed
   since they would have to be removed first. ...

this is certainly the case for suni which is used by the various
atm drivers.

Index: linux/drivers/atm/suni.c
===================================================================
RCS file: /home/chas/CVSROOT/linux/drivers/atm/suni.c,v
retrieving revision 1.1
retrieving revision 1.3
diff -u -r1.1 -r1.3
--- linux/drivers/atm/suni.c	20 Feb 2003 13:45:03 -0000	1.1
+++ linux/drivers/atm/suni.c	26 Feb 2003 15:43:30 -0000	1.3
@@ -233,8 +233,6 @@
 	if (!(PRIV(dev) = kmalloc(sizeof(struct suni_priv),GFP_KERNEL)))
 		return -ENOMEM;
 
-	MOD_INC_USE_COUNT;
-
 	PRIV(dev)->dev = dev;
 	spin_lock_irqsave(&sunis_lock,flags);
 	first = !sunis;
@@ -280,7 +278,6 @@
 	spin_unlock_irqrestore(&sunis_lock,flags);
 	kfree(PRIV(dev));
 
-	MOD_DEC_USE_COUNT;
 	return 0;
 }
 
@@ -293,7 +290,7 @@
 };
 
 
-int __init suni_init(struct atm_dev *dev)
+int suni_init(struct atm_dev *dev)
 {
 	unsigned char mri;
 
