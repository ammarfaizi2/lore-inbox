Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264803AbSJVTRm>; Tue, 22 Oct 2002 15:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264795AbSJVTRm>; Tue, 22 Oct 2002 15:17:42 -0400
Received: from packet.digeo.com ([12.110.80.53]:26561 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264803AbSJVTRk>;
	Tue, 22 Oct 2002 15:17:40 -0400
Message-ID: <3DB5A5BD.D3E00B4A@digeo.com>
Date: Tue, 22 Oct 2002 12:23:41 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [patch] generic nonlinear mappings, 2.5.44-mm2-D0
References: <Pine.LNX.4.44.0210221936010.18790-100000@localhost.localdomain> <20021022184938.A2395@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Oct 2002 19:23:41.0889 (UTC) FILETIME=[87EDC310:01C27A00]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> 
> On Tue, Oct 22, 2002 at 07:57:00PM +0200, Ingo Molnar wrote:
> > the attached patch (ontop of 2.5.44-mm2) implements generic (swappable!)
> > nonlinear mappings and sys_remap_file_pages() support. Ie. no more
> > MAP_LOCKED restrictions and strange pagefault semantics.
> >
> > to implement this i added a new pte concept: "file pte's". This means that
> > upon swapout, shared-named mappings do not get cleared but get converted
> > into file pte's, which can then be decoded by the pagefault path and can
> > be looked up in the pagecache.
> >
> > the normal linear pagefault path from now on does not assume linearity and
> > decodes the offset in the pte. This also tests pte encoding/decoding in
> > the pagecache case, and the ->populate functions.
> 
> Ingo,
> 
> what is the reason for that interface?  It looks like a gross performance
> hack for misdesigned applications to me, kindof windowsish..
> 

So that evicted pages in non-linear mappings can be reestablished
at fault time by the kernel, rather than by delegation to userspace
via SIGBUS.


We seem to have lost a pte_page_unlock() from fremap.c:zap_pte()?
I fixed up the ifdef tangle in there within the shpte-ng patch
and then put the pte_page_unlock() back.

I also added a page_cache_release() to the error path in filemap_populate(),
if install_page() failed.

The 2TB file size limit for mmap on non-PAE is a little worrisome.
I wonder if we can only instantiate the pte_file() bit if the
mapping is using MAP_POPULATE?  Seems hard to do.
