Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272512AbTHPAyX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 20:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272525AbTHPAyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 20:54:23 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:10882 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272512AbTHPAyW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 20:54:22 -0400
Date: Sat, 16 Aug 2003 01:54:08 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>, Mike Galbraith <efault@gmx.de>
Subject: Re: Scheduler activations (IIRC) question
Message-ID: <20030816005408.GA21356@mail.jlokier.co.uk>
References: <200308160149.29834.kernel@kolivas.org> <20030815230312.GD19707@mail.jlokier.co.uk> <20030815235431.GT1027@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815235431.GT1027@matchmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
> On Sat, Aug 16, 2003 at 12:03:12AM +0100, Jamie Lokier wrote:
> > I think it's been done before, under the name "scheduler activations",
> > on some other kernel.
> > 
> 
> Wouldn't futexes help with this?

Futexes are great for the waking up part, not so great for putting
another task to sleep :)

I see two ways to use a futex.

   1. Active task changes a synchronisation word.
   2. Active task FUTEX_WAKEs the shadow task before syscall.
   3. Syscall.
   4. Active task restores synchronisation word.
      ..time passes..
   5. Shadow task runs.
   6. Looks at synchronisation word, which says "go back to sleep".
   7. Shadow task sleeps with FUTEX_WAIT.

This isn't bad, except that a shadow task runs every time we do a
potentially blocking system call from the active task, _or_ is often
ready to run.

If it's just often ready to run, that's not a problem.  If it always
runs immediately, that's two unnecessary context switches per system
call; quite an overhead, and I might as well hand off system calls to
helper threads in that case :)

Next way is the same, except that control is always handed to the
shadow task and the active task, when the system call is finished,
queues the current state machine for the shadow task to pick it up and
then sleeps.  Effectively the active and shadow tasks swap roles on
each system call.

This may or may not be better, depending on whether we've reduced the
average number of context switches to 1 or increased it to 1 :)

It'd wreck the kernel scheduler's interactivity heuristics, too :):)

The first futex method would be quite efficient if a variant of
FUTEX_WAIT was clever enough not to need to be scheduled just to go
back to sleep when the word has the "go back to sleep" value.

Third way is just to use SIGCONT and SIGSTOP.  Not the fastest, but
perhaps faster than the futex-induced context switches.  It'd need to
be measured.

None of these will work well if "wakee" tasks are able to run
immediately after being woken, before "waker" tasks get a chance to
either block or put the wakees back to sleep.

-- Jamie
