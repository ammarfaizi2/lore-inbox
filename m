Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964772AbWBKTH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964772AbWBKTH3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 14:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964775AbWBKTH2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 14:07:28 -0500
Received: from pat.uio.no ([129.240.130.16]:58081 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964772AbWBKTH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 14:07:28 -0500
Subject: Re: msync() behaviour broken for MS_ASYNC, revert patch?
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       linux@horizon.com, linux-kernel@vger.kernel.org, sct@redhat.com
In-Reply-To: <Pine.LNX.4.64.0602101507530.19172@g5.osdl.org>
References: <20060209071832.10500.qmail@science.horizon.com>
	 <20060209094815.75041932.akpm@osdl.org> <43EC1BFF.1080808@yahoo.com.au>
	 <20060209211356.6c3a641a.akpm@osdl.org> <43EC24B1.9010104@yahoo.com.au>
	 <20060209215040.0dcb36b1.akpm@osdl.org> <43EC2C9A.7000507@yahoo.com.au>
	 <20060209221324.53089938.akpm@osdl.org> <43EC3326.4080706@yahoo.com.au>
	 <20060209224656.7533ce2b.akpm@osdl.org> <43EC3961.3030904@yahoo.com.au>
	 <Pine.LNX.4.64.0602100759190.19172@g5.osdl.org>
	 <43ECC13F.5080109@yahoo.com.au>
	 <Pine.LNX.4.64.0602100846170.19172@g5.osdl.org>
	 <43ECCF68.3010605@yahoo.com.au>
	 <Pine.LNX.4.64.0602100944280.19172@g5.osdl.org>
	 <43ECDD9B.7090709@yahoo.com.au>
	 <Pine.LNX.4.64.0602101056130.19172@g5.osdl! .org>
	 <43ECF182.9020505@yahoo.com.au>
	 <Pine.LNX.4.64.0602101254081.19172@g5.osdl.org>
	 <1139608513.7877.9.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0602101432400.19172@g5.osdl.org>
	 <1139612574.7877.17.camel@lade.trondhjem.org>
	 <Pine.LNX.4.64.0602101507530.19172@g5.osdl.org>
Content-Type: text/plain
Date: Sat, 11 Feb 2006 14:07:02 -0500
Message-Id: <1139684822.7867.24.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.332, required 12,
	autolearn=disabled, AWL 1.48, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-02-10 at 15:15 -0800, Linus Torvalds wrote:

> > IIRC msync(MS_INVALIDATE) on Solaris was actually often used by some
> > applications to resync the client page cache to the server when using
> > odd locking schemes, so I believe this interpretation is a valid one.
> 
> I think you're right. Although I would also guess that 99% of the time, 
> you'd only do that for read-only mappings. Doing the same in the presense 
> of also doing writes is just asking for getting shot.
> 
> Even for read-only mappings, it's actually quite hard to globally flush a 
> page cache page if somebody else happens to be using it for a read() or 
> something at exactly the same time.

I'm thinking specifically of the case where the application is using
some fancy user space locking scheme of its own to guarantee safe read
access to a part of the file that is known to have changed on the
server.

We do have fadvise(POSIX_FADV_DONTNEED), which gets you most of the way.
However that calls invalidate_mapping_pages(), which only clears
unlocked pages. This again means that kernel activities like readahead
or VM scanning can cause pages the user would otherwise like to eject to
be preserved.

The other alternative is to use O_DIRECT file access, but that forces
the application to handle caching and readahead in user space too.

Cheers,
  Trond

