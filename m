Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261263AbVAHTI1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261263AbVAHTI1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jan 2005 14:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261269AbVAHTI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jan 2005 14:08:27 -0500
Received: from verein.lst.de ([213.95.11.210]:37315 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S261263AbVAHTIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jan 2005 14:08:24 -0500
Date: Sat, 8 Jan 2005 20:08:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: davej@redhat.com, hannal@us.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix pci_get_device conversion in intel-agp
Message-ID: <20050108190815.GA7031@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 - any device teardown must happen between agp_remove_bridge and
   agp_put_bridge, before agp_remove_bridge users can still call into
   the code
 - it's releasing a reference to the wrong device


--- 1.76/drivers/char/agp/intel-agp.c	2004-12-22 05:53:58 +01:00
+++ edited/drivers/char/agp/intel-agp.c	2005-01-08 20:11:38 +01:00
@@ -1720,8 +1720,13 @@
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
-	pci_dev_put(pdev);
 	agp_remove_bridge(bridge);
+
+	if (intel_i810_private.i810_dev)
+		pci_dev_put(intel_i810_private.i830_dev);
+	if (intel_i810_private.i830_dev)
+		pci_dev_put(intel_i830_private.i830_dev);
+	
 	agp_put_bridge(bridge);
 }
--- 1.18/drivers/char/agp/intel-mch-agp.c	2004-12-16 07:31:44 +01:00
+++ edited/drivers/char/agp/intel-mch-agp.c	2005-01-08 20:12:18 +01:00
@@ -569,8 +569,11 @@
 {
 	struct agp_bridge_data *bridge = pci_get_drvdata(pdev);
 
-	pci_dev_put(pdev);
 	agp_remove_bridge(bridge);
+
+	if (intel_i810_private.i830_dev)
+		pci_dev_put(intel_i830_private.i830_dev);
+
 	agp_put_bridge(bridge);
 }
 
