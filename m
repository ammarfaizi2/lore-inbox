Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbUCLQLK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 11:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbUCLQLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 11:11:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:8680 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262240AbUCLQLH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 11:11:07 -0500
Date: Fri, 12 Mar 2004 08:17:49 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
cc: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@redhat.com>,
       Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: anon_vma RFC2
In-Reply-To: <20040312124638.GR655@holomorphy.com>
Message-ID: <Pine.LNX.4.58.0403120812430.1045@ppc970.osdl.org>
References: <20040311135608.GI30940@dualathlon.random>
 <Pine.LNX.4.44.0403112226581.21139-100000@chimarrao.boston.redhat.com>
 <20040312122127.GQ30940@dualathlon.random> <20040312124638.GR655@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 12 Mar 2004, William Lee Irwin III wrote:
> 
> Absolute guarantees are nice but this characterization is too extreme.
> The case where mremap() creates rmap_chains is so rare I never ever saw
> it happen in 6 months of regular practical use and testing. Their
> creation could be triggered only by remap_file_pages().

I have to _violently_ agree with Andrea on this one.

The absolute _LAST_ thing we want to have is a "remnant" rmap 
infrastructure that only gets very occasional use. That's a GUARANTEED way 
to get bugs, and really subtle behaviour.

I think Andrea is 100% right. Either do rmap for everything (like we do
now, modulo IO/mlock), or do it for _nothing_.  No half measures with
"most of the time".

Quite frankly, the stuff I've seen suggested sounds absolutely _horrible_. 
Special cases are not just a pain to work with, they definitely will cause 
bugs. It's not a matter of "if", it's a matter of "when".

So let's make it clear: if we have an object-based reverse mapping, it 
should cover all reasonable cases, and in particular, it should NOT have 
rare fallbacks to code that thus never gets any real testing.

And if we have per-page rmap like now, it should _always_ be there.

You do have to realize that maintainability is a HELL of a lot more
important than scalability of performance can be. Please keep that in
mind.

		Linus
