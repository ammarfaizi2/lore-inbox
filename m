Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264627AbUEYEUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264627AbUEYEUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 00:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264600AbUEYEUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 00:20:30 -0400
Received: from gate.crashing.org ([63.228.1.57]:44267 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264582AbUEYEUU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 00:20:20 -0400
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston>
	 <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
	 <1085371988.15281.38.camel@gaston>
	 <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
	 <1085373839.14969.42.camel@gaston>
	 <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
	 <20040525034326.GT29378@dualathlon.random>
	 <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1085458660.14969.106.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 25 May 2004 14:17:41 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> and similarly on most other architectures it should be quite easy to do 
> the equivalent. You can always do it with a simple compare-and-exchange 
> loop, something any SMP-capable architecture should have.
> 
> Of course, arguably we can actually optimize this by "knowing" that it is
> safe to set the dirty bit, so then we don't even need an atomic operation,
> we just need one atomic write.  So we only actually need the atomic op for 
> the accessed bit case, and if we make the write-case be totally separate..

Looks good ! That gives us a guarantee that set_pte is never ever called
on a present PTE (thus letting set_pte be non-atomic) and we can safely
BUG_ON(pte_present(*ptep)) in it, right ?
 
Note that having different set_dirty and set_accessed may be useful for
some archs, thouh I agree a single atomic operation is enough on ppc
too, I also want to make sure nobody ever gets the idea of using that
for anything but those 2 bits... Well, that's a matter of taste, go for
what you prefer.

ppc64 version of this would look like

static inline unsigned long ptep_set_bits(pte_t *p, unsigned long set)
{
	unsigned long old, tmp;

	__asm__ __volatile__(
	"1:	ldarx	%0,0,%3\n\
	or	%1,%0,%4 \n\
	stdcx.	%1,0,%3 \n\
	bne-	1b"
	: "=&r" (old), "=&r" (tmp), "=m" (*p)
	: "r" (p), "r" (clr), "m" (*p)
	: "cc" );
	return old;
}

ppc32 would be:

#define ptep_set_bits(p, bits) pte_update(p, 0, bits)

> Anybody willing to write up a patch for a few architectures? Is there any 
> architecture out there that would have a problem with this?
> 
> 		Linus
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

