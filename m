Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317035AbSH0TMp>; Tue, 27 Aug 2002 15:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317066AbSH0TMo>; Tue, 27 Aug 2002 15:12:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58629 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317035AbSH0TMn>; Tue, 27 Aug 2002 15:12:43 -0400
Date: Tue, 27 Aug 2002 12:22:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Dave Jones <davej@suse.de>,
       Marc Dietrich <Marc.Dietrich@hrz.uni-giessen.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M386 flush_one_tlb invlpg
In-Reply-To: <Pine.LNX.4.44.0208271635050.2362-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0208271216440.1419-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Aug 2002, Hugh Dickins wrote:
> 
> I just sent the 2.4.20-pre4 asm-i386/pgtable.h patch to Marcelo:
> here's patch against 2.5.31 or current BK: please apply.

This test is senseless, in my opinion:

> +		if (cpu_has_pge)					\
> +			__flush_tlb_single(addr);			\

The test _should_ be for something like

	if (cpu_has_invlpg)
		__flush_tlb_single(addr);

since we want to use the invlpg instruction regardless of any PGE issues 
if it is available.

There's another issue, which is the fact that I do not believe that invlpg 
is even guaranteed to invalidate a G page at all - although obviously all 
current CPU's seem to work that way. However, I don't see that documented 
anywhere. It might make sense to mark the places that expect to invalidate 
a global page explicitly, and call that function "flush_one_global_rlb()" 
(even if it - at least for now - does the same thing as the regular single 
invalidate).

		Linus

