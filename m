Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267372AbTBPT5x>; Sun, 16 Feb 2003 14:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267382AbTBPT5x>; Sun, 16 Feb 2003 14:57:53 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:18367 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267372AbTBPT5v>;
	Sun, 16 Feb 2003 14:57:51 -0500
Date: Sun, 16 Feb 2003 21:07:25 +0100 (CET)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.q-ag.de
To: Linus Torvalds <torvalds@transmeta.com>
cc: "Martin J. Bligh" <mbligh@aracnet.com>, Anton Blanchard <anton@samba.org>,
       Andrew Morton <akpm@digeo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@holomorphy.com>
Subject: Re: more signal locking bugs?
In-Reply-To: <Pine.LNX.4.44.0302161139530.2952-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0302162100140.24528-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Feb 2003, Linus Torvalds wrote:

> 
> On Sun, 16 Feb 2003, Manfred Spraul wrote:
> >
> > ABBA is not a deadlock, because linux read_locks permit recursive calls.
> > 
> >     read_lock(tasklist_lock);
> >     task_lock(tsk);
> >     read_lock(tasklist_lock);
> > 
> > Does not deadlock, nor any other ordering.
> > 
> > The tasklist_lock is never taken for write from bh or irq context.
> 
> Doesn't matter.
> 
> 	CPU1 - do_exit()	)
> 	write_lock_irq(&tasklist_lock);	
> 	task_lock(tsk);	
> 
> BOOM, you're dead.
> 
> See? ABBA _does_ happen with the task lock.
>
But these lines are not in 2.4 or 2.5.61.
The current rule to nesting tasklist_lock and task_lock is
- read_lock(&tasklist_lock) and task_lock can be mixed in any order.
- write_lock_irq(&tasklist_lock) and task_lock are incompatible.

What about this minimal patch? The performance critical operation is 
signal delivery - we should fix the synchronization between signal 
delivery and exec first.

--
	Manfred
<<
--- 2.5/fs/proc/array.c	2003-02-15 10:29:22.000000000 +0100
+++ build-2.5/fs/proc/array.c	2003-02-16 20:58:37.000000000 +0100
@@ -208,23 +208,27 @@
 {
 	sigset_t ign, catch;
 
-	buffer += sprintf(buffer, "SigPnd:\t");
-	buffer = render_sigset_t(&p->pending.signal, buffer);
-	*buffer++ = '\n';
-	buffer += sprintf(buffer, "ShdPnd:\t");
-	buffer = render_sigset_t(&p->signal->shared_pending.signal, buffer);
-	*buffer++ = '\n';
-	buffer += sprintf(buffer, "SigBlk:\t");
-	buffer = render_sigset_t(&p->blocked, buffer);
-	*buffer++ = '\n';
-
-	collect_sigign_sigcatch(p, &ign, &catch);
-	buffer += sprintf(buffer, "SigIgn:\t");
-	buffer = render_sigset_t(&ign, buffer);
-	*buffer++ = '\n';
-	buffer += sprintf(buffer, "SigCgt:\t"); /* Linux 2.0 uses "SigCgt" */
-	buffer = render_sigset_t(&catch, buffer);
-	*buffer++ = '\n';
+	read_lock(&tasklist_lock);
+	if (p->signal && p->sighand) {
+		buffer += sprintf(buffer, "SigPnd:\t");
+		buffer = render_sigset_t(&p->pending.signal, buffer);
+		*buffer++ = '\n';
+		buffer += sprintf(buffer, "ShdPnd:\t");
+		buffer = render_sigset_t(&p->signal->shared_pending.signal, buffer);
+		*buffer++ = '\n';
+		buffer += sprintf(buffer, "SigBlk:\t");
+		buffer = render_sigset_t(&p->blocked, buffer);
+		*buffer++ = '\n';
+
+		collect_sigign_sigcatch(p, &ign, &catch);
+		buffer += sprintf(buffer, "SigIgn:\t");
+		buffer = render_sigset_t(&ign, buffer);
+		*buffer++ = '\n';
+		buffer += sprintf(buffer, "SigCgt:\t"); /* Linux 2.0 uses "SigCgt" */
+		buffer = render_sigset_t(&catch, buffer);
+		*buffer++ = '\n';
+	}
+	read_unlock(&tasklist_lock);
 
 	return buffer;
 }
<<

