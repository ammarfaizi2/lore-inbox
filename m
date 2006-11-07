Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752375AbWKGTlI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbWKGTlI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 14:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbWKGTlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 14:41:08 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27346 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752375AbWKGTlF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 14:41:05 -0500
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels
	that offer x86 compatability
From: Jeff Layton <jlayton@redhat.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061107175601.GB29746@wohnheim.fh-wedel.de>
References: <1162836725.6952.28.camel@dantu.rdu.redhat.com>
	 <20061106182222.GO27140@parisc-linux.org>
	 <1162838843.12129.8.camel@dantu.rdu.redhat.com>
	 <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com>
	 <20061106211134.GB691@wohnheim.fh-wedel.de> <454FAAF8.8080707@redhat.com>
	 <1162914966.28425.24.camel@dantu.rdu.redhat.com>
	 <20061107172835.GB15629@wohnheim.fh-wedel.de>
	 <20061107174217.GA29746@wohnheim.fh-wedel.de>
	 <20061107175601.GB29746@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 Nov 2006 14:41:04 -0500
Message-Id: <1162928464.28425.59.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 18:56 +0100, Jörn Engel wrote:
> Things are getting more interesting.  simple_fill_super() looked like
> a bug waiting to happen.  It is fairly hard to trigger, but still.
> This should fix it, although in a fairly crude manner.
> 
> The other callers were save - it is hard to have the root inode
> collide with anything existing.
> 
> Jörn
> 

Jörn,
  How about this patch instead here? I don't think anything depends on
i_ino being any certain value for these files, and this seems less
"magic-numbery". This should also mostly prevent us from assigning out
i_ino=0.

Signed-off-by: Jeff Layton <jlayton@redhat.com>

diff --git a/fs/libfs.c b/fs/libfs.c
index bd08e0e..506268e 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -373,6 +373,8 @@ int simple_fill_super(struct super_block
 	inode = new_inode(s);
 	if (!inode)
 		return -ENOMEM;
+	/* ino must not collide with any ino assigned in the loop below */
+	inode->i_ino = 1;
 	inode->i_mode = S_IFDIR | 0755;
 	inode->i_uid = inode->i_gid = 0;
 	inode->i_blocks = 0;
@@ -385,7 +387,7 @@ int simple_fill_super(struct super_block
 		iput(inode);
 		return -ENOMEM;
 	}
-	for (i = 0; !files->name || files->name[0]; i++, files++) {
+	for (i = 2; !files->name || files->name[0]; i++, files++) {
 		if (!files->name)
 			continue;
 		dentry = d_alloc_name(root, files->name);


