Return-Path: <linux-kernel-owner+w=401wt.eu-S965069AbWL2Rw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965069AbWL2Rw3 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 12:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965071AbWL2Rw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 12:52:29 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43784 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965069AbWL2Rw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 12:52:28 -0500
Date: Fri, 29 Dec 2006 09:51:31 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Theodore Tso <tytso@mit.edu>
cc: Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       linux-kernel@vger.kernel.org, ranma@tdiedrich.de,
       gordonfarquharson@gmail.com, akpm@osdl.org, a.p.zijlstra@chello.nl,
       tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
In-Reply-To: <20061229152742.GA28710@thunk.org>
Message-ID: <Pine.LNX.4.64.0612290945510.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
 <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org>
 <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org>
 <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org> <20061229152742.GA28710@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2006, Theodore Tso wrote:
> 
> I'm confused.  Does this mean that if "fs blocksize"=="VM pagesize"
> this bug can't trigger?

No. Even if there is just a single buffer-head, if the filesystem ever 
writes out that _single_ buffer-head out of turn (ie before the VM 
actually asks it to, with "->writepage()"), then the same issue will 
happen.

In fact, a bigger fs blocksize will likely just make this easier to 
trigger (although I doubt it makes a big difference), since any 
out-of-order buffer flushback will happen for the whole page, rather than 
just a part of the page.

So the "problem" really ends up being that the filesystem does flushing 
that the VM isn't aware of, so when the VM did "set_page_dirty()" at an 
earlier time, the VM _expected_ the "->writepages()" call that happened 
much later to write the whole page - but because the FS had flushed things 
behind it backs even _before_ the "->writepage" happens, by the time the 
VM actually asks for the page to be written out, the FS layer won't 
actually write it all out any more.

Blocksize doesn't matter, the only thing that matters is whether something 
writes out data on a buffer-cache level, not on a "page cache" level. Ext3 
apparently does this in "ordered" data more at least (and hey, I suspect 
that the code that tries to release buffer head data might try to do it on 
its own too).

		Linus
