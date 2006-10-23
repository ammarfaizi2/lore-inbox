Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751854AbWJWJXb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbWJWJXb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 05:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbWJWJXb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 05:23:31 -0400
Received: from swan.nt.tuwien.ac.at ([128.131.67.158]:46528 "EHLO
	swan.nt.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1751854AbWJWJXb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 05:23:31 -0400
Date: Mon, 23 Oct 2006 11:23:29 +0200
From: Thomas Zeitlhofer <tzeitlho+lkml@nt.tuwien.ac.at>
To: linux-kernel@vger.kernel.org
Subject: mkdir on read-only NFS is broken in 2.6.18
Message-ID: <20061023092329.GA5231@swan.nt.tuwien.ac.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

there is a problem in 2.6.18/.1 when mkdir is called for an existing
directory on a read-only mounted NFS filesystem.

Lets consider a server that exports the directory /export which contains
the directory-tree a/b/c:

1) If /export is mounted ro and the first access to a, b, or c  is
mkdir, then this directory and all directories underneath become
inaccessible:

  client:# mount server:/export /mnt -o ro
  client:# mkdir /mnt/a/b
  mkdir: cannot create directory `/mnt/a/b': Read-only file system
  client:# find /mnt
  /mnt
  /mnt/a
  find: /mnt/a/b: No such file or directory

2) If /export is mounted ro and the first access to a, b, or c  is _not_
by calling mkdir, then a following mkdir does not destroy the directory
structure (and mkdir now returns EEXIST):

  client:# mount server:/export /mnt -o ro
  client:# find /mnt
  /mnt
  /mnt/a
  /mnt/a/b
  /mnt/a/b/c
  client:# mkdir /mnt/a/b
  mkdir: cannot create directory `/mnt/a/b': File exists
  client:# find /mnt
  /mnt
  /mnt/a
  /mnt/a/b
  /mnt/a/b/c

3) If /export is mounted rw (although exported ro), then mkdir does not
destroy the directory structure:

  client:# mount server:/export /mnt -o rw
  client:# mkdir /mnt/a/b
  mkdir: cannot create directory `/mnt/a/b': Read-only file system
  client:# find /mnt
  /mnt
  /mnt/a
  /mnt/a/b
  /mnt/a/b/c

As a consequence of 1), autofs does not work with mountpoints on NFS
(ro) because the automount daemon calls mkdir for all directories in the
path to the mountpoint. This seems related to the discussion [1], and,
as suggested in [1], the issue is fixed by reverting the patch:

http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=a634904a7de0d3a0bc606f608007a34e8c05bfee;hp=ddeff520f02b92128132c282c350fa72afffb84a

So please consider this patch for the next -stable release:

diff --git a/fs/namei.c b/fs/namei.c
index 432d6bc..5201d77 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1774,8 +1774,6 @@ struct dentry *lookup_create(struct name
 	if (nd->last_type != LAST_NORM)
 		goto fail;
 	nd->flags &= ~LOOKUP_PARENT;
-	nd->flags |= LOOKUP_CREATE;
-	nd->intent.open.flags = O_EXCL;
 
 	/*
 	 * Do the final lookup.

--
[1] http://lkml.org/lkml/2006/9/22/182
