Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbUKHRLC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbUKHRLC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 12:11:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261708AbUKHRJU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 12:09:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:12224 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261853AbUKHQh7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 11:37:59 -0500
Date: Mon, 8 Nov 2004 08:37:53 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Sripathi Kodi <sripathik@in.ibm.com>
cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@redhat.com>,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       dino@in.ibm.com
Subject: Re: [PATCH] do_wait fix for 2.6.10-rc1
In-Reply-To: <Pine.LNX.4.58.0411080806400.24286@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0411080820110.24286@ppc970.osdl.org>
References: <418B4E86.4010709@in.ibm.com> <Pine.LNX.4.58.0411051101500.30457@ppc970.osdl.org>
 <418F826C.2060500@in.ibm.com> <Pine.LNX.4.58.0411080744320.24286@ppc970.osdl.org>
 <Pine.LNX.4.58.0411080806400.24286@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Nov 2004, Linus Torvalds wrote:
> 
> Actually, this part of the patch is bogus. If our "put_task_struct" is the
> last one, it doesn't help at all that we're insidfe the tasklist_lock. 
> We'll just release the task structure ourselves.
> 
> The problem remains, though: "do_wait()" does end up accessing "tsk" in
> 
> 	tsk = next_thread(tsk);
> 
> and as far as I can see, "tsk" may be gone by then.
> 
> Is there anything else protecting us? This looks like a serious (if 
> extremely unlikely) bug..

It also looks like we should have gotten an oops in do_wait() if this ever
happened with SLAB poisoning. Google doesn't seem to find any reports like
that.

Of course, the race to make this happen is likely extremely small indeed,
so the reason may just be that nobody ever triggers it in practice (and it
almost certainly requires that a threaded app waits for its children in
multiple threads, which is also fairly unusual - so this is likely a very
small race coupled with an access pattern that doesn't actually happen in
real life).

But maybe it's because I just missed some reason why this all is ok. I'd 
love to be wrong about it.

Anyway, if I'm right, the suggested fix would be something like this (this 
replaces the earlier patches, since it also makes the zero return case go 
away - we don't need to mark anything runnable, since we restart the whole 
loop).

NOTE! -EAGAIN should be safe, because the other routines involved can only
return -EFAULT as an error, so this is all unique to the "try again"  
case.

Ok, three patches for the same piece of code withing minutes. Please tell 
me this one is not also broken..

			Linus

----
===== kernel/exit.c 1.166 vs edited =====
--- 1.166/kernel/exit.c	2004-11-04 11:13:19 -08:00
+++ edited/kernel/exit.c	2004-11-08 08:34:37 -08:00
@@ -1201,8 +1201,15 @@
 		write_unlock_irq(&tasklist_lock);
 bail_ref:
 		put_task_struct(p);
-		read_lock(&tasklist_lock);
-		return 0;
+		/*
+		 * We are returning to the wait loop without having successfully
+		 * removed the process and having released the lock. We cannot
+		 * continue, since the "p" task pointer is potentially stale.
+		 *
+		 * Return -EAGAIN, and do_wait() will restart the loop from the
+		 * beginning. Do _not_ re-acquire the lock.
+		 */
+		return -EAGAIN;
 	}
 
 	/* move to end of parent's list to avoid starvation */
@@ -1343,6 +1350,8 @@
 							   (options & WNOWAIT),
 							   infop,
 							   stat_addr, ru);
+				if (retval == -EAGAIN)
+					goto repeat;
 				if (retval != 0) /* He released the lock.  */
 					goto end;
 				break;
