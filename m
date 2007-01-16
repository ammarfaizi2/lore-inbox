Return-Path: <linux-kernel-owner+w=401wt.eu-S1751421AbXAPCkz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751421AbXAPCkz (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:40:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbXAPCkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:40:55 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:18925 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbXAPCkx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:40:53 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PO+nNmHgLyzPsdUWj97p2pKlFpTyRoieJtE+qFFK92PqYAgl2AdNAwDar7yCsa+mwqza7N+jBGKCTap49xxXEDrwrELuuMKda2/Uq12wc7pduueG0wU+ydgigshoBzNBE5jZW59QZLvnlMOPlEoCwXrfuPGh5lTq9LGLN1uXwvA=
Message-ID: <afe668f90701151840tc8d7608sadccb3e39017d1ed@mail.gmail.com>
Date: Tue, 16 Jan 2007 10:40:52 +0800
From: "Roy Huang" <royhuang9@gmail.com>
To: "Vaidyanathan Srinivasan" <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH] Provide an interface to limit total page cache.
Cc: linux-kernel@vger.kernel.org, aubreylee@gmail.com, nickpiggin@yahoo.com.au,
       torvalds@osdl.org
In-Reply-To: <45AB6C25.1080804@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <afe668f90701150139q26e41720lf06d6ee445a917b0@mail.gmail.com>
	 <45AB6C25.1080804@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The possible cause is a bug in kswapd thread, or shrink_all_memory
cannot be called in kswapd thread.

On 1/15/07, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com> wrote:
>
> Roy Huang wrote:
> > A patch provide a interface to limit total page cache in
> > /proc/sys/vm/pagecache_ratio. The default value is 90 percent. Any
> > feedback is appreciated.
>
> [snip]
>
> I tried to run your patch on PPC64 SMP machine, unfortunately kswapd
> crashes the kernel when the pagecache limit is exceeded!
>
> ->dd if=/dev/zero of=/tmp/foo bs=1M count=1200
> cpu 0x0: Vector: 300 (Data Access) at [c0000000012d7ad0]
>     pc: c0000000000976ac: .kswapd+0x3a4/0x4f0
>     lr: c0000000000976ac: .kswapd+0x3a4/0x4f0
>     sp: c0000000012d7d50
>    msr: 8000000000009032
>    dar: 0
>  dsisr: 42000000
>   current = 0xc00000000fed7040
>   paca    = 0xc00000000063fb80
>     pid   = 134, comm = kswapd0
> ------------[ cut here ]------------
> enter ? for help
> [c0000000012d7ee0] c000000000069150 .kthread+0x124/0x174
> [c0000000012d7f90] c0000000000247b4 .kernel_thread+0x4c/0x68
> 0:mon>
>
> Steps to recreate fail:
>
> # sync
> # echo 1 > /proc/sys/vm/drop_caches
> MemTotal:      1014584 kB
> MemFree:        905536 kB
> Buffers:          3232 kB
> Cached:          57628 kB
> SwapCached:          0 kB
> Active:          47664 kB
> Inactive:        33160 kB
> SwapTotal:     1526164 kB
> SwapFree:      1526164 kB
> Dirty:             108 kB
> Writeback:           0 kB
> AnonPages:       19976 kB
> Mapped:          15084 kB
> Slab:            19724 kB
> SReclaimable:     8536 kB
> SUnreclaim:      11188 kB
> PageTables:        972 kB
> NFS_Unstable:        0 kB
> Bounce:              0 kB
> CommitLimit:   2033456 kB
> Committed_AS:    87884 kB
> VmallocTotal: 8589934592 kB
> VmallocUsed:      2440 kB
> VmallocChunk: 8589932152 kB
> HugePages_Total:     0
> HugePages_Free:      0
> HugePages_Rsvd:      0
> Hugepagesize:    16384 kB
>
> # echo 50 > /proc/sys/vm/pagecache_ratio
> # dd if=/dev/zero of=/tmp/foo bs=1M count=1200
>
> Basically fill pagecache with overlimit dirty file pages and check
> if the reclaim happened and the limit was not exceeded.
>
> --Vaidy
>
>
>
>
