Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316444AbSETXvQ>; Mon, 20 May 2002 19:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316445AbSETXvP>; Mon, 20 May 2002 19:51:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4035 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316444AbSETXvO>;
	Mon, 20 May 2002 19:51:14 -0400
Date: Mon, 20 May 2002 16:37:24 -0700 (PDT)
Message-Id: <20020520.163724.40381283.davem@redhat.com>
To: torvalds@transmeta.com
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.5.16
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020520.163026.81812639.davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "David S. Miller" <davem@redhat.com>
   Date: Mon, 20 May 2002 16:30:26 -0700 (PDT)
   
   Architectures define tlb_flush_mm() as appropriate, on x86 it would
   be just flush_tlb_mm(mm), on Sparc/PPC/etc. which uses the VMA
   flushing it would just be a NOP.

Actually, there are some issues with my suggestion.

We are trying to do two things:

1) Flush all VMAs

2) Flush some unmapped area (1 or a few VMAs)

In the #1 case we'd like that to turn into something like:

	flush_cache_mm()
	for each vma {
		unmap_page_range();
	}
	tlb_finish_mmu();
	flush_tlb_mm();

Whereas in the #2 case it should look like:

	for each vma {
		tlb_start_vma(vma...);
		tlb_end_vma(vma...);
	}
	tlb_finish_mmu();

We have to reposition that tlb.h:flush_tlb_mm() call somehow to
make this a reality.

The next issue is how to make it so that this infrstructure
can allow us to kill off the buggy flush_tlb_pgtables() thing.
