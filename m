Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbUDQJ5b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 05:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263780AbUDQJ5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 05:57:31 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:48059 "EHLO
	natsmtp00.webmailer.de") by vger.kernel.org with ESMTP
	id S263778AbUDQJt0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 05:49:26 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Consolidate =?iso-8859-1?q?sys32=5Fnfsservctl=0A?=
Date: Fri, 16 Apr 2004 18:08:34 +0200
User-Agent: KMail/1.6.1
References: <200404161800.22367.arnd@arndb.de>
In-Reply-To: <200404161800.22367.arnd@arndb.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404161808.35003.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

sys32_nfsservctl is the largest remaining syscall emulation handler that
can be consolidated. mips and ia64 currently don't use this at all,
parisc has a simpler implementation than the one used by s390, sparc
ppc and that the new compat_sys_nfsservctl is based on.

The user access checks in the code are inconsistant at least, which
should be fixed here.

Compile tested only due to lack of proper test setup.

 arch/ia64/ia32/sys_ia32.c          |  170 --------------------------
 arch/parisc/kernel/sys_parisc32.c  |   88 -------------
 arch/parisc/kernel/syscall_table.S |    2
 arch/ppc64/kernel/misc.S           |    2
 arch/ppc64/kernel/sys_ppc32.c      |  239 -------------------------------------
 arch/s390/kernel/compat_linux.c    |  220 ----------------------------------
 arch/s390/kernel/compat_wrapper.S  |   10 -
 arch/s390/kernel/syscalls.S        |    2
 arch/sparc64/kernel/sys_sparc32.c  |  226 ----------------------------------
 arch/sparc64/kernel/systbls.S      |    2
 arch/x86_64/ia32/ia32entry.S       |    2
 arch/x86_64/ia32/sys_ia32.c        |  227 -----------------------------------
 fs/compat.c                        |  239 +++++++++++++++++++++++++++++++++++++
 13 files changed, 249 insertions(+), 1180 deletions(-)

===== arch/ia64/ia32/sys_ia32.c 1.96 vs edited =====
--- 1.96/arch/ia64/ia32/sys_ia32.c	Thu Apr 15 19:30:49 2004
+++ edited/arch/ia64/ia32/sys_ia32.c	Thu Apr 15 17:37:01 2004
@@ -2200,176 +2200,6 @@
 	return sys_setresgid(srgid, segid, ssgid);
 }
 
-/* Stuff for NFS server syscalls... */
-struct nfsctl_svc32 {
-	u16			svc32_port;
-	s32			svc32_nthreads;
-};
-
-struct nfsctl_client32 {
-	s8			cl32_ident[NFSCLNT_IDMAX+1];
-	s32			cl32_naddr;
-	struct in_addr		cl32_addrlist[NFSCLNT_ADDRMAX];
-	s32			cl32_fhkeytype;
-	s32			cl32_fhkeylen;
-	u8			cl32_fhkey[NFSCLNT_KEYMAX];
-};
-
-struct nfsctl_export32 {
-	s8			ex32_client[NFSCLNT_IDMAX+1];
-	s8			ex32_path[NFS_MAXPATHLEN+1];
-	compat_dev_t	ex32_dev;
-	compat_ino_t	ex32_ino;
-	s32			ex32_flags;
-	compat_uid_t	ex32_anon_uid;
-	compat_gid_t	ex32_anon_gid;
-};
-
-struct nfsctl_arg32 {
-	s32			ca32_version;	/* safeguard */
-	union {
-		struct nfsctl_svc32	u32_svc;
-		struct nfsctl_client32	u32_client;
-		struct nfsctl_export32	u32_export;
-		u32			u32_debug;
-	} u;
-#define ca32_svc	u.u32_svc
-#define ca32_client	u.u32_client
-#define ca32_export	u.u32_export
-#define ca32_debug	u.u32_debug
-};
-
-union nfsctl_res32 {
-	struct knfs_fh		cr32_getfh;
-	u32			cr32_debug;
-};
-
-static int
-nfs_svc32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-
-	err = __get_user(karg->ca_version, &arg32->ca32_version);
-	err |= __get_user(karg->ca_svc.svc_port, &arg32->ca32_svc.svc32_port);
-	err |= __get_user(karg->ca_svc.svc_nthreads,
-			  &arg32->ca32_svc.svc32_nthreads);
-	return err;
-}
-
-static int
-nfs_clnt32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-
-	err = __get_user(karg->ca_version, &arg32->ca32_version);
-	err |= copy_from_user(&karg->ca_client.cl_ident[0],
-			  &arg32->ca32_client.cl32_ident[0],
-			  NFSCLNT_IDMAX);
-	err |= __get_user(karg->ca_client.cl_naddr,
-			  &arg32->ca32_client.cl32_naddr);
-	err |= copy_from_user(&karg->ca_client.cl_addrlist[0],
-			  &arg32->ca32_client.cl32_addrlist[0],
-			  (sizeof(struct in_addr) * NFSCLNT_ADDRMAX));
-	err |= __get_user(karg->ca_client.cl_fhkeytype,
-		      &arg32->ca32_client.cl32_fhkeytype);
-	err |= __get_user(karg->ca_client.cl_fhkeylen,
-		      &arg32->ca32_client.cl32_fhkeylen);
-	err |= copy_from_user(&karg->ca_client.cl_fhkey[0],
-			  &arg32->ca32_client.cl32_fhkey[0],
-			  NFSCLNT_KEYMAX);
-	return err;
-}
-
-static int
-nfs_exp32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-
-	err = __get_user(karg->ca_version, &arg32->ca32_version);
-	err |= copy_from_user(&karg->ca_export.ex_client[0],
-			  &arg32->ca32_export.ex32_client[0],
-			  NFSCLNT_IDMAX);
-	err |= copy_from_user(&karg->ca_export.ex_path[0],
-			  &arg32->ca32_export.ex32_path[0],
-			  NFS_MAXPATHLEN);
-	err |= __get_user(karg->ca_export.ex_dev,
-		      &arg32->ca32_export.ex32_dev);
-	err |= __get_user(karg->ca_export.ex_ino,
-		      &arg32->ca32_export.ex32_ino);
-	err |= __get_user(karg->ca_export.ex_flags,
-		      &arg32->ca32_export.ex32_flags);
-	err |= __get_user(karg->ca_export.ex_anon_uid,
-		      &arg32->ca32_export.ex32_anon_uid);
-	err |= __get_user(karg->ca_export.ex_anon_gid,
-		      &arg32->ca32_export.ex32_anon_gid);
-	return err;
-}
-
-static int
-nfs_getfh32_res_trans(union nfsctl_res *kres, union nfsctl_res32 *res32)
-{
-	int err;
-
-	err = copy_to_user(&res32->cr32_getfh,
-			&kres->cr_getfh,
-			sizeof(res32->cr32_getfh));
-	err |= __put_user(kres->cr_debug, &res32->cr32_debug);
-	return err;
-}
-
-int asmlinkage
-sys32_nfsservctl(int cmd, struct nfsctl_arg32 *arg32, union nfsctl_res32 *res32)
-{
-	struct nfsctl_arg *karg = NULL;
-	union nfsctl_res *kres = NULL;
-	mm_segment_t oldfs;
-	int err;
-
-	karg = kmalloc(sizeof(*karg), GFP_USER);
-	if(!karg)
-		return -ENOMEM;
-	if(res32) {
-		kres = kmalloc(sizeof(*kres), GFP_USER);
-		if(!kres) {
-			kfree(karg);
-			return -ENOMEM;
-		}
-	}
-	switch(cmd) {
-	case NFSCTL_SVC:
-		err = nfs_svc32_trans(karg, arg32);
-		break;
-	case NFSCTL_ADDCLIENT:
-		err = nfs_clnt32_trans(karg, arg32);
-		break;
-	case NFSCTL_DELCLIENT:
-		err = nfs_clnt32_trans(karg, arg32);
-		break;
-	case NFSCTL_EXPORT:
-		err = nfs_exp32_trans(karg, arg32);
-		break;
-	default:
-		err = -EINVAL;
-		break;
-	}
-	if(err)
-		goto done;
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sys_nfsservctl(cmd, karg, kres);
-	set_fs(oldfs);
-
-	if(!err && cmd == NFSCTL_GETFS)
-		err = nfs_getfh32_res_trans(kres, res32);
-
-done:
-	if(karg)
-		kfree(karg);
-	if(kres)
-		kfree(kres);
-	return err;
-}
-
 /* Handle adjtimex compatibility. */
 
 struct timex32 {
===== arch/parisc/kernel/sys_parisc32.c 1.27 vs edited =====
--- 1.27/arch/parisc/kernel/sys_parisc32.c	Thu Apr 15 19:30:49 2004
+++ edited/arch/parisc/kernel/sys_parisc32.c	Thu Apr 15 17:37:01 2004
@@ -564,94 +564,6 @@
         return ret;
 }
 
