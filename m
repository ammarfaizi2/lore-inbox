Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261748AbUCBTsn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 14:48:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261751AbUCBTsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 14:48:43 -0500
Received: from ns.suse.de ([195.135.220.2]:477 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261748AbUCBTsl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 14:48:41 -0500
Subject: [PATCH] ext2 -ENOSPC bug
From: Chris Mason <mason@suse.com>
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain
Message-Id: <1078257067.3932.53.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 02 Mar 2004 14:51:07 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

find_group_other looks buggy for ext2 and ext3 in 2.6, it can cause
-ENOSPC errors when the fs has plenty of free room.

To hit the bug, you need a filesystem where:

parent_group has no free blocks (but might have free inodes)
Every other group has with free inodes has no free blocks.

That gets you down to the final linear search in find_group_other.  The
linear search has two bugs:

group = parent_group + 1; means we start searching at parent_group + 2
because the loop increments group before using it.

for(i = 2 ; i < ngroups ; i++) means we don't search through all the
groups.

The end result is that parent_group and parent_group + 1 are not checked
for free inodes in the final linear search.  ext3 has the same problem,
my patch below fixes both but is largely untested.

I've got an image available that shows the bug if people are interested.

-chris

Index: linux.t/fs/ext2/ialloc.c
===================================================================
--- linux.t.orig/fs/ext2/ialloc.c	2004-02-05 16:56:28.000000000 -0500
+++ linux.t/fs/ext2/ialloc.c	2004-03-02 14:23:20.284235337 -0500
@@ -431,8 +431,8 @@
 	 * That failed: try linear search for a free inode, even if that group
 	 * has no free blocks.
 	 */
-	group = parent_group + 1;
-	for (i = 2; i < ngroups; i++) {
+	group = parent_group;
+	for (i = 0; i < ngroups; i++) {
 		if (++group >= ngroups)
 			group = 0;
 		desc = ext2_get_group_desc (sb, group, &bh);
Index: linux.t/fs/ext3/ialloc.c
===================================================================
--- linux.t.orig/fs/ext3/ialloc.c	2004-02-05 16:56:28.000000000 -0500
+++ linux.t/fs/ext3/ialloc.c	2004-03-02 14:45:52.910477449 -0500
@@ -398,8 +398,8 @@
 	 * That failed: try linear search for a free inode, even if that group
 	 * has no free blocks.
 	 */
-	group = parent_group + 1;
-	for (i = 2; i < ngroups; i++) {
+	group = parent_group;
+	for (i = 0; i < ngroups; i++) {
 		if (++group >= ngroups)
 			group = 0;
 		desc = ext3_get_group_desc (sb, group, &bh);


