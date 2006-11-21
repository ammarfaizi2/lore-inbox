Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755694AbWKUWSA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755694AbWKUWSA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756459AbWKUWSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:18:00 -0500
Received: from server42.ukservers.net ([217.10.138.242]:34950 "EHLO
	server42.ukservers.net") by vger.kernel.org with ESMTP
	id S1755694AbWKUWR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:17:59 -0500
Date: Tue, 21 Nov 2006 22:17:52 +0000
From: James Hunt <james@jameshunt.org.uk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, sct@redhat.com
Subject: [PATCH 2/3] ext2/3/4: enable "undeletable" file attribute.
Message-ID: <20061121221752.GB12422@localdomain>
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

This patch makes ext2 aware of the undeletable attribute such that
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
 fs/ext2/inode.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index dd4e14c..39c7470 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1042,11 +1042,13 @@ void ext2_set_inode_flags(struct inode *
 {
 	unsigned int flags = EXT2_I(inode)->i_flags;
 
-	inode->i_flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC);
+	inode->i_flags &= ~(S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC|S_UNRM);
 	if (flags & EXT2_SYNC_FL)
 		inode->i_flags |= S_SYNC;
 	if (flags & EXT2_APPEND_FL)
 		inode->i_flags |= S_APPEND;
+	if (flags & EXT2_UNRM_FL)
+		inode->i_flags |= S_UNRM;
 	if (flags & EXT2_IMMUTABLE_FL)
 		inode->i_flags |= S_IMMUTABLE;
 	if (flags & EXT2_NOATIME_FL)
-- 
1.4.1

-- 
JaMeS