-/* EXPORT/UNEXPORT */
-struct nfsctl_export32 {
-	char		ex_client[NFSCLNT_IDMAX+1];
-	char		ex_path[NFS_MAXPATHLEN+1];
-	__kernel_old_dev_t ex_dev;
-	compat_ino_t	ex_ino;
-	int		ex_flags;
-	__kernel_uid_t	ex_anon_uid;
-	__kernel_gid_t	ex_anon_gid;
-};
-
-struct nfsctl_arg32 {
-	int			ca_version;	/* safeguard */
-	/* wide kernel places this union on 8-byte boundary, narrow on 4 */
-	union {
-		struct nfsctl_svc	u_svc;
-		struct nfsctl_client	u_client;
-		struct nfsctl_export32	u_export;
-		struct nfsctl_fdparm	u_getfd;
-		struct nfsctl_fsparm	u_getfs;
-	} u;
-};
-
-asmlinkage int sys32_nfsservctl(int cmd, void *argp, void *resp)
-{
-	int ret, tmp;
-	struct nfsctl_arg32 n32;
-	struct nfsctl_arg n;
-
-	ret = copy_from_user(&n, argp, sizeof n.ca_version);
-	if (ret != 0)
-		return ret;
-
-	/* adjust argp to point at the union inside the user's n32 struct */
-	tmp = (unsigned long)&n32.u - (unsigned long)&n32;
-	argp = (void *)((unsigned long)argp + tmp);
-	switch(cmd) {
-	case NFSCTL_SVC:
-		ret = copy_from_user(&n.u, argp, sizeof n.u.u_svc);
-		break;
-
-	case NFSCTL_ADDCLIENT:
-	case NFSCTL_DELCLIENT:
-		ret = copy_from_user(&n.u, argp, sizeof n.u.u_client);
-		break;
-
-	case NFSCTL_GETFD:
-		ret = copy_from_user(&n.u, argp, sizeof n.u.u_getfd);
-		break;
-
-	case NFSCTL_GETFS:
-		ret = copy_from_user(&n.u, argp, sizeof n.u.u_getfs);
-		break;
-
-	case NFSCTL_UNEXPORT:		/* nfsctl_export */
-	case NFSCTL_EXPORT:		/* nfsctl_export */
-		ret = copy_from_user(&n32.u, argp, sizeof n32.u.u_export);
-#undef CP
-#define CP(x)	n.u.u_export.ex_##x = n32.u.u_export.ex_##x
-		memcpy(n.u.u_export.ex_client, n32.u.u_export.ex_client, sizeof n32.u.u_export.ex_client);
-		memcpy(n.u.u_export.ex_path, n32.u.u_export.ex_path, sizeof n32.u.u_export.ex_path);
-		CP(dev);
-		CP(ino);
-		CP(flags);
-		CP(anon_uid);
-		CP(anon_gid);
-		break;
-
-	default:
-		/* lockd probes for some other values (0x10000);
-		 * so don't BUG() */
-		ret = -EINVAL;
-		break;
-	}
-
-	if (ret == 0) {
-		unsigned char rbuf[NFS_FHSIZE + sizeof (struct knfsd_fh)];
-		KERNEL_SYSCALL(ret, sys_nfsservctl, cmd, &n, &rbuf);
-		if (cmd == NFSCTL_GETFD) {
-			ret = copy_to_user(resp, rbuf, NFS_FHSIZE);
-		} else if (cmd == NFSCTL_GETFS) {
-			ret = copy_to_user(resp, rbuf, sizeof (struct knfsd_fh));
-		}
-	}
-
-	return ret;
-}
-
 typedef long __kernel_loff_t32;		/* move this to asm/posix_types.h? */
 
 asmlinkage int sys32_sendfile64(int out_fd, int in_fd, __kernel_loff_t32 *offset, s32 count)
===== arch/parisc/kernel/syscall_table.S 1.6 vs edited =====
--- 1.6/arch/parisc/kernel/syscall_table.S	Thu Apr 15 19:30:49 2004
+++ edited/arch/parisc/kernel/syscall_table.S	Thu Apr 15 17:37:01 2004
@@ -266,7 +266,7 @@
 	ENTRY_SAME(ni_syscall)		/* query_module */
 	ENTRY_SAME(poll)
 	/* structs contain pointers and an in_addr... */
-	ENTRY_DIFF(nfsservctl)
+	ENTRY_COMP(nfsservctl)
 	ENTRY_SAME(setresgid)		/* 170 */
 	ENTRY_SAME(getresgid)
 	ENTRY_SAME(prctl)
===== arch/ppc64/kernel/misc.S 1.76 vs edited =====
--- 1.76/arch/ppc64/kernel/misc.S	Thu Apr 15 17:25:08 2004
+++ edited/arch/ppc64/kernel/misc.S	Thu Apr 15 17:37:01 2004
@@ -740,7 +740,7 @@
 	.llong .sys_getresuid	        /* 165 */
 	.llong .sys_ni_syscall		/* old query_module syscall */
 	.llong .sys_poll
-	.llong .sys32_nfsservctl
+	.llong .compat_sys_nfsservctl
 	.llong .sys_setresgid
 	.llong .sys_getresgid	        /* 170 */
 	.llong .sys32_prctl
===== arch/ppc64/kernel/sys_ppc32.c 1.88 vs edited =====
--- 1.88/arch/ppc64/kernel/sys_ppc32.c	Thu Apr 15 19:30:49 2004
+++ edited/arch/ppc64/kernel/sys_ppc32.c	Thu Apr 15 17:37:01 2004
@@ -351,245 +351,6 @@
 	return ret;
 }
 
