Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311936AbSD2NvX>; Mon, 29 Apr 2002 09:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312253AbSD2NvW>; Mon, 29 Apr 2002 09:51:22 -0400
Received: from swazi.realnet.co.sz ([196.28.7.2]:31880 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S311936AbSD2NvT>; Mon, 29 Apr 2002 09:51:19 -0400
Date: Mon, 29 Apr 2002 15:31:26 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] opl3sa2 resource free on probe failure
Message-ID: <Pine.LNX.4.44.0204291528570.18739-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is dependent on the ad1848 and mpu401 patches i sent earlier, 
which are in 2.4-ac-current and 2.5-dj-current.

Please apply,
	Zwane Mwaikambo

--- linux-2.4.19-pre-ac/drivers/sound/opl3sa2.c.orig	Mon Apr 29 15:14:17 2002
+++ linux-2.4.19-pre-ac/drivers/sound/opl3sa2.c	Mon Apr 29 15:28:52 2002
@@ -57,6 +57,8 @@
  *                         (Jan 7, 2001)
  * Zwane Mwaikambo	   Added PM support. (Dec 4 2001)
  * Zwane Mwaikambo	   Code, data structure cleanups. (Feb 15 2002)
+ * Zwane Mwaikambo	   Free resources during auxiliary device probe
+ * 			   failures (Apr 29 2002)
  *
  */
 
@@ -142,7 +144,7 @@
 	unsigned int	card;
 	int		chipset;	/* What's my version(s)? */
 	char		*chipset_name;
-
+	
 	/* mixer data */
 	int		mixer;
 	unsigned int	volume_l;
@@ -236,7 +238,6 @@
 	*data = inb(port + 1);
 }
 
-
 /*
  * All of the mixer functions...
  */
@@ -584,9 +585,9 @@
 }
 
 
-static inline void __init attach_opl3sa2_mpu(struct address_info* hw_config)
+static inline int __init attach_opl3sa2_mpu(struct address_info* hw_config)
 {
-	attach_mpu401(hw_config, THIS_MODULE);
+	return attach_mpu401(hw_config, THIS_MODULE);
 }
 
 
@@ -641,7 +642,7 @@
 	if(!request_region(hw_config->io_base, 2, OPL3SA2_MODULE_NAME)) {
 		printk(KERN_ERR PFX "Control I/O port %#x not free\n",
 		       hw_config->io_base);
-		return 0;
+		goto out_nodev;
 	}
 
 	/*
@@ -654,7 +655,7 @@
 	if(tmp != misc) {
 		printk(KERN_ERR PFX "Control I/O port %#x is not a YMF7xx chipset!\n",
 		       hw_config->io_base);
-		return 0;
+		goto out_region;
 	}
 
 	/*
@@ -667,7 +668,7 @@
 		printk(KERN_ERR
 		       PFX "Control I/O port %#x is not a YMF7xx chipset!\n",
 		       hw_config->io_base);
-		return 0;
+		goto out_region;
 	}
 	opl3sa2_write(hw_config->io_base, OPL3SA2_MIC, tmp);
 
@@ -714,9 +715,13 @@
 	if(opl3sa2_state[card].chipset != CHIPSET_UNKNOWN) {
 		/* Generate a pretty name */
 		opl3sa2_state[card].chipset_name = (char *)CHIPSET_TABLE[opl3sa2_state[card].chipset];
-		return 1;
+		return 0;
 	}
-	return 0;
+
+out_region:
+	release_region(hw_config->io_base, 2);
+out_nodev:
+	return -ENODEV;
 }
 
 
@@ -914,7 +919,7 @@
 
 #ifdef CONFIG_PM
 /* Power Management support functions */
-static int opl3sa2_suspend(struct pm_dev *pdev, unsigned char pm_mode)
+static int opl3sa2_suspend(struct pm_dev *pdev, unsigned int pm_mode)
 {
 	unsigned long flags;
 	opl3sa2_state_t *p;
@@ -975,11 +980,9 @@
 
 static int opl3sa2_pm_callback(struct pm_dev *pdev, pm_request_t rqst, void *data)
 {
-	unsigned char mode = (unsigned  char)data;
-
 	switch (rqst) {
 		case PM_SUSPEND:
-			return opl3sa2_suspend(pdev, mode);
+			return opl3sa2_suspend(pdev, (unsigned int)data);
 
 		case PM_RESUME:
 			return opl3sa2_resume(pdev);
@@ -995,8 +998,7 @@
  */
 static int __init init_opl3sa2(void)
 {
-        int card;
-	int max;
+        int card, max;
 
 	/* Sanitize isapnp and multiple settings */
 	isapnp = isapnp != 0 ? 1 : 0;
@@ -1060,15 +1062,19 @@
 			opl3sa2_clear_slots(&opl3sa2_state[card].cfg_mss);
 			opl3sa2_clear_slots(&opl3sa2_state[card].cfg_mpu);
 		}
+		
+		if (probe_opl3sa2(&opl3sa2_state[card].cfg, card))
+			return -ENODEV;
 
-		if(!probe_opl3sa2(&opl3sa2_state[card].cfg, card) ||
-		   !probe_opl3sa2_mss(&opl3sa2_state[card].cfg_mss)) {
+		if(!probe_opl3sa2_mss(&opl3sa2_state[card].cfg_mss)) {
 			/*
 			 * If one or more cards are already registered, don't
 			 * return an error but print a warning.  Note, this
 			 * should never really happen unless the hardware or
 			 * ISA PnP screwed up.
 			 */
+			release_region(opl3sa2_state[card].cfg.io_base, 2);
+
 			if(opl3sa2_cards_num) {
 				printk(KERN_WARNING
 				       PFX "There was a problem probing one "
@@ -1114,10 +1120,13 @@
 			opl3sa2_set_loopback(&opl3sa2_state[card].cfg, loopback);
 		}
 		
-		/* Attach MPU if we've been asked to do so */
+		/* Attach MPU if we've been asked to do so, failure isn't fatal */
 		if(opl3sa2_state[card].cfg_mpu.io_base != -1) {
 			if(probe_opl3sa2_mpu(&opl3sa2_state[card].cfg_mpu)) {
-				attach_opl3sa2_mpu(&opl3sa2_state[card].cfg_mpu);
+				if (attach_opl3sa2_mpu(&opl3sa2_state[card].cfg_mpu)) {
+					printk(KERN_ERR PFX "failed to attach MPU401\n");
+					opl3sa2_state[card].cfg_mpu.slots[1] = -1;
+				}
 			}
 		}
 	}

-- 
http://function.linuxpower.ca
		

