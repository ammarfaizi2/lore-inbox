Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbUDTGIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbUDTGIq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 02:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbUDTGIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 02:08:45 -0400
Received: from outmx003.isp.belgacom.be ([195.238.2.100]:20653 "EHLO
	outmx003.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S262063AbUDTGI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 02:08:27 -0400
Subject: Re: [PATCH 2.6.6rc1-mm1] NFS sysctlized - readahead tunable
From: FabianF <Fabian.Frederick@skynet.be>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1082419262.3360.24.camel@lade.trondhjem.org>
References: <1082407753.18853.12.camel@bluerhyme.real3>
	 <1082408907.3360.14.camel@lade.trondhjem.org>
	 <1082410183.19241.12.camel@bluerhyme.real3>
	 <1082419262.3360.24.camel@lade.trondhjem.org>
Content-Type: multipart/mixed; boundary="=-TvjjXWpnmGoqYlkG9+u/"
Message-Id: <1082441531.2104.2.camel@bluerhyme.real3>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 20 Apr 2004 08:12:11 +0200
X-RAVMilter-Version: 8.4.3(snapshot 20030212) (outmx003.isp.belgacom.be)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-TvjjXWpnmGoqYlkG9+u/
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Tue, 2004-04-20 at 02:01, Trond Myklebust wrote:
> On Mon, 2004-04-19 at 17:29, Fabian Frederick wrote:
> > But hey ! "I'm an absolute beginner" :) Maybe you and Andrew can tell me
> > what to do with this ugly patch ;) e.g. no sysctl.h -> include stuff in
> > inode.c ...
> 
> Yes.
This 'superbeast in time' patch against same patchset:
	-Type fixes
	-All in inode.c

Regards,
Fabian
> 

--=-TvjjXWpnmGoqYlkG9+u/
Content-Disposition: attachment; filename=nfsctl2.diff
Content-Type: text/x-patch; name=nfsctl2.diff; charset=iso-8859-1
Content-Transfer-Encoding: 7bit

diff -Naur orig/fs/nfs/inode.c edited/fs/nfs/inode.c
--- orig/fs/nfs/inode.c	2004-04-19 20:27:30.000000000 +0200
+++ edited/fs/nfs/inode.c	2004-04-20 08:05:48.000000000 +0200
@@ -11,6 +11,10 @@
  *  Change to nfs_read_super() to permit NFS mounts to multi-homed hosts.
  *  J.S.Peatfield@damtp.cam.ac.uk
  *
+ *  April 2004 : Fabian Frederick
+ *		 -Add sysctl
+ *		 -maxreadahead to sysctl
+ *
  */
 
 #include <linux/config.h>
@@ -42,13 +46,52 @@
 #define NFSDBG_FACILITY		NFSDBG_VFS
 #define NFS_PARANOIA 1
 
-/* Maximum number of readahead requests
- * FIXME: this should really be a sysctl so that users may tune it to suit
- *        their needs. People that do NFS over a slow network, might for
- *        instance want to reduce it to something closer to 1 for improved
- *        interactive response.
- */
-#define NFS_MAX_READAHEAD	(RPC_DEF_SLOT_TABLE - 1)
+#include <linux/sysctl.h>
+
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
+                .proc_handler   = &proc_dointvec_minmax,
+                .extra1         = (unsigned int *) &nfs_maxreadahead_min,
+                .extra2         = (unsigned int *) &nfs_maxreadahead_max,
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
+#endif
 
 static void nfs_invalidate_inode(struct inode *);
 static int nfs_update_inode(struct inode *, struct nfs_fattr *, unsigned long);
@@ -326,7 +369,7 @@
 		server->acdirmin = server->acdirmax = 0;
 		sb->s_flags |= MS_SYNCHRONOUS;
 	}
-	server->backing_dev_info.ra_pages = server->rpages * NFS_MAX_READAHEAD;
+	server->backing_dev_info.ra_pages = server->rpages * nfs_maxreadahead;
 
 	sb->s_maxbytes = fsinfo.maxfilesize;
 	if (sb->s_maxbytes > MAX_LFS_FILESIZE) 
@@ -1814,6 +1857,11 @@
 #ifdef CONFIG_PROC_FS
 	rpc_proc_register(&nfs_rpcstat);
 #endif
+#ifdef CONFIG_SYSCTL
+	nfs_sysctl_table = register_sysctl_table(nfs_sysctl_root, 0);
+	if(!nfs_sysctl_table)
+		return -ENOMEM;
+#endif
         err = register_filesystem(&nfs_fs_type);
 	if (err)
 		goto out;
@@ -1844,6 +1892,9 @@
 #endif
 	unregister_filesystem(&nfs_fs_type);
 	unregister_nfs4fs();
+#ifdef CONFIG_SYSCTL 
+	unregister_sysctl_table(nfs_sysctl_table);
+#endif
 }
 
 /* Not quite true; I just maintain it */

--=-TvjjXWpnmGoqYlkG9+u/--

