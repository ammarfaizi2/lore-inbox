Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261973AbUKPNGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261973AbUKPNGt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 08:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261967AbUKPNGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 08:06:48 -0500
Received: from gprs214-224.eurotel.cz ([160.218.214.224]:25728 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261973AbUKPNFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 08:05:01 -0500
Date: Tue, 16 Nov 2004 14:04:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, Greg KH <greg@kroah.com>
Subject: Cleanup PCI power states
Message-ID: <20041116130445.GA10085@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This is step 0 before adding type-safety to PCI layer... It introduces
constants and uses them to clean driver up. I'd like this to go in
now, so that I can convert drivers during 2.6.10... Please apply,

								Pavel

[amd8111e.c piece below shows exactly why this is needed; feel free to
apply it or not...]

--- clean/include/linux/pci.h	2004-10-01 00:30:30.000000000 +0200
+++ linux/include/linux/pci.h	2004-11-14 23:36:46.000000000 +0100
@@ -480,6 +480,14 @@
 #define DEVICE_COUNT_COMPATIBLE	4
 #define DEVICE_COUNT_RESOURCE	12
 
+typedef int __bitwise pci_power_t;
+
+#define PCI_D0	((pci_power_t __force) 0)
+#define PCI_D1	((pci_power_t __force) 1)
+#define PCI_D2	((pci_power_t __force) 2)
+#define PCI_D3hot	((pci_power_t __force) 3)
+#define PCI_D3cold	((pci_power_t __force) 4)
+
 /*
  * The pci_dev structure is used to describe PCI devices.
  */
--- clean/drivers/net/amd8111e.c	2004-10-01 00:30:15.000000000 +0200
+++ linux/drivers/net/amd8111e.c	2004-11-14 23:48:04.000000000 +0100
@@ -1865,17 +1865,17 @@
 		if(lp->options & OPTION_WAKE_PHY_ENABLE)
 			amd8111e_enable_link_change(lp);	
 		
-		pci_enable_wake(pci_dev, 3, 1);
-		pci_enable_wake(pci_dev, 4, 1); /* D3 cold */
+		pci_enable_wake(pci_dev, PCI_D3hot, 1);
+		pci_enable_wake(pci_dev, PCI_D3cold, 1);
 
 	}
 	else{		
-		pci_enable_wake(pci_dev, 3, 0);
-		pci_enable_wake(pci_dev, 4, 0); /* 4 == D3 cold */
+		pci_enable_wake(pci_dev, PCI_D3hot, 0);
+		pci_enable_wake(pci_dev, PCI_D3cold, 0);
 	}
 	
 	pci_save_state(pci_dev, lp->pm_state);
-	pci_set_power_state(pci_dev, 3);
+	pci_set_power_state(pci_dev, PCI_D3hot);
 
 	return 0;
 }
@@ -1887,11 +1887,11 @@
 	if (!netif_running(dev))
 		return 0;
 
-	pci_set_power_state(pci_dev, 0);
+	pci_set_power_state(pci_dev, PCI_D0);
 	pci_restore_state(pci_dev, lp->pm_state);
 
-	pci_enable_wake(pci_dev, 3, 0);
-	pci_enable_wake(pci_dev, 4, 0); /* D3 cold */
+	pci_enable_wake(pci_dev, PCI_D3hot, 0);
+	pci_enable_wake(pci_dev, PCI_D3cold, 0);
 
 	netif_device_attach(dev);
 


-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
