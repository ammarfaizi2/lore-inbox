Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261829AbTIHCJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 22:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbTIHCIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 22:08:25 -0400
Received: from dp.samba.org ([66.70.73.150]:63399 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261871AbTIHCIO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 22:08:14 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2] Little fixes to previous futex patch 
In-reply-to: Your message of "Sun, 07 Sep 2003 13:27:36 +0100."
             <Pine.LNX.4.44.0309071248510.3022-100000@localhost.localdomain> 
Date: Mon, 08 Sep 2003 11:56:12 +1000
Message-Id: <20030908020812.47E0C2C4C1@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0309071248510.3022-100000@localhost.localdomain> you write:
> On Sun, 7 Sep 2003, Ingo Molnar wrote:
> > 
> > btw., regarding this fix:
> > 
> >   ChangeSet@1.1179.2.5, 2003-09-06 12:28:20-07:00, hugh@veritas.com
> >     [PATCH] Fix futex hashing bugs
> > 
> > why dont we do this:
> > 
> >                         } else {
> >                                 /* Make sure to stop if key1 == key2 */
> > 				if (head1 == head2)
> > 					break;
> >                                 list_add_tail(i, head2);
> >                                 this->key = key2;
> >                                 if (ret - nr_wake >= nr_requeue)
> >                                         break;
> >                         }

Why not make the code a *whole* lot more readable (and only marginally
slower, if at all) by doing it in two passes: pull them off onto a
(on-stack) list in one pass, then requeue them all in another.

This on top of Hugh's patch on top of Jamie's.  Untested, but you get
the idea...

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: FUTEX_REQUEUE simplyfication
Author: Rusty Russell
Status: Booted on 2.6.0-test4-bk9
Depends: Misc/futex-hugh.patch.gz

D: Simplify the logic of FUTEX_REQUEUE.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32421-linux-2.6.0-test4-bk9/kernel/futex.c .32421-linux-2.6.0-test4-bk9.updated/kernel/futex.c
--- .32421-linux-2.6.0-test4-bk9/kernel/futex.c	2003-09-08 10:44:26.000000000 +1000
+++ .32421-linux-2.6.0-test4-bk9.updated/kernel/futex.c	2003-09-08 11:24:15.000000000 +1000
@@ -253,8 +253,10 @@ out:
 static int futex_requeue(unsigned long uaddr1, unsigned long uaddr2,
 				int nr_wake, int nr_requeue)
 {
-	struct list_head *i, *next, *head1, *head2;
+	struct list_head *head1, *head2;
+	struct futex_q *this, *next;
 	union futex_key key1, key2;
+	LIST_HEAD(moved);
 	int ret;
 
 	down_read(&current->mm->mmap_sem);
@@ -270,27 +272,29 @@ static int futex_requeue(unsigned long u
 	head2 = hash_futex(&key2);
 
 	spin_lock(&futex_lock);
-	list_for_each_safe(i, next, head1) {
-		struct futex_q *this = list_entry(i, struct futex_q, list);
-
-		if (match_futex (&this->key, &key1)) {
-			list_del_init(i);
+	list_for_each_entry_safe(this, next, head1, list) {
+		if (match_futex(&this->key, &key1)) {
 			if (++ret <= nr_wake) {
+				list_del_init(&this->list);
 				wake_up_all(&this->waiters);
 				if (this->filp)
 					send_sigio(&this->filp->f_owner,
 							this->fd, POLL_IN);
 			} else {
-				list_add_tail(i, head2);
-				this->key = key2;
+				/* Dequeue. */
+				list_del(&this->list);
+				list_add(&this->list, &moved);
 				if (ret - nr_wake >= nr_requeue)
 					break;
-				/* Make sure to stop if key1 == key2 */
-				if (head1 == head2 && head1 != next)
-					head1 = i;
 			}
 		}
 	}
+
+	/* Requeue */
+	list_for_each_entry_safe(this, next, &moved, list) {
+		list_del(&this->list);
+		list_add_tail(&this->list, head2);
+	}
 	spin_unlock(&futex_lock);
 
 out:
