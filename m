Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964872AbVITEDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964872AbVITEDl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 00:03:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbVITEDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 00:03:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30434 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964872AbVITEDl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 00:03:41 -0400
Date: Mon, 19 Sep 2005 21:03:36 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: John McCutchan <ttb@tentacle.dhs.org>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under
 load
In-Reply-To: <1127188015.17794.6.camel@vertex>
Message-ID: <Pine.LNX.4.58.0509192054060.2553@g5.osdl.org>
References: <1127177337.15262.6.camel@vertex>  <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org>
  <1127181641.16372.10.camel@vertex>  <Pine.LNX.4.58.0509191909220.2553@g5.osdl.org>
 <1127188015.17794.6.camel@vertex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Sep 2005, John McCutchan wrote:
> 
> I think the name fsnotify_inoderemove is causing some confusion. We only
> care that some name that is pointing to this inode has been deleted. 
> Remember, it was suggested as a replacement for fsnotify_unlink. We
> don't care if the inode is actually going away or not. 

Ahh. 

Well, the problem is one of ordering. You could do it unconditionally at 
the top of d_delete(). If that's ok, then good.

The problem with that is that the name will still be available for a while 
afterwards - another process could look it up on another CPU.

And the _name_ won't be gone until after we've already dropped the inode.  
Remember? You got oopses because you were trying to access an inode that
simply didn't exist any more..

That's where "dentry_iput()" comes in. It's after you've removed the name, 
but before the inode is gone. However, then you do end up having the 
problem that you can't tell a delete from a "drop the dcache entry" any 
more.

One possibility is to mark the dentry deleted in d_flags. That would mean 
something like this (against the just-pushed-put v2.6.14-rc2, which has 
my previous hack).

Untested. Al?

		Linus
---
diff --git a/fs/dcache.c b/fs/dcache.c
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -102,7 +102,7 @@ static inline void dentry_iput(struct de
 		list_del_init(&dentry->d_alias);
 		spin_unlock(&dentry->d_lock);
 		spin_unlock(&dcache_lock);
-		if (!inode->i_nlink)
+		if (dentry->d_flags & DCACHE_DELETED)
 			fsnotify_inoderemove(inode);
 		if (dentry->d_op && dentry->d_op->d_iput)
 			dentry->d_op->d_iput(dentry, inode);
@@ -1166,6 +1166,7 @@ void d_delete(struct dentry * dentry)
 	 */
 	spin_lock(&dcache_lock);
 	spin_lock(&dentry->d_lock);
+	dentry->d_flags |= DCACHE_DELETED;
 	isdir = S_ISDIR(dentry->d_inode->i_mode);
 	if (atomic_read(&dentry->d_count) == 1) {
 		dentry_iput(dentry);
diff --git a/include/linux/dcache.h b/include/linux/dcache.h
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -155,6 +155,7 @@ d_iput:		no		no		no       yes
 
 #define DCACHE_REFERENCED	0x0008  /* Recently used, don't discard. */
 #define DCACHE_UNHASHED		0x0010	
+#define DCACHE_DELETED		0x0020
 
 extern spinlock_t dcache_lock;
 
