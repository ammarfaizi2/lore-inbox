Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965147AbWIEJf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbWIEJf2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 05:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965150AbWIEJf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 05:35:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:934 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S965147AbWIEJf1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 05:35:27 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com>
References: <6d6a94c50609042052n4c1803eey4f4412f6153c4a2b@mail.gmail.com>  <6d6a94c50609032356t47950e40lbf77f15136e67bc5@mail.gmail.com> <17162.1157365295@warthog.cambridge.redhat.com>
To: Aubrey <aubreylee@gmail.com>
Cc: "David Howells" <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       mpm@selenic.com, davidm@snapgear.com, gerg@snapgear.com
Subject: Re: kernel BUGs when removing largish files with the SLOB allocator
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 05 Sep 2006 10:35:03 +0100
Message-ID: <3551.1157448903@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aubrey <aubreylee@gmail.com> wrote:

> IMHO the problem is nommu.c is written for slab only. So when slob is
> enabled, it need to be considered to make some modification to make
> two or more memory allocator algorithms work properly, rather than to
> force all others algorithm to be compatible with the current one(slab)
> to match the code in the nommu.c, which is not common enough.
>
> Does that make sense?

No, not really.

The point is that kobjsize() needs to determine the size of the object it has
been asked to assess.  It knows how to do that directly if the page is
allocated by the main page allocator, but not if the page belongs to the slab
allocator.  The quickest way it can determine this is to look at PG_slab.  In
such a case it defers to the slab allocator for a determination.

What I don't want to happen is that we have to defer immediately to the slob
allocator which then goes and searches various lists to see if it owns the
page.  Remember: unless the page is _marked_ as belonging to the slob
allocator, the slob allocator may _not_ assume any of the metadata in struct
page is valid slob metadata.  It _has_ to determine the validity of the page
by other means _before_ it can use the metadata, and that most likely means a
search.  This is why PG_slab exists: if it is set, you _know_ you can
instantly trust the metadata.

Since slob appears to be an entry-point-by-entry-point replacement for the
slab allocator, the slob allocator can also mark its pages for anything that's
looking to defer to it using PG_slab since the presence of slab and slob are
mutually exclusive.

Also, we already have two major memory allocator algorithms in the kernel at
any one time: (1) the main page allocator and (2) slab or slob.  We don't
really want to start going to three or more.


So, I come back to the main question: Why don't you want to use PG_slab?

David
