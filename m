Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264641AbUEYEnP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264641AbUEYEnP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 00:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264637AbUEYEnP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 00:43:15 -0400
Received: from gate.crashing.org ([63.228.1.57]:57579 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S264646AbUEYEnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 00:43:08 -0400
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
In-Reply-To: <20040525043729.GV29378@dualathlon.random>
References: <1085369393.15315.28.camel@gaston>
	 <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
	 <1085371988.15281.38.camel@gaston>
	 <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
	 <1085373839.14969.42.camel@gaston>
	 <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
	 <20040525034326.GT29378@dualathlon.random>
	 <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
	 <1085458660.14969.106.camel@gaston>
	 <20040525043729.GV29378@dualathlon.random>
Content-Type: text/plain
Message-Id: <1085460025.15024.108.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 25 May 2004 14:40:25 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-05-25 at 14:37, Andrea Arcangeli wrote:
> On Tue, May 25, 2004 at 02:17:41PM +1000, Benjamin Herrenschmidt wrote:
> > on a present PTE (thus letting set_pte be non-atomic) and we can safely
> > BUG_ON(pte_present(*ptep)) in it, right ?
> 
> set_pte is used even to mark the pte non present, so you can forget
> about using BUG_ON(pte_present(*ptep)) anywhere in set_pte regardless of
> how we fix this race (see mm/objrmap.c:unmap_pte_page()). If you want to
> trap for it you should add a set_pte_present and use it at least in
> objrmap.c during the paging.

Isn't this the work of pte_clear ? It's quite important to be very
careful about such PTE manipulations on ppc & ppc64 or we can wreck
everything by losting the hash state bits in there.

> unless you are generating page faults if the young bit is clear, this
> will only slowdown compared to my simpler approch.
> 
> However if some arch is using page faults to set the young bit in
> hardware (not in software), then slowing micro-down x86 and others might
> be an option to share all the common code, but we could easily avoid
> smp locking in x86 and alpha by threating the young-bit-page-fault archs
> differently too. 
> 
> Would be nice to hear from the ia64 folks what they're doing w.r.t. to
> the young bit, I think ia64 is the only one providing the young bit with
> an hardware page fault.
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

