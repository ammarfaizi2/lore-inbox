Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261783AbVB1WTa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261783AbVB1WTa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 17:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVB1WT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 17:19:29 -0500
Received: from gprs214-130.eurotel.cz ([160.218.214.130]:41390 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261783AbVB1WTQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 17:19:16 -0500
Date: Mon, 28 Feb 2005 23:19:04 +0100
From: Pavel Machek <pavel@suse.cz>
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Fix few remaining u32 vs. pm_message_t issues
Message-ID: <20050228221904.GI1615@elf.ucw.cz>
References: <20050228201536.GA12861@elf.ucw.cz> <20050228205251.GA22844@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228205251.GA22844@kroah.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > -mm is pretty good in u32 vs. pm_message_t area, there are only few
> > -places missing. Some of them are in usb (and already on their way
> > -through greg), this should fix the rest. Only code change is
> > -pci_choose_state in savagefb. Please apply,
> 
> If you split out the drivers/base/* and the drivers/pci/* ones I'll add
> those to my trees too.

Okay, here they are:

Thanks,
								Pavel

--- clean-mm/drivers/base/power/runtime.c	2005-01-12 11:07:39.000000000 +0100
+++ linux-mm/drivers/base/power/runtime.c	2005-02-28 21:05:15.000000000 +0100
@@ -16,7 +16,7 @@
 	if (!dev->power.power_state)
 		return;
 	if (!resume_device(dev))
-		dev->power.power_state = 0;
+		dev->power.power_state = PMSG_ON;
 }
 
 
--- clean-mm/drivers/base/power/sysfs.c	2004-08-15 19:14:55.000000000 +0200
+++ linux-mm/drivers/base/power/sysfs.c	2005-02-28 21:05:15.000000000 +0100
@@ -31,7 +31,7 @@
 
 static ssize_t state_store(struct device * dev, const char * buf, size_t n)
 {
-	u32 state;
+	pm_message_t state;
 	char * rest;
 	int error = 0;
 
--- clean-mm/drivers/pci/pci.c	2005-02-28 01:13:58.000000000 +0100
+++ linux-mm/drivers/pci/pci.c	2005-02-28 21:05:55.000000000 +0100
@@ -312,13 +312,14 @@
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


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
