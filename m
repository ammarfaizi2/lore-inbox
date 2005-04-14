Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVDNRfB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVDNRfB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 13:35:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261570AbVDNRfB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 13:35:01 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:50465 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S261567AbVDNReq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 13:34:46 -0400
Date: Thu, 14 Apr 2005 18:34:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andi Kleen <ak@suse.de>
cc: Dave Jones <davej@redhat.com>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>,
       Clem Taylor <clem.taylor@gmail.com>, Chris Wright <chrisw@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: x86-64 bad pmds in 2.6.11.6
In-Reply-To: <20050414170117.GD22573@wotan.suse.de>
Message-ID: <Pine.LNX.4.61.0504141804480.26008@goblin.wat.veritas.com>
References: <20050330214455.GF10159@redhat.com> 
    <20050331104117.GD1623@wotan.suse.de> <20050407024902.GA9017@redhat.com> 
    <20050407062928.GH24469@wotan.suse.de> 
    <Pine.LNX.4.61.0504141419250.25074@goblin.wat.veritas.com> 
    <20050414170117.GD22573@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2005, Andi Kleen wrote:
> 
> Thanks for the analysis. However I doubt the load_cr3 patch can fix
> it. All it does is to stop the CPU from prefetching mappings (which
> can cause different problem).

I thought that the leave_mm code (before your patch) flushes the TLB, but
restores cr3 to the mm, while removing that cpu from the mm's cpu_vm_mask.

So any speculation, not just prefetching, on that cpu is in danger of
bringing address translations according to that mm back into the TLB.

But when the mm is torn down in exit_mmap, there's no longer any record
that the TLB on that cpu needs flushing, so stale translations remain.

As a rule, we always flush TLB _after_ invalidating, not just before,
for this kind of reason.

My paranoia of speculation may be excessive: I _think_ what I outline
above is a real possibility on Intel, but you and others know AMD much
better than I (and the reports I've seen are on AMD64, not EM64T).

> But the Linux code who does bad pmd checks
> never looks at CR3 anyways, it always uses the current->mm. If
> bad pmd sees a bad page it must be still in the page tables of the MM,
> not a stable TLB entry.

Sure, the "mm/memory.c:97: bad pmd" messages are coming from
clear_pmd_range, when the corrupted task exits later (but probably
not much later, since its user stack is oddly distributed across
two different pages: some mentioned SIGSEGVs I think).

The pmd really is bad, but it got to be bad because it had stack data
written into it by create_elf_tables, when the TLB mistakenly thought
it already knew what physical page 0x00007ffffffff000 was mapped to
(prior kernel accesses to that user stack are not by user address).

Hugh
