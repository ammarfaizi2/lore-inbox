Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbVHMLPk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbVHMLPk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 07:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbVHMLPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 07:15:40 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57988 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1751326AbVHMLPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 07:15:40 -0400
Date: Sat, 13 Aug 2005 13:15:34 +0200
From: Jan Kara <jack@suse.cz>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: [PATCH] Fix error handling in reiserfs
Message-ID: <20050813111534.GD4516@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

  the patch below fixes oops triggered when user exceeded his inode
quota on reiserfs (reiserfs incorrectly thought the inode has been
already allocated and tried to free it). Please apply.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs


Initialize key object ID in inode so that we don't try to remove the inode
when we fail on some checks even before we manage to allocate something.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.13-rc6/fs/reiserfs/namei.c linux-2.6.13-rc6-reiser_create_fix/fs/reiserfs/namei.c
--- linux-2.6.13-rc6/fs/reiserfs/namei.c	2005-08-12 10:39:25.000000000 +0200
+++ linux-2.6.13-rc6-reiser_create_fix/fs/reiserfs/namei.c	2005-08-12 10:39:07.000000000 +0200
@@ -593,6 +593,9 @@ static int new_inode_init(struct inode *
 	 */
 	inode->i_uid = current->fsuid;
 	inode->i_mode = mode;
+	/* Make inode invalid - just in case we are going to drop it before
+	 * the initialization happens */
+	INODE_PKEY(inode)->k_objectid = 0;
 
 	if (dir->i_mode & S_ISGID) {
 		inode->i_gid = dir->i_gid;
