Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269905AbUJSXmO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269905AbUJSXmO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 19:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270213AbUJSXjr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:39:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:7306 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270067AbUJSWqb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:31 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257313321@kroah.com>
Date: Tue, 19 Oct 2004 15:42:11 -0700
Message-Id: <10982257312950@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.2.122, 2004/10/15 12:00:07-07:00, johnrose@austin.ibm.com

[PATCH] PCI Hotplug: rpaphp safe list traversal

Hoping you will accept this fix.  The bug can cause a crash upon hotplug
remove.  The bug involves unsafe traversal of a list while deleting list
members.  The fix uses list_for_each_safe() rather than
list_for_each().  Also threw in an initialization to get rid of a
compiler warning.

Signed-off-by: John Rose <johnrose@austin.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/rpaphp_pci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/pci/hotplug/rpaphp_pci.c b/drivers/pci/hotplug/rpaphp_pci.c
--- a/drivers/pci/hotplug/rpaphp_pci.c	2004-10-19 15:21:10 -07:00
+++ b/drivers/pci/hotplug/rpaphp_pci.c	2004-10-19 15:21:10 -07:00
@@ -118,7 +118,7 @@
 {
 	int state, rc;
  	struct device_node *child_dn;
- 	struct pci_dev *child_dev;
+ 	struct pci_dev *child_dev = NULL;
 
 	*value = NOT_VALID;
 	rc = rpaphp_get_sensor_state(slot, &state);
@@ -369,7 +369,7 @@
 int rpaphp_unconfig_pci_adapter(struct slot *slot)
 {
 	int retval = 0;
-	struct list_head *ln;
+	struct list_head *ln, *tmp;
 
 	dbg("Entry %s: slot[%s]\n", __FUNCTION__, slot->name);
 	if (list_empty(&slot->dev.pci_funcs)) {
@@ -380,7 +380,7 @@
 		goto exit;
 	}
 	/* remove the devices from the pci core */
-	list_for_each (ln, &slot->dev.pci_funcs) {
+	list_for_each_safe (ln, tmp, &slot->dev.pci_funcs) {
 		struct rpaphp_pci_func *func;
 	
 		func = list_entry(ln, struct rpaphp_pci_func, sibling);

