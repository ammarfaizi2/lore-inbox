Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265289AbUEZC0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265289AbUEZC0e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 22:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265288AbUEZC0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 22:26:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:41419 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265287AbUEZC0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 22:26:32 -0400
Date: Tue, 25 May 2004 19:26:21 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrea Arcangeli <andrea@suse.de>
cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
       Matthew Wilcox <willy@debian.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@kvack.org>,
       linux-mm@kvack.org, Architectures Group <linux-arch@vger.kernel.org>
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
In-Reply-To: <20040525224258.GK29378@dualathlon.random>
Message-ID: <Pine.LNX.4.58.0405251924360.15534@ppc970.osdl.org>
References: <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
 <20040525034326.GT29378@dualathlon.random> <Pine.LNX.4.58.0405242051460.32189@ppc970.osdl.org>
 <20040525114437.GC29154@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0405250726000.9951@ppc970.osdl.org> <20040525212720.GG29378@dualathlon.random>
 <Pine.LNX.4.58.0405251440120.9951@ppc970.osdl.org> <20040525215500.GI29378@dualathlon.random>
 <Pine.LNX.4.58.0405251500250.9951@ppc970.osdl.org> <20040526021845.A1302@den.park.msu.ru>
 <20040525224258.GK29378@dualathlon.random>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 26 May 2004, Andrea Arcangeli wrote:
> 
> after various searching on the x86 docs I found:
> 
> 	Whenever a page-directory or page-table entry is changed (including when
> 	the present flag is set to zero), the operating-system must immediately
> 	invalidate the corresponding entry in the TLB so that it can be updated
> 	the next time the entry is referenced.
> 
> according to the above we'd need to flush the tlb even in
> do_anonymous_page on x86, or am I reading it wrong?

You're reading it wrong.

The "including when the present flag is set to zero" part does not mean 
that the present flag was zero _before_, it means "is being set to zero" 
as in "having been non-zero before that".

Anytime the P flag was clear _before_, we don't need to invalidate, 
because non-present entries are not cached in the TLB.

			Linus
