Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964886AbWEOL0o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964886AbWEOL0o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 07:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWEOL0o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 07:26:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42964 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964886AbWEOL0n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 07:26:43 -0400
Date: Mon, 15 May 2006 04:23:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Meelis Roos <mroos@linux.ee>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nfsservctl() compatibility broken on AMD64?
Message-Id: <20060515042324.50af55c5.akpm@osdl.org>
In-Reply-To: <Pine.SOC.4.61.0605151220130.27015@math.ut.ee>
References: <Pine.SOC.4.61.0605151220130.27015@math.ut.ee>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Meelis Roos <mroos@linux.ee> wrote:
>
> I'm trying to use the latest amd64 kernel (2.6.17-rc3 compiled last 
> week) with Debian Sarge 32-bit userland (is it reasonable to expect it 
> to work?).
> 
> There's a problem with exportfs. I can export to IP ranges OK but I can 
> not export to single hosts - nfsservctl() returns EFAULT.
> 
> Documentation/Changes tells I need at least nfs-utils 1.0.5, sarge has 
> 1.0.6-3.1 so this should be OK.
> 

Does this fix?


From: Lin Feng Shen <shenlinf@cn.ibm.com>

Functions compat_nfs_svc_trans, compat_nfs_clnt_trans,
compat_nfs_exp_trans, compat_nfs_getfd_trans and compat_nfs_getfs_trans,
which are called by compat_sys_nfsservctl(fs/compat.c), don't handle the
return value of access_ok properly.  access_ok return 1 when the addr is
valid, and 0 when it's not, but these functions have the reversed
understanding.  When the address is valid, they always return -EFAULT to
compat_sys_nfsservctl.

An example is to run /usr/sbin/rpc.nfsd(32bit program on Power5).  It
doesn't function as expected.  strace showes that nfsservctl returns
-EFAULT.

The patch fixes this by correcting the error handling on the return value
of access_ok in the five functions.

Signed-off-by: Lin Feng Shen <shenlinf@cn.ibm.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Neil Brown <neilb@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/compat.c |  190 +++++++++++++++++++++++++-------------------------
 1 files changed, 98 insertions(+), 92 deletions(-)

diff -puN fs/compat.c~nfs-fix-error-handling-on-access_ok-in-compat_sys_nfsservctl fs/compat.c
--- devel/fs/compat.c~nfs-fix-error-handling-on-access_ok-in-compat_sys_nfsservctl	2006-05-13 19:48:55.000000000 -0700
+++ devel-akpm/fs/compat.c	2006-05-13 19:52:20.000000000 -0700
@@ -2030,109 +2030,114 @@ union compat_nfsctl_res {
 	struct knfsd_fh		cr32_getfs;
 };
 
