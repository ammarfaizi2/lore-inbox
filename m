Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbVAUUzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbVAUUzt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 15:55:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbVAUUzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 15:55:48 -0500
Received: from mx2.elte.hu ([157.181.151.9]:37580 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262473AbVAUUzX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 15:55:23 -0500
Date: Fri, 21 Jan 2005 21:54:16 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrea Arcangeli <andrea@cpushare.com>
Cc: Chris Wright <chrisw@osdl.org>, Rik van Riel <riel@redhat.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: seccomp for 2.6.11-rc1-bk8
Message-ID: <20050121205416.GA16915@elte.hu>
References: <20050121100606.GB8042@dualathlon.random> <20050121120325.GA2934@elte.hu> <20050121093902.O469@build.pdx.osdl.net> <Pine.LNX.4.61.0501211338190.15744@chimarrao.boston.redhat.com> <20050121105001.A24171@build.pdx.osdl.net> <20050121195522.GA14982@elte.hu> <20050121203425.GB11112@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121203425.GB11112@dualathlon.random>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrea Arcangeli <andrea@cpushare.com> wrote:

> Indeed. Performance is not an issue (in the short term at least, since
> those syscalls will be probably network bound).
> 
> The only reason I couldn't use ptrace is what you found, that is the
> oom killing of the parent (or a mistake of the CPU seller that kills
> it by mistake by hand, I must prevent him to screw himself ;). Even
> after fixing ptrace, I've an hard time to prefer ptrace, when a
> simple, localized and self contained solution like seccomp is
> available.

ptrace security problems are a matter of fact, but there are really two
types of security barriers related to ptrace:

- first there is the security barrier between a ptrace-ing task (the
  parent) and the kernel/CPU state itself. Ptrace deals with lots of
  complex x86 CPU details, which results in complex ptrace APIs and
  semantics, plus ptrace itself is mainly used by two apps (gdb and
  strace) which use it in a very controlled and synchronous way: all
  this combined resulted in a fair share of bugs/races that allowed
  unprivileged users to break into the kernel via abuse of the ptrace
  APIs.

- the second barrier is the 'jail' of the ptraced task. Especially with
  PTRACE_SYSCALL, the things a child ptraced process can do are
  extremely limited, everything it tries to do will trap, the task will
  suspend and the parent runs. The task is completely passive and ptrace
  on that end is a pretty small engine that stops/traps/restarts user
  processing without alot of frills.

historically there has been alot less problems with the second barrier. 
(in fact i cannot remember even one security issue in that area.)

> I'm open to different solutions, I can even live with you forcing me
> to use the fixed version of ptrace, but you must be confortable to
> take the blame if it breaks ;). [...]

i'm not forcing anyone to do anything, but i think the most logical
solution is to use ptrace. It's there on every Linux box so your client
can run even on 'older' Linux boxes. (You might want to detect in the
client whether the OOM race is fixed in a kernel, but it should not be a
truly big issue.) Waiting for any extra API to get significant userbase
takes at least 1-2 years - while ptrace is here and available on every
Linux box. If you require 'users' to go with a new (or worse: patched)
kernel then you are creating a pretty significant artificial market
penetration barrier for your application.

also, with more applications relying on ptrace it will become more
tested, more robust and people will do speedups. I think the fact that
UML uses ptrace is already a very good sign that it's robust for such
purposes. (_Also_, if there's a security problem in the ptrace barrier,
you'd like to know about it and fix it ASAP - SuSE ships UML, right?)

> [...] Personally I'm confortable to take the blame only if seccomp
> breaks, it's so simple that it can't break. And with break I don't
> mean 0xf00f, that's a minor issue that will be autodetected by the
> system. I mean breaking like killing the ptrace parent right now...
> That can be fixed up reasonably securely too, but it _can't_ be
> autodetected easily (I keep cross logs for everything so I can trace
> it, but it won't be an immediate/automated task like the 0xf00f or
> fcnlex).

an additional idea: you could waitpid() from a 'watchdog' task, on the
parent, and if the parent dies unexpectedly (you get a SIGCHLD) then you
could immediately kill the child PID and log the incident. This still
leaves a small window, but one that is probably quite hard to abuse,
especially since the watchdog task will very likely have the highest
priority amongst those tasks (due to sleeping almost always). The
watchdog task would naturally be very small and hence there's near zero
OOM risk for the watchdog task.

and yet another idea: if you make the ptrace task the leader of its own
process group, then IIRC you will get a death signal delivered to the
ptraced task if the parent dies prematurely. This should close the race
pretty well too.

	Ingo
