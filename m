Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274862AbRKHQqX>; Thu, 8 Nov 2001 11:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRKHQqN>; Thu, 8 Nov 2001 11:46:13 -0500
Received: from adsl-206-170-148-147.dsl.snfc21.pacbell.net ([206.170.148.147]:4
	"HELO gw.goop.org") by vger.kernel.org with SMTP id <S274862AbRKHQqC>;
	Thu, 8 Nov 2001 11:46:02 -0500
Subject: Re: [Ext2-devel] disk throughput
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Constantin Loizides <Constantin.Loizides@isg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <3BEAA3B7.A7F9328E@isg.de>
In-Reply-To: <3BE647F4.AD576FF2@zip.com.au>
	<Pine.GSO.4.21.0111050904000.23204-100000@weyl.math.psu.edu>
	<3BE71131.59BA0CFC@zip.com.au> 
	<20011106105138Z16653-12382+40@humbolt.nl.linux.org>
	<1005063444.25686.18.camel@ixodes.goop.org>  <3BEAA3B7.A7F9328E@isg.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 08 Nov 2001 08:46:01 -0800
Message-Id: <1005237961.4537.0.camel@ixodes.goop.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-11-08 at 07:24, Constantin Loizides wrote:
> 
> > This is one I made a while ago while doing some measurements; its also
> <[snip]
> 
> That's an interesting plot. I would like to do one for my disk!
> 
> How did you do it?
> How do you find out about the seek distance??? 
> Do you create one big file and then start
> seeking around accessing different blocks of it?

Its pretty simple.  I open /dev/hda (the whole device), and read random
blocks, timing how long it takes for the data to come back since the
last one.  I set up a few hundred/thousand buckets, and accumulate the
measured time into the bucket for that seek distance.  So:

	fd=open("/dev/hda")
	llseek(fd, last = rand());
	read(fd)
	while(!finished) {
		blk = rand();
		llseek(fd, blk);
		read(fd);
		bucket[abs(last-blk)] = time;
		last = blk;
	}

I found the random seeking was the only way I could get reasonable
numbers out of the drive; any of the ordered patterns of the form "OK,
lets measure N block seeks" seemed to be predicted by the drive and gave
unreasonably fast results.

This technique measures seek+rotational latency for reads. 
Seek-for-reading is generally faster than seek-for-writing, because they
start reading as soon as the head is appoximately in the right place,
and start using the data as soon as the ECCs start checking out OK.  You
certainly can't start writing until you've done the full head-settle
time (another 1-2ms).

I'll see what state my measurement code is in (technically and legally)
and see if I can release it.  Anyway I'm happy to answer questions.

	J

