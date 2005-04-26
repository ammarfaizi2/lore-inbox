Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVDZMAd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVDZMAd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 08:00:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261492AbVDZMAd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 08:00:33 -0400
Received: from smtp205.mail.sc5.yahoo.com ([216.136.129.95]:65470 "HELO
	smtp205.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261488AbVDZMAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 08:00:24 -0400
Subject: Re: [patch] __block_write_full_page bug
From: Nick Piggin <nickpiggin@yahoo.com.au>
To: Andrew Morton <akpm@osdl.org>
Cc: andrea@suse.de, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050426045039.702d9075.akpm@osdl.org>
References: <426C6A63.80408@yahoo.com.au>
	 <20050426045039.702d9075.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 26 Apr 2005 22:00:20 +1000
Message-Id: <1114516820.5097.26.camel@npiggin-nld.site>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-26 at 04:50 -0700, Andrew Morton wrote:
> Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> >
> >  When running
> >  	fsstress -v -d $DIR/tmp -n 1000 -p 1000 -l 2
> >  on an ext2 filesystem with 1024 byte block size, on SMP i386 with 4096 byte
> >  page size over loopback to an image file on a tmpfs filesystem, I would
> >  very quickly hit
> >  	BUG_ON(!buffer_async_write(bh));
> >  in fs/buffer.c:end_buffer_async_write
> > 
> >  It seems that more than one request would be submitted for a given bh
> >  at a time. __block_write_full_page looks like the culprit - with the
> >  following patch things are very stable.
> 
> What's the bug?  I don't see it.
> 

Ah, the bug is that end_buffer_async_write first does
	BUG_ON(!buffer_async_write(bh));
then a bit later does
	clear_buffer_async_write(bh);

That's where it was blowing up for me, because end_buffer_async_write
was being run twice for that buffer.

Or did you mean *how* is it being run twice? I didn't exactly find
the stack traces involved, but I imagine that simply testing
buffer_async_write catches other requests in flight - ie. we've
lost track of exactly which ones we own.


> Was an ENOSPC involved?
> 

No.

> Those tests for buffer_async_write(bh) are redundant now, aren't they?

They are, yes. Sorry I noticed that earlier too - they should probably
be BUG_ON(!buffer_async_write(bh)) instead. Would make things clearer.

Nick



