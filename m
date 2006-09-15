Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751443AbWIONpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443AbWIONpO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:45:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWIONpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:45:14 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:29892 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751443AbWIONpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:45:11 -0400
Subject: [PATCH] via82cxxx_audio: Use pci_get_device
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, akpm@osdl.org, jgarzik@pobox.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 15:07:13 +0100
Message-Id: <1158329233.29932.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pci_find_device is not refcounting and should be getting killed off.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/sound/oss/via82cxxx_audio.c linux-2.6.18-rc6-mm1/sound/oss/via82cxxx_audio.c
--- linux.vanilla-2.6.18-rc6-mm1/sound/oss/via82cxxx_audio.c	2006-09-11 11:02:49.000000000 +0100
+++ linux-2.6.18-rc6-mm1/sound/oss/via82cxxx_audio.c	2006-09-14 17:29:54.000000000 +0100
@@ -1547,7 +1547,7 @@
 
 	DPRINTK ("ENTER\n");
 
-	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
+	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
 		drvr = pci_dev_driver (pdev);
 		if (drvr == &via_driver) {
 			assert (pci_get_drvdata (pdev) != NULL);
@@ -1562,6 +1562,7 @@
 	return -ENODEV;
 
 match:
+	pci_dev_put(pdev);
 	file->private_data = card->ac97;
 
 	DPRINTK ("EXIT, returning 0\n");
@@ -3245,7 +3246,7 @@
 	}
 
 	card = NULL;
-	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
+	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
 		drvr = pci_dev_driver (pdev);
 		if (drvr == &via_driver) {
 			assert (pci_get_drvdata (pdev) != NULL);
@@ -3264,6 +3265,7 @@
 	return -ENODEV;
 
 match:
+	pci_dev_put(pdev);
 	if (nonblock) {
 		if (!mutex_trylock(&card->open_mutex)) {
 			DPRINTK ("EXIT, returning -EAGAIN\n");

