Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262868AbVAQUQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262868AbVAQUQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 15:16:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262870AbVAQUQw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 15:16:52 -0500
Received: from gprs215-94.eurotel.cz ([160.218.215.94]:59529 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262868AbVAQUQh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 15:16:37 -0500
Date: Mon, 17 Jan 2005 21:16:25 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: driver model: pass pm_message_t down to pci drivers
Message-ID: <20050117201625.GA1779@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This passes pm_message_t down to PCI drivers. Ugly translation code
can be removed and this will allow PCI devices to do right thing
during swsusp snapshot -- like not unneccessarily blanking display.

Only obscure /sysfs code passes anything but 3 to to
pci_device_suspend, anyway, so this is pretty close to nop ;-).

Please apply,
								Pavel

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean-cvs/drivers/pci/pci-driver.c	2005-01-16 22:27:25.000000000 +0100
+++ linux-cvs/drivers/pci/pci-driver.c	2005-01-17 00:19:56.000000000 +0100
@@ -288,23 +288,10 @@
 {
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * drv = pci_dev->driver;
-	u32 dev_state;
 	int i = 0;
 
-	/* Translate PM_SUSPEND_xx states to PCI device states */
-	static u32 state_conversion[] = {
-		[PM_SUSPEND_ON] = 0,
-		[PM_SUSPEND_STANDBY] = 1,
-		[PM_SUSPEND_MEM] = 3,
-		[PM_SUSPEND_DISK] = 3,
-	};
-
-	if (state >= sizeof(state_conversion) / sizeof(state_conversion[1]))
-		return -EINVAL;
-
-	dev_state = state_conversion[state];
 	if (drv && drv->suspend)
-		i = drv->suspend(pci_dev, dev_state);
+		i = drv->suspend(pci_dev, state);
 	else
 		pci_save_state(pci_dev);
 	return i;
--- clean-cvs/include/linux/pci.h	2005-01-16 22:29:13.000000000 +0100
+++ linux-cvs/include/linux/pci.h	2005-01-16 23:58:54.000000000 +0100
@@ -667,7 +667,7 @@
 	const struct pci_device_id *id_table;	/* must be non-NULL for probe to be called */
 	int  (*probe)  (struct pci_dev *dev, const struct pci_device_id *id);	/* New device inserted */
 	void (*remove) (struct pci_dev *dev);	/* Device removed (NULL if not a hot-plug capable driver) */
-	int  (*suspend) (struct pci_dev *dev, u32 state);	/* Device suspended */
+	int  (*suspend) (struct pci_dev *dev, pm_message_t state);	/* Device suspended */
 	int  (*resume) (struct pci_dev *dev);	                /* Device woken up */
 	int  (*enable_wake) (struct pci_dev *dev, u32 state, int enable);   /* Enable wake event */
 
@@ -823,7 +823,7 @@
 int pci_save_state(struct pci_dev *dev);
 int pci_restore_state(struct pci_dev *dev);
 int pci_set_power_state(struct pci_dev *dev, pci_power_t state);
-pci_power_t pci_choose_state(struct pci_dev *dev, u32 state);
+pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state);
 int pci_enable_wake(struct pci_dev *dev, pci_power_t state, int enable);
 
 /* Helper functions for low-level code (drivers/pci/setup-[bus,res].c) */

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

