Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263321AbTBSRzh>; Wed, 19 Feb 2003 12:55:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263326AbTBSRzh>; Wed, 19 Feb 2003 12:55:37 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:44161 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S263321AbTBSRzf>;
	Wed, 19 Feb 2003 12:55:35 -0500
Date: Wed, 19 Feb 2003 19:05:24 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dejan Muhamedagic <dejan@hello-penguin.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: vm issues on sap app server
Message-ID: <20030219180523.GK14633@x30.suse.de>
References: <20030219171432.A6059@smp.colors.kwc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030219171432.A6059@smp.colors.kwc>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2003 at 05:14:32PM +0100, Dejan Muhamedagic wrote:
> Hello everybody,
> 
> We're running here a couple of 4-way intel boxes each with
> 6GB of memory and a SCSI RAID.  The sole purpose is to run
> SAP applications (SAP app servers).  Basically, it's 30-40
> processes accepting connections from ~150 SAP users and
> making queries/updates to a DB server.  These processes are
> long lived and may swallow quite a bit of memory.  The
> standard estimate is ~30MB per user.
> 
> Currently, one box is running 2.4.20aa1 kernel and the other
> 2.4.20 with rmap15d and a bunch of NFS patches applied.
> We're not entirely happy with either VM though the SAP
> statistics show that both machines have acceptable response
> times.
> 
> Both servers swap constantly, but the 2.4.20aa1 at a 10-fold
> higher rate.  OTOH, there should be enough memory for
> everything.  It seems like both VMs have preference for
> cache.  Is it possible to reduce the amount of memory used
> for cache?

yes:

	echo 1000 >/proc/sys/vm/vm_mapped_ratio

this controls how hard the vm will try to shrink the cache before
starting swapping/unmapping activities.

> 
> The worst situation is when there's a high io load.  For
> example, a file transfer over the Gb i/f (~40MBps) makes
> almost all SAP processes stuck in the D state for some time
> even making some SAP jobs fail due to high timeouts.  It
> looks like the VM wants to fill the cache and starts to swap
> more at the same time.  So we have to do big file transfers

you can try if this mitigate the "stalling" effect of the file
transfer:

	echo 5 >/proc/sys/vm/bdflush

also elvtune might be useful here if the above doesn't help at all.

You can also consider to use 2.4.21pre4aa3, it has some more advanced
elevator logic, the one in 2.4.20aa1 wasn't as accurate and it might
generate more stalls than what was necessary.

> when there's no SAP activity.  The machine also suffers
> badly during backup.
> 
> Finally, there's a third SAP app server, an RS6000 running
> AIX with the same amount of memory, which seems to be more
> stable under various loads.
> 
> Anybody with advice on how to get Linux behave better?

2.4.21pre4aa3 has also extreme scalability optimizations that generates
three digits percent improvements on some hardware, however those won't
help latency directly. These optimizations will also change partly when
the vm starts swapping, and it will defer the "swap" point somehow, this
new behaviour (besides the greatly improved scalability) is also
beneficial to very shm-userspace-cache intensive apps. You can revert to
the non-scalable behaviour (but possibly more desiderable on small
desktop/laptops) by using echo 1 >/proc/sys/vm/vm_anon_lru. You should
also try 'echo 1 >/proc/sys/vm/vm_anon_lru' if you see the VM isn't
swapping well enough and that it shrinks too much cache after upgrading
to 2.4.21pre4aa3.

Unfortunately the tuning largely depends on the workload and the
hardware, so it is very hard to make it autotuning at best
automatically.

> I will paste here excerpts from vmstat and sysstat
> (sar), which seemed to be representative, as well as other
> relevant data.

Thanks for the interesting feedback!

Andrea
