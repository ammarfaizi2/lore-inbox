Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbUC2NKo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUC2NJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 08:09:00 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:16910 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S262844AbUC2M31 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 07:29:27 -0500
Date: Mon, 29 Mar 2004 13:30:19 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>, Ray Bryant <raybry@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
cc: anton@samba.org, sds@epoch.ncsc.mil, ak@suse.de,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: Re: [PATCH] [0/6] HUGETLB memory commitment
Message-ID: <11580712.1080567019@42.150.104.212.access.eclipse.net.uk>
In-Reply-To: <98220000.1080501001@[10.10.2.4]>
References: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk>
 <20040325130433.0a61d7ef.akpm@osdl.org>
 <41997489.1080257240@42.150.104.212.access.eclipse.net.uk>
 <4067131A.7000405@sgi.com> <98220000.1080501001@[10.10.2.4]>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="==========76F890F07D76CD187A4C=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========76F890F07D76CD187A4C==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--On 28 March 2004 11:10 -0800 "Martin J. Bligh" <mbligh@aracnet.com> wrote:

> 1. Stop hugepages using the existing overcommit pool for small pages, 
> which breaks small page allocations by prematurely the pool.
> 2. Give hugepages their own over-commit pool, instead of prefaulting.

Indeed.  The previous patches I submitted only address #1.  Attached is
another patch which should address #2, it supplies hugetlb commit
accounting.  This is checked and applied when the segment is created.  It
also supplements the meminfo information to display this new commitment.
The patch only implments strict commitment, but as has been stated here
often, it is not clear that overcommit of unswappable memory makes any
sense in the absence of demand allocation.  When that is implemented then
this will likely need a policy.

Patch applies on top of my previous patch and has been tested on i386.

-apw
--==========76F890F07D76CD187A4C==========
Content-Type: text/plain; charset=iso-8859-1; name="070-hugetlb_commit.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="070-hugetlb_commit.txt"; size=4095

---
 file                    |    1 +
 fs/hugetlbfs/inode.c    |   32 ++++++++++++++++++++++++++++++--
 fs/proc/proc_misc.c     |    1 +
 include/linux/hugetlb.h |    3 +++
 4 files changed, 35 insertions(+), 2 deletions(-)

diff -X /home/apw/lib/vdiff.excl -rupN reference/file current/file
--- reference/file	1970-01-01 01:00:00.000000000 +0100
+++ current/file	2004-03-29 12:10:17.000000000 +0100
@@ -0,0 +1 @@
+this is more text
diff -X /home/apw/lib/vdiff.excl -rupN reference/fs/hugetlbfs/inode.c =
current/fs/hugetlbfs/inode.c
--- reference/fs/hugetlbfs/inode.c	2004-03-25 02:43:00.000000000 +0000
+++ current/fs/hugetlbfs/inode.c	2004-03-29 13:26:57.000000000 +0100
@@ -32,6 +32,25 @@
 /* some random number */
 #define HUGETLBFS_MAGIC	0x958458f6
=20
+atomic_t hugetlb_committed_space =3D ATOMIC_INIT(0);
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
+	long htlb =3D atomic_read(&hugetlb_committed_space);
+	return sprintf(buf, "HugeCommited_AS: %5lu\n", htlb);
+}
+
 static struct super_operations hugetlbfs_ops;
 static struct address_space_operations hugetlbfs_aops;
 struct file_operations hugetlbfs_file_operations;
@@ -200,6 +219,7 @@ static void hugetlbfs_delete_inode(struc
=20
 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
+	hugetlb_acct_memory(-(inode->i_size / PAGE_SIZE));
=20
 	security_inode_delete(inode);
=20
@@ -231,6 +251,8 @@ static void hugetlbfs_forget_inode(struc
 		return;
 	}
=20
+	hugetlb_acct_memory(-(inode->i_size / PAGE_SIZE));
+
 	/* write_inode_now() ? */
 	inodes_stat.nr_unused--;
 	hlist_del_init(&inode->i_hash);
@@ -241,6 +263,7 @@ out_truncate:
 	spin_unlock(&inode_lock);
 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
+	hugetlb_acct_memory(-(inode->i_size / PAGE_SIZE));
=20
 	if (sbinfo->free_inodes >=3D 0) {
 		spin_lock(&sbinfo->stat_lock);
@@ -350,6 +373,10 @@ static int hugetlbfs_setattr(struct dent
 			error =3D hugetlb_vmtruncate(inode, attr->ia_size);
 		if (error)
 			goto out;
+		/* We rely on the fact that the sizes are hugepage aligned,
+		 * and that hugetlb_vmtruncate prevents extend. */
+		hugetlb_acct_memory((attr->ia_size - i_size_read(inode)) /
+			PAGE_SIZE);
 		attr->ia_valid &=3D ~ATTR_SIZE;
 	}
 	error =3D inode_setattr(inode, attr);
@@ -710,8 +737,9 @@ struct file *hugetlb_zero_setup(size_t s
 	if (!capable(CAP_IPC_LOCK))
 		return ERR_PTR(-EPERM);
=20
-	if (!is_hugepage_mem_enough(size))
-		return ERR_PTR(-ENOMEM);
+	error =3D hugetlb_acct_memory(size / PAGE_SIZE);
+	if (error)
+		return ERR_PTR(error);
=20
 	root =3D hugetlbfs_vfsmount->mnt_root;
 	snprintf(buf, 16, "%lu", hugetlbfs_counter());
diff -X /home/apw/lib/vdiff.excl -rupN reference/fs/proc/proc_misc.c =
current/fs/proc/proc_misc.c
--- reference/fs/proc/proc_misc.c	2004-03-29 12:10:18.000000000 +0100
+++ current/fs/proc/proc_misc.c	2004-03-29 13:27:04.000000000 +0100
@@ -232,6 +232,7 @@ static int meminfo_read_proc(char *page,
 		);
=20
 		len +=3D hugetlb_report_meminfo(page + len);
+		len +=3D hugetlbfs_report_meminfo(page + len);
=20
 	return proc_calc_metrics(page, start, off, count, eof, len);
 #undef K
diff -X /home/apw/lib/vdiff.excl -rupN reference/include/linux/hugetlb.h =
current/include/linux/hugetlb.h
--- reference/include/linux/hugetlb.h	2004-03-29 12:10:22.000000000 +0100
+++ current/include/linux/hugetlb.h	2004-03-29 13:22:38.000000000 +0100
@@ -115,11 +115,14 @@ static inline void set_file_hugepages(st
 {
 	file->f_op =3D &hugetlbfs_file_operations;
 }
+int hugetlbfs_report_meminfo(char *);
+
 #else /* !CONFIG_HUGETLBFS */
=20
 #define is_file_hugepages(file)		0
 #define set_file_hugepages(file)	BUG()
 #define hugetlb_zero_setup(size)	ERR_PTR(-ENOSYS)
+#define hugetlbfs_report_meminfo(buf)	0
=20
 #endif /* !CONFIG_HUGETLBFS */
=20

--==========76F890F07D76CD187A4C==========--

