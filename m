Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318148AbSIEV0p>; Thu, 5 Sep 2002 17:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318152AbSIEV0p>; Thu, 5 Sep 2002 17:26:45 -0400
Received: from pat.uio.no ([129.240.130.16]:58304 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id <S318148AbSIEV0o>;
	Thu, 5 Sep 2002 17:26:44 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15735.52512.886434.46650@charged.uio.no>
Date: Thu, 5 Sep 2002 23:31:12 +0200
To: Andrew Morton <akpm@zip.com.au>
Cc: Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <3D77C8B7.1534A2DB@zip.com.au>
References: <3D77C0A7.F74A89D0@zip.com.au>
	<15735.50124.304510.10612@charged.uio.no>
	<3D77C8B7.1534A2DB@zip.com.au>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@zip.com.au> writes:

    >> 'rpciod' process by means of a callback. Since 'rpciod' is
    >> responsible for completing all asynchronous I/O, then
    >> truncate_inode_pages() would deadlock.

     > But if there are such pages, invalidate_inode_pages() would not
     > have removed them anyway?

It should not have to. If the page is locked because it is being paged
in, then we're guaranteed that the data is fresh from the server. If
it is locked because we are writing, then ditto.

     > Trond, there are very good reasons why it broke.  Those pages
     > are visible to the whole world via global data structures -
     > both the page LRUs and via the superblocks->inodes walk.  Those
     > things exist for legitimate purposes, and it is legitimate for
     > async threads of control to take a reference on those pages
     > while playing with them.

I don't buy that explanation w.r.t. readdir: those pages should always
be clean. The global data structures might walk them in order to throw
them out, but that should be a bonus here.
In any case it seems a bit far fetched that they should be pinning
*all* the readdir pages...

     > I suspect we can just remove the page_count() test from
     > invalidate and that will fix everything up.  That will give
     > stronger invalidate and anything which doesn't like that is
     > probably buggy wrt truncate anyway.

I never liked the page_count() test, but Linus overruled me because of
the concern for consistency w.r.t. shared mmap(). Is the latter case
resolved now?

I notice for instance that you've added mapping->releasepage().
What should we be doing for that?

Cheers,
  Trond
