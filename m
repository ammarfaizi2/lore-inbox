Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751488AbWIOOGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbWIOOGH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 10:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWIOOGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 10:06:07 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8618 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751482AbWIOOGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 10:06:04 -0400
Subject: [PATCH] via* : switch to pci_get_device refcounted PCI API
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org, benh@kernel.crashing.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 15 Sep 2006 15:29:37 +0100
Message-Id: <1158330577.29932.56.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If we can clean up these remainders we can finally delete pci_find_*

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/macintosh/via-pmu68k.c linux-2.6.18-rc6-mm1/drivers/macintosh/via-pmu68k.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/macintosh/via-pmu68k.c	2006-09-11 11:00:40.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/macintosh/via-pmu68k.c	2006-09-14 16:41:16.000000000 +0100
@@ -843,7 +843,7 @@
 	struct pci_save *ps;
 
 	npci = 0;
-	while ((pd = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL)
+	while ((pd = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL)
 		++npci;
 	n_pbook_pci_saves = npci;
 	if (npci == 0)
@@ -854,7 +854,7 @@
 		return;
 
 	pd = NULL;
-	while ((pd = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
+	while ((pd = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
 		pci_read_config_word(pd, PCI_COMMAND, &ps->command);
 		pci_read_config_word(pd, PCI_CACHE_LINE_SIZE, &ps->cache_lat);
 		pci_read_config_word(pd, PCI_INTERRUPT_LINE, &ps->intr);
@@ -871,7 +871,7 @@
 	struct pci_dev *pd = NULL;
 	int j;
 
-	while ((pd = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
+	while ((pd = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
 		if (ps->command == 0)
 			continue;
 		pci_read_config_word(pd, PCI_COMMAND, &cmd);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc6-mm1/drivers/macintosh/via-pmu.c linux-2.6.18-rc6-mm1/drivers/macintosh/via-pmu.c
--- linux.vanilla-2.6.18-rc6-mm1/drivers/macintosh/via-pmu.c	2006-09-11 17:00:10.000000000 +0100
+++ linux-2.6.18-rc6-mm1/drivers/macintosh/via-pmu.c	2006-09-14 16:43:07.000000000 +0100
@@ -1827,7 +1827,7 @@
 	struct pci_dev *pd = NULL;
 
 	npci = 0;
-	while ((pd = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
+	while ((pd = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
 		++npci;
 	}
 	if (npci == 0)
@@ -1857,9 +1857,11 @@
 	if (ps == NULL)
 		return;
 
-	while ((pd = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
-		if (npci-- == 0)
+	while ((pd = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
+		if (npci-- == 0) {
+			pci_dev_put(pd);
 			return;
+		}
 #ifndef HACKED_PCI_SAVE
 		pci_read_config_word(pd, PCI_COMMAND, &ps->command);
 		pci_read_config_word(pd, PCI_CACHE_LINE_SIZE, &ps->cache_lat);
@@ -1887,11 +1889,13 @@
 	int npci = pbook_npci_saves;
 	int j;
 
-	while ((pd = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
+	while ((pd = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pd)) != NULL) {
 #ifdef HACKED_PCI_SAVE
 		int i;
-		if (npci-- == 0)
+		if (npci-- == 0) {
+			pci_dev_put(pd);
 			return;
+		}
 		ps++;
 		for (i=2;i<16;i++)
 			pci_write_config_dword(pd, i<<4, ps->config[i]);

