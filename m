Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263134AbUCPQmC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 11:42:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262006AbUCPQla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 11:41:30 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:40709 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263992AbUCPQbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 11:31:00 -0500
Message-ID: <40572F58.6000201@techsource.com>
Date: Tue, 16 Mar 2004 11:46:16 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Eric <eric@cisu.net>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Scheduler: Process priority fed back to parent?
References: <40571A62.8050204@techsource.com> <200403161006.02871.eric@cisu.net>
In-Reply-To: <200403161006.02871.eric@cisu.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Eric wrote:

> 
> 
> 	Sort of like what windows does with its prefetch stuff? Have a directory that 
> contains info about the best way to run a particular program and its memory 
> layouts/ disk accesses and patterns? 

I'm not familiar with that aspect of Windows, but... sure.  :)

> 
>>This way, after gcc has run a few times, it'll be flagged as a CPU-bound
>>process and every time it's run after that point, it is always run at an
>>appropriate priority.  Similarly, the first time xmms is run, its
>>interactivity estimate won't be right, but after it's determined to be
>>interactive, then the next time the program is launched, it STARTS with
>>an appropriate priority:  no ramp-up time.
> 
> 
> 	This sounds like a good idea, however im not too versed in all the technical 
> details. One thing I do see being a problem is do I really want the kernel 
> doing a disk-read/write everytime something forks or starts a process? There 
> would have to be some sort of cache. 

The kernel already does disk access to load a process... to load the 
executable.  The cache of priorities would be structured well on disk, 
and the data in that cache would be cached in RAM like any other file 
data is cached by the VM.

The kernel needs a process context to access files, so either there 
would be an artificial one which always exists for this, or the priority 
cache would be accessed in the context of the process being launched. 
It would be preferable to open the cache file once at boot time, so the 
former is probably best.

> 	Also, is it a good idea for the kernel to be writing/reading from disk, 
> basing some of its decisions on disk files. Does this add filesystem specific 
> complexity? As far as I know the kernel, never keeps any configuration on an 
> actual hard disk. Everything is in /proc...etc... Something nags at me that 
> its a bad idea to have the kernel read/write things it needs to run on a hard 
> disk. 

I appreciate the problems, and the cost may be greater than the benefit. 
  But if the cache is just a file in the file system, then there are no 
file-system dependencies.

> 	So if its a bad idea to write to disk we would have to keep the prefetch info 
> in /proc, which will hog memory as more and more information is gathered, or 
> we will lose our valuable information in between reboots. 

Proc isn't a place.  It's a pseudo filesystem which requests information 
from kernel services.  The output you see from "cat /proc/..." is 
generated at the time you do the cat, which means it may not take ANY 
memory, because it's information that the kernel service already has to 
maintain anyway.  At least, I THINK it works this way.  :)

But in this case, it IS extra memory.  Would there be a process-launch 
penalty?  Definately.  But it might be worth it for the user experience. 
  Furthermore, the priority setting could be asynchronous, where the 
initial priority is a guess, and isn't set until the priority info has 
been fetched.

The thing is, if a program hasn't been loaded yet, then it has to be 
fetched from disk, and one more fetch won't hurt.  Launching processes 
involves LOTS of files being opened (shares libs, etc.).  Furthermore, 
if the program has ALREADY been run once, the both the program AND its 
priority descriptor are probably already in the VM disk cache.

Lastly, the WRITING to the disk of priorities is done in a lazy manner. 
  They could be fed via device node or /proc file to a daemon process 
that consolidates it.  Periodically, it would dump to disk.  So, 
launching and killing xterm 1000 times in one second would only result 
in a single update if the daemon flushed once per second.  Also, the 
'flush', would mostly involve writing to memory cache, letting the file 
system decide when it actually hits the platter.

