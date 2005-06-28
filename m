Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261642AbVF1Fva@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261642AbVF1Fva (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 01:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbVF1Fts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 01:49:48 -0400
Received: from mail.kroah.org ([69.55.234.183]:18924 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261719AbVF1Fdi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 01:33:38 -0400
Cc: rajesh.shah@intel.com
Subject: [PATCH] acpi bridge hotadd: Remove hot-plugged devices that could not be allocated resources
In-Reply-To: <1119936773200@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 27 Jun 2005 22:32:53 -0700
Message-Id: <11199367734132@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] acpi bridge hotadd: Remove hot-plugged devices that could not be allocated resources

When hot-plugging an I/O hierarchy that contains many bridges and leaf
devices, it's possible that there are not enough resources to start all the
device present.  If we fail to assign a resource, clear the corresponding
value in the pci_dev structure, so other code can take corrective action.

Signed-off-by: Rajesh Shah <rajesh.shah@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 542df5de56a23bf2d94b75e2b304ab0e5a5508a8
tree 6e9861262c3fb9cfa72a385ea8db5372c086e35b
parent 091ca9f06382e46d77213c35a97f7d0be9e350d2
author Rajesh Shah <rajesh.shah@intel.com> Thu, 28 Apr 2005 00:25:50 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 27 Jun 2005 21:52:41 -0700

 drivers/pci/setup-bus.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
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

