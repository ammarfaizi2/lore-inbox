Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135540AbREHC3s>; Mon, 7 May 2001 22:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136007AbREHC3j>; Mon, 7 May 2001 22:29:39 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:36364 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135540AbREHC3W>; Mon, 7 May 2001 22:29:22 -0400
Date: Mon, 7 May 2001 19:29:01 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: page_launder() bug
In-Reply-To: <Pine.LNX.4.21.0105071920080.7515-100000@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.21.0105071921110.8237-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 7 May 2001, Marcelo Tosatti wrote:
> 
> So lets fix it and make it look for the swap counts. 

Ehh.

Which you MUST NOT do without holding the page lock.

Hint: it needs "page->index", and without holding the page lock you don't
know what it could be. An out-of-bounds page index could do anything,
including oopsing the kernel. It so happens that right now you'll only get
a printk from swap_count(), because of defensive programming, but the fact
remains that you _cannot_ decide on whether a page is a dead swap-cache
entry until you've gotten the page lock.

> My point is that its _ok_ for us to check if the page is a dead swap cache
> page _without_ the lock since writepage() will recheck again with the page
> _locked_. Quoting you two messages back: 

Yes. But MY point is that the patch is buggy, and should be reverted. 

Move the swap_count check into the page lock. It's such a heavy operation
that you should, anyway. 

My message is true: you can do some "early out" optimizations. The code
has always done that. But if you look at the old code, it never did any
swap-count calculations or anything like that: it only looked at simple
bits in the "struct page" structure and the page count.

But once the level of complexity reaches actually doing function calls
etc, you should not call them early-out optimizations any more. Especially
not on data that could be stale, and that is used to dereference other
data structures (ie the swap count maps).

		Linus

