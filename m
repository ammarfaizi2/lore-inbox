Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263975AbUEXFgp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263975AbUEXFgp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 01:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263972AbUEXFgp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 01:36:45 -0400
Received: from gate.crashing.org ([63.228.1.57]:42465 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263975AbUEXFgk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 01:36:40 -0400
Subject: Re: [PATCH] ppc64: Fix possible race with set_pte on a present PTE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>, Ben LaHaise <bcrl@redhat.com>,
       linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
References: <1085369393.15315.28.camel@gaston>
	 <Pine.LNX.4.58.0405232046210.25502@ppc970.osdl.org>
	 <1085371988.15281.38.camel@gaston>
	 <Pine.LNX.4.58.0405232134480.25502@ppc970.osdl.org>
	 <1085373839.14969.42.camel@gaston>
	 <Pine.LNX.4.58.0405232149380.25502@ppc970.osdl.org>
Content-Type: text/plain
Message-Id: <1085376888.24948.45.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 24 May 2004 15:34:49 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Ahh.. That's a bug, methinks.
> 
> The reason it's a bug is that if you do this, you can lose the dirty bit 
> being written on some other CPU asynchronously.

Hrm... right indeed.

> In other words, I think it's pretty much always a bug to do a "set_pte()"
> with an existing pte in place, exactly because you lose information. You
> are trying to cover up the bug in ppc64-specific code, but I think that
> what you found is actually a (really really) unlikely race condition that
> can have serious consequences.
> 
> Or am I missing something else?

Well, the original scenario triggering that from userland is, imho, so
broken, that we may just not care losing that dirty bit ... Oh well :)
Anyway, apply my patch. If pte is not present, this will have no effect,
if it is, it makes sure we never leave a stale HPTE in the hash, which
is fatal in far worse ways.

> [ grep grep grep ]
> 
> Looks like "break_cow()" and "do_wp_page()" are safe, but only because
> they always sets the dirty bit, and any other bits end up being pretty 
> much "don't care if we miss an accessed bit update" or something.
> 
> Hmm. Maybe I'm wrong. If this really is buggy, it's been buggy this way 
> basically forever. That code is _not_ new, it's some of the oldes code in 
> the whole VM since the original three-level code rewrite. I think. Of 
> course, back then SMP wasn't an issue, and this seems to have survived all 
> the SMP fixes.
> 
> Who else has been working on the page tables that could verify this for 
> me? Ingo? Ben LaHaise? I forget who even worked on this, because it's so 
> long ago we went through all the atomicity issues with the page table 
> updates on SMP. There may be some reason that I'm overlooking that 
> explains why I'm full of sh*t.

Ben.


