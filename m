Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261624AbSJJP23>; Thu, 10 Oct 2002 11:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261626AbSJJP23>; Thu, 10 Oct 2002 11:28:29 -0400
Received: from packet.digeo.com ([12.110.80.53]:50860 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261624AbSJJP22>;
	Thu, 10 Oct 2002 11:28:28 -0400
Message-ID: <3DA59DED.6167C13B@digeo.com>
Date: Thu, 10 Oct 2002 08:34:05 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.41 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: andersen@codepoet.org, Jamie Lokier <lk@tantalophile.demon.co.uk>,
       Mark Mielke <mark@mark.mielke.cc>,
       Giuliano Pochini <pochini@denise.shiny.it>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: O_STREAMING has insufficient info - how about fadvise() ?
References: <20021010032950.GA11683@codepoet.org> <1034249932.2044.128.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2002 15:34:05.0545 (UTC) FILETIME=[77A17D90:01C27072]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> ...
> Instead of O_STREAMING therefore I'd much prefer to have
> 
>         fadvise(filehandle, offset, length, FADV_DONTNEED);

fadvise would make some sense - nice that it's a standardised interface.

It isn't really implementable in 2.4, because of that "offset, length"
thing.  We either have to do a pagecache probe for each page, which
gets painful if the user asked for 10,000,000 pages or we do a
pagelist walk which is painful if the user asked for one page.

In 2.5, the radix tree gang lookup thing will do this search in O(zilch).

The other problem with fadvise is writebehind - there are up to
30 seconds' worth of dirty pages behind the application's write
cursor which fadvise wouldn't be able to do anything with.  So
the application would end up running fadvise(offset=0, length=current-pos)
all the time.   Which is equivalent to O_STREAMING.
 

dropbehind cannot work as effectively because we're basically forced
to put the pages at the head of the inactive LRU and hope that they're
written before they reach the tail.  By which time we've evicted
all the other pagecache on the inactive list.

Could put the pages at the _tail_ of the LRU for reads; but that's
equivalent to just reclaiming them on the spot.  Which is equivalent
to O_STREAMING.
