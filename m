Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbUCaBtv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 20:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261430AbUCaBtv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 20:49:51 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:20497 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S261426AbUCaBtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 20:49:36 -0500
Date: Wed, 31 Mar 2004 02:48:37 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Ray Bryant <raybry@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
cc: anton@samba.org, sds@epoch.ncsc.mil, ak@suse.de,
       lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: RE: [PATCH] [0/6] HUGETLB memory commitment
Message-ID: <27832908.1080701317@[192.168.0.89]>
In-Reply-To: <13395305.1080686882@[192.168.0.89]>
References: <200403302004.i2UK4JF23059@unix-os.sc.intel.com>
 <13395305.1080686882@[192.168.0.89]>
X-Mailer: Mulberry/3.1.0 (Win32)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="==========B9B730DCE148742FE34D=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========B9B730DCE148742FE34D==========
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--On 30 March 2004 22:48 +0100 Andy Whitcroft <apw@shadowen.org> wrote:

>> I can do:
>> 	fd = open("/mnt/htlb/myhtlbfile", O_CREAT|O_RDWR, 0755);
>> 	mmap(..., fd, offset);
>>
>> Accounting didn't happen in this case, (grep Huge /proc/meminfo):

O.k.  Try this one.  Should fix that case.  There is some uglyness in there 
which needs review, but my testing says this works.

Thanks for testing.

-apw
--==========B9B730DCE148742FE34D==========
Content-Type: text/plain; charset=iso-8859-1; name="070-hugetlb_commit.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename="070-hugetlb_commit.txt"; size=4634

---
 file                    |    1 +
 fs/hugetlbfs/inode.c    |   41 ++++++++++++++++++++++++++++++++++++++---
 fs/proc/proc_misc.c     |    1 +
 include/linux/hugetlb.h |    3 +++
 4 files changed, 43 insertions(+), 3 deletions(-)

diff -X /home/apw/lib/vdiff.excl -rupN reference/file current/file
--- reference/file	1970-01-01 01:00:00.000000000 +0100
+++ current/file	2004-03-30 14:39:12.000000000 +0100
@@ -0,0 +1 @@
+this is more text
diff -X /home/apw/lib/vdiff.excl -rupN reference/fs/hugetlbfs/inode.c =
current/fs/hugetlbfs/inode.c
--- reference/fs/hugetlbfs/inode.c	2004-03-25 02:43:00.000000000 +0000
+++ current/fs/hugetlbfs/inode.c	2004-03-31 02:18:03.000000000 +0100
@@ -32,6 +32,27 @@
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
+#define K(x) ((x) << (PAGE_SHIFT - 10))
+	long htlb =3D atomic_read(&hugetlb_committed_space);
+	return sprintf(buf, "HugeCommitted_AS: %5lu kB\n", K(htlb));
+#undef K
+}
+
 static struct super_operations hugetlbfs_ops;
 static struct address_space_operations hugetlbfs_aops;
 struct file_operations hugetlbfs_file_operations;
@@ -62,13 +83,20 @@ static int hugetlbfs_file_mmap(struct fi
 	vma_len =3D (loff_t)(vma->vm_end - vma->vm_start);
=20
 	down(&inode->i_sem);
+	len =3D vma_len +	((loff_t)vma->vm_pgoff << PAGE_SHIFT);
+	/* This represents an extend to the file. */
+	if (inode->i_size < len) {
+		ret =3D hugetlb_acct_memory((len - inode->i_size) / PAGE_SIZE);
+		if (ret)
+			goto out_isem;
+	}
 	file_accessed(file);
 	vma->vm_flags |=3D VM_HUGETLB | VM_RESERVED;
 	vma->vm_ops =3D &hugetlb_vm_ops;
 	ret =3D hugetlb_prefault(mapping, vma);
-	len =3D vma_len +	((loff_t)vma->vm_pgoff << PAGE_SHIFT);
 	if (ret =3D=3D 0 && inode->i_size < len)
 		inode->i_size =3D len;
+out_isem:
 	up(&inode->i_sem);
=20
 	return ret;
@@ -200,6 +228,7 @@ static void hugetlbfs_delete_inode(struc
=20
 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
+	hugetlb_acct_memory(-(inode->i_size / PAGE_SIZE));
=20
 	security_inode_delete(inode);
=20
@@ -241,6 +270,7 @@ out_truncate:
 	spin_unlock(&inode_lock);
 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
+	hugetlb_acct_memory(-(inode->i_size / PAGE_SIZE));
=20
 	if (sbinfo->free_inodes >=3D 0) {
 		spin_lock(&sbinfo->stat_lock);
@@ -350,6 +380,10 @@ static int hugetlbfs_setattr(struct dent
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
@@ -710,8 +744,9 @@ struct file *hugetlb_zero_setup(size_t s
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
+++ current/fs/proc/proc_misc.c	2004-03-30 14:39:12.000000000 +0100
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
+++ current/include/linux/hugetlb.h	2004-03-30 14:39:12.000000000 +0100
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

--==========B9B730DCE148742FE34D==========--

