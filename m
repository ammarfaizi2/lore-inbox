Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261526AbUCPT0f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 14:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261505AbUCPT0f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 14:26:35 -0500
Received: from cardinal.mail.pas.earthlink.net ([207.217.121.226]:9972 "EHLO
	cardinal.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S261500AbUCPTYT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 14:24:19 -0500
From: Eric <eric@cisu.net>
To: Timothy Miller <miller@techsource.com>
Subject: Re: Scheduler: Process priority fed back to parent?
Date: Tue, 16 Mar 2004 13:23:26 -0600
User-Agent: KMail/1.6.1
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <40571A62.8050204@techsource.com> <200403161006.02871.eric@cisu.net> <40572F58.6000201@techsource.com>
In-Reply-To: <40572F58.6000201@techsource.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403161323.26043.eric@cisu.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 March 2004 10:46 am, Timothy Miller wrote:
> Eric wrote:
> > 	Sort of like what windows does with its prefetch stuff? Have a directory
> > that contains info about the best way to run a particular program and its
> > memory layouts/ disk accesses and patterns?
>
> I'm not familiar with that aspect of Windows, but... sure.  :)

All i know is it does some sort of prefetch/caching of information to make 
user processes load faster.
>
> >>This way, after gcc has run a few times, it'll be flagged as a CPU-bound
> >>process and every time it's run after that point, it is always run at an
> >>appropriate priority.  Similarly, the first time xmms is run, its
> >>interactivity estimate won't be right, but after it's determined to be
> >>interactive, then the next time the program is launched, it STARTS with
> >>an appropriate priority:  no ramp-up time.
> >
> > 	This sounds like a good idea, however im not too versed in all the
> > technical details. One thing I do see being a problem is do I really want
> > the kernel doing a disk-read/write everytime something forks or starts a
> > process? There would have to be some sort of cache.
>
> The kernel already does disk access to load a process... to load the
> executable.  The cache of priorities would be structured well on disk,
> and the data in that cache would be cached in RAM like any other file
> data is cached by the VM.
>
> The kernel needs a process context to access files, so either there
> would be an artificial one which always exists for this, or the priority
> cache would be accessed in the context of the process being launched.
> It would be preferable to open the cache file once at boot time, so the
> former is probably best.
>
> > 	Also, is it a good idea for the kernel to be writing/reading from disk,
> > basing some of its decisions on disk files. Does this add filesystem
> > specific complexity? As far as I know the kernel, never keeps any
> > configuration on an actual hard disk. Everything is in /proc...etc...
> > Something nags at me that its a bad idea to have the kernel read/write
> > things it needs to run on a hard disk.
>
> I appreciate the problems, and the cost may be greater than the benefit.
>   But if the cache is just a file in the file system, then there are no
> file-system dependencies.
 True. Read on for my thoughts about cost vs. benifit. The biggest costs would 
only be incurred the first couple times a process is launched, at least the 
cost of calculating what the heck the process is doing. After that it would 
only be using already gathered info.
> > 	So if its a bad idea to write to disk we would have to keep the prefetch
> > info in /proc, which will hog memory as more and more information is
> > gathered, or we will lose our valuable information in between reboots.
>
> Proc isn't a place.  It's a pseudo filesystem which requests information
> from kernel services.  The output you see from "cat /proc/..." is
> generated at the time you do the cat, which means it may not take ANY
> memory, because it's information that the kernel service already has to
> maintain anyway.  At least, I THINK it works this way.  :)

Interesting..... I learned something today. 

> But in this case, it IS extra memory.  Would there be a process-launch
> penalty?  Definately.  But it might be worth it for the user experience.
>   Furthermore, the priority setting could be asynchronous, where the
> initial priority is a guess, and isn't set until the priority info has
> been fetched.

Well on systems with alot of memory this kind of activity might be a good 
trade off. I would gladly give up 1-10MB if it would guarantee faster/more 
efficient process management. This prefetch activity could be turned on/off 
from a /proc flag too just in case. It would have to be compiled in anyways 
too, something like CONFIG_PREFETCH. Servers could turn off prefetch while 
desktops could leave it on. This kind of thing would only improve 
interactivity anyways, not affect long-running processes. 

> The thing is, if a program hasn't been loaded yet, then it has to be
> fetched from disk, and one more fetch won't hurt.  Launching processes
> involves LOTS of files being opened (shares libs, etc.).  Furthermore,
> if the program has ALREADY been run once, the both the program AND its
> priority descriptor are probably already in the VM disk cache.

	Your idea seems to deal mostly with process priority, what came to my mind 
was something like a small struct or DB file describing the first 20-30 files 
or something that that a program uses when it first starts up. That way the 
file is already in disk cache or on its way when the program requests it. We 
all know the slowest piece of a computer is the hard drive, so anything we 
can do to predict, or even KNOW about its file usage we can get the 
information ready before the process requests it. 
	Would monitoring such activity be too much overhead? Maybe there could be 
some sort of way to stop monitoring after the first few seconds or if the 
program's needs are too random, the db file/info/daemon would simply contain 
the something like "Dont monitor this proccess its too random!" or "We 
already have all the info we need about it, just use what we have" That way 
after the overhead is incurred 
	Maybe the information could consist of the first 15-20 libraries (since which 
libraries a program uses shouldn't change too much) and eventually when we 
have run the program enough the prefetch file would know about some 
configuration files and other things that the program always needs. That way 
we can weed out random/temporary files and concentrate on what the program 
needs consistently.

	Please, let me know if my ideas are off track or not feasible, I don't have 
an enormous knowledge about the kernel, but I am willing to learn/be 
corrected. 
	I think I am getting off topic, but oh well. I think both ideas would 
generally have some benifit.
	Can we even monitor open/read's this way? Is it too much overhead or require 
breaking other syscalls?

> Lastly, the WRITING to the disk of priorities is done in a lazy manner.
>   They could be fed via device node or /proc file to a daemon process
> that consolidates it.  Periodically, it would dump to disk.  So,
> launching and killing xterm 1000 times in one second would only result
> in a single update if the daemon flushed once per second.  Also, the
> 'flush', would mostly involve writing to memory cache, letting the file
> system decide when it actually hits the platter.
	Hmm, i Like the daemon idea. 

	The process launching a thousand times was exactly the worst case scenario I 
was thinking of.

Quoting a later message:
>In FACT, that I think I may be on to something here... Hmmm.  So far, 
>process schedulers have been trying to BOOST priority of interactive 
>processes.  That's great.  But maybe an even BIGGER problem is that 
>every time gcc (and cc1) is launched during a kernel compile, it's given 
>too high of a priority, and by the time the priority is corrected, the 
>compile has finished for that .c file.

True. I believe both your ideas about priority management and my idea about 
disk prefetching would greatly improve the performance hit in this scenario.

I believe your idea about priority management would be much simpler to 
implement and would have greater general applications, while my idea is 
solely for desktop interactivity where program usage can be a bit chaotic at 
times.

I've been monitoring LKML for a time and cannot remember any specific 
discussions about this issue, and i tried a quick google, archive search, but 
most of the information i recovered wasn't related.

See what you can dig up and keep us posted :)

-------------------------
Eric Bambach
Eric at cisu dot net
-------------------------
