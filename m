Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933093AbWFZWRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933093AbWFZWRQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933092AbWFZWRQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:17:16 -0400
Received: from web50106.mail.yahoo.com ([206.190.38.34]:33392 "HELO
	web50106.mail.yahoo.com") by vger.kernel.org with SMTP
	id S933093AbWFZWRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:17:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=oenqL/lmZt7yZqT2BF/DHuuj6Dfc5aTZc7nXv2kzebm7gKs4QlwvyAF3OCy9euPwGE2slVpQeIxdbP51V4hg1IXNgpAZn2U7WOE8tz1rEM/C1L06esxmTYV4FZGYwBKhRS9fGfvc7IcaRFs3qnsMDSwunyQLF5SvYBnLEFl9z6E=  ;
Message-ID: <20060626221713.42428.qmail@web50106.mail.yahoo.com>
Date: Mon, 26 Jun 2006 15:17:13 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH 3/6]  EDAC mc numbers refactor 2-of-2
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Thompson <norsk5@xmission.com>

This is part 2 of a 2-part patch set.

1 Reimplement add_mc_to_global_list() with semantics that allow the caller to
  determine the ID number for a mem_ctl_info structure.  Then modify
  edac_mc_add_mc() so that the caller specifies the ID number for the new
  mem_ctl_info structure.  Platform-specific code should be able to assign the
  ID numbers in a platform-specific manner.  For instance, on Opteron it makes
  sense to have the ID of the mem_ctl_info structure match the ID of the node
  that the memory controller belongs to.

2 Modify callers of edac_mc_add_mc() so they use the new semantics.

Signed-off-by: Doug Thompson <norsk5@xmission.com>
---
 amd76x_edac.c  |    5 ++++-
 e752x_edac.c   |    5 ++++-
 e7xxx_edac.c   |    5 ++++-
 edac_mc.c      |   46 +++++++++++++++++++++++++++++++++++++++++++++-
 edac_mc.h      |    2 +-
 i82860_edac.c  |    5 ++++-
 i82875p_edac.c |    5 ++++-
 r82600_edac.c  |    5 ++++-
 8 files changed, 70 insertions(+), 8 deletions(-)

Index: linux-2.6.17-rc5/drivers/edac/amd76x_edac.c
===================================================================
--- linux-2.6.17-rc5.orig/drivers/edac/amd76x_edac.c	2006-05-25 14:01:24.000000000
-0600
+++ linux-2.6.17-rc5/drivers/edac/amd76x_edac.c	2006-05-25 14:06:48.000000000 -0600
@@ -257,7 +257,10 @@
 
 	amd76x_get_error_info(mci, &discard);  /* clear counters */
 
-	if (edac_mc_add_mc(mci)) {
+	/* Here we assume that we will never see multiple instances of this
+	 * type of memory controller.  The ID is therefore hardcoded to 0.
+	 */
+	if (edac_mc_add_mc(mci,0)) {
 		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
 		goto fail;
 	}
Index: linux-2.6.17-rc5/drivers/edac/e752x_edac.c
===================================================================
--- linux-2.6.17-rc5.orig/drivers/edac/e752x_edac.c	2006-05-25 14:01:24.000000000
-0600
+++ linux-2.6.17-rc5/drivers/edac/e752x_edac.c	2006-05-25 14:06:48.000000000 -0600
@@ -953,7 +953,10 @@
 		"tolm = %x, remapbase = %x, remaplimit = %x\n", pvt->tolm,
 		pvt->remapbase, pvt->remaplimit);
 
