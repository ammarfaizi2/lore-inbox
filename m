Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318109AbSHKSym>; Sun, 11 Aug 2002 14:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318121AbSHKSym>; Sun, 11 Aug 2002 14:54:42 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:42254 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318109AbSHKSyk>; Sun, 11 Aug 2002 14:54:40 -0400
Date: Sun, 11 Aug 2002 12:00:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@arcor.de>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
In-Reply-To: <E17dndv-0001ei-00@starship>
Message-ID: <Pine.LNX.4.44.0208111155460.9930-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Aug 2002, Daniel Phillips wrote:

> On Sunday 11 August 2002 00:42, Linus Torvalds wrote:
> > For example, what do you do when somebody has a COW-page mapped into it's
> > VM space and you want to start paging stuff out?
> 
> Clearly it requires a CoW break and swapping out that page won't free any 
> memory directly, but it will in turn allow the cache page to be dropped.

Well, that's the point. Is it really "clearly"?

One alternative is to just instead remove it from the page cache, and add 
it to the swap cache directly (and unmapping it). In fact, I _think_ that 
is the right thing to do (yes, it only works if the page count is 2 (one 
for page cache, one for the VM mapping), but that's very different from 
breaking the COW and generating two separate pages.

The "move directly to swap cache" is nice in that it doesn't add any new
pages. But it's nasty in that it steals pages from the file cache, so that
it basically turns a potentially sharable cache into a private cache that
nobody else will see.

See? You actually _do_ have choices on what to do.

			Linus

