Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318292AbSIEUq6>; Thu, 5 Sep 2002 16:46:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318293AbSIEUq6>; Thu, 5 Sep 2002 16:46:58 -0400
Received: from mons.uio.no ([129.240.130.14]:22494 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S318292AbSIEUq5>;
	Thu, 5 Sep 2002 16:46:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15735.50124.304510.10612@charged.uio.no>
Date: Thu, 5 Sep 2002 22:51:24 +0200
To: Andrew Morton <akpm@zip.com.au>
Cc: Chuck Lever <cel@citi.umich.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: invalidate_inode_pages in 2.5.32/3
In-Reply-To: <3D77C0A7.F74A89D0@zip.com.au>
References: <3D77BB7C.5F20939F@zip.com.au>
	<15735.48664.951983.418842@charged.uio.no>
	<3D77C0A7.F74A89D0@zip.com.au>
X-Mailer: VM 7.00 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Andrew Morton <akpm@zip.com.au> writes:

     > Probably, it worked OK with the global locking because nobody
     > was taking a temp ref against those pages.

But we still have global locking in that readdir by means of the
BKL. There should be no nasty races...

     > Please tell me exactly what semantics NFS needs in there.  Does
     > truncate_inode_pages() do the wrong thing?

Definitely. In most cases we *cannot* wait on I/O completion because
nfs_zap_caches() can be called directly from the 'rpciod' process by
means of a callback. Since 'rpciod' is responsible for completing all
asynchronous I/O, then truncate_inode_pages() would deadlock.

As I said: I don't believe the problem here has anything to do with
invalidate_inode_pages vs. truncate_inode_pages:
  - Pages should only be locked if they are actually being read from
    the server.
  - They should only be refcounted and/or cleared while the BKL is
    held...
There is no reason why code which worked fine under 2.2.x and 2.4.x
shouldn't work under 2.5.x.

Cheers,
  Trond
