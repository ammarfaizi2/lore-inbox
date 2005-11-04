Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932709AbVKDBBD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709AbVKDBBD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 20:01:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161048AbVKDBBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 20:01:00 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:22627 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S1161049AbVKDBAk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 20:00:40 -0500
To: mbligh@mbligh.org, torvalds@osdl.org
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Cc: akpm@osdl.org, arjan@infradead.org, arjanv@infradead.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com,
       lhms-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, mel@csn.ul.ie, mingo@elte.hu,
       nickpiggin@yahoo.com.au
Message-Id: <20051104010021.4180A184531@thermo.lanl.gov>
Date: Thu,  3 Nov 2005 18:00:21 -0700 (MST)
From: andy@thermo.lanl.gov (Andy Nelson)
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org





Linus writes:

>Just face it - people who want memory hotplug had better know that 
>beforehand (and let's be honest - in practice it's only going to work in 
>virtualized environments or in environments where you can insert the new 
>bank of memory and copy it over and remove the old one with hw support).
>
>Same as hugetlb.
>
>Nobody sane _cares_. Nobody sane is asking for these things. Only people 
>with special needs are asking for it, and they know their needs.


Hello, my name is Andy. I am insane. I am one of the CRAZY PEOPLE you wrote
about. I am the whisperer in people's minds, causing them to conspire 
against sanity everywhere and make lives as insane and crazy as mine is.
I love my work. I am an astrophysicist. I have lurked on various linux 
lists for years now, and this is my first time standing in front of all 
you people, hoping to make you bend your insane and crazy kernel developing
minds to listen to the rantings of my insane and crazy HPC mind.

I have done high performance computing in astrophysics for nearly two
decades now. It gives me a perspective that kernel developers usually
don't have, but sometimes need. For my part, I promise that I specifically
do *not* have the perspective of a kernel developer. I don't even speak C.

I don't really know what you folks do all day or night, and I actually 
don't much care except when it impacts my own work. I am fairly certain 
a lot of this hotplug/page defragmentation/page faulting/page zeroing
stuff that the sgi and ibm folk are currently getting rejected from
inclusion in the kernel impacts my work in very serious ways. You're
right, I do know my needs. They are not being met and the people with the
power to do anything about it call me insane and crazy and refuse to be
interested even in making improvement possible, even when it quite likely
helps them too.

Today I didn't hear a voice in my head that told me to shoot the pope, but
I did I hear one telling me to write a note telling you about my issues,
which apparently are in the 0.01% of insane crazies that should be
ignored, as are about 1/2 of the people responding on this thread. 
I'll tell you a bit about my issues and their context now that things
have gotten hot enough that even a devout lurker like me is posting. Some
of it might make sense. Other parts may be internally inconsistent if only
I knew enough. Still other parts may be useful to get people who don't
talk to each other in contact, and think about things in ways they haven't.


I run large hydrodynamic simulations using a variety of techniques
whose relevance is only tangential to the current flamefest. I'll let you
know the important details as they come in later. A lot of my statements
will be common to a large fraction of all hpc applications, and I imagine
to many large scale database applications as well though I'm guessing a
bit there.

I run the same codes on many kinds of systems from workstations up
to large supercomputing platforms. Mostly my experience has been
in shared memory systems, but recently I've been part of things that
will put me into distributed memory space as well.

What does it mean to use computers like I do? Maybe this is surprising
but my executables are very very small. Typically 1-2MB or less, with
only a bit more needed for various external libraries like FFTW or
the like. On the other hand, my memory requirements are huge. Typically
many GB, and some folks run simulations with many TB.  Picture a very
small and very fast flea repeatedly jumping around all over the skin of a
very large elephant, taking a bite at each jump and that is a crude idea
of what is happening.


This has bearing on the current discussion in the following ways, which
are not theoretical in any way. 


