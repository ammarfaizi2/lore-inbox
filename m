Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266486AbUHCOkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266486AbUHCOkZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 10:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266511AbUHCOkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 10:40:25 -0400
Received: from smtp.sys.beep.pl ([195.245.198.13]:14354 "EHLO smtp.sys.beep.pl")
	by vger.kernel.org with ESMTP id S266486AbUHCOkQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 10:40:16 -0400
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
Organization: SelfOrganizing
To: Dave Jones <davej@codemonkey.org.uk>
Subject: [PATCH]: via-agp.c resume/suspend support
Date: Tue, 3 Aug 2004 16:39:47 +0200
User-Agent: KMail/1.6.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200408031639.47204.arekm@pld-linux.org>
X-Spam-Score: 1.1 (+)
X-Spam-Report: Points assigned by spam scoring system to this email. Note that message
	is treated as spam ONLY if X-Spam-Flag header is set to YES.
	If you have any report questions, see report postmaster@beep.pl for details.
	Content analysis details:   (1.1 points, 25.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 REMOVE_REMOVAL_NEAR    List removal information
X-Authenticated-Id: arekm 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

With this patch I'm able to suspend to disk (well, works even without patch)
and resume (without it my laptop hangs (even sysrq is not working)
while resuming).

Please comment and send upstream if it's ok with you. Thanks!


PATCH: resume/suspend support for via-agp driver.

Signed-off-by: Arkadiusz Miskiewicz <arekm@pld-linux.org>

--- linux-2.6.8-rc2.org/drivers/char/agp/via-agp.c	2004-07-30 19:19:16.000000000 +0200
+++ linux-2.6.8-rc2/drivers/char/agp/via-agp.c	2004-08-03 16:21:41.000000000 +0200
@@ -438,6 +423,33 @@
 	agp_put_bridge(bridge);
 }
 
+#ifdef CONFIG_PM
+
+static int agp_via_suspend(struct pci_dev *pdev, u32 state)
+{
+	pci_save_state (pdev, pdev->saved_config_space);
+	pci_set_power_state (pdev, 3);
+
+	return 0;
+}
+
+static int agp_via_resume(struct pci_dev *pdev)
+{
+	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
+
+	pci_set_power_state (pdev, 0);
+	pci_restore_state(pdev, pdev->saved_config_space);
+
+	if (bridge->driver == &via_agp3_driver)
+		return via_configure_agp3();
+	else if (bridge->driver == &via_driver)
+		return via_configure();
+
+	return 0;
+}
+
+#endif /* CONFIG_PM */
+
 /* must be the same order as name table above */
 static struct pci_device_id agp_via_pci_table[] = {
 #define ID(x) \
@@ -487,6 +496,10 @@
 	.id_table	= agp_via_pci_table,
 	.probe		= agp_via_probe,
 	.remove		= agp_via_remove,
+#ifdef CONFIG_PM
+	.suspend	= agp_via_suspend,
+	.resume		= agp_via_resume,
+#endif
 };
 
-- 
Arkadiusz Mi¶kiewicz     CS at FoE, Wroclaw University of Technology
arekm.pld-linux.org, 1024/3DB19BBD, JID: arekm.jabber.org, PLD/Linux
