Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751184AbVKJIyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751184AbVKJIyr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 03:54:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVKJIyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 03:54:47 -0500
Received: from ns.ustc.edu.cn ([202.38.64.1]:26290 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1751193AbVKJIyq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 03:54:46 -0500
Date: Thu, 10 Nov 2005 16:55:03 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Re: ext3_readdir() readahead problem
Message-ID: <20051110085503.GC5797@mail.ustc.edu.cn>
Mail-Followup-To: Wu Fengguang <wfg@mail.ustc.edu.cn>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Just in case this piece of message will benefit someone in the mailing list ;)

--gKMricLos+KVdGMg
Content-Type: message/rfc822
Content-Disposition: inline

Return-path: <akpm@osdl.org>
Envelope-to: wfg@localhost
Delivery-date: Thu, 10 Nov 2005 13:25:45 +0800
Received: from localhost ([127.0.0.1] ident=wfg)
	by localhost.localdomain with esmtp (Exim 4.50)
	id 1Ea4wT-00028Q-Px
	for wfg@localhost; Thu, 10 Nov 2005 13:25:45 +0800
Received: from email.ustc.edu.cn [202.38.64.8]
	by localhost with IMAP (fetchmail-6.2.5)
	for wfg@localhost (single-drop); Thu, 10 Nov 2005 13:25:45 +0800 (CST)
Received: (eyou send program); Thu, 10 Nov 2005 13:21:46 +0800
Message-ID: <331600106.28353@ustc.edu.cn>
Received: from unknown (HELO mx1.ustc.edu.cn) (202.38.64.54)
 by 202.38.64.8 with SMTP; Thu, 10 Nov 2005 13:21:46 +0800
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	by mx1.ustc.edu.cn (8.11.6/8.11.6) with ESMTP id jAA5ItD01240
	for <wfg@mail.ustc.edu.cn>; Thu, 10 Nov 2005 13:18:57 +0800
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAA5LHnO019462
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <wfg@mail.ustc.edu.cn>; Wed, 9 Nov 2005 21:21:17 -0800
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id jAA5LGFa002756
	for <wfg@mail.ustc.edu.cn>; Wed, 9 Nov 2005 21:21:16 -0800
Date: Wed, 9 Nov 2005 21:21:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: Re: ext3_readdir() readahead problem
Message-Id: <20051109212106.1a636706.akpm@osdl.org>
In-Reply-To: <20051110041253.GB6084@mail.ustc.edu.cn>
References: <20051109124505.GA5158@mail.ustc.edu.cn>
	<20051109111500.6725b26e.akpm@osdl.org>
	<20051110030115.GB5146@mail.ustc.edu.cn>
	<20051109193458.5d5f8baa.akpm@osdl.org>
	<20051110041253.GB6084@mail.ustc.edu.cn>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36

Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
>
> On Wed, Nov 09, 2005 at 07:34:58PM -0800, Andrew Morton wrote:
> > Wu Fengguang <wfg@mail.ustc.edu.cn> wrote:
> > Ah, OK.  Rather than showing a stream of numbers it really helps if you can
> > tell people what the numbers _mean_.
> Got it. Thanks!
> > > > 

Minor point: your email are mush more readable if you put a blank line
before and after your paragraphs, like this ;)

> > 
> > Part of the page.  If PAGE_CACHE_SIZE=4k and it's a 1k blocksize
> > filesystem, we'll only read 1k from disk.
> So it's one block, or one buffer_head, am I right?

buffer_head is misnamed.  It used to be both a caching concept and an IO
container.  It's still an IO container sometimes, but it really should be
renamed `struct block'.  It is the kernel's core abstraction for a disk
block.  Usually of size <= PAGE_CACHE_SIZE.  There are a few places where
bh->b_size is >PAGE_CACHE_SIZE, in the get_blocks() callback.  But that's
an exception.

A buffer_head is metadata against a struct page, telling us the state of a
subsection of a page, and also telling us the disk mapping (ie:
partition-relative block number) for that page subsection.

> > > suboptimal to let both ext3_readdir() and page_cache_readahead() do some part
> > > of I/O.  The best scheme should be to test page existence and call read-ahead in
> > > the very beginning(maybe before ext3_getblk()).
> > 
> > ext3_getblk() doesn't actually read the block from disk.  All it will do is
> > to determine the location of the block on disk.  Plus if it's a write and
> > if we newly created the block, ext3 will perform journalling of the buffer.
>
> But it inserts the page into radix tree, which effectively prevents
> __do_page_cache_readahead() to read that page, and makes (actual <= req_size-1)
> in the following trace.

erk.   That's pretty screwed up, isn't it?

I need to think again.   Thanks.


--gKMricLos+KVdGMg--
