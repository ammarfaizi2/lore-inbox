Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262790AbTH1BLi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 21:11:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262799AbTH1BLi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 21:11:38 -0400
Received: from corky.net ([212.150.53.130]:62402 "EHLO marcellos.corky.net")
	by vger.kernel.org with ESMTP id S262790AbTH1BLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 21:11:36 -0400
Date: Thu, 28 Aug 2003 04:11:34 +0300 (IDT)
From: Yoav Weiss <ml-lkml@unpatched.org>
X-X-Sender: yoavw@marcellos.corky.net
To: Andrea Arcangeli <andrea@suse.de>
Cc: Livio Baldini Soares <livio@ime.usp.br>, <mason@suse.com>, <axboe@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: io-stalls again (was "Re: Bug in drivers/block/ll_rw_blk.c")
In-Reply-To: <20030824215840.GE1460@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0308280355560.27026-100000@marcellos.corky.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea,

The only way to consistently get these stalls is with the cloop code.

I don't want to waste your time on reading non-mainstream code if the bug
is there rather than in the kernel, so I'm trying to figure out what the
relevant differences between loop and cloop are, to see if the bug hides
there.

So far, the only difference I see is that do_generic_file_read is called
from a separate thread in loop.o, via loop_thread() which was added by
Jens Axboe.  In cloop.o, everything is done from the context of the
reading thread.

Jens, maybe you can help me a bit here.  Is it wrong to call
do_generic_file_read in a loop-like driver, in the caller's context rather
than using a helper thread ?  Could it somehow cause a stall under heavy
load ?  When the stall occurs, it seems the last request never got
handled, but once another thread accesses the underlying fs/device, the
old request is handled along with the new one.

btw, I verified that the stall still occurs in 2.4.22.  The no-stall patch
only made it worse.

	Yoav Weiss

On Sun, 24 Aug 2003, Andrea Arcangeli wrote:

> On Fri, Aug 22, 2003 at 09:25:01PM +0300, Yoav Weiss wrote:
> > It may be possible to reproduce the same stall with loop.o but takes much
> > longer.  Could be related to the fact that cloop.o is a single thread
> > while loop.o has a separate reader thread.  Could this affect the problem ?
>
> It may not be related to cloop of course, but it would reduce the number
> of variables for us to have an how-to-reproduce that doesn't involve
> running kernel code outside the mainline kernel. If that's the only way
> to reproduce we simply have to look into the whole cloop code first,
> before we can actually look again into the mainline kernel code for
> this.
>
> Andrea
>

