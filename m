Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266218AbSKLFts>; Tue, 12 Nov 2002 00:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266223AbSKLFts>; Tue, 12 Nov 2002 00:49:48 -0500
Received: from fmr01.intel.com ([192.55.52.18]:60360 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S266218AbSKLFtq>;
	Tue, 12 Nov 2002 00:49:46 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC921@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Jamie Lokier'" <lk@tantalophile.demon.co.uk>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       "'mingo@redhat.com'" <mingo@redhat.com>,
       "'Mark Mielke'" <mark@mark.mielke.cc>, linux-kernel@vger.kernel.org
Subject: RE: Users locking memory using futexes
Date: Mon, 11 Nov 2002 21:56:32 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > This raises a good point - I guess we should be doing something like
> > checking user limits (against locked memory, 'ulimit -l').

> If futexes are limited by user limits, that's going to mean some
> threading program gets a surprise when too many threads decide to
> block on a resource.  That's really nasty.  (Of course, a program can
> get a surprise due to just running out of memory in sys_futex() too,
> but that's much rarer).
 
Sure, as I mentioned in my email, that'd be _a_ way to do it, but I am not
convinced at all it is the best -- of course, I don't know what could be the
best way to do it; maybe a capability? a per-process tunable in /proc?
another rlimit and we break POSIX? [do we?]

Good thing is - I just found out after reading twice - that FUTEX_FD does
not lock the page in memory, so that is one case less to worry about. 

In this context I was wondering it it really makes sense to worry about too
many threads of a DoS process blocking on futex_wait() to lock memory out.
At least, as an excercise ...

> It would be nice if the futex waitqueues could be re-hashed against
> swap entries when pages are swapped out, somehow, but this 
> sounds hard.

I am starting to think it could be done with no effort -- just off my
little-knoledgeable-head -- let's say it can be done:

In futex_wait(), we lock the page, store it and the offset [and whatever
else] as now, and then releasing just after queueing in the hash table; this
way the page can go wild to swap.

Some other process has locked it, then goes on to do something else and the
page ends up in swap. Whenever we call _wake() - or tell_waiters(), we need
to make sure the page is in RAM - if not, we can page it in (__pin_page()
does it already) and lock it, do the thing, unlock it.

So, this would mean this patch should suffice:
--- futex.c	12 Nov 2002 05:38:55 -0000	1.1.1.3.8.1
+++ futex.c	12 Nov 2002 05:50:35 -0000
@@ -281,10 +277,12 @@
 	/* Page is pinned, but may no longer be in this address space. */
 	if (get_user(curval, (int *)uaddr) != 0) {
 		ret = -EFAULT;
+                unpin_page(page);
 		goto out;
 	}
 	if (curval != val) {
 		ret = -EWOULDBLOCK;
+                unpin_page(page);
 		goto out;
 	}
 	/*
@@ -295,6 +293,7 @@
 	 * the waiter from the list.
 	 */
 	add_wait_queue(&q.waiters, &wait);
+        unpin_page(page);
 	set_current_state(TASK_INTERRUPTIBLE);
 	if (!list_empty(&q.list))
 		time = schedule_timeout(time);
@@ -313,7 +312,6 @@
 	/* Were we woken up anyway? */
 	if (!unqueue_me(&q))
 		ret = 0;
-	unpin_page(page);
 
 	return ret;
 }

Rusty, Ingo: am I missing something big in here? I am kind of green in the
interactions between the address spaces.

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]

