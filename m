Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751361AbWDKUDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361AbWDKUDG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 16:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWDKUDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 16:03:06 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:12738 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751361AbWDKUDE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 16:03:04 -0400
Message-ID: <443C0B8F.7010501@de.ibm.com>
Date: Tue, 11 Apr 2006 22:03:27 +0200
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: carsteno@de.ibm.com
Organization: IBM Deutschland
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: carsteno@de.ibm.com, Jes Sorensen <jes@sgi.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       bjorn_helgaas@hp.com
Subject: Re: [patch] do_no_pfn handler
References: <yq0k6a6uc7i.fsf@jaguar.mkp.net> <yq0psjonq2p.fsf@jaguar.mkp.net> <Pine.LNX.4.64.0604110751510.10745@g5.osdl.org> <443BCA98.1020805@de.ibm.com> <Pine.LNX.4.64.0604110830260.10745@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604110830260.10745@g5.osdl.org>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> You _really_ cannot do COW together with "random pfn filling".
I still have'nt found a good way to do so, even after discussing with Nick and Hugh, but that's exactly where I intend to get for the xip stuff.

Today, the _only_ code that uses the struct page behind those DCSS segments is aops->nopage (as return value) and do_wp_page. Those small servers have almost no local memory (kernel, libraries, and binaries are shared), and the mem_map array is a large overhead.

> You can do COW with a pure remap_pfn_range() (ie a /dev/mem kind of 
> mapping, or a frame buffer etc), but that's only because it has a very 
> magic special case that is used to distinguish between cow'ed pages and 
> the pages that were inserted initially.
> 
> We have no free bits in the page tables to say "this is a COW page" in 
> general (on x86 we could do it, but some other architectures don't have 
> any SW-usable bits). 
That's true. One can store that information in the vma flags, and split the vma into 3 vmas once we have a write fault. Although that would work in theory, I doubt it would save lot of memory because of too many vmas, and I think we would burn precious CPU horsepower walking all those vmas.
I believe Hugh has already done an implementation for that which he does not consider nice. I have not found a feasible way to adress that issue so far, and I promise to keep from coding until I find a reasonable non-intrusive way to get there.
-- 

Carsten Otte
IBM Linux technology center
ARCH=s390
