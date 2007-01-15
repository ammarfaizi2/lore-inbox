Return-Path: <linux-kernel-owner+w=401wt.eu-S932250AbXAOL5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932250AbXAOL5x (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 06:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbXAOL5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 06:57:53 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:33610 "EHLO
	ausmtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932250AbXAOL5w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 06:57:52 -0500
Message-ID: <45AB6C25.1080804@linux.vnet.ibm.com>
Date: Mon, 15 Jan 2007 17:27:25 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Organization: IBM
User-Agent: Thunderbird 1.5.0.5 (X11/20060728)
MIME-Version: 1.0
To: Roy Huang <royhuang9@gmail.com>
CC: linux-kernel@vger.kernel.org, aubreylee@gmail.com, nickpiggin@yahoo.com.au,
       torvalds@osdl.org
Subject: Re: [PATCH] Provide an interface to limit total page cache.
References: <afe668f90701150139q26e41720lf06d6ee445a917b0@mail.gmail.com>
In-Reply-To: <afe668f90701150139q26e41720lf06d6ee445a917b0@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roy Huang wrote:
> A patch provide a interface to limit total page cache in
> /proc/sys/vm/pagecache_ratio. The default value is 90 percent. Any
> feedback is appreciated.

[snip]

I tried to run your patch on PPC64 SMP machine, unfortunately kswapd
crashes the kernel when the pagecache limit is exceeded!

->dd if=/dev/zero of=/tmp/foo bs=1M count=1200
cpu 0x0: Vector: 300 (Data Access) at [c0000000012d7ad0]
    pc: c0000000000976ac: .kswapd+0x3a4/0x4f0
    lr: c0000000000976ac: .kswapd+0x3a4/0x4f0
    sp: c0000000012d7d50
   msr: 8000000000009032
   dar: 0
 dsisr: 42000000
  current = 0xc00000000fed7040
  paca    = 0xc00000000063fb80
    pid   = 134, comm = kswapd0
------------[ cut here ]------------
enter ? for help
[c0000000012d7ee0] c000000000069150 .kthread+0x124/0x174
[c0000000012d7f90] c0000000000247b4 .kernel_thread+0x4c/0x68
0:mon>

Steps to recreate fail:

# sync
# echo 1 > /proc/sys/vm/drop_caches
MemTotal:      1014584 kB
MemFree:        905536 kB
Buffers:          3232 kB
Cached:          57628 kB
SwapCached:          0 kB
Active:          47664 kB
Inactive:        33160 kB
SwapTotal:     1526164 kB
SwapFree:      1526164 kB
Dirty:             108 kB
Writeback:           0 kB
AnonPages:       19976 kB
Mapped:          15084 kB
Slab:            19724 kB
SReclaimable:     8536 kB
SUnreclaim:      11188 kB
PageTables:        972 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:   2033456 kB
Committed_AS:    87884 kB
VmallocTotal: 8589934592 kB
VmallocUsed:      2440 kB
VmallocChunk: 8589932152 kB
HugePages_Total:     0
HugePages_Free:      0
HugePages_Rsvd:      0
Hugepagesize:    16384 kB

# echo 50 > /proc/sys/vm/pagecache_ratio
# dd if=/dev/zero of=/tmp/foo bs=1M count=1200

Basically fill pagecache with overlimit dirty file pages and check
if the reclaim happened and the limit was not exceeded.

--Vaidy



