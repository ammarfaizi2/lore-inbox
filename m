Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314885AbSFOIKe>; Sat, 15 Jun 2002 04:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315119AbSFOIKd>; Sat, 15 Jun 2002 04:10:33 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:22797 "EHLO
	svldns02.veritas.com") by vger.kernel.org with ESMTP
	id <S314885AbSFOIKd>; Sat, 15 Jun 2002 04:10:33 -0400
Date: Sat, 15 Jun 2002 09:10:20 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
To: Kevin Easton <s3159795@student.anu.edu.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.18 no timestamp update on modified mmapped files
In-Reply-To: <20020615152443.A22396@beernut.flames.org.au>
Message-ID: <Pine.LNX.4.21.0206150830190.1185-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 15 Jun 2002, Kevin Easton wrote:
> On Wed, 12 Jun 2002, Hugh Dickins wrote:
> > 
> > But you didn't spell out the worst news on that option: read faults 
> > into a read-only shared mapping of a file which the application had 
> > open for read-write when it mmapped: the page must be mapped to disk 
> > at read fault time (because the mapping just might be mprotected for 
> > read-write later on, and the page then dirtied). 
> 
> Can't the page be mapped to disk at the page-dirtying-fault time? I 
> was under the impression that even after the mapping has been mprotected
> for read-write, the first write to each page will still cause a page
> fault that results in the page being marked dirty.

It depends on the history of the mapping.  mprotect() does not fault in
any new pages, it just changes permissions on page table entries already
present.  So, if you're talking about a fresh mapping, or an area of a
mapping which has not yet been accessed, you're correct.  And you're
correct if you're talking about a private mapping (which needs write
protection to do copy-on-write).  But those aren't cases of concern here.

In general, there will already be some page table entries present,
and mprotect() from shared readonly to readwrite currently adds write
permission to those entries, and no write fault will then occur on
first write to those pages.  I was suggesting that we'd need to change
that (to the behaviour you expect) if we were trying to guarantee disk
space for unbacked dirty pages (without allocating on read fault).

(I'm referring above to the implementation in Linux 2.4 or 2.5:
I've not checked other releases or OSes, which could indeed arrange
permissions so that there's always a page-dirtying fault.)

Hugh

