Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261792AbUC0P1U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 10:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbUC0P1U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 10:27:20 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56997 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261793AbUC0P01
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 10:26:27 -0500
Date: Sat, 27 Mar 2004 15:26:23 +0000
From: Matthew Wilcox <willy@debian.org>
To: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] compat_sys_mount
Message-ID: <20040327152623.GM25059@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch replaces 6 implementations of various quality of sys32_mount
with a shiny new compat_sys_mount().  It's been tested on parisc64 and
sparc64 and fixes a bug exposed by the latest revision of Debian's
initscripts.  Thanks to Arnd Bergmann and Dave Miller for their
suggestions, fixes and testing.  Please apply.

 arch/ia64/ia32/ia32_entry.S        |    2 
 arch/ia64/ia32/sys_ia32.c          |  154 ---------------------------
 arch/parisc/kernel/sys_parisc32.c  |   99 -----------------
 arch/parisc/kernel/syscall_table.S |    2 
 arch/ppc64/kernel/misc.S           |    2 
 arch/ppc64/kernel/sys_ppc32.c      |  206 -------------------------------------
 arch/s390/kernel/compat_linux.c    |  154 ---------------------------
 arch/s390/kernel/compat_wrapper.S  |    2 
 arch/sparc64/kernel/sys_sparc32.c  |  206 -------------------------------------
 arch/sparc64/kernel/systbls.S      |    2 
 arch/x86_64/ia32/ia32entry.S       |    2 
 arch/x86_64/ia32/sys_ia32.c        |   36 ------
 fs/compat.c                        |  152 +++++++++++++++++++++++++++
 fs/namespace.c                     |    2 
 include/net/scm.h                  |    1 
 15 files changed, 160 insertions(+), 862 deletions(-)

Index: arch/ia64/ia32/ia32_entry.S
===================================================================
RCS file: /var/cvs/linux-2.6/arch/ia64/ia32/ia32_entry.S,v
retrieving revision 1.5
diff -u -p -r1.5 ia32_entry.S
--- a/arch/ia64/ia32/ia32_entry.S	7 Jan 2004 21:30:05 -0000	1.5
+++ b/arch/ia64/ia32/ia32_entry.S	26 Mar 2004 19:05:24 -0000
@@ -229,7 +229,7 @@ ia32_syscall_table:
 	data8 sys_ni_syscall
 	data8 sys32_lseek
 	data8 sys_getpid	  /* 20 */
-	data8 sys_mount
+	data8 compat_sys_mount
 	data8 sys_oldumount
 	data8 sys_setuid	/* 16-bit version */
 	data8 sys_getuid	/* 16-bit version */
Index: arch/ia64/ia32/sys_ia32.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/ia64/ia32/sys_ia32.c,v
retrieving revision 1.12
diff -u -p -r1.12 sys_ia32.c
--- a/arch/ia64/ia32/sys_ia32.c	16 Mar 2004 15:39:51 -0000	1.12
+++ b/arch/ia64/ia32/sys_ia32.c	26 Mar 2004 19:05:24 -0000
@@ -34,9 +34,6 @@
 #include <linux/slab.h>
 #include <linux/uio.h>
 #include <linux/nfs_fs.h>
-#include <linux/smb_fs.h>
-#include <linux/smb_mount.h>
-#include <linux/ncp_fs.h>
 #include <linux/quota.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
@@ -2383,157 +2380,6 @@ long sys32_fadvise64_64(int fd, __u32 of
 } 
 
 #ifdef	NOTYET  /* UNTESTED FOR IA64 FROM HERE DOWN */
