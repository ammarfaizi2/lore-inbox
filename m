Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030609AbVKXGAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030609AbVKXGAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 01:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030610AbVKXGAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 01:00:34 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:36817 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1030609AbVKXGAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 01:00:34 -0500
Date: Thu, 24 Nov 2005 06:00:30 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: davej@codemonkey.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add basic PM support for Nvidia and ATI AGP bridges
Message-ID: <20051124060030.GF28070@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I retrieved these from the swsusp2 patchset, but they seem to be 
independently useful. As a result, I'm not sure who the original author 
is - however, they seem to be pretty obvious.

## All lines beginning with `## DP:' are a description of the patch.
## DP: Description: Add suspend/resume support to ATI and Nvidia AGP bridges
## DP: Patch author: Unknown
## DP: Upstream status: Not submitted

. $(dirname $0)/DPATCH

@DPATCH@
diff -ruNp 210-agp-resume-support.patch-old/drivers/char/agp/ati-agp.c 210-agp-resume-support.patch-new/drivers/char/agp/ati-agp.c
--- 210-agp-resume-support.patch-old/drivers/char/agp/ati-agp.c	2005-06-20 11:46:51.000000000 +1000
+++ 210-agp-resume-support.patch-new/drivers/char/agp/ati-agp.c	2005-07-04 23:14:18.000000000 +1000
@@ -507,6 +507,33 @@ static void __devexit agp_ati_remove(str
 	agp_put_bridge(bridge);
 }
 
+#ifdef CONFIG_PM
+
+static int agp_ati_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	pci_save_state (pdev);
+	pci_set_power_state (pdev, 3);
+
+	return 0;
+}
+
+static int agp_ati_resume(struct pci_dev *pdev)
+{
+	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
+
+	/* set power state 0 and restore PCI space */
+	pci_set_power_state (pdev, 0);
+	pci_restore_state(pdev);
+
+	/* reconfigure AGP hardware again */
+	if (bridge->driver == &ati_generic_bridge)
+		return ati_configure();
+
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
 static struct pci_device_id agp_ati_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
@@ -526,6 +553,10 @@ static struct pci_driver agp_ati_pci_dri
 	.id_table	= agp_ati_pci_table,
 	.probe		= agp_ati_probe,
 	.remove		= agp_ati_remove,
+#ifdef CONFIG_PM
+	.suspend	= agp_ati_suspend,
+	.resume		= agp_ati_resume,
+#endif
 };
 
 static int __init agp_ati_init(void)
diff -ruNp 210-agp-resume-support.patch-old/drivers/char/agp/nvidia-agp.c 210-agp-resume-support.patch-new/drivers/char/agp/nvidia-agp.c
--- 210-agp-resume-support.patch-old/drivers/char/agp/nvidia-agp.c	2005-06-20 11:46:51.000000000 +1000
+++ 210-agp-resume-support.patch-new/drivers/char/agp/nvidia-agp.c	2005-07-04 23:14:18.000000000 +1000
@@ -397,11 +397,40 @@ static struct pci_device_id agp_nvidia_p
 
 MODULE_DEVICE_TABLE(pci, agp_nvidia_pci_table);
 
+#ifdef CONFIG_PM
+static int agp_nvidia_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	pci_save_state (pdev);
+	pci_set_power_state (pdev, 3);
+
+	return 0;
+}
+
+static int agp_nvidia_resume(struct pci_dev *pdev)
+{
+	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
+
+	/* set power state 0 and restore PCI space */
+	pci_set_power_state (pdev, 0);
+	pci_restore_state(pdev);
+
+	/* reconfigure AGP hardware again */
+	if (bridge->driver == &nvidia_driver)
+		nvidia_configure();
+
+	return 0;
+}
+#endif
+
 static struct pci_driver agp_nvidia_pci_driver = {
 	.name		= "agpgart-nvidia",
 	.id_table	= agp_nvidia_pci_table,
 	.probe		= agp_nvidia_probe,
 	.remove		= agp_nvidia_remove,
+#ifdef CONFIG_PM
+	.suspend	= agp_nvidia_suspend,
+	.resume		= agp_nvidia_resume,
+#endif
 };
 
 static int __init agp_nvidia_init(void)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
