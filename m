Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319358AbSHQEOM>; Sat, 17 Aug 2002 00:14:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319359AbSHQEOM>; Sat, 17 Aug 2002 00:14:12 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:7887 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S319358AbSHQEOL>;
	Sat, 17 Aug 2002 00:14:11 -0400
Date: Fri, 16 Aug 2002 21:15:44 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <2156501334.1029532543@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.44.0208162056250.2305-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208162056250.2305-100000@home.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> At least some of those you don't have to kmap ... at least not in
>> the traditional sense. This sort of thing is a good application
>> for the per-process (or per-task) kernel virtual address area.
>> you just map in the stuff you need for your own task, instead
>> of having to share the global space with everybody.
> 
> Careful.
> 
> The VM space is shared _separately_ from other data structures, which
> means that you can _not_ user per-VM virtual address areas and expect them 
> to scale with load. And than some VM happens to have thousands of threads, 
> and you're dead.

OK ... not sure I understand the exact scenario you're evisioning,
but I can certainly see some problems in that area. There are two 
different ways we could do this (or a combination of both), and I'm 
not 100% sure if they solve the problems you mention, but it'd be
interesting to see what you think.

1. We have a per-process UKVA (user-kernel virtual address space), 
which is great for per-process stuff like mapping pagetables. Dave
McCracken made an implementation of this that carves off a fixed
amount of space between the top of the stack and PAGE_OFFSET.
That makes highpte more efficient by saving the kmaps most of the
time (or it should).

2. A per task UKVA, that'd probably have to come out of something
like the vmalloc space. I think Bill Irwin derived something like 
that from Dave's work, though I'm not sure it's complete & working 
as yet. Per task things like the kernel stack (minus the task_struct 
&  waitqueues) could go in here.

> Kernel stacks most certainly can't do this easily, since you'll just hit 
> the scalability problem somewhere else (ie many threads, same VM). 

Does (2) solve some of the thread scalability problems you're worried
about?
 
> And files, for example, can not only be many files for one VM, you can 
> have the reverse too, ie many VM's, one file table.

Could we fix this by having multiple tasks map the same page and share
it? Still much less vaddr space overhead than global?

Hopefully I haven't totally missed your point ... if so, hit me again,
but harder and slower ;-)

M.

