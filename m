Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbUCPVWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 16:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261684AbUCPVWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 16:22:04 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:56331 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261707AbUCPVUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 16:20:12 -0500
Message-ID: <40577325.7090709@techsource.com>
Date: Tue, 16 Mar 2004 16:35:33 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Eric <eric@cisu.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler: Process priority fed back to parent?
References: <40571A62.8050204@techsource.com> <200403161006.02871.eric@cisu.net> <40572F58.6000201@techsource.com> <200403161323.26043.eric@cisu.net>
In-Reply-To: <200403161323.26043.eric@cisu.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Eric wrote:
> On Tuesday 16 March 2004 10:46 am, Timothy Miller wrote:
> 
>>Eric wrote:
>>
>>>	Sort of like what windows does with its prefetch stuff? Have a directory
>>>that contains info about the best way to run a particular program and its
>>>memory layouts/ disk accesses and patterns?
>>
>>I'm not familiar with that aspect of Windows, but... sure.  :)
> 
> 
> All i know is it does some sort of prefetch/caching of information to make 
> user processes load faster.

I'm not sure that this is quite the same.  Mac OS X has a special cache 
on disk of things that get loaded on boot.  It's arranged near the 
outer-most tracks of the disk, and it's stored linearly, so it can all 
be read as efficiently as possible.  This saves a lot of time.

This isn't what I'm talking about, however.  This caching idea is 
something that applies only to, for instance, loading system services, 
and that would all be in user space.


>>I appreciate the problems, and the cost may be greater than the benefit.
>>  But if the cache is just a file in the file system, then there are no
>>file-system dependencies.
> 
>  True. Read on for my thoughts about cost vs. benifit. The biggest costs would 
> only be incurred the first couple times a process is launched, at least the 
> cost of calculating what the heck the process is doing. After that it would 
> only be using already gathered info.

Yes and no.  We'd probably want to keep a running average or a life-time 
average.  We want to smooth out the bumps in program behavior over the 
long-term, and we don't want unfortunate first-impressions to cause 
grudges.  So, let's say that some program you install uses an inordinate 
amount of CPU for the first few days of its life because it's doing all 
sorts of initialization, but after that point, it behaves more sanely. 
We want the initial impression of the program's behavior to decay over 
time to better match its present behavior.

So, while the existing process scheduler estimates interactivity over 
the lifetime of a process, which could be mere seconds, the 
interactivity cache could estimate interactivity over a period of hours 
or more.


>>But in this case, it IS extra memory.  Would there be a process-launch
>>penalty?  Definately.  But it might be worth it for the user experience.
>>  Furthermore, the priority setting could be asynchronous, where the
>>initial priority is a guess, and isn't set until the priority info has
>>been fetched.
> 
> 
> Well on systems with alot of memory this kind of activity might be a good 
> trade off. I would gladly give up 1-10MB if it would guarantee faster/more 
> efficient process management. This prefetch activity could be turned on/off 
> from a /proc flag too just in case. It would have to be compiled in anyways 
> too, something like CONFIG_PREFETCH. Servers could turn off prefetch while 
> desktops could leave it on. This kind of thing would only improve 
> interactivity anyways, not affect long-running processes. 

Let's not call it "prefetch", because that would be confusing.  Let's 
call it "CONFIG_INTERACTIVITY_HISTORY".

The cache would need to know as little as a number which indicates 
interactivity history (or a short list), and either a filename or an 
inode number.

Indeed, would it be possible to store this number as metadata in the 
file's inode?  That would be filesystem-dependent, but it would also 
have zero cost.  This would only be a problem for read-only file 
systems, and those are common enough that it would warrant a separate 
cache.  Furthermore, in some cases, the cache could exist only for the 
uptime, so if you reboot, you lose all the history, but your compiles 
would only misbehave briefly before the system learned the behavior of cc1.

