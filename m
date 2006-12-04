Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936967AbWLDO7q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936967AbWLDO7q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 09:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936966AbWLDO4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 09:56:53 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:22524 "EHLO
	mtagate5.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936963AbWLDO4P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 09:56:15 -0500
Date: Mon, 4 Dec 2006 15:56:10 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] Convert extmem spin_lock into a mutex.
Message-ID: <20061204145610.GA32059@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] Convert extmem spin_lock into a mutex.

There's no need to have a spin_lock here, but need sleepable context
for vmem_map. Therefore convert the spin_lock into a mutex.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/extmem.c |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff -urpN linux-2.6/arch/s390/mm/extmem.c linux-2.6-patched/arch/s390/mm/extmem.c
--- linux-2.6/arch/s390/mm/extmem.c	2006-12-04 14:50:53.000000000 +0100
+++ linux-2.6-patched/arch/s390/mm/extmem.c	2006-12-04 14:50:59.000000000 +0100
@@ -78,7 +78,7 @@ struct dcss_segment {
 	int segcnt;
 };
 
-static DEFINE_SPINLOCK(dcss_lock);
+static DEFINE_MUTEX(dcss_lock);
 static struct list_head dcss_list = LIST_HEAD_INIT(dcss_list);
 static char *segtype_string[] = { "SW", "EW", "SR", "ER", "SN", "EN", "SC",
 					"EW/EN-MIXED" };
@@ -114,7 +114,7 @@ segment_by_name (char *name)
 	struct list_head *l;
 	struct dcss_segment *tmp, *retval = NULL;
 
-	assert_spin_locked(&dcss_lock);
+	BUG_ON(!mutex_is_locked(&dcss_lock));
 	dcss_mkname (name, dcss_name);
 	list_for_each (l, &dcss_list) {
 		tmp = list_entry (l, struct dcss_segment, list);
@@ -269,7 +269,7 @@ segment_overlaps_others (struct dcss_seg
 	struct list_head *l;
 	struct dcss_segment *tmp;
 
-	assert_spin_locked(&dcss_lock);
+	BUG_ON(!mutex_is_locked(&dcss_lock));
 	list_for_each(l, &dcss_list) {
 		tmp = list_entry(l, struct dcss_segment, list);
 		if ((tmp->start_addr >> 20) > (seg->end >> 20))
@@ -426,7 +426,7 @@ segment_load (char *name, int do_nonshar
 	if (!MACHINE_IS_VM)
 		return -ENOSYS;
 
-	spin_lock (&dcss_lock);
+	mutex_lock(&dcss_lock);
 	seg = segment_by_name (name);
 	if (seg == NULL)
 		rc = __segment_load (name, do_nonshared, addr, end);
@@ -441,7 +441,7 @@ segment_load (char *name, int do_nonshar
 			rc    = -EPERM;
 		}
 	}
-	spin_unlock (&dcss_lock);
+	mutex_unlock(&dcss_lock);
 	return rc;
 }
 
@@ -464,7 +464,7 @@ segment_modify_shared (char *name, int d
 	unsigned long dummy;
 	int dcss_command, rc, diag_cc;
 
-	spin_lock (&dcss_lock);
+	mutex_lock(&dcss_lock);
 	seg = segment_by_name (name);
 	if (seg == NULL) {
 		rc = -EINVAL;
@@ -505,7 +505,7 @@ segment_modify_shared (char *name, int d
 		  &dummy, &dummy);
 	kfree(seg);
  out_unlock:
-	spin_unlock(&dcss_lock);
+	mutex_unlock(&dcss_lock);
 	return rc;
 }
 
@@ -523,7 +523,7 @@ segment_unload(char *name)
 	if (!MACHINE_IS_VM)
 		return;
 
-	spin_lock(&dcss_lock);
+	mutex_lock(&dcss_lock);
 	seg = segment_by_name (name);
 	if (seg == NULL) {
 		PRINT_ERR ("could not find segment %s in segment_unload, "
@@ -537,7 +537,7 @@ segment_unload(char *name)
 		kfree(seg);
 	}
 out_unlock:
-	spin_unlock(&dcss_lock);
+	mutex_unlock(&dcss_lock);
 }
 
 /*
@@ -556,7 +556,7 @@ segment_save(char *name)
 	if (!MACHINE_IS_VM)
 		return;
 
-	spin_lock(&dcss_lock);
+	mutex_lock(&dcss_lock);
 	seg = segment_by_name (name);
 
 	if (seg == NULL) {
@@ -589,7 +589,7 @@ segment_save(char *name)
 		goto out;
 	}
 out:
-	spin_unlock(&dcss_lock);
+	mutex_unlock(&dcss_lock);
 }
 
 EXPORT_SYMBOL(segment_load);
