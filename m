Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319343AbSHQFKN>; Sat, 17 Aug 2002 01:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319346AbSHQFKN>; Sat, 17 Aug 2002 01:10:13 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:10968 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319343AbSHQFKM>; Sat, 17 Aug 2002 01:10:12 -0400
Date: Fri, 16 Aug 2002 22:12:04 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Benjamin LaHaise <bcrl@redhat.com>, Andrea Arcangeli <andrea@suse.de>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Pavel Machek <pavel@elf.ucw.cz>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: aio-core why not using SuS? [Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)]
Message-ID: <2159880183.1029535922@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.44.0208162134440.2497-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0208162134440.2497-100000@home.transmeta.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 1. We have a per-process UKVA (user-kernel virtual address space), 
> 
> What is your definition of a "process"?

Sorry ... per shared address space ... so multiple tasks sharing an
mm are 1 process (to me at least).
 
> And what is your definition of a "task"?
> 
> You seem to think that a task is one thread ("per task things like the
> kernel stack"), ie a 1:1 mapping with a "struct task_stuct".

yup, that's what I meant. task == 1 task_struct.
 
> But if you have such a mapping, then you _cannot_ make a per-task VM
> space, because many tasks will share the same VM. You cannot even do a
> per-cpu mapping change (and rewrite the VM on thread switch), since the VM
> is _shared_ across CPU's, and absolutely has to be in order to work with
> CPU's that do TLB fill in hardware (eg x86).

I don't see why the area above PAGE_OFFSET has to be global, or per
VM (by which I'm assuming you're meaning the set of pagetables per
process, aka group of tasks sharing an mm). 

Assume 3 level page tables and a 3/1 user/kernel split for the sake 
of argument. The bottom 3 PGD entries point to user PMD pages, 
and the top 1 to the kernel PMD page. At the moment, the PGDs are per
VM, but say we make them per task instead ... each task also gets
a copy of the standard kernel PMD (which never changes in the normal
course of things). In that PMD, we tweak the top couple of entries
to point to a per-task set of entries ... but the rest of the PMD
entries all point back to a shared set of PTE entries (well, except
ZONE_NORMAL is all large pages, so there ain't none for those).

Yes, I guess you'd have to TLB flush on the context switch with 
shared mm's which you don't have to do now, and you'd use an extra
couple of pages per task, but that's of phys ram, not vaddr space
which is what's precious. I think that all works, but it's kind of
late ;-)

It also has the advantage that you can wedge kernel text replication
for NUMA in the per-task PMD entries.

> The fact is, that in order to get the right TLB behaviour, the _only_
> thing you can do is to have a "per-MM UKVA". It's not per thread, and it's
> not per process. It's one per MM, which is _neither_.

OK, I was defining a process as the set of tasks sharing an MM. 
You seem to have a different definition - could you clarify for me?

> And this is where the problems come in. Since it is per-MM (and thus 
> shared across CPU's) updates need to be SMP-safe. And since it is per-MM, 
> it means that _any_ data structure that might be shared across different 
> MM's are really really dangerous to put in this thing (think virtual 
> caches on some hardware). 

OK ... I wasn't thinking virtual caches, I'll admit. But how many 
crazy 32 bit architectures do we have wanting 64Gb of RAM? ;-)
I *think* this is OK for ia32? 64 bit machines don't care about
all this nonsense.

> And since it is per-MM, it means that anything that there can be multiple 
> of per MM (which is pretty much _every_ data structure in the kernel) 
> cannot go at a fixed address or anything like that, but needs to be 
> allocated within the per-MM area dynamically.

right. I didn't mean to imply that it's trivial, or a panacea, 
but it's an interesting concept.

M.

