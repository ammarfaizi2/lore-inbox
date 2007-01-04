Return-Path: <linux-kernel-owner+w=401wt.eu-S932254AbXADEou@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932254AbXADEou (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 23:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbXADEou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 23:44:50 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:47075 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932254AbXADEot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 23:44:49 -0500
Date: Wed, 3 Jan 2007 20:44:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Andrea Gelmini <gelma@gelma.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: VM: Fix nasty and subtle race in shared mmap'ed page writeback
In-Reply-To: <459C7B24.8080008@yahoo.com.au>
Message-ID: <Pine.LNX.4.64.0701032031400.3661@woody.osdl.org>
References: <200612291859.kBTIx2kq031961@hera.kernel.org> <20061229224309.GA23445@gelma.net>
 <459734CE.1090001@yahoo.com.au> <20061231135031.GC23445@gelma.net>
 <459C7B24.8080008@yahoo.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 4 Jan 2007, Nick Piggin wrote:
> 
> Yhat's when the bug was introduced -- 2.6.19. 2.6.18 does not have
> this bug, so it cannot be years old.

Actually, I think 2.6.18 may have a subtle variation on it. 

In particular, I look back at the try_to_free_buffers() thing that I hated 
so much, and it makes me wonder.. It used to do:

	spin_lock(&mapping->private_lock);
	ret = drop_buffers(page, &buffers_to_free);
	spin_unlock(&mapping->private_lock);
	if (ret) {
		.. crappy comment ..
		if (test_clear_page_dirty(page))
			task_io_account_cancelled_write(PAGE_CACHE_SIZE);
	}

and I think that at least on SMP, we had a race with another CPU doing the 
"mark page dirty if it was dirty in the PTE" at the same time. Because the 
marking dirty would come in, find no buffers (they just got dropped), and 
then mark the page dirty (ignoring the lack of any buffers), but then the 
above would do the "test_clear_page_dirty()" thing on it.

Ie the race, I think, existed where that crappy comment was.

But that much older race would only trigger on SMP (or possibly UP with 
preempt).

And I haven't actually thought about it that much, so I could be full of 
crap. But I don't see anything that protects against it: we may hold the 
page lock, but since the code that marks things _dirty_ doesn't 
necessarily always hold it, that doesn't help us. And we may hold the 
"private_lock", but we drop it before we do the dirty bit clearing, and in 
fact on UP+PREEMPT that very dropping could cause an active preemption to 
take place, so..

I dunno. 

I would certainly suggest the whole series of my "dirty cleanup" be added 
on top of 2.6.18.3 (which apparently has the dirty mapped page tracking). 
For older kernels? If there is a race there, it must be pretty damn hard 
to hit in practice (and it must have been there for a looong time), so 
trying to fix it is possibly as likely to cause problems as it migh to fix 
them.

		Linus
