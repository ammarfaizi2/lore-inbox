Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261903AbTIFQ1Q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 12:27:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbTIFQ1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 12:27:16 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:42286 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S261903AbTIFQ1F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 12:27:05 -0400
Date: Sat, 6 Sep 2003 17:28:44 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@osdl.org>
cc: Ulrich Drepper <drepper@redhat.com>,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Andrew Morton <akpm@osdl.org>, Stephen Hemminger <shemminger@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: today's futex changes
In-Reply-To: <3F58F0F7.4090105@redhat.com>
Message-ID: <Pine.LNX.4.44.0309061723160.1470-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Sep 2003, Ulrich Drepper wrote:
> ... broke NPTL.  Tests which worked with previous kernels fail now.  One
> test eventually succeeded, but the process somehow got stuck for about
> 30-40 seconds.  Then it finished.  Running strace showed a call to
> clone() as the last operation but there were other threads running at
> that time.
>....
> What I can offer are statically linked versions of the tests.
> One is here: http://people.redhat.com/drepper/tst-cond2.bz2

Very helpful, thank you: it showed two bugs, one new and one old. 
Does the patch below work for you, Ulrich?

The new bug is that "offset" has been declared as an alternative in
the union, instead of as an element in the structures comprising it,
effectively eliminating it from the key: keys match which should not.

The old bug is that if futex_requeue were called with identical
key1 and key2 (sensible? tended to happen given the first bug),
it was liable to loop for a long time holding futex_lock: guard
against that, still respecting the semantics of futex_requeue.

While here, please let's also fix the get_futex_key VM_NONLINEAR
case, which was returning the 1 from get_user_pages, taken as an
error by its callers.  And save a few bytes and improve debuggability
by uninlining the top-level futex_wake, futex_requeue, futex_wait.

Hugh

--- 2.6.0-test4-bk8/kernel/futex.c	Fri Sep  5 21:04:52 2003
+++ linux/kernel/futex.c	Sat Sep  6 16:29:32 2003
@@ -49,16 +49,18 @@
 	struct {
 		unsigned long pgoff;
 		struct inode *inode;
+		int offset;
 	} shared;
 	struct {
 		unsigned long uaddr;
 		struct mm_struct *mm;
+		int offset;
 	} private;
 	struct {
 		unsigned long word;
 		void *ptr;
+		int offset;
 	} both;
-	int offset;
 };
 
 /*
@@ -91,7 +93,7 @@
 {
 	return &futex_queues[hash_long(key->both.word
 				       + (unsigned long) key->both.ptr
-				       + key->offset, FUTEX_HASHBITS)];
+				       + key->both.offset, FUTEX_HASHBITS)];
 }
 
 /*
@@ -101,7 +103,7 @@
 {
 	return (key1->both.word == key2->both.word
 		&& key1->both.ptr == key2->both.ptr
-		&& key1->offset == key2->offset);
+		&& key1->both.offset == key2->both.offset);
 }
 
 /*
@@ -127,10 +129,10 @@
 	/*
 	 * The futex address must be "naturally" aligned.
 	 */
-	key->offset = uaddr % PAGE_SIZE;
-	if (unlikely((key->offset % sizeof(u32)) != 0))
+	key->both.offset = uaddr % PAGE_SIZE;
+	if (unlikely((key->both.offset % sizeof(u32)) != 0))
 		return -EINVAL;
-	uaddr -= key->offset;
+	uaddr -= key->both.offset;
 
 	/*
 	 * The futex is hashed differently depending on whether
@@ -199,6 +201,7 @@
 		key->shared.pgoff =
 			page->index << (PAGE_CACHE_SHIFT - PAGE_SHIFT);
 		put_page(page);
+		return 0;
 	}
 	return err;
 }
@@ -208,7 +211,7 @@
  * Wake up all waiters hashed on the physical page that is mapped
  * to this virtual address:
  */
-static inline int futex_wake(unsigned long uaddr, int num)
+static int futex_wake(unsigned long uaddr, int num)
 {
 	struct list_head *i, *next, *head;
 	union futex_key key;
@@ -247,7 +250,7 @@
  * Requeue all waiters hashed on one physical page to another
  * physical page.
  */
-static inline int futex_requeue(unsigned long uaddr1, unsigned long uaddr2,
+static int futex_requeue(unsigned long uaddr1, unsigned long uaddr2,
 				int nr_wake, int nr_requeue)
 {
 	struct list_head *i, *next, *head1, *head2;
@@ -282,6 +285,9 @@
 				this->key = key2;
 				if (ret - nr_wake >= nr_requeue)
 					break;
+				/* Make sure to stop if key1 == key2 */
+				if (head1 == head2 && head1 != next)
+					head1 = i;
 			}
 		}
 	}
@@ -320,7 +326,7 @@
 	return ret;
 }
 
-static inline int futex_wait(unsigned long uaddr, int val, unsigned long time)
+static int futex_wait(unsigned long uaddr, int val, unsigned long time)
 {
 	DECLARE_WAITQUEUE(wait, current);
 	int ret, curval;


