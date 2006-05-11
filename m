Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbWEKGWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbWEKGWo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 02:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbWEKGWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 02:22:44 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:35282 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP id S965144AbWEKGWn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 02:22:43 -0400
Message-ID: <4462D816.7090207@cn.ibm.com>
Date: Thu, 11 May 2006 14:22:14 +0800
From: Lin Feng Shen <shenlinf@cn.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: neilb@cse.unsw.edu.au, nfs@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] NFS: fix error handling on access_ok in compat_sys_nfsservctl
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lin Feng Shen <shenlinf@cn.ibm.com>

Functions compat_nfs_svc_trans, compat_nfs_clnt_trans, compat_nfs_exp_trans,
compat_nfs_getfd_trans and compat_nfs_getfs_trans, which are called by
compat_sys_nfsservctl(fs/compat.c), don't handle the return value of
access_ok properly. access_ok return 1 when the addr is valid, and 0
when it's not, but these functions have the reversed understanding. When the
address is valid, they always return -EFAULT to compat_sys_nfsservctl.

An example is to run /usr/sbin/rpc.nfsd(32bit program on Power5). It doesn't
function as expected. strace showes that nfsservctl returns -EFAULT.

The patch fixes this by correcting the error handling on the return value of
access_ok in the five functions. It is created against 
linux-2.6.17-rc3-git16.

Signed-off-by: Lin Feng Shen <shenlinf@cn.ibm.com>
---

