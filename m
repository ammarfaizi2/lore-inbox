Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264121AbTEWSNT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 14:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264122AbTEWSNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 14:13:19 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:21576 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264121AbTEWSNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 14:13:18 -0400
Date: Fri, 23 May 2003 11:29:26 -0700
From: Andrew Morton <akpm@digeo.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: rmk@arm.linux.org.uk, LW@KARO-electronics.de, linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
 2.5.30(at least))
Message-Id: <20030523112926.7c864263.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0305231821460.1690-100000@localhost.localdomain>
References: <20030523175413.A4584@flint.arm.linux.org.uk>
	<Pine.LNX.4.44.0305231821460.1690-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 May 2003 18:26:24.0917 (UTC) FILETIME=[D1523450:01C32158]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins <hugh@veritas.com> wrote:
>
> On Fri, 23 May 2003, Russell King wrote:
> > 
> > No, I think there is a flush missing somewhere in this path.
> > 
> > What I think is happening is that Lothar is using the PXA with the cache
> > in write allocate write back mode (Xscale is the first ARM-arch cpu to
> > have allocate on write caches.)
> > 
> > This means that when IDE copies the data into the buffer using insw or
> > whatever, it ends up in the VIVT cache rather than memory.  Since we
> > don't seem to be calling flush_dcache_page(), we never write this data
> > back to memory for user space to access it via their mapping.

That sounds distinctly possible.

> I believe (DaveM will speak with authority) that hitherto it has been
> assumed that I/O (well, Input) brings data actually into memory: we use
> flush_dcache_page if kernel memsets or memcpys data, not if it's read in.

Vague statement of principle: The device driver layer takes care of these
issues for DMA transfers, and hence should also take care of them for PIO. 
Is this sensible and/or possible?

> If this mode+architecture departs from that, then we would need another
> macro, which translates to flush_dcache_page (sufficient?) for that,
> and is a nop for everything else.
> 
> And where would it be placed?  I think not where the flush_page_to_ram
> used to be in filemap_nopage, but after the ->readpage.  Or... would
> this tie in with Martin's s390 request for a SetPageUptodate hook?
> 

IDE?

