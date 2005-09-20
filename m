Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964841AbVITCUb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964841AbVITCUb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 22:20:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964842AbVITCUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 22:20:30 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24270 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964841AbVITCUa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 22:20:30 -0400
Date: Mon, 19 Sep 2005 19:20:26 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: John McCutchan <ttb@tentacle.dhs.org>
cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Robert Love <rml@novell.com>, Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [patch] stop inotify from sending random DELETE_SELF event under
 load
In-Reply-To: <1127181641.16372.10.camel@vertex>
Message-ID: <Pine.LNX.4.58.0509191909220.2553@g5.osdl.org>
References: <1127177337.15262.6.camel@vertex>  <Pine.LNX.4.58.0509191821220.2553@g5.osdl.org>
 <1127181641.16372.10.camel@vertex>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 19 Sep 2005, John McCutchan wrote:
> 
> To quote you:

Yeah, sometimes I'm more right than other times. That wasn't one of them.

It's actually _almost_ right. The problem being that dentry_iput() is 
called for non-delete events too.

However, your patch is _worse_. Your patch will cause it not to report the 
delete at all, because what will happen is that if the delete() is done 
while somebody else has a pointer to the dentry, then we won't call 
"dentry_iput()" with a "delete" AT ALL. We will only call it later when 
the _other_ person (who didn't do a delete) releases the dentry.

See? It's very very wrong to send a flag that depends on the call-chain, 
because the call-chain is _not_ what determines whether the inode gets 
deleted or not.

The only way to know whether it gets deleted or not is whan the actual
i_nlink goes down to 0, and the inode gets deleted. Ie exactly the
generic_delete_inode() case.

But if you keep a reference to the inode, that will never actually happen. 
Hmm.

Who wants that inode delete event anyway? It's fundamentally harder than 
removing a name, partly because of the delayed delete, partly because an 
inode may be reachable multiple ways.

Maybe this patch instead? It's not going to be reliable on networked 
filesystems, though. Nothing is.

		Linus

---
diff --git a/fs/dcache.c b/fs/dcache.c
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -102,7 +102,8 @@ static inline void dentry_iput(struct de
 		list_del_init(&dentry->d_alias);
 		spin_unlock(&dentry->d_lock);
 		spin_unlock(&dcache_lock);
-		fsnotify_inoderemove(inode);
+		if (!inode->i_nlink)
+			fsnotify_inoderemove(inode);
 		if (dentry->d_op && dentry->d_op->d_iput)
 			dentry->d_op->d_iput(dentry, inode);
 		else
