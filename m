Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267771AbRGQEmz>; Tue, 17 Jul 2001 00:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267772AbRGQEmp>; Tue, 17 Jul 2001 00:42:45 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:29966 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267771AbRGQEmf>; Tue, 17 Jul 2001 00:42:35 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Mon, 16 Jul 2001 21:41:56 -0700
Message-Id: <200107170441.f6H4fux15702@penguin.transmeta.com>
To: tachino@open.nm.fujitsu.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [BUG 2.4.6] PPID of a process is set to itself
Newsgroups: linux.dev.kernel
In-Reply-To: <k818gp7s.wl@nisaaru.open.nm.fujitsu.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <k818gp7s.wl@nisaaru.open.nm.fujitsu.co.jp> you write:
>
>When I am playing with clone system call, I found the case the cloned process
>becomes the zombie which is not reaped because the PPID of the process is
>set to itself. The test program are following.

Heh.

>Following patch fixes the bug, but I don't know this is correct. Can
>someone please explain me why in forget_original_parent(), the parent of
>processes in a thread group is set to another process in the thread
>group?

The point with "CLONE_THREAD" is to create a sibling that is a more
"traditional" thread in the sense that it is more identical to the
original clonee - sharing the same thread group etc, so that we can
implement full POSIX pthreads semantics.

HOWEVER, the bug you hit is because CLONE_THREAD also implies
CLONE_PARENT, and the fork() code didn't actually enforce this. So
instead of your patch, we just should not allow the parent and the child
to be in the same thread group. Suggested real patch appended. Does this
fix it for you too?

Thanks,

		Linus

------
--- linux-orig/kernel/fork.c	Mon Apr 30 22:23:29 2001
+++ linux/kernel/fork.c	Mon Jul 16 21:38:11 2001
@@ -604,7 +604,7 @@
 	p->run_list.next = NULL;
 	p->run_list.prev = NULL;
 
-	if ((clone_flags & CLONE_VFORK) || !(clone_flags & CLONE_PARENT)) {
+	if ((clone_flags & CLONE_VFORK) || !(clone_flags & (CLONE_PARENT | CLONE_THREAD))) {
 		p->p_opptr = current;
 		if (!(p->ptrace & PT_PTRACED))
 			p->p_pptr = current;

