Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262394AbTIUM41 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 08:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbTIUM41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 08:56:27 -0400
Received: from hera.cwi.nl ([192.16.191.8]:64955 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S262394AbTIUM4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 08:56:25 -0400
From: Andries.Brouwer@cwi.nl
Date: Sun, 21 Sep 2003 14:56:17 +0200 (MEST)
Message-Id: <UTC200309211256.h8LCuHG29226.aeb@smtp.cwi.nl>
To: jpcartal@free.fr, linux-kernel@vger.kernel.org
Subject: [PATCH] Re: suid bit behaviour modification in 2.6.0-test5
Cc: akpm@osdl.org, torvalds@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jpcartal@free.fr writes:

	I noticed that contrary to what was happening with 2.4.x kernel, suid 
	root files don't loose their suid bit when they get overwritten by a 
	normal user (see example below)

	Is this the intended behaviour or a bug ?

	Example :

	[root@localhost test]# chown root ~cartaljp/test/suid_test
	[root@localhost test]# chmod 4775 ~cartaljp/test/suid_test
	[root@localhost test]# exit
	[cartaljp@localhost test]$ cp /bin/ls suid_test
	[cartaljp@localhost test]$ ls -l
	total 72
	-rwsrwxr-x    1 root     cartaljp    67668 Sep 19 07:56 suid_test <- 
	Suid bit is still set whereas with 2.4.x kernel it was reset.

Yes. Here 2.4 had the terrible code

     mode = (inode->i_mode & S_IXGRP)*(S_ISGID/S_IXGRP) | S_ISUID;

while 2.6 does things via notify_change().
However, in 2.6 notify_change() does not allow removal of the SUID bit
because you are not owner of the file :-).
So, we have to convince inode_change_ok() to do it anyway.
Below a patch.

Andries


diff -u --recursive --new-file -X /linux/dontdiff a/mm/filemap.c b/mm/filemap.c
--- a/mm/filemap.c	Sat Aug 23 13:30:20 2003
+++ b/mm/filemap.c	Sun Sep 21 13:55:38 2003
@@ -1437,7 +1437,7 @@
 
 	/* was any of the uid bits set? */
 	if (mode && !capable(CAP_FSETID)) {
-		newattrs.ia_valid = ATTR_KILL_SUID | ATTR_KILL_SGID;
+		newattrs.ia_valid = ATTR_KILL_SUID | ATTR_KILL_SGID | ATTR_FORCE;
 		notify_change(dentry, &newattrs);
 	}
 }
