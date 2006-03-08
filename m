Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWCHD1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWCHD1S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 22:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932424AbWCHD1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 22:27:18 -0500
Received: from fmr23.intel.com ([143.183.121.15]:52418 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S932422AbWCHD1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 22:27:17 -0500
Subject: [PATCH] ftruncate on huge page couldn't extend hugetlb file
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: David Gibson <david@gibson.dropbear.id.au>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>
In-Reply-To: <1141787660.29825.83.camel@ymzhang-perf.sh.intel.com>
References: <200603060815.k268FXg07605@unix-os.sc.intel.com>
	 <1141635963.29825.28.camel@ymzhang-perf.sh.intel.com>
	 <1141787660.29825.83.camel@ymzhang-perf.sh.intel.com>
Content-Type: text/plain
Message-Id: <1141788278.29825.89.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 08 Mar 2006 11:24:38 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yanmin <yanmin.zhang@intel.com>

Currently, ftruncate on hugetlb files couldn't extend them. My patch enables it.

This patch is against 2.6.16-rc5-mm3 and on the top of the patch which
implements mmap on zero-length hugetlb files with PROT_NONE.

Thanks for Ken's good idea.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

diff -Nraup linux-2.6.16-rc5-mm3_huge_check/fs/hugetlbfs/inode.c linux-2.6.16-rc5-mm3_truncate/fs/hugetlbfs/inode.c
--- linux-2.6.16-rc5-mm3_huge_check/fs/hugetlbfs/inode.c	2006-03-08 18:17:15.000000000 +0800
+++ linux-2.6.16-rc5-mm3_truncate/fs/hugetlbfs/inode.c	2006-03-08 18:50:40.000000000 +0800
@@ -308,18 +308,22 @@ static int hugetlb_vmtruncate(struct ino
 	unsigned long pgoff;
 	struct address_space *mapping = inode->i_mapping;
 
-	if (offset > inode->i_size)
-		return -EINVAL;
-
 	BUG_ON(offset & ~HPAGE_MASK);
 	pgoff = offset >> HPAGE_SHIFT;
-
-	inode->i_size = offset;
-	spin_lock(&mapping->i_mmap_lock);
-	if (!prio_tree_empty(&mapping->i_mmap))
-		hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
-	spin_unlock(&mapping->i_mmap_lock);
-	truncate_hugepages(inode, offset);
+        if (offset > inode->i_size) {
+        	if (hugetlb_extend_reservation(HUGETLBFS_I(inode), pgoff) != 0)
+			return -ENOMEM;
+		inode->i_size = offset;
+	}
+	else {
+
+		inode->i_size = offset;
+		spin_lock(&mapping->i_mmap_lock);
+		if (!prio_tree_empty(&mapping->i_mmap))
+			hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
+		spin_unlock(&mapping->i_mmap_lock);
+		truncate_hugepages(inode, offset);
+	}
 	return 0;
 }
 


