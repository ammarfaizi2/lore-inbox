Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132911AbRBRONt>; Sun, 18 Feb 2001 09:13:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132922AbRBRONj>; Sun, 18 Feb 2001 09:13:39 -0500
Received: from fungus.teststation.com ([212.32.186.211]:4762 "EHLO
	fungus.svenskatest.se") by vger.kernel.org with ESMTP
	id <S132911AbRBRONc>; Sun, 18 Feb 2001 09:13:32 -0500
Date: Sun, 18 Feb 2001 15:13:30 +0100 (CET)
From: Urban Widmark <urban@teststation.com>
To: <linux-kernel@vger.kernel.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [patch] smbfs does not support LFS (2.4.1-ac18)
Message-ID: <Pine.LNX.4.30.0102180118460.10156-100000@cola.teststation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello

Unless I misunderstand s_maxbytes it says how large a file can be on the
fs. I assume it is enough for a fs to set that and then it knows the vfs
will not ask it to go beyond that limit?

Is it ok to at mount time set it to non-LFS and then later change it to be
something larger? smbfs doesn't actually know what the server and smbmount
negotiates until later, but no smbfs operation can take place before that
anyway.

For smbfs the limit is currently 2G, it does unsigned -> signed internally
and it lacks support from smbmount. The later makes the server (tested vs
NT4sp6) return errors beyond 2G.

Quick patch below to keep it within limits.


For people needing LFS in smbfs I have a *very* experimental pair of
patches here:
    http://www.hojdpunkten.ac.se/054/samba/index.html
(It worked last night, it may still work today. You need to patch both the
 kernel and samba ./configure)

/Urban


diff -ur -X exclude linux-2.4.1-ac18-orig/fs/smbfs/inode.c linux-2.4.1-ac18-smbfs/fs/smbfs/inode.c
--- linux-2.4.1-ac18-orig/fs/smbfs/inode.c	Sun Feb 18 01:20:31 2001
+++ linux-2.4.1-ac18-smbfs/fs/smbfs/inode.c	Sun Feb 18 14:06:15 2001
@@ -399,7 +399,7 @@
 	sb->s_magic = SMB_SUPER_MAGIC;
 	sb->s_flags = 0;
 	sb->s_op = &smb_sops;
-	sb->s_maxbytes = ~0;	/* Server limited not client */
+	sb->s_maxbytes = MAX_NON_LFS;	/* client support missing */
 
 	sb->u.smbfs_sb.mnt = NULL;
 	sb->u.smbfs_sb.sock_file = NULL;

