Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264635AbUEYEhi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264635AbUEYEhi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 00:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264628AbUEYEhi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 00:37:38 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:55789
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S264595AbUEYEhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 00:37:34 -0400
Date: Tue, 25 May 2004 06:37:29 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
Message-ID: <20040525043729.GV29378@dualathlon.random>
References: <1085369393.15315.28.camel@gaston> <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org> <1085371988.15281.38.camel@gaston> <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org> <1085373839.14969.42.camel@gaston> <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org> <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org> <1085458660.14969.106.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085458660.14969.106.camel@gaston>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 02:17:41PM +1000, Benjamin Herrenschmidt wrote:
> on a present PTE (thus letting set_pte be non-atomic) and we can safely
> BUG_ON(pte_present(*ptep)) in it, right ?

set_pte is used even to mark the pte non present, so you can forget
about using BUG_ON(pte_present(*ptep)) anywhere in set_pte regardless of
how we fix this race (see mm/objrmap.c:unmap_pte_page()). If you want to
trap for it you should add a set_pte_present and use it at least in
objrmap.c during the paging.

> ppc64 version of this would look like
> 
> static inline unsigned long ptep_set_bits(pte_t *p, unsigned long set)
> {
> 	unsigned long old, tmp;
> 
> 	__asm__ __volatile__(
> 	"1:	ldarx	%0,0,%3\n\
> 	or	%1,%0,%4 \n\
> 	stdcx.	%1,0,%3 \n\
> 	bne-	1b"
> 	: "=&r" (old), "=&r" (tmp), "=m" (*p)
> 	: "r" (p), "r" (clr), "m" (*p)
> 	: "cc" );
> 	return old;
> }
> 
> ppc32 would be:
> 
> #define ptep_set_bits(p, bits) pte_update(p, 0, bits)

unless you are generating page faults if the young bit is clear, this
will only slowdown compared to my simpler approch.

However if some arch is using page faults to set the young bit in
hardware (not in software), then slowing micro-down x86 and others might
be an option to share all the common code, but we could easily avoid
smp locking in x86 and alpha by threating the young-bit-page-fault archs
differently too. 

Would be nice to hear from the ia64 folks what they're doing w.r.t. to
the young bit, I think ia64 is the only one providing the young bit with
an hardware page fault.
