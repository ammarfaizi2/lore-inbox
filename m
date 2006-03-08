Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWCHG5K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWCHG5K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 01:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751742AbWCHG5K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 01:57:10 -0500
Received: from fmr14.intel.com ([192.55.52.68]:41948 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751202AbWCHG5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 01:57:09 -0500
Subject: Re: [PATCH] ftruncate on huge page couldn't extend hugetlb file
From: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Chen@fmsfmr100.fm.intel.com, Kenneth W <kenneth.w.chen@intel.com>,
       David Gibson <david@gibson.dropbear.id.au>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060307222148.76e5dc45.akpm@osdl.org>
References: <200603060815.k268FXg07605@unix-os.sc.intel.com>
	 <1141635963.29825.28.camel@ymzhang-perf.sh.intel.com>
	 <1141787660.29825.83.camel@ymzhang-perf.sh.intel.com>
	 <1141788278.29825.89.camel@ymzhang-perf.sh.intel.com>
	 <20060307222148.76e5dc45.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1141800861.29825.94.camel@ymzhang-perf.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Wed, 08 Mar 2006 14:54:22 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-03-08 at 14:21, Andrew Morton wrote:
> "Zhang, Yanmin" <yanmin_zhang@linux.intel.com> wrote:
> >
> > -	if (!prio_tree_empty(&mapping->i_mmap))
> >  -		hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
> >  -	spin_unlock(&mapping->i_mmap_lock);
> >  -	truncate_hugepages(inode, offset);
> >  +        if (offset > inode->i_size) {
> 
> whitespace is broken here.
Sorry for the stupid problem.


> 	} else {
> 
> >  +
> >  +		inode->i_size = offset;
> 
> i_size_write(), unless i_sem is held.   I guess it is, so OK.
Yes.

> 
> >  +		spin_lock(&mapping->i_mmap_lock);
> >  +		if (!prio_tree_empty(&mapping->i_mmap))
> >  +			hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
> >  +		spin_unlock(&mapping->i_mmap_lock);
> >  +		truncate_hugepages(inode, offset);
> >  +	}
> >   	return 0;

Here is the new patch.

From: Zhang Yanmin <yanmin.zhang@intel.com>

Currently, ftruncate on hugetlb files couldn't extend them. My patch enables it.

This patch is against 2.6.16-rc5-mm3 and on the top of the patch which
implements mmap on zero-length hugetlb files with PROT_NONE.

Thanks for Ken's good idea.

Signed-off-by: Zhang Yanmin <yanmin.zhang@intel.com>

---

diff -Nraup linux-2.6.16-rc5-mm3_huge_check/fs/hugetlbfs/inode.c linux-2.6.16-rc5-mm3_truncate/fs/hugetlbfs/inode.c
--- linux-2.6.16-rc5-mm3_huge_check/fs/hugetlbfs/inode.c	2006-03-08 18:17:15.000000000 +0800
+++ linux-2.6.16-rc5-mm3_truncate/fs/hugetlbfs/inode.c	2006-03-08 22:43:54.000000000 +0800
@@ -308,18 +308,20 @@ static int hugetlb_vmtruncate(struct ino
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
+	if (offset > inode->i_size) {
+		if (hugetlb_extend_reservation(HUGETLBFS_I(inode), pgoff) != 0)
+			return -ENOMEM;
+		inode->i_size = offset;
+	} else {
+		inode->i_size = offset;
+		spin_lock(&mapping->i_mmap_lock);
+		if (!prio_tree_empty(&mapping->i_mmap))
+			hugetlb_vmtruncate_list(&mapping->i_mmap, pgoff);
+		spin_unlock(&mapping->i_mmap_lock);
+		truncate_hugepages(inode, offset);
+	}
 	return 0;
 }
 


