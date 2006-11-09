Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424058AbWKIPZx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424058AbWKIPZx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 10:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424052AbWKIPZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 10:25:17 -0500
Received: from mx1.redhat.com ([66.187.233.31]:6871 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1424047AbWKIPYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 10:24:55 -0500
Subject: [PATCH 3/3] new_inode_autonum: fix up possible i_ino collision in
	simple_fill_super()
From: Jeff Layton <jlayton@redhat.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@osdl.org
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Nov 2006 10:24:46 -0500
Message-Id: <1163085886.21469.47.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

simple_fill_super() looked like a bug waiting to happen.  It is fairly hard to
trigger, but still. This should fix it, although in a fairly crude manner.
    
Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
Signed-off-by: Jeff Layton <jlayton@redhat.com>

diff --git a/fs/libfs.c b/fs/libfs.c
index bd08e0e..477c012 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -373,6 +373,10 @@ int simple_fill_super(struct super_block
 	inode = new_inode(s);
 	if (!inode)
 		return -ENOMEM;
+	/* ino must not collide with any ino assigned in the loop below.
+	 * This value is arbitrary but should be "big enough" to avoid
+	 * collisions. */
+	inode->i_ino = 0x8000000;
 	inode->i_mode = S_IFDIR | 0755;
 	inode->i_uid = inode->i_gid = 0;
 	inode->i_blocks = 0;


