Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263492AbUJ2Tn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263492AbUJ2Tn0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 15:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263474AbUJ2Tju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 15:39:50 -0400
Received: from witte.sonytel.be ([80.88.33.193]:1010 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261478AbUJ2TK5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 15:10:57 -0400
Date: Fri, 29 Oct 2004 21:10:52 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Zachary Amsden <zach@vmware.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Remove some divide instructions
In-Reply-To: <Pine.LNX.4.58.0410282136030.28839@ppc970.osdl.org>
Message-ID: <Pine.GSO.4.61.0410292108100.23014@waterleaf.sonytel.be>
References: <417FC982.7070602@vmware.com> <Pine.LNX.4.58.0410270926240.28839@ppc970.osdl.org>
 <41801DE1.6000007@vmware.com> <Pine.LNX.4.58.0410271704520.28839@ppc970.osdl.org>
 <Pine.LNX.4.58.0410271731010.28839@ppc970.osdl.org> <4181933A.5000402@vmware.com>
 <Pine.LNX.4.58.0410282136030.28839@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004, Linus Torvalds wrote:
> On Thu, 28 Oct 2004, Zachary Amsden wrote:
> 	#define __constant_log2(y) ((y==1) ? 0 : \
> 				    (y==2) ? 1 : \
> 				    (y==4) ? 2 : \
> 				    (y==8) ? 3 : -1)	/* We could go on ... */
> 
> 	#define do_div(x,y) ({					\
> 		unsigned long __mod;				\
> 		int __log2;					\
> 		if (__builtin_constant_p(y) && 			\
> 		    !((y) & ((y)-1)) &&				\
> 		    (__log2 = __constant_log2((y))) >= 0) {	\
> 			mod = x & ((y)-1);			\
> 			(x) >>= __log2;				\
> 		} else {					\
> 			.. inline asm case ..			\
> 		}						\
> 		__mod; })
> 
> which looks like it should work, but it's getting so ugly that I suspect I 
> should be committed for even thinking about it.
> 
> (And no, I didn't test the above. It is all trivially optimizable by a 
> compiler, and I can't see how gcc could _fail_ to get it right, but hey, I 
> thought the previous thing would work too, so I'm clearly not competent to 
> make that judgement... ;)

Perhaps this is why you see in many header files code like this:

    static inline xxx_const_case(...) { ... }
    static inline xxx_nonconst_case(...) { ... }

#define xxx(...) __builtin_constant_p(...) ? xxx_const_case(...) \
					   : xxx_nonconst_case(...)

i.e. gcc is better in optimizing away calls to non-called functions?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
