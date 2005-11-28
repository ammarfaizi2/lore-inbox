Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751044AbVK1QFv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbVK1QFv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 11:05:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbVK1QFv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 11:05:51 -0500
Received: from cantor2.suse.de ([195.135.220.15]:9932 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751044AbVK1QFu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 11:05:50 -0500
Date: Mon, 28 Nov 2005 17:05:47 +0100
From: Andi Kleen <ak@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow lockless traversal of notifier lists
Message-ID: <20051128160547.GA20775@brahms.suse.de>
References: <20051128133757.GQ20775@brahms.suse.de> <20051128160129.GA8478@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051128160129.GA8478@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 09:31:29PM +0530, Dipankar Sarma wrote:
> On Mon, Nov 28, 2005 at 02:37:57PM +0100, Andi Kleen wrote:
> > 
> >   *
> >   *	Currently always returns zero.
> >   */
> > @@ -116,6 +119,7 @@
> >  		list= &((*list)->next);
> >  	}
> >  	n->next = *list;
> > +	wmb();
> >  	*list=n;
> >  	write_unlock(&notifier_lock);
> 
> Shouldn't this be smp_wmb() ?

Yes.

> 
> Also, not all archs have strong ordering for data dependent reads.

Ah you mean the Alpha exception? Right Alpha would need that.

Thanks for the review.

-Andi

Revised patch with Alphaextrawurst.

----
As discussed in other thread.
 
Just needed an additional write barrier, so that a parallel
running lockup can never see inconsistent state. As long as there
is no unregistration or the unregistration is done using
locking or RCU in the caller they should be ok now.

This only makes a difference on non i386/x86-64 architectures.
x86 was already ok because it never reorders writes.


diff -u linux-2.6.15rc2-work/kernel/sys.c-o linux-2.6.15rc2-work/kernel/sys.c
--- linux-2.6.15rc2-work/kernel/sys.c-o	2005-11-16 00:34:33.000000000 +0100
+++ linux-2.6.15rc2-work/kernel/sys.c	2005-11-28 17:03:22.000000000 +0100
@@ -102,6 +102,9 @@
  *	@n: New entry in notifier chain
  *
  *	Adds a notifier to a notifier chain.
+ *	As long as unregister is not used this is safe against parallel
+ *	lockless notifier lookups. If unregister is used then unregister
+ *	needs to do additional locking or use RCU.
  *
  *	Currently always returns zero.
  */
@@ -116,6 +119,7 @@
 		list= &((*list)->next);
 	}
 	n->next = *list;
+	smp_wmb();
 	*list=n;
 	write_unlock(&notifier_lock);
 	return 0;
@@ -129,6 +133,8 @@
  *	@n: New entry in notifier chain
  *
  *	Removes a notifier from a notifier chain.
+ *	Note this needs additional locking or RCU in the caller to be safe
+ * 	against parallel traversals.
  *
  *	Returns zero on success, or %-ENOENT on failure.
  */
@@ -175,6 +181,7 @@
 
 	while(nb)
 	{
+		smp_read_barrier_depends();
 		ret=nb->notifier_call(nb,val,v);
 		if(ret&NOTIFY_STOP_MASK)
 		{

