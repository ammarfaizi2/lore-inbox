Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265823AbUFTDd6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265823AbUFTDd6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 23:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265828AbUFTDd6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 23:33:58 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:11398 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S265823AbUFTDd4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 23:33:56 -0400
Subject: Re: inode_unused list corruption in 2.4.26 - spin_lock problem?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Chris Caputo <ccaputo@alt.net>, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>, riel@redhat.com
In-Reply-To: <20040620001529.GA4326@logos.cnet>
References: <Pine.LNX.4.44.0406181730370.1847-100000@nacho.alt.net>
	 <20040620001529.GA4326@logos.cnet>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1087702435.5361.64.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 19 Jun 2004 23:33:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På lau , 19/06/2004 klokka 20:15, skreiv Marcelo Tosatti:

> The changes between 2.4.25->2.4.26 (which introduce __refile_inode() and 
> the unused_pagecache list) must have something to do with this. 

Here's one question:

Given the fact that in iput(), the inode remains hashed and the
inode->i_state does not change until after we've dropped the inode_lock,
called write_inode_now(), and then retaken the inode_lock, exactly what
is preventing a third party task from grabbing that inode?

(Better still: write_inode_now() itself actually calls __iget(), which
could cause that inode to be plonked right back onto the "inode_in_use"
list if ever refile_inode() gets called.)

So does the following patch help?

Cheers,
  Trond

--- linux-2.4.27-pre3/fs/inode.c.orig	2004-05-20 20:41:41.000000000 -0400
+++ linux-2.4.27-pre3/fs/inode.c	2004-06-19 23:22:29.000000000 -0400
@@ -1200,6 +1200,7 @@ void iput(struct inode *inode)
 		struct super_block *sb = inode->i_sb;
 		struct super_operations *op = NULL;
 
+again:
 		if (inode->i_state == I_CLEAR)
 			BUG();
 
@@ -1241,11 +1242,16 @@ void iput(struct inode *inode)
 				if (!(inode->i_state & (I_DIRTY|I_LOCK))) 
 					__refile_inode(inode);
 				inodes_stat.nr_unused++;
-				spin_unlock(&inode_lock);
-				if (!sb || (sb->s_flags & MS_ACTIVE))
+				if (!sb || (sb->s_flags & MS_ACTIVE)) {
+					spin_unlock(&inode_lock);
 					return;
-				write_inode_now(inode, 1);
-				spin_lock(&inode_lock);
+				}
+				if (inode->i_state & I_DIRTY) {
+					__iget(inode);
+					spin_unlock(&inode_lock);
+					write_inode_now(inode, 1);
+					goto again;
+				}
 				inodes_stat.nr_unused--;
 				list_del_init(&inode->i_hash);
 			}

