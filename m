Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262397AbVCSAUP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbVCSAUP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 19:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262385AbVCSATq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 19:19:46 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:51209 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S262325AbVCSASd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 19:18:33 -0500
From: Herbert Xu <herbert@gondor.apana.org.au>
To: rweight@us.ibm.com
Subject: Re: RFC: Bug in generic_forget_inode() ?
Cc: akpm@osdl.org, dev@sw.ru, linux-kernel@vger.kernel.org,
       viro@parcelfarce.linux.theplanet.co.uk
Organization: Core
In-Reply-To: <1111190260.7102.78.camel@russw.beaverton.ibm.com>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.4.27-hx-1-686-smp (i686))
Message-Id: <E1DCRe4-0005wJ-00@gondolin.me.apana.org.au>
Date: Sat, 19 Mar 2005 11:16:48 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russ Weight <rweight@us.ibm.com> wrote:
> 
> The problem is more likely in generic_forget_inode(). It releases the

Exactly.  It's a continuation of the greased turkey bug :)

When we're writing the inode out, we shouldn't place it on the unused
list at all.  Placing the inode on the unused list only makes sense
when we return from generic_forget_inode without actually destroying
the inode.

So we need something like this.  I'm not sure about the nr_unused
counter though.  Should we be incrementing it as we do now even when
we don't put the inode on the unused list?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
===== fs/inode.c 1.144 vs edited =====
--- 1.144/fs/inode.c	2005-03-05 17:41:15 +11:00
+++ edited/fs/inode.c	2005-03-19 11:11:56 +11:00
@@ -1037,12 +1037,14 @@
 	struct super_block *sb = inode->i_sb;
 
 	if (!hlist_unhashed(&inode->i_hash)) {
-		if (!(inode->i_state & (I_DIRTY|I_LOCK)))
-			list_move(&inode->i_list, &inode_unused);
 		inodes_stat.nr_unused++;
-		spin_unlock(&inode_lock);
-		if (!sb || (sb->s_flags & MS_ACTIVE))
+		if (!sb || (sb->s_flags & MS_ACTIVE)) {
+			if (!(inode->i_state & (I_DIRTY|I_LOCK)))
+				list_move(&inode->i_list, &inode_unused);
+			spin_unlock(&inode_lock);
 			return;
+		}
+		spin_unlock(&inode_lock);
 		write_inode_now(inode, 1);
 		spin_lock(&inode_lock);
 		inodes_stat.nr_unused--;
