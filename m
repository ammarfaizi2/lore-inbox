Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317755AbSHZBh1>; Sun, 25 Aug 2002 21:37:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317767AbSHZBh0>; Sun, 25 Aug 2002 21:37:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:12562 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317755AbSHZBh0>;
	Sun, 25 Aug 2002 21:37:26 -0400
Message-ID: <3D6989F7.9ED1948A@zip.com.au>
Date: Sun, 25 Aug 2002 18:52:55 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: MM patches against 2.5.31
References: <3D644C70.6D100EA5@zip.com.au> <20020822112806.28099.qmail@thales.mathematik.uni-ulm.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Ehrhardt wrote:
> 
> On Wed, Aug 21, 2002 at 07:29:04PM -0700, Andrew Morton wrote:
> >
> > I've uploaded a rollup of pending fixes and feature work
> > against 2.5.31 to
> >
> > http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.31/2.5.31-mm1/
> >
> > The rolled up patch there is suitable for ongoing testing and
> > development.  The individual patches are in the broken-out/
> > directory and should all be documented.
> 
> Sorry, but we still have the page release race in multiple places.
> Look at the following (page starts with page_count == 1):
> 

So we do.  It's a hugely improbable race, so there's no huge rush
to fix it.  Looks like the same race is present in -ac kernels,
actually, if add_to_swap() fails.  Also perhaps 2.4 is exposed if
swap_writepage() is synchronous, and page reclaim races with 
zap_page_range.  ho-hum.


What I'm inclined to do there is to change __page_cache_release()
to not attempt to free the page at all.  Just let it sit on the
LRU until page reclaim encounters it.  With the anon-free-via-pagevec
patch, very, very, very few pages actually get their final release in
__page_cache_release() - zero on uniprocessor, I expect.

And change pagevec_release() to take the LRU lock before dropping
the refcount on the pages.

That means there will need to be two flavours of pagevec_release():
one which expects the pages to become freeable (and takes the LRU
lock in anticipation of this).  And one which doesn't expect the
pages to become freeable.  The latter will leave the occasional
zero-count page on the LRU, as above.

Sound sane?
