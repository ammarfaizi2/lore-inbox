Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261408AbTIDXX7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 19:23:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbTIDXX7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 19:23:59 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:23815 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261408AbTIDXX5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 19:23:57 -0400
Subject: Re: [PATCH] fix remap of shared read only mappings
From: James Bottomley <James.Bottomley@steeleye.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030904225636.GN31590@mail.jlokier.co.uk>
References: <1062686960.1829.11.camel@mulgrave>
	<20030904214810.GG31590@mail.jlokier.co.uk>
	<1062714829.2161.384.camel@mulgrave> 
	<20030904225636.GN31590@mail.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 04 Sep 2003 19:23:46 -0400
Message-Id: <1062717828.2161.449.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-04 at 18:56, Jamie Lokier wrote:
> You have just argued _against_ worrying about cache coherence by
> aligning mapping addresses.
> 
> Basically, POSIX says shared mappings aren't guanteed to be coherent
> until you call msync().  Then you can just do whatever is needed to
> make different views coherent.  That's easier now that we have rmap.

I think you may misunderstand what I mean by coherence:  Our problem is
the VIVT processor caches.  Once one mapper does an msync, that data
must be visible to all the other mappers, so at that point we have to
flush the cache lines of all the other mappers.  On PA, we only need to
flush one correctly aligned address to get the VIVT cache to flush all
the others.  However, the kernel page cache usually holds an unaligned
reference so we need to do the extra aligned flush when this data
changes.  If we didn't do the alignment, we'd need to flush every
virtual address in the current CPU translation for that page.

If you mean PROT_SEM requires immediate coherence without an msync, then
those semantics would be very tricky to achieve on parisc since we'd
need the kernel virtual address of the page in the page cache correctly
aligned as well.

rmap isn't really necessary for this, that's what the
page->mapping->i_mmap and i_mmap_shared lists are for.

James


