Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272091AbRHVTTa>; Wed, 22 Aug 2001 15:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272088AbRHVTTK>; Wed, 22 Aug 2001 15:19:10 -0400
Received: from ns.ithnet.com ([217.64.64.10]:63749 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S272091AbRHVTTE>;
	Wed, 22 Aug 2001 15:19:04 -0400
Date: Wed, 22 Aug 2001 21:18:49 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Mike Galbraith <mikeg@wen-online.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, phillips@bonn-fries.net
Subject: Re: Memory Problem in 2.4.9 ?
Message-Id: <20010822211849.14a4481a.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.33.0108221752590.542-100000@mikeg.weiden.de>
In-Reply-To: <20010822130106.0c4d4bf1.skraw@ithnet.com>
	<Pine.LNX.4.33.0108221752590.542-100000@mikeg.weiden.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.5.3 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001 19:22:35 +0200 (CEST)
Mike Galbraith <mikeg@wen-online.de> wrote:

> When page is added to to the pagecache, it begins life with age=0 and
> is placed on the inactive_dirty list with use_once.  With the original
> aging, it started with PAGE_AGE_START and was placed on the active
> list.  The intent of used once (correct me Daniel if I fsck up.. haven't
> been able to track vm changes very thoroughly lately [as you can see:])
> is to place a new page in the line of fire of page reclamation and only
> pull it into the active aging scheme if it is referenced again prior to
> consumption.  This is intended to preserve other cached pages in the event
> of streaming IO.  Your cache won't be demolished as quickly, the pages
> which are only used one time will self destruct instead.  Cool idea.

Well, maybe I am completely off the road, but the primary problem seems to be that a whole lot of the pages _look_ like being of the same age, and the algorithm cannot cope with that very well. There is obviously no way out of this problem for the code, and thats basically why it fails to alloc pages with this warning message. So the primary goal should be to refine the algorithm and give it a way to _know_ a way out, and not to _guess_ ("maybe we got some free pages later") or _give up_ on the problem. How about the following (ridiculously simple) approach:
every alloc'ed page gets a "timestamp". If an alloc-request reaches the current "dead point" it simply throws out the oldest x pages of the lowest aging level reachable. This is sort of a garbage-collection idea. It sounds not very fast indeed, but it sounds working, does it?
Best of all, very few changes have to be made to make it work.

Shoot me for this :-)

Regards, Stephan

PS: timestamp could be a simple static int, that is counted up on every successful alloc. Obviously page needs an additional struct member.
