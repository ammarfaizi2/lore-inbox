Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263240AbUDEXUV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 19:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbUDEXUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 19:20:21 -0400
Received: from fmr04.intel.com ([143.183.121.6]:63925 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S263240AbUDEXTV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 19:19:21 -0400
Message-Id: <200404052318.i35NIHF29964@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ray Bryant'" <raybry@sgi.com>
Cc: "'Andy Whitcroft'" <apw@shadowen.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>, "Andrew Morton" <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <anton@samba.org>, <sds@epoch.ncsc.mil>,
       <ak@suse.de>, <lse-tech@lists.sourceforge.net>,
       <linux-ia64@vger.kernel.org>
Subject: RE: [Lse-tech] RE: [PATCH] HUGETLB memory commitment
Date: Mon, 5 Apr 2004 16:18:17 -0700
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcQbQmFE3myMlwRFScyNnG+v3muadwADhJVg
In-Reply-To: <4071A3DE.2020809@sgi.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> Ray Bryant wrote on Monday, April 05, 2004 11:22 AM
> > Chen, Kenneth W wrote:
> > I actually started coding yesterday.  It doesn't look too bad (I think).
> > I will post it once I finished it up later today or tomorrow.
>
> Hmmm...so did I.  Oh well.  We can pull the good ideas from both. :-)

I did have a revelation from your original demand-paging patch with per-inode
tracking ;-)  I extended it into tracking by struct address_space (so we don't
pollute inode structure) and added per-block tracking.  See patch at the end of
this post. I admit I had very pessimistic thoughts until I saw your patch.


> > There are still some oddity in lifetime of the huge page reservation,
> > but that can be discussed once everyone sees the code.

I was thinking the lifetime of the huge page reservation should be the life
of a mapping, i.e., only persist across mmap/munmap.  That means add a ref
count in the per-block tracking.  This seriously complicates the design
because now, ref count needs to be updated in munmap and fault_hander in
addition to the mmap and truncate.  Not to mention that Andy Whitcroft already
pointed out we don't get notification from munmap.  Plus it seriously make
tracking logic complicated and have performance down side as well.

I guess everyone is OK with reservation lives until file truncate?



Patch enclosed, less than 140 lines of change (only x86 and ia64 for now,
should be trivial to add other arch).  Tested on linux-2.6.5

 arch/i386/mm/hugetlbpage.c |    5 +
 arch/ia64/mm/hugetlbpage.c |    5 +
 fs/hugetlbfs/inode.c       |  119 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/hugetlb.h    |    8 +++
 4 files changed, 135 insertions(+), 2 deletions(-)

diff -Nurp linux-2.6.5/arch/i386/mm/hugetlbpage.c linux-2.6.5.htlb/arch/i386/mm/hugetlbpage.c
--- linux-2.6.5/arch/i386/mm/hugetlbpage.c	2004-04-03 19:38:15.000000000 -0800
+++ linux-2.6.5.htlb/arch/i386/mm/hugetlbpage.c	2004-04-05 16:09:29.000000000 -0700
@@ -22,7 +22,8 @@

 static long    htlbpagemem;
 int     htlbpage_max;
-static long    htlbzone_pages;
+long    htlbzone_pages;
+long	htlbpage_resv;

 static struct list_head hugepage_freelists[MAX_NUMNODES];
 static spinlock_t htlbpage_lock = SPIN_LOCK_UNLOCKED;
@@ -516,9 +517,11 @@ int hugetlb_report_meminfo(char *buf)
 	return sprintf(buf,
 			"HugePages_Total: %5lu\n"
 			"HugePages_Free:  %5lu\n"
+			"HUgePages_Resv:  %5lu\n"
 			"Hugepagesize:    %5lu kB\n",
 			htlbzone_pages,
 			htlbpagemem,
+			htlbpage_resv,
 			HPAGE_SIZE/1024);
 }

diff -Nurp linux-2.6.5/arch/ia64/mm/hugetlbpage.c linux-2.6.5.htlb/arch/ia64/mm/hugetlbpage.c
--- linux-2.6.5/arch/ia64/mm/hugetlbpage.c	2004-04-03 19:37:07.000000000 -0800
+++ linux-2.6.5.htlb/arch/ia64/mm/hugetlbpage.c	2004-04-05 16:09:41.000000000 -0700
@@ -24,7 +24,8 @@

 static long	htlbpagemem;
 int		htlbpage_max;
-static long	htlbzone_pages;
+long		htlbzone_pages;
+long		htlbpage_resv;
 unsigned int	hpage_shift=HPAGE_SHIFT_DEFAULT;

 static struct list_head hugepage_freelists[MAX_NUMNODES];
@@ -579,9 +580,11 @@ int hugetlb_report_meminfo(char *buf)
 	return sprintf(buf,
 			"HugePages_Total: %5lu\n"
 			"HugePages_Free:  %5lu\n"
+			"HUgePages_Resv:  %5lu\n"
 			"Hugepagesize:    %5lu kB\n",
 			htlbzone_pages,
 			htlbpagemem,
+			htlbpage_resv,
 			HPAGE_SIZE/1024);
 }

diff -Nurp linux-2.6.5/fs/hugetlbfs/inode.c linux-2.6.5.htlb/fs/hugetlbfs/inode.c
--- linux-2.6.5/fs/hugetlbfs/inode.c	2004-04-03 19:38:14.000000000 -0800
+++ linux-2.6.5.htlb/fs/hugetlbfs/inode.c	2004-04-05 16:09:41.000000000 -0700
@@ -43,6 +43,121 @@ static struct backing_dev_info hugetlbfs
 	.memory_backed	= 1,	/* Does not contribute to dirty memory */
 };

