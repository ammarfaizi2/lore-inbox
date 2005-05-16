Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261215AbVEPBM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbVEPBM0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 May 2005 21:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVEPBM0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 May 2005 21:12:26 -0400
Received: from waste.org ([216.27.176.166]:61313 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261211AbVEPBMQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 May 2005 21:12:16 -0400
Date: Sun, 15 May 2005 18:12:09 -0700
From: Matt Mackall <mpm@selenic.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: "Adam J. Richter" <adam@yggdrasil.com>, pasky@ucw.cz, git@vger.kernel.org,
       linux-kernel@vger.kernel.org, mercurial@selenic.com, torvalds@osdl.org
Subject: Re: Mercurial 0.4e vs git network pull
Message-ID: <20050516011209.GM5914@waste.org>
References: <200505151122.j4FBMJa01073@adam.yggdrasil.com> <20050515173923.GK5914@waste.org> <428793A1.5070004@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <428793A1.5070004@pobox.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2005 at 02:23:29PM -0400, Jeff Garzik wrote:
> Matt Mackall wrote:
> >On Sun, May 15, 2005 at 04:22:19AM -0700, Adam J. Richter wrote:
> >
> >>On Sun, 15 May 2005 10:54:05 +0200, Petr Baudis wrote:
> >>
> >>>Dear diary, on Thu, May 12, 2005 at 10:57:35PM CEST, I got a letter
> >>>where Matt Mackall <mpm@selenic.com> told me that...
> >>>
> >>>>Does this need an HTTP request (and round trip) per object? It appears
> >>>>to. That's 2200 requests/round trips for my 800 patch benchmark.
> >>
> >>>Yes it does. On the other side, it needs no server-side CGI. But I guess
> >>>it should be pretty easy to write some kind of server-side CGI streamer,
> >>>and it would then easily take just a single HTTP request (telling the
> >>>server the commit ID and receiving back all the objects).
> >>
> >>	I don't understand what was wrong with Jeff Garzik's previous
> >>suggestion of using http/1.1 pipelining to coalesce the round trips.
> >
> >
> >You can't do pipelining if you can't look ahead far enough to fill the 
> >pipe.
> 
> Even if you cannot fill a pipeline, HTTP/1.1 is sufficiently useful 
> simply by removing the per-request connection overhead.

Sure. It cuts round trips by a factor of 2. But that's just about all
it does.

Mercurial already does:
  - approximately O(log(new changesets)) requests/data to find new changesets
  - one request to get an entire changegroup (set of all new
    changesets), which comes back all nicely pipelined and sorted by file
  - delta transfer

In "dumb http" mode, ie what's been there since about day three, it
can do:
  - one request (size proportional to total number of changesets) to
    find new changesets
  - approximately two requests per changed file to pull all deltas
    (vs request per file revision)
  - delta transfer

-- 
Mathematics is the supreme nostalgia of our time.
