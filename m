Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279927AbRKSQ5e>; Mon, 19 Nov 2001 11:57:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280032AbRKSQ5Y>; Mon, 19 Nov 2001 11:57:24 -0500
Received: from [208.129.208.52] ([208.129.208.52]:13320 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S279927AbRKSQ5Q>;
	Mon, 19 Nov 2001 11:57:16 -0500
Date: Mon, 19 Nov 2001 09:06:40 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Andi Kleen <ak@suse.de>
cc: Mike Kravetz <kravetz@us.ibm.com>, <lse-tech@lists.sourceforge.net>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: Real Time Runqueue
In-Reply-To: <20011119173022.A19740@wotan.suse.de>
Message-ID: <Pine.LNX.4.40.0111190901360.1572-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Nov 2001, Andi Kleen wrote:

> On Fri, Nov 16, 2001 at 04:32:24PM -0800, Mike Kravetz wrote:
> > The reason I ask is that we went through the pains of a separate
> > realtime RQ in our MQ scheduler.  And yes, it does hurt the common
> > case, not to mention the extra/complex code paths.  I was hoping
> > that someone in the know could enlighten us as to how RT semantics
> > apply to SMP systems.  If the semantics I suggest above are required,
> > then it implies support must be added to any possible future
> > scheduler implementations.
>
> It seems a lot of applications/APIs do not care about global RT semantics,
> but about RT semantics for groups of threads or processes (e.g. java
> or ada applications). Linux currently simulates this only for root
> and with a global runqueue. I don't think it makes too much sense to have
> an global rt queue on a multi processor system, but there should be some
> way to define "scheduling groups" where rt semantics are followed inside.
> Such a scheduling group could be a clone flag or default to CLONE_VM for
> example for compatibility.  A scheduling group would also make it possible
> to support simple rt semantics for thread groups as non root.  Then one
> could run a rt queue per scheduling group, and simulate global rt run queue
> or per cpu rt run queue as needed by appropiate setup.

What i'm currently trying to achieve is to have two kind of rt tasks,
local and global ones.
Local rt tasks are stored inside the local CPU run queue and compete only
with the local tasks.
Global rt tasks have a global runqueue that is fast-checked w/out
held locks inside the schedule() :

    if (!list_empty(&runqueue_head(RT_QID)))
        goto rt_queue_select;
rt_queue_select_back:

So a local rt tasks can _not_ preempt a task on another CPU while a global
one yes.




- Davide


