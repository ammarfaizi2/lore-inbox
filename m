Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318113AbSFTEHo>; Thu, 20 Jun 2002 00:07:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318114AbSFTEHn>; Thu, 20 Jun 2002 00:07:43 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5996 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S318113AbSFTEHl>; Thu, 20 Jun 2002 00:07:41 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Cort Dougan <cort@fsmlabs.com>, Benjamin LaHaise <bcrl@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Robert Love <rml@tech9.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: latest linus-2.5 BK broken
References: <Pine.LNX.4.44.0206191018510.2053-100000@home.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Jun 2002 21:57:35 -0600
In-Reply-To: <Pine.LNX.4.44.0206191018510.2053-100000@home.transmeta.com>
Message-ID: <m1d6umtxe8.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 19 Jun 2002, Eric W. Biederman wrote:
> >
> > 10-20 years or someone finds a good way to implement a single system
> > image on linux clusters.  They are already into the 1000s of nodes,
> > and dual processors per node category.  And as things continue they
> > might even grow bigger.
> 
> Oh, clusters are a separate issue. I'm absolutely 100% conviced that you
> don't want to have a "single kernel" for a cluster, you want to run
> independent kernels with good communication infrastructure between them
> (ie global filesystem, and try to make the networking look uniform).
> 
> Trying to have a single kernel for thousands of nodes is just crazy. Even
> if the system were ccNuma and _could_ do it in theory.

I totally agree, mostly I was playing devils advocate.  The model
actually in my head is when you have multiple kernels but they talk
well enough that the applications have to care in areas where it
doesn't make a performance difference (There's got to be one of those).

> The NuMA work can probably take single-kernel to maybe 64+ nodes, before
> people just start turning stark raving mad. There's no way you'll have
> single-kernel for thousands of CPU's, and still stay sane and claim any
> reasonable performance under generic loads.
> 
> So don't confuse the issue with clusters like that. The "set_affinity()"
> call simply doesn't have anything to do with them. If you want to move
> processes between nodes on such a cluster, you'll probably need user-level
> help, the kernel is unlikely to do it for you.

Agreed.  

The compute cluster problem is an interesting one.  The big items
I see on the todo list are:

- Scalable fast distributed file system (Lustre looks like a
   possibility)
- Sub application level checkpointing.

Services like a schedulers, already exist.  

Basically the job of a cluster scheduler gets much easier, and the
scheduler more powerful once it gets the ability to suspend jobs.
Checkpointing buys three things.  The ability to preempt jobs, the
ability to migrate processes, and the ability to recover from failed
nodes, (assuming the failed hardware didn't corrupt your jobs
checkpoint).

Once solutions to the cluster problems become well understood I
wouldn't be surprised if some of the supporting services started to
live in the kernel like nfsd.  Parts of the distributed filesystem
certainly will.

I suspect process checkpointing and restoring will evolve something
something like pthread support.  With some code in user space, and
some generic helpers in the kernel as clean pieces of the job can be
broken off.  The challenge is only how to save/restore interprocess
communications. Things like moving a tcp connection from one node to
another are interesting problems.  

But also I suspect most of the hard problems that we need kernel help
with can have uses independent of checkpointing.  Already we have web
server farms that spread connections to a single ip across nodes.

Eric
