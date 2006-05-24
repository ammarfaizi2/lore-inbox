Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932734AbWEXRrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932734AbWEXRrL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 13:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbWEXRrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 13:47:11 -0400
Received: from web50105.mail.yahoo.com ([206.190.38.33]:46767 "HELO
	web50105.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932734AbWEXRrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 13:47:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Dm8xjv/IP0pEm5/b//WxVT5ejgcV8j8SrGO0SZWv1UJSL5EfKa7UFIku3PY/e69+zYwC++2Y056C/nDofElEJYRLdmLws4FERnLuippFFKCC4D8vbzZmjBWr8iQN+LyqJTkYUa7/jVlN0BonL2tJaVMpXx+c8ZJzAH539Me2uJI=  ;
Message-ID: <20060524174709.68400.qmail@web50105.mail.yahoo.com>
Date: Wed, 24 May 2006 10:47:09 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH 3/6]  EDAC mc numbers refactor 2-of-2
To: Andrew Morton <akpm@osdl.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is part 2 of a 2-part patch set.

1 Reimplement add_mc_to_global_list() with semantics that allow the caller to
  determine the ID number for a mem_ctl_info structure.  Then modify
  edac_mc_add_mc() so that the caller specifies the ID number for the new
  mem_ctl_info structure.  Platform-specific code should be able to assign the
  ID numbers in a platform-specific manner.  For instance, on Opteron it makes
  sense to have the ID of the mem_ctl_info structure match the ID of the node
  that the memory controller belongs to.

2 Modify callers of edac_mc_add_mc() so they use the new semantics.

Signed-of-by: Doug Thompson <norsk5@xmission.com>


Index: linux-2.6.17-rc4/drivers/edac/amd76x_edac.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/edac/amd76x_edac.c	2006-05-15 15:40:31.000000000
-0600
+++ linux-2.6.17-rc4/drivers/edac/amd76x_edac.c	2006-05-15 15:44:30.000000000 -0600
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
Index: linux-2.6.17-rc4/drivers/edac/e752x_edac.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/edac/e752x_edac.c	2006-05-15 15:40:31.000000000
-0600
+++ linux-2.6.17-rc4/drivers/edac/e752x_edac.c	2006-05-15 15:44:30.000000000 -0600
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
Index: linux-2.6.17-rc4/drivers/edac/e7xxx_edac.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/edac/e7xxx_edac.c	2006-05-15 15:44:21.000000000
-0600
+++ linux-2.6.17-rc4/drivers/edac/e7xxx_edac.c	2006-05-15 15:44:30.000000000 -0600
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
Index: linux-2.6.17-rc4/drivers/edac/edac_mc.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/edac/edac_mc.c	2006-05-15 15:44:28.000000000 -0600
+++ linux-2.6.17-rc4/drivers/edac/edac_mc.c	2006-05-15 15:44:30.000000000 -0600
@@ -1390,6 +1390,48 @@
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
@@ -1411,6 +1453,7 @@
  * edac_mc_add_mc: Insert the 'mci' structure into the mci global list and
  *                 create sysfs entries associated with mci structure
  * @mci: pointer to the mci structure to be added to the list
+ * @mc_idx: A unique numeric identifier to be assigned to the 'mci' structure.
  *
  * Return:
  *	0	Success
@@ -1418,9 +1461,10 @@
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
Index: linux-2.6.17-rc4/drivers/edac/edac_mc.h
===================================================================
--- linux-2.6.17-rc4.orig/drivers/edac/edac_mc.h	2006-05-15 15:40:31.000000000 -0600
+++ linux-2.6.17-rc4/drivers/edac/edac_mc.h	2006-05-15 15:44:30.000000000 -0600
@@ -421,7 +421,7 @@
 void edac_mc_dump_csrow(struct csrow_info *csrow);
 #endif  /* CONFIG_EDAC_DEBUG */
 
-extern int edac_mc_add_mc(struct mem_ctl_info *mci);
+extern int edac_mc_add_mc(struct mem_ctl_info *mci,int mc_idx);
 extern struct mem_ctl_info * edac_mc_del_mc(struct device *dev);
 extern int edac_mc_find_csrow_by_page(struct mem_ctl_info *mci,
 					unsigned long page);
Index: linux-2.6.17-rc4/drivers/edac/i82860_edac.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/edac/i82860_edac.c	2006-05-15 15:42:36.000000000
-0600
+++ linux-2.6.17-rc4/drivers/edac/i82860_edac.c	2006-05-15 15:44:30.000000000 -0600
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
Index: linux-2.6.17-rc4/drivers/edac/i82875p_edac.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/edac/i82875p_edac.c	2006-05-15 15:43:19.000000000
-0600
+++ linux-2.6.17-rc4/drivers/edac/i82875p_edac.c	2006-05-15 15:44:30.000000000 -0600
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
Index: linux-2.6.17-rc4/drivers/edac/r82600_edac.c
===================================================================
--- linux-2.6.17-rc4.orig/drivers/edac/r82600_edac.c	2006-05-15 15:44:02.000000000
-0600
+++ linux-2.6.17-rc4/drivers/edac/r82600_edac.c	2006-05-15 15:44:30.000000000 -0600
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



"If you think Education is expensive, just try Ignorance"

"Don't tell people HOW to do things, tell them WHAT you
want and they will surprise you with their ingenuity."
                   Gen George Patton

