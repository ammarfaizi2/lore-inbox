Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270882AbTHOVPs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 17:15:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270971AbTHOVPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 17:15:48 -0400
Received: from marblerye.cs.uga.edu ([128.192.101.172]:11904 "HELO
	marblerye.cs.uga.edu") by vger.kernel.org with SMTP id S270882AbTHOVPq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 17:15:46 -0400
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH] do_wp_page: BUG on invalid pfn
From: Ed L Cashin <ecashin@uga.edu>
Date: Fri, 15 Aug 2003 17:15:45 -0400
In-Reply-To: <20030815184720.A4D482CE79@lists.samba.org> (Rusty Russell's
 message of "Sat, 16 Aug 2003 03:15:21 +1000")
Message-ID: <877k5e8vwe.fsf@uga.edu>
User-Agent: Gnus/5.090014 (Oort Gnus v0.14) Emacs/21.2
 (i386-debian-linux-gnu)
References: <20030815184720.A4D482CE79@lists.samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell <rusty@rustcorp.com.au> writes:

> In message <87d6fixvpm.fsf@uga.edu> you write:
>> This patch just does what the comment says should be done.
>
> Hi Ed!
>
> 	Not trivial I'm afraid.  Send to Linus and lkml.


This patch just does what the comment says should be done.  I thought
it was a trivial patch, but Rusty Russell has informed me otherwise.
(Thanks, RR).


--- linux-2.6.0-test2/mm/memory.c.orig	Sun Jul 27 13:01:24 2003
+++ linux-2.6.0-test2/mm/memory.c	Wed Aug  6 18:30:55 2003
@@ -990,15 +990,10 @@
 	int ret;
 
 	if (unlikely(!pfn_valid(pfn))) {
-		/*
-		 * This should really halt the system so it can be debugged or
-		 * at least the kernel stops what it's doing before it corrupts
-		 * data, but for the moment just pretend this is OOM.
-		 */
-		pte_unmap(page_table);
 		printk(KERN_ERR "do_wp_page: bogus page at address %08lx\n",
 				address);
-		goto oom;
+		dump_stack();
+		BUG();
 	}
 	old_page = pfn_to_page(pfn);
 
@@ -1054,7 +1049,6 @@
 
 no_mem:
 	page_cache_release(old_page);
-oom:
 	ret = VM_FAULT_OOM;
 out:
 	spin_unlock(&mm->page_table_lock);

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

