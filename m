Return-Path: <linux-kernel-owner+w=401wt.eu-S965036AbWLOBmk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965036AbWLOBmk (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 20:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965007AbWLOBmk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 20:42:40 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46167 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964966AbWLOBfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 20:35:16 -0500
Message-Id: <20061215013803.284069000@sous-sol.org>
References: <20061215013337.823935000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Thu, 14 Dec 2006 17:33:55 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Drake <dsd@gentoo.org>,
       stefanr@s5r6.in-berlin.de
Subject: [patch 18/24] ieee1394: ohci1394: add PPC_PMAC platform code to driver probe
Content-Disposition: inline; filename=ieee1394-ohci1394-add-ppc_pmac-platform-code-to-driver-probe.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.18-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Stefan Richter <stefanr@s5r6.in-berlin.de>

Fixes http://bugzilla.kernel.org/show_bug.cgi?id=7431
iBook G3 threw a machine check exception and put the display backlight
to full brightness after ohci1394 was unloaded and reloaded.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
[dsd@gentoo.org: also added missing if condition, commit
 63cca59e89892497e95e1e9c7156d3345fb7e2e8]
Signed-off-by: Daniel Drake <dsd@gentoo.org>
Acked-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
It fixes a kernel oops which occurs when the ohci1394 driver is reloaded on PPC
http://bugs.gentoo.org/154851

 drivers/ieee1394/ohci1394.c |   21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

--- linux-2.6.18.5.orig/drivers/ieee1394/ohci1394.c
+++ linux-2.6.18.5/drivers/ieee1394/ohci1394.c
@@ -3218,6 +3218,19 @@ static int __devinit ohci1394_pci_probe(
 	struct ti_ohci *ohci;	/* shortcut to currently handled device */
 	resource_size_t ohci_base;
 
+#ifdef CONFIG_PPC_PMAC
+	/* Necessary on some machines if ohci1394 was loaded/ unloaded before */
+	if (machine_is(powermac)) {
+		struct device_node *of_node = pci_device_to_OF_node(dev);
+
+		if (of_node) {
+			pmac_call_feature(PMAC_FTR_1394_CABLE_POWER, of_node,
+					  0, 1);
+			pmac_call_feature(PMAC_FTR_1394_ENABLE, of_node, 0, 1);
+		}
+	}
+#endif /* CONFIG_PPC_PMAC */
+
         if (pci_enable_device(dev))
 		FAIL(-ENXIO, "Failed to enable OHCI hardware");
         pci_set_master(dev);
@@ -3506,11 +3519,9 @@ static void ohci1394_pci_remove(struct p
 #endif
 
 #ifdef CONFIG_PPC_PMAC
-	/* On UniNorth, power down the cable and turn off the chip
-	 * clock when the module is removed to save power on
-	 * laptops. Turning it back ON is done by the arch code when
-	 * pci_enable_device() is called */
-	{
+	/* On UniNorth, power down the cable and turn off the chip clock
+	 * to save power on laptops */
+	if (machine_is(powermac)) {
 		struct device_node* of_node;
 
 		of_node = pci_device_to_OF_node(ohci->dev);

--
