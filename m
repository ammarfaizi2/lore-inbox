Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbUKFDB2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbUKFDB2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 22:01:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbUKFDB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 22:01:28 -0500
Received: from [12.177.129.25] ([12.177.129.25]:52931 "EHLO
	ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S261288AbUKFDBU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 22:01:20 -0500
Date: Sat, 6 Nov 2004 00:13:06 -0500
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade_spam@yahoo.it>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       akpm@osdl.org, cw@f00f.org
Subject: Re: Synchronization primitives in UML (was: Re: [uml-devel] Re: [patch 09/20] uml: use SIG_IGN for empty sighandler)
Message-ID: <20041106051306.GA3038@ccure.user-mode-linux.org>
References: <200411052036.55541.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411052036.55541.blaisorblade_spam@yahoo.it>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 05, 2004 at 08:36:55PM +0100, Blaisorblade wrote:
> Also, why shouldn't sigprocmask be restartable with the -ERESTART* mechanism?

Err, that was pause, not sigprocmask.  sigprocmask just switches the signal
mask.

pause is what sits there and waits for something to happen.

> Wouldn't your kludge break?

What kludge?

> Also, a nicer way to code this could be to have an explicit sighandler setting 
> a flag (to get the syscall interrupted if the signal arrives before being 
> blocked) and to call sigpending() (to test if the signal arrived just after 
> setting it). After the syscall, that could become SIG_IGN.

You're seeing races where there aren't any.  SIGWINCH is only possible when
it gets a controlling tty, which happens after the sigprocmask.

> Also, (optional answer), why is this needed? A comment about such issues would 
> be better than an answer email.

The point of this is to handle SIGWINCH on consoles which have host ttys and
relay them inside UML to whatever might be running on the console and cares
about the window size.

So, we have a separate thread for each host tty attached to a UML device
(side-issue - I'm annoyed that one thread can't have multiple controlling
ttys for purposed of handling SIGWINCH, but I imagine there are other reasons
that doesn't make any sense).

SIGWINCH can't be received synchronously, so you have to set up to receive
it as a signal.  That being the case, if you are going to wait for it, it is
convenient to sit in a pause() and wait for the signal to bounce you out of
it.  So, you need a signal handler for the reason I mentioned before, but it's
not needed to do anything.

> Ok. However, I have a general question about all this whole code: why do you 
> use pipes as synchronization primitives? Did you avoid semaphores for 
> portability issues, or for persistency ones? Both can be solved (with the os_
> layer and the IPC_PRIVATE key).

OK, the synchronization here is due to that fact that the argument recieved
by the thread is on the stack of the parent.  The parent can't return from
its current procedure until it knows that the child has copied the data onto
its own stack.  Hence the writing of the byte after it has been copied.

A semaphore would work, and in fact that's exactly what I'm imitating here.
I've avoided SysV semaphores because of a long-standing dislike of them,
stemming mostly from their persistence, and the fact that they need to be
cleaned up manually if the process that created them didn't destroy them.

I just had a look at the man page, and I see this:

       The name choice IPC_PRIVATE was perhaps unfortunate, IPC_NEW would more
       clearly show its function.

So, IPC_PRIVATE ones would seem to be persistent, too.

A more basic issue is the interface.  What I have now is the mapping
	open <-> create
	read <-> down
	write <-> up
	close <-> destroy
which is way simpler and cleaner than semget, semop, and ??? (I can't figure
out how to destroy one of these things).

> This would especially help during context switching, I think. I have just a 
> rough idea of what switch_pipe is for, but calling the network layer (what 
> you call os_pipe() is actually socketpair(), which is very confusing) to rely 
> on the semaphores / wait queues it uses seems suboptimal and ugly.

For context switching, normal pipes (or semaphores) would be fine.  I use 
socketpairs because they support SIGIO, and pipes don't.  I stuck with 
socketpairs just because they do everything I need.

				Jeff
