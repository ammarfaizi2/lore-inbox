Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030501AbVIJBrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbVIJBrt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 21:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030505AbVIJBrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 21:47:48 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:62512 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1030501AbVIJBrs convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 21:47:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pppXF3VyKVuvu0rQJaO/LvGtkh/W33TJ9RCclOtFhUZlywdtKz83/0iEKm5AIgpMFjVJXpaNNjmb+DRKRBdIwD55W+TXUmnYjlwpaKEo1fFb5fHkt7FFoHyEUtrLRvMLpUdK3QWd4KJ/AHZHxs6+e3Y+V4LtPVufmXu03olXR7Q=
Message-ID: <5c49b0ed0509091847135834c0@mail.gmail.com>
Date: Fri, 9 Sep 2005 18:47:42 -0700
From: Nate Diller <nate.diller@gmail.com>
Reply-To: nate.diller@gmail.com
To: awesley@acquerra.com.au
Subject: Re: kernel 2.6.13 buffer strangeness
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <432231B7.2060200@acquerra.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <432151B0.7030603@acquerra.com.au>
	 <EXCHG2003Zi71mrvoGd00000659@EXCHG2003.microtech-ks.com>
	 <5c49b0ed05090914394dba42bf@mail.gmail.com>
	 <432225E0.9030606@acquerra.com.au>
	 <5c49b0ed0509091735436260bb@mail.gmail.com>
	 <432231B7.2060200@acquerra.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/05, Anthony Wesley <awesley@acquerra.com.au> wrote:
> Okay, just tested a couple of things, here's what I see...
> 
> I tested the write speed to the usb2 hard disk and got 21MBytes/sec. It's a
> laptop 
> hard drive, only 5400rpm so this is not surprising.
> 
> I did this test with my video capture app running, but just displaying data
> and not writing,
> 
> I have another laptop usb2 hard drive here which I just tested and got
> 17MBytes/sec - it's
> a 4200rpm drive so again not surprising numbers.
> 
> The video data is written as individual frames, so the efficiency is a bit
> below the raw throughput,
> but my tests were transferring 1.5Gb of data as raw frames - exactly the
> same way that Coriander would
> write its data.
> 
> I'd bet a large sum of money that these hard disk figures are correct to
> within a few percent.
> 
> Also, when I am actually capturing I have timed by stopwatch how long the
> disk activity light
> is on, and reached about the same conclusion.
> 
> Working the problem from the other direction, the only way to explain the
> early throttling that
> I see would be if *almost no data* is being written to the disk, and this is
> plainly not the case. Even if
> the disk were running at a greatly reduced rate of (say) 10MBytes/sec I
> would still see 86 seconds
> of buffering before the throttle kicks in, and so far I have managed only to
> get to about 65 or 70.
> 
> regards, Anthony
> 
i need a vmstat trace ('vmstat 1 > logfile', then run the test, then
^c)  before i can comment further.  also, your filesystem and
scheduler would be interesting to know.  you can find out the
scheduler with 'cat /sys/block/[drive]/queue/scheduler'.

NATE

> Nate Diller wrote:
> 
> 
> >>Setting dirty_ratio and dirty_background_ratio to 90/10 puts me back at
> >>around 50 seconds, i.e. where I started.
> >>
> > 
> > this setting should do the trick, so there's something going on here
> > that isn't expected.
> > 
> > 
> >>So as far as I can see there is *no way* to get 3 minutes worth of
> buffering
> >>by adjusting these parameters.
> >>
> >>Just to remind everyone - I have video data coming in at 25MBytes/sec and
> I
> >>am writing it out to a usb2 hard disk that can sustain 17MBytes/sec. I
> want
> >>my video capture to run at full speed as long as possible by having the
> >>7MBytes/sec deficit slowly eat up the available RAM in the machine. I
> have
> >>1.5Gb of RAM, 1.3Gb available for buffers, so this should take 3 minutes
> to
> >>consume at 7MBytes/sec.
> >>
> >>So, I've tried all the combinations on dirty_ratio and
> >>dirty_background_ratio and they *do not help*.
> >>
> > 
> > dirty_ratio is the tubable you want, if it's not working correctly,
> > either there's a problem with your setup, or a bug
> > 
> > 
> >>Can anyone suggest something else that I might try? The goal is to have
> >>25MBytes/sec streaming video for about 3 minutes. 
> >>
> > 
> > how sure are you that you're getting 17MB/s during this test?  can you
> > run "vmstat 1" while this is running to verify?  which FS and
> > scheduler?
> > 
> > just for interest, what's the raw disk bandwidth (use hdparm, or run a
> > dd, or something)?  it would obviously be much better to sustain
> > 25MB/s to disk
> > 
> > 
> >>Or is this simply not possible with the current kernel I/O setup? Do I
> have
> >>to do something elaborate myself, like build a big RAM buffer, mount the
> >>disk synchronous, do the buffering myself in userland...??
> >>
> > 
> > this should be possible, although it could be considered a bit risky WRT
> OOM.
> > 
> > NATE
> 
> -- 
> Anthony Wesley
> Director and IT/Network Consultant
> Smart Networks Pty Ltd
> Acquerra Pty Ltd
> 
> Anthony.Wesley@acquerra.com.au
> Phone: (02) 62595404 or 0419409836
>
