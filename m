Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314284AbSGQTv4>; Wed, 17 Jul 2002 15:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316604AbSGQTv4>; Wed, 17 Jul 2002 15:51:56 -0400
Received: from dsl-213-023-038-064.arcor-ip.net ([213.23.38.64]:31934 "EHLO
	starship") by vger.kernel.org with ESMTP id <S314284AbSGQTvz>;
	Wed, 17 Jul 2002 15:51:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: [patch 1/13] minimal rmap
Date: Wed, 17 Jul 2002 21:55:41 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L.0207171639480.12241-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0207171639480.12241-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17Uuti-0004PT-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 July 2002 21:41, Rik van Riel wrote:
> On Wed, 17 Jul 2002, Daniel Phillips wrote:
> > On Wednesday 17 July 2002 21:31, Rik van Riel wrote:
> > > On Wed, 17 Jul 2002, Daniel Phillips wrote:
> > > > On Wednesday 17 July 2002 07:29, Andrew Morton wrote:
> > > > > 11: The nightly updatedb run is still evicting everything.
> > > >
> > > > That is not a problem with rmap per se, it's a result of not properly
> > > > handling streaming IO.
> > >
> > > Umm, updatedb isn't exactly streaming...
> >
> > You're right, it's not exactly, it's hitting every directory entry on
>                                                      ^^^^^^^^^^^^^^^
> > the system, hopefully just once.  Let's not call it streaming, let's
> > call it... err... use-once? ;-)
> 
> Nope. If it hits every directory entry once, it'll hit every
> page with directory or inode information multiple times, causing
> that page to enter the active list and push out process pages.
> 
> This is exactly what we want to prevent.

Yes, it could get challenging, but it's very desirable to do the
optimization somehow.  It's even more desirable to stay focussed on
the immediate issues, imho.

Food for thought: readdir actually picks up the entries 4K-worth at a
time, however that's randomly aligned with respect to directory block
boundaries, meaning that most blocks get two hits, which could well be
the problem.

Inode table blocks present a more difficult problem.  It's really hard
to know when to evict them, and just arbitrarily holding them to a
certain percentage of memory isn't nice either.

I think Andrew also mentioned he sees a lot of buffers sitting around
in the morning.  His strip-buffers-immediately hack would kill that
one dead.

-- 
Daniel
