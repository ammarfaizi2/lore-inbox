Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269439AbUIYXel@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269439AbUIYXel (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 19:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269440AbUIYXel
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 19:34:41 -0400
Received: from gate.crashing.org ([63.228.1.57]:56706 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S269439AbUIYXef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 19:34:35 -0400
Subject: Re: ptep_establish/establish_pte needs set_pte_atomic and all
	set_pte must be written in asm
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrea Arcangeli <andrea@novell.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040925155404.GL3309@dualathlon.random>
References: <20040925155404.GL3309@dualathlon.random>
Content-Type: text/plain
Message-Id: <1096155207.475.40.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 26 Sep 2004 09:33:27 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-09-26 at 01:54, Andrea Arcangeli wrote:

> Worthy to note is that we're buggy in all set_pte implementations since,
> all archs would need to also implement the set_pte in assembler to make
> sure the C language doesn't write it byte-by-byte which would break the
> SMP in the other thread. On ppc64 where a problem triggered (possibily
> unrelated to this) the pte is an unsigned long and it's being updated by
> set_pte with this:

Bye by byte ? Ahem ... That would be a really broken C compiler ;) I
don't see how it could be broken on archs where the PTE size is a single
long for example, ppc64 is not. ppc32 is already atomic for different
reasons

> 	*ptep = __pte(pte_val(pte)) & ~_PAGE_HPTEFLAGS

This is not broken, how can somebody else race on modifying this
PTE since we hold the page table lock and the PTE was previously
cleared & flushed from the hash table ? The last store updating
the PTE before we leave that code path will be a single 8 bytes
store (this is a 64 bits architecture !)

> (note pte_clear would be fine to be still in C, pte clear is guaranteed
> to run on not present ptes, 

That isn't the case of the pte_clear call issued by set_pte itself on
ppc64. I haven't looked at othe cases in the generic code, but I
suppose they indeed use get_and_clear instead.

> so we don't race with other threads, it's
> only set_pte that should always be written in assembler in the last
> opcode that writes in the pte)

Why ? I mean, why _always_ ? The above is perfectly correct on ppc64

> We don't need an SMP lock, we only need to write 4 or 8 bytes at once (a
> plain movl in x86 would do the trick). That's all we need. 

No, we need the page table lock on ppc64 because we must make sure the
PTE has been cleared & flushed from the hash table, before we set it to
the new value and all of that without another thread trying to modify
it. The only way we could get rid of the locks around set_pte or other
calls modifying the PTE validity/address on ppc64 would be to use the
PAGE_BUSY bit, which we defined as a per-PTE lock, in such a way that
it's taken around the whole flush+write operation (that is hold it
accross the hash flush). 

> (and in
> theory only for SMP, but UP will not get any slowdown since no lock on
> the bus will be necessary, we're the only writer thanks to the
> page_table_lock, but there are other readers running in userspace in
> SMP, hence the need of atomicity)
> 
> pte_clear would not be safe to call inside ptep_establish for the same
> reason (pte_clear is not atomic and it doesn't need to be atomic unlike
> set_pte), while something like this should be fine:
> 
> 	ptep_get_and_clear
> 	set_pte
> 	flush_tlb
> 
> but it doesn't worht it since all other archs supporting SMP in their
> architecture will have to change set_pte to an assembly version, so for
> them set_pte_atomic will be defined to set_pte.

I don't understand your point... PTE's are usually the native long size
of the arch and usually set_pte is a single aligned store, which mean
it's pretty much always "atomic"...

> The x86 set_pte itself should be changed to:
> 
> static inline void set_pte(pte_t *ptep, pte_t pte)
> {
> 	ptep->pte_high = pte.pte_high;
> 	smp_wmb();
> 	do this in a single not locked movl -> (ptep->pte_low = pte.pte_low);
> }
> 
> and for x86 the set_pte_atomic will remain the same as today, so the
> below patch seems the right long term fix (even if it breaks all archs
> but x86).
> 
> Comments?

If I understand your explanation, all you need is make sure that x86
set_pte sets the HW present bit last when writing the 2 halves, no ?

Ben.