-
-struct ncp_mount_data32 {
-	int version;
-	unsigned int ncp_fd;
-	compat_uid_t mounted_uid;
-	int wdog_pid;
-	unsigned char mounted_vol[NCP_VOLNAME_LEN + 1];
-	unsigned int time_out;
-	unsigned int retry_count;
-	unsigned int flags;
-	compat_uid_t uid;
-	compat_gid_t gid;
-	compat_mode_t file_mode;
-	compat_mode_t dir_mode;
-};
-
-static void *
-do_ncp_super_data_conv(void *raw_data)
-{
-	struct ncp_mount_data *n = (struct ncp_mount_data *)raw_data;
-	struct ncp_mount_data32 *n32 = (struct ncp_mount_data32 *)raw_data;
-
-	n->dir_mode = n32->dir_mode;
-	n->file_mode = n32->file_mode;
-	n->gid = n32->gid;
-	n->uid = n32->uid;
-	memmove (n->mounted_vol, n32->mounted_vol,
-		 (sizeof (n32->mounted_vol) + 3 * sizeof (unsigned int)));
-	n->wdog_pid = n32->wdog_pid;
-	n->mounted_uid = n32->mounted_uid;
-	return raw_data;
-}
-
-struct smb_mount_data32 {
-	int version;
-	compat_uid_t mounted_uid;
-	compat_uid_t uid;
-	compat_gid_t gid;
-	compat_mode_t file_mode;
-	compat_mode_t dir_mode;
-};
-
-static void *
-do_smb_super_data_conv(void *raw_data)
-{
-	struct smb_mount_data *s = (struct smb_mount_data *)raw_data;
-	struct smb_mount_data32 *s32 = (struct smb_mount_data32 *)raw_data;
-
-	if (s32->version != SMB_MOUNT_OLDVERSION)
-		goto out;
-	s->version = s32->version;
-	s->mounted_uid = s32->mounted_uid;
-	s->uid = s32->uid;
-	s->gid = s32->gid;
-	s->file_mode = s32->file_mode;
-	s->dir_mode = s32->dir_mode;
-out:
-	return raw_data;
-}
-
-static int
-copy_mount_stuff_to_kernel(const void *user, unsigned long *kernel)
-{
-	int i;
-	unsigned long page;
-	struct vm_area_struct *vma;
-
-	*kernel = 0;
-	if(!user)
-		return 0;
-	vma = find_vma(current->mm, (unsigned long)user);
-	if(!vma || (unsigned long)user < vma->vm_start)
-		return -EFAULT;
-	if(!(vma->vm_flags & VM_READ))
-		return -EFAULT;
-	i = vma->vm_end - (unsigned long) user;
-	if(PAGE_SIZE <= (unsigned long) i)
-		i = PAGE_SIZE - 1;
-	if(!(page = __get_free_page(GFP_KERNEL)))
-		return -ENOMEM;
-	if(copy_from_user((void *) page, user, i)) {
-		free_page(page);
-		return -EFAULT;
-	}
-	*kernel = page;
-	return 0;
-}
-
-#define SMBFS_NAME	"smbfs"
-#define NCPFS_NAME	"ncpfs"
-
-asmlinkage long
-sys32_mount(char *dev_name, char *dir_name, char *type,
-	    unsigned long new_flags, u32 data)
-{
-	unsigned long type_page;
-	int err, is_smb, is_ncp;
-
-	if(!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	is_smb = is_ncp = 0;
-	err = copy_mount_stuff_to_kernel((const void *)type, &type_page);
-	if(err)
-		return err;
-	if(type_page) {
-		is_smb = !strcmp((char *)type_page, SMBFS_NAME);
-		is_ncp = !strcmp((char *)type_page, NCPFS_NAME);
-	}
-	if(!is_smb && !is_ncp) {
-		if(type_page)
-			free_page(type_page);
-		return sys_mount(dev_name, dir_name, type, new_flags,
-				 (void *)AA(data));
-	} else {
-		unsigned long dev_page, dir_page, data_page;
-
-		err = copy_mount_stuff_to_kernel((const void *)dev_name,
-						 &dev_page);
-		if(err)
-			goto out;
-		err = copy_mount_stuff_to_kernel((const void *)dir_name,
-						 &dir_page);
-		if(err)
-			goto dev_out;
-		err = copy_mount_stuff_to_kernel((const void *)AA(data),
-						 &data_page);
-		if(err)
-			goto dir_out;
-		if(is_ncp)
-			do_ncp_super_data_conv((void *)data_page);
-		else if(is_smb)
-			do_smb_super_data_conv((void *)data_page);
-		else
-			panic("The problem is here...");
-		err = do_mount((char *)dev_page, (char *)dir_page,
-				(char *)type_page, new_flags,
-				(void *)data_page);
-		if(data_page)
-			free_page(data_page);
-	dir_out:
-		if(dir_page)
-			free_page(dir_page);
-	dev_out:
-		if(dev_page)
-			free_page(dev_page);
-	out:
-		if(type_page)
-			free_page(type_page);
-		return err;
-	}
-}
 
 asmlinkage long sys32_setreuid(compat_uid_t ruid, compat_uid_t euid)
 {
Index: arch/parisc/kernel/sys_parisc32.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/parisc/kernel/sys_parisc32.c,v
retrieving revision 1.13
diff -u -p -r1.13 sys_parisc32.c
--- a/arch/parisc/kernel/sys_parisc32.c	28 Feb 2004 01:50:19 -0000	1.13
+++ b/arch/parisc/kernel/sys_parisc32.c	26 Mar 2004 19:05:25 -0000
@@ -607,105 +607,6 @@ out:
 	return error;
 }
 
-static int copy_mount_stuff_to_kernel(const void *user, unsigned long *kernel)
-{
-	int i;
-	unsigned long page;
-	struct vm_area_struct *vma;
-
-	*kernel = 0;
-	if(!user)
-		return 0;
-	vma = find_vma(current->mm, (unsigned long)user);
-	if(!vma || (unsigned long)user < vma->vm_start)
-		return -EFAULT;
-	if(!(vma->vm_flags & VM_READ))
-		return -EFAULT;
-	i = vma->vm_end - (unsigned long) user;
-	if(PAGE_SIZE <= (unsigned long) i)
-		i = PAGE_SIZE - 1;
-	if(!(page = __get_free_page(GFP_KERNEL)))
-		return -ENOMEM;
-	if(copy_from_user((void *) page, user, i)) {
-		free_page(page);
-		return -EFAULT;
-	}
-	*kernel = page;
-	return 0;
-}
-
-#define SMBFS_NAME	"smbfs"
-#define NCPFS_NAME	"ncpfs"
-
-asmlinkage int sys32_mount(char *dev_name, char *dir_name, char *type, unsigned long new_flags, u32 data)
-{
-	unsigned long type_page = 0;
-	unsigned long data_page = 0;
-	unsigned long dev_page = 0;
-	unsigned long dir_page = 0;
-	int err, is_smb, is_ncp;
-
-	is_smb = is_ncp = 0;
-
-	err = copy_mount_stuff_to_kernel((const void *)type, &type_page);
-	if (err)
-		goto out;
-
-	if (!type_page) {
-		err = -EINVAL;
-		goto out;
-	}
-
-	is_smb = !strcmp((char *)type_page, SMBFS_NAME);
-	is_ncp = !strcmp((char *)type_page, NCPFS_NAME);
-
-	err = copy_mount_stuff_to_kernel((const void *)(unsigned long)data, &data_page);
-	if (err)
-		goto type_out;
-
-	err = copy_mount_stuff_to_kernel(dev_name, &dev_page);
-	if (err)
-		goto data_out;
-
-	err = copy_mount_stuff_to_kernel(dir_name, &dir_page);
-	if (err)
-		goto dev_out;
-
-	if (!is_smb && !is_ncp) {
-		lock_kernel();
-		err = do_mount((char*)dev_page, (char*)dir_page,
-				(char*)type_page, new_flags, (char*)data_page);
-		unlock_kernel();
-	} else {
-		if (is_ncp)
-			panic("NCP mounts not yet supported 32/64 parisc");
-			/* do_ncp_super_data_conv((void *)data_page); */
-		else {
-			panic("SMB mounts not yet supported 32/64 parisc");
-			/* do_smb_super_data_conv((void *)data_page); */
-		}
-
-		lock_kernel();
-		err = do_mount((char*)dev_page, (char*)dir_page,
-				(char*)type_page, new_flags, (char*)data_page);
-		unlock_kernel();
-	}
-	free_page(dir_page);
-
-dev_out:
-	free_page(dev_page);
-
-data_out:
-	free_page(data_page);
-
-type_out:
-	free_page(type_page);
-
-out:
-	return err;
-}
-
-
 /* readv/writev stolen from mips64 */
 typedef ssize_t (*IO_fn_t)(struct file *, char *, size_t, loff_t *);
 
Index: arch/parisc/kernel/syscall_table.S
===================================================================
RCS file: /var/cvs/linux-2.6/arch/parisc/kernel/syscall_table.S,v
retrieving revision 1.5
diff -u -p -r1.5 syscall_table.S
--- a/arch/parisc/kernel/syscall_table.S	19 Jan 2004 05:15:47 -0000	1.5
+++ b/arch/parisc/kernel/syscall_table.S	26 Mar 2004 19:05:25 -0000
@@ -84,7 +84,7 @@
 	ENTRY_DIFF(lseek)
 	ENTRY_SAME(getpid)		/* 20 */
 	/* the 'void * data' parameter may need re-packing in wide */
-	ENTRY_DIFF(mount)
+	ENTRY_COMP(mount)
 	/* concerned about struct sockaddr in wide/narrow */
 	/* ---> I think sockaddr is OK unless the compiler packs the struct */
 	/*      differently to align the char array */
Index: arch/ppc64/kernel/misc.S
===================================================================
RCS file: /var/cvs/linux-2.6/arch/ppc64/kernel/misc.S,v
retrieving revision 1.8
diff -u -p -r1.8 misc.S
--- a/arch/ppc64/kernel/misc.S	20 Mar 2004 20:29:26 -0000	1.8
+++ b/arch/ppc64/kernel/misc.S	26 Mar 2004 19:05:26 -0000
@@ -593,7 +593,7 @@ _GLOBAL(sys_call_table32)
 	.llong .sys_ni_syscall		/* old stat syscall */
 	.llong .ppc32_lseek
 	.llong .sys_getpid              /* 20 */
-	.llong .sys32_mount
+	.llong .compat_sys_mount
 	.llong .sys_oldumount
 	.llong .sys_setuid
 	.llong .sys_getuid
Index: arch/ppc64/kernel/sys_ppc32.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/ppc64/kernel/sys_ppc32.c,v
retrieving revision 1.9
diff -u -p -r1.9 sys_ppc32.c
--- a/arch/ppc64/kernel/sys_ppc32.c	20 Mar 2004 20:29:27 -0000	1.9
+++ b/arch/ppc64/kernel/sys_ppc32.c	26 Mar 2004 19:05:26 -0000
@@ -35,9 +35,6 @@
 #include <linux/uio.h>
 #include <linux/aio.h>
 #include <linux/nfs_fs.h>
-#include <linux/smb_fs.h>
-#include <linux/smb_mount.h>
-#include <linux/ncp_fs.h>
 #include <linux/module.h>
 #include <linux/sunrpc/svc.h>
 #include <linux/nfsd/nfsd.h>
@@ -251,209 +248,6 @@ out:
 	if (file)
 		fput(file);
 	return ret;
-}
-
-struct ncp_mount_data32_v3 {
-        int version;
-        unsigned int ncp_fd;
-        compat_uid_t mounted_uid;
-        compat_pid_t wdog_pid;
-        unsigned char mounted_vol[NCP_VOLNAME_LEN + 1];
-        unsigned int time_out;
-        unsigned int retry_count;
-        unsigned int flags;
-        compat_uid_t uid;
-        compat_gid_t gid;
-        compat_mode_t file_mode;
-        compat_mode_t dir_mode;
-};
-
-struct ncp_mount_data32_v4 {
-	int version;
-	/* all members below are "long" in ABI ... i.e. 32bit on sparc32, while 64bits on sparc64 */
-	unsigned int flags;
-	unsigned int mounted_uid;
-	int wdog_pid;
-
-	unsigned int ncp_fd;
-	unsigned int time_out;
-	unsigned int retry_count;
-
-	unsigned int uid;
-	unsigned int gid;
-	unsigned int file_mode;
-	unsigned int dir_mode;
-};
-
-static void *do_ncp_super_data_conv(void *raw_data)
-{
-	switch (*(int*)raw_data) {
-		case NCP_MOUNT_VERSION:
-			{
-				struct ncp_mount_data news, *n = &news; 
-				struct ncp_mount_data32_v3 *n32 = (struct ncp_mount_data32_v3 *)raw_data;
-
-				n->version = n32->version;
-				n->ncp_fd = n32->ncp_fd;
-				n->mounted_uid = n32->mounted_uid;
-				n->wdog_pid = n32->wdog_pid;
-				memmove (n->mounted_vol, n32->mounted_vol, sizeof (n32->mounted_vol));
-				n->time_out = n32->time_out;
-				n->retry_count = n32->retry_count;
-				n->flags = n32->flags;
-				n->uid = n32->uid;
-				n->gid = n32->gid;
-				n->file_mode = n32->file_mode;
-				n->dir_mode = n32->dir_mode;
-				memcpy(raw_data, n, sizeof(*n)); 
-			}
-			break;
-		case NCP_MOUNT_VERSION_V4:
-			{
-				struct ncp_mount_data_v4 news, *n = &news; 
-				struct ncp_mount_data32_v4 *n32 = (struct ncp_mount_data32_v4 *)raw_data;
-
-				n->version = n32->version;
-				n->flags = n32->flags;
-				n->mounted_uid = n32->mounted_uid;
-				n->wdog_pid = n32->wdog_pid;
-				n->ncp_fd = n32->ncp_fd;
-				n->time_out = n32->time_out;
-				n->retry_count = n32->retry_count;
-				n->uid = n32->uid;
-				n->gid = n32->gid;
-				n->file_mode = n32->file_mode;
-				n->dir_mode = n32->dir_mode;
-				memcpy(raw_data, n, sizeof(*n)); 
-			}
-			break;
-		default:
-			/* do not touch unknown structures */
-			break;
-	}
-	return raw_data;
-}
-
-struct smb_mount_data32 {
-        int version;
-        compat_uid_t mounted_uid;
-        compat_uid_t uid;
-        compat_gid_t gid;
-        compat_mode_t file_mode;
-        compat_mode_t dir_mode;
-};
-
-static void *do_smb_super_data_conv(void *raw_data)
-{
-	struct smb_mount_data news, *s = &news;
-	struct smb_mount_data32 *s32 = (struct smb_mount_data32 *)raw_data;
-
-	if (s32->version != SMB_MOUNT_OLDVERSION)
-		goto out;
-	s->version = s32->version;
-	s->mounted_uid = s32->mounted_uid;
-	s->uid = s32->uid;
-	s->gid = s32->gid;
-	s->file_mode = s32->file_mode;
-	s->dir_mode = s32->dir_mode;
-	memcpy(raw_data, s, sizeof(struct smb_mount_data)); 
-out:
-	return raw_data;
-}
-
-static int copy_mount_stuff_to_kernel(const void *user, unsigned long *kernel)
-{
-	int i;
-	unsigned long page;
-	struct vm_area_struct *vma;
-
-	*kernel = 0;
-	if(!user)
-		return 0;
-	vma = find_vma(current->mm, (unsigned long)user);
-	if(!vma || (unsigned long)user < vma->vm_start)
-		return -EFAULT;
-	if(!(vma->vm_flags & VM_READ))
-		return -EFAULT;
-	i = vma->vm_end - (unsigned long) user;
-	if(PAGE_SIZE <= (unsigned long) i)
-		i = PAGE_SIZE - 1;
-	if(!(page = __get_free_page(GFP_KERNEL)))
-		return -ENOMEM;
-	if(copy_from_user((void *) page, user, i)) {
-		free_page(page);
-		return -EFAULT;
-	}
-	*kernel = page;
-	return 0;
-}
-
-#define SMBFS_NAME	"smbfs"
-#define NCPFS_NAME	"ncpfs"
-
-asmlinkage long sys32_mount(char *dev_name, char *dir_name, char *type, unsigned long new_flags, u32 data)
-{
-	unsigned long type_page = 0;
-	unsigned long data_page = 0;
-	unsigned long dev_page = 0;
-	unsigned long dir_page = 0;
-	int err, is_smb, is_ncp;
-	
-	is_smb = is_ncp = 0;
-
-	err = copy_mount_stuff_to_kernel((const void *)type, &type_page);
-	if (err)
-		goto out;
-
-	if (!type_page) {
-		err = -EINVAL;
-		goto out;
-	}
-
-	is_smb = !strcmp((char *)type_page, SMBFS_NAME);
-	is_ncp = !strcmp((char *)type_page, NCPFS_NAME);
-
-	err = copy_mount_stuff_to_kernel((const void *)AA(data), &data_page);
-	if (err)
-		goto type_out;
-
-	err = copy_mount_stuff_to_kernel(dev_name, &dev_page);
-	if (err)
-		goto data_out;
-
-	err = copy_mount_stuff_to_kernel(dir_name, &dir_page);
-	if (err)
-		goto dev_out;
-
-	if (!is_smb && !is_ncp) {
-		lock_kernel();
-		err = do_mount((char*)dev_page, (char*)dir_page,
-				(char*)type_page, new_flags, (char*)data_page);
-		unlock_kernel();
-	} else {
-		if (is_ncp)
-			do_ncp_super_data_conv((void *)data_page);
-		else
-			do_smb_super_data_conv((void *)data_page);
-
-		lock_kernel();
-		err = do_mount((char*)dev_page, (char*)dir_page,
-				(char*)type_page, new_flags, (char*)data_page);
-		unlock_kernel();
-	}
-	free_page(dir_page);
-
-dev_out:
-	free_page(dev_page);
-
-data_out:
-	free_page(data_page);
-
-type_out:
-	free_page(type_page);
-
-out:
-	return err;
 }
 
 /* readdir & getdents */
