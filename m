Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281015AbRKCTHr>; Sat, 3 Nov 2001 14:07:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281016AbRKCTHh>; Sat, 3 Nov 2001 14:07:37 -0500
Received: from www.wen-online.de ([212.223.88.39]:20237 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S281015AbRKCTHZ>;
	Sat, 3 Nov 2001 14:07:25 -0500
Date: Sat, 3 Nov 2001 20:07:16 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: <jogi@planetzork.ping.de>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.14-pre6
In-Reply-To: <Pine.LNX.4.33.0111030953250.1680-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0111031957040.362-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Nov 2001, Linus Torvalds wrote:

> On Sat, 3 Nov 2001, Mike Galbraith wrote:
> >
> > > Otherwise -pre5aa1 still seems to be the fastest kernel *in this test*.
> >
> > My box agrees.  Notice pre5aa1/ac IO numbers below.  I'm getting
> > ~good %user/wallclock with pre6/pre7 despite (thrash?) IO numbers.
>
> Well, pre7 gets the second-best numbers, and the reason I really don't
> like pre5aa1 is that since pre4, the virgin kernels have had all mapped
> pages in the LRU queue, and can use that knowledge to decide when to
> start swapping.
>
> So in those kernels, the balance between scanning the VM tables and
> scanning the regular unmapped caches is something that is strictly
> deterministic, which is something I _really_ want to have.
>
> We've had too much trouble with the "let's hope this works" approach.
> Which is why I want the anonymous pages to clearly show up in the
> scanning, and not have them be these virtual ghosts that only show up when
> you start swapping stuff out.
>
> Your array cut down to just the ones that made the benchmark in under 8
> minutes makes it easier to read, and clearly pre6+ seems to be a bit _too_
> swap-happy. I'm trying the "dynamic max_mapped" approach now.

Swap-happy doesn't bother this load too much.  What it's really sensitive
to is pagein.  Turning the cache knobs (vigorously:) in aa-latest...

2.4.14-pre6aa1
real    8m29.484s
user    6m38.650s
sys     0m27.940s

user  :       0:06:45.45  70.6%  page in :   641298
nice  :       0:00:00.00   0.0%  page out:   634494
system:       0:00:41.73   7.3%  swap in :   118869
idle  :       0:02:06.90  22.1%  swap out:   154141

echo 2 > /proc/sys/vm/vm_mapped_ratio
echo 128 > /proc/sys/vm/vm_balance_ratio

real    7m25.069s
user    6m37.390s
sys     0m27.540s

user  :       0:06:43.60  78.7%  page in :   588488
nice  :       0:00:00.00   0.0%  page out:   514865
system:       0:00:40.47   7.9%  swap in :   118738
idle  :       0:01:08.92  13.4%  swap out:   122340

..lowers the sleep time noticibly despite swapin remaining constant.

	-Mike

