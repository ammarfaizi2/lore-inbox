Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbUBZMxI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 07:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbUBZMxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 07:53:08 -0500
Received: from fw.osdl.org ([65.172.181.6]:57311 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262765AbUBZMxC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 07:53:02 -0500
Date: Thu, 26 Feb 2004 04:53:31 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Cc: linux-kernel@vger.kernel.org, gluk@php4.ru, anton@megashop.ru,
       mfedyk@matchmail.com
Subject: Re: 2.6.1 IO lockup on SMP systems
Message-Id: <20040226045331.060c07d3.akpm@osdl.org>
In-Reply-To: <200402261519.35506.rathamahata@php4.ru>
References: <200401311940.28078.rathamahata@php4.ru>
	<20040223142626.48938d7c.akpm@osdl.org>
	<200402241454.08210.rathamahata@php4.ru>
	<200402261519.35506.rathamahata@php4.ru>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Sergey S. Kostyliov" <rathamahata@php4.ru> wrote:
>
> Yet another lockup has just occurred. I could be wrong but from the
> /proc/meminfo content it doesn't looks like memory leak (neither kernel
> nor userspace), doesn't it?

I think it's a kernel leak.

> Thu Feb 26 05:00:15 MSK 2004
> MemTotal:      2073868 kB
> MemFree:          2528 kB
> Buffers:          2180 kB
> Cached:          34216 kB
> SwapCached:     643808 kB
> Active:         999316 kB
> Inactive:        12088 kB
> HighTotal:     1179648 kB
> HighFree:          576 kB
> LowTotal:       894220 kB
> LowFree:          1952 kB
> SwapTotal:     3583968 kB
> SwapFree:      2559796 kB
> Dirty:               0 kB
> Writeback:        3052 kB
> Mapped:        1001208 kB
> Slab:            23932 kB
> Committed_AS:  1979784 kB
> PageTables:       4840 kB
> VmallocTotal:   114680 kB
> VmallocUsed:      7448 kB
> VmallocChunk:   107232 kB

A gig of mapped memory, most of it in swapcache.  That's probably all
highmem.  Only a gig of memory on the page LRU.  Where is the rest?  Lost.

Almost no pagecache at all, slab is small.

> 3) sysrq-T:
> ===========
> http://sysadminday.org.ru/2.6.3-lockup/20040226/sysrq-T

hm, you have 34 instances of crond running.   How odd.

> 3) `vmstat 30':
> ===============
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
>  0 19 1255096   1952   1996  19920  426 1763   505  1778 1068   172  0  1  0 99
>  0 24 1260156   1944   2028  19816  374 1650   463  1670 1067   165  0  1  0 99

Again, all your memory has vanished.

I'd say that we've leaked everything in lowmem and everyone is stuck trying
to reclaim some lowmem memory.  Not sure why the oom-killer didn't do
anything.  I haven't tested it in a year - maybe it broke.

So.  What are you using which is different from everyone else?  DAC960 I
see.  What about firewall setups, NIC drivers, RAID/MD/etc?  Anything in
there which isn't a mainstream thing?