Index: arch/s390/kernel/compat_linux.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/s390/kernel/compat_linux.c,v
retrieving revision 1.10
diff -u -p -r1.10 compat_linux.c
--- a/arch/s390/kernel/compat_linux.c	20 Mar 2004 20:29:28 -0000	1.10
+++ b/arch/s390/kernel/compat_linux.c	26 Mar 2004 19:05:26 -0000
@@ -35,9 +35,6 @@
 #include <linux/slab.h>
 #include <linux/uio.h>
 #include <linux/nfs_fs.h>
-#include <linux/smb_fs.h>
-#include <linux/smb_mount.h>
-#include <linux/ncp_fs.h>
 #include <linux/quota.h>
 #include <linux/module.h>
 #include <linux/sunrpc/svc.h>
@@ -825,157 +822,6 @@ int cp_compat_stat(struct kstat *stat, s
 	err |= put_user(0, &statbuf->__unused4[0]);
 	err |= put_user(0, &statbuf->__unused4[1]);
 */
-	return err;
-}
-
-struct ncp_mount_data32 {
-        int version;
-        unsigned int ncp_fd;
-        compat_uid_t mounted_uid;
-        compat_pid_t wdog_pid;
-        unsigned char mounted_vol[NCP_VOLNAME_LEN + 1];
-        unsigned int time_out;
-        unsigned int retry_count;
-        unsigned int flags;
-        compat_uid_t uid;
-        compat_gid_t gid;
-        compat_mode_t file_mode;
-        compat_mode_t dir_mode;
-};
-
-static void *do_ncp_super_data_conv(void *raw_data)
-{
-	struct ncp_mount_data *n = (struct ncp_mount_data *)raw_data;
-	struct ncp_mount_data32 *n32 = (struct ncp_mount_data32 *)raw_data;
-
-	n->dir_mode = n32->dir_mode;
-	n->file_mode = n32->file_mode;
-	n->gid = low2highgid(n32->gid);
-	n->uid = low2highuid(n32->uid);
-	memmove (n->mounted_vol, n32->mounted_vol, (sizeof (n32->mounted_vol) + 3 * sizeof (unsigned int)));
-	n->wdog_pid = n32->wdog_pid;
-	n->mounted_uid = low2highuid(n32->mounted_uid);
-	return raw_data;
-}
-
-struct smb_mount_data32 {
-        int version;
-        compat_uid_t mounted_uid;
-        compat_uid_t uid;
-        compat_gid_t gid;
-        compat_mode_t file_mode;
-        compat_mode_t dir_mode;
-};
-
-static void *do_smb_super_data_conv(void *raw_data)
-{
-	struct smb_mount_data *s = (struct smb_mount_data *)raw_data;
-	struct smb_mount_data32 *s32 = (struct smb_mount_data32 *)raw_data;
-
-	if (s32->version != SMB_MOUNT_OLDVERSION)
-		goto out;
-	s->version = s32->version;
-	s->mounted_uid = low2highuid(s32->mounted_uid);
-	s->uid = low2highuid(s32->uid);
-	s->gid = low2highgid(s32->gid);
-	s->file_mode = s32->file_mode;
-	s->dir_mode = s32->dir_mode;
-out:
-	return raw_data;
-}
-
-static int copy_mount_stuff_to_kernel(const void *user, unsigned long *kernel)
-{
-	int i;
-	unsigned long page;
-	struct vm_area_struct *vma;
-
-	*kernel = 0;
-	if(!user)
-		return 0;
-	vma = find_vma(current->mm, (unsigned long)user);
-	if(!vma || (unsigned long)user < vma->vm_start)
-		return -EFAULT;
-	if(!(vma->vm_flags & VM_READ))
-		return -EFAULT;
-	i = vma->vm_end - (unsigned long) user;
-	if(PAGE_SIZE <= (unsigned long) i)
-		i = PAGE_SIZE - 1;
-	if(!(page = __get_free_page(GFP_KERNEL)))
-		return -ENOMEM;
-	if(copy_from_user((void *) page, user, i)) {
-		free_page(page);
-		return -EFAULT;
-	}
-	*kernel = page;
-	return 0;
-}
-
-#define SMBFS_NAME	"smbfs"
-#define NCPFS_NAME	"ncpfs"
-
-asmlinkage int sys32_mount(char *dev_name, char *dir_name, char *type, unsigned long new_flags, u32 data)
-{
-	unsigned long type_page = 0;
-	unsigned long data_page = 0;
-	unsigned long dev_page = 0;
-	unsigned long dir_page = 0;
-	int err, is_smb, is_ncp;
-
-	is_smb = is_ncp = 0;
-
-	err = copy_mount_stuff_to_kernel((const void *)type, &type_page);
-	if (err)
-		goto out;
-
-	if (!type_page) {
-		err = -EINVAL;
-		goto out;
-	}
-
-	is_smb = !strcmp((char *)type_page, SMBFS_NAME);
-	is_ncp = !strcmp((char *)type_page, NCPFS_NAME);
-
-	err = copy_mount_stuff_to_kernel((const void *)AA(data), &data_page);
-	if (err)
-		goto type_out;
-
-	err = copy_mount_stuff_to_kernel(dev_name, &dev_page);
-	if (err)
-		goto data_out;
-
-	err = copy_mount_stuff_to_kernel(dir_name, &dir_page);
-	if (err)
-		goto dev_out;
-
-	if (!is_smb && !is_ncp) {
-		lock_kernel();
-		err = do_mount((char*)dev_page, (char*)dir_page,
-				(char*)type_page, new_flags, (char*)data_page);
-		unlock_kernel();
-	} else {
-		if (is_ncp)
-			do_ncp_super_data_conv((void *)data_page);
-		else
-			do_smb_super_data_conv((void *)data_page);
-
-		lock_kernel();
-		err = do_mount((char*)dev_page, (char*)dir_page,
-				(char*)type_page, new_flags, (char*)data_page);
-		unlock_kernel();
-	}
-	free_page(dir_page);
-
-dev_out:
-	free_page(dev_page);
-
-data_out:
-	free_page(data_page);
-
-type_out:
-	free_page(type_page);
-
-out:
 	return err;
 }
 
