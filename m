Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266338AbUGAWIT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266338AbUGAWIT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 18:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266361AbUGAWIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 18:08:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:5588 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266338AbUGAWGx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 18:06:53 -0400
Date: Thu, 1 Jul 2004 15:09:44 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan Kara <jack@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix minor quota race
Message-Id: <20040701150944.19b33862.akpm@osdl.org>
In-Reply-To: <20040701200740.GE3540@atrey.karlin.mff.cuni.cz>
References: <20040701200740.GE3540@atrey.karlin.mff.cuni.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Kara <jack@suse.cz> wrote:
>
> I'm sending one more quota fix - it fixes a possible race between
> quotaoff and prune_icache. The race could lead to some forgotten
> pointers to quotas in inodes leading later to BUG when invalidating
> quota structures. The patch is against 2.6.7.

It tossed one reject against the lock ranking comment in dquot.c.  I fixed
that up.

I'll apply the below patch on top of it - please always put extern decls in
header files so that the implementor and all users of the data/function
always see the same declaration.



diff -puN fs/dquot.c~fix-minor-quota-race-tweaks fs/dquot.c
--- 25/fs/dquot.c~fix-minor-quota-race-tweaks	Thu Jul  1 15:05:45 2004
+++ 25-akpm/fs/dquot.c	Thu Jul  1 15:06:12 2004
@@ -730,11 +730,6 @@ static void put_dquot_list(struct list_h
 	}
 }
 
-/* Function in inode.c - remove pointers to dquots in icache */
-extern void remove_dquot_ref(struct super_block *, int, struct list_head *);
-
-extern struct semaphore iprune_sem;
-
 /* Gather all references from inodes and drop them */
 static void drop_dquot_ref(struct super_block *sb, int type)
 {
diff -puN include/linux/fs.h~fix-minor-quota-race-tweaks include/linux/fs.h
--- 25/include/linux/fs.h~fix-minor-quota-race-tweaks	Thu Jul  1 15:05:45 2004
+++ 25-akpm/include/linux/fs.h	Thu Jul  1 15:07:08 2004
@@ -1386,6 +1386,8 @@ extern void clear_inode(struct inode *);
 extern void destroy_inode(struct inode *);
 extern struct inode *new_inode(struct super_block *);
 extern int remove_suid(struct dentry *);
+extern void remove_dquot_ref(struct super_block *, int, struct list_head *);
+extern struct semaphore iprune_sem;
 
 extern void __insert_inode_hash(struct inode *, unsigned long hashval);
 extern void remove_inode_hash(struct inode *);
_

