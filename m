Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316099AbSETQND>; Mon, 20 May 2002 12:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316105AbSETQNC>; Mon, 20 May 2002 12:13:02 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:29961 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S316099AbSETQNC>; Mon, 20 May 2002 12:13:02 -0400
Date: Mon, 20 May 2002 09:13:22 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.16
In-Reply-To: <15592.61285.98743.781939@argo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.44.0205200904461.23874-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 20 May 2002, Paul Mackerras wrote:
>
> This patch splits up the existing tlb_remove_page into
> tlb_remove_tlb_entry (for pages that are/were mapped into userspace)
> and tlb_remove_page, as you suggested.  It also adds the necessary
> stuff for PPC, which has its own include/asm-ppc/tlb.h now.  This
> works on at least one PPC machine. :)

Hmm.. The PPC <asm/tlb.h> seems to be largely a simplified version of
the asm-generic one, with no support for the UP optimization, for example.

And that UP optimization should be perfectly correct even on PPC, so you
apparently lost something in the translation.

I'd actually rather try to share more of the code, if possible.

That does involve putting some of the helper functions in the native
asm/tlb.h file, so I would suggest somehting along the line of

 - asm-i386/tlb.h:

	/*
	 * x86 doesn't need to do any per-TLB work,
	 * or care about VMA ranges
	 */
	#define tlb_flush_one_page(tlb,page,address) do { } while (0)
	#define tlb_start_vma(tlb,vma) do { } while (0)
	#define tlb_end_vma(tlb,vma) do { } while (0)

	#include <asm-generic/tlb.h>

 - asm-ppc/tlb.h:


	static inline void tlb_flush_one_page(tlb, page, address)
	{
		if (tlb->nr == 0)
			tlb->start = address;
		else if (address - tlb->end > 32 * PAGE_SIZE) {
			tlb_flush_mmu(tlb);
			tlb->start = address;
		}
		tlb->end = address;
	}
	#define tlb_start_vma(tlb,vma) do { } while (0)
	#define tlb_end_vma(tlb,vma) tlb_flush_mmu(tlb)

	#include <asm-generic/tlb.h>

See what I mean? You can share all the generic stuff, and only differ in
the details.

I think.

		Linus

