Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261677AbSJJQoS>; Thu, 10 Oct 2002 12:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261659AbSJJQoQ>; Thu, 10 Oct 2002 12:44:16 -0400
Received: from waste.org ([209.173.204.2]:11467 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S261664AbSJJQoP>;
	Thu, 10 Oct 2002 12:44:15 -0400
Date: Thu, 10 Oct 2002 11:49:17 -0500
From: Oliver Xymoron <oxymoron@waste.org>
To: Andrew Morton <akpm@digeo.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, andersen@codepoet.org,
       Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Mark Mielke <mark@mark.mielke.cc>,
       Giuliano Pochini <pochini@denise.shiny.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_STREAMING has insufficient info - how about fadvise() ?
Message-ID: <20021010164916.GO21400@waste.org>
References: <20021010032950.GA11683@codepoet.org> <1034249932.2044.128.camel@irongate.swansea.linux.org.uk> <3DA59DED.6167C13B@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DA59DED.6167C13B@digeo.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 10, 2002 at 08:34:05AM -0700, Andrew Morton wrote:
> 
> dropbehind cannot work as effectively because we're basically forced
> to put the pages at the head of the inactive LRU and hope that they're
> written before they reach the tail.  By which time we've evicted
> all the other pagecache on the inactive list.

Seems like we're not keeping enough information. Perhaps we could have
something like "streaming rank" at the mapping level and use that as a
hint to prioritize evictions or possibly where to insert in the LRU.
Throw new mappings at the streaming end of the rank list and whenever
they fault behind the r/w pointer, swap them upwards in the list.

If you're playing an MP3, it starts out at the streaming end of the
list and starts dropping pages at the first sign of pressure. Since
this really is streaming, no problem.

Now run Mozilla, which starts out behind the MP3, seeks around
randomly paging in code (which looks like fault behind), says "um,
excused me", and bumps ahead of the MP3..

Let Mozilla idle, start OpenOffice, which bumps in front of the MP3,
and if it hits more pressure, bumps in front of the idling Mozilla as
well.

Then updatedb starts, reads a ton of files in a streaming fashion, but
none of those streaming file mappings push above the idling apps.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
