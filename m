Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbULBUT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbULBUT2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 15:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbULBUT2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 15:19:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:33422 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261751AbULBUTK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 15:19:10 -0500
Date: Thu, 2 Dec 2004 21:19:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au
Subject: Re: Time sliced CFQ io scheduler
Message-ID: <20041202201904.GD26695@suse.de>
References: <20041202130457.GC10458@suse.de> <20041202134801.GE10458@suse.de> <20041202114836.6b2e8d3f.akpm@osdl.org> <20041202195232.GA26695@suse.de> <20041202121938.12a9e5e0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202121938.12a9e5e0.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02 2004, Andrew Morton wrote:
> Jens Axboe <axboe@suse.de> wrote:
> >
> > n Thu, Dec 02 2004, Andrew Morton wrote:
> > > Jens Axboe <axboe@suse.de> wrote:
> > > >
> > > > as:
> > > > Reader: 27985KiB/sec (max_lat=34msec)
> > > > Writer:    64KiB/sec (max_lat=1042msec)
> > > > 
> > > > cfq:
> > > > Reader: 12703KiB/sec (max_lat=108msec)
> > > > Writer:  9743KiB/sec (max_lat=89msec)
> > > > 
> > > > If you look at vmstat while running these tests, cfq and deadline give
> > > > equal bandwidth for the reader and writer all the time, while as
> > > > basically doesn't give anything to the writer (a single block per second
> > > > only). Nick, is the write batching broken or something?
> > > 
> > > Looks like it.  We used to do 2/3rds-read, 1/3rd-write in that testcase.
> > 
> > But 'as' has had no real changes in about 9 months time, it's really
> > strange. Twiddling with write expire and write batch expire settings
> > make no real difference. Upping the ante to 4 clients, two readers and
> > two writers work about the same: 27MiB/sec aggregate read bandwidth,
> > ~100KiB/sec write.
> 
> Did a quick test here, things seem OK.
> 
> Writer:
> 
> 	while true
> 	do
> 	dd if=/dev/zero of=foo bs=1M count=1000 conv=notrunc
> 	done
> 
> Reader:
> 
> 	time cat 1-gig-file > /dev/null
> 	cat x > /dev/null  0.07s user 1.55s system 3% cpu 45.434 total
> 
> `vmstat 1' says:
> 
> 
>  0  5   1168   3248    472 220972    0    0    28 24896 1249   212  0  7  0 94
>  0  7   1168   3248    492 220952    0    0    28 28056 1284   204  0  5  0 96
>  0  8   1168   3248    500 221012    0    0    28 30632 1255   194  0  5  0 95
>  0  7   1168   2800    508 221344    0    0    16 20432 1183   170  0  3  0 97
>  0  8   1168   3024    484 221164    0    0 15008 12488 1246   460  0  4  0 96
>  1  8   1168   2252    484 221980    0    0 27808  6092 1270   624  0  4  0 96
>  0  8   1168   3248    468 221044    0    0 32420  4596 1290   690  0  4  0 96
>  0  9   1164   2084    456 222212    4    0 28964  1800 1285   596  0  3  0 96
>  1  7   1164   3032    392 221256    0    0 23456  6820 1270   527  0  4  0 96

[snip]

Looks fine, yes.

> So what are you doing different?

Doing sync io, most likely. My results above are 64k O_DIRECT reads and
writes, see the mention of the test cases in the first mail.  I'll
repeat the testing with both sync and async writes tomorrow on the same
box and see what that does to fairness.

Async writes are not very interesting, it takes quite some effort to
make those go slow :-)

-- 
Jens Axboe

