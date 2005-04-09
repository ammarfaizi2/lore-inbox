Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVDIJ0X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVDIJ0X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 05:26:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVDIJ0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 05:26:23 -0400
Received: from av4-1-sn3.vrr.skanova.net ([81.228.9.111]:34973 "EHLO
	av4-1-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261317AbVDIJZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 05:25:43 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Soeren Sonnenburg <kernel@nn7.de>, Nix <nix@esperi.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pktcddvd -> immediate crash
References: <1112640251.5410.30.camel@localhost>
	<87fyy5jgt6.fsf@amaterasu.srvr.nix>
	<1112724384.5410.61.camel@localhost>
From: Peter Osterlund <petero2@telia.com>
Date: 09 Apr 2005 11:25:32 +0200
In-Reply-To: <1112724384.5410.61.camel@localhost>
Message-ID: <m3ekdkqp2r.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Soeren Sonnenburg <kernel@nn7.de> writes:

> On Tue, 2005-04-05 at 18:04 +0100, Nix wrote:
> > On 5 Apr 2005, Soeren Sonnenburg whispered secretively:
> > > I wonder whether anyone could use the pktcddvd device without killing
> > > random jobs (due to sudden out of memory or better memory leaks in
> > > pktcddvd) and finally a complete freeze of the machine ?
> > 
> > I'm using it without difficulty.
> > 
> > > To reproduce just create an udf filesystem on some dvdrw, mount it rw
> > > and copy some large file to the mount point.
> > 
> > Well, I copied a 502Mb file to a CD/RW yesterday as part of my
> > regular backups. No problems.
> >
> > I think we need more details (a .config would be nice, and preferably
> > a cat of /proc/slabinfo and a dmesg dump when the problem starts).
> 
> .config is attached (gzipped) and dmesg see below. unfortunately I
> cannot provide a cat of /proc/slabinfo after the problem started...

>From config.gz:

# Linux kernel version: 2.6.11

ONFIG_CDROM_PKTCDVD=y
CONFIG_CDROM_PKTCDVD_BUFFERS=32
# CONFIG_CDROM_PKTCDVD_WCACHE is not set

> however this machine has like 1.5G mem 2G swap and was doing no serious
> stuff, i.e. no high load no high memory requirements (I guess <500M)
...
> pktcdvd: inserted media is DVD+RW
> pktcdvd: write speed 2822kB/s
> pktcdvd: 4590208kB available on disc
> UDF-fs INFO UDF 0.9.8.1 (2004/29/09) Mounting volume 'LinuxUDF', timestamp 2005/03/27 18:49 (103c)
> rtc: lost some interrupts at 1024Hz.
> rtc: lost some interrupts at 1024Hz.
> rtc: lost some interrupts at 1024Hz.
> rtc: lost some interrupts at 1024Hz.
> oom-killer: gfp_mask=0xd0
> DMA per-cpu:
> cpu 0 hot: low 2, high 6, batch 1
> cpu 0 cold: low 0, high 2, batch 1
> Normal per-cpu:
> cpu 0 hot: low 32, high 96, batch 16
> cpu 0 cold: low 0, high 32, batch 16
> HighMem per-cpu:
> cpu 0 hot: low 32, high 96, batch 16
> cpu 0 cold: low 0, high 32, batch 16
> 
> Free pages:       28944kB (896kB HighMem)
> Active:46742 inactive:158822 dirty:666 writeback:114320 unstable:0 free:7236 slab:18648 mapped:44732 pagetables:845
> DMA free:3960kB min:584kB low:728kB high:876kB active:1996kB inactive:1104kB present:16384kB pages_scanned:3747 all_unreclaimable? yes
> lowmem_reserve[]: 0 880 1519
> Normal free:24088kB min:32180kB low:40224kB high:48268kB active:5780kB inactive:167540kB present:901120kB pages_scanned:29844 all_unreclaimable? no
> lowmem_reserve[]: 0 0 5119
> HighMem free:896kB min:512kB low:640kB high:768kB active:179192kB inactive:466644kB present:655344kB pages_scanned:0 all_unreclaimable? no
> lowmem_reserve[]: 0 0 0
> DMA: 0*4kB 1*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 1*2048kB 0*4096kB = 3960kB
> Normal: 0*4kB 1*8kB 1*16kB 0*32kB 0*64kB 0*128kB 2*256kB 0*512kB 1*1024kB 1*2048kB 5*4096kB = 24088kB
> HighMem: 62*4kB 7*8kB 5*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB 0*4096kB = 896kB
> Swap cache: add 35451, delete 35184, find 371/482, race 0+0
> Free swap  = 1838852kB
> Total swap = 1975976kB
> Out of Memory: Killed process 18330 (cat).

I don't know how the OOM killer is supposed to work, but I think it's
strange that it is triggered when there is 28MB RAM available and when
"writeback" is 114320, which means that a lot more memory will become
available by just waiting for the I/O to complete.

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