-static int compat_nfs_svc_trans(struct nfsctl_arg *karg, struct compat_nfsctl_arg __user *arg)
+static int compat_nfs_svc_trans(struct nfsctl_arg *karg,
+				struct compat_nfsctl_arg __user *arg)
 {
-	int err;
-
-	err = access_ok(VERIFY_READ, &arg->ca32_svc, sizeof(arg->ca32_svc));
-	err |= get_user(karg->ca_version, &arg->ca32_version);
-	err |= __get_user(karg->ca_svc.svc_port, &arg->ca32_svc.svc32_port);
-	err |= __get_user(karg->ca_svc.svc_nthreads, &arg->ca32_svc.svc32_nthreads);
-	return (err) ? -EFAULT : 0;
-}
-
-static int compat_nfs_clnt_trans(struct nfsctl_arg *karg, struct compat_nfsctl_arg __user *arg)
-{
-	int err;
-
-	err = access_ok(VERIFY_READ, &arg->ca32_client, sizeof(arg->ca32_client));
-	err |= get_user(karg->ca_version, &arg->ca32_version);
-	err |= __copy_from_user(&karg->ca_client.cl_ident[0],
-			  &arg->ca32_client.cl32_ident[0],
-			  NFSCLNT_IDMAX);
-	err |= __get_user(karg->ca_client.cl_naddr, &arg->ca32_client.cl32_naddr);
-	err |= __copy_from_user(&karg->ca_client.cl_addrlist[0],
-			  &arg->ca32_client.cl32_addrlist[0],
-			  (sizeof(struct in_addr) * NFSCLNT_ADDRMAX));
-	err |= __get_user(karg->ca_client.cl_fhkeytype,
-		      &arg->ca32_client.cl32_fhkeytype);
-	err |= __get_user(karg->ca_client.cl_fhkeylen,
-		      &arg->ca32_client.cl32_fhkeylen);
-	err |= __copy_from_user(&karg->ca_client.cl_fhkey[0],
-			  &arg->ca32_client.cl32_fhkey[0],
-			  NFSCLNT_KEYMAX);
-
-	return (err) ? -EFAULT : 0;
-}
-
-static int compat_nfs_exp_trans(struct nfsctl_arg *karg, struct compat_nfsctl_arg __user *arg)
-{
-	int err;
-
-	err = access_ok(VERIFY_READ, &arg->ca32_export, sizeof(arg->ca32_export));
-	err |= get_user(karg->ca_version, &arg->ca32_version);
-	err |= __copy_from_user(&karg->ca_export.ex_client[0],
-			  &arg->ca32_export.ex32_client[0],
-			  NFSCLNT_IDMAX);
-	err |= __copy_from_user(&karg->ca_export.ex_path[0],
-			  &arg->ca32_export.ex32_path[0],
-			  NFS_MAXPATHLEN);
-	err |= __get_user(karg->ca_export.ex_dev,
-		      &arg->ca32_export.ex32_dev);
-	err |= __get_user(karg->ca_export.ex_ino,
-		      &arg->ca32_export.ex32_ino);
-	err |= __get_user(karg->ca_export.ex_flags,
-		      &arg->ca32_export.ex32_flags);
-	err |= __get_user(karg->ca_export.ex_anon_uid,
-		      &arg->ca32_export.ex32_anon_uid);
-	err |= __get_user(karg->ca_export.ex_anon_gid,
-		      &arg->ca32_export.ex32_anon_gid);
+	if(!access_ok(VERIFY_READ, &arg->ca32_svc, sizeof(arg->ca32_svc)) ||
+		get_user(karg->ca_version, &arg->ca32_version) ||
+		__get_user(karg->ca_svc.svc_port, &arg->ca32_svc.svc32_port) ||
+		__get_user(karg->ca_svc.svc_nthreads,
+				&arg->ca32_svc.svc32_nthreads))
+		return -EFAULT;
+	return 0;
+}
+
+static int compat_nfs_clnt_trans(struct nfsctl_arg *karg,
+				struct compat_nfsctl_arg __user *arg)
+{
+	if (!access_ok(VERIFY_READ, &arg->ca32_client,
+			sizeof(arg->ca32_client)) ||
+		get_user(karg->ca_version, &arg->ca32_version) ||
+		__copy_from_user(&karg->ca_client.cl_ident[0],
+				&arg->ca32_client.cl32_ident[0],
+				NFSCLNT_IDMAX) ||
+		__get_user(karg->ca_client.cl_naddr,
+				&arg->ca32_client.cl32_naddr) ||
+		__copy_from_user(&karg->ca_client.cl_addrlist[0],
+				&arg->ca32_client.cl32_addrlist[0],
+				(sizeof(struct in_addr) * NFSCLNT_ADDRMAX)) ||
+		__get_user(karg->ca_client.cl_fhkeytype,
+				&arg->ca32_client.cl32_fhkeytype) ||
+		__get_user(karg->ca_client.cl_fhkeylen,
+				&arg->ca32_client.cl32_fhkeylen) ||
+		__copy_from_user(&karg->ca_client.cl_fhkey[0],
+				&arg->ca32_client.cl32_fhkey[0],
+				NFSCLNT_KEYMAX))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int compat_nfs_exp_trans(struct nfsctl_arg *karg,
+				struct compat_nfsctl_arg __user *arg)
+{
+	if (!access_ok(VERIFY_READ, &arg->ca32_export,
+				sizeof(arg->ca32_export)) ||
+		get_user(karg->ca_version, &arg->ca32_version) ||
+		__copy_from_user(&karg->ca_export.ex_client[0],
+				&arg->ca32_export.ex32_client[0],
+				NFSCLNT_IDMAX) ||
+		__copy_from_user(&karg->ca_export.ex_path[0],
+				&arg->ca32_export.ex32_path[0],
+				NFS_MAXPATHLEN) ||
+		__get_user(karg->ca_export.ex_dev,
+				&arg->ca32_export.ex32_dev) ||
+		__get_user(karg->ca_export.ex_ino,
+				&arg->ca32_export.ex32_ino) ||
+		__get_user(karg->ca_export.ex_flags,
+				&arg->ca32_export.ex32_flags) ||
+		__get_user(karg->ca_export.ex_anon_uid,
+				&arg->ca32_export.ex32_anon_uid) ||
+		__get_user(karg->ca_export.ex_anon_gid,
+				&arg->ca32_export.ex32_anon_gid))
+		return -EFAULT;
 	SET_UID(karg->ca_export.ex_anon_uid, karg->ca_export.ex_anon_uid);
 	SET_GID(karg->ca_export.ex_anon_gid, karg->ca_export.ex_anon_gid);
 
-	return (err) ? -EFAULT : 0;
+	return 0;
 }
 
-static int compat_nfs_getfd_trans(struct nfsctl_arg *karg, struct compat_nfsctl_arg __user *arg)
+static int compat_nfs_getfd_trans(struct nfsctl_arg *karg,
+				struct compat_nfsctl_arg __user *arg)
 {
-	int err;
+	if(!access_ok(VERIFY_READ, &arg->ca32_getfd, sizeof(arg->ca32_getfd)) ||
+		get_user(karg->ca_version, &arg->ca32_version) ||
+		__copy_from_user(&karg->ca_getfd.gd_addr,
+				&arg->ca32_getfd.gd32_addr,
+				(sizeof(struct sockaddr))) ||
+		__copy_from_user(&karg->ca_getfd.gd_path,
+				&arg->ca32_getfd.gd32_path,
+				(NFS_MAXPATHLEN+1)) ||
+		__get_user(karg->ca_getfd.gd_version,
+				&arg->ca32_getfd.gd32_version))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int compat_nfs_getfs_trans(struct nfsctl_arg *karg,
+				struct compat_nfsctl_arg __user *arg)
+{
+	if (!access_ok(VERIFY_READ,&arg->ca32_getfs,sizeof(arg->ca32_getfs)) ||
+		get_user(karg->ca_version, &arg->ca32_version) ||
+		__copy_from_user(&karg->ca_getfs.gd_addr,
+				&arg->ca32_getfs.gd32_addr,
+				(sizeof(struct sockaddr))) ||
+		__copy_from_user(&karg->ca_getfs.gd_path,
+				&arg->ca32_getfs.gd32_path,
+				(NFS_MAXPATHLEN+1)) ||
+		__get_user(karg->ca_getfs.gd_maxlen,
+				&arg->ca32_getfs.gd32_maxlen))
+		return -EFAULT;
 
-	err = access_ok(VERIFY_READ, &arg->ca32_getfd, sizeof(arg->ca32_getfd));
-	err |= get_user(karg->ca_version, &arg->ca32_version);
-	err |= __copy_from_user(&karg->ca_getfd.gd_addr,
-			  &arg->ca32_getfd.gd32_addr,
-			  (sizeof(struct sockaddr)));
-	err |= __copy_from_user(&karg->ca_getfd.gd_path,
-			  &arg->ca32_getfd.gd32_path,
-			  (NFS_MAXPATHLEN+1));
-	err |= __get_user(karg->ca_getfd.gd_version,
-		      &arg->ca32_getfd.gd32_version);
-
-	return (err) ? -EFAULT : 0;
-}
-
-static int compat_nfs_getfs_trans(struct nfsctl_arg *karg, struct compat_nfsctl_arg __user *arg)
-{
-	int err;
-
-	err = access_ok(VERIFY_READ, &arg->ca32_getfs, sizeof(arg->ca32_getfs));
-	err |= get_user(karg->ca_version, &arg->ca32_version);
-	err |= __copy_from_user(&karg->ca_getfs.gd_addr,
-			  &arg->ca32_getfs.gd32_addr,
-			  (sizeof(struct sockaddr)));
-	err |= __copy_from_user(&karg->ca_getfs.gd_path,
-			  &arg->ca32_getfs.gd32_path,
-			  (NFS_MAXPATHLEN+1));
-	err |= __get_user(karg->ca_getfs.gd_maxlen,
-		      &arg->ca32_getfs.gd32_maxlen);
-
-	return (err) ? -EFAULT : 0;
+	return 0;
 }
 
 /* This really doesn't need translations, we are only passing
  * back a union which contains opaque nfs file handle data.
  */
-static int compat_nfs_getfh_res_trans(union nfsctl_res *kres, union compat_nfsctl_res __user *res)
+static int compat_nfs_getfh_res_trans(union nfsctl_res *kres,
+				union compat_nfsctl_res __user *res)
 {
 	int err;
 
@@ -2141,8 +2146,9 @@ static int compat_nfs_getfh_res_trans(un
 	return (err) ? -EFAULT : 0;
 }
 
-asmlinkage long compat_sys_nfsservctl(int cmd, struct compat_nfsctl_arg __user *arg,
-					union compat_nfsctl_res __user *res)
+asmlinkage long compat_sys_nfsservctl(int cmd,
+				struct compat_nfsctl_arg __user *arg,
+				union compat_nfsctl_res __user *res)
 {
 	struct nfsctl_arg *karg;
 	union nfsctl_res *kres;
_

