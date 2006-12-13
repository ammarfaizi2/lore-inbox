Return-Path: <linux-kernel-owner+w=401wt.eu-S964905AbWLMMWL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbWLMMWL (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 07:22:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964904AbWLMMWK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 07:22:10 -0500
Received: from pat.uio.no ([129.240.10.15]:54747 "EHLO pat.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964896AbWLMMWJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 07:22:09 -0500
Subject: Re: Status of buffered write path (deadlock fixes)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Mark Fasheh <mark.fasheh@oracle.com>,
       Linux Memory Management <linux-mm@kvack.org>,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@google.com>
In-Reply-To: <457F7B90.5000900@yahoo.com.au>
References: <45751712.80301@yahoo.com.au>
	 <20061207195518.GG4497@ca-server1.us.oracle.com>
	 <4578DBCA.30604@yahoo.com.au>
	 <20061208234852.GI4497@ca-server1.us.oracle.com>
	 <457D20AE.6040107@yahoo.com.au> <457D7EBA.7070005@yahoo.com.au>
	 <20061212223109.GG6831@ca-server1.us.oracle.com>
	 <457F4EEE.9000601@yahoo.com.au>
	 <1165974458.5695.17.camel@lade.trondhjem.org>
	 <457F5DD8.3090909@yahoo.com.au>
	 <1165977064.5695.38.camel@lade.trondhjem.org>
	 <457F7B90.5000900@yahoo.com.au>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 07:21:50 -0500
Message-Id: <1166012510.5695.15.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.328, required 12,
	autolearn=disabled, AWL 1.53, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 15:03 +1100, Nick Piggin wrote:
> Trond Myklebust wrote:
> > On Wed, 2006-12-13 at 12:56 +1100, Nick Piggin wrote:
> > 
> >>Note that these pages should be *really* rare. Definitely even for normal
> >>filesystems I think RMW would use too much bandwidth if it were required
> >>for any significant number of writes.
> > 
> > 
> > If file "foo" exists on the server, and contains data, then something
> > like
> > 
> > fd = open("foo", O_WRONLY);
> > write(fd, "1", 1);
> > 
> > should never need to trigger a read. That's a fairly common workload
> > when you think about it (happens all the time in apps that do random
> > write).
> 
> Right. What I'm currently looking at doing in that case is two copies,
> first into a temporary buffer. Unfortunate, but we'll see what the
> performance looks like.

Yech.

> >>I don't want to mandate anything just yet, so I'm just going through our
> >>options. The first two options (remove, and RMW) are probably trickier
> >>than they need to be, given the 3rd option available (temp buffer). Given
> >>your input, I'm increasingly thinking that the best course of action would
> >>be to fix this with the temp buffer and look at improving that later if it
> >>causes a noticable slowdown.
> > 
> > 
> > What is the generic problem you are trying to resolve? I saw something
> > fly by about a reader filling the !uptodate page while the writer is
> > updating it: how is that going to happen if the writer has the page
> > locked?
> 
> The problem is that you can't take a pagefault while holding the page
> lock. You can deadlock against another page, the same page, or the
> mmap_sem.
> 
> > AFAIK the only thing that can modify the page if it is locked (aside
> > from the process that has locked it) is a process that has the page
> > mmapped(). However mmapped pages are always uptodate, right?
> 
> That's right (modulo the pagefault vs invalidate race bug).
> 
> But we need to unlock the destination page in order to be able to take
> a pagefault to bring the source user memory uptodate. If the page is
> not uptodate, then a read might see uninitialised data.

The NFS read code will automatically flush dirty data to disk if it sees
that the page is marked as dirty or partially dirty. We do this without
losing the page lock thanks to the helper function nfs_wb_page().

BTW: We will do the same thing in our mapping->release_page() in order
to fix the races you can have between invalidate_inode_pages2() and page
dirtying, however that call to test_and_clear_page_dirty() screws us
over for the case of mmapped files (although we're quite safe w.r.t.
prepare_write()/commit_write()).

Cheers
  Trond

