Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756428AbWKUWTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756428AbWKUWTV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756462AbWKUWTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:19:21 -0500
Received: from server42.ukservers.net ([217.10.138.242]:28554 "EHLO
	server42.ukservers.net") by vger.kernel.org with ESMTP
	id S1756428AbWKUWTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:19:20 -0500
Date: Tue, 21 Nov 2006 22:19:14 +0000
From: James Hunt <james@jameshunt.org.uk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, sct@redhat.com
Subject: [PATCH 3/3] ext2/3/4: enable "undeletable" file attribute.
Message-ID: <20061121221914.GC12422@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, although you can mark a file as undeletable with 'chattr'...

  > touch /tmp/wibble
  > ls -l /tmp/wibble
  -rw-rw-r-- 1 james james 0 Nov 16 20:00 /tmp/wibble
  > chattr +u /tmp/wibble      # mark file as undeletable
  > lsattr /tmp/wibble
  -u----------- /tmp/wibble

... it's not honoured by the kernel:

  > rm /tmp/wibble             # yikes! this should fail!!

This patch makes ext4 aware of the undeletable attribute such that
attempting to delete a file marked as undeltable works as expected:

  > chattr +u /tmp/wibble      # mark file as undeletable
  > lsattr /tmp/wibble
  -u----------- /tmp/wibble
  > rm /tmp/wibble
  rm: cannot remove `/tmp/wibble': Operation not permitted
  > chattr -u /tmp/wibble      # remove undeletable attribute
  > lsattr /tmp/wibble
  ------------- /tmp/wibble
  > rm /tmp/wibble             # works as expected this time

Tested with e2fsprogs-1.38-12 (FC5).

Signed-off-by: James Hunt <james@jameshunt.org.uk>
---
 fs/ext4/inode.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 0a60ec5..8115b64 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2571,11 +2571,13 @@ void ext4_set_inode_flags(struct inode *
 {
 	unsigned int flags = EXT4_I(inode)->i_flags;
 
-	inode->i_flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC);
+	inode->i_flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC|S_UNRM);
 	if (flags & EXT4_SYNC_FL)
 		inode->i_flags |= S_SYNC;
 	if (flags & EXT4_APPEND_FL)
 		inode->i_flags |= S_APPEND;
+	if (flags & EXT4_UNRM_FL)
+		inode->i_flags |= S_UNRM;
 	if (flags & EXT4_IMMUTABLE_FL)
 		inode->i_flags |= S_IMMUTABLE;
 	if (flags & EXT4_NOATIME_FL)
-- 
1.4.1

-- 
JaMeS
