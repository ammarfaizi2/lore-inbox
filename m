Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752916AbWKCBlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752916AbWKCBlz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 20:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752915AbWKCBlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 20:41:55 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7316 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751893AbWKCBly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 20:41:54 -0500
Date: Thu, 2 Nov 2006 17:41:49 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc: Gabriel C <nix.or.die@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: New filesystem for Linux
Message-Id: <20061102174149.3578062d.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0611030219270.7781@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0611022221330.4104@artax.karlin.mff.cuni.cz>
	<454A71EB.4000201@googlemail.com>
	<Pine.LNX.4.64.0611030219270.7781@artax.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Nov 2006 02:22:57 +0100 (CET)
Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz> wrote:

> BTW. I've found a weird code in 2.6.19rc4 in vfs_getattr:
> generic_fillattr(inode, stat); (ends with stat->blksize = (1 << 
> inode->i_blkbits);)
> and then
> if (!stat->blksize) {...

Good point.  I queued a patch to kill it.

> Someone made this bug when changing it.

Well, not really.  I very much doubt if we ever had any inodes with a zero
in ->i_blksize.  I suspect that code (which has been like that since at
least 2.6.12) just never did anything.





From: Andrew Morton <akpm@osdl.org>

As Mikulas points out, (1 << anything) won't be evaluating to zero.  This code
is long-dead.

Cc: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 fs/stat.c |    7 -------
 1 files changed, 7 deletions(-)

diff -puN fs/stat.c~vfs_getattr-remove-dead-code fs/stat.c
--- a/fs/stat.c~vfs_getattr-remove-dead-code
+++ a/fs/stat.c
@@ -51,13 +51,6 @@ int vfs_getattr(struct vfsmount *mnt, st
 		return inode->i_op->getattr(mnt, dentry, stat);
 
 	generic_fillattr(inode, stat);
-	if (!stat->blksize) {
-		struct super_block *s = inode->i_sb;
-		unsigned blocks;
-		blocks = (stat->size+s->s_blocksize-1) >> s->s_blocksize_bits;
-		stat->blocks = (s->s_blocksize / 512) * blocks;
-		stat->blksize = s->s_blocksize;
-	}
 	return 0;
 }
 
_

