Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267188AbSLKSll>; Wed, 11 Dec 2002 13:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267265AbSLKSll>; Wed, 11 Dec 2002 13:41:41 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:1043 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S267188AbSLKSlk>; Wed, 11 Dec 2002 13:41:40 -0500
Date: Wed, 11 Dec 2002 13:47:18 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: RAID5 chunksize?
In-Reply-To: <20021210152330.GP32203@rdlg.net>
Message-ID: <Pine.LNX.3.96.1021211132229.19397A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Dec 2002, Robert L. Harris wrote:

> 
> 
> Ok, say I'm building a 4 disk raid5 array.  Performance is going to be
> critical as this system is going to be very IO intensive.  We had to go
> RAID5 though due to filesystem requirements.
> 
> According to the manufacturer the disks have:
> 
>   8Meg DataBuffer
>   10K RPM Rotational speed
>   SCSI Ultra 160
> 
> (Drive is:
> http://www.fel.fujitsu.com/home/product.asp?L=en&PID=248&INFO=fsp)
> 
> What is the ideal Chunksize?  

That depends on your definition of ideal, unfortunately.

> Any other thoughts on how to lay down the disks/filesystem on this
> bugger?

Yes, I got a chance to spend a LOT of time tuning RAID, and got to see
what various settings actually did.

You have to decide if you want to have maximum transfer rate or minimum
seeks on the drive. Some of the changes impact one at the expense of the
other.

If you want to reduce seeks, make the stripe size larger than most of the
i/o requests, so you access at most two drives. This will reduce your
seeks, a too-small stripe can result in activity to most of the drives for
most i/o operations. Lots of seeks, and bad performance if transfers are
fairly small, a request can't complete until the slowest seek+transfer is
complete. 

If the typical write is large, defined as transfer time significantly more
than seek time, you can improve transfer rate by spreading the transfer
over multiple drives, as long as you don't overload your bus. This last
gets important, a few controllers with multiple sets of LVD-160 or faster
drives can start to stress the PCI bus, and enough DMA (or similar bus
master i/o) can actually hit the memory hard enough to measure in the CPU
access time. Clearly these limits are not typical, you idea of high rate
might be idle on some NUMA or cluster. Since this increases the seek rate
on individual drives, you can hurt more than you help with certain loads.

Finally, if you have a very high read rate and much lower write rate, you
can help with RAID-1, so that data on one (busy) drive can be pulled from
a mirror. You *can* have more than two mirrored copies, if your load
justifies it.

Hope some of this helps you answer your own question.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

