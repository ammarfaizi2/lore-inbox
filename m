Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbTDQEB1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 00:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262946AbTDQEB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 00:01:27 -0400
Received: from gandalf.tausq.org ([64.81.244.94]:22680 "EHLO pippin.tausq.org")
	by vger.kernel.org with ESMTP id S262908AbTDQEBB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 00:01:01 -0400
Date: Wed, 16 Apr 2003 21:09:26 -0700
From: Randolph Chung <tausq@parisc-linux.org>
To: Linus <torvalds@transmeta.com>, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH][COMPAT] sys_nfsservctl unification
Message-ID: <20030417040926.GT25257@tausq.org>
Reply-To: Randolph Chung <tausq@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP: for PGP key, see http://www.tausq.org/pgp.txt
X-GPG: for GPG key, see http://www.tausq.org/gpg.txt
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the arch-specific sys32_nfsservctl and creates
compat_sys_nfsservctl. It also simplifies the compat function a bit.
Comments appreciated.

Patch against 2.5.67-bk6.

thanks,
randolph
-- 
Randolph Chung
Debian GNU/Linux Developer, hppa/ia64 ports
http://www.tausq.org/


diff -uNrp linux-2.5.67/arch/parisc/kernel/sys_parisc32.c linux-compat/arch/parisc/kernel/sys_parisc32.c
--- linux-2.5.67/arch/parisc/kernel/sys_parisc32.c	2003-04-15 22:41:21.000000000 -0700
+++ linux-compat/arch/parisc/kernel/sys_parisc32.c	2003-04-16 20:38:27.000000000 -0700
@@ -29,19 +29,14 @@
 #include <linux/shm.h>
 #include <linux/slab.h>
 #include <linux/uio.h>
-#include <linux/nfs_fs.h>
 #include <linux/smb_fs.h>
 #include <linux/smb_mount.h>
 #include <linux/ncp_fs.h>
 #include <linux/quota.h>
-#include <linux/sunrpc/svc.h>
-#include <linux/nfsd/nfsd.h>
-#include <linux/nfsd/cache.h>
-#include <linux/nfsd/xdr.h>
-#include <linux/nfsd/syscall.h>
 #include <linux/poll.h>
 #include <linux/personality.h>
 #include <linux/stat.h>
+#include <linux/skbuff.h>
 #include <linux/filter.h>			/* for setsockopt() */
 #include <linux/icmpv6.h>			/* for setsockopt() */
 #include <linux/netfilter_ipv4/ip_queue.h>	/* for setsockopt() */
@@ -73,34 +68,6 @@
 #define DBG(x)
 #endif
 