-/* Stuff for NFS server syscalls... */
-struct nfsctl_svc32 {
-	u16			svc32_port;
-	s32			svc32_nthreads;
-};
-
-struct nfsctl_client32 {
-	s8			cl32_ident[NFSCLNT_IDMAX+1];
-	s32			cl32_naddr;
-	struct in_addr		cl32_addrlist[NFSCLNT_ADDRMAX];
-	s32			cl32_fhkeytype;
-	s32			cl32_fhkeylen;
-	u8			cl32_fhkey[NFSCLNT_KEYMAX];
-};
-
-struct nfsctl_export32 {
-	s8			ex32_client[NFSCLNT_IDMAX+1];
-	s8			ex32_path[NFS_MAXPATHLEN+1];
-	compat_dev_t	ex32_dev;
-	compat_ino_t	ex32_ino;
-	s32			ex32_flags;
-	compat_uid_t	ex32_anon_uid;
-	compat_gid_t	ex32_anon_gid;
-};
-
-struct nfsctl_fdparm32 {
-	struct sockaddr		gd32_addr;
-	s8			gd32_path[NFS_MAXPATHLEN+1];
-	s32			gd32_version;
-};
-
-struct nfsctl_fsparm32 {
-	struct sockaddr		gd32_addr;
-	s8			gd32_path[NFS_MAXPATHLEN+1];
-	s32			gd32_maxlen;
-};
-
-struct nfsctl_arg32 {
-	s32			ca32_version;	/* safeguard */
-	union {
-		struct nfsctl_svc32	u32_svc;
-		struct nfsctl_client32	u32_client;
-		struct nfsctl_export32	u32_export;
-		struct nfsctl_fdparm32	u32_getfd;
-		struct nfsctl_fsparm32	u32_getfs;
-	} u;
-#define ca32_svc	u.u32_svc
-#define ca32_client	u.u32_client
-#define ca32_export	u.u32_export
-#define ca32_getfd	u.u32_getfd
-#define ca32_getfs	u.u32_getfs
-};
-
-union nfsctl_res32 {
-	__u8			cr32_getfh[NFS_FHSIZE];
-	struct knfsd_fh		cr32_getfs;
-};
-
-static int nfs_svc32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = __get_user(karg->ca_version, &arg32->ca32_version);
-	err |= __get_user(karg->ca_svc.svc_port, &arg32->ca32_svc.svc32_port);
-	err |= __get_user(karg->ca_svc.svc_nthreads, &arg32->ca32_svc.svc32_nthreads);
-	return err;
-}
-
-static int nfs_clnt32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = __get_user(karg->ca_version, &arg32->ca32_version);
-	err |= copy_from_user(&karg->ca_client.cl_ident[0],
-			  &arg32->ca32_client.cl32_ident[0],
-			  NFSCLNT_IDMAX);
-	err |= __get_user(karg->ca_client.cl_naddr, &arg32->ca32_client.cl32_naddr);
-	err |= copy_from_user(&karg->ca_client.cl_addrlist[0],
-			  &arg32->ca32_client.cl32_addrlist[0],
-			  (sizeof(struct in_addr) * NFSCLNT_ADDRMAX));
-	err |= __get_user(karg->ca_client.cl_fhkeytype,
-		      &arg32->ca32_client.cl32_fhkeytype);
-	err |= __get_user(karg->ca_client.cl_fhkeylen,
-		      &arg32->ca32_client.cl32_fhkeylen);
-	err |= copy_from_user(&karg->ca_client.cl_fhkey[0],
-			  &arg32->ca32_client.cl32_fhkey[0],
-			  NFSCLNT_KEYMAX);
-
-	if(err) return -EFAULT;
-	return 0;
-}
-
-static int nfs_exp32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = __get_user(karg->ca_version, &arg32->ca32_version);
-	err |= copy_from_user(&karg->ca_export.ex_client[0],
-			  &arg32->ca32_export.ex32_client[0],
-			  NFSCLNT_IDMAX);
-	err |= copy_from_user(&karg->ca_export.ex_path[0],
-			  &arg32->ca32_export.ex32_path[0],
-			  NFS_MAXPATHLEN);
-	err |= __get_user(karg->ca_export.ex_dev,
-		      &arg32->ca32_export.ex32_dev);
-	err |= __get_user(karg->ca_export.ex_ino,
-		      &arg32->ca32_export.ex32_ino);
-	err |= __get_user(karg->ca_export.ex_flags,
-		      &arg32->ca32_export.ex32_flags);
-	err |= __get_user(karg->ca_export.ex_anon_uid,
-		      &arg32->ca32_export.ex32_anon_uid);
-	err |= __get_user(karg->ca_export.ex_anon_gid,
-		      &arg32->ca32_export.ex32_anon_gid);
-	karg->ca_export.ex_anon_uid = karg->ca_export.ex_anon_uid;
-	karg->ca_export.ex_anon_gid = karg->ca_export.ex_anon_gid;
-
-	if(err) return -EFAULT;
-	return 0;
-}
-
-static int nfs_getfd32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = __get_user(karg->ca_version, &arg32->ca32_version);
-	err |= copy_from_user(&karg->ca_getfd.gd_addr,
-			  &arg32->ca32_getfd.gd32_addr,
-			  (sizeof(struct sockaddr)));
-	err |= copy_from_user(&karg->ca_getfd.gd_path,
-			  &arg32->ca32_getfd.gd32_path,
-			  (NFS_MAXPATHLEN+1));
-	err |= __get_user(karg->ca_getfd.gd_version,
-		      &arg32->ca32_getfd.gd32_version);
-
-	if(err) return -EFAULT;
-	return 0;
-}
-
-static int nfs_getfs32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = __get_user(karg->ca_version, &arg32->ca32_version);
-	err |= copy_from_user(&karg->ca_getfs.gd_addr,
-			  &arg32->ca32_getfs.gd32_addr,
-			  (sizeof(struct sockaddr)));
-	err |= copy_from_user(&karg->ca_getfs.gd_path,
-			  &arg32->ca32_getfs.gd32_path,
-			  (NFS_MAXPATHLEN+1));
-	err |= __get_user(karg->ca_getfs.gd_maxlen,
-		      &arg32->ca32_getfs.gd32_maxlen);
-
-	if(err) return -EFAULT;
-	return 0;
-}
-
-/* This really doesn't need translations, we are only passing
- * back a union which contains opaque nfs file handle data.
- */
-static int nfs_getfh32_res_trans(union nfsctl_res *kres, union nfsctl_res32 *res32)
-{
-	int err;
-
-	err = copy_to_user(res32, kres, sizeof(*res32));
-
-	if(err) return -EFAULT;
-	return 0;
-}
-
-/* Note: it is necessary to treat cmd_parm as an unsigned int, 
- * with the corresponding cast to a signed int to insure that the 
- * proper conversion (sign extension) between the register representation of a signed int (msr in 32-bit mode)
- * and the register representation of a signed int (msr in 64-bit mode) is performed.
- */
-int asmlinkage sys32_nfsservctl(u32 cmd_parm, struct nfsctl_arg32 *arg32, union nfsctl_res32 *res32)
-{
-  int cmd = (int)cmd_parm;
-	struct nfsctl_arg *karg = NULL;
-	union nfsctl_res *kres = NULL;
-	mm_segment_t oldfs;
-	int err;
-
-	karg = kmalloc(sizeof(*karg), GFP_USER);
-	if(!karg)
-		return -ENOMEM;
-	if(res32) {
-		kres = kmalloc(sizeof(*kres), GFP_USER);
-		if(!kres) {
-			kfree(karg);
-			return -ENOMEM;
-		}
-	}
-	switch(cmd) {
-	case NFSCTL_SVC:
-		err = nfs_svc32_trans(karg, arg32);
-		break;
-	case NFSCTL_ADDCLIENT:
-		err = nfs_clnt32_trans(karg, arg32);
-		break;
-	case NFSCTL_DELCLIENT:
-		err = nfs_clnt32_trans(karg, arg32);
-		break;
-	case NFSCTL_EXPORT:
-	case NFSCTL_UNEXPORT:
-		err = nfs_exp32_trans(karg, arg32);
-		break;
-	case NFSCTL_GETFD:
-		err = nfs_getfd32_trans(karg, arg32);
-		break;
-	case NFSCTL_GETFS:
-		err = nfs_getfs32_trans(karg, arg32);
-		break;
-	default:
-		err = -EINVAL;
-		break;
-	}
-	if(err)
-		goto done;
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sys_nfsservctl(cmd, karg, kres);
-	set_fs(oldfs);
-
-	if (err)
-		goto done;
-
-	if((cmd == NFSCTL_GETFD) ||
-	   (cmd == NFSCTL_GETFS))
-		err = nfs_getfh32_res_trans(kres, res32);
-
-done:
-	if(karg)
-		kfree(karg);
-	if(kres)
-		kfree(kres);
-	return err;
-}
-
-
 
 /* These are here just in case some old sparc32 binary calls it. */
 asmlinkage long sys32_pause(void)
===== arch/s390/kernel/compat_linux.c 1.21 vs edited =====
--- 1.21/arch/s390/kernel/compat_linux.c	Thu Apr 15 19:30:49 2004
+++ edited/arch/s390/kernel/compat_linux.c	Thu Apr 15 17:37:01 2004
@@ -815,226 +815,6 @@
 
 #endif  /* CONFIG_MODULES */
 
