Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbUANVBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 16:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264467AbUANVBc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 16:01:32 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:35490 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S264455AbUANVBa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 16:01:30 -0500
Subject: Re: 2.4.24 SMP lockups
From: David Woodhouse <dwmw2@infradead.org>
To: Simon Kirby <sim@netnation.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       viro@ftp.uk.linux.org, davej@redhat.com
In-Reply-To: <1074104903.7098.18.camel@hades.cambridge.redhat.com>
References: <20040109210450.GA31404@netnation.com>
	 <Pine.LNX.4.58L.0401101719400.1310@logos.cnet>
	 <20040114170753.GB8467@netnation.com>
	 <1074104903.7098.18.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Message-Id: <1074114083.7098.39.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.2) 
Date: Wed, 14 Jan 2004 21:01:24 +0000
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-14 at 18:28 +0000, David Woodhouse wrote:
> I _think_ it's true that the _only_ way we can get woken from
> __wait_on_freeing_inode() is the inode has actually been destroyed, in
> which case it's fine just to _not_ remove ourselves from the (defunct)
> wait queue, and to return. But I need to stare hard at it some more,
> have another cup of tea, and ask Al :)

It does look like it should be OK. As far as I can tell, the only place
that looks like it could wake us without actually destroying the inode
is __sync_one(), and I really can't see how we'd get there with an
I_FREEING inode. I'd be inclined to stick a BUG() in for testing
purposes, to make sure the assumption is true.

I note that in prune_icache() in the CONFIG_HIGHMEM case, we're actually
dropping I_LOCK on an inode without waking its wait queue. I suspect
that's wrong and wants fixing too...

(untested)
===== fs/inode.c 1.47 vs edited =====
--- 1.47/fs/inode.c	Thu Jan  8 12:23:51 2004
+++ edited/fs/inode.c	Wed Jan 14 20:51:18 2004
@@ -250,9 +250,10 @@
  * ->read_inode, and we want to be sure that evidence of the deletion is found
  * by ->read_inode.
  *
- * This call might return early if an inode which shares the waitq is woken up.
- * This is most easily handled by the caller which will loop around again
- * looking for the inode.
+ * Unlike the 2.6 version, this call call cannot return early, since inodes
+ * do not share wait queue. Therefore, we don't call remove_wait_queue(); it
+ * would be dangerous to do so since the inode may have already been freed, 
+ * and it's unnecessary, since the inode is definitely going to get freed.
  *
  * This is called with inode_lock held.
  */
@@ -264,7 +265,7 @@
         set_current_state(TASK_UNINTERRUPTIBLE);
         spin_unlock(&inode_lock);
         schedule();
-        remove_wait_queue(&inode->i_wait, &wait);
+
         spin_lock(&inode_lock);
 }
 
@@ -325,7 +326,7 @@
 	list_del(&inode->i_list);
 	list_add(&inode->i_list, &inode->i_sb->s_locked_inodes);
 
-	if (inode->i_state & I_LOCK)
+	if (inode->i_state & (I_LOCK|I_FREEING))
 		BUG();
 
 	/* Set I_LOCK, reset I_DIRTY */
@@ -344,8 +345,7 @@
 
 	spin_lock(&inode_lock);
 	inode->i_state &= ~I_LOCK;
-	if (!(inode->i_state & I_FREEING))
-		__refile_inode(inode);
+	__refile_inode(inode);
 	wake_up(&inode->i_wait);
 }
 
@@ -884,6 +884,7 @@
 		/* Release the inode again. */
 		spin_lock(&inode_lock);
 		inode->i_state &= ~I_LOCK;
+		wake_up(&inode->i_wait);
 	}
 	spin_unlock(&inode_lock);
 #endif /* CONFIG_HIGHMEM */





-- 
dwmw2

