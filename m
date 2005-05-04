Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262042AbVEDHEN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262042AbVEDHEN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 03:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262043AbVEDHDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 03:03:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:63716 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262044AbVEDHCW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 03:02:22 -0400
Cc: eike-hotplug@sf-tec.de
Subject: [PATCH] PCI Hotplug ibmphp_pci.c: Fix masking out needed information too early
In-Reply-To: <11151901371766@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 May 2005 00:02:17 -0700
Message-Id: <11151901371381@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] PCI Hotplug ibmphp_pci.c: Fix masking out needed information too early

here is the patch that fixes the bug introduced by my previous patch which
already went into 2.6.12-rc2 and is likely to cause trouble is someone hits
one the else case here by accident.

Using the &= operation before the if statement destroys the information the
if asks for so we always go into the else branch.

Signed-off-by: Rolf Eike Beer <eike-hotplug@sf-tec.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 034ecc724cc6ba662d0b2b5a1e11e7e66a768596
tree d34ced60da68e2dca2aae90e2b29d8f94618ffbc
parent c8958177224622411b9979eabb5610e30b06034b
author Rolf Eike Beer <eike-hotplug@sf-tec.de> 1113224514 +0200
committer Greg KH <gregkh@suse.de> 1115189115 -0700

Index: drivers/pci/hotplug/ibmphp_pci.c
===================================================================
--- 09ceb4ce69813c9ac2a3e3c7ea6eff9d5361fe9c/drivers/pci/hotplug/ibmphp_pci.c  (mode:100644 sha1:2335fac65fb4eee0456837e97d9cd99e5adec341)
+++ d34ced60da68e2dca2aae90e2b29d8f94618ffbc/drivers/pci/hotplug/ibmphp_pci.c  (mode:100644 sha1:8122fe734aa78d40cd23ea6bd236dcbb040a0bcb)
@@ -1308,10 +1308,10 @@
 			/* ????????? DO WE NEED TO WRITE ANYTHING INTO THE PCI CONFIG SPACE BACK ?????????? */
 		} else {
 			/* This is Memory */
-			start_address &= PCI_BASE_ADDRESS_MEM_MASK;
 			if (start_address & PCI_BASE_ADDRESS_MEM_PREFETCH) {
 				/* pfmem */
 				debug ("start address of pfmem is %x\n", start_address);
+				start_address &= PCI_BASE_ADDRESS_MEM_MASK;
 
 				if (ibmphp_find_resource (bus, start_address, &pfmem, PFMEM) < 0) {
 					err ("cannot find corresponding PFMEM resource to remove\n");
@@ -1325,6 +1325,8 @@
 			} else {
 				/* regular memory */
 				debug ("start address of mem is %x\n", start_address);
+				start_address &= PCI_BASE_ADDRESS_MEM_MASK;
+
 				if (ibmphp_find_resource (bus, start_address, &mem, MEM) < 0) {
 					err ("cannot find corresponding MEM resource to remove\n");
 					return -EIO;
@@ -1422,9 +1424,9 @@
 			/* ????????? DO WE NEED TO WRITE ANYTHING INTO THE PCI CONFIG SPACE BACK ?????????? */
 		} else {
 			/* This is Memory */
-			start_address &= PCI_BASE_ADDRESS_MEM_MASK;
 			if (start_address & PCI_BASE_ADDRESS_MEM_PREFETCH) {
 				/* pfmem */
+				start_address &= PCI_BASE_ADDRESS_MEM_MASK;
 				if (ibmphp_find_resource (bus, start_address, &pfmem, PFMEM) < 0) {
 					err ("cannot find corresponding PFMEM resource to remove\n");
 					return -EINVAL;
@@ -1436,6 +1438,7 @@
 				}
 			} else {
 				/* regular memory */
+				start_address &= PCI_BASE_ADDRESS_MEM_MASK;
 				if (ibmphp_find_resource (bus, start_address, &mem, MEM) < 0) {
 					err ("cannot find corresponding MEM resource to remove\n");
 					return -EINVAL;

