Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266153AbUGJGLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266153AbUGJGLu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 02:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266154AbUGJGLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 02:11:50 -0400
Received: from mail-relay-2.tiscali.it ([212.123.84.92]:40927 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S266153AbUGJGLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 02:11:48 -0400
Date: Sat, 10 Jul 2004 08:11:33 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, mason@suse.com
Subject: Re: writepage fs corruption fixes
Message-ID: <20040710061133.GB20947@dualathlon.random>
References: <20040709040151.GB20947@dualathlon.random> <20040708212923.406135f0.akpm@osdl.org> <20040709044205.GF20947@dualathlon.random> <20040708215645.16d0f227.akpm@osdl.org> <20040710001600.GT20947@dualathlon.random> <20040710010738.GX20947@dualathlon.random> <20040710045920.GY20947@dualathlon.random> <20040709225634.2eb0b8b0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040709225634.2eb0b8b0.akpm@osdl.org>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 09, 2004 at 10:56:34PM -0700, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> > +page_is_mapped:
> >  +
> >  +	end_index = i_size >> PAGE_CACHE_SHIFT;
> >   	if (page->index >= end_index) {
> >  -		unsigned offset = i_size_read(inode) & (PAGE_CACHE_SIZE - 1);
> >  +		unsigned offset = i_size & (PAGE_CACHE_SIZE - 1);
> >   		char *kaddr;
> >   
> >   		if (page->index > end_index || !offset)
> >  @@ -503,8 +506,6 @@ mpage_writepage(struct bio *bio, struct 
> >   		kunmap_atomic(kaddr, KM_USER0);
> >   	}
> >   
> >  -page_is_mapped:
> 
> What's the thinking behind moving the page_is_mapped label here?
> 
> We've established that we have found `first_unmapped' number of uptodate
> and dirty buffers at the "front" of the page, and we're about to stick
> (first_unmapped<<blkbits) bytes of this page into the BIO for writeout. 
> Hence everything which will go into the BIO is known to be uptodate and
> dirty.  So I'm wondering why this change was made.
> 
> 
> The change is correct, though.  It prevents us from writing non-zero data
> between i_size and the end of the final bh to the file. 
> block_write_full_page() does it too:

not sure to understand. The change is exactly to prevents us from
writing non-zero data between i_size and the end of the final bh. 

> (Note that this is a "best effort" thing - userspace could still write

sure I understand this is a best effort. I infact wanted to suggesting
that we could do it only once maybe (it's not guaranteed anyways, it's
up to userspace to do guarantee it, kernel cannot).

> But was this the reason for you making this change?

Just because block_write_full_page is doing it, so I think Chris was
correct making that change and moving the label. Either we remove it
from both, or we do it in both places. If we remove it we've just to be
careful on how to deal with the _first_ clearing. the prepare_write is
already ok, if the buffer is uptodate then we know we can write it. the
non-bh case needs to be checked and I belive that's the reason you were
doing the thing only for the non-bh case.

the only real fixes are the other two ones, the page_is_mapped move is
just because I agree with Chris it's more correct to do the same thing
as block_write_full_page to get the very same behaviour from both.
