Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271213AbRIGFV1>; Fri, 7 Sep 2001 01:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271207AbRIGFVS>; Fri, 7 Sep 2001 01:21:18 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:43973 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S271186AbRIGFU5>;
	Fri, 7 Sep 2001 01:20:57 -0400
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15256.22858.57091.769101@napali.hpl.hp.com>
Date: Thu, 6 Sep 2001 22:21:14 -0700
To: Andrea Arcangeli <andrea@suse.de>
Cc: David Mosberger <davidm@hpl.hp.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] proposed fix for ptrace() SMP race
In-Reply-To: <20010907032801.N11329@athlon.random>
In-Reply-To: <200109062300.QAA27430@napali.hpl.hp.com>
	<20010907021900.L11329@athlon.random>
	<15256.6038.599811.557582@napali.hpl.hp.com>
	<20010907032801.N11329@athlon.random>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Fri, 7 Sep 2001 03:28:01 +0200, Andrea Arcangeli <andrea@suse.de> said:

  Andrea> For making sure the task isn't wakenup while it's under
  Andrea> ptrace we should just do that in
  Andrea> kernel/signal.c::ignored_signal() as far I can tell.

This doesn't make sense: ignored_signal() is too late as
handle_stop_signal() will already have woken up the task in response
to a SIGCONT.  Also, if you're suggesting to ignore SIGCONT while a
PT_PTRACED is set, that certainly wouldn't be right.  We only want to
*delay* the wakeup while the ptrace() system call is running (which is
much shorter than the period of time PT_PTRACED is set).  So, as far
as I can tell, you'd have to add more locking to the signal path,
which doesn't look attractive to me. Also, if pursuing approach, we'd
have to prove that we cover all possible paths that could wake up the
task.  E.g., PTRACE_SYSCALL and PTRACE_CONT are other ways the task
could be woken up.  These particular cases should be fine, because
they'll already be serialized by the BKL acquired during ptrace(), but
I'm not so sure there aren't any other cases.

So, I still think cpus_allowed is a safer and better approach at least
for 2.4.  Yes, we'd have to add locking for writing cpus_allowed, but
I'd say that makes sense anyhow given that it is being manipulated by
other tasks.

Hmmh, looking at ptrace() more closely, the entire locking situation
seems to be a bit confused.  For example, what's stopping wait4() from
releasing the task structure just after ptrace() released the
tasklist_lock and before it checked child->state?

	--david
