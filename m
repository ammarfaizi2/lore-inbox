Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271250AbUJVMJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271250AbUJVMJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 08:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271252AbUJVMJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 08:09:08 -0400
Received: from hell.sks3.muni.cz ([147.251.210.30]:39308 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S271250AbUJVMI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 08:08:58 -0400
Date: Fri, 22 Oct 2004 14:08:22 +0200
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 - e1000 - page allocation failed
Message-ID: <20041022120821.GA12619@mail.muni.cz>
References: <20041021221622.GA11607@mail.muni.cz> <20041021225825.GA10844@electric-eye.fr.zoreil.com> <20041022025158.7737182c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041022025158.7737182c.akpm@osdl.org>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 02:51:58AM -0700, Andrew Morton wrote:
> I'd be interested in knowing if this fixes it - I don't expect it will,
> because that's a zero-order allocation failure.  He's really out of memory.
> 
> The e1000 driver has a default rx ring size of 256 which seems a bit nutty:
> a back-to-back GFP_ATOMIC allocation of 256 skbs could easily exhaust the
> page allocator pools.
> 
> Probably this machine needs to increase /proc/sys/vm/min_free_kbytes.

It did not help.

However I tweak network stack a little bit:
/sbin/sysctl -w net/core/rmem_max=8388608
/sbin/sysctl -w net/core/wmem_max=8388608
/sbin/sysctl -w net/core/rmem_default=1048576
/sbin/sysctl -w net/core/wmem_default=1048576
/sbin/sysctl -w net/ipv4/tcp_window_scaling=1
/sbin/sysctl -w net/ipv4/tcp_rmem="4096 1048576 8388608"
/sbin/sysctl -w net/ipv4/tcp_wmem="4096 1048576 8388608"
/sbin/ifconfig eth0 txqueuelen 1000

this is /proc/meminfo:
cat /proc/meminfo 
MemTotal:      1035116 kB
MemFree:        447028 kB
Buffers:             0 kB
Cached:         522444 kB
SwapCached:          0 kB
Active:          98092 kB
Inactive:       460408 kB
HighTotal:      131008 kB
HighFree:          308 kB
LowTotal:       904108 kB
LowFree:        446720 kB
SwapTotal:     4008208 kB
SwapFree:      4008204 kB
Dirty:               0 kB
Writeback:           0 kB
Mapped:          45804 kB
Slab:            21112 kB
Committed_AS:   128148 kB
PageTables:       1528 kB
VmallocTotal:   114680 kB
VmallocUsed:      2964 kB
VmallocChunk:   111700 kB

Note that there is 400MB of _free_ memory.

This is from slabinfo (hope that it is relevant info..)

size-131072(DMA)       0      0 131072    1   32 : tunables
8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables
8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables
8    4    0 : slabdata      0      0      0
size-65536             1      1  65536    1   16 : tunables
8    4    0 : slabdata      1      1      0
size-32768(DMA)        0      0  32768    1    8 : tunables
8    4    0 : slabdata      0      0      0
size-32768            16     16  32768    1    8 : tunables
8    4    0 : slabdata     16     16      0
size-16384(DMA)        0      0  16384    1    4 : tunables
8    4    0 : slabdata      0      0      0
size-16384             2      2  16384    1    4 : tunables
8    4    0 : slabdata      2      2      0
size-8192(DMA)         0      0   8192    1    2 : tunables
8    4    0 : slabdata      0      0      0
size-8192            120    120   8192    1    2 : tunables
8    4    0 : slabdata    120    120      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12
8 : slabdata      0      0      0
size-4096            300    300   4096    1    1 : tunables   24   12
8 : slabdata    300    300      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12
8 : slabdata      0      0      0
size-2048            106    106   2048    2    1 : tunables   24   12
8 : slabdata     53     53      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27
8 : slabdata      0      0      0
size-1024           1052   1052   1024    4    1 : tunables   54   27
8 : slabdata    263    263      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27
8 : slabdata      0      0      0
size-512             294   1240    512    8    1 : tunables   54   27
8 : slabdata    155    155      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60
8 : slabdata      0      0      0
size-256             211   1170    256   15    1 : tunables  120   60
8 : slabdata     78     78      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60
8 : slabdata      0      0      0
size-128            1688   2728    128   31    1 : tunables  120   60
8 : slabdata     88     88      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60
8 : slabdata      0      0      0
size-64              610   2318     64   61    1 : tunables  120   60
8 : slabdata     38     38      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60
8 : slabdata      0      0      0
size-32             1381   4641     32  119    1 : tunables  120   60
8 : slabdata     39     39     15
kmem_cache           165    165    256   15    1 : tunables  120   60
8 : slabdata     11     11      0

-- 
Luká¹ Hejtmánek
