Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317802AbSGPImU>; Tue, 16 Jul 2002 04:42:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317803AbSGPImU>; Tue, 16 Jul 2002 04:42:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51979 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317802AbSGPImS>;
	Tue, 16 Jul 2002 04:42:18 -0400
Message-ID: <3D33DED8.C5C92C06@zip.com.au>
Date: Tue, 16 Jul 2002 01:52:40 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] loop.c oopses
References: <20020716062453.GK1022@holomorphy.com> <3D33C64A.7491B591@zip.com.au> <20020716083142.GQ811@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> On Tue, Jul 16 2002, Andrew Morton wrote:
> > William Lee Irwin III wrote:
> > >
> > > loop.c oopses when bio_copy() returns NULL. This was encountered while
> > > running dbench 16 on a loopback-mounted reiserfs filesystem.
> >
> > ugh.  GFP_NOIO is evil.  I guess it's better to add __GFP_HIGH
> > there, but it's not a happy solution.
> 
> GFP_NOIO has __GFP_WAIT set, so bio_copy -> bio_alloc -> mempool_alloc
> should never fail. Puzzled.
> 

Presumably the loop driver was called from within shrink_cache(),
as PF_MEMALLOC.  Those allocations can fail.

That's maybe wrong - if there are a decent number of pages
under writeback then we should be able to just wait it out.
But it gets tricky with the loop driver...

-
