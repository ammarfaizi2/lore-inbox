Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWITB5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWITB5n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 21:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWITB5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 21:57:43 -0400
Received: from gate.crashing.org ([63.228.1.57]:56791 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750853AbWITB5m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 21:57:42 -0400
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Mike Waychison <mikew@google.com>, linux-mm@kvack.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060919172105.bad4a89e.akpm@osdl.org>
References: <1158274508.14473.88.camel@localhost.localdomain>
	 <20060915001151.75f9a71b.akpm@osdl.org> <45107ECE.5040603@google.com>
	 <1158709835.6002.203.camel@localhost.localdomain>
	 <1158710712.6002.216.camel@localhost.localdomain>
	 <20060919172105.bad4a89e.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 20 Sep 2006 11:57:09 +1000
Message-Id: <1158717429.6002.231.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Livelocks.  I've described the deliberate one, but I fear there are
> accidental ones I haven't thought of.

But if you check for signal pending in handle_pte_fault() and possibly
do a cond_resched(), there should be no livelock situation...

> > My thinking was something around the lines of no_page() always does the
> > retry logic. Then, we do something like:
> > 
> > handle_pte_fault() gets modified. If do_no_page() returns
> > VM_FAULT_RETRY, it checks pte_present() again. If the PTE is present, it
> > returns VM_FAULT_MINOR. If PTE is absent, it checks for signals, and
> > returns VM_FAULT_MINOR if a signal is pending. If PTE is absent and no
> > signals are pending, it returns VM_FAULT_RETRY.
> 
> You forget that the point of this optimisation is to undo mmap_sem while
> waiting on the disk IO.  Once we've done that we cannot go looking at ptes
> or vmas: another thread could have munapped the whole lot or anything. 
> (And we always need to be afraid of use_mm()..)

Wait wait .. .we don't need to have the mmap sem to -look- at a PTE. Or
the hardware would be in pain when doing table walk. My point is, if the
PTE is -present- (which we can check without taking the mmap sem), we
just return to userland and re-do the instruction.

> Once mmap_sem has been dropped we need to go all the way back to the
> process's virtual address and redo the vma lookup. The easy and clean way
> of doing that is to rerun the fault, reuse all the existing code.

Sure, but what I'm saying is that we can still check if the PTE is
present or a signal pending and based on that, decide to return either
VM_FAULT_MINOR or VM_FAULT_RETRY. The former would cause do_page_fault()
to return all the way to userland while the later would just loop in
do_page_fault() as per Mike patch.

> > In addition, we still need to modify all archs do_page_fault() to handle
> > VM_FAULT_RETRY...
> 
> Yup, it would need some temporary ifdeffery while architetures convert.
> 
> But bear in mind my earlier comments regarding possible optimisations to
> this code.

Yup and I think my idea does, and I still don't see why we need this
additional burden of MAY_RETRY to carry around... (that is, I don't see
the livelock if we are careful enough to test for signals when we get a
VM_FAULT_RETRY result, and possibly cond_resched() or test
need_resched() and go back to userland, either way is fine by me).

Ben.


