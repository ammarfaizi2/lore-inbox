Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbTEJPI1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 11:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264335AbTEJPI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 11:08:26 -0400
Received: from locutus.cmf.nrl.navy.mil ([134.207.10.66]:47509 "EHLO
	locutus.cmf.nrl.navy.mil") by vger.kernel.org with ESMTP
	id S264334AbTEJPIY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 11:08:24 -0400
Message-Id: <200305101518.h4AFIWGi014599@locutus.cmf.nrl.navy.mil>
To: "David S. Miller" <davem@redhat.com>
cc: hch@infradead.org, romieu@fr.zoreil.com, linux-kernel@vger.kernel.org
Subject: Re: [ATM] [UPDATE] unbalanced exit path in Forerunner HE he_init_one() (and an iphase patch too!) 
In-reply-to: Your message of "Sat, 10 May 2003 07:02:34 PDT."
             <20030510.070234.21899554.davem@redhat.com> 
X-url: http://www.nrl.navy.mil/CCS/people/chas/index.html
X-mailer: nmh 1.0
Date: Sat, 10 May 2003 11:18:32 -0400
From: chas williams <chas@locutus.cmf.nrl.navy.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030510.070234.21899554.davem@redhat.com>,"David S. Miller" writes:
>   but its ok for usb drivers?
>Bad ugly code in one area of the kernel is not an excuse
>for it in other areas :-)

perhaps someone should mention this to them?  i believe usb
is under active development.

>test controlling it's execution is very unreadable.  Most
>people's eyes expect to see:
>	if (test)
>		IF_CODE_BLOCK

sorry, i am an old fortran programmer.  i am always trying to put
a continutation punch in field 6 on multiple lines.  (btw, this
doesnt mean i like goto.)

here are the two patches again:

[ATM]: unbalanced exit path in Forerunner HE he_init_one().  thanks to
       Francois Romieu <romieu@fr.zoreil.com>

--- linux-2.5.68/drivers/atm/he.c.002	Fri May  9 15:33:08 2003
+++ linux-2.5.68/drivers/atm/he.c	Sat May 10 11:09:49 2003
@@ -362,43 +362,56 @@
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
+	if (atm_dev)
+		atm_dev_deregister(atm_dev);
+	if (he_dev)
+		kfree(he_dev);
+	pci_disable_device(pci_dev);
+	return err;
 }
 
 static void __devexit
@@ -417,6 +430,7 @@
 	kfree(he_dev);
 
 	pci_set_drvdata(pci_dev, NULL);
+	pci_disable_device(pci_dev);
 }
 
 

[ATM]: [ATM]: Sneak variant of "ioremap() return dereferencing".  thanks to
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
