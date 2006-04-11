Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWDKPil@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWDKPil (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 11:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWDKPil
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 11:38:41 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10928 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750762AbWDKPil (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 11:38:41 -0400
Date: Tue, 11 Apr 2006 08:35:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: carsteno@de.ibm.com
cc: Jes Sorensen <jes@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, bjorn_helgaas@hp.com
Subject: Re: [patch] do_no_pfn handler
In-Reply-To: <443BCA98.1020805@de.ibm.com>
Message-ID: <Pine.LNX.4.64.0604110830260.10745@g5.osdl.org>
References: <yq0k6a6uc7i.fsf@jaguar.mkp.net> <yq0psjonq2p.fsf@jaguar.mkp.net>
 <Pine.LNX.4.64.0604110751510.10745@g5.osdl.org> <443BCA98.1020805@de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 11 Apr 2006, Carsten Otte wrote:

> Linus Torvalds wrote:
> > At the very least, it would also need a
> > 
> > 	BUG_ON(is_cow_mapping(vma->vm_flags));
> > 
> > (or at least make it return VM_FAULT_SIGBUS). Because a COW mapping _will_ 
> > confuse the VM and cause it to do random bad things in vm_normal_page(). 
>
> That leaves my use-case out for now. I will need COW for my mapping when
> switching to this interface. Looks like a lot of things need rethinking
> in memory.c for COW with no struct page behind.

You _really_ cannot do COW together with "random pfn filling".

You can do COW with a pure remap_pfn_range() (ie a /dev/mem kind of 
mapping, or a frame buffer etc), but that's only because it has a very 
magic special case that is used to distinguish between cow'ed pages and 
the pages that were inserted initially.

We have no free bits in the page tables to say "this is a COW page" in 
general (on x86 we could do it, but some other architectures don't have 
any SW-usable bits). 

		Linus
