Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318770AbSH1HDN>; Wed, 28 Aug 2002 03:03:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318771AbSH1HDM>; Wed, 28 Aug 2002 03:03:12 -0400
Received: from zok.SGI.COM ([204.94.215.101]:31898 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S318770AbSH1HDM>;
	Wed, 28 Aug 2002 03:03:12 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: neilb@cse.unsw.edu.au
Cc: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.19 Generate better code for nfs_sillyrename
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Aug 2002 17:07:20 +1000
Message-ID: <5810.1030518440@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using strlen() generates an unnecessary inline function expansion plus
dynamic stack adjustment.  For constant strings, strlen() == sizeof()-1
and the object code is better.  Patch against 2.4.19.

diff -urp 2.4.x-xfs-linux/fs/nfs/dir.c 2.4.x-xfs-linux-kdb/fs/nfs/dir.c
--- 2.4.x-xfs-linux/fs/nfs/dir.c	Fri Aug  9 16:03:57 2002
+++ 2.4.x-xfs-linux-kdb/fs/nfs/dir.c	Wed Aug 28 16:54:44 2002
@@ -741,7 +741,7 @@ static int nfs_sillyrename(struct inode 
 	static unsigned int sillycounter;
 	const int      i_inosize  = sizeof(dir->i_ino)*2;
 	const int      countersize = sizeof(sillycounter)*2;
-	const int      slen       = strlen(".nfs") + i_inosize + countersize;
+	const int      slen       = sizeof(".nfs")-1 + i_inosize + countersize;
 	char           silly[slen+1];
 	struct qstr    qsilly;
 	struct dentry *sdentry;

