Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932096AbVK1NiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbVK1NiH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 08:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932097AbVK1NiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 08:38:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:11172 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932096AbVK1NiG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 08:38:06 -0500
Date: Mon, 28 Nov 2005 14:37:57 +0100
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Allow lockless traversal of notifier lists
Message-ID: <20051128133757.GQ20775@brahms.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As discussed in other thread.

Just needed an additional write barrier, so that a parallel
running lockup can never see inconsistent state. As long as there
is no unregistration or the unregistration is done using
locking or RCU in the caller they should be ok now.

This only makes a difference on non i386/x86-64 architectures.
x86 was already ok because it never reorders writes.

That's the first step for fixing all the callers. Some that 
already don't unregister or do it safely are already ok.

Also fixed up the kerneldoc description to document the various
locking restriction.

Signed-off-by: Andi Kleen <ak@suse.de>

diff -u linux-2.6.15rc2-work/kernel/sys.c-o linux-2.6.15rc2-work/kernel/sys.c
--- linux-2.6.15rc2-work/kernel/sys.c-o	2005-11-16 00:34:33.000000000 +0100
+++ linux-2.6.15rc2-work/kernel/sys.c	2005-11-28 14:33:20.000000000 +0100
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
+	wmb();
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
