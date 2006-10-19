Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423326AbWJSMVT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423326AbWJSMVT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 08:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423329AbWJSMVT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 08:21:19 -0400
Received: from brick.kernel.dk ([62.242.22.158]:17749 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1423326AbWJSMVS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 08:21:18 -0400
Date: Thu, 19 Oct 2006 14:22:01 +0200
From: Jens Axboe <jens.axboe@oracle.com>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jakob Oestergaard <jakob@unthought.net>,
       Arjan van de Ven <arjan@infradead.org>,
       "Phetteplace, Thad (GE Healthcare, consultant)" 
	<Thad.Phetteplace@ge.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Bandwidth Allocations under CFQ I/O Scheduler
Message-ID: <20061019122201.GJ30700@kernel.dk>
References: <20061018080030.GU23492@unthought.net> <1161164456.3128.81.camel@laptopd505.fenrus.org> <20061018113001.GV23492@unthought.net> <20061018114913.GG24452@kernel.dk> <20061018122323.GW23492@unthought.net> <1161175344.9363.30.camel@localhost.localdomain> <20061018124420.GI24452@kernel.dk> <4536245B.8070906@yahoo.com.au> <20061018130456.GJ24452@kernel.dk> <45363149.9050607@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45363149.9050607@grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18 2006, Paulo Marques wrote:
> Jens Axboe wrote:
> >[...]
> >Precisely, hence CFQ is now based on the time metric. Given larger
> >slices, you can mostly eliminate the impact of other applications in the
> >system.
> 
> Just one thought: we can't predict reliably how much time a request will
> take to be serviced, but we can account the time it _took_ to service a
> request.
> 
> If we account the time it took to service requests for each process, and
> we have several processes with requests pending, we can use the same 
> algorithm we would use for a large time slice algorithm to select the 
> process to service.
> 
> This should make it as fair over time as a large time slice algorithm 
> and doesn't need large time slices, so latencies can be kept as low as 
> required.

Two problems:

- You can't chop things down to single request times. A cost of a
  request greatly varies depending on what preceeded it, hence you need
  to account batches of requests from a process - this is what the time
  slice currently accomplishes.

- Whether a process has requests pending or not varies a lot. The
  typical bandwidth problem is due to processes doing sync or dependent
  io where you only get io in pieces over time.

A request based approach only works over processes that always (or
almost always) have work left to do. You absolutely need the time slice
or some other waiting mechanism to help those that don't.

> However, having a small time slice will probably help the hardware 
> coalesce several request from the same process that are more likely to 
> be to nearby sectors, and thus improve performance.

Either the process is submittinger larger amounts of io and you'll get
the merging anyways, or it isn't. There's a large difference in time
scales here.

-- 
Jens Axboe