-/* For this source file, we want overflow handling. */
-
-#undef high2lowuid
-#undef high2lowgid
-#undef low2highuid
-#undef low2highgid
-#undef SET_UID16
-#undef SET_GID16
-#undef NEW_TO_OLD_UID
-#undef NEW_TO_OLD_GID
-#undef SET_OLDSTAT_UID
-#undef SET_OLDSTAT_GID
-#undef SET_STAT_UID
-#undef SET_STAT_GID
-
-#define high2lowuid(uid) ((uid) > 65535) ? (u16)overflowuid : (u16)(uid)
-#define high2lowgid(gid) ((gid) > 65535) ? (u16)overflowgid : (u16)(gid)
-#define low2highuid(uid) ((uid) == (u16)-1) ? (uid_t)-1 : (uid_t)(uid)
-#define low2highgid(gid) ((gid) == (u16)-1) ? (gid_t)-1 : (gid_t)(gid)
-#define SET_UID16(var, uid)	var = high2lowuid(uid)
-#define SET_GID16(var, gid)	var = high2lowgid(gid)
-#define NEW_TO_OLD_UID(uid)	high2lowuid(uid)
-#define NEW_TO_OLD_GID(gid)	high2lowgid(gid)
-#define SET_OLDSTAT_UID(stat, uid)	(stat).st_uid = high2lowuid(uid)
-#define SET_OLDSTAT_GID(stat, gid)	(stat).st_gid = high2lowgid(gid)
-#define SET_STAT_UID(stat, uid)		(stat).st_uid = high2lowuid(uid)
-#define SET_STAT_GID(stat, gid)		(stat).st_gid = high2lowgid(gid)
-
 /*
  * count32() counts the number of arguments/envelopes. It is basically
  *           a copy of count() from fs/exec.c, except that it works
@@ -1270,94 +1237,6 @@ asmlinkage long sys32_msgrcv(int msqid,
 	return err;
 }
 
-/* EXPORT/UNEXPORT */
-struct nfsctl_export32 {
-	char		ex_client[NFSCLNT_IDMAX+1];
-	char		ex_path[NFS_MAXPATHLEN+1];
-	__kernel_dev_t	ex_dev;
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
 #include <linux/quota.h>
 
 struct dqblk32 {
diff -uNrp linux-2.5.67/arch/parisc/kernel/syscall.S linux-compat/arch/parisc/kernel/syscall.S
--- linux-2.5.67/arch/parisc/kernel/syscall.S	2003-04-15 22:41:21.000000000 -0700
+++ linux-compat/arch/parisc/kernel/syscall.S	2003-04-16 20:38:27.000000000 -0700
@@ -547,7 +547,7 @@ sys_call_table:
 	ENTRY_SAME(ni_syscall)		/* query_module */
 	ENTRY_SAME(poll)
 	/* structs contain pointers and an in_addr... */
-	ENTRY_DIFF(nfsservctl)
+	ENTRY_COMP(nfsservctl)
 	ENTRY_SAME(setresgid)		/* 170 */
 	ENTRY_SAME(getresgid)
 	ENTRY_SAME(prctl)
diff -uNrp linux-2.5.67/arch/ppc64/kernel/misc.S linux-compat/arch/ppc64/kernel/misc.S
--- linux-2.5.67/arch/ppc64/kernel/misc.S	2003-04-15 22:41:21.000000000 -0700
+++ linux-compat/arch/ppc64/kernel/misc.S	2003-04-16 20:38:27.000000000 -0700
@@ -670,7 +670,7 @@ _GLOBAL(sys_call_table32)
 	.llong .sys_getresuid	        /* 165 */
 	.llong .sys_ni_syscall		/* old query_module syscall */
 	.llong .sys_poll
-	.llong .sys32_nfsservctl
+	.llong .compat_sys_nfsservctl
 	.llong .sys_setresgid
 	.llong .sys_getresgid	        /* 170 */
 	.llong .sys32_prctl
diff -uNrp linux-2.5.67/arch/ppc64/kernel/sys_ppc32.c linux-compat/arch/ppc64/kernel/sys_ppc32.c
--- linux-2.5.67/arch/ppc64/kernel/sys_ppc32.c	2003-04-15 22:41:21.000000000 -0700
+++ linux-compat/arch/ppc64/kernel/sys_ppc32.c	2003-04-16 20:38:27.000000000 -0700
@@ -859,246 +859,6 @@ asmlinkage long sys32_adjtimex(struct ti
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
diff -uNrp linux-2.5.67/arch/s390/kernel/compat_linux.c linux-compat/arch/s390/kernel/compat_linux.c
--- linux-2.5.67/arch/s390/kernel/compat_linux.c	2003-04-15 22:41:21.000000000 -0700
+++ linux-compat/arch/s390/kernel/compat_linux.c	2003-04-16 20:38:27.000000000 -0700
@@ -2066,230 +2066,6 @@ sys32_delete_module(const char *name_use
 
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
-/*
-asmlinkage long sys_ni_syscall(void); 
-*/
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
-
 /* Translations due to time_t size differences.  Which affects all
    sorts of things, like timeval and itimerval.  */
 
diff -uNrp linux-2.5.67/arch/s390/kernel/compat_wrapper.S linux-compat/arch/s390/kernel/compat_wrapper.S
--- linux-2.5.67/arch/s390/kernel/compat_wrapper.S	2003-04-15 22:41:21.000000000 -0700
+++ linux-compat/arch/s390/kernel/compat_wrapper.S	2003-04-16 20:38:27.000000000 -0700
@@ -782,12 +782,12 @@ sys32_poll_wrapper:
 	lgfr	%r4,%r4			# long 
 	jg	sys_poll		# branch to system call
 
-	.globl  sys32_nfsservctl_wrapper 
-sys32_nfsservctl_wrapper:
+	.globl  compat_sys_nfsservctl_wrapper 
+compat_sys_nfsservctl_wrapper:
 	lgfr	%r2,%r2			# int 
 	llgtr	%r3,%r3			# struct nfsctl_arg_emu31 * 
 	llgtr	%r4,%r4			# union nfsctl_res_emu31 * 
-	jg	sys32_nfsservctl	# branch to system call
+	jg	compat_sys_nfsservctl	# branch to system call
 
 	.globl  sys32_setresgid16_wrapper 
 sys32_setresgid16_wrapper:
diff -uNrp linux-2.5.67/arch/s390/kernel/syscalls.S linux-compat/arch/s390/kernel/syscalls.S
--- linux-2.5.67/arch/s390/kernel/syscalls.S	2003-04-15 22:49:32.000000000 -0700
+++ linux-compat/arch/s390/kernel/syscalls.S	2003-04-16 20:39:12.000000000 -0700
@@ -177,7 +177,7 @@ SYSCALL(sys_getresuid16,sys_ni_syscall,s
 NI_SYSCALL							/* for vm86 */
 NI_SYSCALL							/* old sys_query_module */
 SYSCALL(sys_poll,sys_poll,sys32_poll_wrapper)
-SYSCALL(sys_nfsservctl,sys_nfsservctl,sys32_nfsservctl_wrapper)
+SYSCALL(sys_nfsservctl,sys_nfsservctl,compat_sys_nfsservctl_wrapper)
 SYSCALL(sys_setresgid16,sys_ni_syscall,sys32_setresgid16_wrapper)	/* 170 old setresgid16 syscall */
 SYSCALL(sys_getresgid16,sys_ni_syscall,sys32_getresgid16_wrapper)	/* old getresgid16 syscall */
 SYSCALL(sys_prctl,sys_prctl,sys32_prctl_wrapper)
diff -uNrp linux-2.5.67/arch/sparc64/kernel/sys_sparc32.c linux-compat/arch/sparc64/kernel/sys_sparc32.c
--- linux-2.5.67/arch/sparc64/kernel/sys_sparc32.c	2003-04-15 22:41:22.000000000 -0700
+++ linux-compat/arch/sparc64/kernel/sys_sparc32.c	2003-04-16 20:38:27.000000000 -0700
@@ -2208,234 +2208,6 @@ sys32_delete_module(const char *name_use
 
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
-extern asmlinkage long sys_ni_syscall(void);
-int asmlinkage sys32_nfsservctl(int cmd, void *notused, void *notused2)
-{
-	return sys_ni_syscall();
-}
-#endif
-
 /* Translations due to time_t size differences.  Which affects all
    sorts of things, like timeval and itimerval.  */
 
diff -uNrp linux-2.5.67/arch/sparc64/kernel/systbls.S linux-compat/arch/sparc64/kernel/systbls.S
--- linux-2.5.67/arch/sparc64/kernel/systbls.S	2003-04-15 22:41:22.000000000 -0700
+++ linux-compat/arch/sparc64/kernel/systbls.S	2003-04-16 20:38:27.000000000 -0700
@@ -69,7 +69,7 @@ sys_call_table32:
 	.word sys_ni_syscall, sys_llseek, sys_mlock, sys_munlock, sys_mlockall
 /*240*/	.word sys_munlockall, sys_sched_setparam, sys_sched_getparam, sys_sched_setscheduler, sys_sched_getscheduler
 	.word sys_sched_yield, sys_sched_get_priority_max, sys_sched_get_priority_min, sys32_sched_rr_get_interval, compat_sys_nanosleep
-/*250*/	.word sys32_mremap, sys32_sysctl, sys_getsid, sys_fdatasync, sys32_nfsservctl
+/*250*/	.word sys32_mremap, sys32_sysctl, sys_getsid, sys_fdatasync, compat_sys_nfsservctl
 	.word sys_aplib
 
 	/* Now the 64-bit native Linux syscall table. */
diff -uNrp linux-2.5.67/arch/x86_64/ia32/ia32entry.S linux-compat/arch/x86_64/ia32/ia32entry.S
--- linux-2.5.67/arch/x86_64/ia32/ia32entry.S	2003-04-15 22:41:22.000000000 -0700
+++ linux-compat/arch/x86_64/ia32/ia32entry.S	2003-04-16 20:38:27.000000000 -0700
@@ -373,7 +373,7 @@ ia32_sys_call_table:
 	.quad sys32_vm86_warning	/* vm86 */ 
 	.quad quiet_ni_syscall	/* query_module */
 	.quad sys_poll
-	.quad sys32_nfsservctl
+	.quad compat_sys_nfsservctl
 	.quad sys_setresgid16	/* 170 */
 	.quad sys_getresgid16
 	.quad sys_prctl
diff -uNrp linux-2.5.67/arch/x86_64/ia32/sys_ia32.c linux-compat/arch/x86_64/ia32/sys_ia32.c
--- linux-2.5.67/arch/x86_64/ia32/sys_ia32.c	2003-04-15 22:41:22.000000000 -0700
+++ linux-compat/arch/x86_64/ia32/sys_ia32.c	2003-04-16 20:38:27.000000000 -0700
@@ -1802,235 +1802,6 @@ long sys32_kill(int pid, int sig)
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
-	karg->ca_export.ex_anon_uid = high2lowuid(karg->ca_export.ex_anon_uid);
-	karg->ca_export.ex_anon_gid = high2lowgid(karg->ca_export.ex_anon_gid);
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
-	return copy_to_user(res32, kres, sizeof(*res32));
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
-extern asmlinkage long sys_ni_syscall(void);
-long asmlinkage sys32_nfsservctl(int cmd, void *notused, void *notused2)
-{
-	return sys_ni_syscall();
-}
-#endif
-
 long sys32_module_warning(void)
 { 
 		printk(KERN_INFO "%s: 32bit 2.4.x modutils not supported on 64bit kernel\n",
diff -uNrp linux-2.5.67/fs/compat.c linux-compat/fs/compat.c
--- linux-2.5.67/fs/compat.c	2003-04-07 10:31:15.000000000 -0700
+++ linux-compat/fs/compat.c	2003-04-16 20:38:27.000000000 -0700
@@ -17,6 +17,7 @@
 #include <linux/time.h>
 #include <linux/fs.h>
 #include <linux/fcntl.h>
+#include <linux/highuid.h>
 #include <linux/namei.h>
 #include <linux/file.h>
 #include <linux/vfs.h>
@@ -244,3 +245,165 @@ asmlinkage long compat_sys_fcntl(unsigne
 	return compat_sys_fcntl64(fd, cmd, arg);
 }
 
+
+#if defined(CONFIG_NFSD) || defined(CONFIG_NFSD_MODULE)
+
+#include <linux/sunrpc/svc.h>
+#include <linux/nfsd/nfsd.h>
+#include <linux/nfsd/syscall.h>
+
+static int compat_nfs_svc_trans(struct nfsctl_arg *karg, 
+				struct compat_nfsctl_arg *carg)
+{
+	int err;
+	
+	err  = __get_user(karg->ca_version, &carg->ca_version);
+	err |= __get_user(karg->ca_svc.svc_port, &carg->ca_svc.svc_port);
+	err |= __get_user(karg->ca_svc.svc_nthreads, &carg->ca_svc.svc_nthreads);
+	return err;
+}
+
+static int compat_nfs_clnt_trans(struct nfsctl_arg *karg, 
+				 struct compat_nfsctl_arg *carg)
+{
+	int err;
+	
+	err = __get_user(karg->ca_version, &carg->ca_version);
+	err |= copy_from_user(&karg->ca_client.cl_ident[0],
+			      &carg->ca_client.cl_ident[0],
+			      NFSCLNT_IDMAX+1);
+	err |= __get_user(karg->ca_client.cl_naddr, &carg->ca_client.cl_naddr);
+	err |= copy_from_user(&karg->ca_client.cl_addrlist[0],
+			      &carg->ca_client.cl_addrlist[0],
+			      sizeof(struct in_addr) * NFSCLNT_ADDRMAX);
+	err |= __get_user(karg->ca_client.cl_fhkeytype,
+		          &carg->ca_client.cl_fhkeytype);
+	err |= __get_user(karg->ca_client.cl_fhkeylen,
+			  &carg->ca_client.cl_fhkeylen);
+	err |= copy_from_user(&karg->ca_client.cl_fhkey[0],
+			      &carg->ca_client.cl_fhkey[0],
+			      NFSCLNT_KEYMAX);
+	return err;
+}
+
+static int compat_nfs_exp_trans(struct nfsctl_arg *karg,
+				struct compat_nfsctl_arg *carg)
+{
+	int err;
+	
+	err = __get_user(karg->ca_version, &carg->ca_version);
+	err |= copy_from_user(&karg->ca_export.ex_client[0],
+			      &carg->ca_export.ex_client[0],
+			      NFSCLNT_IDMAX+1);
+	err |= copy_from_user(&karg->ca_export.ex_path[0],
+			      &carg->ca_export.ex_path[0],
+			      NFS_MAXPATHLEN+1);
+	err |= __get_user(karg->ca_export.ex_dev,
+			  &carg->ca_export.ex_dev);
+	err |= __get_user(karg->ca_export.ex_ino,
+			  &carg->ca_export.ex_ino);
+	err |= __get_user(karg->ca_export.ex_flags,
+			  &carg->ca_export.ex_flags);
+	err |= __get_user(karg->ca_export.ex_anon_uid,
+			  &carg->ca_export.ex_anon_uid);
+	err |= __get_user(karg->ca_export.ex_anon_gid,
+			  &carg->ca_export.ex_anon_gid);
+	karg->ca_export.ex_anon_uid = NEW_TO_OLD_UID(karg->ca_export.ex_anon_uid);
+	karg->ca_export.ex_anon_gid = NEW_TO_OLD_GID(karg->ca_export.ex_anon_gid);
+	
+	return err; 
+}
+
+static int compat_nfs_getfd_trans(struct nfsctl_arg *karg,
+				  struct compat_nfsctl_arg *carg)
+{
+	int err;
+	
+	err  = __get_user(karg->ca_version, &carg->ca_version);
+	err |= copy_from_user(&karg->ca_getfd.gd_addr,
+			      &carg->ca_getfd.gd_addr,
+			      sizeof(struct sockaddr));
+	err |= copy_from_user(&karg->ca_getfd.gd_path,
+			      &carg->ca_getfd.gd_path,
+			      NFS_MAXPATHLEN+1);
+	err |= __get_user(karg->ca_getfd.gd_version,
+			  &carg->ca_getfd.gd_version);
+	return err;
+}
+
+static int compat_nfs_getfs_trans(struct nfsctl_arg *karg,
+				  struct compat_nfsctl_arg *carg)
+{
+	int err;
+	
+	err  = __get_user(karg->ca_version, &carg->ca_version);
+	err |= copy_from_user(&karg->ca_getfs.gd_addr,
+			      &carg->ca_getfs.gd_addr,
+			      sizeof(struct sockaddr));
+	err |= copy_from_user(&karg->ca_getfs.gd_path,
+			      &carg->ca_getfs.gd_path,
+			      NFS_MAXPATHLEN+1);
+	err |= __get_user(karg->ca_getfs.gd_maxlen,
+			  &carg->ca_getfs.gd_maxlen);
+	return err;
+}
+
+static struct {
+	int (*translate)(struct nfsctl_arg *, struct compat_nfsctl_arg *);
+} compat_nfs_map[] = {
+	[NFSCTL_SVC]	   = { .translate = compat_nfs_svc_trans },
+	[NFSCTL_ADDCLIENT] = { .translate = compat_nfs_clnt_trans },
+	[NFSCTL_DELCLIENT] = { .translate = compat_nfs_clnt_trans },
+	[NFSCTL_EXPORT]    = { .translate = compat_nfs_exp_trans },
+	[NFSCTL_UNEXPORT]  = { .translate = compat_nfs_exp_trans },
+	[NFSCTL_GETFD]	   = { .translate = compat_nfs_getfd_trans },
+	[NFSCTL_GETFS]	   = { .translate = compat_nfs_getfs_trans },
+};
+
+long asmlinkage compat_sys_nfsservctl(int cmd, struct compat_nfsctl_arg *carg,
+				      union nfsctl_res *res)
+{
+	struct nfsctl_arg *karg = NULL;
+	union nfsctl_res *kres = NULL;
+	mm_segment_t oldfs;
+	int ret;
+
+	if (cmd < 0 || cmd >= sizeof(compat_nfs_map)/sizeof(compat_nfs_map[0]) 
+		    || !compat_nfs_map[cmd].translate)
+		return -EINVAL;
+
+	karg = kmalloc(sizeof(*karg), GFP_USER);
+	kres = kmalloc(sizeof(*kres), GFP_USER);
+	if (!karg || !kres) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = compat_nfs_map[cmd].translate(karg, carg) ? -EFAULT : 0;
+	if(ret) 
+		goto out;
+
+	oldfs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = sys_nfsservctl(cmd, karg, kres);
+	set_fs(oldfs);
+
+	if (!ret && res && (cmd == NFSCTL_GETFD || cmd == NFSCTL_GETFS))
+		ret = copy_to_user(res, kres, sizeof(*res)) ? -EFAULT : 0;
+
+out:
+	if (karg)
+		kfree(karg);
+	if (kres)
+		kfree(kres);
+	return ret;
+}
+
+#else
+long asmlinkage compat_sys_nfsservctl(int cmd, struct compat_nfsctl_arg *carg,
+				      union nfsctl_res *res)
+{
+	return -ENOSYS;
+}
+#endif
+
diff -uNrp linux-2.5.67/include/linux/nfsd/syscall.h linux-compat/include/linux/nfsd/syscall.h
--- linux-2.5.67/include/linux/nfsd/syscall.h	2003-04-15 22:41:29.000000000 -0700
+++ linux-compat/include/linux/nfsd/syscall.h	2003-04-16 20:38:27.000000000 -0700
@@ -112,6 +112,57 @@ union nfsctl_res {
 	struct knfsd_fh		cr_getfs;
 };
 
+#ifdef CONFIG_COMPAT
+#include <linux/compat.h>
+
+struct compat_nfsctl_svc {
+	unsigned short		svc_port;
+	compat_int_t		svc_nthreads;
+};
+
+struct compat_nfsctl_client {
+	char			cl_ident[NFSCLNT_IDMAX+1];
+	compat_int_t		cl_naddr;
+	struct in_addr		cl_addrlist[NFSCLNT_ADDRMAX];
+	compat_int_t		cl_fhkeytype;
+	compat_int_t		cl_fhkeylen;
+	unsigned char		cl_fhkey[NFSCLNT_KEYMAX];
+};
+
+struct compat_nfsctl_export {
+	char			ex_client[NFSCLNT_IDMAX+1];
+	char			ex_path[NFS_MAXPATHLEN+1];
+	compat_dev_t		ex_dev;
+	compat_ino_t		ex_ino;
+	compat_int_t		ex_flags;
+	compat_uid_t		ex_anon_uid;
+	compat_gid_t		ex_anon_gid;
+};
+
+struct compat_nfsctl_fdparm {
+	struct sockaddr		gd_addr;
+	char			gd_path[NFS_MAXPATHLEN+1];
+	compat_int_t		gd_version;
+};
+
+struct compat_nfsctl_fsparm {
+	struct sockaddr		gd_addr;
+	char			gd_path[NFS_MAXPATHLEN+1];
+	compat_int_t		gd_maxlen;
+};
+
+struct compat_nfsctl_arg {
+	compat_int_t		ca_version;	/* safeguard */
+	union {
+		struct compat_nfsctl_svc	u_svc;
+		struct compat_nfsctl_client	u_client;
+		struct compat_nfsctl_export	u_export;
+		struct compat_nfsctl_fdparm	u_getfd;
+		struct compat_nfsctl_fsparm	u_getfs;
+	} u;
+};
+#endif
+
 #ifdef __KERNEL__
 /*
  * Kernel syscall implementation.
