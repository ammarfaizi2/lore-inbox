Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316842AbSIJUyy>; Tue, 10 Sep 2002 16:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318116AbSIJUyx>; Tue, 10 Sep 2002 16:54:53 -0400
Received: from dsl-213-023-020-046.arcor-ip.net ([213.23.20.46]:39383 "EHLO
	starship") by vger.kernel.org with ESMTP id <S316842AbSIJUyw>;
	Tue, 10 Sep 2002 16:54:52 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Chuck Lever <cel@citi.umich.edu>
Subject: Re: invalidate_inode_pages in 2.5.32/3
Date: Tue, 10 Sep 2002 22:52:17 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@digeo.com>, Rik van Riel <riel@conectiva.com.br>,
       <trond.myklebust@fys.uio.no>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.BSO.4.33.0209101412300.5368-100000@citi.umich.edu>
In-Reply-To: <Pine.BSO.4.33.0209101412300.5368-100000@citi.umich.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17orzf-0007Gn-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 September 2002 21:04, Chuck Lever wrote:
> today, dirty mmap'd pages are passed to the NFS client via the writepage
> address space operation.  what more needs to be done here?  is there a
> mechanism today to tell the VM layer to "call writepage for all dirty
> mmap'd pages?"

Well, Andrew has cooked up something that seems to be headed in that
direction, mpage_writepages and various associated superstructure, but
it does not apparently walk all the ptes to check the dirty bits before
it flushes the dirty pages, which is what you want, I think.  It would
not be hard to teach it that trick, it's another thing made easy by
rmap.

Then, after that's done, what kind of semantics have we got?  Perhaps
it's worth being able to guarantee that when a program says 'get all
the dirty memory here out onto disk' it actually happens, even though
there is no built-in way to be sure that some unsychronized task
won't come along and dirty the mmap again immediately.  You could look
at the need for synchronization there as an application issue.  On the
other hand, if the NFS client is taking the liberty of flushing the
dirty memory on behalf of the mmap users, what guarantee is provided?
IMHO, none, so is this really worth it for the NFS client to do this?

It does make sense that fsync should really get all the dirty pages
onto disk (err, or onto the server) and not come back until its done,
and that 'dirty pages' should include dirty ptes, not just pages that
happen to have been scanned and had their dirty bits moved from the
pte to the struct page.

Andrew, did I miss something, or does the current code really ignore
the pte dirty bits?

-- 
Daniel
