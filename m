Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVCRWTR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVCRWTR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 17:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbVCRWQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 17:16:46 -0500
Received: from fmr22.intel.com ([143.183.121.14]:62173 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S262394AbVCRWOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 17:14:32 -0500
Date: Fri, 18 Mar 2005 14:14:15 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: gregkh@suse.de, tony.luck@intel.com, len.brown@intel.com
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org,
       pcihpd-discuss@lists.sourceforge.net, linux-ia64@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: [patch 08/12] Remove hot-plugged devices that could not be allocated resources
Message-ID: <20050318141415.H1145@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <20050318133856.A878@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050318133856.A878@unix-os.sc.intel.com>; from rajesh.shah@intel.com on Fri, Mar 18, 2005 at 01:38:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When hot-plugging an I/O hierarchy that contains many bridges
and leaf devices, it's possible that there are not enough 
resources to start all the device present. If we fail to assign
a resource, clear the corresponding value in the pci_dev structure,
so other code can take corrective action.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
---

 linux-2.6.11-mm4-iohp-rshah1/drivers/pci/setup-bus.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -puN drivers/pci/setup-bus.c~discard_no_resource_devs drivers/pci/setup-bus.c
--- linux-2.6.11-mm4-iohp/drivers/pci/setup-bus.c~discard_no_resource_devs	2005-03-16 13:07:26.557944717 -0800
+++ linux-2.6.11-mm4-iohp-rshah1/drivers/pci/setup-bus.c	2005-03-16 13:07:26.666343153 -0800
@@ -72,7 +72,10 @@ pbus_assign_resources_sorted(struct pci_
 	for (list = head.next; list;) {
 		res = list->res;
 		idx = res - &list->dev->resource[0];
-		pci_assign_resource(list->dev, idx);
+		if (pci_assign_resource(list->dev, idx)) {
+			res->start = 0;
+			res->flags = 0;
+		}
 		tmp = list;
 		list = list->next;
 		kfree(tmp);
_
