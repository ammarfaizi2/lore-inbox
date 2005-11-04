Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750888AbVKDVEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750888AbVKDVEl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 16:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750891AbVKDVEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 16:04:41 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:10672 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S1750887AbVKDVEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 16:04:41 -0500
To: andy@thermo.lanl.gov, mingo@elte.hu
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Cc: akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mbligh@mbligh.org, mel@csn.ul.ie,
       nickpiggin@yahoo.com.au, torvalds@osdl.org
In-Reply-To: <20051104201248.GA14201@elte.hu>
Message-Id: <20051104210418.BC56F184739@thermo.lanl.gov>
Date: Fri,  4 Nov 2005 14:04:18 -0700 (MST)
From: andy@thermo.lanl.gov (Andy Nelson)
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

>can you think of any reason why the boot-time-configured hugetlb zone 
>would be inadequate for your needs?

I am not enough of a kernel level person or sysadmin to know for certain,
but I have still big worries about consecutive jobs that run on the
same resources, but want extremely different page behavior. If what
you are suggesting can cause all previous history on those resources
to be forgotten and then reset to whatever it is that I want when I
start my run, then yes. It would be fine for me. In some sense, this is
perhaps what I was asking for in my original message when I was talking
about using batch schedulers, cpusets and friends to encapsulate 
regions of resources, that could be reset to nice states at user
specified intervals, like when the batch scheduler releases one job
and another job starts.


The issues that I can still think of that hpc people will need are 
(some points here are clearly related to each other, but anyway).


  1) how do zones play with numa? Does setting up resource management this 
     way mean that various kernel things that help me access my memory
     (hellifino what I'm talking about here--things like tables and lists
     of pages that I own and how to access them etc I suppose--whatever
     it is that kernels don't get rid of when someone else's job ends and
     before mine starts) actually get allocated in some other zone half
     way across the machine? This is going to kill me on latency grounds.
     Can it be set up so that this reserved special kernel zone is somewhere
     close by? If it is bigger than the next guy to get my resources wants, 
     can it be deleted and reset once my job is finished, so his job can run?
     This is what I would hope for and expect that something like 
     cpuset/memsets would help to do.

  2) How do zones play with merging small pages into big pages, splitting
     big pages into small, or deleting whatever page environment was there
     in favor of a reset of those resources to some initial state? If
     someone runs a small page job right after my big page job, will
     they get big pages? If I run a big page job right after their small
     page job, will I get small pages? 
     
     In each case, will it simply say 'no can do' and die? If this setup
     just means that some jobs can't be run or can't be run after
     something else, it will not fly.

  3) How does any sort of fall back scheme work? If I can't have all of my
     big pages, maybe I'll settle for some small ones and some big ones.
     Can I have them? If I can't have them and die instead, zones like
     this will not fly. 

     Points 2 and 3 have mostly to do with the question Does the system
     performance degrade over time for different constituencies of users
     or can it stay up stably, serving everyone equally and well for a
     long time? 

  4) How does any of this stuff play with interactive management? It is
     not going to fly if sysadmins have to get involved on a
     daily/regular basis, or even at much more than a cursory level of 
     turning something on once when the machine is purchased.

  5) How does any of this stuff play with me having to rewrite my code to
     use nonstandard language features? If I can't run using standard 
     fortran, standard C and maybe for some folks standard C++ or Java,
     it won't fly. 

  6) what about text vs data pages. I'm talking here about executable
     code vs whatever that code operates on. Do they get to have different
     sized pages? Do they get allocated from sensible places on the
     machine, as in reasonably separate from each other but not in some
     far away zone over the rainbow?  

  7) If OS's/HW ever get decent support for lots and lots of page sizes 
     (like mips and sparc now) rather than a couple , will the 
     infrastructure be able to give me whichever size I ask for, or will 
     I only get to choose between a couple, even if perhaps settable at 
     boot time? Extensibility like this will be a requirement long term 
     of course.

  8) What if I want 32 cpus and 64GB of memory on a machine, get it,
     finish using it, and then the next jobs in line request say 8 cpus
     and 16GB of memory, 4cpus and 16GB of memory, 20 cpus and 4GB
     of memory? Will the zone system be able to handle such dynamically
     changing things?


What I would need to see is that these sorts of issues can be handled
gracefully by the OS, perhaps with the help of some user land or
priveleged userland hints that would come from things like the batch 
scheduler or an env variable to set my prefered page size or other 
things about memory policy.


Thanks,

Andy

PS to Linus: I have secured access to an dual cpu dual core amd box. 
I have to talk to someone who is not here today to see about turning
on large pages. We'll see how that goes probably some time next week. 
If it is possible, you'll see some benchmarks then.

