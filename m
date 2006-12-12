Return-Path: <linux-kernel-owner+w=401wt.eu-S932423AbWLLTza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbWLLTza (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 14:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbWLLTza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 14:55:30 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:51156 "EHLO
	e35.co.us.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932423AbWLLTz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 14:55:26 -0500
Date: Tue, 12 Dec 2006 13:55:24 -0600
To: gregkh@suse.de, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Subject: [PATCH 1/2]: Renumber PCI error enums to start at zero
Message-ID: <20061212195524.GG4329@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Greg, Andrew,

This patch fixes an annoying numbering mistake. 
Please apply this (and the next patch).

--linas

Subject: [PATCH 1/2]: Renumber PCI error enums to start at zero

Renumber the PCI error enums to start at zero for "normal/online".
This allows un-initialized pci channel state (which defaults to zero)
to be interpreted as "normal".  Add very simple routine to check
state, just in case this ever has to be fiddled with again.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 include/linux/pci.h |   11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

Index: linux-2.6.19-git7/include/linux/pci.h
===================================================================
--- linux-2.6.19-git7.orig/include/linux/pci.h	2006-12-05 17:11:02.000000000 -0600
+++ linux-2.6.19-git7/include/linux/pci.h	2006-12-05 17:12:12.000000000 -0600
@@ -87,13 +87,13 @@ typedef unsigned int __bitwise pci_chann
 
 enum pci_channel_state {
 	/* I/O channel is in normal state */
-	pci_channel_io_normal = (__force pci_channel_state_t) 1,
+	pci_channel_io_normal = (__force pci_channel_state_t) 0,
 
 	/* I/O to channel is blocked */
-	pci_channel_io_frozen = (__force pci_channel_state_t) 2,
+	pci_channel_io_frozen = (__force pci_channel_state_t) 1,
 
 	/* PCI card is dead */
-	pci_channel_io_perm_failure = (__force pci_channel_state_t) 3,
+	pci_channel_io_perm_failure = (__force pci_channel_state_t) 2,
 };
 
 typedef unsigned short __bitwise pci_bus_flags_t;
@@ -181,6 +181,11 @@ struct pci_dev {
 #define	to_pci_dev(n) container_of(n, struct pci_dev, dev)
 #define for_each_pci_dev(d) while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
 
+static inline int pci_channel_offline(struct pci_dev *pdev)
+{
+	return (pdev->error_state != pci_channel_io_normal);
+}
+
 static inline struct pci_cap_saved_state *pci_find_saved_cap(
 	struct pci_dev *pci_dev,char cap)
 {
