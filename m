Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265461AbUBAVmA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 16:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265465AbUBAVmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 16:42:00 -0500
Received: from fw.osdl.org ([65.172.181.6]:55253 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265461AbUBAVl6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 16:41:58 -0500
Date: Sun, 1 Feb 2004 13:41:48 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Roland McGrath <roland@redhat.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: More waitpid issues with CLONE_DETACHED/CLONE_THREAD
In-Reply-To: <20040201051204.GB27271@nevyn.them.org>
Message-ID: <Pine.LNX.4.58.0402011333020.2229@home.osdl.org>
References: <20040201032525.GA10254@nevyn.them.org>
 <Pine.LNX.4.58.0401312014420.2033@home.osdl.org> <20040201044331.GA27271@nevyn.them.org>
 <20040201051204.GB27271@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 1 Feb 2004, Daniel Jacobowitz wrote:
> 
> Here you go.  The bug turns out not to be related directly to
> CLONE_DETACHED.  Compile testcase with -DNOTHREAD to use fork (well,
> clone, but without the fancy flags), without -DNOTHREAD to use
> CLONE_DETACHED | CLONE_THREAD.

I don't think this bug has anything to do with anything else.

This program seems to show that PTRACE_KILL simply doesn't work.

What ptrace_kill() does is effectively:

 - stage 1: ptrace_check_attach(): wait for child stopped

 - stage 2: PTRACE_KILL does:

	child->exit_code = SIGKILL;
	wake_up_process(child);

and the thing is, it looks like the signal handling changes have totally
made the child ignore the "exit_code" thing, unless I'm seriously
misreading something.

Roland, you know this code better than I do. Any comments?

I suspect the PTRACE_KILL logic should also do a

	spin_lock_irqsave(child->sighand->siglock, flags);
	sigaddset(&child->pending->signal, SIGKILL);
	set_tsk_thread_flag(child, TIF_SIGPENDING);
	spin_unlock_irqrestore(child->sighand->siglock, flags);

	ptrace_detach(child);

which would set the SIGKILL thing properly, but I suspect we had a good
reason not to do it that way originally. 

Daniel?

		Linus
