Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264010AbTEWK3s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 06:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbTEWK3s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 06:29:48 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:35869 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264010AbTEWK3r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 06:29:47 -0400
Date: Fri, 23 May 2003 03:45:51 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Lothar Wassmann" <LW@KARO-electronics.de>
Cc: rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [patch] cache flush bug in mm/filemap.c (all kernels >=
 2.5.30(at least))
Message-Id: <20030523034551.0f80b17f.akpm@digeo.com>
In-Reply-To: <16077.61981.684846.221686@ipc1.karo>
References: <16076.50160.67366.435042@ipc1.karo>
	<20030522151156.C12171@flint.arm.linux.org.uk>
	<16077.55787.797668.329213@ipc1.karo>
	<20030523022454.61a180dd.akpm@digeo.com>
	<16077.61981.684846.221686@ipc1.karo>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 May 2003 10:42:53.0179 (UTC) FILETIME=[103BC4B0:01C32118]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lothar Wassmann" <LW@KARO-electronics.de> wrote:
>
> Andrew Morton writes:
> > "Lothar Wassmann" <LW@KARO-electronics.de> wrote:
> > >
> > > And maybe because *every* other call to flush_page_to_ram() has been
> > >  replaced by one of the new interface macros except that one in
> > >  filemap_nopage() in 'mm/filemap.c'.
> > > 
> > 
> > flush_page_to_ram() has been deleted from the kernel.
> > 
> Yes, I know. But did you even read, what I have written?

Vaguely.  It never hurts to repeat things ;)

> Is 2.5.68 current enough?

yes.

filemap_nopage isn't the right place to be doing these things though.

Given that there was no page at the virtual address before filemap_nopage
was called I don't think any CPU cache writeback or invalidation need be
performed.  Perhaps a writeback or invalidate is missing somewhere in the
unmap paths, or there is a problem in arch/arm somewhere.

We have a no-op flush_icache_page() in do_no_page(), but I don't know what
that thing ever did, not what it's doing in there.  (What happens if you
replace it with a flush_cache_page(vma, address)?)

Someone who understands these things better than I is going to have to work
out where the bug really is, I'm afraid.

