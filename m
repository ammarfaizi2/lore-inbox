Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262805AbSITQHc>; Fri, 20 Sep 2002 12:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262838AbSITQHc>; Fri, 20 Sep 2002 12:07:32 -0400
Received: from mx1.elte.hu ([157.181.1.137]:24786 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S262805AbSITQHa>;
	Fri, 20 Sep 2002 12:07:30 -0400
Date: Fri, 20 Sep 2002 18:20:10 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Bill Huey <billh@gnuppy.monkey.org>
Cc: Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
In-Reply-To: <20020920120606.GA4961@gnuppy.monkey.org>
Message-ID: <Pine.LNX.4.44.0209201658240.5862-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Sep 2002, Bill Huey wrote:

> The JVM needs a couple of pretty critical things that are a bit off from
> the normal Posix threading standard. One of them is very fast thread
> suspension for both individual threads and the all threads accept the
> currently running one...

the user contexts for active but preempted threads are stored in the
kernel stack. To support GC safepoints we need fast access to the current
state of every not voluntarily preempted thread. This is admittedly easier
if threads are abstraced in user-space [in which case the context is
stored in user-space], but the question is, what is more important, an
occasional pass of garbage collection, or the cost of doing IO?

until then it can be done via sending SIGSTOP/SIGCONT to the process PID
from the garbage collection thread, which should stop all threads pretty
efficiently in 2.5.35+ kernels. Then all threads that are not voluntarily
sleeping can be fixed up via ptrace calls.

and it can be further improved by tracking preempted user contexts in the
scheduler and giving fast access to them via a syscall. (all voluntarily
sleeping contexts can properly prepare their suspension state in
userspace.) So it's possible to do it efficiently.

how frequently does the GC thread run?

	Ingo

