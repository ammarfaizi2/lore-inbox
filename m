Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263273AbVCKNL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263273AbVCKNL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 08:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbVCKNL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 08:11:27 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:183 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263303AbVCKNK6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 08:10:58 -0500
Date: Fri, 11 Mar 2005 14:10:40 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, kernel list <linux-kernel@vger.kernel.org>
Subject: Re: fix-u32-vs-pm_message_t-in-usb
Message-ID: <20050311131040.GD1379@elf.ucw.cz>
References: <20050310223353.47601d54.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310223353.47601d54.akpm@osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> This patch has been spitting warnings:
> 
> drivers/usb/host/uhci-hcd.c:838: warning: initialization from incompatible pointer type
> drivers/usb/host/ohci-pci.c:191: warning: initialization from incompatible pointer type
> 
> Because hc_driver.suspend() takes a u32 as its second arg.  Changing that
> to pci_power_t causes build failures and including pci.h in usb.h seems
> wrong.
> 
> Wanna fix it sometime?

While fixing usb, I stomped on a few more fixes. Print error when some
device fails to power down, and 2 is no longer valid state to pass in
pm_message_t. Please apply,

									Pavel

--- clean-mm/drivers/base/power/suspend.c	2005-01-12 11:07:39.000000000 +0100
+++ linux-mm/drivers/base/power/suspend.c	2005-03-11 13:46:41.000000000 +0100
@@ -134,6 +134,8 @@
  Done:
 	return error;
  Error:
+	printk(KERN_ERR "Could not power down device %s: "
+		"error %d\n", kobject_name(&dev->kobj), error);
 	dpm_power_up();
 	goto Done;
 }
Only in linux-mm/drivers/char: consolemap_deftbl.c
--- clean-mm/drivers/ide/ide-disk.c	2005-03-11 11:25:34.000000000 +0100
+++ linux-mm/drivers/ide/ide-disk.c	2005-03-11 13:44:18.000000000 +0100
@@ -1096,7 +1096,7 @@
 	}
 
 	printk("Shutdown: %s\n", drive->name);
-	dev->bus->suspend(dev, PM_SUSPEND_STANDBY);
+	dev->bus->suspend(dev, PMSG_SUSPEND);
 }
 
 /*
--- clean-mm/drivers/pci/pci.c	2005-03-11 11:25:36.000000000 +0100
+++ linux-mm/drivers/pci/pci.c	2005-03-11 13:55:50.000000000 +0100
@@ -312,22 +312,24 @@
 /**
  * pci_choose_state - Choose the power state of a PCI device
  * @dev: PCI device to be suspended
- * @state: target sleep state for the whole system
+ * @state: target sleep state for the whole system. This is the value
+ *	that is passed to suspend() function.
  *
  * Returns PCI power state suitable for given device and given system
  * message.
  */
 
-pci_power_t pci_choose_state(struct pci_dev *dev, u32 state)
+pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
 {
 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
 		return PCI_D0;
 
 	switch (state) {
-	case 0:	return PCI_D0;
-	case 2: return PCI_D2;
+	case 0: return PCI_D0;
 	case 3: return PCI_D3hot;
-	default: BUG();
+	default: 
+		printk("They asked me for state %d\n", state);
+		BUG();
 	}
 	return PCI_D0;
 }

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
