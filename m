Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261716AbVDOBtk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261716AbVDOBtk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 21:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbVDOBtk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 21:49:40 -0400
Received: from fire.osdl.org ([65.172.181.4]:63192 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261716AbVDOBte (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 21:49:34 -0400
Date: Thu, 14 Apr 2005 18:49:13 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs: fix a few  'empty body in an if-statement' 
 warnings.
Message-Id: <20050414184913.72831860.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.62.0504150255090.3466@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0504150255090.3466@dragon.hyggekrogen.localhost>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Apr 2005 02:58:54 +0200 (CEST) Jesper Juhl wrote:

| When building with  gcc -W  fs/reiserfs/namei.c:602 has a few warnings 
| about 'empty body in an if-statement'. This patch silences those warnings.

So fix include/linux/reiserfs_xattr.h:
change
#define reiserfs_mark_inode_private(inode)
to
#define reiserfs_mark_inode_private(inode)	do { } while (0)


and not as below.

| Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
| 
| --- linux-2.6.12-rc2-mm3-orig/fs/reiserfs/namei.c	2005-04-11 21:20:55.000000000 +0200
| +++ linux-2.6.12-rc2-mm3/fs/reiserfs/namei.c	2005-04-15 02:54:53.000000000 +0200
| @@ -352,8 +352,9 @@ static struct dentry * reiserfs_lookup (
|          }
|  
|  	/* Propogate the priv_object flag so we know we're in the priv tree */
| -	if (is_reiserfs_priv_object (dir))
| +	if (is_reiserfs_priv_object (dir)) {
|  	    reiserfs_mark_inode_private (inode);
| +	}
|      }
|      reiserfs_write_unlock(dir->i_sb);
|      if ( retval == IO_ERROR ) {
| @@ -599,8 +600,9 @@ static int reiserfs_create (struct inode
|  
|      reiserfs_write_lock(dir->i_sb);
|  
| -    if (locked)
| +    if (locked) {
|          reiserfs_write_lock_xattrs (dir->i_sb);
| +    }
|  
|      retval = journal_begin(&th, dir->i_sb, jbegin_count);
|      if (retval) {
| @@ -640,8 +642,9 @@ static int reiserfs_create (struct inode
|      retval = journal_end(&th, dir->i_sb, jbegin_count) ;
|  
|  out_failed:
| -    if (locked)
| +    if (locked) {
|          reiserfs_write_unlock_xattrs (dir->i_sb);
| +    }
|      reiserfs_write_unlock(dir->i_sb);
|      return retval;
|  }
| @@ -668,8 +671,9 @@ static int reiserfs_mknod (struct inode 
|  
|      reiserfs_write_lock(dir->i_sb);
|  
| -    if (locked)
| +    if (locked) {
|          reiserfs_write_lock_xattrs (dir->i_sb);
| +    }
|  
|      retval = journal_begin(&th, dir->i_sb, jbegin_count) ;
|      if (retval) {
| @@ -714,8 +718,9 @@ static int reiserfs_mknod (struct inode 
|      retval = journal_end(&th, dir->i_sb, jbegin_count) ;
|  
|  out_failed:
| -    if (locked)
| +    if (locked) {
|          reiserfs_write_unlock_xattrs (dir->i_sb);
| +    }
|      reiserfs_write_unlock(dir->i_sb);
|      return retval;
|  }
| @@ -743,8 +748,9 @@ static int reiserfs_mkdir (struct inode 
|      locked = reiserfs_cache_default_acl (dir);
|  
|      reiserfs_write_lock(dir->i_sb);
| -    if (locked)
| +    if (locked) {
|          reiserfs_write_lock_xattrs (dir->i_sb);
| +    }
|  
|      retval = journal_begin(&th, dir->i_sb, jbegin_count) ;
|      if (retval) {
| @@ -799,8 +805,9 @@ static int reiserfs_mkdir (struct inode 
|      d_instantiate(dentry, inode);
|      retval = journal_end(&th, dir->i_sb, jbegin_count) ;
|  out_failed:
| -    if (locked)
| +    if (locked) {
|          reiserfs_write_unlock_xattrs (dir->i_sb);
| +    }
|      reiserfs_write_unlock(dir->i_sb);
|      return retval;
|  }


---
~Randy
