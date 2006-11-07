Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753356AbWKGVPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753356AbWKGVPb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 16:15:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753251AbWKGVPb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 16:15:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33217 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753034AbWKGVPa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 16:15:30 -0500
Subject: Re: [PATCH] make last_inode counter in new_inode 32-bit on kernels
	that offer x86 compatability
From: Jeff Layton <jlayton@redhat.com>
To: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Eric Sandeen <sandeen@redhat.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061107204135.GF29746@wohnheim.fh-wedel.de>
References: <1162838843.12129.8.camel@dantu.rdu.redhat.com>
	 <20061106202313.GA691@wohnheim.fh-wedel.de> <454FA032.1070008@redhat.com>
	 <20061106211134.GB691@wohnheim.fh-wedel.de> <454FAAF8.8080707@redhat.com>
	 <1162914966.28425.24.camel@dantu.rdu.redhat.com>
	 <20061107172835.GB15629@wohnheim.fh-wedel.de>
	 <20061107174217.GA29746@wohnheim.fh-wedel.de>
	 <20061107175601.GB29746@wohnheim.fh-wedel.de>
	 <1162928464.28425.59.camel@dantu.rdu.redhat.com>
	 <20061107204135.GF29746@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=utf-8
Date: Tue, 07 Nov 2006 16:13:00 -0500
Message-Id: <1162933980.28425.64.camel@dantu.rdu.redhat.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-07 at 21:41 +0100, Jörn Engel wrote:
> On Tue, 7 November 2006 14:41:04 -0500, Jeff Layton wrote:
> > 
> >   How about this patch instead here? I don't think anything depends on
> > i_ino being any certain value for these files, and this seems less
> > "magic-numbery". This should also mostly prevent us from assigning out
> > i_ino=0.
> 
> nfsctl_transaction_write() appears to depend on i_ino.
> 
> Jörn
> 

Ahh, correct. That could probably stand to be a bit more robust, but I
don't want to tackle it now. How about this instead, which should just
set it to the maximum allowed value of s->s_lastino? It might throw a
compile-time warning about overflowing i_ino, but I think it'll still
work.

Signed-off-by: Jeff Layton <jlayton@redhat.com>

diff --git a/fs/libfs.c b/fs/libfs.c
index bd08e0e..d9f4e3e 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -373,6 +373,9 @@ int simple_fill_super(struct super_block
 	inode = new_inode(s);
 	if (!inode)
 		return -ENOMEM;
+	/* ino must not collide with any ino assigned in the loop below. Set
+	   it to the highest possible inode number */
+	inode->i_ino = (1 << (sizeof(s->s_lastino) * 8)) - 1;
 	inode->i_mode = S_IFDIR | 0755;
 	inode->i_uid = inode->i_gid = 0;
 	inode->i_blocks = 0;


