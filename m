Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318076AbSIESe5>; Thu, 5 Sep 2002 14:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318080AbSIESe5>; Thu, 5 Sep 2002 14:34:57 -0400
Received: from dsl-213-023-039-222.arcor-ip.net ([213.23.39.222]:36776 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318076AbSIESez>;
	Thu, 5 Sep 2002 14:34:55 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Re: Race in shrink_cache
Date: Thu, 5 Sep 2002 20:41:36 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <E17mooe-00064m-00@starship> <E17mr4K-000660-00@starship> <3D770D77.BF85645E@zip.com.au>
In-Reply-To: <3D770D77.BF85645E@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17n1ZQ-00069v-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 September 2002 09:53, Andrew Morton wrote:
> Not having to bump page counts when moving pages from the LRU into a private
> list would be nice.

I'm not sure what your intended application is here.  It's easy enough to 
change the lru state bit to a scalar, the transitions of which are protected 
naturally by the lru lock.  This gives you N partitions of the lru list 
(times M zones) and page_cache_release does the right thing for all of them.

On the other hand, if what you want is a private list that page_cache_release 
doesn't act on automatically, all you have to do is set the lru state to zero,
leave the page count incremented and move to the private list.  You then take
explicit responsibility for freeing the page or moving it back onto a 
mainstream lru list.

An example of an application of the latter technique is a short delay list to 
(finally) implement the use-once concept properly.  A newly instantiated page 
goes onto the hot end of this list instead of the inactive list as it does 
now, and after a short delay dependent on the allocation activity in the 
system, is moved either to the (per zone) active or inactive list, depending 
on whether it was referenced.  Thus the use-once list is not per-zone and 
removal from it is always explicit.  So it's not like the other lru lists, 
even though it uses the same link field.

While I'm meandering here, I'll mention that the above approach finally makes 
use-once work properly for swap pages, which always had the problem that we 
couldn't detect the second, activating reference (and this was fudged by 
always marking a swapped-in page as referenced, i.e., kludging away the 
mechanism).  It also solves the problem of detecting clustered references, 
such as reading through a page a byte at a time, which should only count as a 
single reference.  Right now we do a stupid hack that works in a lot of 
cases, but fails in enough cases to be annoying, all in the name of trying to 
get by without implementing a dedicated list.

Readahead on the other hand needs to be handled with dedicated per-zone lru 
lists, so that we can conveniently and accurately claw back readahead that 
happens to have gone too far ahead.  So this is an example of the first kind 
of usage.  Once read, a readahead page moves to the used-once queue, and from 
there either to the inactive or active queue as above.

-- 
Daniel
