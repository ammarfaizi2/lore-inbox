Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751514AbWIYWMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbWIYWMu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 18:12:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbWIYWMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 18:12:50 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:11412 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751514AbWIYWMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 18:12:49 -0400
Subject: [PATCH] ip2: use newer pci_get functions
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 25 Sep 2006 23:37:32 +0100
Message-Id: <1159223852.11049.158.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is one of a series of patches I plan to gradually trickle into the
tree which eliminates almost all remaining use of pci_find_* and lets me
build a pci_find_* free kernel for all but some obscure ISDN and SCSI
drivers. This is important as all pci_find_* users are not hotplug safe
- even if they are not the device being plugged.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-mm1/drivers/char/ip2/ip2main.c linux-2.6.18-mm1/drivers/char/ip2/ip2main.c
--- linux.vanilla-2.6.18-mm1/drivers/char/ip2/ip2main.c	2006-09-25 12:10:08.000000000 +0100
+++ linux-2.6.18-mm1/drivers/char/ip2/ip2main.c	2006-09-25 12:17:20.000000000 +0100
@@ -436,6 +436,7 @@
 #ifdef CONFIG_PCI
 		if (ip2config.type[i] == PCI && ip2config.pci_dev[i]) {
 			pci_disable_device(ip2config.pci_dev[i]);
+			pci_dev_put(ip2config.pci_dev[i]);
 			ip2config.pci_dev[i] = NULL;
 		}
 #endif
@@ -505,6 +506,7 @@
 	static int loaded;
 	i2eBordStrPtr pB = NULL;
 	int rc = -1;
+	static struct pci_dev *pci_dev_i = NULL;
 
 	ip2trace (ITRC_NO_PORT, ITRC_INIT, ITRC_ENTER, 0 );
 
@@ -566,6 +568,7 @@
 
 	/* Initialise all the boards we can find (up to the maximum). */
 	for ( i = 0; i < IP2_MAX_BOARDS; ++i ) {
+		
 		switch ( ip2config.addr[i] ) { 
 		case 0:	/* skip this slot even if card is present */
 			break;
@@ -588,8 +591,7 @@
 		case PCI:
 #ifdef CONFIG_PCI
 			{
-				struct pci_dev *pci_dev_i = NULL;
-				pci_dev_i = pci_find_device(PCI_VENDOR_ID_COMPUTONE,
+				pci_dev_i = pci_get_device(PCI_VENDOR_ID_COMPUTONE,
 							  PCI_DEVICE_ID_COMPUTONE_IP2EX, pci_dev_i);
 				if (pci_dev_i != NULL) {
 					unsigned int addr;
@@ -600,7 +602,7 @@
 						break;
 					}
 					ip2config.type[i] = PCI;
-					ip2config.pci_dev[i] = pci_dev_i;
+					ip2config.pci_dev[i] = pci_dev_get(pci_dev_i);
 					status =
 					pci_read_config_dword(pci_dev_i, PCI_BASE_ADDRESS_1, &addr);
 					if ( addr & 1 ) {
@@ -641,6 +643,9 @@
 			break;
 		}	/* switch */
 	}	/* for */
+	if (pci_dev_i)
+		pci_dev_put(pci_dev_i);
+		
 	for ( i = 0; i < IP2_MAX_BOARDS; ++i ) {
 		if ( ip2config.addr[i] ) {
 			pB = kmalloc( sizeof(i2eBordStr), GFP_KERNEL);

