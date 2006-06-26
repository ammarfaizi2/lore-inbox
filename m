Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964792AbWFZXC4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbWFZXC4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964817AbWFZXCy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:02:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54481 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964811AbWFZXCd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:02:33 -0400
Date: Mon, 26 Jun 2006 16:02:08 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       linux-kernel@vger.kernel.org, arjan@linux.intel.com, pavel@suse.cz,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] binfmt: turn MAX_ARG_PAGES into a sysctl tunable
In-Reply-To: <20060626223526.GA18579@elte.hu>
Message-ID: <Pine.LNX.4.64.0606261555320.3927@g5.osdl.org>
References: <1151060089.30819.2.camel@lappy> <20060626095702.8b23263d.akpm@osdl.org>
 <Pine.LNX.4.64.0606261009190.3747@g5.osdl.org> <20060626223526.GA18579@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Jun 2006, Ingo Molnar wrote:
>
> i thought about your "map execve pages directly into target" (since the 
> source gets destroyed anyway) suggestion back then, and unfortunately it 
> gets quite complex.

No, you misunderstood.

I wasn't actually suggesting mapping pages directly from the source into 
the destination.  That is indeed horribly horribly complicated.

I really only wanted to avoid the "brpm->pages[]" indirection.

So right now, we copy the argument strings into new temporary pages and 
put them in the ->pages[] array.

The "copy argument strings into new temporary pages" part is _fine_. I 
wouldn't change that part at all.

I'd only really change the "into the ->pages[] array" part, and instead 
move them directly into the destination page tables.

Why?

Two reasons:
 - right now ->pages[] array is unswappable. Avoiding the temporary array 
   would allow the swapper to actually swap the pages out (no special 
   cases: it's a perfectly normal page table, it just hasn't actually 
   gotten activated yet).
 - And the whole reason for having a limited array  basically goes away 
   (the swappable thing is part of it, but the fact that the page tables 
   themselves are just a lot more extensible than the silly array is just 
   fundamentally a part of it too)

So it's literally just the array I'd get rid of. Instead of insertign the 
page into the array, just insert it directly into the page table with 
"install_arg_page()".

			Linus
