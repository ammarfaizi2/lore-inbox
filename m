Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263620AbTEJAaQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 20:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbTEJAaQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 20:30:16 -0400
Received: from zeus.kernel.org ([204.152.189.113]:34205 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S263620AbTEJAaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 20:30:11 -0400
Message-Id: <200305092339.h49NcYGi011242@locutus.cmf.nrl.navy.mil>
To: Francois Romieu <romieu@fr.zoreil.com>
cc: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [ATM] [UPDATE] unbalanced exit path in Forerunner HE he_init_one() (and an iphase patch too!) 
In-reply-to: Your message of "Sat, 10 May 2003 00:02:22 +0200."
             <20030510000222.A10796@electric-eye.fr.zoreil.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Fri, 09 May 2003 19:38:34 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>- pci_enable_device() balanced on error path in he_init_one();
>- return of atm_dev_register() isn't lost any more if he_dev allocation fails
>  in he_init_one();
>- pci_disable_device() added to he_disable_one();

i hope you dont mind, but i really dislike the goto.  one is plenty. 
attached is a cleanup for the iphase (i made a small addition -- i believe
the MEMDUMP_XXXXXXREG cases are also guilty of dereferencing).

[ATM]: unbalanced exit path in Forerunner HE he_init_one().  thanks to 
       Francois Romieu <romieu@fr.zoreil.com>

--- linux-2.5.68/drivers/atm/he.c.002	Fri May  9 15:33:08 2003
+++ linux-2.5.68/drivers/atm/he.c	Fri May  9 19:00:02 2003
@@ -362,43 +362,54 @@
 static int __devinit
 he_init_one(struct pci_dev *pci_dev, const struct pci_device_id *pci_ent)
 {
-	struct atm_dev *atm_dev;
-	struct he_dev *he_dev;
+	struct atm_dev *atm_dev = NULL;
+	struct he_dev *he_dev = NULL;
+	int err = 0;
 
 	printk(KERN_INFO "he: %s\n", version);
 
 	if (pci_enable_device(pci_dev)) return -EIO;
-	if (pci_set_dma_mask(pci_dev, HE_DMA_MASK) != 0)
-	{
+	if (pci_set_dma_mask(pci_dev, HE_DMA_MASK) != 0) {
 		printk(KERN_WARNING "he: no suitable dma available\n");
-		return -EIO;
+		err = -EIO;
+		goto init_one_failure;
 	}
 
 	atm_dev = atm_dev_register(DEV_LABEL, &he_ops, -1, 0);
-	if (!atm_dev) return -ENODEV;
+	if (!atm_dev) {
+		err = -ENODEV;
+		goto init_one_failure;
+	}
 	pci_set_drvdata(pci_dev, atm_dev);
 
 	he_dev = (struct he_dev *) kmalloc(sizeof(struct he_dev),
 							GFP_KERNEL);
-	if (!he_dev) return -ENOMEM;
+	if (!he_dev) {
+		err = -ENOMEM;
+		goto init_one_failure;
+	}
 	memset(he_dev, 0, sizeof(struct he_dev));
 
 	he_dev->pci_dev = pci_dev;
 	he_dev->atm_dev = atm_dev;
 	he_dev->atm_dev->dev_data = he_dev;
 	HE_DEV(atm_dev) = he_dev;
-	he_dev->number = atm_dev->number;	/* was devs */
+	he_dev->number = atm_dev->number;
 	if (he_start(atm_dev)) {
-		atm_dev_deregister(atm_dev);
 		he_stop(he_dev);
-		kfree(he_dev);
-		return -ENODEV;
+		err = -ENODEV;
+		goto init_one_failure;
 	}
 	he_dev->next = NULL;
 	if (he_devs) he_dev->next = he_devs;
 	he_devs = he_dev;
-
 	return 0;
+
+init_one_failure:
+	if (atm_dev) atm_dev_deregister(atm_dev);
+	if (he_dev) kfree(he_dev);
+	pci_disable_device(pci_dev);
+	return err;
 }
 
 static void __devexit
@@ -417,6 +428,7 @@
 	kfree(he_dev);
 
 	pci_set_drvdata(pci_dev, NULL);
+	pci_disable_device(pci_dev);
 }
 
 

[ATM]: Sneak variant of "ioremap() return dereferencing".  thanks to
       Francois Romieu <romieu@fr.zoreil.com>


--- linux-2.5.68/drivers/atm/iphase.c.002	Fri May  9 19:01:27 2003
+++ linux-2.5.68/drivers/atm/iphase.c	Fri May  9 19:35:24 2003
@@ -2774,7 +2774,7 @@
 	     if (!capable(CAP_NET_ADMIN)) return -EPERM;
              tmps = (u16 *)ia_cmds.buf;
              for(i=0; i<0x80; i+=2, tmps++)
-                if(put_user(*(u16*)(iadev->seg_reg+i), tmps)) return -EFAULT;
+                if(put_user((u16)(readl(iadev->seg_reg+i) & 0xffff), tmps)) return -EFAULT;
              ia_cmds.status = 0;
              ia_cmds.len = 0x80;
              break;
@@ -2782,7 +2782,7 @@
 	     if (!capable(CAP_NET_ADMIN)) return -EPERM;
              tmps = (u16 *)ia_cmds.buf;
              for(i=0; i<0x80; i+=2, tmps++)
-                if(put_user(*(u16*)(iadev->reass_reg+i), tmps)) return -EFAULT;
+                if(put_user((u16)(readl(iadev->reass_reg+i) & 0xffff), tmps)) return -EFAULT;
              ia_cmds.status = 0;
              ia_cmds.len = 0x80;
              break;
@@ -2799,10 +2799,10 @@
 	     rfL = &regs_local->rfredn;
              /* Copy real rfred registers into the local copy */
  	     for (i=0; i<(sizeof (rfredn_t))/4; i++)
-                ((u_int *)rfL)[i] = ((u_int *)iadev->reass_reg)[i] & 0xffff;
+                ((u_int *)rfL)[i] = readl(iadev->reass_reg + i) & 0xffff;
              	/* Copy real ffred registers into the local copy */
 	     for (i=0; i<(sizeof (ffredn_t))/4; i++)
-                ((u_int *)ffL)[i] = ((u_int *)iadev->seg_reg)[i] & 0xffff;
+                ((u_int *)ffL)[i] = readl(iadev->seg_reg + i) & 0xffff;
 
              if (copy_to_user(ia_cmds.buf, regs_local,sizeof(ia_regs_t))) {
                 kfree(regs_local);
