Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264142AbUDRGPh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Apr 2004 02:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264146AbUDRGPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Apr 2004 02:15:37 -0400
Received: from florence.buici.com ([206.124.142.26]:49792 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264142AbUDRGPb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Apr 2004 02:15:31 -0400
Date: Sat, 17 Apr 2004 23:15:29 -0700
From: Marc Singer <elf@buici.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Marc Singer <elf@buici.com>, wli@holomorphy.com,
       linux-kernel@vger.kernel.org
Subject: Re: vmscan.c heuristic adjustment for smaller systems
Message-ID: <20040418061529.GF19595@flea>
References: <20040417193855.GP743@holomorphy.com> <20040417212958.GA8722@flea> <20040417162125.3296430a.akpm@osdl.org> <20040417233037.GA15576@flea> <20040417165151.24b1fed5.akpm@osdl.org> <20040418015918.GU743@holomorphy.com> <20040417205338.71bed81b.akpm@osdl.org> <20040418053857.GC19595@flea> <20040417225243.0faa6fc4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040417225243.0faa6fc4.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 17, 2004 at 10:52:43PM -0700, Andrew Morton wrote:
> Well some more descriptions of what the system does after that copy-to-nfs
> would help.  Does it _ever_ come good, or is a reboot needed, etc?

As far as I can tell, it never gets good.  I run the same ls command
over and over.  Ten times.  Always the same behavior.  Sometimes it
gets even slower.  I can set swappiness to zero and it responds
normally, immediately.

> What does `vmstat 1' say during the copy, and during the ls?

I thought I sent a message about this.  I've found that the problem
*only* occurs when there is exactly one process running.  If I open a
second console (via telnet) then the slow-down behavior disappears.
If I logout of the console session and run the tests from the telnet
session then I *do* see the problem again.

> /proc/vmstats before and after the ls.

This one I can do.

BEFORE

    nr_dirty 0
    nr_writeback 0
    nr_unstable 0
    nr_page_table_pages 49
    nr_mapped 163
    nr_slab 255
    pgpgin 4
    pgpgout 0
    pswpin 0
    pswpout 0
    pgalloc_high 0
    pgalloc_normal 0
    pgalloc_dma 78568
    pgfree 79274
    pgactivate 8428
    pgdeactivate 8324
    pgfault 17112
    pgmajfault 1348
    pgrefill_high 0
    pgrefill_normal 0
    pgrefill_dma 543296
    pgsteal_high 0
    pgsteal_normal 0
    pgsteal_dma 60834
    pgscan_kswapd_high 0
    pgscan_kswapd_normal 0
    pgscan_kswapd_dma 189700
    pgscan_direct_high 0
    pgscan_direct_normal 0
    pgscan_direct_dma 31746
    pginodesteal 0
    slabs_scanned 1586
    kswapd_steal 30907
    kswapd_inodesteal 0
    pageoutrun 77994
    allocstall 82
    pgrotated 0

ls -l /proc runs slowly.

AFTER

    nr_dirty 0
    nr_writeback 0
    nr_unstable 0
    nr_page_table_pages 49
    nr_mapped 164
    nr_slab 225
    pgpgin 4
    pgpgout 0
    pswpin 0
    pswpout 0
    pgalloc_high 0
    pgalloc_normal 0
    pgalloc_dma 85378
    pgfree 86106
    pgactivate 11759
    pgdeactivate 11650
    pgfault 21293
    pgmajfault 2316
    pgrefill_high 0
    pgrefill_normal 0
    pgrefill_dma 616785
    pgsteal_high 0
    pgsteal_normal 0
    pgsteal_dma 67511
    pgscan_kswapd_high 0
    pgscan_kswapd_normal 0
    pgscan_kswapd_dma 200241
    pgscan_direct_high 0
    pgscan_direct_normal 0
    pgscan_direct_dma 31746
    pginodesteal 0
    slabs_scanned 1586
    kswapd_steal 37584
    kswapd_inodesteal 0
    pageoutrun 78405
    allocstall 82
    pgrotated 0

ls -l still slow.

Anything interesting? 

> Try doing the copy, then when it has finished do the old
> memset(malloc(24M)) and monitor the `vmstat 1' output while it runs,
> capture /proc/meminfo before and after.

Here's the meminfo version of the same test above.

BEFORE

MemTotal:        30256 kB
MemFree:          3312 kB
Buffers:             0 kB
Cached:          24512 kB
SwapCached:          0 kB
Active:            732 kB
Inactive:        24084 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        30256 kB
LowFree:          3312 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:            700 kB
Slab:             1024 kB
Committed_AS:      476 kB
PageTables:        196 kB
VmallocTotal:   434176 kB
VmallocUsed:     65924 kB
VmallocChunk:   368252 kB


ls -l runs slowly

AFTER

MemTotal:        30256 kB
MemFree:          3420 kB
Buffers:             0 kB
Cached:          24448 kB
SwapCached:          0 kB
Active:            772 kB
Inactive:        23984 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:        30256 kB
LowFree:          3420 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:            692 kB
Slab:              964 kB
Committed_AS:      476 kB
PageTables:        196 kB
VmallocTotal:   434176 kB
VmallocUsed:     65924 kB
VmallocChunk:   368252 kB

ls -l still runs slowly.

The copy w/vmstat involves two processes.  It doesn't exhibit the
problems.

> None of the problems you report are present on x86 as far as I can tell,
> so...

I don't expect you would.  Are you confident that this doesn't happen
on a 386 NFS root mounted system in single-user mode?  I don't have an
IA32 system where I can test this scenario.
