Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315204AbSFOJMj>; Sat, 15 Jun 2002 05:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315207AbSFOJMj>; Sat, 15 Jun 2002 05:12:39 -0400
Received: from merlin.webone.com.au ([210.8.44.18]:10758 "EHLO
	merlin.webone.com.au") by vger.kernel.org with ESMTP
	id <S315204AbSFOJMh>; Sat, 15 Jun 2002 05:12:37 -0400
Date: Sat, 15 Jun 2002 19:12:30 +1000
To: hugh@veritas.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 no timestamp update on modified mmapped files
Message-ID: <20020615191230.A22499@beernut.flames.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0206150830190.1185-100000@localhost.localdomain>
From: Kevin Easton <s3159795@student.anu.edu.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 15 Jun 2002, Hugh Dickins wrote:
> On Sat, 15 Jun 2002, Kevin Easton wrote:
> > On Wed, 12 Jun 2002, Hugh Dickins wrote:
> > > 
> > > But you didn't spell out the worst news on that option: read faults 
> > > into a read-only shared mapping of a file which the application had 
> > > open for read-write when it mmapped: the page must be mapped to disk 
> > > at read fault time (because the mapping just might be mprotected for 
> > > read-write later on, and the page then dirtied). 
> > 
> > Can't the page be mapped to disk at the page-dirtying-fault time? I 
> > was under the impression that even after the mapping has been mprotected
> > for read-write, the first write to each page will still cause a page
> > fault that results in the page being marked dirty.
> 
> It depends on the history of the mapping.  mprotect() does not fault in
> any new pages, it just changes permissions on page table entries already
> present.  So, if you're talking about a fresh mapping, or an area of a
> mapping which has not yet been accessed, you're correct.  And you're
> correct if you're talking about a private mapping (which needs write
> protection to do copy-on-write).  But those aren't cases of concern here.
> 
> In general, there will already be some page table entries present,
> and mprotect() from shared readonly to readwrite currently adds write
> permission to those entries, and no write fault will then occur on
> first write to those pages.  I was suggesting that we'd need to change
> that (to the behaviour you expect) if we were trying to guarantee disk
> space for unbacked dirty pages (without allocating on read fault).
> 
> (I'm referring above to the implementation in Linux 2.4 or 2.5:
> I've not checked other releases or OSes, which could indeed arrange
> permissions so that there's always a page-dirtying fault.)
> 
> Hugh
> 

Hmm.. so how do such pages get marked dirty on architectures that don't
do it in hardware ("most RISC architectures" according to a comment in
memory.c)? Is the entire mapping made dirty when the write permissions
are added?

	- Kevin

