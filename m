Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268051AbTGTT43 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 15:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268098AbTGTT43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 15:56:29 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:16330 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S268051AbTGTT4U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 15:56:20 -0400
Date: Sun, 20 Jul 2003 22:10:50 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Peter Osterlund <petero2@telia.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Software suspend and RTL 8139too in 2.6.0-test1
Message-ID: <20030720201050.GB292@elf.ucw.cz>
References: <m2wuelqo6c.fsf@telia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2wuelqo6c.fsf@telia.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch is needed to make software suspend work with the 8139too
> driver loaded.

There's more complicated patch at
http://mrohne.home.cern.ch/mrohne/P2120/P2120_Linux_S3.html. Could you
test it, perhaps?
								Pavel

diff -Nru -X dontdiff linux-2.5.64bk11/drivers/net/8139too.c linux-2.5.64bk11-p2120/drivers/net/8139too.c
--- linux-2.5.64bk11/drivers/net/8139too.c	2003-03-07 10:23:38.000000000 +0100
+++ linux-2.5.64bk11-p2120/drivers/net/8139too.c	2003-03-17 13:04:19.000000000 +0100
@@ -109,6 +109,7 @@
 #include <linux/ethtool.h>
 #include <linux/mii.h>
 #include <linux/completion.h>
+#include <linux/suspend.h>
 #include <linux/crc32.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
@@ -565,6 +566,7 @@
 	void *mmio_addr;
 	int drv_flags;
 	struct pci_dev *pci_dev;
+        u32 pci_state[16];
 	struct net_device_stats stats;
 	unsigned char *rx_ring;
 	unsigned int cur_rx;	/* Index into the Rx buffer of next Rx pkt. */
@@ -1595,6 +1597,8 @@
 		timeout = next_tick;
 		do {
 			timeout = interruptible_sleep_on_timeout (&tp->thr_wait, timeout);
+			if (current->flags & PF_FREEZE)
+				refrigerator(PF_IOTHREAD);
 		} while (!signal_pending (current) && (timeout > 0));
 
 		if (signal_pending (current)) {
@@ -2562,6 +2566,9 @@
 	tp->stats.rx_missed_errors += RTL_R32 (RxMissed);
 	RTL_W32 (RxMissed, 0);
 
+	pci_save_state (pdev, tp->pci_state);
+	pci_set_power_state (pdev, 3);
+
 	spin_unlock_irqrestore (&tp->lock, flags);
 	return 0;
 }
@@ -2570,11 +2577,15 @@
 static int rtl8139_resume (struct pci_dev *pdev)
 {
 	struct net_device *dev = pci_get_drvdata (pdev);
+	struct rtl8139_private *tp = dev->priv;
 
 	if (!netif_running (dev))
 		return 0;
-	netif_device_attach (dev);
+	pci_set_power_state (pdev, 0);
+	pci_restore_state (pdev, tp->pci_state);
+	rtl8139_init_ring (dev);
 	rtl8139_hw_start (dev);
+	netif_device_attach (dev);
 	return 0;
 }
 
diff -Nru -X dontdiff linux-2.5.64bk11/drivers/pci/pci-driver.c linux-2.5.64bk11-p2120/drivers/pci/pci-driver.c
--- linux-2.5.64bk11/drivers/pci/pci-driver.c	2003-03-05 04:29:31.000000000 +0100
+++ linux-2.5.64bk11-p2120/drivers/pci/pci-driver.c	2003-03-17 13:04:19.000000000 +0100
@@ -91,11 +91,9 @@
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 
 	if (pci_dev->driver) {
-		/* We may not call PCI drivers resume at
-		   RESUME_POWER_ON because interrupts are not yet
-		   working at that point. Calling resume at
-		   RESUME_RESTORE_STATE seems like solution. */
-		if (level == RESUME_RESTORE_STATE && pci_dev->driver->resume)
+	        if (level == RESUME_POWER_ON && pci_dev->driver->power_on)
+			pci_dev->driver->power_on(pci_dev);
+		else if (level == RESUME_RESTORE_STATE && pci_dev->driver->resume)
 			pci_dev->driver->resume(pci_dev);
 	}
 	return 0;
