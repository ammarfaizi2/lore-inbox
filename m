Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319056AbSH1XNt>; Wed, 28 Aug 2002 19:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319059AbSH1XNs>; Wed, 28 Aug 2002 19:13:48 -0400
Received: from dsl-213-023-022-149.arcor-ip.net ([213.23.22.149]:4045 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319056AbSH1XMk>;
	Wed, 28 Aug 2002 19:12:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: MM patches against 2.5.31
Date: Thu, 29 Aug 2002 00:57:06 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3D644C70.6D100EA5@zip.com.au> <E17kAvf-0002tx-00@starship> <3D6D5128.9EE6DFDD@zip.com.au>
In-Reply-To: <3D6D5128.9EE6DFDD@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17kBkK-0002uI-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 August 2002 00:39, Andrew Morton wrote:
> Daniel Phillips wrote:
> > 
> > ...
> > So there's no question that the race is lurking in 2.4.  I noticed several
> > more paths besides the one above that look suspicious as well.  The bottom
> > line is, 2.4 needs a fix along the lines of my suggestion or Christian's,
> > something that can actually be proved.
> > 
> > It's a wonder that this problem manifests so rarely in practice.
> 
> I sort-of glanced through the 2.4 paths and it appears that in all of the
> places where it could do a page_cache_get/release, that would never happen
> because of other parts of the page state.
> 
> Like: it can't be in pagecache, so we won't run writepage, and
> it can't have buffers, so we won't run try_to_release_page().
> 
> Of course, I might have missed a path.  And, well, generally: ugh.

I think it is happening.  I just went sifting searching through the archives
on 'oops' and '2.4'.  The first one I found was:

   2.4.18-xfs (xfs related?) oops report

which fits the description nicely.

The race I showed actually causes the page->count to go negative, avoiding
a double free on a technicality.  That doesn't make me feel much better about
it.  Have you got a BUG_ON(!page_count(page)) in put_page_testzero?  I think
we might see some action.

-- 
Daniel
