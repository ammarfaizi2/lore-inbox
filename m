Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273983AbRIXQP0>; Mon, 24 Sep 2001 12:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273989AbRIXQPQ>; Mon, 24 Sep 2001 12:15:16 -0400
Received: from femail27.sdc1.sfba.home.com ([24.254.60.17]:54200 "EHLO
	femail27.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S273983AbRIXQO6>; Mon, 24 Sep 2001 12:14:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: [PATCH] 2.4.10 improved reiserfs a lot, but could still be better
Date: Mon, 24 Sep 2001 09:15:19 -0700
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <B0005839269@gollum.logi.net.au> <20010924173210.A7630@emma1.emma.line.org>
In-Reply-To: <20010924173210.A7630@emma1.emma.line.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010924161518.KYHD11251.femail27.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 24 September 2001 08:32 am, Matthias Andree wrote:
> On Mon, 24 Sep 2001, Beau Kuiper wrote:
> > Also, the performace problems seem to be very dependant on the
> > hardware being used. 5400rpm drives get hurt a lot, while 7200 rpm
> > drives seem to handle it better. Decent write caching on IDE
> > devices (like the 2meg buffer on the IBM) can completely hide this
> > issue.
>
> Decent write caching on IDE devices can eat your whole file system.
>
> Turn it off (I have no idea of internals, but I presume it'll still
> be a write-through cache, so reading back will still be served from
> the buffer). Do hdparm -W0 /dev/hd[a-h].

I'm sorry, but that's not acceptable.
Please note the dd timings at the bottom of this message.

This is consistant with real workload on my and other peoples systems, 
200-300MB+ files, clear up to 1GB+ files are at times ROUTINE for 
writing. This is esspecialy applicable if dealing with disk images, etc.
Disabling write cache creates times that are twice as large or more 
than WITH write cache. Unless the system or drive has a serious, 
SPECIFIC fault with its write cache, disabling it can cause an 
unacceptable performance hit.

Yes, a typical desktop user isn't going to notice much, even a normal 
webserver or fileserver not dealing with constant updates may not, but 
certain workloads will. These workloads are real enough that telling 
people to disable write caching out of hand is a bad idea.
There's no way in hell I'm going to accept having my performance cut in 
half or more on my daily workload due to the remote possibility that 
something may happen to my data/filesystem in mid-write. That's what 
the cheap little UPS sitting beside my desk that gives me ample time to 
power down is for.
Short of a catastrophic power supply, motherboard, or other component 
failure (which often stands a good chance of destroying the drive 
anyway), a power failure is the main problem here.
Keep in mind also, that you may be putting your data and filesystems in 
more risk by not using a write cache as with using it.



(below timings are all on an IBM 75GXP DTLA-307045, 46.11BB("GB") 
7200RPM ATA/100 drive on an off-board Promise Ultra/100 (ATA/100) 
controller on an 800Mhz Athlon 100Mhz FSB PC100 RAM CAS3@100Mhz.)

root@c779218-a:/home/nnkk# hdparm -W0 /dev/hde

/dev/hde:
 setting drive write-caching to 0 (off)
root@c779218-a:/home/nnkk# time dd if=/dev/zero of=test.zero bs=1024k 
count=128
128+0 records in
128+0 records out

real    0m18.178s
user    0m0.000s
sys     0m1.740s
root@c779218-a:/home/nnkk# rm -f test.zero
root@c779218-a:/home/nnkk# hdparm -W1 /dev/hde

/dev/hde:
 setting drive write-caching to 1 (on)
root@c779218-a:/home/nnkk# time dd if=/dev/zero of=test.zero bs=1024k 
count=128
128+0 records in
128+0 records out

real    0m7.809s
user    0m0.020s
sys     0m1.890s
root@c779218-a:/home/nnkk# time dd if=/dev/zero of=test.zero bs=1024k 
count=256
256+0 records in
256+0 records out

real    0m44.328s
user    0m0.010s
sys     0m3.510s
root@c779218-a:/home/nnkk# hdparm -W1 /dev/hde

/dev/hde:
 setting drive write-caching to 1 (on)
root@c779218-a:/home/nnkk# rm -f test.zero
root@c779218-a:/home/nnkk# time dd if=/dev/zero of=test.zero bs=1024k 
count=256
256+0 records in
256+0 records out

real    0m18.790s
user    0m0.000s
sys     0m3.780s
