Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266698AbUAWWKT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 17:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266697AbUAWWKT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 17:10:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:61901 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266698AbUAWWKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 17:10:10 -0500
Date: Fri, 23 Jan 2004 23:10:06 +0100
From: Jens Axboe <axboe@suse.de>
To: Randy Appleton <rappleto@nmu.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unneeded Code Found??
Message-ID: <20040123221006.GS2734@suse.de>
References: <3FFF3931.4030202@nmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FFF3931.4030202@nmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 09 2004, Randy Appleton wrote:
> I have modified the __make_request function in ll_rw_blk.c.
> Now every request for a block off the hard drive is logged.
>                                                                                         
> 
> The function __make_request has code to attempt to merge the current
> block request with some contigious existing request for better
> performance. This merge function keeps a one-entry cache pointing to the
> last block request made.  An attempt is made to merge the current
> request with the last request, and if that is not possible then
> a search of the whole queue is done, looking at merger possibililites.
>                                                                                         
> 
> Looking at the data from my logs, I notice that over 50% of all requests
> can be merged.  However, a merge only ever happens between the
> current request and the previous one.  It never happens between the
> current request and any other request that might be in the queue (for
> more than 50,000 requests examined).
>                                                                                         
> 
> This is true for several test runs, including "daily usage" and doing
> two kernel compiles at the same time.  I have only tested on a
> single-CPU machine.

It gets used, the fact that you don't hit it for your workload(s) is
pretty uninteresting. Try threaded io tests, for instance.

That said, the one-hit cache is pretty effective since a process usually
gets to submit more than one request at the time (which is why it's
there). In 2.6 merges aren't as important anymore due to large io
submissions. You didn't say what version of the kernel you are looking
at though, so kind of hard to really say anything about your
'investigation'.

> I wonder if the code (and CPU time) used to search the entire request
> queue is actually useful.  Would this be a reasonable candidate for code
> elimination?

In 2.4 it's a O(N) scan, which doubles as an insertion scan (meaning we
have to do it anyways). In 2.6 it's a hash lookup, quick enough.

You also didn't say how you are logging this info. If you are using
printk() to log every request you pretty much already Heisenberged your
test. Even without qualifying the supposedly wasted CPU time.

-- 
Jens Axboe

