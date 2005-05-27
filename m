Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbVE0Uwa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbVE0Uwa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 16:52:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVE0Uwa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 16:52:30 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:37323 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S262590AbVE0UvM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 16:51:12 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur.tabi@ammasso.com>
Subject: Re: Will __pa(vmalloc()) ever work?
Date: Fri, 27 May 2005 22:31:33 +0200
User-Agent: KMail/1.7.2
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <4297746C.10900@ammasso.com> <20050527192925.GA8250@infradead.org> <42977B0D.3040809@ammasso.com>
In-Reply-To: <42977B0D.3040809@ammasso.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200505272231.34162.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Freedag 27 Mai 2005 21:54, Timur Tabi wrote:
> Christoph Hellwig wrote:
> 
> > It will return the correct physical address for the start of the buffer.

No, not even that. If you do __pa(vmalloc()), the result will point outside of
the physical address space on most architectures.

> > But given that vmalloc is a non-contingous allocator that's pretty useless.
> 
> So as long as the vmalloc'd memory fits inside one page, __pa() will always give the 
> correct address?  If so, then can't I just call __pa() for every page in the buffer and 
> get a list of physical addresses?  If I can do that, then how the memory be virtually 
> contiguous but not physicall contiguous?

If the vmalloc'd memory fits into one page, you should not have used
vmalloc in the first place ;-). The only reason to ever use vmalloc
is if you can't get enough memory from alloc_pages reliably.

> > As are physical addresses for anything but low-level architecture code.
> 
> I don't understand what that means.

It means that a device driver should never need to use __pa directly, because
physical addresses don't have a well-defined meaning outside of the memory
management. A driver should only need to deal with user virtual, kernel virtual
and bus virtual but never real addresses.

Also, no device driver should be using vmalloc either: vmalloc fragments
your address space, pins physical pages and eats small children.

	Arnd <><
