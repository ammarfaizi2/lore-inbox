Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269632AbRHUDqE>; Mon, 20 Aug 2001 23:46:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269920AbRHUDpz>; Mon, 20 Aug 2001 23:45:55 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:45839 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S269632AbRHUDpn>; Mon, 20 Aug 2001 23:45:43 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: 2.4.8/2.4.9 VM problems
Date: Tue, 21 Aug 2001 05:51:39 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Mike Galbraith <mikeg@wen-online.de>,
        Frank Dekervel <Frank.dekervel@student.kuleuven.ac.Be>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0108202247090.5646-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0108202247090.5646-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010821034550Z16007-32383+621@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 21, 2001 03:55 am, Rik van Riel wrote:
> The TARGET SIZE for the inactive_dirty list is 1 second
> of pageout activity. This means that with the use-once
> scheme read-ahead pages have at most 1 second to be used
> while the system is under pressure.
> 
> This is not enough.  With disks being able to do at most
> 100 reads a second (7ms seek, 3ms rotational) you'll have
> limited the system to 100 threads of streaming IO at
> maximum, assuming that the readahead window is limited to
> 1 second worth of data.
> 
> This may seem a lot, but don't worry because the readahead
> window ISN'T limited to 1 second worth of data. Think an
> FTP server serving 10kB/second to each client with readahead
> expanding to the standard 128kB maximum.
> 
> This means that at any point we'll have evicted 90% of the
> still unused readahead pages, leading to heavy thrashing of
> the readahead window and reducing the maximum load supported
> by the system a full _10_ FTP clients!

I have to admit, the 100 FTP clients case wasn't on the top of my mind.  Even 
so, think about what is really happening.  Nothing is getting activated and 
nothing is competing with these allocations so you can just let the inactive 
list grow until it holds a large fraction of the physical pages.  FIFO isn't 
such a bad model for this situation, and that's exactly what will fall out.

Assuming that some of the files are more popular than others, these file 
pages will be touched more than once and will go onto the active ring, also 
exactly what you want.  As they get old they get fed into the inactive queue 
at a rate that's tunable.  I don't see what the problem is.

There are a couple of simple improvements that can be made.  We could mark 
all new pages referenced, age=1 (to distinguish from aged-to-zero pages).  We 
would not do unlazy activation but just allow age to increment with each 
touch.  Then, in addition to the Referenced test, we would test the age 
against a tunable threshold to decide which pages to rescue.  You can see 
that this would take care of your 100 streaming clients case nicely, while 
not negatively affecting the cases that are already working well.

A second simple improvement is to have separate activation and deactivation 
queues.  This allows you to tune the rate at which pages are pulled from the 
activation queue (these would be the streaming IO pages) against pages culled 
from the active list.  I can't think of any downside at all for doing this, 
except that it's not something I'd consider appropriate for the 2.4 series.

> [...] you haven't yet made any
> proposal on how to make the rest of the VM interact nicely
> with the use-once idea, preventing things like the thrashing
> of the readahead window, etc...

This is hypothetical thrashing so far, have you see it in the wild?

--
Daniel
