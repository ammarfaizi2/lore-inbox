Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWDUIAW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWDUIAW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 04:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932214AbWDUIAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 04:00:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:51898 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932162AbWDUIAV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 04:00:21 -0400
Date: Fri, 21 Apr 2006 00:59:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Nick Piggin <npiggin@suse.de>
Cc: npiggin@suse.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch 1/5] mm: remap_vmalloc_range
Message-Id: <20060421005913.1c4322a2.akpm@osdl.org>
In-Reply-To: <20060421073315.GL21660@wotan.suse.de>
References: <20060301045901.12434.54077.sendpatchset@linux.site>
	<20060301045910.12434.4844.sendpatchset@linux.site>
	<20060421001712.4cd5625e.akpm@osdl.org>
	<20060421073315.GL21660@wotan.suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <npiggin@suse.de> wrote:
>
> On Fri, Apr 21, 2006 at 12:17:12AM -0700, Andrew Morton wrote:
> > Nick Piggin <npiggin@suse.de> wrote:
> > >
> > > Add a remap_vmalloc_range and get rid of as many remap_pfn_range and
> > > vm_insert_page loops as possible.
> > > 
> > > remap_vmalloc_range can do a whole lot of nice range checking even
> > > if the caller gets it wrong (which it looks like one or two do).
> > > 
> > > 
> > > -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
> > > -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
> > > -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
> > > -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
> > > -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
> > > -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
> > > -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
> > > -		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED))
> > > -		if (remap_pfn_range(vma, start, page + vma->vm_pgoff,
> > > -						PAGE_SIZE, vma->vm_page_prot))
> > > -		if (remap_pfn_range(vma, addr, pfn, PAGE_SIZE, PAGE_READONLY))
> > 
> > You've removed the ability for the caller to set the pte protections - it
> > now always uses vma->vm_page_prot.
> > 
> > please explain...
> 
> They should use vma->vm_page_prot?
> 
> The callers affected are the PAGE_SHARED ones (the others are unchanged).
> Isn't it correct to provide readonly mappings if userspace asks for it?

Dunno.  I assume perfmon was using PAGE_READONLY because it doesn't want
userspace altering the memory.  One would think that this should be
enforced at mmap()-time, and that mprotect() might be able to override it
anyway.  But I haven't looked that closely.

First impression is that there's some potential for breaking stuff in all
this - convince me otherwise ;)

