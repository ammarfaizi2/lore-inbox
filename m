Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262154AbVEEQUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262154AbVEEQUE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 12:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVEEQUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 12:20:03 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:3334 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262144AbVEEQTc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 12:19:32 -0400
To: dwmw2@infradead.org
CC: akpm@osdl.org, dedekind@infradead.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <1115284240.12012.416.camel@baythorne.infradead.org> (message
	from David Woodhouse on Thu, 05 May 2005 10:10:40 +0100)
Subject: Re: [PATCH] VFS bugfix: two read_inode() calles without
	clear_inode() call between
References: <1114607741.12617.4.camel@sauron.oktetlabs.ru>
	 <E1DQoui-0002In-00@dorka.pomaz.szeredi.hu>
	 <1114618748.12617.23.camel@sauron.oktetlabs.ru>
	 <E1DQqZu-0002Rf-00@dorka.pomaz.szeredi.hu>
	 <1114673528.3483.2.camel@sauron.oktetlabs.ru>
	 <20050428003450.51687b65.akpm@osdl.org>
	 <1115209055.8559.12.camel@sauron.oktetlabs.ru>
	 <20050504130450.7c90a422.akpm@osdl.org>
	 <1115242507.12012.394.camel@baythorne.infradead.org>
	 <20050504145811.63e9bb10.akpm@osdl.org> <1115284240.12012.416.camel@baythorne.infradead.org>
Message-Id: <E1DTj3z-0005By-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Thu, 05 May 2005 18:18:59 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That comment isn't true any more. Look at what __wait_on_freeing_inode()
> actually does, and observe the fact that all its callers actually loop
> and start again after calling it. 
> 
> The current implementation of __wait_on_freeing_inode() waits until it
> _might_ have changed, not until it _has_ changed. That's why it's OK for
> it just to be a yield() or a wait on a bit_waitqueue.
> 
> I'm not convinced I _like_ that implementation, mind you -- it's changed
> since I last looked at it. But I don't see that there's anything
> strictly broken about it.

Using yield() to wait for a precisely defined event (clear_inode()
finishing) doesn't seem like a very good idea.  Especially, since
Artem's patch will probably make it trigger more often.

How about this (totally untested) patch?  Even if I_LOCK is not set
initially, wake_up_inode() should do the right thing and wake up the
waiting task after clear_inode().  It shouldn't cause spurious
wakeups, since there should be no other reference to the inode.

Miklos

--- inode.c~	2005-05-02 11:24:49.000000000 +0200
+++ inode.c	2005-05-05 18:12:57.000000000 +0200
@@ -1264,18 +1264,6 @@ static void __wait_on_freeing_inode(stru
 {
 	wait_queue_head_t *wq;
 	DEFINE_WAIT_BIT(wait, &inode->i_state, __I_LOCK);
-
-	/*
-	 * I_FREEING and I_CLEAR are cleared in process context under
-	 * inode_lock, so we have to give the tasks who would clear them
-	 * a chance to run and acquire inode_lock.
-	 */
-	if (!(inode->i_state & I_LOCK)) {
-		spin_unlock(&inode_lock);
-		yield();
-		spin_lock(&inode_lock);
-		return;
-	}
 	wq = bit_waitqueue(&inode->i_state, __I_LOCK);
 	prepare_to_wait(wq, &wait.wait, TASK_UNINTERRUPTIBLE);
 	spin_unlock(&inode_lock);
