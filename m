Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316440AbSETXoX>; Mon, 20 May 2002 19:44:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316445AbSETXoU>; Mon, 20 May 2002 19:44:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:65218 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316440AbSETXoQ>;
	Mon, 20 May 2002 19:44:16 -0400
Date: Mon, 20 May 2002 16:30:26 -0700 (PDT)
Message-Id: <20020520.163026.81812639.davem@redhat.com>
To: torvalds@transmeta.com
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.16
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0205200904461.23874-100000@home.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Mon, 20 May 2002 09:13:22 -0700 (PDT)

   See what I mean? You can share all the generic stuff, and only differ in
   the details.

I think it is easier to make tlb_{start,end}_vma do the cache/tlb
flushing, and then change tlb_flush_mmu() to look something like:

static inline void tlb_flush_mmu(mmu_gather_t *tlb, unsigned long start, unsigned long end)
{
        unsigned long nr;

-       flush_tlb_mm(tlb->mm);
+       tlb_flush_mm(tlb->mm);
        nr = tlb->nr;
        if (nr != ~0UL) {
                unsigned long i;
                tlb->nr = 0;
                for (i=0; i < nr; i++)
                        free_page_and_swap_cache(tlb->pages[i]);
        }
}

Architectures define tlb_flush_mm() as appropriate, on x86 it would
be just flush_tlb_mm(mm), on Sparc/PPC/etc. which uses the VMA
flushing it would just be a NOP.

This allows to share all of the infrastructure, with just a few
overrides for the arch specific bits.