+enum file_area_action {
+	INSERT,
+	FRONT_MERGE,
+	BACK_MERGE,
+	THREE_WAY_MERGE
+};
+
+/*
+ * return 0 if reservation is granted
+ */
+static int hugetlb_reserve_page(struct address_space *mapping,
+				struct vm_area_struct *vma)
+{
+	unsigned long block_start, block_end, resv;
+	struct list_head *p, *head;
+	struct file_area_struct *curr, *next;
+	enum file_area_action action;
+	int ret = -ENOMEM;
+
+	block_start = vma->vm_pgoff >> (HPAGE_SHIFT-PAGE_SHIFT);
+	block_end = block_start + ((vma->vm_end - vma->vm_start) >> HPAGE_SHIFT);
+
+	down(&mapping->i_shared_sem);
+
+	action = INSERT;
+	resv = block_end - block_start;
+	head = &mapping->private_list;
+	curr = next = NULL;
+	list_for_each(p, head) {
+		curr = list_entry(p, struct file_area_struct, list);
+		if (p->next != head)
+			next = list_entry(p->next, struct file_area_struct, list);
+
+		if (block_start <= curr->end) {
+			if (block_end <= curr->end) {
+				ret = 0;
+				goto out;
+			} else if (!next || block_end < next->start) {
+				resv = block_end - curr->end;
+				action = BACK_MERGE;
+			} else {
+				resv = next->start - curr->end;
+				action = THREE_WAY_MERGE;
+			}
+		} else if (!next || block_start < next->start) {
+			if (!next || block_end < next->start) {
+				resv = block_end - block_start;
+				action = INSERT;
+			} else {
+				curr = next;
+				resv = curr->start - block_start;
+				action = FRONT_MERGE;
+			}
+		}
+		else
+			continue;
+	}
+
+	/* check page reservation */
+	if (resv > (htlbzone_pages - htlbpage_resv))
+		goto out;
+
+	/* FIXME: check file system quota */
+
+	/* we have enough hugetlb page, go ahead reserve them */
+	switch(action) {
+		case BACK_MERGE:
+			curr->end = block_end;
+			break;
+		case FRONT_MERGE:
+			curr->start = block_start;
+			break;
+		case THREE_WAY_MERGE:
+			curr->end = next->end;
+			list_del(p->next);
+			kfree(next);
+			break;
+		case INSERT:
+			curr = kmalloc(sizeof(*curr), GFP_KERNEL);
+			if (!curr)
+				goto out;
+			curr->start = block_start;
+			curr->end = block_end;
+			list_add(&curr->list, p);
+			break;
+	}
+	htlbpage_resv += resv;
+	ret = 0;
+out:
+	up(&mapping->i_shared_sem);
+	return ret;
+}
+
+static void hugetlb_unreserve_page(struct address_space *mapping, loff_t lstart)
+{
+	struct file_area_struct *curr, *tmp;
+	unsigned long resv;
+
+	lstart >>= HPAGE_SHIFT;
+	down(&mapping->i_shared_sem);
+	list_for_each_entry_safe(curr, tmp, &mapping->private_list, list) {
+		if (lstart <= curr->start) {
+			resv = curr->end - curr->start;
+			list_del(&curr->list);
+			kfree(curr);
+		}
+		else {
+			resv = curr->end - lstart;
+			curr->end = lstart;
+		}
+		htlbpage_resv -= resv;
+	}
+	up(&mapping->i_shared_sem);
+}
+
 static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct inode *inode = file->f_dentry->d_inode;
@@ -59,6 +174,9 @@ static int hugetlbfs_file_mmap(struct fi
 	if (vma->vm_end - vma->vm_start < HPAGE_SIZE)
 		return -EINVAL;

+	if (hugetlb_reserve_page(mapping, vma))
+		return -ENOMEM;
+
 	vma_len = (loff_t)(vma->vm_end - vma->vm_start);

 	down(&inode->i_sem);
@@ -186,6 +304,7 @@ void truncate_hugepages(struct address_s
 		huge_pagevec_release(&pvec);
 	}
 	BUG_ON(!lstart && mapping->nrpages);
+	hugetlb_unreserve_page(mapping, lstart);
 }

 static void hugetlbfs_delete_inode(struct inode *inode)
diff -Nurp linux-2.6.5/include/linux/hugetlb.h linux-2.6.5.htlb/include/linux/hugetlb.h
--- linux-2.6.5/include/linux/hugetlb.h	2004-04-03 19:37:06.000000000 -0800
+++ linux-2.6.5.htlb/include/linux/hugetlb.h	2004-04-05 16:09:41.000000000 -0700
@@ -30,6 +30,8 @@ int is_aligned_hugepage_range(unsigned l
 int pmd_huge(pmd_t pmd);

 extern int htlbpage_max;
+extern long htlbzone_pages;
+extern long htlbpage_resv;

 static inline void
 mark_mm_hugetlb(struct mm_struct *mm, struct vm_area_struct *vma)
@@ -103,6 +105,12 @@ struct hugetlbfs_sb_info {
 	spinlock_t	stat_lock;
 };

+struct file_area_struct {
+	struct list_head	list;
+	unsigned long		start;
+	unsigned long		end;
+};
+
 static inline struct hugetlbfs_sb_info *HUGETLBFS_SB(struct super_block *sb)
 {
 	return sb->s_fs_info;


