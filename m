Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbUDSUpx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 16:45:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262046AbUDSUpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 16:45:53 -0400
Received: from outmx013.isp.belgacom.be ([195.238.3.64]:31885 "EHLO
	outmx013.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S262045AbUDSUpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 16:45:45 -0400
Subject: [PATCH 2.6.6rc1-mm1] NFS sysctlized - readahead tunable
From: Fabian Frederick <Fabian.Frederick@skynet.be>
To: Trond <trond.myklebust@fys.uio.no>
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-87D+eS/0/qmlA5DSD6x0"
Message-Id: <1082407753.18853.12.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 19 Apr 2004 22:49:14 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx013.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-87D+eS/0/qmlA5DSD6x0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Trond,

	Here is a patch to have nfs to sysctl although Maxreadahead is tunable
under nfs init only.Do you have an idea and do you think it's acceptable
to make it applicable directly i.e. would it be readahead reduction
tolerant ?

btw, is this inode.c an issue for V4 ?

Regards,
Fabian

--=-87D+eS/0/qmlA5DSD6x0
Content-Disposition: attachment; filename=nfsctl.diff
Content-Type: text/x-patch; name=nfsctl.diff; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur orig/fs/nfs/inode.c edited/fs/nfs/inode.c
--- orig/fs/nfs/inode.c	2004-04-19 20:27:30.000000000 +0200
+++ edited/fs/nfs/inode.c	2004-04-19 22:32:14.000000000 +0200
@@ -11,6 +11,10 @@
  *  Change to nfs_read_super() to permit NFS mounts to multi-homed hosts.
  *  J.S.Peatfield@damtp.cam.ac.uk
  *
+ *  04/04 (FabianF)
+ *	-sysctl support
+ *	-readahead through sysctl
+ *
  */
 
 #include <linux/config.h>
@@ -42,13 +46,8 @@
 #define NFSDBG_FACILITY		NFSDBG_VFS
 #define NFS_PARANOIA 1
 
-/* Maximum number of readahead requests
- * FIXME: this should really be a sysctl so that users may tune it to suit
- *        their needs. People that do NFS over a slow network, might for
- *        instance want to reduce it to something closer to 1 for improved
- *        interactive response.
- */
-#define NFS_MAX_READAHEAD	(RPC_DEF_SLOT_TABLE - 1)
+/*Local sysctl handling*/
+#include "sysctl.h"
 
 static void nfs_invalidate_inode(struct inode *);
 static int nfs_update_inode(struct inode *, struct nfs_fattr *, unsigned long);
@@ -326,7 +325,7 @@
 		server->acdirmin = server->acdirmax = 0;
 		sb->s_flags |= MS_SYNCHRONOUS;
 	}
-	server->backing_dev_info.ra_pages = server->rpages * NFS_MAX_READAHEAD;
+	server->backing_dev_info.ra_pages = server->rpages * nfs_maxreadahead;
 
 	sb->s_maxbytes = fsinfo.maxfilesize;
 	if (sb->s_maxbytes > MAX_LFS_FILESIZE) 
@@ -1814,6 +1813,12 @@
 #ifdef CONFIG_PROC_FS
 	rpc_proc_register(&nfs_rpcstat);
 #endif
+#ifdef CONFIG_SYSCTL
+	nfs_sysctl_table = register_sysctl_table(nfs_sysctl_root, 0);
+	if(!nfs_sysctl_table)
+		return -ENOMEM;
+#endif
+
         err = register_filesystem(&nfs_fs_type);
 	if (err)
 		goto out;
@@ -1844,6 +1849,10 @@
 #endif
 	unregister_filesystem(&nfs_fs_type);
 	unregister_nfs4fs();
+#ifdef CONFIG_SYSCTL 
+	unregister_sysctl_table(nfs_sysctl_table);
+#endif
+
 }
 
 /* Not quite true; I just maintain it */
diff -Naur orig/fs/nfs/sysctl.h edited/fs/nfs/sysctl.h
--- orig/fs/nfs/sysctl.h	1970-01-01 01:00:00.000000000 +0100
+++ edited/fs/nfs/sysctl.h	2004-04-19 22:23:21.000000000 +0200
@@ -0,0 +1,56 @@
+/*
+ * sysctl.h - NFS sysctl handling
+ * 
+ * Copyright (c) 2004 Fabian Frederick (fabian.frederick@gmx.fr)
+ *
+ */
+
+#ifndef _LINUX_NFS_SYSCTL_H
+#define _LINUX_NFS_SYSCTL_H
+
+#include <linux/sysctl.h>
+static unsigned int 		nfs_maxreadahead = RPC_DEF_SLOT_TABLE-1;
+
+static const unsigned int	nfs_maxreadahead_min = 0;
+static const unsigned int	nfs_maxreadahead_max = 256;
+
+#ifdef CONFIG_SYSCTL
+static struct ctl_table_header *nfs_sysctl_table;
+
+#define CTL_UNNUMBERED		-2
+
+static ctl_table nfs_sysctls[] = {
+        {
+                .ctl_name       = CTL_UNNUMBERED,
+                .procname       = "nfs_maxreadahead",
+                .data           = &nfs_maxreadahead,
+                .maxlen         = sizeof(int),
+                .mode           = 0644,
+                .proc_handler   = &proc_doulongvec_minmax,
+                .extra1         = (unsigned long *) &nfs_maxreadahead_min,
+                .extra2         = (unsigned long *) &nfs_maxreadahead_max,
+        }
+};
+
+static ctl_table nfs_sysctl_dir[] = {
+        {
+                .ctl_name       = CTL_UNNUMBERED,
+                .procname       = "nfs",
+                .mode           = 0555,
+                .child          = nfs_sysctls,
+        },
+        { .ctl_name = 0 }
+};
+
+static ctl_table nfs_sysctl_root[] = {
+        {
+                .ctl_name       = CTL_FS,
+                .procname       = "fs",
+                .mode           = 0555,
+                .child          = nfs_sysctl_dir,
+        },
+        { .ctl_name = 0 }
+};
+
+#endif /* CONFIG_SYSCTL */
+#endif /* _LINUX_NFS_SYSCTL_H */

--=-87D+eS/0/qmlA5DSD6x0--

