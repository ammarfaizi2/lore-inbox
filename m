Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWEYRA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWEYRA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 13:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030281AbWEYRA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 13:00:26 -0400
Received: from [213.46.243.16] ([213.46.243.16]:43882 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030280AbWEYRA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 13:00:26 -0400
Subject: Re: [PATCH 1/3] mm: tracking shared dirty pages
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Christoph Lameter <clameter@sgi.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Christoph Lameter <christoph@lameter.com>,
       Martin Bligh <mbligh@google.com>, Nick Piggin <npiggin@suse.de>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605250856020.23726@schroedinger.engr.sgi.com>
References: <20060525135534.20941.91650.sendpatchset@lappy>
	 <20060525135555.20941.36612.sendpatchset@lappy>
	 <Pine.LNX.4.64.0605250856020.23726@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Thu, 25 May 2006 19:00:20 +0200
Message-Id: <1148576422.10561.80.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-05-25 at 09:21 -0700, Christoph Lameter wrote:
> On Thu, 25 May 2006, Peter Zijlstra wrote:
> 
> > @@ -1446,12 +1447,13 @@ static int do_wp_page(struct mm_struct *
> >  
> > -	if (unlikely(vma->vm_flags & VM_SHARED)) {
> > +	if (vma->vm_flags & VM_SHARED) {
> 
> You add this unlikely later again it seems. Why remove in the first place?

I'm not sure I follow you, are you suggesting that we'll find the
condition to be unlikely still, even with most of the shared mappings
trapping this branch?

> > +static int page_mkclean_one(struct page *page, struct vm_area_struct *vma)
> > +	entry = pte_mkclean(pte_wrprotect(*pte));
> > +	ptep_establish(vma, address, pte, entry);
> 
> > +	update_mmu_cache(vma, address, entry);
> 
> You only changed protections on an estisting pte and ptep_establish 
> already flushed the tlb. No need to call update_mmu_cache. See how 
> change_protection() in mm/mprotect.c does it.

OK, will check.

> > +	lazy_mmu_prot_update(entry);
> 
> Needed.

