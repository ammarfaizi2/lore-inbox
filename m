Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261177AbULWIKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261177AbULWIKD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 03:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261176AbULWIKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 03:10:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:14793 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261177AbULWIIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 03:08:20 -0500
Date: Thu, 23 Dec 2004 09:08:07 +0100
From: Jens Axboe <axboe@suse.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: "M. Edward Borasky" <znmeb@cesmail.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Negative "ios_in_flight" in the 2.4 kernel
Message-ID: <20041223080806.GG12463@suse.de>
References: <1103691937.23157.14.camel@DreamGate> <20041222111642.GD12463@suse.de> <1103728782.26340.34.camel@DreamGate> <20041222155816.GF3088@logos.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222155816.GF3088@logos.cnet>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22 2004, Marcelo Tosatti wrote:
> On Wed, Dec 22, 2004 at 07:19:42AM -0800, M. Edward Borasky wrote:
> > On Wed, 2004-12-22 at 12:16 +0100, Jens Axboe wrote:
> > >  
> > > > Question: wouldn't a simple refusal to decrement ios_in_flight in
> > > > "down_ios" if it's zero fix this, or am I missing something?
> > > 
> > > That would paper over the real bug, but it will work for you.
> > What is the "real bug", then? What will "work for me" is accurate disk
> > usage tick counts. The intent of these statistics is something known as
> > Operational Analysis of Queueing Networks. 
> > 
> > The "requirement" is that the operations on each device be accurately
> > counted, and the "wall clock" time spent *waiting* for requests and the
> > time spent *servicing* requests be accurately accumulated for each
> > device. The sector count is a bonus. 
> > 
> > >From these raw counters, one can, and iostat does, compute throughput,
> > utilization, average service time, average wait time and average queue
> > length. An excellent and highly readable reference for the math involved
> > can be found at
> > 
> > http://www.cs.washington.edu/homes/lazowska/qsp/Images/Chap_03.pdf
> > 
> > That is the intent behind these counters, and what will "work for me" is
> > a kernel that captures the raw counters correctly. If forcing
> > ios_in_flight to be non-negative is done at the expense of losing or
> > gaining ticks in the wait or service time accumulators, then it will not
> > work for me.
> 
> Well something is deaccounting uncorrectly (doh), probably the disk/partition 
> accounting logic is doing wrong in some condition, Jens?
> 
> void req_merged_io(struct request *req)
> {
>         struct hd_struct *hd1, *hd2;
> 
>         locate_hd_struct(req, &hd1, &hd2);
>         if (hd1)
>                 down_ios(hd1);
>         if (hd2)
>                 down_ios(hd2);
> }
> 
> void req_finished_io(struct request *req)
> {
>         struct hd_struct *hd1, *hd2;
> 
>         locate_hd_struct(req, &hd1, &hd2);
>         if (hd1)
>                 account_io_end(hd1, req);
>         if (hd2)
>                 account_io_end(hd2, req);
> }
> 
> We could eliminate that possibility if you ran your tests with a single 
> non-partitioned disk, but thats just a guess.

It would be nice to know if this was a vanilla kernel or patched in some
way. The only recent bug in this area I remember was a bad merge in the
SUSE tree with the io_request_lock scaling patch.

(and don't trim the cc list when replying, at least not if you want
people to see your message)

-- 
Jens Axboe

