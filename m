Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313704AbSDPOyA>; Tue, 16 Apr 2002 10:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313705AbSDPOyA>; Tue, 16 Apr 2002 10:54:00 -0400
Received: from [195.223.140.120] ([195.223.140.120]:38981 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S313704AbSDPOx5>; Tue, 16 Apr 2002 10:53:57 -0400
Date: Tue, 16 Apr 2002 16:53:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Moritz Franosch <jfranosc@physik.tu-muenchen.de>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: IO performance problems in 2.4.19-pre5 when writing to DVD-RAM/ZIP/MO
Message-ID: <20020416165358.E29747@dualathlon.random>
In-Reply-To: <rxxadshj1rh.fsf@synapse.t30.physik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 05, 2002 at 11:04:18PM +0200, Moritz Franosch wrote:
> 
> 
> Hello Andrea,
> 
> 
> When releasing 2.4.19-pre5, Marcelo wrote
> 
>   This release has -aa writeout scheduling changes, which should
>   improve IO performance (and interactivity under heavy write loads).
> 
>   _Please_ test that extensively looking for any kind of problems
>   (performance, interactivity, etc).
> 
> I did test it because I noticed serious IO performance problems with
> earlier kernels.
> http://groups.google.com/groups?selm=linux.kernel.rxxn103tdbw.fsf%40synapse.t30.physik.tu-muenchen.de&output=gplain
> http://groups.google.com/groups?selm=linux.kernel.rxxsn83rd4c.fsf%40synapse.t30.physik.tu-muenchen.de&output=gplain
> 
> The problem is that writing to a DVD-RAM, ZIP or MO device almost
> totally blocks reading from a _different_ device. Here is some data.
> 
> nr bench read       write      2.4.18  2.4.19-rc5  expected factor
> 1  dd    30GB HDD   DVD-RAM    278     490         60       8.2
> 2  dd    120GB HDD  DVD-RAM    197     438         32       14
> 3  dd    30GB HDD   ZIP        158     239         60       4.0
> 4  dd    120GB HDD  ZIP        142     249         32       7.8
> 5  dd    30GB HDD   120GB HDD   87      89         60       1.5
> 6  dd    120GB HDD  30GB HDD    66      69         32       2.2
> 7  cp    30GB HDD   120GB HDD   97      77         60       1.3
> 8  cp    120GB HDD  30GB HDD    78      65         50       1.3
> 
> The columns 2.4.18 and 2.4.19-rc5 list execution times in seconds of
> the respective benchmark. The column "expected" lists the time I would
> have expected for the respective benchmark to complete with a
> "perfect" kernel. The "factor" is the factor 2.4.19-rc5 is slower than
> a perfect kernel would be.
> 
> The "dd" benchmark reads by 'dd' a file of size 1GB from the device
> listed under "read" and writes to /dev/null while _another_ 'dd'
> process writes to the device listed under "write" and reads from
> /dev/zero. Please see the source below. The "cp" benchmark simply
> copies a file of size 1GB from "read" to "write".
> 
> I have four IDE devices installed in that system:
> hda: 30 GB IDE HDD 5400 rpm
> hdb: 9.4 GB ATAPI DVD-RAM
> hdc: 120 GB IDE HDD 7200 rpm
> hdd: 100 MB ATAPI ZIP
> 
> As you can see, the "cp" benchmark (7,8) has considerably improved
> between 2.4.18 and 2.4.19-rc5 and it is only a factor of 1.3 away from
> perfect. Good work!
> 
> The performance problems can be seen in benchmarks 1-4. Writing to
> DVD-RAM while reading from the (fast) 130GB HDD (benchmark 2) almost
> totally blocks the read process. Under 2.4.19-rc5, it takes 14 times
> longer to 'dd' a 1GB file from HDD to /dev/null while writing to
> DVD-RAM than without any other IO. Without any other IO it only takes
> 32 seconds to read the 1GB file from the 130GB HDD. I would expect
> that writing simultaneously to _another_ device while reading a file
> would have no impact on the read speed. That's why I expected 32
> seconds for benchmark 2 to complete. Similarly, in benchmark 6,
> reading 1GB from the 120GB HDD should only take 32 seconds. But it
> takes more than twice that time when writing simultaneously to the
> 30GB HDD.
> 
> With 'vmstat 1' I have made the observation that 2.4.19-pre5 is a bit
> "fairer" that 2.4.18. Under 2.4.18, a writing process to DVD-RAM
> almost totally blocks reading from HDD whereas under 2.4.19-pre5 about
> 1-2 MB/s can be read simultaneously. So I was astonished that in my
> benchmarks 1-4, kernel 2.4.19-pre5 performed much worse than
> 2.4.18. The reason may be that the main throughput stems from the
> short moments where, for what reason whatsoever, read speed increases
> to 20-30 MB/s, as is normal. In benchmarks 3 and 4 the 'dd' process
> writing to the ZIP drive terminated with "no space left on device"
> before the reading 'dd' process completed. The reading 'dd' process
> then probably got a higher throughput (I checked that in X with
> xosview). That's probably the reason why benchmarks 3 and 4 (ZIP) took
> shorter than 1 and 2 (DVD-RAM).
> 
> I ran all benchmarks just after booting into runlevel 1 (single user
> mode) on a Suse 7.1 system. The system is a Athlon 700 MHz, KT133
> chipset, 256 MB RAM, 256 MB swap.
> 
> 
> The "dd" benchmark is:
> 
> #!/bin/bash
> 
> dd if=/dev/zero of=$1/tmp bs=1000000 &
> # a sleep is sometimes necessary for bad performance (to fill cache?)
> sleep 30 
> time dd if=$2 of=/dev/null bs=1000000
> 
> 
> Filesystems are:
> jfranosc@nomad:~ > mount
> /dev/hda3 on / type reiserfs (rw,noatime)
> proc on /proc type proc (rw)
> devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
> /dev/hda1 on /boot type ext2 (rw,noatime)
> /dev/hda6 on /home type ext2 (rw,noatime)
> /dev/hda7 on /lscratch type reiserfs (rw,noatime)
> /dev/hdc2 on /lscratch2 type reiserfs (rw,noatime)
> shmfs on /dev/shm type shm (rw)
> automount(pid341) on /net type autofs (rw,fd=5,pgrp=341,minproto=2,maxproto=4)
> automount(pid334) on /misc type autofs (rw,fd=5,pgrp=334,minproto=2,maxproto=4)
> /dev/hdd4 on /mzip type vfat (rw,noexec,nosuid,nodev,user=jfranosc)
> /dev/sr0 on /dvd type ext2 (rw,noexec,nosuid,nodev,user=jfranosc)
> 
> 
> Boot parameters in /etc/lilo.conf:
> append = "hdb=ide-scsi hdd=ide-floppy"  
> 
> 
> I report this performance problem because, first, there is room for
> improvements of IO performance up to factor 2 when using multiple
> disks, and, second, writing to DVD-RAM or ZIP almost makes the system
> unusable (because read performance drops to virtually zero).
> 
> If you have patches that you think should be tested, I'd like to try
> them.

The reason hd is faster is because new algorithm is much better than the
previous mainline code. Now the reason the DVDRAM hangs the machine
more, that's probably because more ram can be marked dirty with those
new changes (beneficial for some workload, but it stalls much more the
fast hd, if there's one very slow blkdev in the system). You can try
decrasing the percent of vm dirty in the system with:

	echo 2 500 0 0 500 3000 3 1 0 >/proc/sys/vm/bdflush

hope this helps,

Right fix is different but not suitable for 2.4.

Andrea
