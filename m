Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751319AbWCVP0i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751319AbWCVP0i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWCVP0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:26:37 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:15284 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751319AbWCVP0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:26:36 -0500
Date: Wed, 22 Mar 2006 16:27:03 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, snakebyte@gmx.de, linux-kernel@vger.kernel.org
Subject: [patch 23/24] s390: kzalloc() conversion in arch/s390.
Message-ID: <20060322152703.GW5801@skybase.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Sesterhenn <snakebyte@gmx.de>

[patch 23/24] s390: kzalloc() conversion in arch/s390.

Convert all kmalloc + memset sequences in arch/s390 to kzalloc usage.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/appldata/appldata_base.c |    3 +--
 arch/s390/kernel/debug.c           |   11 +++--------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff -urpN linux-2.6/arch/s390/appldata/appldata_base.c linux-2.6-patched/arch/s390/appldata/appldata_base.c
--- linux-2.6/arch/s390/appldata/appldata_base.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/appldata/appldata_base.c	2006-03-22 14:36:41.000000000 +0100
@@ -531,12 +531,11 @@ int appldata_register_ops(struct appldat
 		P_ERROR("ctl_nr %i already in use!\n", ops->ctl_nr);
 		return -EBUSY;
 	}
-	ops->ctl_table = kmalloc(4*sizeof(struct ctl_table), GFP_KERNEL);
+	ops->ctl_table = kzalloc(4*sizeof(struct ctl_table), GFP_KERNEL);
 	if (ops->ctl_table == NULL) {
 		P_ERROR("Not enough memory for %s ctl_table!\n", ops->name);
 		return -ENOMEM;
 	}
-	memset(ops->ctl_table, 0, 4*sizeof(struct ctl_table));
 
 	spin_lock(&appldata_ops_lock);
 	list_for_each(lh, &appldata_ops_list) {
diff -urpN linux-2.6/arch/s390/kernel/debug.c linux-2.6-patched/arch/s390/kernel/debug.c
--- linux-2.6/arch/s390/kernel/debug.c	2006-03-20 06:53:29.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/debug.c	2006-03-22 14:36:41.000000000 +0100
@@ -204,16 +204,13 @@ debug_areas_alloc(int pages_per_area, in
 			goto fail_malloc_areas2;
 		}
 		for(j = 0; j < pages_per_area; j++) {
-			areas[i][j] = (debug_entry_t*)kmalloc(PAGE_SIZE,
-						GFP_KERNEL);
+			areas[i][j] = kzalloc(PAGE_SIZE, GFP_KERNEL);
 			if(!areas[i][j]) {
 				for(j--; j >=0 ; j--) {
 					kfree(areas[i][j]);
 				}
 				kfree(areas[i]);
 				goto fail_malloc_areas2;
-			} else {
-				memset(areas[i][j],0,PAGE_SIZE);
 			}
 		}
 	}
@@ -249,14 +246,12 @@ debug_info_alloc(char *name, int pages_p
 	rc = (debug_info_t*) kmalloc(sizeof(debug_info_t), GFP_KERNEL);
 	if(!rc)
 		goto fail_malloc_rc;
-	rc->active_entries = (int*)kmalloc(nr_areas * sizeof(int), GFP_KERNEL);
+	rc->active_entries = kcalloc(nr_areas, sizeof(int), GFP_KERNEL);
 	if(!rc->active_entries)
 		goto fail_malloc_active_entries;
-	memset(rc->active_entries, 0, nr_areas * sizeof(int));
-	rc->active_pages = (int*)kmalloc(nr_areas * sizeof(int), GFP_KERNEL);
+	rc->active_pages = kcalloc(nr_areas, sizeof(int), GFP_KERNEL);
 	if(!rc->active_pages)
 		goto fail_malloc_active_pages;
-	memset(rc->active_pages, 0, nr_areas * sizeof(int));
 	if((mode == ALL_AREAS) && (pages_per_area != 0)){
 		rc->areas = debug_areas_alloc(pages_per_area, nr_areas);
 		if(!rc->areas)
