Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265658AbUBFTbE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 14:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265663AbUBFTbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 14:31:04 -0500
Received: from host-64-65-253-246.alb.choiceone.net ([64.65.253.246]:63415
	"EHLO gaimboi.tmr.com") by vger.kernel.org with ESMTP
	id S265658AbUBFTa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 14:30:59 -0500
Message-ID: <4023EBF8.2070804@tmr.com>
Date: Fri, 06 Feb 2004 14:33:12 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mattias Wadenstein <maswan@acc.umu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: Performance issue with 2.6 md raid0
References: <Pine.A41.4.58.0402051304410.28218@lenin.acc.umu.se>
In-Reply-To: <Pine.A41.4.58.0402051304410.28218@lenin.acc.umu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mattias Wadenstein wrote:
> Greetings.
> 
> While testing a file server to store a couple of TB in resonably large
> files (>1G), I noticed an odd performance behaviour with the md raid0 in a
> pristine 2.6.2 kernel as compared to a 2.4.24 kernel.
> 
> When striping two md raid5:s, instead of going from about 160-200MB/s for
> a single raid5 to 300M/s for the raid0 in 2.4.24, the 2.6.2 kernel gave
> 135M/s in single stream read performance.
> 
> The setup:
> 2 x 2.0 GHz Opteron 248, 4 gigs of ram (running 32-bit kernels)
> 2 x 8-port 3ware sata raid cards, acting as disk controllers (no hw raid)
> 16 x Maxtor 250-gig 7k2 rpm sata drives.
> 1 x system drive on onboard pata doing pretty much nothing.
> 
> The sata drives are configured in 2 8-disk md raid5s, not hw raid for
> performance reasons, we get better numbers from the md driver in that case
> than the hw raid on the card. Then I have created a raid0 of these two
> raid5 devices.
> 
> I used jfs for these numbers, I have only seen minor differences in speed
> in the single-stream case on this hardware though for different
> filesystems I have tested (ext2, xfs, jfs, reiserfs). And the filesystem
> numbers are reflected pretty close by doing a dd from /dev/md10. The same
> goes for increasing the chunk-size to 4M instead of 32k, roughly the same
> numbers. The system is not doing anything else.
> 
> The results (as meassured by bonnie++ -f -n0, all numbers in kB/s, all
> numbers for a single stream[*]):
> 2.4.24, one of the raid5s: Write: 138273, Read: 212474
> 2.4.24, raid0 of two raid5s: Write: 215827, Read: 303388
> 2.6.2, one of the raid5s: Write: 159271, Read: 161327
> 2.6.2, raid0 of two raid5s: Write: 280691, Read: 134622
> 
> It is the last read value that really stands out.
> 
> Any ideas? Anything I should try? More info wanted?
> 
> Please Cc: me as I'm not a subscriber to this list.
> 
> [*]: For multiple streams, say a dozen or so readers, the aggregate
> performance on the 2.6.2 raid0 went down to about 60MB/s, which is a bit
> of a real performance problem for the intended use, I'd like to at least
> saturate a single gigE interface and hopefully two with that many readers.

I believe what you see between 2.4 and 2.6 is just lack of readahead, 
and you should increase this for your read performance. With no other 
changes you should be able to pretty much match performance between 2.4 
and 2.6.

However, after some years of trying to tune stripe size on both Linux 
and AIX news servers, I suspect that the stripe size you have is too 
small. The optimal stripe size under heavy load seems to be at least 2x 
the largest typical io size, so that you don't have to seek on multiple 
drives all the time. Note "at least," in most cases you can go larger 
than that unless you create and delete a lot of files, in which case you 
can wind up with the inodes on one drive, which can be a real issue.

For this reason I find that most install programs are about worthless, 
they simply use too small a stripe size and generate a lot of overhead 
when used, because too many io are on multiple devices. That's good for 
huge io on separate busses where bus bandwidth is a factor, but very bad 
when most of the time is latency.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
