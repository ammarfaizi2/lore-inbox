Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266312AbUFPO17@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266312AbUFPO17 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 10:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266295AbUFPO0y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 10:26:54 -0400
Received: from uni00du.unity.ncsu.edu ([152.1.13.100]:26754 "EHLO
	uni00du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S266298AbUFPOX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 10:23:28 -0400
From: jlnance@unity.ncsu.edu
Date: Wed, 16 Jun 2004 10:15:30 -0400
To: Bill Davidsen <davidsen@tmr.com>
Cc: John Bradford <john@grabjohn.com>, Rik van Riel <riel@redhat.com>,
       Lasse =?unknown-8bit?Q?K=E4rkk=E4inen?= / Tronic 
	<tronic2@sci.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: Some thoughts about cache and swap
Message-ID: <20040616141530.GA4680@ncsu.edu>
References: <Pine.LNX.4.44.0406051935380.29273-100000@chimarrao.boston.redhat.com> <200406060708.i5678PW4000272@81-2-122-30.bradfords.org.uk> <40C76861.4040600@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C76861.4040600@tmr.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 09, 2004 at 03:43:29PM -0400, Bill Davidsen wrote:
> John Bradford wrote:
> >Quote from Rik van Riel <riel@redhat.com>:

> >Is the current system really bad enough to make it worthwhile, though?
> 
> Yes! The current implementation just uses all the memory available, and 
> pushes any programs not actively running out to disk. Click the window 
> and go for coffee. On a small machine that's needed, but for almost any 
> typical usage, desktop or server, pushing out programs to have 3.5GB of 
> buffer instead of 3.0 doesn't help disk performance.

Hi All,

It would be good to make the swap-out code smarter, but it occured
to me this morning that the problem might really be the swap-in code.
If my 120M mozilla process gets paged out and then I click on the window,
whats the best case time required to swap it in.  Isn't it something like
2 seconds?  I dont think we currently get anywhere close to 2 seconds,
though I haven't checked.  I can think of two reasons this might be so,
though I am no expert on the Linux VM code so I would appreciate comments.

First, it may be that we spread the pages of the executable across the
swap space rather than putting them near each other.  This would introduce
a lot of seeks when we paged them back in, and this would certainly slow
us down.

Second, I believe the page-in process is fairly synchronous, something
like this:

    A - app generates a page fault
    B - kernel puts app to sleep and queues page-in
    C - Page in happens and kernel wakes up app

This is good behavior for the normal case where swapping is rare and you
want to drop unneeded pages from the working set.  But it is going to
be slow for the case where we need to page a lot of stuff in.  Does the
kernel try and recognize the case of a swapped out application 'comming
back to life' and try to page large portions of it back in before the
app faults the pages?

Thanks,

Jim
