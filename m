Return-Path: <linux-kernel-owner+w=401wt.eu-S932125AbXAHImo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbXAHImo (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 03:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932127AbXAHImo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 03:42:44 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:40361 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932125AbXAHImn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 03:42:43 -0500
Date: Mon, 8 Jan 2007 09:39:35 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Avi Kivity <avi@qumranet.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org
Subject: Re: [announce] [patch] KVM paravirtualization for Linux
Message-ID: <20070108083935.GB18259@elte.hu>
References: <20070105215223.GA5361@elte.hu> <45A0E586.50806@qumranet.com> <20070107174416.GA14607@elte.hu> <45A1FF4E.1020106@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A1FF4E.1020106@qumranet.com>
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Avi Kivity <avi@qumranet.com> wrote:

> > the cache is zapped upon pagefaults anyway, so unpinning ought to be 
> > possible. Which one would you prefer?
> 
> It's zapped by the equivalent of mmu_free_roots(), right?  That's 
> effectively unpinning it (by zeroing ->root_count).

no, right now only the guest-visible cache is zapped - the roots are 
zapped by natural rotation. I guess they should be zapped in 
kvm_cr3_cache_clear() - but i wanted to keep that function an invariant 
to the other MMU state, to make it easier to call it from whatever mmu 
codepath.

> However, kvm takes pagefaults even for silly things like setting (in 
> hardware) or clearing (in software) the dirty bit.

yeah. I think it also does some TLB flushes that are not needed. For 
example in rmap_write_protect() we do this:

                rmap_remove(vcpu, spte);
                kvm_arch_ops->tlb_flush(vcpu);

but AFAICS rmap_write_protect() is only ever called if we write a new 
cr3 - hence a TLB flush will happen anyway, because we do a 
vmcs_writel(GUEST_CR3, new_cr3). Am i missing something? I didnt want to 
remove it as part of the cr3 patches (to keep things simpler), but that 
flush looks quite unnecessary to me. The patch below seems to work in 
light testing.

	Ingo

Index: linux/drivers/kvm/mmu.c
===================================================================
--- linux.orig/drivers/kvm/mmu.c
+++ linux/drivers/kvm/mmu.c
@@ -404,7 +404,11 @@ static void rmap_write_protect(struct kv
 		BUG_ON(!(*spte & PT_WRITABLE_MASK));
 		rmap_printk("rmap_write_protect: spte %p %llx\n", spte, *spte);
 		rmap_remove(vcpu, spte);
-		kvm_arch_ops->tlb_flush(vcpu);
+		/*
+		 * While we removed a mapping there's no need to explicitly
+		 * flush the TLB here, because this codepath only triggers
+		 * if we write a new cr3 - which will flush the TLB anyway.
+		 */
 		*spte &= ~(u64)PT_WRITABLE_MASK;
 	}
 }
