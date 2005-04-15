Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261821AbVDOOpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261821AbVDOOpl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 10:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVDOOpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 10:45:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:64222 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261470AbVDOOpM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 10:45:12 -0400
From: David Howells <dhowells@redhat.com>
To: torvalds@osdl.org, akpm@osdl.org, trond.myklebust@fys.uio.no
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       steved@redhat.com
Subject: [PATCH] Add 32-bit compatibility for NFSv4 mount
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Fri, 15 Apr 2005 15:45:02 +0100
Message-ID: <26687.1113576302@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch adds 32-bit compatibility for mounting an NFSv4 mount on a
64-bit kernel (such as happens with PPC64).

The problem is that the mount data for the NFS4 mount process includes
auxilliary data pointers, probably because the NFS4 mount data may conceivably
exceed PAGE_SIZE in size - thus breaking against the hard limit imposed by
sys_mount().

Signed-Off-By: David Howells <dhowells@redhat.com>
---
warthog>diffstat -p1 /tmp/linux-2.6.9-nfs4-compat-mount.patch 
 fs/compat.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 74 insertions(+)

--- linux-2.6.9/fs/compat.c.orig	2005-04-15 14:22:38.325413709 +0100
+++ linux-2.6.9/fs/compat.c	2005-04-15 14:22:54.000000000 +0100
@@ -30,6 +30,7 @@
 #include <linux/smb.h>
 #include <linux/smb_mount.h>
 #include <linux/ncp_mount.h>
+#include <linux/nfs4_mount.h>
 #include <linux/smp_lock.h>
 #include <linux/syscalls.h>
 #include <linux/ctype.h>
@@ -746,10 +747,79 @@ static void *do_smb_super_data_conv(void
 	return raw_data;
 }
 
+struct compat_nfs_string {
+	compat_uint_t len;
+	compat_uptr_t __user data;
+};
+
+static inline void compat_nfs_string(struct nfs_string *dst,
+				     struct compat_nfs_string *src)
+{
+	dst->data = compat_ptr(src->data);
+	dst->len = src->len;
+}
+
+struct compat_nfs4_mount_data_v1 {
+	compat_int_t version;
+	compat_int_t flags;
+	compat_int_t rsize;
+	compat_int_t wsize;
+	compat_int_t timeo;
+	compat_int_t retrans;
+	compat_int_t acregmin;
+	compat_int_t acregmax;
+	compat_int_t acdirmin;
+	compat_int_t acdirmax;
+	struct compat_nfs_string client_addr;
+	struct compat_nfs_string mnt_path;
+	struct compat_nfs_string hostname;
+	compat_uint_t host_addrlen;
+	compat_uptr_t __user host_addr;
+	compat_int_t proto;
+	compat_int_t auth_flavourlen;
+	compat_uptr_t __user auth_flavours;
+};
+
+static int do_nfs4_super_data_conv(void *raw_data)
+{
+	int version = *(compat_uint_t *) raw_data;
+
+	if (version == 1) {
+		struct compat_nfs4_mount_data_v1 *raw = raw_data;
+		struct nfs4_mount_data *real = raw_data;
+
+		/* copy the fields backwards */
+		real->auth_flavours = compat_ptr(raw->auth_flavours);
+		real->auth_flavourlen = raw->auth_flavourlen;
+		real->proto = raw->proto;
+		real->host_addr = compat_ptr(raw->host_addr);
+		real->host_addrlen = raw->host_addrlen;
+		compat_nfs_string(&real->hostname, &raw->hostname);
+		compat_nfs_string(&real->mnt_path, &raw->mnt_path);
+		compat_nfs_string(&real->client_addr, &raw->client_addr);
+		real->acdirmax = raw->acdirmax;
+		real->acdirmin = raw->acdirmin;
+		real->acregmax = raw->acregmax;
+		real->acregmin = raw->acregmin;
+		real->retrans = raw->retrans;
+		real->timeo = raw->timeo;
+		real->wsize = raw->wsize;
+		real->rsize = raw->rsize;
+		real->flags = raw->flags;
+		real->version = raw->version;
+	}
+	else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 extern int copy_mount_options (const void __user *, unsigned long *);
 
 #define SMBFS_NAME      "smbfs"
 #define NCPFS_NAME      "ncpfs"
+#define NFS4_NAME	"nfs4"
 
 asmlinkage long compat_sys_mount(char __user * dev_name, char __user * dir_name,
 				 char __user * type, unsigned long flags,
@@ -785,6 +855,9 @@ asmlinkage long compat_sys_mount(char __
 			do_smb_super_data_conv((void *)data_page);
 		} else if (!strcmp((char *)type_page, NCPFS_NAME)) {
 			do_ncp_super_data_conv((void *)data_page);
+		} else if (!strcmp((char *)type_page, NFS4_NAME)) {
+			if (do_nfs4_super_data_conv((void *) data_page))
+				goto out4;
 		}
 	}
 
@@ -793,6 +866,7 @@ asmlinkage long compat_sys_mount(char __
 			flags, (void*)data_page);
 	unlock_kernel();
 
+ out4:
 	free_page(data_page);
  out3:
 	free_page(dev_page);
