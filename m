Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266064AbSLTW31>; Fri, 20 Dec 2002 17:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266100AbSLTW31>; Fri, 20 Dec 2002 17:29:27 -0500
Received: from warden3-p.diginsite.com ([208.147.64.186]:38614 "HELO
	warden3.diginsite.com") by vger.kernel.org with SMTP
	id <S266064AbSLTW3Z>; Fri, 20 Dec 2002 17:29:25 -0500
Date: Fri, 20 Dec 2002 14:25:28 -0800 (PST)
From: David Lang <dlang@diginsite.com>
To: "Joseph D. Wagner" <wagnerjd@prodigy.net>
cc: "'Torben Frey'" <kernel@mailsammler.de>, <linux-kernel@vger.kernel.org>
Subject: RE: Horrible drive performance under concurrent i/o jobs (dlh
 problem?)
In-Reply-To: <002f01c2a868$0ab3b5d0$3b41d03f@joe>
Message-ID: <Pine.LNX.4.44.0212201343170.10189-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Dec 2002, Joseph D. Wagner wrote:

> Date: Fri, 20 Dec 2002 14:40:30 -0600
> From: Joseph D. Wagner <wagnerjd@prodigy.net>
> To: 'Torben Frey' <kernel@mailsammler.de>, linux-kernel@vger.kernel.org
> Subject: RE: Horrible drive performance under concurrent i/o jobs (dlh
>     problem?)
>
> I hope I'm not entering this discussion too late to be of help.
>
> > We are running a 3ware Escalade 7850 Raid controller
> > with 7 IBM Deskstar GXP 180 disks in Raid 5 mode, so
> > it builds a 1.11TB disk.
>
> Raid 0 is better in terms of speed.

IIRC raid0 is striping with no redundancy, good for speed, very bad for
reliability. Raid 1 or 1+0 are the fastest modes to use that give
redundancy for the data, but they cost you half your disk space. In
addition everything I have seen and experianced about the 3ware cards
indicates that they are very fast for these modes, but much slower for
Raid 4 or 5

> > There's one partition on it, /dev/sda1, formatted
> > with ReiserFS format 3.6.
>
> Oh no! This is bad news, both in terms of speed and security.
>
> Lumping everything into one partition makes it impossible to protect against
> the SUID/GUID security vulnerability (security), and requires all reads and
> writes to be funneled through one partition (speed).

Here I have to disagree with you.

for default system installs that don't mount things noexec or readonly
there is little if any security difference between one large partition and
lots of small partitions. If you do have to time to use the mount flags to
protect your system then it is an advantage, unfortunantly in the real
world overworked sysadmins seldom have the time to do this (and if it's
not done at build time it becomes almost impossible to do later becouse
things get into places that would violate your mount restrictions)

As for speed, as long as you are on the same spindles there is no
definante speed gain for having lots of partitions and there is a
definante cost to having lots of partitions. If you think about it, if you
have seperate partitions you KNOW that you will have to seek across a
large portion of the disk to get from /root to /var where they may not be
seperated that much if they are one filesystem.

> At an absolute MINIMUM, your partitions should be divided into:
> /boot	032 MB
> /tmp	512 MB
> swap	1.5 - 3.0 times the amount of RAM,
> 	not to exceed a 2 GB per swap partition limit
> /root	  5 GB
> /var	 10 GB
> /usr	20% of what is leftover
> /home	50% of what is leftover,
> 	or at least 32 MB per user
> /	30% of what is leftover

The other problem with lots of partitions is that you almost always get
into a situation where one partition fills up and you have to go to a
significant amount of work to repartition things.

> The above numbers are my recommendations for your 1.1 TB Raid Array ONLY.
> Please don't flame me about how those numbers aren't right for everybody's
> systems.
>
> Additionally, in your case, I'd add a /data partition to store this huge
> amount of rapidly generated data you're talking about.  That way, if you
> should need to reformat, remount, whatever, the partition with the data, you
> won't have to take down or redo the whole system.
>
> > Or could it come from running an SMP kernel
> > although I have only one CPU in my board?
>
> This is a bad idea.  The SMP kernel includes a whole load of extra code
> which is totally unnecessary in a Uniprocessor environment.  All that extra
> code will do is slow down your system and take up extra memory.
>
> Switch to a Uniprocessor kernel, or see my next point.

Definantly. Also make sure you compile your own kernel optimizing for the
CPU that you have. this can be a 30% improvement with no other changes.

> > The Board is an MSI 6501 (K7D Master) with 1GB RAM
> > but only one processor.
>
> Upgrade to 4 GB of RAM (if possible) and add a second processor (if
> possible).
>
> From what you're telling me, you're going to need all the RAM you can get.

I am a little more shy about going beyond 1G of ram. things are getting
better, but there are still lots of things that can only exist in the
lowest Gig of ram and if you have lots of memory you run the possibility
of filling it up and having the machine lockup. If you need the ram add
it, but on my machines that don't _NEED_ that much ram I put in 1G and use
960M of it (himem disabled). on systems doing a lot of disk IO I do put
large amounts of cache on the scsi controllers.

> Further, SCSI really works better with two or more processors.  SCSI is
> designed to take advantage of multiple processors.  If you're not running
> multiple processors, you might as well be running IDE, IMHO.

Here I will disagree slightly. I see very significant advantages running
SCSI even on single CPU machines. it all depends on your workload.

> > Watching vmstat 1 shows me that "bo" drops quickly
> > down from rates in the 10 or 20 thousands to low rates
> > of about 2 or 3 thousands when the runs take so long.
>
> I'm willing to bet that your system is spending all of its time flushing the
> buffers.  When you're generating gigabytes of data, your buffers are going
> to need to be huge.
>
> I have no idea how to do this.

you definantly need to experiment with all the other types of journaling
filesystems. the performance tradeoffs of the different options are not
well understood (a combination of a lack of benchmarks of the different
types and the tendancy of benchmarks to show the best aspect of the
filesystem while missing the problem areas) and performance changes so
drasticly based on workloads and tuning parameters (journal size, flush
delays, etc)

David Lang
