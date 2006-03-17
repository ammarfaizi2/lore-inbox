Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752476AbWCQBE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476AbWCQBE3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 20:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752474AbWCQBE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 20:04:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:15242 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752467AbWCQBE2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 20:04:28 -0500
Date: Thu, 16 Mar 2006 17:04:14 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Jes Sorensen <jes@sgi.com>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, hch@lst.de, cotte@de.ibm.com,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: [patch] mspec - special memory driver and do_no_pfn handler
In-Reply-To: <20060316163728.06f49c00.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0603161659210.3618@g5.osdl.org>
References: <yq0k6auuy5n.fsf@jaguar.mkp.net> <20060316163728.06f49c00.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 16 Mar 2006, Andrew Morton wrote:
> 
> hm.  Is that a superset of ->nopage?  Should we be looking at
> migrating over to ->nopfn, retire ->nopage?
> 
> <looks at the ghastly stuff in do_no_page>
> 
> Maybe not...

Yeah, absolutely _not_.

If we wouldn't pass the "struct page" around, we wouldn't have anything to 
synchronize with, and each nopage() function would have to do rmap stuff.

That's actually how nopage() worked a long time ago (not rmap, but it was 
up the the low-level function to do all the page table logic etc). 
Switching to returning a structured return value and letting the generic 
VM code handle all the locking and the races was a _huge_ improvement.

So yes, the modern "->nopage()" interface is less flexible, but it's less 
flexible for a very good reason. 

Quite frankly, I don't think nopfn() is a good interface. It's only usable 
for one single thing, so trying to claim that it's a generic VM op is 
really not valid. If (and that's a big if) we need this interface, we 
should just do it inside mm/memory.c instead of playing games as if it was 
generic.

		Linus
