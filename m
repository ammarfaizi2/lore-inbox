Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316774AbSEUXOO>; Tue, 21 May 2002 19:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316775AbSEUXON>; Tue, 21 May 2002 19:14:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42252 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316774AbSEUXOM>; Tue, 21 May 2002 19:14:12 -0400
Date: Tue, 21 May 2002 16:13:37 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Make 2.5.17 TLB even more friendlier
In-Reply-To: <15594.53956.275011.958879@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.33.0205211609210.15094-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 May 2002, Paul Mackerras wrote:
> I'm thinking now that I would be better off doing the batching by
> storing a list of virtual addresses needing flushing in the
> mmu_gather_t, instead of relying on getting at the special bits in the
> PTEs at some time after the tlb_remove_tlb_entry call.

Well, you can combine that with something like

	static inline void tlb_remove_tlb_entry(tlb, pte, address)
	{
		if (pte_tlb_hash(pte)) {
			if (tlb->start_addr == NOSTART)
				tlb->start_addr = address;
			tlb->end_addr = address+PAGE_SIZE;
		}
	}

and then have the tlb_end_vma() do something like

	/* No pages mapped? */
	if (tlb->start_addr == NOADDR)
		return;
	pte_remove_range(vma, tlb->start_addr, tlb->end_addr)
	tlb->start_addr = NOADDR;

which will bunch them up on a vma granularity (if there is any reason to 
do that), while still retaining the optimization that if a VMA was mostly 
unmapped you wouldn't need to do a lot of hash table searching because of 
the start/end thing.

		Linus

