Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262208AbUESSwm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262208AbUESSwm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 14:52:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264500AbUESSwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 14:52:42 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:45205 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262208AbUESSwh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 14:52:37 -0400
Subject: [PATCH] use-before-uninitialized value in ext3(2)_find_ goal
From: Mingming Cao <cmm@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20040519043235.30d47edb.akpm@osdl.org>
References: <20040519043235.30d47edb.akpm@osdl.org>
Content-Type: multipart/mixed; boundary="=-yCTXr9t2LNG52pt4ioq2"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 19 May 2004 11:51:43 -0700
Message-Id: <1084992705.15395.1276.camel@w-ming2.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-yCTXr9t2LNG52pt4ioq2
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I am looking at the how the goal for block allocation is determined in
in ext3_find_goal(), so I wrote a very simple test to do random write by
one process on one file (write() ,then lseek then write then lseek). 
The test shows a bug there.

There is a uninitialized goal value being referenced in both ext3 and
ext2 find goal block functions (ext3_find_goal() and ext2_find_goal()).
In the non-sequential write case, these functions check the goal
value(non zero) before calling ext3(2)_find_near() to find the goal
block to allocate. Since the goal value is uninitialized(non zero), the
ext3(2)_find_near() is never being called in the non-sequential write,
thus ext3(2)_find_goal() failed to guide a goal block in the random
write case. 

ext3(2)_new_block() takes the junk goal value and will turn it to goal 0
since it's normally beyond the filesystem block number limit.

The fix is trivial. 

There is a uninitialized goal value being referenced in both ext3 and ext2 find goal block functions (ext3_find_goal() and ext2_find_goal()). In the non-sequential write case, these functions check the goal value(non zero) before calling ext3(2)_find_near() to find the goal block to allocate. Since the goal value is uninitialized(non zero), the ext3(2)_find_near() is never being called in the non-sequential write, thus ext3(2)_find_goal() failed to guide a goal block in the random write case. ext3(2)_new_block() takes the junk goal value and will turn it to goal 0 since it's normally beyond the filesystem block number limit. The fix is trivial. 


---

 src-ming/fs/ext2/inode.c |    1 +
 src-ming/fs/ext3/inode.c |    1 +
 2 files changed, 2 insertions(+)

diff -puN fs/ext3/inode.c~ext3_find_goal_uninitialization_fix fs/ext3/inode.c
--- src/fs/ext3/inode.c~ext3_find_goal_uninitialization_fix	2004-05-19 18:30:13.857197080 -0700
+++ src-ming/fs/ext3/inode.c	2004-05-19 18:45:31.689665336 -0700
@@ -748,6 +748,7 @@ out:
 	if (err == -EAGAIN)
 		goto changed;
 
+	goal = 0;
 	down(&ei->truncate_sem);
 	if (ext3_find_goal(inode, iblock, chain, partial, &goal) < 0) {
 		up(&ei->truncate_sem);
diff -puN fs/ext2/inode.c~ext3_find_goal_uninitialization_fix fs/ext2/inode.c
--- src/fs/ext2/inode.c~ext3_find_goal_uninitialization_fix	2004-05-19 18:30:13.861196472 -0700
+++ src-ming/fs/ext2/inode.c	2004-05-19 18:45:40.586312840 -0700
@@ -584,6 +584,7 @@ out:
 	if (err == -EAGAIN)
 		goto changed;
 
+	goal = 0;
 	if (ext2_find_goal(inode, iblock, chain, partial, &goal) < 0)
 		goto changed;
 

_

--=-yCTXr9t2LNG52pt4ioq2
Content-Disposition: attachment; filename=ext3_find_goal_uninitialization_fix.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=ext3_find_goal_uninitialization_fix.patch;
	charset=UTF-8


There is a uninitialized goal value being referenced in both ext3 and ext2 =
find goal block functions (ext3_find_goal() and ext2_find_goal()). In the n=
on-sequential write case, these functions check the goal value(non zero) be=
fore calling ext3(2)_find_near() to find the goal block to allocate. Since =
the goal value is uninitialized(non zero), the ext3(2)_find_near() is never=
 being called in the non-sequential write, thus ext3(2)_find_goal() failed =
to guide a goal block in the random write case. ext3(2)_new_block() takes t=
he junk goal value and will turn it to goal 0 since it's normally beyond th=
e filesystem block number limit. The fix is trivial.=20


---

 src-ming/fs/ext2/inode.c |    1 +
 src-ming/fs/ext3/inode.c |    1 +
 2 files changed, 2 insertions(+)

diff -puN fs/ext3/inode.c~ext3_find_goal_unintialization_fix fs/ext3/inode.=
c
--- src/fs/ext3/inode.c~ext3_find_goal_unintialization_fix	2004-05-19 18:30=
:13.857197080 -0700
+++ src-ming/fs/ext3/inode.c	2004-05-19 18:45:31.689665336 -0700
@@ -748,6 +748,7 @@ out:
 	if (err =3D=3D -EAGAIN)
 		goto changed;
=20
+	goal =3D 0;
 	down(&ei->truncate_sem);
 	if (ext3_find_goal(inode, iblock, chain, partial, &goal) < 0) {
 		up(&ei->truncate_sem);
diff -puN fs/ext2/inode.c~ext3_find_goal_unintialization_fix fs/ext2/inode.=
c
--- src/fs/ext2/inode.c~ext3_find_goal_unintialization_fix	2004-05-19 18:30=
:13.861196472 -0700
+++ src-ming/fs/ext2/inode.c	2004-05-19 18:45:40.586312840 -0700
@@ -584,6 +584,7 @@ out:
 	if (err =3D=3D -EAGAIN)
 		goto changed;
=20
+	goal =3D 0;
 	if (ext2_find_goal(inode, iblock, chain, partial, &goal) < 0)
 		goto changed;
=20

_

--=-yCTXr9t2LNG52pt4ioq2--

