Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263859AbTDDS3k (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 13:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263862AbTDDS3k (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 13:29:40 -0500
Received: from mail-3.tiscali.it ([195.130.225.149]:13698 "EHLO
	mail.tiscali.it") by vger.kernel.org with ESMTP id S263859AbTDDS3i (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 13:29:38 -0500
Date: Fri, 4 Apr 2003 20:40:59 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Jeffrey Baker <jwbaker@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: performance degradation from 2.4.17 to 2.4.21-pre5aa2
Message-ID: <20030404184059.GR16293@dualathlon.random>
References: <20030404181648.GA23281@heat>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404181648.GA23281@heat>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 04, 2003 at 10:16:48AM -0800, Jeffrey Baker wrote:
> Greets.  Thanks to rwhron, whose benchmarking skills are
> unrivalled, and due to profound unhappiness with the

agreed.

> performance of my database server, I decided to move from
> kernel 2.4.17 to 2.4.21-pre5aa2.  The aa kernel seems to
> have much better block I/O and far superior I/O scheduling
> fariness than 2.4.17.  So I decided to change kernels.
> 
> The machine in question is a dual pentium III 866 MHz,
> serverworks, 4GB main memory, aic7xxx storage on six disks,
> using software raid 0+1 with ext2 filesystems.  The workload
> is both postgresql and mysql databases, with data of
> approximately 80GB and about 60 simultaneous connections.
> The performance problems we were having involved simple
> queries just going off into space for up to tens of minutes.
> I hoped the reduced maximum read latency of the aa kernel
> (as seen in tiobench) would improve the situation.
> 
> Unfortunately for us, the server's performance is actually
> much worse under 2.4.21-pre5aa2 than it was under 2.4.17.
> While the block i/o rates seen in vmstat are generally
> higher, the CPU load is also much higher, hovering between 7
> and 9, normally with more than half the CPU time spent in
> the kernel (according to top).  Time to connect to the
> database, which involves a TCP connection and a fork and a
> lot of file opens, has gone from essentially instantaneous
> to varying between zero and thirty seconds.  Queries per
> second has gone from about 100 to about 80, and a particular
> ad hoc report that previously took fifteen minutes now takes
> over twice that time.
> 
> I guess the punch line is that the kernel can look good on
> paper but be a stinker in reality.  I've since moved the

well, those numbers are paper yes, but they're generated in real life
with some of the best and most reliable open benchmarks that I'm aware
of (peraphs with the exception of dbench, that at least when read alone
doesn't tell you the whole picture, but it's still good to benchmark the
writeback cache changes across otherwise unchanged kernels).

> machine back to 2.4.17.
> 
> I'm using highio and config_2gb.  Maybe there are some
> config tweaks I can make to improve the situation.  Is there
> any known reason why this type of workload would be run
> poorly under these newer kernels?
> 
> Here's a snippet of vmstat.  The i/o numbers are pathetic
> for a storage subsystem capable of over 80MB/s sequential:
> 
>    procs                      memory    swap          io     system         cpu
>  r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
>  4  0  0 230152  99236   9464 3441048  20   0   172  1772 1708  8790  53  43   4
>  7  0  0 230144 108812   9464 3441660   8   0    84  1008 1492  4879  43  57   0
>  5  0  0 230136  83584   9464 3442588  12   0   232  1240 1646  7277  54  44   2
>  4  0  0 230132  94296   9456 3442120   0   0   100   944 1572  7238  44  53   3
>  9  1  0 230116 114716   9436 3439060  12   0   188  1032 1642  7447  46  50   4
>  5  1  0 230116 100816   9444 3439520  20   0    76  1856 1394  3809  50  49   0
>  7  0  1 230096 105684   9404 3434376  12   0   352   936 1600  6138  49  50   1
>  9  1  1 230092  96788   9404 3434960   8   0    76   904 1537  4703  50  50   0
>  5  0  0 230092 103884   9404 3435288   0   0    48   464  958  3502  51  45   3
>  3  0  0 230092 105348   9404 3435968   0   0    72  1072 1451  6919  49  50   1
>  3  0  0 230092 116780   9412 3436452   0   0    20  1760 1520  4578  46  48   7
>  6  1  0 230088  95320   9412 3437028  48   0   204   752 1269  5630  50  48   1
>  4  1  0 230084  96496   9412 3437732  16   0   132  1064 1499  5966  50  50   1
>  7  0  0 230084 106360   9412 3438284   4   0    72   848 1429  7362  48  51   1

can you check if:

	echo 1000 >/proc/sys/vm/vm_mapped_ratio

helps? That can be enabled very safely, there's no downside except it'll
swap less.

Also make sure the 3400M of cache aren't all shared memory (not sure if
mysql provides a very large memory model), in such case you may be
bitten by the lowmem reservation, in such case you can boot with this
parameter passed to the kernel via grub or lilo:

	lower_zone_reserve=256,256

Then it will reserve less lowmem and it'll give you more ram to allocate
in shm (see your "free is now around 100M, it can go down to 20M or so
with such parameter, giving you 80M back that can make a difference
since you're only 200M into swap).

but it's not very recommended, since it can lead to normal zones
shortages in some conditions (like pagetables filling zone normal, or
anon memory and shm filling zone normal w/o swap). But you can give it a
spin (it won't be less safe than 2.4.17 anyways)

Also I would be extremely interested to see the:

	readprofile -m /boot/System.map-2.4.21-pre5aa2 | sort -nr +2
	readprofile -m /boot/System.map-2.4.21-pre5aa2 | sort -nr

output, to see where you're spending all such system time, if it's
swapping time walking pagetables or something else. the offender should
definitely showup in the readprofile.

Would also be interesting if you could try a vanilla 2.4.21-pre5 (or
pre6) and see if you get the same problem, many things have changed
since 2.4.17, I don't touch drivers usually.

thanks,

Andrea
