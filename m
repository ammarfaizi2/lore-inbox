Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbUKOGIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbUKOGIK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 01:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbUKOGIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 01:08:10 -0500
Received: from almesberger.net ([63.105.73.238]:12294 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id S261513AbUKOGIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 01:08:05 -0500
Date: Mon, 15 Nov 2004 03:07:50 -0300
From: Werner Almesberger <werner@almesberger.net>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Rajesh Venkatasubramanian <vrajesh@umich.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Generalize prio_tree (1/3)
Message-ID: <20041115030750.L28802@almesberger.net>
References: <20041114235646.K28802@almesberger.net> <419830FD.7000007@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419830FD.7000007@yahoo.com.au>; from nickpiggin@yahoo.com.au on Mon, Nov 15, 2004 at 03:30:53PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:
> I'm curious, how do you plan to use them for healthier barrier handling?

Ah, you missed the great discussion on fsdevel and the BOF
at OLS :-)

http://marc.theaimsgroup.com/?t=108787649700005&r=1&w=2&n=34
http://marc.theaimsgroup.com/?t=108809650200006&r=1&w=2&n=11
http://marc.theaimsgroup.com/?l=linux-fsdevel&m=109107082406140&w=2

This comes from prioritization of requests at the elevator.
In order to honor priorities as much as possible, we need to
keep barriers from affecting all requests in the queue.

The idea is to ignore barriers unless requests separated by a
barrier overlap, and at least one of them is a write. prio_tree
is used to find those overlaps.

That way, priorities are only affected by barriers if using
some form of direct IO, with overlaps and writes. While this
isn't perfect (i.e. someone else scribbling over our files can
still spoil all the fun), it allows a much larger class of
applications to enjoy the full benefits of priorities.

Besides that, it also helps the elevator to do a better job for
requests even without priorities, because it doesn't have to go
FIFO whenever it sees a barrier.

See also section 3.6 of
http://abiss.sourceforge.net/doc/abiss-lk.ps.gz

The CPU overhead is actually quite marginal: in tests, the ABISS
elevator would actually outperform AS in terms of CPU time
spent (measured by sending a lot of random requests with AIO
into a large queue). While such tests compare apples and oranges,
they at least indicate that minimalizing the effect of barriers
doesn't have a horrible performance impact.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina     werner@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