diff -Nru -X dontdiff linux-2.5.64bk11/drivers/video/radeonfb.c linux-2.5.64bk11-p2120/drivers/video/radeonfb.c
--- linux-2.5.64bk11/drivers/video/radeonfb.c	2003-03-05 04:29:53.000000000 +0100
+++ linux-2.5.64bk11-p2120/drivers/video/radeonfb.c	2003-03-17 13:59:04.000000000 +0100
@@ -402,7 +402,11 @@
 	u32 mdll, mdll2;
 #endif /* CONFIG_PMAC_PBOOK */
 	int asleep;
-	
+
+#ifdef CONFIG_PM
+        u8 pci_state[64];
+#endif /* CONFIG_PM */
+
 	struct radeonfb_info *next;
 };
 
@@ -2925,7 +2929,7 @@
 		switch (pdev->device) {
 			case PCI_DEVICE_ID_ATI_RADEON_LY:
 			case PCI_DEVICE_ID_ATI_RADEON_LZ:
-				rinfo->video_ram = 8192;
+				rinfo->video_ram = 8192*1024;
 				break;
 			default:
 				break;
@@ -3104,16 +3108,65 @@
 			    pci_resource_len(pdev, 2));
 	release_mem_region (rinfo->fb_base_phys,
 			    pci_resource_len(pdev, 0));
+
+	pci_set_drvdata (pdev, NULL);
         
         kfree (rinfo);
 }
 
+#ifdef CONFIG_PM
+static int radeonfb_save_state (struct pci_dev *pdev, u32 state)
+{
+	struct radeonfb_info *rinfo = pci_get_drvdata (pdev);
+
+	printk ("radeonfb_save_state\n");
+	rinfo->asleep++;
+	return 0;
+}
+
+static int radeonfb_suspend (struct pci_dev *pdev, u32 state)
+{
+	struct radeonfb_info *rinfo = pci_get_drvdata (pdev);
+
+	printk ("radeonfb_suspend\n");
+	pci_save_state (pdev, (u32 *)rinfo->pci_state);
+	mdelay (10);
+	rinfo->asleep++;
+	return 0;
+}
+
+static int radeonfb_power_on (struct pci_dev *pdev)
+{
+	struct radeonfb_info *rinfo = pci_get_drvdata (pdev);
+
+	printk ("radeonfb_power_on\n");
+	pci_restore_state (pdev, (u32 *)rinfo->pci_state);
+	mdelay (10);
+	rinfo->asleep--;
+	return 0;
+}
+
+static int radeonfb_resume (struct pci_dev *pdev)
+{
+	struct radeonfb_info *rinfo = pci_get_drvdata (pdev);
+
+	printk ("radeonfb_resume\n");
+	rinfo->asleep--;
+	return 0;
+}
+#endif /* CONFIG_PM */
 
 static struct pci_driver radeonfb_driver = {
 	name:		"radeonfb",
 	id_table:	radeonfb_pci_table,
 	probe:		radeonfb_pci_register,
 	remove:		__devexit_p(radeonfb_pci_unregister),
+#ifdef CONFIG_PM
+	.save_state	= radeonfb_save_state,
+	.suspend	= radeonfb_suspend,
+	.power_on	= radeonfb_power_on,
+	.resume		= radeonfb_resume,
+#endif /* CONFIG_PM */
 };
 
 
diff -Nru -X dontdiff linux-2.5.64bk11/include/linux/pci.h linux-2.5.64bk11-p2120/include/linux/pci.h
--- linux-2.5.64bk11/include/linux/pci.h	2003-03-17 11:48:10.000000000 +0100
+++ linux-2.5.64bk11-p2120/include/linux/pci.h	2003-03-17 13:04:19.000000000 +0100
@@ -500,6 +500,7 @@
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
 	int  (*save_state) (struct pci_dev *dev, u32 state);    /* Save Device Context */
 	int  (*suspend) (struct pci_dev *dev, u32 state);	/* Device suspended */
+	int  (*power_on) (struct pci_dev *dev);	                /* Device power on */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
