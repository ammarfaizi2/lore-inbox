Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264216AbTICSXe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 14:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264170AbTICSWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 14:22:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:28885 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264239AbTICSTk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 14:19:40 -0400
Date: Wed, 3 Sep 2003 11:19:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Hugh Dickins <hugh@veritas.com>
cc: Jamie Lokier <jamie@shareable.org>, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@redhat.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Alternate futex non-page-pinning and COW fix
In-Reply-To: <Pine.LNX.4.44.0309031859370.2336-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0309031111050.31853-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 3 Sep 2003, Hugh Dickins wrote:
> > 
> > The VM itself should only ever care about VM_SHARED. Because that's the 
> > only bit that has real semantic meaning.
> 
> To that part of the kernel interested in dirty pages, yes.
> But when interested in futexes, it seems not.

I don't like it.

If the patches can't be made to work for private mappings, then there's
something fundamentally wrong with them.

A non-writable shared mapping has degenerated into a private mapping since
the very first releases of Linux that supported mmap. It started out as a
"hey, we don't support true writable shared mappings, but we _do_ support
cache coherency on read-only mmaps through the normal private mappings,
so..".

And even later on, when true shared mappings were supported, we continued
the "degenerate to a private mapping" approach because the private
mappings tend to be simpler and require less overhead (exactly because
they don't need to worry about dirty bits).

So part of the picture is that this is just how the Linux VM fundamentally 
works. 

The other part of the picture is that futex'es should "just work" even 
when it comes to regular private mappings. Regardless of any VM_SHARED or 
VM_MAYSHARE bits. Even if the user did a totally private mmap() in the 
first place, that does not mean that the futex shouldn't work properly.

So the thing boils down to:

 - if the futex works on a proper private mapping, then the downgrade is 
   still proper, and the futex should never care about anything but a real
   VM_SHARED.

 - if the futex doesn't work with a proper private mapping, then that is a 
   bug _regardless_ of anything else, and VM_SHARED vs VM_MAYSHARE never 
   enters into the picture anyway.

What?

		Linus

