Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290794AbSBSJF6>; Tue, 19 Feb 2002 04:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290779AbSBSJFr>; Tue, 19 Feb 2002 04:05:47 -0500
Received: from gans.physik3.uni-rostock.de ([139.30.44.2]:38660 "EHLO
	gans.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id <S290807AbSBSJFX>; Tue, 19 Feb 2002 04:05:23 -0500
Date: Tue, 19 Feb 2002 10:05:17 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Tom Holroyd <tomh@po.crl.go.jp>
cc: kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Unknown HZ value! (1908) Assume 1024.
In-Reply-To: <Pine.LNX.4.44.0202191000030.26361-100000@holly.crl.go.jp>
Message-ID: <Pine.LNX.4.33.0202190951130.13518-100000@gans.physik3.uni-rostock.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2002, Tom Holroyd wrote:
> > > After about 50 days of uptime on 2.4.17 on an Alpha, I started getting
> > > this message from ps, et al.
> > To make sure, can you post /proc/uptime and /proc/stat output? Also, is
> > this uniprocessor or SMP?
> 
> It's not userspace, this is a kernel problem (proc_misc.c):
> 
> /proc/uptime:
> 4919324.13 1615.50
> 
> /proc/stat:
> cpu  2427984276 2540057284 67737892 4296620451
> cpu0 2427984276 2540057284 67737892 4296620451
> ...
> 
> ps --version:
> Unknown HZ value! (1897) Assume 1024.
> procps version 2.0.2
> 
> All the tools that give me that message are in procps.  I tried it
> with procps 2.0.7 and it still happens.  The message is coming from
> sysinfo.c in the libproc part of that package.  What it does is, it
> takes the "cpu" line from /proc/stat, and adds up all the numbers, and
> then divides by the value in /proc/uptime.  So it gets:
> 
> 	2427984276 + 2540057284 + 67737892 + 4296620451 = 9332399903
> 	9332399903 / 4919324.13 = 1897 (wrong)
> 
> Apparently, that 4th value in /proc/stat is bogus.  If I do:
> 
> 	2427984276 + 2540057284 + 67737892 = 5035779452
> 	5035779452 / 4919324.13 = 1023.67 (close enough)
> 
> So what is the 4th value in /proc/stat (procps calls it "other", while
> the first 3 are "user", "nice", and "sys")?  According to
> linux/fs/proc/proc_misc.c, it is:
> 
> 	jif * smp_num_cpus - (user + nice + system)
> 
> formatted with a %lu (the others are just %u).  smp_num_cpus is 1.
> Things are declared this way:
> 
>         unsigned long jif = jiffies;
>         unsigned int sum = 0, user = 0, nice = 0, system = 0;
> 
> So, the problem is that user + nice + system overflows (I'm compiling
> with gcc 3.0, BTW).
> 
> Thanks for the clue; now, how to fix it?
> 

Good analysis! 
I'd suggest changing the declarations in kstat_read_proc to

        unsigned long jif = jiffies, user = 0, nice = 0, system = 0;
        unsigned int sum = 0;

so that ticks that are lost due to overflow count as "other".

For increased symmetry we might also consider to change the "other" value 
to 32 bit as well like user, nice, and system. This, however, would also
require userspace changes.
Extending all values to  unsigned long  would cause problems on 32 bit 
platforms. While they might be solved as in the 64 bit jiffies patch
(http://www.lib.uaa.alaska.edu/linux-kernel/archive/2001-Week-47/0736.html)
this looks like pure overkill to me.

Tim

