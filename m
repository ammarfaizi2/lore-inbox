Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268391AbTGTVRY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 17:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268396AbTGTVRX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 17:17:23 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:11476 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S268391AbTGTVRT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 17:17:19 -0400
Date: Sun, 20 Jul 2003 23:30:14 +0200
From: Pavel Machek <pavel@ucw.cz>
To: ole.rohne@cern.ch, kernel list <linux-kernel@vger.kernel.org>
Subject: 8390too, radeonfb support
Message-ID: <20030720213014.GA810@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Ole put some patches on his webpage. I ported them to
2.6.0-test1. Could someone who has hardware test them/push them to
linus?
							Pavel

--- /usr/src/tmp/linux/arch/i386/kernel/acpi/wakeup.S	2003-03-06 23:25:13.000000000 +0100
+++ /usr/src/linux/arch/i386/kernel/acpi/wakeup.S	2003-07-20 23:18:10.000000000 +0200
@@ -43,6 +43,11 @@
 
 	testl	$1, video_flags - wakeup_code
 	jz	1f
+	/* It is miracle that this works:
+	   * PCI may or may not be initialized at this point
+	   * I'm told we should pass device ID to video bios
+	   However it works on some real machines...
+	 */
 	lcall   $0xc000,$3
 	movw	%cs, %ax
 	movw	%ax, %ds					# Bios might have played with that
--- /usr/src/tmp/linux/drivers/net/8139too.c	2003-07-11 21:38:37.000000000 +0200
+++ /usr/src/linux/drivers/net/8139too.c	2003-07-20 22:42:26.000000000 +0200
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
@@ -1597,6 +1599,8 @@
 		timeout = next_tick;
 		do {
 			timeout = interruptible_sleep_on_timeout (&tp->thr_wait, timeout);
+			if (current->flags & PF_FREEZE)
+				refrigerator(PF_IOTHREAD);
 		} while (!signal_pending (current) && (timeout > 0));
 
 		if (signal_pending (current)) {
@@ -2566,6 +2570,9 @@
 	tp->stats.rx_missed_errors += RTL_R32 (RxMissed);
 	RTL_W32 (RxMissed, 0);
 
+	pci_save_state (pdev, tp->pci_state);
+	pci_set_power_state (pdev, 3);
+
 	spin_unlock_irqrestore (&tp->lock, flags);
 	return 0;
 }
@@ -2574,11 +2581,15 @@
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
 
--- /usr/src/tmp/linux/drivers/pci/pci-driver.c	2003-07-06 20:07:38.000000000 +0200
+++ /usr/src/linux/drivers/pci/pci-driver.c	2003-07-20 22:42:26.000000000 +0200
@@ -179,11 +179,9 @@
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
--- /usr/src/tmp/linux/drivers/video/radeonfb.c	2003-06-15 22:43:26.000000000 +0200
+++ /usr/src/linux/drivers/video/radeonfb.c	2003-07-20 22:55:13.000000000 +0200
@@ -405,7 +405,11 @@
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
 
@@ -3113,16 +3117,64 @@
 			    pci_resource_len(pdev, 2));
 	release_mem_region (rinfo->fb_base_phys,
 			    pci_resource_len(pdev, 0));
-        
+	pci_set_drvdata (pdev, NULL);
+
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
 	.name		= "radeonfb",
 	.id_table	= radeonfb_pci_table,
 	.probe		= radeonfb_pci_register,
 	.remove		= __devexit_p(radeonfb_pci_unregister),
+#ifdef CONFIG_PM
+	.save_state	= radeonfb_save_state,
+	.suspend	= radeonfb_suspend,
+	.power_on	= radeonfb_power_on,
+	.resume		= radeonfb_resume,
+#endif /* CONFIG_PM */
 };
 
 
--- /usr/src/tmp/linux/include/linux/pci.h	2003-07-11 21:38:47.000000000 +0200
+++ /usr/src/linux/include/linux/pci.h	2003-07-20 22:42:26.000000000 +0200
@@ -512,6 +512,7 @@
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
 	int  (*save_state) (struct pci_dev *dev, u32 state);    /* Save Device Context */
 	int  (*suspend) (struct pci_dev *dev, u32 state);	/* Device suspended */
+	int  (*power_on) (struct pci_dev *dev);	                /* Device power on */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
