Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317581AbSHMT1u>; Tue, 13 Aug 2002 15:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319010AbSHMT1u>; Tue, 13 Aug 2002 15:27:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:29408 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317581AbSHMT1t>;
	Tue, 13 Aug 2002 15:27:49 -0400
Date: Tue, 13 Aug 2002 21:31:46 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] exit_free(), 2.5.31-A0
In-Reply-To: <Pine.LNX.4.44.0208131148340.7411-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0208132119520.8104-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Linus Torvalds wrote:

> The same thing comes up when you want to do an execve() (yes, I know
> pthreads doesn't support a thread starting another process, but the fact
> that pthreads is broken is no excuse for broken interfaces).

fixing this too would be very nice indeed.

> If the parent needs to be notified that the stack slot is no longer in
> use, it needs to happen for execve() too, not just exit().
> 
> In fact, I'd say that this thing is tied in to "mm_release()", not
> "exit()".

yes.

from the practical POV right now we have a dualness of APIs. exit() is a
way to exit a current thread and destroy it. execve() is a way to exit()  
the current thread and bootstrapping a completely new thread from scratch
- while saving over some well-specified state into the new thread.

so for any threading library to handle execve() correctly, there needs to
be some way to specify an mm_release event. It's in essence the same
'exit' conceptual thing we do in both the sys_exit() and sys_execve()
case, but it's accessible via two external interfaces.

one solution would be a new syscall to set 'VM exit notification' address
and value in the released VM. But since it would always come in pair with
sys_exit() or sys_execve(), it would be nicer to have a composite syscalls
as well - ie. exit_release_user_mm() and execve_release_user_mm(). I know
this is a pain to look at, but i dont have any better ideas right now. The
composite syscalls also have the advantage that no additional per-thread
field has to be used, since user-space can be notified right at the
beginning.

hm, maybe there's an idea: perhaps the most elegant way would be to handle
this at clone() time: if the CLONE_NOTIFY_MM_RELEASE flag is specified
then the top of the user stack address is taken as the notification
address. (or a new parameter can be used.) And the notification can as
well be an implicit 'set to 0' rule. [so it's basically a VM lock extended
to userspace.] The user-space stack's address is known at clone() time
already, nothing wants to change that address until exit() time.

mm_release() then sees this address set in current->, and notifies the
userspace VM of the release. No need for new syscalls, and *all* 'exit'
variants in the future will automatically have this capability, without
having to create clumsy composite syscalls.
 
> The fact that the child doesn't want to send a signal to the parent on
> exit is a totally different matter, and should already be supported by
> just giving a zero signal number.

yes.

	Ingo

