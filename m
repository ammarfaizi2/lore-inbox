Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319326AbSHNUx4>; Wed, 14 Aug 2002 16:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319322AbSHNUxa>; Wed, 14 Aug 2002 16:53:30 -0400
Received: from berzerk.gpcc.itd.umich.edu ([141.211.2.162]:17112 "EHLO
	berzerk.gpcc.itd.umich.edu") by vger.kernel.org with ESMTP
	id <S319326AbSHNUuP>; Wed, 14 Aug 2002 16:50:15 -0400
Date: Wed, 14 Aug 2002 16:54:04 -0400 (EDT)
From: "Kendrick M. Smith" <kmsmith@umich.edu>
X-X-Sender: kmsmith@vanguard.gpcc.itd.umich.edu
To: linux-kernel@vger.kernel.org, <nfs@lists.sourceforge.net>
Subject: REPOST patch 36/38: SERVER: ensure XDR buffer is large enough for
 NFSv4
Message-ID: <Pine.SOL.4.44.0208141653340.1834-100000@vanguard.gpcc.itd.umich.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch changes the 'xdrsize' parameter to svc_create(), to be
     NFS4_SVC_XDRSIZE   if v4 is defined
else NFS3_SVC_XDRSIZE   if v3 is defined
else NFS2_SVC_XDRSIZE     (formerly NFSSVC_XDRSIZE)

This always works, since
     NFS4_SVC_XDRSIZE >= NFS3_SVC_XDRSIZE >= NFS2_SVC_XDRSIZE.

The value of NFSD_BUFSIZE has also been moved to const.h, since we need
the definition available in nfs4proc.c
--- old/fs/nfsd/nfssvc.c	Thu Aug  1 16:16:02 2002
+++ new/fs/nfsd/nfssvc.c	Sun Aug 11 23:15:09 2002
@@ -31,10 +31,11 @@
 #include <linux/nfsd/stats.h>
 #include <linux/nfsd/cache.h>
 #include <linux/nfsd/xdr.h>
+#include <linux/nfsd/xdr3.h>
+#include <linux/nfsd/xdr4.h>
 #include <linux/lockd/bind.h>

 #define NFSDDBG_FACILITY	NFSDDBG_SVC
-#define NFSD_BUFSIZE		(1024 + NFSSVC_MAXBLKSIZE)

 /* these signals will be delivered to an nfsd thread
  * when handling a request
--- old/include/linux/nfsd/const.h	Sun Aug 11 19:20:54 2002
+++ new/include/linux/nfsd/const.h	Sun Aug 11 23:15:09 2002
@@ -30,6 +30,16 @@
 # define NFS_SUPER_MAGIC	0x6969
 #endif

+#define NFSD_BUFSIZE		(1024 + NFSSVC_MAXBLKSIZE)
+
+#ifdef CONFIG_NFSD_V4
+# define NFSSVC_XDRSIZE		NFS4_SVC_XDRSIZE
+#elif defined(CONFIG_NFSD_V3)
+# define NFSSVC_XDRSIZE		NFS3_SVC_XDRSIZE
+#else
+# define NFSSVC_XDRSIZE		NFS2_SVC_XDRSIZE
+#endif
+
 #endif /* __KERNEL__ */

 #endif /* _LINUX_NFSD_CONST_H */
--- old/include/linux/nfsd/xdr.h	Thu Aug  1 16:16:33 2002
+++ new/include/linux/nfsd/xdr.h	Sun Aug 11 23:15:09 2002
@@ -119,7 +119,7 @@ union nfsd_xdrstore {
 	struct nfsd_readdirargs	readdir;
 };

-#define NFSSVC_XDRSIZE		sizeof(union nfsd_xdrstore)
+#define NFS2_SVC_XDRSIZE	sizeof(union nfsd_xdrstore)


 int nfssvc_decode_void(struct svc_rqst *, u32 *, void *);