-/* Stuff for NFS server syscalls... */
-struct nfsctl_svc32 {
-	u16			svc32_port;
-	s32			svc32_nthreads;
-};
-
-struct nfsctl_client32 {
-	s8			cl32_ident[NFSCLNT_IDMAX+1];
-	s32			cl32_naddr;
-	struct in_addr		cl32_addrlist[NFSCLNT_ADDRMAX];
-	s32			cl32_fhkeytype;
-	s32			cl32_fhkeylen;
-	u8			cl32_fhkey[NFSCLNT_KEYMAX];
-};
-
-struct nfsctl_export32 {
-	s8			ex32_client[NFSCLNT_IDMAX+1];
-	s8			ex32_path[NFS_MAXPATHLEN+1];
-	compat_dev_t	ex32_dev;
-	compat_ino_t	ex32_ino;
-	s32			ex32_flags;
-	compat_uid_t	ex32_anon_uid;
-	compat_gid_t	ex32_anon_gid;
-};
-
-struct nfsctl_fdparm32 {
-	struct sockaddr		gd32_addr;
-	s8			gd32_path[NFS_MAXPATHLEN+1];
-	s32			gd32_version;
-};
-
-struct nfsctl_fsparm32 {
-	struct sockaddr		gd32_addr;
-	s8			gd32_path[NFS_MAXPATHLEN+1];
-	s32			gd32_maxlen;
-};
-
-struct nfsctl_arg32 {
-	s32			ca32_version;	/* safeguard */
-	union {
-		struct nfsctl_svc32	u32_svc;
-		struct nfsctl_client32	u32_client;
-		struct nfsctl_export32	u32_export;
-		struct nfsctl_fdparm32	u32_getfd;
-		struct nfsctl_fsparm32	u32_getfs;
-	} u;
-#define ca32_svc	u.u32_svc
-#define ca32_client	u.u32_client
-#define ca32_export	u.u32_export
-#define ca32_getfd	u.u32_getfd
-#define ca32_getfs	u.u32_getfs
-#define ca32_authd	u.u32_authd
-};
-
-union nfsctl_res32 {
-	__u8			cr32_getfh[NFS_FHSIZE];
-	struct knfsd_fh		cr32_getfs;
-};
-
-static int nfs_svc32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = __get_user(karg->ca_version, &arg32->ca32_version);
-	err |= __get_user(karg->ca_svc.svc_port, &arg32->ca32_svc.svc32_port);
-	err |= __get_user(karg->ca_svc.svc_nthreads, &arg32->ca32_svc.svc32_nthreads);
-	return err;
-}
-
-static int nfs_clnt32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = __get_user(karg->ca_version, &arg32->ca32_version);
-	err |= copy_from_user(&karg->ca_client.cl_ident[0],
-			  &arg32->ca32_client.cl32_ident[0],
-			  NFSCLNT_IDMAX);
-	err |= __get_user(karg->ca_client.cl_naddr, &arg32->ca32_client.cl32_naddr);
-	err |= copy_from_user(&karg->ca_client.cl_addrlist[0],
-			  &arg32->ca32_client.cl32_addrlist[0],
-			  (sizeof(struct in_addr) * NFSCLNT_ADDRMAX));
-	err |= __get_user(karg->ca_client.cl_fhkeytype,
-		      &arg32->ca32_client.cl32_fhkeytype);
-	err |= __get_user(karg->ca_client.cl_fhkeylen,
-		      &arg32->ca32_client.cl32_fhkeylen);
-	err |= copy_from_user(&karg->ca_client.cl_fhkey[0],
-			  &arg32->ca32_client.cl32_fhkey[0],
-			  NFSCLNT_KEYMAX);
-	return err;
-}
-
-static int nfs_exp32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = __get_user(karg->ca_version, &arg32->ca32_version);
-	err |= copy_from_user(&karg->ca_export.ex_client[0],
-			  &arg32->ca32_export.ex32_client[0],
-			  NFSCLNT_IDMAX);
-	err |= copy_from_user(&karg->ca_export.ex_path[0],
-			  &arg32->ca32_export.ex32_path[0],
-			  NFS_MAXPATHLEN);
-	err |= __get_user(karg->ca_export.ex_dev,
-		      &arg32->ca32_export.ex32_dev);
-	err |= __get_user(karg->ca_export.ex_ino,
-		      &arg32->ca32_export.ex32_ino);
-	err |= __get_user(karg->ca_export.ex_flags,
-		      &arg32->ca32_export.ex32_flags);
-	err |= __get_user(karg->ca_export.ex_anon_uid,
-		      &arg32->ca32_export.ex32_anon_uid);
-	err |= __get_user(karg->ca_export.ex_anon_gid,
-		      &arg32->ca32_export.ex32_anon_gid);
-	karg->ca_export.ex_anon_uid = high2lowuid(karg->ca_export.ex_anon_uid);
-	karg->ca_export.ex_anon_gid = high2lowgid(karg->ca_export.ex_anon_gid);
-	return err;
-}
-
-static int nfs_getfd32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = __get_user(karg->ca_version, &arg32->ca32_version);
-	err |= copy_from_user(&karg->ca_getfd.gd_addr,
-			  &arg32->ca32_getfd.gd32_addr,
-			  (sizeof(struct sockaddr)));
-	err |= copy_from_user(&karg->ca_getfd.gd_path,
-			  &arg32->ca32_getfd.gd32_path,
-			  (NFS_MAXPATHLEN+1));
-	err |= __get_user(karg->ca_getfd.gd_version,
-		      &arg32->ca32_getfd.gd32_version);
-	return err;
-}
-
-static int nfs_getfs32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = __get_user(karg->ca_version, &arg32->ca32_version);
-	err |= copy_from_user(&karg->ca_getfs.gd_addr,
-			  &arg32->ca32_getfs.gd32_addr,
-			  (sizeof(struct sockaddr)));
-	err |= copy_from_user(&karg->ca_getfs.gd_path,
-			  &arg32->ca32_getfs.gd32_path,
-			  (NFS_MAXPATHLEN+1));
-	err |= __get_user(karg->ca_getfs.gd_maxlen,
-		      &arg32->ca32_getfs.gd32_maxlen);
-	return err;
-}
-
-/* This really doesn't need translations, we are only passing
- * back a union which contains opaque nfs file handle data.
- */
-static int nfs_getfh32_res_trans(union nfsctl_res *kres, union nfsctl_res32 *res32)
-{
-	return copy_to_user(res32, kres, sizeof(*res32)) ? -EFAULT : 0;
-}
-
-long asmlinkage sys32_nfsservctl(int cmd, struct nfsctl_arg32 *arg32, union nfsctl_res32 *res32)
-{
-	struct nfsctl_arg *karg = NULL;
-	union nfsctl_res *kres = NULL;
-	mm_segment_t oldfs;
-	int err;
-
-	karg = kmalloc(sizeof(*karg), GFP_USER);
-	if(!karg)
-		return -ENOMEM;
-	if(res32) {
-		kres = kmalloc(sizeof(*kres), GFP_USER);
-		if(!kres) {
-			kfree(karg);
-			return -ENOMEM;
-		}
-	}
-	switch(cmd) {
-	case NFSCTL_SVC:
-		err = nfs_svc32_trans(karg, arg32);
-		break;
-	case NFSCTL_ADDCLIENT:
-		err = nfs_clnt32_trans(karg, arg32);
-		break;
-	case NFSCTL_DELCLIENT:
-		err = nfs_clnt32_trans(karg, arg32);
-		break;
-	case NFSCTL_EXPORT:
-	case NFSCTL_UNEXPORT:
-		err = nfs_exp32_trans(karg, arg32);
-		break;
-	case NFSCTL_GETFD:
-		err = nfs_getfd32_trans(karg, arg32);
-		break;
-	case NFSCTL_GETFS:
-		err = nfs_getfs32_trans(karg, arg32);
-		break;
-	default:
-		err = -EINVAL;
-		break;
-	}
-	if(err)
-		goto done;
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sys_nfsservctl(cmd, karg, kres);
-	set_fs(oldfs);
-
-	if (err)
-		goto done;
-
-	if((cmd == NFSCTL_GETFD) ||
-	   (cmd == NFSCTL_GETFS))
-		err = nfs_getfh32_res_trans(kres, res32);
-
-done:
-	if(karg)
-		kfree(karg);
-	if(kres)
-		kfree(kres);
-	return err;
-}
-
 /* Translations due to time_t size differences.  Which affects all
    sorts of things, like timeval and itimerval.  */
 
===== arch/s390/kernel/compat_wrapper.S 1.11 vs edited =====
--- 1.11/arch/s390/kernel/compat_wrapper.S	Thu Apr 15 19:30:49 2004
+++ edited/arch/s390/kernel/compat_wrapper.S	Thu Apr 15 17:37:01 2004
@@ -786,12 +786,12 @@
 	lgfr	%r4,%r4			# long 
 	jg	sys_poll		# branch to system call
 
