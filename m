Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270172AbUJSXW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270172AbUJSXW5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270197AbUJSXVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:21:04 -0400
Received: from mail.kroah.org ([69.55.234.183]:20618 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270169AbUJSWql convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:41 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257312950@kroah.com>
Date: Tue, 19 Oct 2004 15:42:12 -0700
Message-Id: <10982257322647@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.1, 2004/10/06 11:17:12-07:00, greg@kroah.com

[PATCH] PCI: remove pci_find_subsys() calls from cpufreq code.

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 arch/i386/kernel/cpu/cpufreq/speedstep-ich.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)


diff -Nru a/arch/i386/kernel/cpu/cpufreq/speedstep-ich.c b/arch/i386/kernel/cpu/cpufreq/speedstep-ich.c
--- a/arch/i386/kernel/cpu/cpufreq/speedstep-ich.c	2004-10-19 15:27:53 -07:00
+++ b/arch/i386/kernel/cpu/cpufreq/speedstep-ich.c	2004-10-19 15:27:53 -07:00
@@ -171,7 +171,7 @@
  */
 static unsigned int speedstep_detect_chipset (void)
 {
-	speedstep_chipset_dev = pci_find_subsys(PCI_VENDOR_ID_INTEL,
+	speedstep_chipset_dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
 			      PCI_DEVICE_ID_INTEL_82801DB_12,
 			      PCI_ANY_ID,
 			      PCI_ANY_ID,
@@ -179,7 +179,7 @@
 	if (speedstep_chipset_dev)
 		return 4; /* 4-M */
 
-	speedstep_chipset_dev = pci_find_subsys(PCI_VENDOR_ID_INTEL,
+	speedstep_chipset_dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
 			      PCI_DEVICE_ID_INTEL_82801CA_12,
 			      PCI_ANY_ID,
 			      PCI_ANY_ID,
@@ -188,7 +188,7 @@
 		return 3; /* 3-M */
 
 
-	speedstep_chipset_dev = pci_find_subsys(PCI_VENDOR_ID_INTEL,
+	speedstep_chipset_dev = pci_get_subsys(PCI_VENDOR_ID_INTEL,
 			      PCI_DEVICE_ID_INTEL_82801BA_10,
 			      PCI_ANY_ID,
 			      PCI_ANY_ID,
@@ -201,7 +201,7 @@
 		static struct pci_dev *hostbridge;
 		u8 rev = 0;
 
-		hostbridge  = pci_find_subsys(PCI_VENDOR_ID_INTEL,
+		hostbridge  = pci_get_subsys(PCI_VENDOR_ID_INTEL,
 			      PCI_DEVICE_ID_INTEL_82815_MC,
 			      PCI_ANY_ID,
 			      PCI_ANY_ID,
@@ -214,9 +214,11 @@
 		if (rev < 5) {
 			dprintk(KERN_INFO "cpufreq: hostbridge does not support speedstep\n");
 			speedstep_chipset_dev = NULL;
+			pci_dev_put(hostbridge);
 			return 0;
 		}
 
+		pci_dev_put(hostbridge);
 		return 2; /* 2-M */
 	}
 
@@ -411,8 +413,10 @@
 	}
 
 	/* activate speedstep support */
-	if (speedstep_activate())
+	if (speedstep_activate()) {
+		pci_dev_put(speedstep_chipset_dev);
 		return -EINVAL;
+	}
 
 	return cpufreq_register_driver(&speedstep_driver);
 }
@@ -425,6 +429,7 @@
  */
 static void __exit speedstep_exit(void)
 {
+	pci_dev_put(speedstep_chipset_dev);
 	cpufreq_unregister_driver(&speedstep_driver);
 }
 

