Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263579AbSITVpb>; Fri, 20 Sep 2002 17:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263592AbSITVpb>; Fri, 20 Sep 2002 17:45:31 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:64384 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP
	id <S263579AbSITVpa>; Fri, 20 Sep 2002 17:45:30 -0400
Date: Fri, 20 Sep 2002 14:50:29 -0700
To: Ingo Molnar <mingo@elte.hu>
Cc: Ulrich Drepper <drepper@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Native POSIX Thread Library 0.1
Message-ID: <20020920215029.GB1527@gnuppy.monkey.org>
References: <20020920120606.GA4961@gnuppy.monkey.org> <Pine.LNX.4.44.0209201658240.5862-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209201658240.5862-100000@localhost.localdomain>
User-Agent: Mutt/1.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 20, 2002 at 06:20:10PM +0200, Ingo Molnar wrote:
> the user contexts for active but preempted threads are stored in the
> kernel stack. To support GC safepoints we need fast access to the current
> state of every not voluntarily preempted thread. This is admittedly easier
> if threads are abstraced in user-space [in which case the context is
> stored in user-space], but the question is, what is more important, an
> occasional pass of garbage collection, or the cost of doing IO?

The GC is generational and incremental, so it must deal with a lot of short
term objects that need to be collected. GC performance is a sore point in the
JVM (language runtimes in general) and having slow access to this is potentially
crippling for high load machines. The HotSpot/JVM is a bit overzealous with
safepoints which opens this area to optimization, but the problem exists now.

> until then it can be done via sending SIGSTOP/SIGCONT to the process PID
> from the garbage collection thread, which should stop all threads pretty
> efficiently in 2.5.35+ kernels. Then all threads that are not voluntarily
> sleeping can be fixed up via ptrace calls.

It's better to have an explict pthread_suspend_[thread,all]() function
since this kind of thing is becoming more and more common in thread
heavy language runtimes. The Posix thread spec was build without regard
to this and it's definitely become an important issues these days.

> and it can be further improved by tracking preempted user contexts in the
> scheduler and giving fast access to them via a syscall. (all voluntarily
> sleeping contexts can properly prepare their suspension state in
> userspace.) So it's possible to do it efficiently.
> 
> how frequently does the GC thread run?

Don't remember off hand, but it's like to be several times a second which is
often enough to be a problem especially on large systems with high load.

The JVM with incremental GC is being targetted for media oriented tasks
using the new NIO, 3d library, etc... slowness in safepoints would cripple it
for these tasks. It's a critical item and not easily address by the current
1:1 model.

bill

