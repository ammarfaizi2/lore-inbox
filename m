Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265193AbUEYWNS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265193AbUEYWNS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 18:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265187AbUEYWNR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 18:13:17 -0400
Received: from gate.crashing.org ([63.228.1.57]:60293 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S265201AbUEYWLQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 18:11:16 -0400
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, wesolows@foobazco.org,
       willy@debian.org, Andrea Arcangeli <andrea@suse.de>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>, mingo@elte.hu,
       bcrl@kvack.org, linux-mm@kvack.org,
       Linux Arch list <linux-arch@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0405251455320.9951@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston>
	 <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
	 <1085371988.15281.38.camel@gaston>
	 <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
	 <1085373839.14969.42.camel@gaston>
	 <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
	 <20040525034326.GT29378@dualathlon.random>
	 <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
	 <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org>
	 <20040525153501.GA19465@foobazco.org>
	 <Pine.LNX.4.58.0405250841280.9951@ppc970.osdl.org>
	 <20040525102547.35207879.davem@redhat.com>
	 <Pine.LNX.4.58.0405251034040.9951@ppc970.osdl.org>
	 <20040525105442.2ebdc355.davem@redhat.com>
	 <Pine.LNX.4.58.0405251056520.9951@ppc970.osdl.org>
	 <1085521251.24948.127.camel@gaston>
	 <Pine.LNX.4.58.0405251452590.9951@ppc970.osdl.org>
	 <Pine.LNX.4.58.0405251455320.9951@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1085522860.15315.133.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 26 May 2004 08:07:41 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 	static inline void ptep_update_dirty_accessed(pte_t *ptep, pte_t entry, int dirty)
> 	{
> 		unsigned long bits = pte_value(entry) & (_PAGE_DIRTY | _PAGE_ACCESSED);
> 		unsigned long tmp;
> 
> 		__asm__ __volatile__(
> 	"1:	lwarx	%0,0,%3\n\
> 		or	%0,%2,%0\n\
> 		stwcx.	%0,0,%3\n\
> 		bne-	1b"
> 		:"=&r" (tmp), "=m" (*ptep)
> 		:"r" (bits), "r" (ptep)
> 		:"cc");
> 	}
> 
> 	/* Make asm-generic/pgtable.h know about it.. */
> 	#define ptep_update_dirty_accessed ptep_update_dirty_accessed

That looks good on a first look, I need to re-read the whole discussion since
yesterday through to make sure I didn't miss anything. Note that I'd rather
call the function ptep_set_* than ptep_update_* to make clear that it can
only ever be used to _set_ those bits.

Ben.


