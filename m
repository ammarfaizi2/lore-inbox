Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315630AbSETBZZ>; Sun, 19 May 2002 21:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315631AbSETBZY>; Sun, 19 May 2002 21:25:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:57093 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315630AbSETBZW>; Sun, 19 May 2002 21:25:22 -0400
Date: Sun, 19 May 2002 18:25:47 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.16
In-Reply-To: <15592.19630.175916.291284@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44.0205191820100.20628-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 May 2002, Paul Mackerras wrote:
>
> My only comment at this stage is that I would like to have the address
> passed to tlb_remove_page, as it used to be, so that I can find and
> clear the PTEs in the MMU hash table efficiently when the buffer in
> the mmu_gather_t fills up, before freeing the pages.

Sure enough, but you need to keep in mind that x86 (and others) want to
use the generic support even for pages that don't have virtual addresses,
ie the page directories etc. So that argues for splitting up the existing
"tlb_remove_page()" into something like

	tlb_remove_tlb_entry(tlb_gather_t *tlb, struct page *page, unsigned long address)
	{
		tlb_flush_mapping(tlb, page, address);
		tlb->freed++;
		tlb_remove_page(tlb,page);
	}

	tlb_remove_page(tlb_gather_t *tlb, tlb)
	{
		.. add the page to the pages[] array ..
	}

where PPC would have the "tlb_flush_mapping()" thing, and something like
x86 or a regular TLB would just define it to be a no-op.

		Linus

