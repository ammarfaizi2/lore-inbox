Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751554AbWCHTDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554AbWCHTDc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 14:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751550AbWCHTDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 14:03:32 -0500
Received: from fmr21.intel.com ([143.183.121.13]:45547 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751315AbWCHTDb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 14:03:31 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] ftruncate on huge page couldn't extend hugetlb file
Date: Wed, 8 Mar 2006 11:03:20 -0800
Message-ID: <B05667366EE6204181EABE9C1B1C0EB509E5AC61@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] ftruncate on huge page couldn't extend hugetlb file
Thread-Index: AcZCfYA9MqAI0U2TRueLSRHhrpWP6AAZC/4Q
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <Chen@fmsfmr100.fm.intel.com>,
       "David Gibson" <david@gibson.dropbear.id.au>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 Mar 2006 19:03:21.0500 (UTC) FILETIME=[F7DAEDC0:01C642E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zhang, Yanmin wrote on Tuesday, March 07, 2006 10:54 PM
> From: Zhang Yanmin <yanmin.zhang@intel.com>
> 
> Currently, ftruncate on hugetlb files couldn't extend them. My patch
enables it.
> 
> This patch is against 2.6.16-rc5-mm3 and on the top of the patch which
> implements mmap on zero-length hugetlb files with PROT_NONE.

Reservation should be already done at the mmap time.
Like this?


Signed-off-by: Ken Chen <kenneth.w.chen@intel.com>

--- linux-2.6.15/fs/hugetlbfs/inode.c.orig	2006-03-08
11:39:49.782708398 -0800
+++ linux-2.6.15/fs/hugetlbfs/inode.c	2006-03-08 11:51:04.382309509
-0800
@@ -337,20 +337,18 @@ hugetlb_vmtruncate_list(struct prio_tree
 	}
 }
 
-/*
- * Expanding truncates are not allowed.
- */
 static int hugetlb_vmtruncate(struct inode *inode, loff_t offset)
 {
 	unsigned long pgoff;
 	struct address_space *mapping = inode->i_mapping;
 
-	if (offset > inode->i_size)
-		return -EINVAL;
-
 	BUG_ON(offset & ~HPAGE_MASK);
 	pgoff = offset >> HPAGE_SHIFT;
 
+	if (offset > inode->i_size) {
+		inode->i_size = offset;
+		return 0;
+	}
 	inode->i_size = offset;
 	spin_lock(&mapping->i_mmap_lock);
 	if (!prio_tree_empty(&mapping->i_mmap))
