Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965660AbWKGR4g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965660AbWKGR4g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 12:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965326AbWKGR4g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 12:56:36 -0500
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:44248 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S932769AbWKGR4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 12:56:34 -0500
Date: Tue, 7 Nov 2006 18:56:01 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jeff Layton <jlayton@redhat.com>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels that offer x86 compatability
Message-ID: <20061107175601.GB29746@wohnheim.fh-wedel.de>
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com> <20061106182222.GO27140@parisc-linux.org> <1162838843.12129.8.camel@dantu.rdu.redhat.com> <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com> <20061106211134.GB691@wohnheim.fh-wedel.de> <454FAAF8.8080707@redhat.com> <1162914966.28425.24.camel@dantu.rdu.redhat.com> <20061107172835.GB15629@wohnheim.fh-wedel.de> <20061107174217.GA29746@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20061107174217.GA29746@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Things are getting more interesting.  simple_fill_super() looked like
a bug waiting to happen.  It is fairly hard to trigger, but still.
This should fix it, although in a fairly crude manner.

The other callers were save - it is hard to have the root inode
collide with anything existing.

Jörn

-- 
Good warriors cause others to come to them and do not go to others.
-- Sun Tzu


Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 fs/libfs.c |    2 ++
 1 file changed, 2 insertions(+)

--- iunique/fs/libfs.c~iunique_libfs	2006-10-13 15:56:01.000000000 +0200
+++ iunique/fs/libfs.c	2006-11-07 18:54:21.000000000 +0100
@@ -381,6 +381,8 @@ int simple_fill_super(struct super_block
 	inode = new_inode(s);
 	if (!inode)
 		return -ENOMEM;
+	/* ino must not collide with any ino assigned in the loop below */
+	inode->i_ino = 0x8000000;
 	inode->i_mode = S_IFDIR | 0755;
 	inode->i_uid = inode->i_gid = 0;
 	inode->i_blksize = PAGE_CACHE_SIZE;