-	if (edac_mc_add_mc(mci)) {
+	/* Here we assume that we will never see multiple instances of this
+	 * type of memory controller.  The ID is therefore hardcoded to 0.
+	 */
+	if (edac_mc_add_mc(mci,0)) {
 		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
 		goto fail;
 	}
Index: linux-2.6.17-rc5/drivers/edac/e7xxx_edac.c
===================================================================
--- linux-2.6.17-rc5.orig/drivers/edac/e7xxx_edac.c	2006-05-25 14:01:24.000000000
-0600
+++ linux-2.6.17-rc5/drivers/edac/e7xxx_edac.c	2006-05-25 14:06:48.000000000 -0600
@@ -463,7 +463,10 @@
 	/* clear any pending errors, or initial state bits */
 	e7xxx_get_error_info(mci, &discard);
 
-	if (edac_mc_add_mc(mci) != 0) {
+	/* Here we assume that we will never see multiple instances of this
+	 * type of memory controller.  The ID is therefore hardcoded to 0.
+	 */
+	if (edac_mc_add_mc(mci,0)) {
 		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
 		goto fail;
 	}
Index: linux-2.6.17-rc5/drivers/edac/edac_mc.c
===================================================================
--- linux-2.6.17-rc5.orig/drivers/edac/edac_mc.c	2006-05-25 14:06:40.000000000 -0600
+++ linux-2.6.17-rc5/drivers/edac/edac_mc.c	2006-05-25 14:06:48.000000000 -0600
@@ -1632,6 +1632,48 @@
 	return NULL;
 }
 
+/* Return 0 on success, 1 on failure.
+ * Before calling this function, caller must
+ * assign a unique value to mci->mc_idx.
+ */
+static int add_mc_to_global_list (struct mem_ctl_info *mci)
+{
+	struct list_head *item, *insert_before;
+	struct mem_ctl_info *p;
+
+	insert_before = &mc_devices;
+
+	if (unlikely((p = find_mci_by_dev(mci->dev)) != NULL))
+		goto fail0;
+
+	list_for_each(item, &mc_devices) {
+		p = list_entry(item, struct mem_ctl_info, link);
+
+		if (p->mc_idx >= mci->mc_idx) {
+			if (unlikely(p->mc_idx == mci->mc_idx))
+				goto fail1;
+
+			insert_before = item;
+			break;
+		}
+	}
+
+	list_add_tail_rcu(&mci->link, insert_before);
+	return 0;
+
+fail0:
+	edac_printk(KERN_WARNING, EDAC_MC,
+		    "%s (%s) %s %s already assigned %d\n", p->dev->bus_id,
+		    dev_name(p->dev), p->mod_name, p->ctl_name, p->mc_idx);
+	return 1;
+
+fail1:
+	edac_printk(KERN_WARNING, EDAC_MC,
+		    "bug in low-level driver: attempt to assign\n"
+		    "    duplicate mc_idx %d in %s()\n", p->mc_idx, __func__);
+	return 1;
+}
+
 static void complete_mc_list_del(struct rcu_head *head)
 {
 	struct mem_ctl_info *mci;
@@ -1653,6 +1695,7 @@
  * edac_mc_add_mc: Insert the 'mci' structure into the mci global list and
  *                 create sysfs entries associated with mci structure
  * @mci: pointer to the mci structure to be added to the list
+ * @mc_idx: A unique numeric identifier to be assigned to the 'mci' structure.
  *
  * Return:
  *	0	Success
@@ -1660,9 +1703,10 @@
  */
 
 /* FIXME - should a warning be printed if no error detection? correction? */
-int edac_mc_add_mc(struct mem_ctl_info *mci)
+int edac_mc_add_mc(struct mem_ctl_info *mci, int mc_idx)
 {
 	debugf0("%s()\n", __func__);
+	mci->mc_idx = mc_idx;
 #ifdef CONFIG_EDAC_DEBUG
 	if (edac_debug_level >= 3)
 		edac_mc_dump_mci(mci);
Index: linux-2.6.17-rc5/drivers/edac/edac_mc.h
===================================================================
--- linux-2.6.17-rc5.orig/drivers/edac/edac_mc.h	2006-05-25 14:01:24.000000000 -0600
+++ linux-2.6.17-rc5/drivers/edac/edac_mc.h	2006-05-25 14:06:48.000000000 -0600
@@ -417,7 +417,7 @@
 void edac_mc_dump_csrow(struct csrow_info *csrow);
 #endif  /* CONFIG_EDAC_DEBUG */
 
-extern int edac_mc_add_mc(struct mem_ctl_info *mci);
+extern int edac_mc_add_mc(struct mem_ctl_info *mci,int mc_idx);
 extern struct mem_ctl_info * edac_mc_del_mc(struct device *dev);
 extern int edac_mc_find_csrow_by_page(struct mem_ctl_info *mci,
 					unsigned long page);
Index: linux-2.6.17-rc5/drivers/edac/i82860_edac.c
===================================================================
--- linux-2.6.17-rc5.orig/drivers/edac/i82860_edac.c	2006-05-25 14:01:24.000000000
-0600
+++ linux-2.6.17-rc5/drivers/edac/i82860_edac.c	2006-05-25 14:06:48.000000000 -0600
@@ -208,7 +208,10 @@
 
 	i82860_get_error_info(mci, &discard);  /* clear counters */
 
-	if (edac_mc_add_mc(mci)) {
+	/* Here we assume that we will never see multiple instances of this
+	 * type of memory controller.  The ID is therefore hardcoded to 0.
+	 */
+	if (edac_mc_add_mc(mci,0)) {
 		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
 		edac_mc_free(mci);
 	} else {
Index: linux-2.6.17-rc5/drivers/edac/i82875p_edac.c
===================================================================
--- linux-2.6.17-rc5.orig/drivers/edac/i82875p_edac.c	2006-05-25 14:01:24.000000000
-0600
+++ linux-2.6.17-rc5/drivers/edac/i82875p_edac.c	2006-05-25 14:06:48.000000000 -0600
@@ -390,7 +390,10 @@
 
 	i82875p_get_error_info(mci, &discard);  /* clear counters */
 
-	if (edac_mc_add_mc(mci)) {
+	/* Here we assume that we will never see multiple instances of this
+	 * type of memory controller.  The ID is therefore hardcoded to 0.
+	 */
+	if (edac_mc_add_mc(mci,0)) {
 		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
 		goto fail3;
 	}
Index: linux-2.6.17-rc5/drivers/edac/r82600_edac.c
===================================================================
--- linux-2.6.17-rc5.orig/drivers/edac/r82600_edac.c	2006-05-25 14:01:24.000000000
-0600
+++ linux-2.6.17-rc5/drivers/edac/r82600_edac.c	2006-05-25 14:06:48.000000000 -0600
@@ -304,7 +304,10 @@
 
 	r82600_get_error_info(mci, &discard);  /* clear counters */
 
-	if (edac_mc_add_mc(mci)) {
+	/* Here we assume that we will never see multiple instances of this
+	 * type of memory controller.  The ID is therefore hardcoded to 0.
+	 */
+	if (edac_mc_add_mc(mci,0)) {
 		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
 		goto fail;
 	}

