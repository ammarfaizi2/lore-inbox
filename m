Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbVDNSKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbVDNSKg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 14:10:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261581AbVDNSKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 14:10:36 -0400
Received: from ns2.suse.de ([195.135.220.15]:17115 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261580AbVDNSKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 14:10:17 -0400
Date: Thu, 14 Apr 2005 20:10:15 +0200
From: Andi Kleen <ak@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, Dave Jones <davej@redhat.com>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6
Message-ID: <20050414181015.GH22573@wotan.suse.de>
References: <20050330214455.GF10159@redhat.com> <20050331104117.GD1623@wotan.suse.de> <20050407024902.GA9017@redhat.com> <20050407062928.GH24469@wotan.suse.de> <Pine.LNX.4.61.0504141419250.25074@goblin.wat.veritas.com> <20050414170117.GD22573@wotan.suse.de> <Pine.LNX.4.61.0504141804480.26008@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504141804480.26008@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 06:34:58PM +0100, Hugh Dickins wrote:
> On Thu, 14 Apr 2005, Andi Kleen wrote:
> > 
> > Thanks for the analysis. However I doubt the load_cr3 patch can fix
> > it. All it does is to stop the CPU from prefetching mappings (which
> > can cause different problem).
> 
> I thought that the leave_mm code (before your patch) flushes the TLB, but
> restores cr3 to the mm, while removing that cpu from the mm's cpu_vm_mask.
> 
> So any speculation, not just prefetching, on that cpu is in danger of
> bringing address translations according to that mm back into the TLB.
> 
> But when the mm is torn down in exit_mmap, there's no longer any record
> that the TLB on that cpu needs flushing, so stale translations remain.
> 
> As a rule, we always flush TLB _after_ invalidating, not just before,
> for this kind of reason.

Yes this is all true. In fact I have several bug fixes for problems
in this area.

But this all cannot explain corruptions comming from the kernel, 
you tend to only see problems with the CPU prefetching something.

Note that with the cr3 reload you end up with init_mm, which
is not any useful mm. So even if there was a store from the kernel
into a stale mapping it would cause -EFAULT now.  But that is
not happening.

> 
> My paranoia of speculation may be excessive: I _think_ what I outline
> above is a real possibility on Intel, but you and others know AMD much
> better than I (and the reports I've seen are on AMD64, not EM64T).

It is not both on Intel and AMD :) These CPUs do a lot of prefetching
behind your back, any stale mappings at any time in the TLB eventually
cause problems. But other ones than this.


> Sure, the "mm/memory.c:97: bad pmd" messages are coming from
> clear_pmd_range, when the corrupted task exits later (but probably
> not much later, since its user stack is oddly distributed across
> two different pages: some mentioned SIGSEGVs I think).
> 
> The pmd really is bad, but it got to be bad because it had stack data
> written into it by create_elf_tables, when the TLB mistakenly thought
> it already knew what physical page 0x00007ffffffff000 was mapped to
> (prior kernel accesses to that user stack are not by user address).

What I meant is that the overwriting must be from Linux code
acting in the direct mapping, not due stale TLBs for addresses < __PAGE_OFFSET.

I will take a closer look at the rc1/rc2 patches later this evening
and see if I can spot something. Can only report back tomorrow though.

-Andi
