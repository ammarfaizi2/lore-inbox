Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbTAVUdx>; Wed, 22 Jan 2003 15:33:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263215AbTAVUdw>; Wed, 22 Jan 2003 15:33:52 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:57064 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id <S262824AbTAVUdv>;
	Wed, 22 Jan 2003 15:33:51 -0500
Message-Id: <200301222050.PAA03194@moss-shockers.ncsc.mil>
Date: Wed, 22 Jan 2003 15:50:22 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: [RFC][PATCH] Restore LSM hook calls to sendfile
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linux-security-module@wirex.com, sds@epoch.ncsc.mil
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: Q9TVZLaSNZYu6WjzdyNubg==
X-Mailer: dtmail 1.2.0 CDE Version 1.2 SunOS 5.6 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch restores the LSM hook calls in sendfile to 2.5.59.  The hook
was previously added as of 2.5.29 but the hook calls in sendfile were
subsequently lost as a result of the sendfile rewrite as of 2.5.30.

If anyone has any objections to this change, please let me know.

 read_write.c |    8 ++++++++
 1 files changed, 8 insertions(+)
-----

===== fs/read_write.c 1.25 vs edited =====
--- 1.25/fs/read_write.c	Sat Dec 14 18:19:55 2002
+++ edited/fs/read_write.c	Wed Jan 22 15:21:04 2003
@@ -531,6 +531,10 @@
 	if (retval)
 		goto fput_in;
 
+	retval = security_file_permission (in_file, MAY_READ);
+	if (retval)
+		goto fput_in;
+
 	/*
 	 * Get output file, and verify that it is ok..
 	 */
@@ -545,6 +549,10 @@
 		goto fput_out;
 	out_inode = out_file->f_dentry->d_inode;
 	retval = locks_verify_area(FLOCK_VERIFY_WRITE, out_inode, out_file, out_file->f_pos, count);
+	if (retval)
+		goto fput_out;
+
+	retval = security_file_permission (out_file, MAY_WRITE);
 	if (retval)
 		goto fput_out;
 


--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

