Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbWHBRhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbWHBRhD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 13:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbWHBRhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 13:37:01 -0400
Received: from mxout.hispeed.ch ([62.2.95.247]:27338 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S1751294AbWHBRhA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 13:37:00 -0400
From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>
To: Greg KH <gregkh@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] PCI: use PCI_BIOS as last fallback
Date: Wed, 2 Aug 2006 19:36:40 +0200
User-Agent: KMail/1.7.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-pci" <linux-pci@atrey.karlin.mff.cuni.cz>,
       Marcus Better <marcus@better.se>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608021936.41102.daniel.ritz-ml@swissonline.ch>
X-DCC-spamcheck-01.tornado.cablecom.ch-Metrics: smtp-06.tornado.cablecom.ch 1377;
	Body=5 Fuz1=5 Fuz2=5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI: use PCI_BIOS as last fallback

there was a change in 2.6.17 which affected the order in which the PCI access
methods are probed. this gives regressions on some machines with broken BIOS.
the problem is that PCI_BIOS sometimes reports the last bus wrong, leaving cardbus
non-funcational. previously those system worked fine with direct access.
fix it by chaning the order of the probing, having PCI_BIOS as the last fallback.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>

diff --git a/arch/i386/pci/init.c b/arch/i386/pci/init.c
index c7650a7..caeefd4 100644
--- a/arch/i386/pci/init.c
+++ b/arch/i386/pci/init.c
@@ -11,13 +11,13 @@ #ifdef CONFIG_PCI_MMCONFIG
 #endif
 	if (raw_pci_ops)
 		return 0;
-#ifdef CONFIG_PCI_BIOS
-	pci_pcbios_init();
-#endif
-	if (raw_pci_ops)
-		return 0;
 #ifdef CONFIG_PCI_DIRECT
 	pci_direct_init();
+	if (raw_pci_ops)
+		return 0;
+#endif
+#ifdef CONFIG_PCI_BIOS
+	pci_pcbios_init();
 #endif
 	return 0;
 }
