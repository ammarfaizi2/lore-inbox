Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbULVSS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbULVSS3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 13:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261954AbULVSS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 13:18:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18070 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261948AbULVSSW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 13:18:22 -0500
Date: Wed, 22 Dec 2004 13:58:16 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: "M. Edward Borasky" <znmeb@cesmail.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jens Axboe <axboe@suse.de>
Subject: Re: Negative "ios_in_flight" in the 2.4 kernel
Message-ID: <20041222155816.GF3088@logos.cnet>
References: <1103691937.23157.14.camel@DreamGate> <20041222111642.GD12463@suse.de> <1103728782.26340.34.camel@DreamGate>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103728782.26340.34.camel@DreamGate>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 07:19:42AM -0800, M. Edward Borasky wrote:
> On Wed, 2004-12-22 at 12:16 +0100, Jens Axboe wrote:
> >  
> > > Question: wouldn't a simple refusal to decrement ios_in_flight in
> > > "down_ios" if it's zero fix this, or am I missing something?
> > 
> > That would paper over the real bug, but it will work for you.
> What is the "real bug", then? What will "work for me" is accurate disk
> usage tick counts. The intent of these statistics is something known as
> Operational Analysis of Queueing Networks. 
> 
> The "requirement" is that the operations on each device be accurately
> counted, and the "wall clock" time spent *waiting* for requests and the
> time spent *servicing* requests be accurately accumulated for each
> device. The sector count is a bonus. 
> 
> >From these raw counters, one can, and iostat does, compute throughput,
> utilization, average service time, average wait time and average queue
> length. An excellent and highly readable reference for the math involved
> can be found at
> 
> http://www.cs.washington.edu/homes/lazowska/qsp/Images/Chap_03.pdf
> 
> That is the intent behind these counters, and what will "work for me" is
> a kernel that captures the raw counters correctly. If forcing
> ios_in_flight to be non-negative is done at the expense of losing or
> gaining ticks in the wait or service time accumulators, then it will not
> work for me.

Well something is deaccounting uncorrectly (doh), probably the disk/partition 
accounting logic is doing wrong in some condition, Jens?

void req_merged_io(struct request *req)
{
        struct hd_struct *hd1, *hd2;

        locate_hd_struct(req, &hd1, &hd2);
        if (hd1)
                down_ios(hd1);
        if (hd2)
                down_ios(hd2);
}

void req_finished_io(struct request *req)
{
        struct hd_struct *hd1, *hd2;

        locate_hd_struct(req, &hd1, &hd2);
        if (hd1)
                account_io_end(hd1, req);
        if (hd2)
                account_io_end(hd2, req);
}

We could eliminate that possibility if you ran your tests with a single 
non-partitioned disk, but thats just a guess.

Jens has more of a clue than I certainly.

