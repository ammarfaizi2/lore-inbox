Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129368AbQKDUDI>; Sat, 4 Nov 2000 15:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129283AbQKDUC6>; Sat, 4 Nov 2000 15:02:58 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:38646 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129093AbQKDUCs>; Sat, 4 Nov 2000 15:02:48 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: Jonathan George <Jonathan.George@trcinc.com>,
        "'matthew@mattshouse.com'" <matthew@mattshouse.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test10 Sluggish After Load
In-Reply-To: <Pine.LNX.4.05.10011041403590.4511-100000@humbolt.nl.linux.org>
From: Christoph Rohland <cr@sap.com>
Date: 04 Nov 2000 21:04:10 +0100
Message-ID: <m3bsvvh5c5.fsf@linux.local>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Capitol Reef)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

Rik van Riel <riel@conectiva.com.br> writes:
> Indeed, shared memory performance still sucks rocks.

No, it's not a performance problem. It is a hard lockup problem on
highmem machines.

I do see two problems here:
1) shm_swap_core does not handle the failure of prepare_higmem_swapout
   right and basically cannot do so. It gets called zone independant
   and should probably get called per zone. At least it has to react:
   If the lowmem zone is full it should not try to swap out highmem
   pages. I have a little workaround for that. Unfortunately this is
   not the whole thing:
2) Apparently the vm does not handle the case, where it has hardly any
   pages in the queues. My machine locks up with the following memory
   numbers:

SysRq: Show Memory
Mem-info:
Free pages:        2560kB (  1028kB HighMem)
( Active: 5, inactive_dirty: 27, inactive_clean: 27, free: 640 (638 1276 1914) )0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 1*512kB 0*1024kB 0*2048kB = 512kB)
7*4kB 14*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB = 1020kB)
3*4kB 1*8kB 1*16kB 1*32kB 1*64kB 1*128kB 1*256kB 1*512kB 0*1024kB 0*2048kB = 1028kB)
Swap cache: add 31231, delete 31218, find 21433/21531
Free swap:       1961028kB
2162688 pages of RAM
1867776 pages of HIGHMEM
102296 reserved pages
1204551 pages shared
13 pages swap cached
0 pages in page table cache
Buffer memory:      100kB
    CLEAN: 2 buffers, 8 kbyte, 2 used (last=2), 0 locked, 0 protected, 0 dirty
   LOCKED: 25 buffers, 100 kbyte, 25 used (last=25), 2 locked, 0
   protected, 0 dirty  

You see: you only have 5+27+27=59 pages under your control...

> I have not had time to fix this and I'm afraid I probably
> won't have time to fix this in the near future. I'm willing
> to give some advice to people who do want to take on the job
> of fixing SHM performance, though..

As you know I started this some time before, but nobody helped me in
integrating it into the rest of the VM :-( 

Unfortunately my time is very limited, but I probably would give it a
second try since I think shm swapping should work. But I think a clean
integration is a 2.5 issue.

Greetings
                Christoph

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
