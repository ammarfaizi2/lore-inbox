Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbWDNCX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbWDNCX6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 22:23:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965093AbWDNCX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 22:23:58 -0400
Received: from mga01.intel.com ([192.55.52.88]:53886 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S965092AbWDNCX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 22:23:57 -0400
X-IronPort-AV: i="4.04,119,1144047600"; 
   d="scan'208"; a="23807078:sNHT20703396"
Subject: Re: [PATCH 3/8] IA64 various hugepage size - Add a mount option to
	hugetlbfs
From: Zou Nan hai <nanhai.zou@intel.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linux-IA64 <linux-ia64@vger.kernel.org>, Tony <tony.luck@intel.com>,
       Kenneth W <kenneth.w.chen@intel.com>
In-Reply-To: <1144974881.5817.59.camel@linux-znh>
References: <1144974367.5817.39.camel@linux-znh>
	 <1144974667.5817.51.camel@linux-znh>  <1144974881.5817.59.camel@linux-znh>
Content-Type: text/plain
Organization: 
Message-Id: <1144975292.5817.74.camel@linux-znh>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 14 Apr 2006 08:41:32 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a mount option page_size= to hugetlbfs.
The s_blocksize_bits in hugetlb super block will indicate the huge page size which attached 
to this fs.

Signed-off-by: Zou Nan hai <nanhai.zou@intel.com>

diff -Nraup a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
--- a/fs/hugetlbfs/inode.c	2006-04-11 08:51:59.000000000 +0800
+++ b/fs/hugetlbfs/inode.c	2006-04-11 10:55:49.000000000 +0800
@@ -63,6 +63,14 @@ static int hugetlbfs_file_mmap(struct fi
 	loff_t len, vma_len;
 	int ret;
 
+#ifdef ARCH_HAS_VARIABLE_HUGEPAGE_SIZE
+        struct super_block *sb = inode->i_sb;
+        unsigned long hpage_shift = sb->s_blocksize_bits;
+
+        if (hpage_shift != vma->vm_mm->hugepage_shift)
+                return -EINVAL;
+#endif
+
 	if (vma->vm_pgoff & (HPAGE_SIZE / PAGE_SIZE - 1))
 		return -EINVAL;
 
@@ -632,7 +640,17 @@ hugetlbfs_parse_options(char *options, s
 			size &= HPAGE_MASK;
 			pconfig->nr_blocks = (size >> HPAGE_SHIFT);
 			value = rest;
-		} else if (!strcmp(opt,"nr_inodes")) {
+		}
+#ifdef ARCH_HAS_VARIABLE_HUGEPAGE_SIZE
+                else if (!strcmp(opt, "page_size")) {
+                        unsigned long long size = memparse(value, &rest);
+                        if (!is_valid_hpage_size(size))
+                                return -EINVAL;
+                        pconfig->page_shift = __ffs(size);
+                        value = rest;
+                }
+#endif
+		else if (!strcmp(opt,"nr_inodes")) {
 			pconfig->nr_inodes = memparse(value, &rest);
 			value = rest;
 		} else
@@ -658,6 +676,7 @@ hugetlbfs_fill_super(struct super_block 
 	config.uid = current->fsuid;
 	config.gid = current->fsgid;
 	config.mode = 0755;
+	config.page_shift = HPAGE_SHIFT;
 	ret = hugetlbfs_parse_options(data, &config);
 
 	if (ret)
@@ -673,8 +692,8 @@ hugetlbfs_fill_super(struct super_block 
 	sbinfo->max_inodes = config.nr_inodes;
 	sbinfo->free_inodes = config.nr_inodes;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
-	sb->s_blocksize = HPAGE_SIZE;
-	sb->s_blocksize_bits = HPAGE_SHIFT;
+	sb->s_blocksize = 1UL << config.page_shift;
+	sb->s_blocksize_bits = config.page_shift;
 	sb->s_magic = HUGETLBFS_MAGIC;
 	sb->s_op = &hugetlbfs_ops;
 	sb->s_time_gran = 1;
diff -Nraup a/include/linux/hugetlb.h b/include/linux/hugetlb.h
--- a/include/linux/hugetlb.h	2006-04-11 08:52:00.000000000 +0800
+++ b/include/linux/hugetlb.h	2006-04-11 10:51:41.000000000 +0800
@@ -124,6 +124,7 @@ struct hugetlbfs_config {
 	uid_t   uid;
 	gid_t   gid;
 	umode_t mode;
+	int     page_shift;
 	long	nr_blocks;
 	long	nr_inodes;
 };

