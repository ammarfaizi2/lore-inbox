Return-Path: <linux-kernel-owner+w=401wt.eu-S1030178AbWL3A7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030178AbWL3A7n (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 19:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWL3A7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 19:59:43 -0500
Received: from smtp.osdl.org ([65.172.181.25]:37331 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030178AbWL3A7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 19:59:42 -0500
Date: Fri, 29 Dec 2006 16:58:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Segher Boessenkool <segher@kernel.crashing.org>,
       David Miller <davem@davemloft.net>, nickpiggin@yahoo.com.au,
       kenneth.w.chen@intel.com, guichaz@yahoo.fr, hugh@veritas.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ranma@tdiedrich.de, gordonfarquharson@gmail.com, a.p.zijlstra@chello.nl,
       tbm@cyrius.com, arjan@infradead.org, andrei.popa@i-neo.ro
Subject: Re: Ok, explained.. (was Re: [PATCH] mm: fix page_mkclean_one)
In-Reply-To: <20061229163316.020fcda1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612291651350.4473@woody.osdl.org>
References: <Pine.LNX.4.64.0612281125100.4473@woody.osdl.org>
 <20061228114517.3315aee7.akpm@osdl.org> <Pine.LNX.4.64.0612281156150.4473@woody.osdl.org>
 <20061228.143815.41633302.davem@davemloft.net> <3d6d8711f7b892a11801d43c5996ebdf@kernel.crashing.org>
 <Pine.LNX.4.64.0612282155400.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612290017050.4473@woody.osdl.org>
 <Pine.LNX.4.64.0612290202350.4473@woody.osdl.org> <20061229141632.51c8c080.akpm@osdl.org>
 <Pine.LNX.4.64.0612291431200.4473@woody.osdl.org> <20061229155118.3feb0c17.akpm@osdl.org>
 <Pine.LNX.4.64.0612291559540.4473@woody.osdl.org> <20061229163316.020fcda1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2006, Andrew Morton wrote:
>
> > > Somewhat nastily, but as ext3 directories are metadata it is appropriate
> > > that modifications to them be done in terms of buffer_heads (ie: blocks).
> > 
> > No. There is nothing "appropriate" about using buffer_heads for metadata. 
> 
> I said "modification".

You said "metadata".

Why do you think directories are any different from files? Yes, they are 
metadata. So what? What does that have to do with anything?

They should still use virtual indexes, the way files do. That doesn't 
preclude them from using buffer-heads to mark their (partial-page) 
modifications and for keeping the virtual->physical translations cached.

I mean, really. Look at ext2. It does exactly that. It keeps the 
directories in the page cache - virtually indexed. And it even modifies 
them there. Exactly the same way it modifies regular file data.

It all works exactly the same way it works for regular files. It uses

	page->mapping->a_ops->prepare_write(NULL, page, from, to);
	... do modification ...
	ext2_commit_chunk(page, from, to);

exactly the way regular file data works. 

That's why I'm saying there is absolutely _zero_ thing about "metadata" 
here, or even about "modifications". It all works better in a virtual 
cache, because you get all the support that we give to page caches.

So I really don't understand why you make excuses for ext3 and talk about 
"modifications" and "metadata". It was a fine design ten years ago. It's 
not really very good any longer.

I suspect we're stuck with the design, but that doesn't make it any 
_better_.

		Linus
