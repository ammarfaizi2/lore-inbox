Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750723AbWITAVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbWITAVQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 20:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWITAVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 20:21:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21890 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750723AbWITAVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 20:21:15 -0400
Date: Tue, 19 Sep 2006 17:21:05 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Mike Waychison <mikew@google.com>, linux-mm@kvack.org,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
Message-Id: <20060919172105.bad4a89e.akpm@osdl.org>
In-Reply-To: <1158710712.6002.216.camel@localhost.localdomain>
References: <1158274508.14473.88.camel@localhost.localdomain>
	<20060915001151.75f9a71b.akpm@osdl.org>
	<45107ECE.5040603@google.com>
	<1158709835.6002.203.camel@localhost.localdomain>
	<1158710712.6002.216.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2006 10:05:12 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > I need to re-read your mail and Andrew as at this point, I don't quite
> > see why we need that args and/or that current->flags bit instead of
> > always returning all the way to userland and let the faulting
> > instruction happen again (which means you don't block in the kernel, can
> > take signals etc... thus do you actually need to prevent multiple
> > retries ?)
> 
> Actually... I can see it's faster to not return all the way and take the
> fault again ... though only in some cases. For example, if the pte has
> been filled in the meantime (concurrent faults) it's actually faster to
> just go back. The only reason I see why you need those args is to tell
> the no_page() handler wether retrying is acceptable or wether it should
> use the old way. Any reason why this is necessary at all ? What are you
> trying to avoid by not letting it always do the retry path ?

Livelocks.  I've described the deliberate one, but I fear there are
accidental ones I haven't thought of.

> My thinking was something around the lines of no_page() always does the
> retry logic. Then, we do something like:
> 
> handle_pte_fault() gets modified. If do_no_page() returns
> VM_FAULT_RETRY, it checks pte_present() again. If the PTE is present, it
> returns VM_FAULT_MINOR. If PTE is absent, it checks for signals, and
> returns VM_FAULT_MINOR if a signal is pending. If PTE is absent and no
> signals are pending, it returns VM_FAULT_RETRY.

You forget that the point of this optimisation is to undo mmap_sem while
waiting on the disk IO.  Once we've done that we cannot go looking at ptes
or vmas: another thread could have munapped the whole lot or anything. 
(And we always need to be afraid of use_mm()..)

Once mmap_sem has been dropped we need to go all the way back to the
process's virtual address and redo the vma lookup.  The easy and clean way
of doing that is to rerun the fault, reuse all the existing code.

> In addition, we still need to modify all archs do_page_fault() to handle
> VM_FAULT_RETRY...

Yup, it would need some temporary ifdeffery while architetures convert.

But bear in mind my earlier comments regarding possible optimisations to
this code.

> Or is there a specific scenario you are trying to avoid by keeping this
> mecanism for preventing retries ?
> 
> Ben.
