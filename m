Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbUC3Mze (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 07:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263640AbUC3Mze
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 07:55:34 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:4624 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S263639AbUC3MzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 07:55:05 -0500
Date: Tue, 30 Mar 2004 13:57:39 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Ray Bryant <raybry@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
cc: anton@samba.org, sds@epoch.ncsc.mil, ak@suse.de,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: RE: [PATCH] [0/6] HUGETLB memory commitment
Message-ID: <20541286.1080655059@42.150.104.212.access.eclipse.net.uk>
In-Reply-To: <200403292045.i2TKjnF11402@unix-os.sc.intel.com> <200403292049.i2TKnvF11443@unix-os.sc.intel.com>
References: <200403292045.i2TKjnF11402@unix-os.sc.intel.com>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="==========AF2C5D3E3B31FCFA5320=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========AF2C5D3E3B31FCFA5320==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--On 29 March 2004 12:45 -0800 "Chen, Kenneth W" <kenneth.w.chen@intel.com> wrote:

> +int hugetlbfs_report_meminfo(char *buf)
> +{
> +	long htlb = atomic_read(&hugetlb_committed_space);
> +	return sprintf(buf, "HugeCommited_AS: %5lu\n", htlb);
> +}
> 
> "HugeCommited_AS", typo?? Should that be double "t"?  Also can we print
> in terms of kB instead of num pages to match all other entries? Something
> Like: htlb<<(PAGE_SHIFT-10)?

Doh and Doh.  Yes, we went though a stage where this was in hugetlb
pages, but it has ended up in the same units as the small page
pool.  Attached is a replacement patch with this changed, below
is a relative diff against the previous patch.

> overcomit is not checked for hugetlb mmap, is it intentional here?

> Just to follow up myself, I meant overcommit accounting is not done
> for mmap hugetlb page.  (typical Monday morning symptom :))

Essentially, hugetlb pages can only be part of a shared mapping in
the current implementation.  As a result all commitments are made
and checked at segment create time.  The commitment cannot change.

Hope that's what you meant.

Martin, perhaps this is a candidate for your -mjb tree?

-apw

diff -X /home/apw/lib/vdiff.excl -rupN reference/fs/hugetlbfs/inode.c current/fs/hugetlbfs/inode.c
--- reference/fs/hugetlbfs/inode.c	2004-03-29 14:05:22.000000000 +0100
+++ current/fs/hugetlbfs/inode.c	2004-03-30 09:52:59.000000000 +0100
@@ -47,8 +47,10 @@ int hugetlb_acct_memory(long delta)
 
 int hugetlbfs_report_meminfo(char *buf)
 {
+#define K(x) ((x) << (PAGE_SHIFT - 10))
 	long htlb = atomic_read(&hugetlb_committed_space);
-	return sprintf(buf, "HugeCommited_AS: %5lu\n", htlb);
+	return sprintf(buf, "HugeCommitted_AS: %5lu kB\n", K(htlb));
+#undef K
 }
 
 static struct super_operations hugetlbfs_ops;


--==========AF2C5D3E3B31FCFA5320==========
Content-Type: text/plain; charset=us-ascii; name="070-hugetlb_commit.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="070-hugetlb_commit.txt"; size=4031

---
 file                    |    1 +
 fs/hugetlbfs/inode.c    |   34 ++++++++++++++++++++++++++++++++--
 fs/proc/proc_misc.c     |    1 +
 include/linux/hugetlb.h |    3 +++
 4 files changed, 37 insertions(+), 2 deletions(-)

diff -upN /dev/null current/file
--- /dev/null	2002-08-31 00:31:37.000000000 +0100
+++ current/file	2004-03-30 14:39:12.000000000 +0100
@@ -0,0 +1 @@
+this is more text
diff -upN reference/fs/hugetlbfs/inode.c current/fs/hugetlbfs/inode.c
--- reference/fs/hugetlbfs/inode.c	2004-03-25 02:43:00.000000000 +0000
+++ current/fs/hugetlbfs/inode.c	2004-03-30 14:39:12.000000000 +0100
@@ -32,6 +32,27 @@
 /* some random number */
 #define HUGETLBFS_MAGIC	0x958458f6
 
