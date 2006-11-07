Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754077AbWKGHX6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754077AbWKGHX6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 02:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754085AbWKGHX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 02:23:58 -0500
Received: from brick.kernel.dk ([62.242.22.158]:3602 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S1754077AbWKGHX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 02:23:57 -0500
Date: Tue, 7 Nov 2006 08:26:06 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: Brent Baccala <cosine@freesoft.org>, linux-kernel@vger.kernel.org
Subject: Re: async I/O seems to be blocking on 2.6.15
Message-ID: <20061107072606.GN19471@kernel.dk>
References: <20061105121522.GC13555@kernel.dk> <000001c701e9$a1435260$ff0da8c0@amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001c701e9$a1435260$ff0da8c0@amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06 2006, Chen, Kenneth W wrote:
> Jens Axboe wrote on Sunday, November 05, 2006 4:15 AM
> > On Fri, Nov 03 2006, Brent Baccala wrote:
> > > On Fri, 3 Nov 2006, Jens Axboe wrote:
> > > 
> > > >Try to time it (visual output of the app is not very telling, and it's
> > > >buffered) and then apply some profiling.
> > > 
> > > OK, a little more info.  I added gettimeofday() calls after each call
> > > to io_submit(), put the timevals in an array, and after everything was
> > > done computed the difference between each timeval and the program start
> > > time, as well as the deltas.  I got this:
> > > 
> > > 0: 0.080s
> > > 1: 0.086s  0.006s
> > > 2: 0.102s  0.016s
> > > 3: 0.111s  0.008s
> > > 4: 0.118s  0.007s
> > > 5: 0.134s  0.015s
> > > 6: 0.141s  0.006s
> > > 7: 0.148s  0.006s
> > > 8: 0.158s  0.009s
> > > 9: 0.164s  0.006s
> > > ...
> > > 96: 1.036s  0.007s
> > > 97: 1.044s  0.007s
> > > 98: 1.147s  0.102s
> > > 99: 1.155s  0.008s
> > > 
> > > 98 appears to be an aberration.  Perhaps three of the times on an
> > > average run are around a tenth of a second; all of the others are
> > > pretty steady at 7 or 8 microseconds.  So, it's basically linear in
> > > its time consumption.
> > > 
> > > Does 7 microseconds seem a bit excessive for an io_submit (and a
> > > gettimeofday)?
> > 
> > I guess you mean miliseconds, not microseconds. 7 miliseconds seems way
> > too long. I repeated your test here, and the 100 submits take 97000
> > microseconds here - or 97 miliseconds. So that's a little less than 1
> > msec per io_submit. Still pretty big. You can experiment with oprofile
> > to profile where the kernel spends its time in that period.
> 
> 
> I've tried that myself too and see similar result.  One thing to note is
> that I/O being submitted are pretty big at 1MB, so the vector list inside
> bio is going to be pretty long and it will take a while to construct that.
> Drop the size for each I/O to something like 4KB will significantly reduce
> the time.  I haven't done the measurement whether the time to submit I/O
> grows linearly with respect to I/O size.  Most likely it will.  If it is
> not, then we might have a scaling problem (though I don't believe we have
> this problem).

True, it might not be all that unreasonable, just seemed a bit excessive
to me. If you submit smaller ios, you move the cost from bio_add_page()
to the merge logic in the driver. You'd have more allocations as well,
with bio's strung together instead of a bigger vector map.

-- 
Jens Axboe