Index: arch/s390/kernel/compat_wrapper.S
===================================================================
RCS file: /var/cvs/linux-2.6/arch/s390/kernel/compat_wrapper.S,v
retrieving revision 1.5
diff -u -p -r1.5 compat_wrapper.S
--- a/arch/s390/kernel/compat_wrapper.S	20 Mar 2004 20:29:28 -0000	1.5
+++ b/arch/s390/kernel/compat_wrapper.S	26 Mar 2004 19:05:26 -0000
@@ -102,7 +102,7 @@ sys32_mount_wrapper:
 	llgtr	%r4,%r4			# char *
 	llgfr	%r5,%r5			# unsigned long
 	llgtr	%r6,%r6			# void *
-	jg	sys32_mount		# branch to system call
+	jg	compat_sys_mount	# branch to system call
 
 	.globl  sys32_oldumount_wrapper 
 sys32_oldumount_wrapper:
Index: arch/sparc64/kernel/sys_sparc32.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/sparc64/kernel/sys_sparc32.c,v
retrieving revision 1.10
diff -u -p -r1.10 sys_sparc32.c
--- a/arch/sparc64/kernel/sys_sparc32.c	16 Mar 2004 15:40:00 -0000	1.10
+++ b/arch/sparc64/kernel/sys_sparc32.c	26 Mar 2004 19:05:27 -0000
@@ -27,9 +27,6 @@
 #include <linux/slab.h>
 #include <linux/uio.h>
 #include <linux/nfs_fs.h>