-	.globl  sys32_nfsservctl_wrapper 
-sys32_nfsservctl_wrapper:
+	.globl  compat_sys_nfsservctl_wrapper 
+compat_sys_nfsservctl_wrapper:
 	lgfr	%r2,%r2			# int 
-	llgtr	%r3,%r3			# struct nfsctl_arg_emu31 * 
-	llgtr	%r4,%r4			# union nfsctl_res_emu31 * 
-	jg	sys32_nfsservctl	# branch to system call
+	llgtr	%r3,%r3			# struct compat_nfsctl_arg* 
+	llgtr	%r4,%r4			# union compat_nfsctl_res* 
+	jg	compat_sys_nfsservctl	# branch to system call
 
 	.globl  sys32_setresgid16_wrapper 
 sys32_setresgid16_wrapper:
===== arch/s390/kernel/syscalls.S 1.11 vs edited =====
--- 1.11/arch/s390/kernel/syscalls.S	Thu Apr 15 19:30:49 2004
+++ edited/arch/s390/kernel/syscalls.S	Thu Apr 15 17:37:01 2004
@@ -177,7 +177,7 @@
 NI_SYSCALL							/* for vm86 */
 NI_SYSCALL							/* old sys_query_module */
 SYSCALL(sys_poll,sys_poll,sys32_poll_wrapper)
-SYSCALL(sys_nfsservctl,sys_nfsservctl,sys32_nfsservctl_wrapper)
+SYSCALL(sys_nfsservctl,sys_nfsservctl,compat_sys_nfsservctl_wrapper)
 SYSCALL(sys_setresgid16,sys_ni_syscall,sys32_setresgid16_wrapper)	/* 170 old setresgid16 syscall */
 SYSCALL(sys_getresgid16,sys_ni_syscall,sys32_getresgid16_wrapper)	/* old getresgid16 syscall */
 SYSCALL(sys_prctl,sys_prctl,sys32_prctl_wrapper)
===== arch/sparc64/kernel/sys_sparc32.c 1.97 vs edited =====
--- 1.97/arch/sparc64/kernel/sys_sparc32.c	Thu Apr 15 19:30:49 2004
+++ edited/arch/sparc64/kernel/sys_sparc32.c	Thu Apr 15 17:37:01 2004
@@ -1392,232 +1392,6 @@
 
 #endif  /* CONFIG_MODULES */
 
-#if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
-/* Stuff for NFS server syscalls... */
-struct nfsctl_svc32 {
-	u16			svc32_port;
-	s32			svc32_nthreads;
-};
-
-struct nfsctl_client32 {
-	s8			cl32_ident[NFSCLNT_IDMAX+1];
-	s32			cl32_naddr;
-	struct in_addr		cl32_addrlist[NFSCLNT_ADDRMAX];
-	s32			cl32_fhkeytype;
-	s32			cl32_fhkeylen;
-	u8			cl32_fhkey[NFSCLNT_KEYMAX];
-};
-
-struct nfsctl_export32 {
-	s8			ex32_client[NFSCLNT_IDMAX+1];
-	s8			ex32_path[NFS_MAXPATHLEN+1];
-	compat_dev_t	ex32_dev;
-	compat_ino_t	ex32_ino;
-	s32			ex32_flags;
-	compat_uid_t	ex32_anon_uid;
-	compat_gid_t	ex32_anon_gid;
-};
-
-struct nfsctl_fdparm32 {
-	struct sockaddr		gd32_addr;
-	s8			gd32_path[NFS_MAXPATHLEN+1];
-	s32			gd32_version;
-};
-
-struct nfsctl_fsparm32 {
-	struct sockaddr		gd32_addr;
-	s8			gd32_path[NFS_MAXPATHLEN+1];
-	s32			gd32_maxlen;
-};
-
-struct nfsctl_arg32 {
-	s32			ca32_version;	/* safeguard */
-	union {
-		struct nfsctl_svc32	u32_svc;
-		struct nfsctl_client32	u32_client;
-		struct nfsctl_export32	u32_export;
-		struct nfsctl_fdparm32	u32_getfd;
-		struct nfsctl_fsparm32	u32_getfs;
-	} u;
-#define ca32_svc	u.u32_svc
-#define ca32_client	u.u32_client
-#define ca32_export	u.u32_export
-#define ca32_getfd	u.u32_getfd
-#define ca32_getfs	u.u32_getfs
-};
-
-union nfsctl_res32 {
-	__u8			cr32_getfh[NFS_FHSIZE];
-	struct knfsd_fh		cr32_getfs;
-};
-
-static int nfs_svc32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = __get_user(karg->ca_version, &arg32->ca32_version);
-	err |= __get_user(karg->ca_svc.svc_port, &arg32->ca32_svc.svc32_port);
-	err |= __get_user(karg->ca_svc.svc_nthreads, &arg32->ca32_svc.svc32_nthreads);
-	return err;
-}
-
-static int nfs_clnt32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = __get_user(karg->ca_version, &arg32->ca32_version);
-	err |= copy_from_user(&karg->ca_client.cl_ident[0],
-			  &arg32->ca32_client.cl32_ident[0],
-			  NFSCLNT_IDMAX);
-	err |= __get_user(karg->ca_client.cl_naddr, &arg32->ca32_client.cl32_naddr);
-	err |= copy_from_user(&karg->ca_client.cl_addrlist[0],
-			  &arg32->ca32_client.cl32_addrlist[0],
-			  (sizeof(struct in_addr) * NFSCLNT_ADDRMAX));
-	err |= __get_user(karg->ca_client.cl_fhkeytype,
-		      &arg32->ca32_client.cl32_fhkeytype);
-	err |= __get_user(karg->ca_client.cl_fhkeylen,
-		      &arg32->ca32_client.cl32_fhkeylen);
-	err |= copy_from_user(&karg->ca_client.cl_fhkey[0],
-			  &arg32->ca32_client.cl32_fhkey[0],
-			  NFSCLNT_KEYMAX);
-	return (err ? -EFAULT : 0);
-}
-
-static int nfs_exp32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = __get_user(karg->ca_version, &arg32->ca32_version);
-	err |= copy_from_user(&karg->ca_export.ex_client[0],
-			  &arg32->ca32_export.ex32_client[0],
-			  NFSCLNT_IDMAX);
-	err |= copy_from_user(&karg->ca_export.ex_path[0],
-			  &arg32->ca32_export.ex32_path[0],
-			  NFS_MAXPATHLEN);
-	err |= __get_user(karg->ca_export.ex_dev,
-		      &arg32->ca32_export.ex32_dev);
-	err |= __get_user(karg->ca_export.ex_ino,
-		      &arg32->ca32_export.ex32_ino);
-	err |= __get_user(karg->ca_export.ex_flags,
-		      &arg32->ca32_export.ex32_flags);
-	err |= __get_user(karg->ca_export.ex_anon_uid,
-		      &arg32->ca32_export.ex32_anon_uid);
-	err |= __get_user(karg->ca_export.ex_anon_gid,
-		      &arg32->ca32_export.ex32_anon_gid);
-	karg->ca_export.ex_anon_uid = high2lowuid(karg->ca_export.ex_anon_uid);
-	karg->ca_export.ex_anon_gid = high2lowgid(karg->ca_export.ex_anon_gid);
-	return (err ? -EFAULT : 0);
-}
-
-static int nfs_getfd32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = __get_user(karg->ca_version, &arg32->ca32_version);
-	err |= copy_from_user(&karg->ca_getfd.gd_addr,
-			  &arg32->ca32_getfd.gd32_addr,
-			  (sizeof(struct sockaddr)));
-	err |= copy_from_user(&karg->ca_getfd.gd_path,
-			  &arg32->ca32_getfd.gd32_path,
-			  (NFS_MAXPATHLEN+1));
-	err |= __get_user(karg->ca_getfd.gd_version,
-		      &arg32->ca32_getfd.gd32_version);
-	return (err ? -EFAULT : 0);
-}
-
-static int nfs_getfs32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = __get_user(karg->ca_version, &arg32->ca32_version);
-	err |= copy_from_user(&karg->ca_getfs.gd_addr,
-			  &arg32->ca32_getfs.gd32_addr,
-			  (sizeof(struct sockaddr)));
-	err |= copy_from_user(&karg->ca_getfs.gd_path,
-			  &arg32->ca32_getfs.gd32_path,
-			  (NFS_MAXPATHLEN+1));
-	err |= __get_user(karg->ca_getfs.gd_maxlen,
-		      &arg32->ca32_getfs.gd32_maxlen);
-	return (err ? -EFAULT : 0);
-}
-
-/* This really doesn't need translations, we are only passing
- * back a union which contains opaque nfs file handle data.
- */
-static int nfs_getfh32_res_trans(union nfsctl_res *kres, union nfsctl_res32 *res32)
-{
-	return (copy_to_user(res32, kres, sizeof(*res32)) ? -EFAULT : 0);
-}
-
-int asmlinkage sys32_nfsservctl(int cmd, struct nfsctl_arg32 *arg32, union nfsctl_res32 *res32)
-{
-	struct nfsctl_arg *karg = NULL;
-	union nfsctl_res *kres = NULL;
-	mm_segment_t oldfs;
-	int err;
-
-	karg = kmalloc(sizeof(*karg), GFP_USER);
-	if(!karg)
-		return -ENOMEM;
-	if(res32) {
-		kres = kmalloc(sizeof(*kres), GFP_USER);
-		if(!kres) {
-			kfree(karg);
-			return -ENOMEM;
-		}
-	}
-	switch(cmd) {
-	case NFSCTL_SVC:
-		err = nfs_svc32_trans(karg, arg32);
-		break;
-	case NFSCTL_ADDCLIENT:
-		err = nfs_clnt32_trans(karg, arg32);
-		break;
-	case NFSCTL_DELCLIENT:
-		err = nfs_clnt32_trans(karg, arg32);
-		break;
-	case NFSCTL_EXPORT:
-	case NFSCTL_UNEXPORT:
-		err = nfs_exp32_trans(karg, arg32);
-		break;
-	case NFSCTL_GETFD:
-		err = nfs_getfd32_trans(karg, arg32);
-		break;
-	case NFSCTL_GETFS:
-		err = nfs_getfs32_trans(karg, arg32);
-		break;
-	default:
-		err = -EINVAL;
-		break;
-	}
-	if(err)
-		goto done;
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sys_nfsservctl(cmd, karg, kres);
-	set_fs(oldfs);
-
-	if (err)
-		goto done;
-
-	if((cmd == NFSCTL_GETFD) ||
-	   (cmd == NFSCTL_GETFS))
-		err = nfs_getfh32_res_trans(kres, res32);
-
-done:
-	if(karg)
-		kfree(karg);
-	if(kres)
-		kfree(kres);
-	return err;
-}
-#else /* !NFSD */
-int asmlinkage sys32_nfsservctl(int cmd, void *notused, void *notused2)
-{
-	return sys_ni_syscall();
-}
-#endif
-
 /* Translations due to time_t size differences.  Which affects all
    sorts of things, like timeval and itimerval.  */
 
