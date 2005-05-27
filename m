Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261925AbVE0HTJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261925AbVE0HTJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 03:19:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261921AbVE0HTI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 03:19:08 -0400
Received: from mx2.elte.hu ([157.181.151.9]:24036 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261940AbVE0HS0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 03:18:26 -0400
Date: Fri, 27 May 2005 09:18:00 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andi Kleen <ak@muc.de>, Sven-Thorsten Dietrich <sdietrich@mvista.com>,
       dwalker@mvista.com, bhuey@lnxw.com, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RT patch acceptance
Message-ID: <20050527071800.GA1624@elte.hu>
References: <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com> <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu> <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net> <20050526193230.GY86087@muc.de> <1117138270.1583.44.camel@sdietrich-xp.vilm.net> <20050526202747.GB86087@muc.de> <4296ADE9.50805@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4296ADE9.50805@yahoo.com.au>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Nick Piggin <nickpiggin@yahoo.com.au> wrote:

> Presumably your RT tasks are going to want to do some kind of *real* 
> work somewhere along the line - so how is that work provided 
> guarantees?

there are several layers to this. The primary guarantee we can offer is
to execute userspace code within N usecs. Most code that needs hard
guarantees is quite simple and uses orthogonal mechanisms.

The secondary guarantee we will eventually offer is that as long as a
process uses orthogonal resources, other tasks will not delay it. This
is not quite true right now but it's possible to achive it
realistically. If an RT and a non-RT task shares e.g. the same file
descriptor - or the RT tasks does not use mlockall() to exclude VM, then
we cannot guarantee latencies. There might be more subtle 'sharing', but
as long as the primary APIs are fundamentally O(1) [and they are], the
worst-case overhead will be deterministic. What controls is the
worst-case latency of the kernel facility an RT task makes use of. Under
normal PREEMPT what controls latencies is the _system-wide_ worst-case
latency - which is a very different thing.

but it's not like hard-RT tasks live in a vacuum: they already have to 
be aware of the latencies caused by themselves, and they have to be 
consciously aware of what kernel facilities they use. If you do hard-RT
you have to be very aware of every line of code your task may execute.

> So in that sense, if you do hard RT in the Linux kernel, it surely is 
> always going to be some subset of operations, dependant on exact 
> locking implementation, other tasks running and resource usage, right?

yes. The goal is that latencies will fundamentally depend on what 
facilities (and sharing) the RT task makes use of - instead of depending 
on what _other_ tasks do in the system.

> Tasklist lock might be a good example off the top of my head - so you 
> may be able to send a signal to another process with deterministic 
> latency, however that latency might look something like: x + nrproc*y

yes, signals are not O(1).

Fundamentally, the Linux kernel constantly moves towards separation of 
unrelated functionality, for scalability reasons. So the moment there's 
some unexpected sharing, we try to get to rid of it not primarily due to 
latencies, but due to performance. (and vice versa - one reason why it's 
not hard to get latency patches into the kernel) E.g. the tasklist lock 
might be convered to RCU one day. The idea is that a 'perfectly
scalable' Linux kernel also has perfect latencies - the two goals meet.

> It appears to me (uneducated bystander, remember) that a nanokernel 
> running a small hard-rt kernel and Linux together might be "better" 
> for people that want real realtime.

If your application model can tolerate a total separation of OSs then 
that's sure a viable way. If you want to do everything under one 
instance of Linux, and want to separate out some well-controlled RT 
functionality, then PREEMPT_RT is good for you.

Note that if you can tolerate separation of OSs (i.e. no sharing or 
well-controlled sharing) then you can do that under PREEMPT_RT too, here 
and today: e.g. run all the non-RT tasks in an UML or QEMU instance.
(separation of UML needs more work but it's fundamentally ok.) Or you
can use PREEMPT_RT as the nanokernel [although this sure is overkill]
and put all the RT functionality into a virtual machine. So instead of a
hard choice forced upon you, virtualization becomes an option. Soft-RT
applications can morph towards hard-RT conditions and vice versa.

So whether it's good enough will have to be seen - maybe nanokernels
will win in the end. As long as PREEMPT_RT does not impose any undue
design burden on the stock kernel (and i believe it does not) it's a
win-win situation: latency improvements will drive scalability,
scalability improvements will drive latencies, and the code can be
easily removed if it becomes unused.

	Ingo