+atomic_t hugetlb_committed_space = ATOMIC_INIT(0);
+
+int hugetlb_acct_memory(long delta)
+{
+	atomic_add(delta, &hugetlb_committed_space);
+	if (delta > 0 && atomic_read(&hugetlb_committed_space) >
+			hugetlb_total_pages()) {
+		atomic_add(-delta, &hugetlb_committed_space);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
+int hugetlbfs_report_meminfo(char *buf)
+{
+#define K(x) ((x) << (PAGE_SHIFT - 10))
+	long htlb = atomic_read(&hugetlb_committed_space);
+	return sprintf(buf, "HugeCommitted_AS: %5lu kB\n", K(htlb));
+#undef K
+}
+
 static struct super_operations hugetlbfs_ops;
 static struct address_space_operations hugetlbfs_aops;
 struct file_operations hugetlbfs_file_operations;
@@ -200,6 +221,7 @@ static void hugetlbfs_delete_inode(struc
 
 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
+	hugetlb_acct_memory(-(inode->i_size / PAGE_SIZE));
 
 	security_inode_delete(inode);
 
@@ -231,6 +253,8 @@ static void hugetlbfs_forget_inode(struc
 		return;
 	}
 
+	hugetlb_acct_memory(-(inode->i_size / PAGE_SIZE));
+
 	/* write_inode_now() ? */
 	inodes_stat.nr_unused--;
 	hlist_del_init(&inode->i_hash);
@@ -241,6 +265,7 @@ out_truncate:
 	spin_unlock(&inode_lock);
 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
+	hugetlb_acct_memory(-(inode->i_size / PAGE_SIZE));
 
 	if (sbinfo->free_inodes >= 0) {
 		spin_lock(&sbinfo->stat_lock);
@@ -350,6 +375,10 @@ static int hugetlbfs_setattr(struct dent
 			error = hugetlb_vmtruncate(inode, attr->ia_size);
 		if (error)
 			goto out;
+		/* We rely on the fact that the sizes are hugepage aligned,
+		 * and that hugetlb_vmtruncate prevents extend. */
+		hugetlb_acct_memory((attr->ia_size - i_size_read(inode)) /
+			PAGE_SIZE);
 		attr->ia_valid &= ~ATTR_SIZE;
 	}
 	error = inode_setattr(inode, attr);
@@ -710,8 +739,9 @@ struct file *hugetlb_zero_setup(size_t s
 	if (!capable(CAP_IPC_LOCK))
 		return ERR_PTR(-EPERM);
 
-	if (!is_hugepage_mem_enough(size))
-		return ERR_PTR(-ENOMEM);
+	error = hugetlb_acct_memory(size / PAGE_SIZE);
+	if (error)
+		return ERR_PTR(error);
 
 	root = hugetlbfs_vfsmount->mnt_root;
 	snprintf(buf, 16, "%lu", hugetlbfs_counter());
diff -upN reference/fs/proc/proc_misc.c current/fs/proc/proc_misc.c
--- reference/fs/proc/proc_misc.c	2004-03-30 14:39:06.000000000 +0100
+++ current/fs/proc/proc_misc.c	2004-03-30 14:39:12.000000000 +0100
@@ -232,6 +232,7 @@ static int meminfo_read_proc(char *page,
 		);
 
 		len += hugetlb_report_meminfo(page + len);
+		len += hugetlbfs_report_meminfo(page + len);
 
 	return proc_calc_metrics(page, start, off, count, eof, len);
 #undef K
diff -upN reference/include/linux/hugetlb.h current/include/linux/hugetlb.h
--- reference/include/linux/hugetlb.h	2004-03-30 14:39:11.000000000 +0100
+++ current/include/linux/hugetlb.h	2004-03-30 14:39:12.000000000 +0100
@@ -115,11 +115,14 @@ static inline void set_file_hugepages(st
 {
 	file->f_op = &hugetlbfs_file_operations;
 }
+int hugetlbfs_report_meminfo(char *);
+
 #else /* !CONFIG_HUGETLBFS */
 
 #define is_file_hugepages(file)		0
 #define set_file_hugepages(file)	BUG()
 #define hugetlb_zero_setup(size)	ERR_PTR(-ENOSYS)
+#define hugetlbfs_report_meminfo(buf)	0
 
 #endif /* !CONFIG_HUGETLBFS */
 

--==========AF2C5D3E3B31FCFA5320==========--

