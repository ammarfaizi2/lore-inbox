Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750737AbVLZOPI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVLZOPI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 09:15:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbVLZOPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 09:15:07 -0500
Received: from smtp.etmail.cz ([160.218.43.220]:23447 "EHLO smtp.etmail.cz")
	by vger.kernel.org with ESMTP id S1750737AbVLZOPG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 09:15:06 -0500
Message-ID: <43AFFAEA.1000401@stud.feec.vutbr.cz>
Date: Mon, 26 Dec 2005 15:15:06 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] amd64-agp suspend support
Content-Type: multipart/mixed;
 boundary="------------040601050603070303010109"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040601050603070303010109
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This adds support for suspend/resume to the amd64-agp driver. Without 
it, X displays garbage after resume from swsusp.

Signed-off-by: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>

--------------040601050603070303010109
Content-Type: text/plain;
 name="amd64-agp-suspend-support.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="amd64-agp-suspend-support.diff"

diff -Nurp -X linux-mich/Documentation/dontdiff linux/drivers/char/agp/amd64-agp.c linux-mich/drivers/char/agp/amd64-agp.c
--- linux/drivers/char/agp/amd64-agp.c	2005-12-25 19:33:28.000000000 +0100
+++ linux-mich/drivers/char/agp/amd64-agp.c	2005-12-26 14:38:30.000000000 +0100
@@ -600,6 +600,26 @@ static void __devexit agp_amd64_remove(s
 	agp_put_bridge(bridge);
 }
 
+#ifdef CONFIG_PM
+
+static int agp_amd64_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	pci_save_state(pdev);
+	pci_set_power_state(pdev, pci_choose_state(pdev, state));
+
+	return 0;
+}
+
+static int agp_amd64_resume(struct pci_dev *pdev)
+{
+	pci_set_power_state(pdev, PCI_D0);
+	pci_restore_state(pdev);
+
+	return amd_8151_configure();	
+}
+
+#endif /* CONFIG_PM */
+
 static struct pci_device_id agp_amd64_pci_table[] = {
 	{
 	.class		= (PCI_CLASS_BRIDGE_HOST << 8),
@@ -718,6 +738,10 @@ static struct pci_driver agp_amd64_pci_d
 	.id_table	= agp_amd64_pci_table,
 	.probe		= agp_amd64_probe,
 	.remove		= agp_amd64_remove,
+#ifdef CONFIG_PM
+	.suspend	= agp_amd64_suspend,
+	.resume		= agp_amd64_resume,
+#endif
 };
 
 

--------------040601050603070303010109--