===== arch/sparc64/kernel/systbls.S 1.54 vs edited =====
--- 1.54/arch/sparc64/kernel/systbls.S	Thu Apr 15 19:30:49 2004
+++ edited/arch/sparc64/kernel/systbls.S	Thu Apr 15 17:37:01 2004
@@ -69,7 +69,7 @@
 	.word compat_fstatfs64, sys_llseek, sys_mlock, sys_munlock, sys_mlockall
 /*240*/	.word sys_munlockall, sys_sched_setparam, sys_sched_getparam, sys_sched_setscheduler, sys_sched_getscheduler
 	.word sys_sched_yield, sys_sched_get_priority_max, sys_sched_get_priority_min, sys32_sched_rr_get_interval, compat_sys_nanosleep
-/*250*/	.word sys32_mremap, sys32_sysctl, sys_getsid, sys_fdatasync, sys32_nfsservctl
+/*250*/	.word sys32_mremap, sys32_sysctl, sys_getsid, sys_fdatasync, compat_sys_nfsservctl
 	.word sys_ni_syscall, compat_clock_settime, compat_clock_gettime, compat_clock_getres, compat_clock_nanosleep
 /*260*/	.word compat_sys_sched_getaffinity, compat_sys_sched_setaffinity, compat_timer_settime, compat_timer_gettime, sys_timer_getoverrun
 	.word sys_timer_delete, sys32_timer_create, sys_ni_syscall, compat_sys_io_setup, sys_io_destroy
===== arch/x86_64/ia32/ia32entry.S 1.33 vs edited =====
--- 1.33/arch/x86_64/ia32/ia32entry.S	Thu Apr 15 19:30:49 2004
+++ edited/arch/x86_64/ia32/ia32entry.S	Thu Apr 15 17:37:01 2004
@@ -474,7 +474,7 @@
 	.quad sys32_vm86_warning	/* vm86 */ 
 	.quad quiet_ni_syscall	/* query_module */
 	.quad sys_poll
-	.quad sys32_nfsservctl
+	.quad compat_sys_nfsservctl
 	.quad sys_setresgid16	/* 170 */
 	.quad sys_getresgid16
 	.quad sys_prctl
===== arch/x86_64/ia32/sys_ia32.c 1.59 vs edited =====
--- 1.59/arch/x86_64/ia32/sys_ia32.c	Thu Apr 15 19:30:49 2004
+++ edited/arch/x86_64/ia32/sys_ia32.c	Thu Apr 15 17:37:01 2004
@@ -1166,233 +1166,6 @@
 }
  
 
