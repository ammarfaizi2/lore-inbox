Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266003AbUGAQXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266003AbUGAQXs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 12:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUGAQXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 12:23:48 -0400
Received: from mail-relay-4.tiscali.it ([212.123.84.94]:24466 "EHLO
	sparkfist.tiscali.it") by vger.kernel.org with ESMTP
	id S266003AbUGAQXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 12:23:47 -0400
Date: Thu, 1 Jul 2004 18:23:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Roland McGrath <roland@redhat.com>, Andreas Schwab <schwab@suse.de>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: zombie with CLONE_THREAD
Message-ID: <20040701162328.GK15086@dualathlon.random>
References: <200407010706.i6176pTa019793@magilla.sf.frob.com> <Pine.LNX.4.58.0407010843450.11212@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0407010843450.11212@ppc970.osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 01, 2004 at 08:49:10AM -0700, Linus Torvalds wrote:
> 
> 
> On Thu, 1 Jul 2004, Roland McGrath wrote:
> > 
> > > .. since this information should be available anyway (we'll have woken up 
> > > the tracer, and the tracer will see that the child is gone by simply 
> > > seeing the ESRCH errorcode from ptrace).
> > 
> > When did you wake up the tracer?  I don't see how that happened.
> 
> exit_notify() will inform the tracer:
> 
>         if (tsk->exit_signal != -1 && thread_group_empty(tsk)) {
>                 int signal = tsk->parent == tsk->real_parent ? tsk->exit_signal : SIGCHLD;
>                 do_notify_parent(tsk, signal);
>         } else if (tsk->ptrace) {
> ***             do_notify_parent(tsk, SIGCHLD);   *****
>         }
> 
> so this should catch it. It even gets the pid of the child in the siginfo 
> structure if it really wants to see that..

it will get the wakeup, but that doesn't mean wait4 will return if
it's waiting for all childs. Now I don't know but with strace it may
even be ok by luck, but it certainly changes the semantics of
wait4/ptrace at least a little and I could remotely imagine if somebody
wants a wait4 to return when a ptraced child exited, if there are other
"regular" children. That's why I admitted it can be considered a feature
and not a completely worthless effort to leave self-reaping tasks as
zombies if they're ptraced.
