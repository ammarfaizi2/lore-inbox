Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263442AbUCYRAr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 12:00:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263440AbUCYRAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 12:00:03 -0500
Received: from hellhawk.shadowen.org ([212.13.208.175]:53769 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S263424AbUCYQ5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 11:57:23 -0500
Date: Thu, 25 Mar 2004 17:01:07 +0000
From: Andy Whitcroft <apw@shadowen.org>
To: Anton Blanchard <anton@samba.org>, Andrew Morton <akpm@osdl.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
cc: Andi Kleen <ak@suse.de>, raybry@sgi.com, lse-tech@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: [PATCH] [4/6] HUGETLB memory commitment
Message-ID: <18824508.1080234067@42.150.104.212.access.eclipse.net.uk>
In-Reply-To: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk>
References: <18429360.1080233672@42.150.104.212.access.eclipse.net.uk>
X-Mailer: Mulberry/3.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[070-mem_acctdom_hugetlb]

Convert hugetlb to accounting domains (core)

---
 fs/hugetlbfs/inode.c     |   45 ++++++++++++++++++++++++++++++++++++++-------
 include/linux/hugetlb.h  |    5 +++++
 security/commoncap.c     |    9 +++++++++
 security/dummy.c         |    9 +++++++++
 security/selinux/hooks.c |    9 +++++++++
 5 files changed, 70 insertions(+), 7 deletions(-)

diff -upN reference/fs/hugetlbfs/inode.c current/fs/hugetlbfs/inode.c
--- reference/fs/hugetlbfs/inode.c	2004-03-25 02:43:00.000000000 +0000
+++ current/fs/hugetlbfs/inode.c	2004-03-25 15:03:33.000000000 +0000
@@ -26,12 +26,15 @@
 #include <linux/dnotify.h>
 #include <linux/statfs.h>
 #include <linux/security.h>
+#include <linux/mman.h>
 
 #include <asm/uaccess.h>
 
 /* some random number */
 #define HUGETLBFS_MAGIC	0x958458f6
 
+#define VM_ACCT(size)    (PAGE_CACHE_ALIGN(size) >> PAGE_SHIFT)
+
 static struct super_operations hugetlbfs_ops;
 static struct address_space_operations hugetlbfs_aops;
 struct file_operations hugetlbfs_file_operations;
@@ -191,6 +194,7 @@ void truncate_hugepages(struct address_s
 static void hugetlbfs_delete_inode(struct inode *inode)
 {
 	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(inode->i_sb);
+	long change;
 
 	hlist_del_init(&inode->i_hash);
 	list_del_init(&inode->i_list);
@@ -198,6 +202,9 @@ static void hugetlbfs_delete_inode(struc
 	inodes_stat.nr_inodes--;
 	spin_unlock(&inode_lock);
 
+	change = VM_ACCT(inode->i_size) - VM_ACCT(0);
+	if (change)
+		vm_unacct_memory(VM_AD_HUGETLB, change);
 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
 
@@ -217,6 +224,7 @@ static void hugetlbfs_forget_inode(struc
 {
 	struct super_block *super_block = inode->i_sb;
 	struct hugetlbfs_sb_info *sbinfo = HUGETLBFS_SB(super_block);
+	long change;
 
 	if (hlist_unhashed(&inode->i_hash))
 		goto out_truncate;
@@ -239,6 +247,9 @@ out_truncate:
 	inode->i_state |= I_FREEING;
 	inodes_stat.nr_inodes--;
 	spin_unlock(&inode_lock);
+	change = VM_ACCT(inode->i_size) - VM_ACCT(0);
+	if (change)
+		vm_unacct_memory(VM_AD_HUGETLB, change);
 	if (inode->i_data.nrpages)
 		truncate_hugepages(&inode->i_data, 0);
 
@@ -312,8 +323,10 @@ static int hugetlb_vmtruncate(struct ino
 	unsigned long pgoff;
 	struct address_space *mapping = inode->i_mapping;
 
+	/*
 	if (offset > inode->i_size)
 		return -EINVAL;
+	*/
 
 	BUG_ON(offset & ~HPAGE_MASK);
 	pgoff = offset >> HPAGE_SHIFT;
@@ -334,6 +347,8 @@ static int hugetlbfs_setattr(struct dent
 	struct inode *inode = dentry->d_inode;
 	int error;
 	unsigned int ia_valid = attr->ia_valid;
+	long change = 0;
+	loff_t csize;
 
 	BUG_ON(!inode);
 
@@ -345,15 +360,27 @@ static int hugetlbfs_setattr(struct dent
 	if (error)
 		goto out;
 	if (ia_valid & ATTR_SIZE) {
+		csize = i_size_read(inode);
 		error = -EINVAL;
-		if (!(attr->ia_size & ~HPAGE_MASK))
-			error = hugetlb_vmtruncate(inode, attr->ia_size);
-		if (error)
+		if (!(attr->ia_size & ~HPAGE_MASK)) 
+			goto out;
+		if (attr->ia_size > csize)
 			goto out;
+		change = VM_ACCT(csize) - VM_ACCT(attr->ia_size);
+		if (change)
+			vm_unacct_memory(VM_AD_HUGETLB, change);
+		/* XXX: here we commit to removing the mappings, should we do
+		 * this before we attmempt to write the inode or after.  What
+		 * should we do if it fails?
+		 */
+		hugetlb_vmtruncate(inode, attr->ia_size);
 		attr->ia_valid &= ~ATTR_SIZE;
 	}
 	error = inode_setattr(inode, attr);
 out:
+	if (error && change)
+		vm_acct_memory(VM_AD_HUGETLB, change);
+
 	return error;
 }
 
@@ -710,17 +737,19 @@ struct file *hugetlb_zero_setup(size_t s
 	if (!capable(CAP_IPC_LOCK))
 		return ERR_PTR(-EPERM);
 
-	if (!is_hugepage_mem_enough(size))
+	if (security_vm_enough_memory(VM_AD_HUGETLB, VM_ACCT(size)))
 		return ERR_PTR(-ENOMEM);
-
+ 
 	root = hugetlbfs_vfsmount->mnt_root;
 	snprintf(buf, 16, "%lu", hugetlbfs_counter());
 	quick_string.name = buf;
 	quick_string.len = strlen(quick_string.name);
 	quick_string.hash = 0;
 	dentry = d_alloc(root, &quick_string);
-	if (!dentry)
-		return ERR_PTR(-ENOMEM);
+	if (!dentry) {
+		error = -ENOMEM;
+		goto out_committed;
+	}
 
 	error = -ENFILE;
 	file = get_empty_filp();
@@ -747,6 +776,8 @@ out_file:
 	put_filp(file);
 out_dentry:
 	dput(dentry);
+out_committed:
+	vm_unacct_memory(VM_AD_HUGETLB, VM_ACCT(size));
 	return ERR_PTR(error);
 }
 
diff -upN reference/include/linux/hugetlb.h current/include/linux/hugetlb.h
--- reference/include/linux/hugetlb.h	2004-02-23 18:15:09.000000000 +0000
+++ current/include/linux/hugetlb.h	2004-03-25 15:03:33.000000000 +0000
@@ -19,6 +19,7 @@ int hugetlb_prefault(struct address_spac
 void huge_page_release(struct page *);
 int hugetlb_report_meminfo(char *);
 int is_hugepage_mem_enough(size_t);
+unsigned long hugetlb_total_pages(void);
 struct page *follow_huge_addr(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long address, int write);
 struct vm_area_struct *hugepage_vma(struct mm_struct *mm,
@@ -48,6 +49,10 @@ static inline int is_vm_hugetlb_page(str
 {
 	return 0;
 }
+static inline unsigned long hugetlb_total_pages(void)
+{
+	return 0;
+}
 
 #define follow_hugetlb_page(m,v,p,vs,a,b,i)	({ BUG(); 0; })
 #define follow_huge_addr(mm, vma, addr, write)	0
diff -upN reference/security/commoncap.c current/security/commoncap.c
--- reference/security/commoncap.c	2004-03-25 15:03:32.000000000 +0000
+++ current/security/commoncap.c	2004-03-25 15:03:33.000000000 +0000
@@ -22,6 +22,7 @@
 #include <linux/netlink.h>
 #include <linux/ptrace.h>
 #include <linux/xattr.h>
+#include <linux/hugetlb.h>
 
 int cap_capable (struct task_struct *tsk, int cap)
 {
@@ -314,6 +315,13 @@ int cap_vm_enough_memory(int domain, lon
 
 	vm_acct_memory(domain, pages);
 
+	/* Check against the full compliment of hugepages, no reserve. */
+	if (domain == VM_AD_HUGETLB) {
+		allowed = hugetlb_total_pages();
+
+		goto check;
+	}
+
 	/* We only account for the default memory domain, assume overcommit
 	 * for all others.
 	 */
@@ -367,6 +375,7 @@ int cap_vm_enough_memory(int domain, lon
 	allowed = totalram_pages * sysctl_overcommit_ratio / 100;
 	allowed += total_swap_pages;
 
+check:
 	if (atomic_read(&vm_committed_space[domain]) < allowed)
 		return 0;
 
diff -upN reference/security/dummy.c current/security/dummy.c
--- reference/security/dummy.c	2004-03-25 15:03:32.000000000 +0000
+++ current/security/dummy.c	2004-03-25 15:03:33.000000000 +0000
@@ -25,6 +25,7 @@
 #include <linux/netlink.h>
 #include <net/sock.h>
 #include <linux/xattr.h>
+#include <linux/hugetlb.h>
 
 static int dummy_ptrace (struct task_struct *parent, struct task_struct *child)
 {
@@ -115,6 +116,13 @@ static int dummy_vm_enough_memory(int do
 
 	vm_acct_memory(domain, pages);
 
+	/* Check against the full compliment of hugepages, no reserve. */
+	if (domain == VM_AD_HUGETLB) {
+		allowed = hugetlb_total_pages();
+
+		goto check;
+	}
+
 	/* We only account for the default memory domain, assume overcommit
 	 * for all others.
 	 */
@@ -155,6 +163,7 @@ static int dummy_vm_enough_memory(int do
 	allowed = totalram_pages * sysctl_overcommit_ratio / 100;
 	allowed += total_swap_pages;
 
+check:
 	if (atomic_read(&vm_committed_space[domain]) < allowed)
 		return 0;
 
diff -upN reference/security/selinux/hooks.c current/security/selinux/hooks.c
--- reference/security/selinux/hooks.c	2004-03-25 15:03:32.000000000 +0000
+++ current/security/selinux/hooks.c	2004-03-25 15:03:33.000000000 +0000
@@ -59,6 +59,7 @@
 #include <net/af_unix.h>	/* for Unix socket types */
 #include <linux/parser.h>
 #include <linux/nfs_mount.h>
+#include <linux/hugetlb.h>
 
 #include "avc.h"
 #include "objsec.h"
@@ -1504,6 +1505,13 @@ static int selinux_vm_enough_memory(int 
 
 	vm_acct_memory(domain, pages);
 
+	/* Check against the full compliment of hugepages, no reserve. */
+	if (domain == VM_AD_HUGETLB) {
+		allowed = hugetlb_total_pages();
+
+		goto check;
+	}
+
 	/* We only account for the default memory domain, assume overcommit
 	 * for all others.
 	 */
@@ -1553,6 +1561,7 @@ static int selinux_vm_enough_memory(int 
 	allowed = totalram_pages * sysctl_overcommit_ratio / 100;
 	allowed += total_swap_pages;
 
+check:
 	if (atomic_read(&vm_committed_space[domain]) < allowed)
 		return 0;
 