-#if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
-/* Stuff for NFS server syscalls... */
-struct nfsctl_svc32 {
-	u16			svc32_port;
-	s32			svc32_nthreads;
-};
-
-struct nfsctl_client32 {
-	s8			cl32_ident[NFSCLNT_IDMAX+1];
-	s32			cl32_naddr;
-	struct in_addr		cl32_addrlist[NFSCLNT_ADDRMAX];
-	s32			cl32_fhkeytype;
-	s32			cl32_fhkeylen;
-	u8			cl32_fhkey[NFSCLNT_KEYMAX];
-};
-
-struct nfsctl_export32 {
-	s8			ex32_client[NFSCLNT_IDMAX+1];
-	s8			ex32_path[NFS_MAXPATHLEN+1];
-	compat_dev_t	ex32_dev;
-	compat_ino_t	ex32_ino;
-	s32			ex32_flags;
-	compat_pid_t	ex32_anon_uid;
-	compat_gid_t	ex32_anon_gid;
-};
-
-struct nfsctl_fdparm32 {
-	struct sockaddr		gd32_addr;
-	s8			gd32_path[NFS_MAXPATHLEN+1];
-	s32			gd32_version;
-};
-
-struct nfsctl_fsparm32 {
-	struct sockaddr		gd32_addr;
-	s8			gd32_path[NFS_MAXPATHLEN+1];
-	s32			gd32_maxlen;
-};
-
-struct nfsctl_arg32 {
-	s32			ca32_version;	/* safeguard */
-	union {
-		struct nfsctl_svc32	u32_svc;
-		struct nfsctl_client32	u32_client;
-		struct nfsctl_export32	u32_export;
-		struct nfsctl_fdparm32	u32_getfd;
-		struct nfsctl_fsparm32	u32_getfs;
-	} u;
-#define ca32_svc	u.u32_svc
-#define ca32_client	u.u32_client
-#define ca32_export	u.u32_export
-#define ca32_getfd	u.u32_getfd
-#define ca32_getfs	u.u32_getfs
-};
-
-union nfsctl_res32 {
-	__u8			cr32_getfh[NFS_FHSIZE];
-	struct knfsd_fh		cr32_getfs;
-};
-
-static int nfs_svc32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = get_user(karg->ca_version, &arg32->ca32_version);
-	err |= __get_user(karg->ca_svc.svc_port, &arg32->ca32_svc.svc32_port);
-	err |= __get_user(karg->ca_svc.svc_nthreads, &arg32->ca32_svc.svc32_nthreads);
-	return err;
-}
-
-static int nfs_clnt32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = get_user(karg->ca_version, &arg32->ca32_version);
-	err |= copy_from_user(&karg->ca_client.cl_ident[0],
-			  &arg32->ca32_client.cl32_ident[0],
-			  NFSCLNT_IDMAX);
-	err |= __get_user(karg->ca_client.cl_naddr, &arg32->ca32_client.cl32_naddr);
-	err |= copy_from_user(&karg->ca_client.cl_addrlist[0],
-			  &arg32->ca32_client.cl32_addrlist[0],
-			  (sizeof(struct in_addr) * NFSCLNT_ADDRMAX));
-	err |= __get_user(karg->ca_client.cl_fhkeytype,
-		      &arg32->ca32_client.cl32_fhkeytype);
-	err |= __get_user(karg->ca_client.cl_fhkeylen,
-		      &arg32->ca32_client.cl32_fhkeylen);
-	err |= copy_from_user(&karg->ca_client.cl_fhkey[0],
-			  &arg32->ca32_client.cl32_fhkey[0],
-			  NFSCLNT_KEYMAX);
-	return err;
-}
-
-static int nfs_exp32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = get_user(karg->ca_version, &arg32->ca32_version);
-	err |= copy_from_user(&karg->ca_export.ex_client[0],
-			  &arg32->ca32_export.ex32_client[0],
-			  NFSCLNT_IDMAX);
-	err |= copy_from_user(&karg->ca_export.ex_path[0],
-			  &arg32->ca32_export.ex32_path[0],
-			  NFS_MAXPATHLEN);
-	err |= __get_user(karg->ca_export.ex_dev,
-		      &arg32->ca32_export.ex32_dev);
-	err |= __get_user(karg->ca_export.ex_ino,
-		      &arg32->ca32_export.ex32_ino);
-	err |= __get_user(karg->ca_export.ex_flags,
-		      &arg32->ca32_export.ex32_flags);
-	err |= __get_user(karg->ca_export.ex_anon_uid,
-		      &arg32->ca32_export.ex32_anon_uid);
-	err |= __get_user(karg->ca_export.ex_anon_gid,
-		      &arg32->ca32_export.ex32_anon_gid);
-	SET_UID(karg->ca_export.ex_anon_uid, karg->ca_export.ex_anon_uid);
-	SET_GID(karg->ca_export.ex_anon_gid, karg->ca_export.ex_anon_gid);
-	return err;
-}
-
-
-static int nfs_getfd32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = get_user(karg->ca_version, &arg32->ca32_version);
-	err |= copy_from_user(&karg->ca_getfd.gd_addr,
-			  &arg32->ca32_getfd.gd32_addr,
-			  (sizeof(struct sockaddr)));
-	err |= copy_from_user(&karg->ca_getfd.gd_path,
-			  &arg32->ca32_getfd.gd32_path,
-			  (NFS_MAXPATHLEN+1));
-	err |= get_user(karg->ca_getfd.gd_version,
-		      &arg32->ca32_getfd.gd32_version);
-	return err;
-}
-
-static int nfs_getfs32_trans(struct nfsctl_arg *karg, struct nfsctl_arg32 *arg32)
-{
-	int err;
-	
-	err = get_user(karg->ca_version, &arg32->ca32_version);
-	err |= copy_from_user(&karg->ca_getfs.gd_addr,
-			  &arg32->ca32_getfs.gd32_addr,
-			  (sizeof(struct sockaddr)));
-	err |= copy_from_user(&karg->ca_getfs.gd_path,
-			  &arg32->ca32_getfs.gd32_path,
-			  (NFS_MAXPATHLEN+1));
-	err |= get_user(karg->ca_getfs.gd_maxlen,
-		      &arg32->ca32_getfs.gd32_maxlen);
-	return err;
-}
-
-/* This really doesn't need translations, we are only passing
- * back a union which contains opaque nfs file handle data.
- */
-static int nfs_getfh32_res_trans(union nfsctl_res *kres, union nfsctl_res32 *res32)
-{
-	return copy_to_user(res32, kres, sizeof(*res32)) ? -EFAULT : 0;
-}
-
-long asmlinkage sys32_nfsservctl(int cmd, struct nfsctl_arg32 *arg32, union nfsctl_res32 *res32)
-{
-	struct nfsctl_arg *karg = NULL;
-	union nfsctl_res *kres = NULL;
-	mm_segment_t oldfs;
-	int err;
-
-	karg = kmalloc(sizeof(*karg), GFP_USER);
-	if(!karg)
-		return -ENOMEM;
-	if(res32) {
-		kres = kmalloc(sizeof(*kres), GFP_USER);
-		if(!kres) {
-			kfree(karg);
-			return -ENOMEM;
-		}
-	}
-	switch(cmd) {
-	case NFSCTL_SVC:
-		err = nfs_svc32_trans(karg, arg32);
-		break;
-	case NFSCTL_ADDCLIENT:
-		err = nfs_clnt32_trans(karg, arg32);
-		break;
-	case NFSCTL_DELCLIENT:
-		err = nfs_clnt32_trans(karg, arg32);
-		break;
-	case NFSCTL_EXPORT:
-	case NFSCTL_UNEXPORT:
-		err = nfs_exp32_trans(karg, arg32);
-		break;
-	case NFSCTL_GETFD:
-		err = nfs_getfd32_trans(karg, arg32);
-		break;
-	case NFSCTL_GETFS:
-		err = nfs_getfs32_trans(karg, arg32);
-		break;
-	default:
-		err = -EINVAL;
-		break;
-	}
-	if(err)
-		goto done;
-	oldfs = get_fs();
-	set_fs(KERNEL_DS);
-	err = sys_nfsservctl(cmd, karg, kres);
-	set_fs(oldfs);
-
-	if (err)
-		goto done;
-
-	if((cmd == NFSCTL_GETFD) ||
-	   (cmd == NFSCTL_GETFS))
-		err = nfs_getfh32_res_trans(kres, res32);
-
-done:
-	if(karg)
-		kfree(karg);
-	if(kres)
-		kfree(kres);
-	return err;
-}
-#else /* !NFSD */
-long asmlinkage sys32_nfsservctl(int cmd, void *notused, void *notused2)
-{
-	return sys_ni_syscall();
-}
-#endif
-
 long sys32_io_setup(unsigned nr_reqs, u32 *ctx32p)
 { 
 	long ret; 
===== fs/compat.c 1.24 vs edited =====
--- 1.24/fs/compat.c	Thu Apr 15 19:31:49 2004
+++ edited/fs/compat.c	Thu Apr 15 17:37:01 2004
@@ -1399,3 +1399,242 @@
 	return ret;
 }
 
