Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271842AbRH0SsQ>; Mon, 27 Aug 2001 14:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271841AbRH0SsG>; Mon, 27 Aug 2001 14:48:06 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:17924 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S271840AbRH0SsA>; Mon, 27 Aug 2001 14:48:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: [resent PATCH] Re: very slow parallel read performance
Date: Mon, 27 Aug 2001 20:54:48 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Helge Hafting <helgehaf@idb.hist.no>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108270953090.8450-100000@dlang.diginsite.com>
In-Reply-To: <Pine.LNX.4.33.0108270953090.8450-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010827184809Z16070-32383+1677@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On August 27, 2001 06:55 pm, David Lang wrote:
> with you moving things to the inactive queue both when they are used and
> when they spillover from the readahead queue I think you end up putting to
> much preasure on the inactive queue.

Note: the whole point is to avoid having the readahead queue spill over, by 
throttling readahead.  So the readahead queue should only need to be culled 
due to a rise in page activations, enlarging the active list, and requiring 
the system to rebalance itself.  I don't think you can really talk about 
pressure being exerted on the inactive queue by the readahead queue.  The 
size of the inactive queue doesn't really matter as long as it isn't too 
short to provide a good test of short-term page activity.  (If it gets very 
long then it will automatically shorten itself because the probability of a 
given page on the queue being referenced and rescued goes up.)

> given that the readahead queue will fill almost all memory when things
> start spilling off of it you are needing to free memory, so if you just
> put it on the inactive queue you then have to free an equivalent amount of
> space from the inactive queue to actually make any progress on freeing
> space.

Sure, there is an argument for stripping buffers immediately from culled 
readahead pages and moving them straight to the inactive_clean list instead 
of the inactive_dirty list.  In effect, culled readahead pages would then 
rank below aged-to-zero and used-once pages.  It's too subtle a difference 
for me to see any clear advantage one way or the other.  Doing it your way 
would save one queue-move in the lifetime of every culled readahead page.

--
Daniel