> 
> 
>>The thing is, if a program hasn't been loaded yet, then it has to be
>>fetched from disk, and one more fetch won't hurt.  Launching processes
>>involves LOTS of files being opened (shares libs, etc.).  Furthermore,
>>if the program has ALREADY been run once, the both the program AND its
>>priority descriptor are probably already in the VM disk cache.
> 
> 
> 	Your idea seems to deal mostly with process priority, what came to my mind 
> was something like a small struct or DB file describing the first 20-30 files 
> or something that that a program uses when it first starts up. That way the 
> file is already in disk cache or on its way when the program requests it. We 
> all know the slowest piece of a computer is the hard drive, so anything we 
> can do to predict, or even KNOW about its file usage we can get the 
> information ready before the process requests it. 

This is a wonderful idea, but it's completely separate.  This is 
something that could be done almost completely in user space.

A few more things about this... we'd need a new filesystem which 
maintained this cache in a section of the disk where it could keep 
things linear, and secondly, the anticipatory I/O scheduler does a 
wonderful job of reordering reads in a VERY efficient order.

> 	Would monitoring such activity be too much overhead? Maybe there could be 
> some sort of way to stop monitoring after the first few seconds or if the 
> program's needs are too random, the db file/info/daemon would simply contain 
> the something like "Dont monitor this proccess its too random!" or "We 
> already have all the info we need about it, just use what we have" That way 
> after the overhead is incurred 

Boot time would likely benefit most from this.  And even if it helped a 
lot over AS, it would simply come down to someone replacing the 
user-space mechanism that starts system services.

> 	Maybe the information could consist of the first 15-20 libraries (since which 
> libraries a program uses shouldn't change too much) and eventually when we 
> have run the program enough the prefetch file would know about some 
> configuration files and other things that the program always needs. That way 
> we can weed out random/temporary files and concentrate on what the program 
> needs consistently.

glibc is the biggest issue, but it's loaded into memory so early that I 
don't think we could help anything by caching it.

> 
> 	Please, let me know if my ideas are off track or not feasible, I don't have 
> an enormous knowledge about the kernel, but I am willing to learn/be 
> corrected. 
> 	I think I am getting off topic, but oh well. I think both ideas would 
> generally have some benifit.
> 	Can we even monitor open/read's this way? Is it too much overhead or require 
> breaking other syscalls?

For what I've been talking about, we'd want to hide it as much as 
possible, except from the scheduler and the daemon that maintains the 
history.

> 
> 
>>Lastly, the WRITING to the disk of priorities is done in a lazy manner.
>>  They could be fed via device node or /proc file to a daemon process
>>that consolidates it.  Periodically, it would dump to disk.  So,
>>launching and killing xterm 1000 times in one second would only result
>>in a single update if the daemon flushed once per second.  Also, the
>>'flush', would mostly involve writing to memory cache, letting the file
>>system decide when it actually hits the platter.
> 
> 	Hmm, i Like the daemon idea. 
> 
> 	The process launching a thousand times was exactly the worst case scenario I 
> was thinking of.
> 
> Quoting a later message:
> 
>>In FACT, that I think I may be on to something here... Hmmm.  So far, 
>>process schedulers have been trying to BOOST priority of interactive 
>>processes.  That's great.  But maybe an even BIGGER problem is that 
>>every time gcc (and cc1) is launched during a kernel compile, it's given 
>>too high of a priority, and by the time the priority is corrected, the 
>>compile has finished for that .c file.
> 
> 
> True. I believe both your ideas about priority management and my idea about 
> disk prefetching would greatly improve the performance hit in this scenario.

As I say, most of the time, this sort of caching is done only as a way 
to passify users who want the OS to boot faster.  On boot, so many 
things are being loaded at the same time that it can really be helpful. 
  But when loading a single app, caching won't help much.

Plus, there are other things that would speed up Linux booting MORE. 
For instance, if multiple independent system services were launched 
simultaneously, that combined with AS would result in a significant 
speedup in boot time.

> 
> I believe your idea about priority management would be much simpler to 
> implement and would have greater general applications, while my idea is 
> solely for desktop interactivity where program usage can be a bit chaotic at 
> times.

The first time gcc is started during a compile, it has to be loaded from 
disk, which is always going to be time-consuming.  But while that disk 
access is going on, other processes run, so interactivity isn't 
affected.  Caching of the executable would only save a few milliseconds. 
  Subsequent launches of gcc would all come from memory cache.  Only 
THEN does gcc start to affect interactivity, and this is all about 
process scheduling.


