Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282640AbRLKTHv>; Tue, 11 Dec 2001 14:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282668AbRLKTHl>; Tue, 11 Dec 2001 14:07:41 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:40354 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S282640AbRLKTH1>; Tue, 11 Dec 2001 14:07:27 -0500
Date: Tue, 11 Dec 2001 19:07:41 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
To: Leigh Orf <orf@mailbag.com>
cc: linux-kernel@vger.kernel.org, Ken Brownfield <brownfld@irridia.com>,
        Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.4.16 memory badness (reproducible) 
In-Reply-To: <200112082142.fB8LgAb02089@orp.orf.cx>
Message-ID: <Pine.LNX.4.21.0112111850090.1164-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Dec 2001, Leigh Orf wrote:
> 
> So I don't know if it's a symptom or a cause, but modify_ldt seems to be
> triggering the problem. Not being a kernel hacker, I leave the analysis
> of this to those who are.
> 
> home[1029]:/home/orf% free
>              total       used       free     shared    buffers     cached
> Mem:       1029772     967096      62676          0     443988      98312
> -/+ buffers/cache:     424796     604976
> Swap:      2064344          0    2064344
> 
> modify_ldt(0x1, 0xbffff1fc, 0x10)       = -1 ENOMEM (Cannot allocate memory)

I believe this error comes, not from a (genuine or mistaken) shortage
of free memory, but from shortage or fragmentation of vmalloc's virtual
address space.  Does patch below (to 2.4.17-pre4-aa1 since I think that's
what you tried last; easily adaptible to other trees) doubling vmalloc's
address space (on your 1GB machine or larger) make any difference?
Perhaps there's a vmalloc leak and this will only delay the error.

Hugh

--- 1704aa1/arch/i386/kernel/setup.c	Tue Dec 11 15:22:53 2001
+++ linux/arch/i386/kernel/setup.c	Tue Dec 11 19:01:37 2001
@@ -835,7 +835,7 @@
 /*
  * 128MB for vmalloc and initrd
  */
-#define VMALLOC_RESERVE	(unsigned long)(128 << 20)
+#define VMALLOC_RESERVE	(unsigned long)(256 << 20)
 #define MAXMEM		(unsigned long)(-PAGE_OFFSET-VMALLOC_RESERVE)
 #ifdef CONFIG_HIGHMEM_EMULATION
 #define ORDER_DOWN(x)	((x >> (MAX_ORDER-1)) << (MAX_ORDER-1))

