Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319337AbSHQEj7>; Sat, 17 Aug 2002 00:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319340AbSHQEj7>; Sat, 17 Aug 2002 00:39:59 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9220 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319337AbSHQEj6>; Sat, 17 Aug 2002 00:39:58 -0400
Date: Fri, 16 Aug 2002 21:46:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, <linux-kernel@vger.kernel.org>,
       <linux-aio@kvack.org>
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re:
 async-io API registration for 2.5.29)]
In-Reply-To: <2156501334.1029532543@[10.10.2.3]>
Message-ID: <Pine.LNX.4.44.0208162134440.2497-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 16 Aug 2002, Martin J. Bligh wrote:
> 
> 1. We have a per-process UKVA (user-kernel virtual address space), 

What is your definition of a "process"?

Linux doesn't really have any such thing. Linux threads share different 
amounts of stuff, and a traditional process just happens to share nothing. 
However, since they _can_ share more, it's damn hard to see what a 
"per-process" mapping means.

> 2. A per task UKVA, that'd probably have to come out of something
> like the vmalloc space. I think Bill Irwin derived something like 
> that from Dave's work, though I'm not sure it's complete & working 
> as yet. Per task things like the kernel stack (minus the task_struct 
> &  waitqueues) could go in here.

And what is your definition of a "task"?

You seem to think that a task is one thread ("per task things like the
kernel stack"), ie a 1:1 mapping with a "struct task_stuct".

But if you have such a mapping, then you _cannot_ make a per-task VM
space, because many tasks will share the same VM. You cannot even do a
per-cpu mapping change (and rewrite the VM on thread switch), since the VM
is _shared_ across CPU's, and absolutely has to be in order to work with
CPU's that do TLB fill in hardware (eg x86).

The fact is, that in order to get the right TLB behaviour, the _only_
thing you can do is to have a "per-MM UKVA". It's not per thread, and it's
not per process. It's one per MM, which is _neither_.

And this is where the problems come in. Since it is per-MM (and thus 
shared across CPU's) updates need to be SMP-safe. And since it is per-MM, 
it means that _any_ data structure that might be shared across different 
MM's are really really dangerous to put in this thing (think virtual 
caches on some hardware). 

And since it is per-MM, it means that anything that there can be multiple 
of per MM (which is pretty much _every_ data structure in the kernel) 
cannot go at a fixed address or anything like that, but needs to be 
allocated within the per-MM area dynamically.

I suspect that you are used to the traditional UNIX "process" notion,
where a "process" has exactly one file table, and has exactly one set of
signals, one set of semaphores etc. In that setup it can be quite
convenient to map these into the VM address space at magical addresses.

You may also be used to per-CPU page tables or software TLB fill
situations, where different CPU's can have different TLB contents. That
can be used to have per-thread mappings. Again, that doesn't work on Linux
due to page table sharing and hw TLB fills.

		Linus