1) Some of these simulations frequently need to access data that is 
   located very far away in memory. That means that the bigger your
   pages are, the fewer TLB misses you get, the smaller the
   thrashing, and the faster your code runs. 

   One example: I have a particle hydrodynamics code that uses gravity.
   Molecular dynamics simulations have similar issues with long range
   forces too. Gravity is calculated by culling acceptable nodes and atoms
   out of a tree structure that can be many GB in size, or for bigger
   jobs, many TB. You have to traverse the entire tree for every particle
   (or closely packed small group). During this stage, almost every node
   examination (a simple compare and about 5 flops) requires at least one
   TLB miss and depending on how you've laid out your array, several TLB
   misses. Huge pages help this problem, big time. Fine with me if all I
   had was one single page. If I am stupid and get into swap territory, I
   deserve every bad thing that happens to me.

   Now you have a list of a few thousand nodes and atoms with their data
   spread sparsely over that entire multi-GB memory volume. Grab data
   (about 10 double precision numbers) for one node, do 40-50 flops with
   it, and repeat, L1 and TLB thrashing your way through the entire list.
   There are some tricks that work some times (preload an L1 sized array
   of node data and use it for an entire group of particles, then discard
   it for another preload if there is more data; dimension arrays in the
   right direction, so you get multiple loads from the same cache line
   etc) but such things don't always work or aren't always useful.

   I can easily imagine database apps doing things not too dissimilar to
   this. With my particular code, I have measured factors of several (\sim
   3-4) speedup with large pages compared to small. This is measured on 
   an Origin 3000, with 64k, 1M and 16MB pages were used. Not a factor 
   of several percent. A factor of several. I have also measured similar
   sorts of speedups on other types of machines. It is also not a factor
   related to NUMA. I can see other effects from that source and can
   distinguish between them.

   Another example: Take a code that discretizes space on a grid
   in 3d and does something to various variables to make them evolve.
   You've got 3d arrays many GB in size, and for various calculations 
   you have to sweep through them in each direction: x, y and z. Going 
   in the z direction means that you are leaping across huge slices of 
   memory every time you increment the grid zone by 1. In some codes 
   only a few calculations are needed per zone. For example you want 
   to take a derivative:

        deriv = (rho(i,j,k+1) - rho(i,j,k-1))/dz(k)

   (I speak fortran, so the last index is the slow one here).

   Again, every calculation strides through huge distances and gets you
   a TLB miss or several. Note for the unwary: it usually does not make
   sense to transpose the arrays so that the fast index is the one you
   work with. You don't have enough memory for one thing and you pay
   for the TLB overhead in the transpose anyway.

   In both examples, with large pages the chances of getting a TLB hit 
   are far far higher than with small pages. That means I want truly 
   huge pages. Assuming pages at all (various arches don't have them
   I think), a single one that covered my whole memory would be fine. 


   Other codes don't seem to benefit so much from large pages, or even
   benefit from small pages, though my experience is minimal with 
   such codes. Other folks run them on the same machines I do though:


2) The last paragraph above is important because of the way HPC
   works as an industry. We often don't just have a dedicated machine to
   run on, that gets booted once and one dedicated application runs on it
   till it dies or gets rebooted again. Many jobs run on the same machine.
   Some jobs run for weeks. Others run for a few hours over and over
   again. Some run massively parallel. Some run throughput.

   How is this situation handled? With a batch scheduler. You submit
   a job to run and ask for X cpus, Y memory and Z time. It goes and
   fits you in wherever it can. cpusets were helpful infrastructure
   in linux for this. 

   You may get some cpus on one side of the machine, some more
   on the other, and memory associated with still others. They
   do a pretty good job of allocating resources sanely, but there is
   only so much that it can do. 

   The important point here for page related discusssions is that
   someone, you don't know who, was running on those cpu's and memory
   before you. And doing Ghu Knows What with it. 

   This code could be running something that benefits from small pages, or
   it could be running with large pages. It could be dynamically
   allocating and freeing large or small blocks of memory or it could be
   allocating everything at the beginning and running statically
   thereafter. Different codes do different things. That means that the
   memory state could be totally fubar'ed before your job ever gets
   any time allocated to it.

>Nobody takes a random machine and says "ok, we'll now put our most 
>performance-critical database on this machine, and oh, btw, you can't 
>reboot it and tune for it beforehand". 

   Wanna bet?

   What I wrote above makes tuning the machine itself totally ineffective.
   What do you tune for? Tuning for one person's code makes someone else's
   slower. Tuning for the same code on one input makes another input run
   horribly. 
   
   You also can't be rebooting after every job. What about all the other
   ones that weren't done yet? You'd piss off everyone running there and
   it takes too long besides.

   What about a machine that is running multiple instances of some
   database, some bigger or smaller than others, or doing other kinds
   of work? Do you penalize the big ones or the small ones, this kind
   of work or that?


   You also can't establish zones that can't be changed on the fly
   as things on the system change. How do zones like that fit into
   numa? How do things work when suddenly you've got a job that wants
   the entire memory filled with large pages and you've only got 
   half your system set up for large pages? What if you tune the
   system that way and then let that job run. For some stupid reason user
   reason it dies 10 minutes after starting? Do you let the 30
   other jobs in the queue sit idle because they want a different
   page distribution?

   This way lies madness. Sysadmins just say no and set up the machine
   in as stably as they can, usually with something not too different
   that whatever manufacturer recommends as a default. For very good reasons.  

   I would bet the only kind of zone stuff that could even possibly
   work would be related to a cpu/memset zone arrangement. See below.