-#include <linux/smb_fs.h>
-#include <linux/smb_mount.h>
-#include <linux/ncp_fs.h>
 #include <linux/quota.h>
 #include <linux/module.h>
 #include <linux/sunrpc/svc.h>
@@ -1327,209 +1324,6 @@ int cp_compat_stat(struct kstat *stat, s
 asmlinkage int sys32_sysfs(int option, u32 arg1, u32 arg2)
 {
 	return sys_sysfs(option, arg1, arg2);
-}
-
-struct ncp_mount_data32_v3 {
-        int version;
-        unsigned int ncp_fd;
-        compat_uid_t mounted_uid;
-        compat_pid_t wdog_pid;
-        unsigned char mounted_vol[NCP_VOLNAME_LEN + 1];
-        unsigned int time_out;
-        unsigned int retry_count;
-        unsigned int flags;
-        compat_uid_t uid;
-        compat_gid_t gid;
-        compat_mode_t file_mode;
-        compat_mode_t dir_mode;
-};
-
-struct ncp_mount_data32_v4 {
-	int version;
-	/* all members below are "long" in ABI ... i.e. 32bit on sparc32, while 64bits on sparc64 */
-	unsigned int flags;
-	unsigned int mounted_uid;
-	int wdog_pid;
-
-	unsigned int ncp_fd;
-	unsigned int time_out;
-	unsigned int retry_count;
-
-	unsigned int uid;
-	unsigned int gid;
-	unsigned int file_mode;
-	unsigned int dir_mode;
-};
-
-static void *do_ncp_super_data_conv(void *raw_data)
-{
-	switch (*(int*)raw_data) {
-		case NCP_MOUNT_VERSION:
-			{
-				struct ncp_mount_data news, *n = &news; 
-				struct ncp_mount_data32_v3 *n32 = (struct ncp_mount_data32_v3 *)raw_data;
-
-				n->version = n32->version;
-				n->ncp_fd = n32->ncp_fd;
-				n->mounted_uid = low2highuid(n32->mounted_uid);
-				n->wdog_pid = n32->wdog_pid;
-				memmove (n->mounted_vol, n32->mounted_vol, sizeof (n32->mounted_vol));
-				n->time_out = n32->time_out;
-				n->retry_count = n32->retry_count;
-				n->flags = n32->flags;
-				n->uid = low2highuid(n32->uid);
-				n->gid = low2highgid(n32->gid);
-				n->file_mode = n32->file_mode;
-				n->dir_mode = n32->dir_mode;
-				memcpy(raw_data, n, sizeof(*n)); 
-			}
-			break;
-		case NCP_MOUNT_VERSION_V4:
-			{
-				struct ncp_mount_data_v4 news, *n = &news; 
-				struct ncp_mount_data32_v4 *n32 = (struct ncp_mount_data32_v4 *)raw_data;
-
-				n->version = n32->version;
-				n->flags = n32->flags;
-				n->mounted_uid = n32->mounted_uid;
-				n->wdog_pid = n32->wdog_pid;
-				n->ncp_fd = n32->ncp_fd;
-				n->time_out = n32->time_out;
-				n->retry_count = n32->retry_count;
-				n->uid = n32->uid;
-				n->gid = n32->gid;
-				n->file_mode = n32->file_mode;
-				n->dir_mode = n32->dir_mode;
-				memcpy(raw_data, n, sizeof(*n)); 
-			}
-			break;
-		default:
-			/* do not touch unknown structures */
-			break;
-	}
-	return raw_data;
-}
-
-struct smb_mount_data32 {
-        int version;
-        compat_uid_t mounted_uid;
-        compat_uid_t uid;
-        compat_gid_t gid;
-        compat_mode_t file_mode;
-        compat_mode_t dir_mode;
-};
-
-static void *do_smb_super_data_conv(void *raw_data)
-{
-	struct smb_mount_data news, *s = &news;
-	struct smb_mount_data32 *s32 = (struct smb_mount_data32 *)raw_data;
-
-	if (s32->version != SMB_MOUNT_OLDVERSION)
-		goto out;
-	s->version = s32->version;
-	s->mounted_uid = low2highuid(s32->mounted_uid);
-	s->uid = low2highuid(s32->uid);
-	s->gid = low2highgid(s32->gid);
-	s->file_mode = s32->file_mode;
-	s->dir_mode = s32->dir_mode;
-	memcpy(raw_data, s, sizeof(struct smb_mount_data)); 
-out:
-	return raw_data;
-}
-
-static int copy_mount_stuff_to_kernel(const void *user, unsigned long *kernel)
-{
-	int i;
-	unsigned long page;
-	struct vm_area_struct *vma;
-
-	*kernel = 0;
-	if(!user)
-		return 0;
-	vma = find_vma(current->mm, (unsigned long)user);
-	if(!vma || (unsigned long)user < vma->vm_start)
-		return -EFAULT;
-	if(!(vma->vm_flags & VM_READ))
-		return -EFAULT;
-	i = vma->vm_end - (unsigned long) user;
-	if(PAGE_SIZE <= (unsigned long) i)
-		i = PAGE_SIZE - 1;
-	if(!(page = __get_free_page(GFP_KERNEL)))
-		return -ENOMEM;
-	if(copy_from_user((void *) page, user, i)) {
-		free_page(page);
-		return -EFAULT;
-	}
-	*kernel = page;
-	return 0;
-}
-
-#define SMBFS_NAME	"smbfs"
-#define NCPFS_NAME	"ncpfs"
-
-asmlinkage int sys32_mount(char *dev_name, char *dir_name, char *type, unsigned long new_flags, u32 data)
-{
-	unsigned long type_page = 0;
-	unsigned long data_page = 0;
-	unsigned long dev_page = 0;
-	unsigned long dir_page = 0;
-	int err, is_smb, is_ncp;
-
-	is_smb = is_ncp = 0;
-
-	err = copy_mount_stuff_to_kernel((const void *)type, &type_page);
-	if (err)
-		goto out;
-
-	if (!type_page) {
-		err = -EINVAL;
-		goto out;
-	}
-
-	is_smb = !strcmp((char *)type_page, SMBFS_NAME);
-	is_ncp = !strcmp((char *)type_page, NCPFS_NAME);
-
-	err = copy_mount_stuff_to_kernel((const void *)AA(data), &data_page);
-	if (err)
-		goto type_out;
-
-	err = copy_mount_stuff_to_kernel(dev_name, &dev_page);
-	if (err)
-		goto data_out;
-
-	err = copy_mount_stuff_to_kernel(dir_name, &dir_page);
-	if (err)
-		goto dev_out;
-
-	if (!is_smb && !is_ncp) {
-		lock_kernel();
-		err = do_mount((char*)dev_page, (char*)dir_page,
-				(char*)type_page, new_flags, (char*)data_page);
-		unlock_kernel();
-	} else {
-		if (is_ncp)
-			do_ncp_super_data_conv((void *)data_page);
-		else
-			do_smb_super_data_conv((void *)data_page);
-
-		lock_kernel();
-		err = do_mount((char*)dev_page, (char*)dir_page,
-				(char*)type_page, new_flags, (char*)data_page);
-		unlock_kernel();
-	}
-	free_page(dir_page);
-
-dev_out:
-	free_page(dev_page);
-
-data_out:
-	free_page(data_page);
-
-type_out:
-	free_page(type_page);
-
-out:
-	return err;
 }
 
 struct sysinfo32 {
Index: arch/sparc64/kernel/systbls.S
===================================================================
RCS file: /var/cvs/linux-2.6/arch/sparc64/kernel/systbls.S,v
retrieving revision 1.6
diff -u -p -r1.6 systbls.S
--- a/arch/sparc64/kernel/systbls.S	7 Jan 2004 21:30:12 -0000	1.6
+++ b/arch/sparc64/kernel/systbls.S	26 Mar 2004 19:05:27 -0000
@@ -52,7 +52,7 @@ sys_call_table32:
 /*150*/	.word sys_nis_syscall, sys_nis_syscall, sys_nis_syscall, sys_poll, sys_getdents64
 	.word compat_sys_fcntl64, sys_ni_syscall, compat_sys_statfs, compat_sys_fstatfs, sys_oldumount
 /*160*/	.word compat_sys_sched_setaffinity, compat_sys_sched_getaffinity, sys_getdomainname, sys_setdomainname, sys_nis_syscall
-	.word sys_quotactl, sys_set_tid_address, sys32_mount, sys_ustat, sys_setxattr
+	.word sys_quotactl, sys_set_tid_address, compat_sys_mount, sys_ustat, sys_setxattr
 /*170*/	.word sys_lsetxattr, sys_fsetxattr, sys_getxattr, sys_lgetxattr, sys32_getdents
 	.word sys_setsid, sys_fchdir, sys_fgetxattr, sys_listxattr, sys_llistxattr
 /*180*/	.word sys_flistxattr, sys_removexattr, sys_lremovexattr, compat_sys_sigpending, sys_ni_syscall
Index: arch/x86_64/ia32/ia32entry.S
===================================================================
RCS file: /var/cvs/linux-2.6/arch/x86_64/ia32/ia32entry.S,v
retrieving revision 1.6
diff -u -p -r1.6 ia32entry.S
--- a/arch/x86_64/ia32/ia32entry.S	16 Mar 2004 15:40:01 -0000	1.6
+++ b/arch/x86_64/ia32/ia32entry.S	26 Mar 2004 19:05:27 -0000
@@ -326,7 +326,7 @@ ia32_sys_call_table:
 	.quad sys_stat
 	.quad sys32_lseek
 	.quad sys_getpid		/* 20 */
-	.quad sys_mount	/* mount  */
+	.quad compat_sys_mount	/* mount  */
 	.quad sys_oldumount	/* old_umount  */
 	.quad sys_setuid16
 	.quad sys_getuid16
Index: arch/x86_64/ia32/sys_ia32.c
===================================================================
RCS file: /var/cvs/linux-2.6/arch/x86_64/ia32/sys_ia32.c,v
retrieving revision 1.11
diff -u -p -r1.11 sys_ia32.c
--- a/arch/x86_64/ia32/sys_ia32.c	16 Mar 2004 15:40:01 -0000	1.11
+++ b/arch/x86_64/ia32/sys_ia32.c	26 Mar 2004 19:05:28 -0000
@@ -40,9 +40,6 @@
 #include <linux/slab.h>
 #include <linux/uio.h>
 #include <linux/nfs_fs.h>
-#include <linux/smb_fs.h>
-#include <linux/smb_mount.h>
-#include <linux/ncp_fs.h>
 #include <linux/quota.h>
 #include <linux/module.h>
 #include <linux/sunrpc/svc.h>
@@ -872,39 +869,6 @@ asmlinkage long
 sys32_sysfs(int option, u32 arg1, u32 arg2)
 {
 	return sys_sysfs(option, arg1, arg2);
-}
-
-static char *badfs[] = {
-	"smbfs", "ncpfs", NULL
-}; 	
-
-static int checktype(char *user_type) 
-{ 
-	int err = 0; 
-	char **s,*kernel_type = getname(user_type); 
-	if (!kernel_type || IS_ERR(kernel_type)) 
-		return -EFAULT; 
-	for (s = badfs; *s; ++s) 
-		if (!strcmp(kernel_type, *s)) { 
-			printk(KERN_ERR "mount32: unsupported fs `%s' -- use 64bit mount\n", *s); 
-			err = -EINVAL; 
-			break;
-		} 	
-	putname(user_type); 
-	return err;
-} 
-
-asmlinkage long
-sys32_mount(char *dev_name, char *dir_name, char *type,
-	    unsigned long new_flags, u32 data)
-{
-	int err;
-	if(!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-	err = checktype(type);
-	if (err)
-		return err;
-	return sys_mount(dev_name, dir_name, type, new_flags, (void *)AA(data));
 }
 
 struct sysinfo32 {
Index: fs/compat.c
===================================================================
RCS file: /var/cvs/linux-2.6/fs/compat.c,v
retrieving revision 1.7
diff -u -p -r1.7 compat.c
--- a/fs/compat.c	28 Feb 2004 01:51:06 -0000	1.7
+++ b/fs/compat.c	26 Mar 2004 19:05:31 -0000
@@ -27,6 +27,9 @@
 #include <linux/ioctl32.h>
 #include <linux/init.h>
 #include <linux/sockios.h>	/* for SIOCDEVPRIVATE */
+#include <linux/smb.h>
+#include <linux/smb_mount.h>
+#include <linux/ncp_mount.h>
 #include <linux/smp_lock.h>
 #include <linux/syscalls.h>
 #include <linux/ctype.h>
@@ -642,3 +645,152 @@ compat_sys_io_submit(aio_context_t ctx_i
 		ret = sys_io_submit(ctx_id, nr, iocb64);
 	return ret;
 }
+
+struct compat_ncp_mount_data {
+	compat_int_t version;
+	compat_uint_t ncp_fd;
+	compat_uid_t mounted_uid;
+	compat_pid_t wdog_pid;
+	unsigned char mounted_vol[NCP_VOLNAME_LEN + 1];
+	compat_uint_t time_out;
+	compat_uint_t retry_count;
+	compat_uint_t flags;
+	compat_uid_t uid;
+	compat_gid_t gid;
+	compat_mode_t file_mode;
+	compat_mode_t dir_mode;
+};
+
+struct compat_ncp_mount_data_v4 {
+	compat_int_t version;
+	compat_ulong_t flags;
+	compat_ulong_t mounted_uid;
+	compat_long_t wdog_pid;
+	compat_uint_t ncp_fd;
+	compat_uint_t time_out;
+	compat_uint_t retry_count;
+	compat_ulong_t uid;
+	compat_ulong_t gid;
+	compat_ulong_t file_mode;
+	compat_ulong_t dir_mode;
+};
+
+static void *do_ncp_super_data_conv(void *raw_data)
+{
+	int version = *(unsigned int *)raw_data;
+
+	if (version == 3) {
+		struct compat_ncp_mount_data *c_n = raw_data;
+		struct ncp_mount_data *n = raw_data;
+
+		n->dir_mode = c_n->dir_mode;
+		n->file_mode = c_n->file_mode;
+		n->gid = c_n->gid;
+		n->uid = c_n->uid;
+		memmove (n->mounted_vol, c_n->mounted_vol, (sizeof (c_n->mounted_vol) + 3 * sizeof (unsigned int)));
+		n->wdog_pid = c_n->wdog_pid;
+		n->mounted_uid = c_n->mounted_uid;
+	} else if (version == 4) {
+		struct compat_ncp_mount_data_v4 *c_n = raw_data;
+		struct ncp_mount_data_v4 *n = raw_data;
+
+		n->dir_mode = c_n->dir_mode;
+		n->file_mode = c_n->file_mode;
+		n->gid = c_n->gid;
+		n->uid = c_n->uid;
+		n->retry_count = c_n->retry_count;
+		n->time_out = c_n->time_out;
+		n->ncp_fd = c_n->ncp_fd;
+		n->wdog_pid = c_n->wdog_pid;
+		n->mounted_uid = c_n->mounted_uid;
+		n->flags = c_n->flags;
+	} else if (version != 5) {
+		return NULL;
+	}
+
+	return raw_data;
+}
+
+struct compat_smb_mount_data {
+	compat_int_t version;
+	compat_uid_t mounted_uid;
+	compat_uid_t uid;
+	compat_gid_t gid;
+	compat_mode_t file_mode;
+	compat_mode_t dir_mode;
+};
+
+static void *do_smb_super_data_conv(void *raw_data)
+{
+	struct smb_mount_data *s = raw_data;
+	struct compat_smb_mount_data *c_s = raw_data;
+
+	if (c_s->version != SMB_MOUNT_OLDVERSION)
+		goto out;
+	s->dir_mode = c_s->dir_mode;
+	s->file_mode = c_s->file_mode;
+	s->gid = c_s->gid;
+	s->uid = c_s->uid;
+	s->mounted_uid = c_s->mounted_uid;
+ out:
+	return raw_data;
+}
+
+extern int copy_mount_options (const void __user *, unsigned long *);
+
+#define SMBFS_NAME      "smbfs"
+#define NCPFS_NAME      "ncpfs"
+
+asmlinkage int compat_sys_mount(char __user * dev_name, char __user * dir_name,
+				char __user * type, unsigned long flags,
+				void __user * data)
+{
+	unsigned long type_page;
+	unsigned long data_page;
+	unsigned long dev_page;
+	char *dir_page;
+	int retval;
+
+	retval = copy_mount_options (type, &type_page);
+	if (retval < 0)
+		goto out;
+
+	dir_page = getname(dir_name);
+	retval = PTR_ERR(dir_page);
+	if (IS_ERR(dir_page))
+		goto out1;
+
+	retval = copy_mount_options (dev_name, &dev_page);
+	if (retval < 0)
+		goto out2;
+
+	retval = copy_mount_options (data, &data_page);
+	if (retval < 0)
+		goto out3;
+
+	retval = -EINVAL;
+
+	if (type_page) {
+		if (!strcmp((char *)type_page, SMBFS_NAME)) {
+			do_smb_super_data_conv((void *)data_page);
+		} else if (!strcmp((char *)type_page, NCPFS_NAME)) {
+			do_ncp_super_data_conv((void *)data_page);
+		}
+	}
+
+	lock_kernel();
+	retval = do_mount((char*)dev_page, dir_page, (char*)type_page,
+			flags, (void*)data_page);
+	unlock_kernel();
+
+	free_page(data_page);
+ out3:
+	free_page(dev_page);
+ out2:
+	putname(dir_page);
+ out1:
+	free_page(type_page);
+ out:
+	return retval;
+}
+
Index: fs/namespace.c
===================================================================
RCS file: /var/cvs/linux-2.6/fs/namespace.c,v
retrieving revision 1.5
diff -u -p -r1.5 namespace.c
--- a/fs/namespace.c	20 Mar 2004 20:29:48 -0000	1.5
+++ b/fs/namespace.c	26 Mar 2004 19:05:31 -0000
@@ -694,7 +694,7 @@ out:
 	return err;
 }
 
-static int copy_mount_options (const void __user *data, unsigned long *where)
+int copy_mount_options (const void __user *data, unsigned long *where)
 {
 	int i;
 	unsigned long page;
Index: include/net/scm.h
===================================================================
RCS file: /var/cvs/linux-2.6/include/net/scm.h,v
retrieving revision 1.2
diff -u -p -r1.2 scm.h
--- a/include/net/scm.h	8 Oct 2003 20:53:05 -0000	1.2
+++ b/include/net/scm.h	26 Mar 2004 19:05:31 -0000
@@ -2,6 +2,7 @@
 #define __LINUX_NET_SCM_H
 
 #include <linux/limits.h>
+#include <linux/net.h>
 
 /* Well, we should have at least one descriptor open
  * to accept passed FDs 8)

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