+#if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
+/* Stuff for NFS server syscalls... */
+struct compat_nfsctl_svc {
+	u16			svc32_port;
+	s32			svc32_nthreads;
+};
+
+struct compat_nfsctl_client {
+	s8			cl32_ident[NFSCLNT_IDMAX+1];
+	s32			cl32_naddr;
+	struct in_addr		cl32_addrlist[NFSCLNT_ADDRMAX];
+	s32			cl32_fhkeytype;
+	s32			cl32_fhkeylen;
+	u8			cl32_fhkey[NFSCLNT_KEYMAX];
+};
+
+struct compat_nfsctl_export {
+	char		ex32_client[NFSCLNT_IDMAX+1];
+	char		ex32_path[NFS_MAXPATHLEN+1];
+	compat_dev_t	ex32_dev;
+	compat_ino_t	ex32_ino;
+	compat_int_t	ex32_flags;
+	compat_uid_t	ex32_anon_uid;
+	compat_gid_t	ex32_anon_gid;
+};
+
+struct compat_nfsctl_fdparm {
+	struct sockaddr		gd32_addr;
+	s8			gd32_path[NFS_MAXPATHLEN+1];
+	compat_int_t		gd32_version;
+};
+
+struct compat_nfsctl_fsparm {
+	struct sockaddr		gd32_addr;
+	s8			gd32_path[NFS_MAXPATHLEN+1];
+	compat_int_t		gd32_maxlen;
+};
+
+struct compat_nfsctl_arg {
+	compat_int_t		ca32_version;	/* safeguard */
+	union {
+		struct compat_nfsctl_svc	u32_svc;
+		struct compat_nfsctl_client	u32_client;
+		struct compat_nfsctl_export	u32_export;
+		struct compat_nfsctl_fdparm	u32_getfd;
+		struct compat_nfsctl_fsparm	u32_getfs;
+	} u;
+#define ca32_svc	u.u32_svc
+#define ca32_client	u.u32_client
+#define ca32_export	u.u32_export
+#define ca32_getfd	u.u32_getfd
+#define ca32_getfs	u.u32_getfs
+};
+
+union compat_nfsctl_res {
+	__u8			cr32_getfh[NFS_FHSIZE];
+	struct knfsd_fh		cr32_getfs;
+};
+
+static int compat_nfs_svc_trans(struct nfsctl_arg *karg, struct compat_nfsctl_arg *arg)
+{
+	int err;
+
+	err = access_ok(VERIFY_READ, &arg->ca32_svc, sizeof(arg->ca32_svc));
+	err |= get_user(karg->ca_version, &arg->ca32_version);
+	err |= __get_user(karg->ca_svc.svc_port, &arg->ca32_svc.svc32_port);
+	err |= __get_user(karg->ca_svc.svc_nthreads, &arg->ca32_svc.svc32_nthreads);
+	return (err) ? -EFAULT : 0;
+}
+
+static int compat_nfs_clnt_trans(struct nfsctl_arg *karg, struct compat_nfsctl_arg *arg)
+{
+	int err;
+
+	err = access_ok(VERIFY_READ, &arg->ca32_client, sizeof(arg->ca32_client));
+	err |= get_user(karg->ca_version, &arg->ca32_version);
+	err |= __copy_from_user(&karg->ca_client.cl_ident[0],
+			  &arg->ca32_client.cl32_ident[0],
+			  NFSCLNT_IDMAX);
+	err |= __get_user(karg->ca_client.cl_naddr, &arg->ca32_client.cl32_naddr);
+	err |= __copy_from_user(&karg->ca_client.cl_addrlist[0],
+			  &arg->ca32_client.cl32_addrlist[0],
+			  (sizeof(struct in_addr) * NFSCLNT_ADDRMAX));
+	err |= __get_user(karg->ca_client.cl_fhkeytype,
+		      &arg->ca32_client.cl32_fhkeytype);
+	err |= __get_user(karg->ca_client.cl_fhkeylen,
+		      &arg->ca32_client.cl32_fhkeylen);
+	err |= __copy_from_user(&karg->ca_client.cl_fhkey[0],
+			  &arg->ca32_client.cl32_fhkey[0],
+			  NFSCLNT_KEYMAX);
+
+	return (err) ? -EFAULT : 0;
+}
+
+static int compat_nfs_exp_trans(struct nfsctl_arg *karg, struct compat_nfsctl_arg *arg)
+{
+	int err;
+
+	err = access_ok(VERIFY_READ, &arg->ca32_export, sizeof(arg->ca32_export));
+	err |= get_user(karg->ca_version, &arg->ca32_version);
+	err |= __copy_from_user(&karg->ca_export.ex_client[0],
+			  &arg->ca32_export.ex32_client[0],
+			  NFSCLNT_IDMAX);
+	err |= __copy_from_user(&karg->ca_export.ex_path[0],
+			  &arg->ca32_export.ex32_path[0],
+			  NFS_MAXPATHLEN);
+	err |= __get_user(karg->ca_export.ex_dev,
+		      &arg->ca32_export.ex32_dev);
+	err |= __get_user(karg->ca_export.ex_ino,
+		      &arg->ca32_export.ex32_ino);
+	err |= __get_user(karg->ca_export.ex_flags,
+		      &arg->ca32_export.ex32_flags);
+	err |= __get_user(karg->ca_export.ex_anon_uid,
+		      &arg->ca32_export.ex32_anon_uid);
+	err |= __get_user(karg->ca_export.ex_anon_gid,
+		      &arg->ca32_export.ex32_anon_gid);
+	SET_UID(karg->ca_export.ex_anon_uid, karg->ca_export.ex_anon_uid);
+	SET_GID(karg->ca_export.ex_anon_gid, karg->ca_export.ex_anon_gid);
+
+	return (err) ? -EFAULT : 0;
+}
+
+static int compat_nfs_getfd_trans(struct nfsctl_arg *karg, struct compat_nfsctl_arg *arg)
+{
+	int err;
+	
+	err = access_ok(VERIFY_READ, &arg->ca32_getfd, sizeof(arg->ca32_getfd));
+	err |= get_user(karg->ca_version, &arg->ca32_version);
+	err |= __copy_from_user(&karg->ca_getfd.gd_addr,
+			  &arg->ca32_getfd.gd32_addr,
+			  (sizeof(struct sockaddr)));
+	err |= __copy_from_user(&karg->ca_getfd.gd_path,
+			  &arg->ca32_getfd.gd32_path,
+			  (NFS_MAXPATHLEN+1));
+	err |= __get_user(karg->ca_getfd.gd_version,
+		      &arg->ca32_getfd.gd32_version);
+
+	return (err) ? -EFAULT : 0;
+}
+
+static int compat_nfs_getfs_trans(struct nfsctl_arg *karg, struct compat_nfsctl_arg *arg)
+{
+	int err;
+
+	err = access_ok(VERIFY_READ, &arg->ca32_getfs, sizeof(arg->ca32_getfs));
+	err |= get_user(karg->ca_version, &arg->ca32_version);
+	err |= __copy_from_user(&karg->ca_getfs.gd_addr,
+			  &arg->ca32_getfs.gd32_addr,
+			  (sizeof(struct sockaddr)));
+	err |= __copy_from_user(&karg->ca_getfs.gd_path,
+			  &arg->ca32_getfs.gd32_path,
+			  (NFS_MAXPATHLEN+1));
+	err |= __get_user(karg->ca_getfs.gd_maxlen,
+		      &arg->ca32_getfs.gd32_maxlen);
+
+	return (err) ? -EFAULT : 0;
+}
+
+/* This really doesn't need translations, we are only passing
+ * back a union which contains opaque nfs file handle data.
+ */
+static int compat_nfs_getfh_res_trans(union nfsctl_res *kres, union compat_nfsctl_res *res)
+{
+	int err;
+
+	err = copy_to_user(res, kres, sizeof(*res));
+
+	return (err) ? -EFAULT : 0;
+}
+
+asmlinkage long compat_sys_nfsservctl(int cmd, struct compat_nfsctl_arg *arg,
+					union compat_nfsctl_res *res)
+{
+	struct nfsctl_arg *karg;
+	union nfsctl_res *kres;
+	mm_segment_t oldfs;
+	int err;
+
+	karg = kmalloc(sizeof(*karg), GFP_USER);
+	kres = kmalloc(sizeof(*kres), GFP_USER);
+	if(!karg || !kres) {
+		err = -ENOMEM;
+		goto done;
+	}
+
+	switch(cmd) {
+	case NFSCTL_SVC:
+		err = compat_nfs_svc_trans(karg, arg);
+		break;
+
+	case NFSCTL_ADDCLIENT:
+		err = compat_nfs_clnt_trans(karg, arg);
+		break;
+
+	case NFSCTL_DELCLIENT:
+		err = compat_nfs_clnt_trans(karg, arg);
+		break;
+
+	case NFSCTL_EXPORT:
+	case NFSCTL_UNEXPORT:
+		err = compat_nfs_exp_trans(karg, arg);
+		break;
+
+	case NFSCTL_GETFD:
+		err = compat_nfs_getfd_trans(karg, arg);
+		break;
+
+	case NFSCTL_GETFS:
+		err = compat_nfs_getfs_trans(karg, arg);
+		break;
+
+	default:
+		err = -EINVAL;
+		goto done;
+	}
+
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	err = sys_nfsservctl(cmd, karg, kres);
+	set_fs(oldfs);
+
+	if (err)
+		goto done;
+
+	if((cmd == NFSCTL_GETFD) ||
+	   (cmd == NFSCTL_GETFS))
+		err = compat_nfs_getfh_res_trans(kres, res);
+
+done:
+	kfree(karg);
+	kfree(kres);
+	return err;
+}
+#else /* !NFSD */
+long asmlinkage compat_sys_nfsservctl(int cmd, void *notused, void *notused2)
+{
+	return sys_ni_syscall();
+}
+#endif