--- linux-2.6.17-rc3-git16/fs/compat.c.orig    2006-05-09 
09:07:38.000000000 -0500
+++ linux-2.6.17-rc3-git16/fs/compat.c    2006-05-09 09:21:00.000000000 
-0500
@@ -2032,101 +2032,96 @@ union compat_nfsctl_res {
 
 static int compat_nfs_svc_trans(struct nfsctl_arg *karg, struct 
compat_nfsctl_arg __user *arg)
 {
-    int err;
-
-    err = access_ok(VERIFY_READ, &arg->ca32_svc, sizeof(arg->ca32_svc));
-    err |= get_user(karg->ca_version, &arg->ca32_version);
-    err |= __get_user(karg->ca_svc.svc_port, &arg->ca32_svc.svc32_port);
-    err |= __get_user(karg->ca_svc.svc_nthreads, 
&arg->ca32_svc.svc32_nthreads);
-    return (err) ? -EFAULT : 0;
+    if(!access_ok(VERIFY_READ, &arg->ca32_svc, sizeof(arg->ca32_svc)) ||
+        get_user(karg->ca_version, &arg->ca32_version) ||
+        __get_user(karg->ca_svc.svc_port, &arg->ca32_svc.svc32_port) ||
+        __get_user(karg->ca_svc.svc_nthreads, 
&arg->ca32_svc.svc32_nthreads))
+        return -EFAULT;
+    return 0;
 }
 
 static int compat_nfs_clnt_trans(struct nfsctl_arg *karg, struct 
compat_nfsctl_arg __user *arg)
 {
-    int err;
-
-    err = access_ok(VERIFY_READ, &arg->ca32_client, 
sizeof(arg->ca32_client));
-    err |= get_user(karg->ca_version, &arg->ca32_version);
-    err |= __copy_from_user(&karg->ca_client.cl_ident[0],
+    if(!access_ok(VERIFY_READ, &arg->ca32_client, 
sizeof(arg->ca32_client)) ||
+        get_user(karg->ca_version, &arg->ca32_version) ||
+        __copy_from_user(&karg->ca_client.cl_ident[0],
               &arg->ca32_client.cl32_ident[0],
-              NFSCLNT_IDMAX);
-    err |= __get_user(karg->ca_client.cl_naddr, 
&arg->ca32_client.cl32_naddr);
-    err |= __copy_from_user(&karg->ca_client.cl_addrlist[0],
+              NFSCLNT_IDMAX) ||
+        __get_user(karg->ca_client.cl_naddr, 
&arg->ca32_client.cl32_naddr) ||
+        __copy_from_user(&karg->ca_client.cl_addrlist[0],
               &arg->ca32_client.cl32_addrlist[0],
-              (sizeof(struct in_addr) * NFSCLNT_ADDRMAX));
-    err |= __get_user(karg->ca_client.cl_fhkeytype,
-              &arg->ca32_client.cl32_fhkeytype);
-    err |= __get_user(karg->ca_client.cl_fhkeylen,
-              &arg->ca32_client.cl32_fhkeylen);
-    err |= __copy_from_user(&karg->ca_client.cl_fhkey[0],
+              (sizeof(struct in_addr) * NFSCLNT_ADDRMAX)) ||
+        __get_user(karg->ca_client.cl_fhkeytype,
+              &arg->ca32_client.cl32_fhkeytype) ||
+        __get_user(karg->ca_client.cl_fhkeylen,
+              &arg->ca32_client.cl32_fhkeylen) ||
+        __copy_from_user(&karg->ca_client.cl_fhkey[0],
               &arg->ca32_client.cl32_fhkey[0],
-              NFSCLNT_KEYMAX);
+              NFSCLNT_KEYMAX))
+        return -EFAULT;
 
-    return (err) ? -EFAULT : 0;
+    return 0;
 }
 
 static int compat_nfs_exp_trans(struct nfsctl_arg *karg, struct 
compat_nfsctl_arg __user *arg)
 {
-    int err;
-
-    err = access_ok(VERIFY_READ, &arg->ca32_export, 
sizeof(arg->ca32_export));
-    err |= get_user(karg->ca_version, &arg->ca32_version);
-    err |= __copy_from_user(&karg->ca_export.ex_client[0],
+    if(!access_ok(VERIFY_READ, &arg->ca32_export, 
sizeof(arg->ca32_export)) ||
+        get_user(karg->ca_version, &arg->ca32_version) ||
+        __copy_from_user(&karg->ca_export.ex_client[0],
               &arg->ca32_export.ex32_client[0],
-              NFSCLNT_IDMAX);
-    err |= __copy_from_user(&karg->ca_export.ex_path[0],
+              NFSCLNT_IDMAX) ||
+        __copy_from_user(&karg->ca_export.ex_path[0],
               &arg->ca32_export.ex32_path[0],
-              NFS_MAXPATHLEN);
-    err |= __get_user(karg->ca_export.ex_dev,
-              &arg->ca32_export.ex32_dev);
-    err |= __get_user(karg->ca_export.ex_ino,
-              &arg->ca32_export.ex32_ino);
-    err |= __get_user(karg->ca_export.ex_flags,
-              &arg->ca32_export.ex32_flags);
-    err |= __get_user(karg->ca_export.ex_anon_uid,
-              &arg->ca32_export.ex32_anon_uid);
-    err |= __get_user(karg->ca_export.ex_anon_gid,
-              &arg->ca32_export.ex32_anon_gid);
+              NFS_MAXPATHLEN) ||
+        __get_user(karg->ca_export.ex_dev,
+              &arg->ca32_export.ex32_dev) ||
+        __get_user(karg->ca_export.ex_ino,
+              &arg->ca32_export.ex32_ino) ||
+        __get_user(karg->ca_export.ex_flags,
+              &arg->ca32_export.ex32_flags) ||
+        __get_user(karg->ca_export.ex_anon_uid,
+              &arg->ca32_export.ex32_anon_uid) ||
+        __get_user(karg->ca_export.ex_anon_gid,
+              &arg->ca32_export.ex32_anon_gid))
+        return -EFAULT;
     SET_UID(karg->ca_export.ex_anon_uid, karg->ca_export.ex_anon_uid);
     SET_GID(karg->ca_export.ex_anon_gid, karg->ca_export.ex_anon_gid);
 
-    return (err) ? -EFAULT : 0;
+    return 0;
 }
 
 static int compat_nfs_getfd_trans(struct nfsctl_arg *karg, struct 
compat_nfsctl_arg __user *arg)
 {
-    int err;
-
-    err = access_ok(VERIFY_READ, &arg->ca32_getfd, 
sizeof(arg->ca32_getfd));
-    err |= get_user(karg->ca_version, &arg->ca32_version);
-    err |= __copy_from_user(&karg->ca_getfd.gd_addr,
+    if(!access_ok(VERIFY_READ, &arg->ca32_getfd, 
sizeof(arg->ca32_getfd)) ||
+        get_user(karg->ca_version, &arg->ca32_version) ||
+        __copy_from_user(&karg->ca_getfd.gd_addr,
               &arg->ca32_getfd.gd32_addr,
-              (sizeof(struct sockaddr)));
-    err |= __copy_from_user(&karg->ca_getfd.gd_path,
+              (sizeof(struct sockaddr))) ||
+        __copy_from_user(&karg->ca_getfd.gd_path,
               &arg->ca32_getfd.gd32_path,
-              (NFS_MAXPATHLEN+1));
-    err |= __get_user(karg->ca_getfd.gd_version,
-              &arg->ca32_getfd.gd32_version);
+              (NFS_MAXPATHLEN+1)) ||
+        __get_user(karg->ca_getfd.gd_version,
+              &arg->ca32_getfd.gd32_version))
+        return -EFAULT;
 
-    return (err) ? -EFAULT : 0;
+    return 0;
 }
 
 static int compat_nfs_getfs_trans(struct nfsctl_arg *karg, struct 
compat_nfsctl_arg __user *arg)
 {
-    int err;
-
-    err = access_ok(VERIFY_READ, &arg->ca32_getfs, 
sizeof(arg->ca32_getfs));
-    err |= get_user(karg->ca_version, &arg->ca32_version);
-    err |= __copy_from_user(&karg->ca_getfs.gd_addr,
+    if(!access_ok(VERIFY_READ, &arg->ca32_getfs, 
sizeof(arg->ca32_getfs)) ||
+        get_user(karg->ca_version, &arg->ca32_version) ||
+        __copy_from_user(&karg->ca_getfs.gd_addr,
               &arg->ca32_getfs.gd32_addr,
-              (sizeof(struct sockaddr)));
-    err |= __copy_from_user(&karg->ca_getfs.gd_path,
+              (sizeof(struct sockaddr))) ||
+        __copy_from_user(&karg->ca_getfs.gd_path,
               &arg->ca32_getfs.gd32_path,
-              (NFS_MAXPATHLEN+1));
-    err |= __get_user(karg->ca_getfs.gd_maxlen,
-              &arg->ca32_getfs.gd32_maxlen);
+              (NFS_MAXPATHLEN+1)) ||
+        __get_user(karg->ca_getfs.gd_maxlen,
+              &arg->ca32_getfs.gd32_maxlen))
+        return -EFAULT;
 
-    return (err) ? -EFAULT : 0;
+    return 0;
 }
 
 /* This really doesn't need translations, we are only passing

