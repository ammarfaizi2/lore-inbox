Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263589AbTANPQN>; Tue, 14 Jan 2003 10:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263760AbTANPQM>; Tue, 14 Jan 2003 10:16:12 -0500
Received: from mons.uio.no ([129.240.130.14]:31401 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S263589AbTANPQK>;
	Tue, 14 Jan 2003 10:16:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15908.11206.749377.863257@charged.uio.no>
Date: Tue, 14 Jan 2003 16:24:54 +0100
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       NFS maillist <nfs@lists.sourceforge.net>
Subject: [PATCH] Fix RPC client warning in 2.5.58...
In-Reply-To: <Pine.LNX.4.44.0301131556030.1095-100000@penguin.transmeta.com>
References: <15906.28604.625977.386301@charged.uio.no>
	<Pine.LNX.4.44.0301131556030.1095-100000@penguin.transmeta.com>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Linus Torvalds <torvalds@transmeta.com> writes:

     > Trond, with the latest stuff I'm getting infinite streams of
     > 	/lockd/clntef03c480 RPC: Couldn't create pipefs entry

This appears to be due to the lockd process starting RPC clients as an
unprivileged user, causing path_walk() to fail. The following patch
should fix it.

Cheers,
  Trond

diff -u --recursive --new-file linux-2.5.58/net/sunrpc/rpc_pipe.c linux-2.5.58-00-fix_warn/net/sunrpc/rpc_pipe.c
--- linux-2.5.58/net/sunrpc/rpc_pipe.c	2003-01-12 22:39:49.000000000 +0100
+++ linux-2.5.58-00-fix_warn/net/sunrpc/rpc_pipe.c	2003-01-14 16:05:21.000000000 +0100
@@ -342,19 +342,19 @@
 static struct rpc_filelist files[] = {
 	[RPCAUTH_lockd] = {
 		.name = "lockd",
-		.mode = S_IFDIR | S_IRUSR | S_IXUSR,
+		.mode = S_IFDIR | S_IRUGO | S_IXUGO,
 	},
 	[RPCAUTH_nfs] = {
 		.name = "nfs",
-		.mode = S_IFDIR | S_IRUSR | S_IXUSR,
+		.mode = S_IFDIR | S_IRUGO | S_IXUGO,
 	},
 	[RPCAUTH_portmap] = {
 		.name = "portmap",
-		.mode = S_IFDIR | S_IRUSR | S_IXUSR,
+		.mode = S_IFDIR | S_IRUGO | S_IXUGO,
 	},
 	[RPCAUTH_statd] = {
 		.name = "statd",
-		.mode = S_IFDIR | S_IRUSR | S_IXUSR,
+		.mode = S_IFDIR | S_IRUGO | S_IXUGO,
 	},
 };
 
@@ -425,7 +425,7 @@
 		return -ENODEV;
 	}
 	nd->mnt = mntget(rpc_mount);
-	nd->dentry = dget(rpc_mount->mnt_sb->s_root);
+	nd->dentry = dget(rpc_mount->mnt_root);
 	nd->last_type = LAST_ROOT;
 	nd->flags = flags;
 
