Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751768AbWJIK0j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbWJIK0j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 06:26:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751773AbWJIK0j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 06:26:39 -0400
Received: from mail.suse.de ([195.135.220.2]:1944 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751768AbWJIK0j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 06:26:39 -0400
Date: Mon, 9 Oct 2006 12:26:35 +0200
From: Nick Piggin <npiggin@suse.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] mm: fault handler to replace nopage and populate
Message-ID: <20061009102635.GC3487@wotan.suse.de>
References: <20061007105758.14024.70048.sendpatchset@linux.site> <20061007105853.14024.95383.sendpatchset@linux.site> <20061007134407.6aa4dd26.akpm@osdl.org> <1160351174.14601.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160351174.14601.3.camel@localhost.localdomain>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2006 at 09:46:13AM +1000, Benjamin Herrenschmidt wrote:
> 
> > - So is the plan here to migrate all code over to using
> >   vm_operations.fault() and to finally remove vm_operations.nopage and
> >   .nopfn?  If so, that'd be nice.
> 
> Agreed. That would also allow to pass down knowledge of wether we can be
> interruptible or not (coming from userland or not). Useful in a few case
> when dealing with strange hw mappings.
> 
> Now, fault() still returns a struct page and thus doesn't quite fix the
> problem I'm exposing in my "User switchable HW mappings & cie" mail I
> posted today in which case we need to either duplicate the truncate
> logic in no_pfn() or get rid of no_pfn() and set the PTE from the fault
> handler . I tend to prefer the later provided that it's strictly limited
> for mappings that do not have a struct page though.

The truncate logic can't be duplicated because it works on struct pages.

What sounds best, if you use nopfn, is to do your own internal
synchronisation against your unmap call. Obviously you can't because you
have no ->nopfn_done call with which to drop locks ;)

So, hmm yes I have a good idea for how fault() could take over ->nopfn as
well: just return NULL, set the fault type to VM_FAULT_MINOR, and have
the ->fault handler install the pte. It will require a new helper along
the lines of vm_insert_page.

I'll code that up in my next patchset.
