Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261364AbVAGRfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261364AbVAGRfD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 12:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVAGRfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 12:35:03 -0500
Received: from fw.osdl.org ([65.172.181.6]:53172 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261364AbVAGRds (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 12:33:48 -0500
Date: Fri, 7 Jan 2005 09:33:41 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Oleg Nesterov <oleg@tv-sign.ru>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Make pipe data structure be a circular list of pages, rather
 than
In-Reply-To: <1105113998.24187.361.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0501070923590.2272@ppc970.osdl.org>
References: <41DE9D10.B33ED5E4@tv-sign.ru>  <Pine.LNX.4.58.0501070735000.2272@ppc970.osdl.org>
 <1105113998.24187.361.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 7 Jan 2005, Alan Cox wrote:
>
> > The reason I don't want to coalesce is that I don't ever want to modify a
> > page that is on a pipe buffer (well, at least not through the pipe buffe
> 
> If I can't write 4096 bytes down it one at a time without blocking from
> an empty pipe then its not a pipe in the eyes of the Unix world and the
> standards.

Absolutely. In fact, with the new implementation, you can often write
_several_ packets of 4096 bytes without blocking (but only writes less
than PIPE_BUF are guaranteed to be done all-or-nothing). I'm very aware of
the atomicity guarantees, I'm just saying that if you try to write 4096 
bytes by doing it one byte at a time, that has changed.

> > With this organization, a pipe ends up being able to act as a "conduit"  
> > for pretty much any data, including some high-bandwidth things like video
> > streams, where you really _really_ don't want to copy the data. So the 
> > next stage is:
> 
> The data copying impact isn't very high even if it is just done for the
> pipe() case for standards behaviour. You end up with one page that is
> written too and then sent and then freed rather than many.

I absolutely agree. A regular read()/write() still copies the data, and 
that's because I'm a firm believer that copying even a few kB of data is 
likely to be cheaper than trying to play MM games (not just the lookup of 
the physical address - all the locking, COW, etc crud that VM games 
require).

So while this shares some of the issues with the zero-copy pipes of yore,
but doesn't actually do any of that for regular pipe read/writes. And
never will, as far as I'm concerned. I just don't think user zero-copy is 
interesting at that level: if the user wants to access somethign without 
copying, he uses "mmap()".

So only when the data is _not_ in user VM space, that's when increasing a
reference count is cheaper than copying. Pretty much by definition, you
already have a "struct page *" at that point, along with which part of the
page contains the data.

So the "standard behaviour" (aka just plain read/write on the pipe) is all
the same copies that it used to be. The "just move pages around" issue
only happens when you want to duplicate the stream, or if you splice
around stuff that is already in kernel buffers (or needs a kernel buffer
anyway).

		Linus
