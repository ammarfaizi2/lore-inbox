Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbVK2ACC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbVK2ACC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 19:02:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbVK2ACB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 19:02:01 -0500
Received: from mail.suse.de ([195.135.220.2]:60085 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932293AbVK2ACA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 19:02:00 -0500
Date: Tue, 29 Nov 2005 01:01:58 +0100
From: Andi Kleen <ak@suse.de>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow lockless traversal of notifier lists
Message-ID: <20051129000158.GE7209@brahms.suse.de>
References: <20051128133757.GQ20775@brahms.suse.de> <20051128160129.GA8478@in.ibm.com> <20051128160547.GA20775@brahms.suse.de> <20051128161747.GA4359@in.ibm.com> <20051128162709.GC20775@brahms.suse.de> <20051128174203.GB4359@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051128174203.GB4359@in.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2005 at 11:12:03PM +0530, Dipankar Sarma wrote:
> Don't we insert at the front of the list ? Shouldn't the read-side
> on alpha see the contents of the new notifier block before it sees
> the pointer to the first notifier block in the list head ?

Ok third version, hopefully Dipankar proof now. 

Andrew, please consider applying.

-Andi

---

As discussed in other thread.

 Notifiers could be locklessly traversed if there was no removal
 ever, except that the update order is wrong.
 
 Just needed an additional write barrier, so that a parallel
 running lockup can never see inconsistent state. As long as there
 is no unregistration or the unregistration is done using
 locking or RCU in the caller they should be ok now.

 This only makes a difference on non i386/x86-64 architectures.
 x86 was already ok because it never reorders writes.

Signed-off-by: Andi Kleen <ak@suse.de> 


diff -u linux-2.6.15rc2-work/kernel/sys.c-o linux-2.6.15rc2-work/kernel/sys.c
--- linux-2.6.15rc2-work/kernel/sys.c-o	2005-11-16 00:34:33.000000000 +0100
+++ linux-2.6.15rc2-work/kernel/sys.c	2005-11-29 00:33:26.000000000 +0100
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
@@ -171,10 +177,12 @@
 int notifier_call_chain(struct notifier_block **n, unsigned long val, void *v)
 {
 	int ret=NOTIFY_DONE;
-	struct notifier_block *nb = *n;
-
+	struct notifier_block *nb;
+	smp_read_barrier_depends();
+	nb = *n;
 	while(nb)
 	{
+		smp_read_barrier_depends();
 		ret=nb->notifier_call(nb,val,v);
 		if(ret&NOTIFY_STOP_MASK)
 		{
