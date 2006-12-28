Return-Path: <linux-kernel-owner+w=401wt.eu-S964913AbWL1EyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWL1EyV (ORCPT <rfc822;w@1wt.eu>);
	Wed, 27 Dec 2006 23:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWL1EyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Dec 2006 23:54:21 -0500
Received: from smtp.osdl.org ([65.172.181.25]:58209 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964913AbWL1EyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Dec 2006 23:54:20 -0500
Date: Wed, 27 Dec 2006 20:53:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Gordon Farquharson <gordonfarquharson@gmail.com>
cc: David Miller <davem@davemloft.net>, ranma@tdiedrich.de, tbm@cyrius.com,
       Peter Zijlstra <a.p.zijlstra@chello.nl>, andrei.popa@i-neo.ro,
       Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
In-Reply-To: <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0612272039411.4473@woody.osdl.org>
References: <20061226.205518.63739038.davem@davemloft.net> 
 <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org> 
 <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org> 
 <20061227.165246.112622837.davem@davemloft.net>  <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org>
 <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Dec 2006, Gordon Farquharson wrote:
> 
> It is at all suprising that the second offset within a page can be
> less than the first offset within a page ? e.g.
> 
> Chunk 260 corrupted (1-1455)  (2769-127)

No, that just means that it went over to the next page (so you actually 
had two consecutive pages that weren't written out).

That said, your output is very different from mine in another way. You 
don't have zeroes in your pages, rather the thing seems to have data from 
the next block (ie the chunk that should have 20 is reported as having 21 
etc). You also have your offsets shifted up by one (ie offset 0 looks ok 
for you, and then you have a strange pattern of corruption at bytes 
1...1455 instead of 0..1459.

You also seem to have an example of the _earlier_ writes being corrupted, 
rather than the later ones. For example (but it's also a page-crosser, so 
maybe that's part of it):

	Chunk 274 corrupted (1-1455)  (2729-87)
	Expected 18, got 19
	Written as (154)11(85)

says that block chunk 274 is the corrupt one, but it was written fairly 
early as #11, and the blocks around it (chunks 273 and 275) were actually 
written later.

For all I know, my test-program is buggy wrt the ordering printouts, 
though. Did you perhaps change the logic in any way?

			Linus