3) I have experimented quite a bit with the page merge infrastructure
   that exists on irix. I understand that similar large page and merge
   infrastructure exists on solaris, though I haven't run on such systems.
   I can get very good page distributions if I run immediately after
   reboot. I get progressively worse distributions if my job runs only
   a few days or weeks later. 

   My experience is that after some days or weeks of running have gone
   by, there is no possible way short of a reboot to get pages merged
   effectively back to any pristine state with the infrastructure that 
   exists there.
   
   Some improvement can be had however, with a bit of pain. What I
   would like to see is not a theoretical, general, all purpose 
   defragmentation and hotplug scheme, but one that can work effectively
   with the kinds of constraints that a batch scheduler imposes.
   I would even imagine that a more general scheduler type of situation
   could be effective it that scheduler was smart enough. God knows,
   the scheduler in linux has been rewritten often enough. What is
   one more time for this purpose too?

   You may claim that this sort of merge stuff requires excessive time
   for the OS. Nothing could matter to me less. I've got those cpu's
   full time for the next X days and if I want them to spend the first
   5 minutes or whatever of my run making the place comfortable, so that
   my job gets done three days earlier then I want to spend that time. 


3) The thing is that all of this memory management at this level is not
   the batch scheduler's job, its the OS's job. The thing that will make
   it work is that in the case of a reasonably intelligent batch scheduler
   (there are many), you are absolutely certain that nothing else is
   running on those cpus and that memory. Except whatever the kernel
   sprinkled in and didn't clean up afterwards. 

   So why can't the kernel clean up after itself? Why does the kernel need
   to keep anything in this memory anyway? I supposedly have a guarantee
   that it is mine, but it goes and immediately violates that guarantee
   long before I even get started. I want all that kernel stuff gone from
   my allocation and reset to a nice, sane pristine state.

   The thing that would make all of it work is good fragmentation and
   hotplug type stuff in the kernel. Push everything that the kernel did
   to my memory into the bitbucket and start over. There shouldn't be
   anything there that it needs to remember from before anyway. Perhaps
   this is what the defragmentation stuff is supposed to help with.
   Probably it has other uses that aren't on my agenda. Like pulling out
   bad ram sticks or whatever. Perhaps there are things that need to be
   remembered. Certainly being able to hotunplug those pieces would do it.
   Just do everything but unplug it from the board, and then do a hotplug
   to turn it back on. 


4) You seem to claim that issues I wrote about above are 'theoretical
   general cases'. They are not, at least not to any more people than the
   0.01% of people who regularly time their kernel builds as I saw someone
   doing some emails ago. Using that sort of argument as a reason not to
   incorporate this sort of infrastructure just about made me fall out of
   my chair, especially in the context of keeping the sane case sane.
   Since this thread has long since lost decency and meaning and descended
   into name calling, I suppose I'll pitch in with that too on two fronts: 
   
   1) I'd say someone making that sort of argument is doing some very serious 
   navel gazing. 

   2) Here's a cluebat: that ain't one of the sane cases you wrote about.



That said, it appears to me there are a variety of constituencies that
have some serious interest in this infrastructure.

1) HPC stuff

2) big database stuff.

3) people who are pushing hotplug for other reasons like the
   bad memory replacement stuff I saw discussed.  

4) Whatever else the hotplug folk want that I don't follow.


Seems to me that is a bit more than 0.01%.



>When you hear voices in your head that tell you to shoot the pope, do you 
>do what they say? Same thing goes for customers and managers. They are the 
>crazy voices in your head, and you need to set them right, not just 
>blindly do what they ask for.

I don't care if you do what I ask for, but I do start getting irate and
start writing long annoyed letters if I can't do what I need to do, and
find out that someone could do something about it but refuses.

That said, I'm not so hot any more so I'll just unplug now.


Andy Nelson



PS: I read these lists at an archive, so if responders want to rm me from
any cc's that is fine. I'll still read what I want or need to from there.



--
Andy Nelson                       Theoretical Astrophysics Division (T-6) 
andy dot nelson at lanl dot gov   Los Alamos National Laboratory
http://www.phys.lsu.edu/~andy     Los Alamos, NM 87545











