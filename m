Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266488AbRH1Szl>; Tue, 28 Aug 2001 14:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270299AbRH1Szb>; Tue, 28 Aug 2001 14:55:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:2313 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266488AbRH1SzU>; Tue, 28 Aug 2001 14:55:20 -0400
From: Linus Torvalds <torvalds@transmeta.com>
Date: Tue, 28 Aug 2001 11:52:50 -0700
Message-Id: <200108281852.f7SIqos15325@penguin.transmeta.com>
To: kevin.vanmaren@unisys.com, linux-kernel@vger.kernel.org
Subject: Re: The cause of the "VM" performance problem with 2.4.X
Newsgroups: linux.dev.kernel
In-Reply-To: <245F259ABD41D511A07000D0B71C4CBA289F5F@us-slc-exch-3.slc.unisys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <245F259ABD41D511A07000D0B71C4CBA289F5F@us-slc-exch-3.slc.unisys.com> you
write:
>
>Okay, here are some more results with Morton's "2nd" patch,
>running 2.4.8,IA64-010815 on 4X IA64 (Lion) with 8GB RAM,
>733MHz B3 (4MB) CPUs.  3 Adaptec 39160 channels, each with
>8 (18GB) Cheetah drives, create 4 md's using 2 disks from
>each channel.  Also using Gibbs' 6.2.0 adaptec driver.
>I tried to extract the "important" info to keep this message
>relatively small.  Meant to get this out earlier...

Interesting.

>It looks like "getblk" could use some additional optimization.
>More info to follow, but even doing one "mkfs" at a time,
>the lru_list_lock is held over 82% of the time, mostly by
>getblk().

Note that the real fix is to make the block devices use the page cache.
Andrea has patches, but it's a 2.5.x thing.

The buffer cache is really meant to be used only for meta-data, and
"getblk()" should not show up on profiles under any reasonable load. I
seriously doubt that running parallel (or even a single) "mkfs" is a
reasonable load under normal use.

So I don't consider the buffer cache locking to be a critical
performance issue - but I _do_ want to make sure that we don't have any
_really_ horrid special cases where we just perform so abysmally that
it's not worth using Linux at all.

So small inefficiencies and lack of parallelism is not a huge issue for
the buffer cache - at least not until somebody finds a more
"interesting" load per se. 

As to the really bad behaviour with the CPU spending all the time just
traversing the dirty buffer lists, I'd love to hear what 2.4.10-pre2
does.  It doesn't use Andrews advanced patch, but instead just makes
dirty buffer balancing not care about the device - which should allow
much better IO behaviour and not have any silly bad cases from a VM
standpoint. 


>Abbreiated/stripped kernprof/gprof output:
>------------------------------------------
>
>Each sample counts as 0.000976562 seconds.
>  %   cumulative   self              self     total
> time   seconds   seconds    calls  ms/call  ms/call  name
> 39.46    224.65   224.65                             cg_record_arc
> 16.40    318.00    93.34  6722992     0.01     0.02  getblk
>  9.02    369.33    51.33 50673121     0.00     0.00  spin_lock_
>  6.67    407.27    37.95  6722669     0.01     0.01  _make_request
>  4.51    432.97    25.70 13445261     0.00     0.00  blk_get_queue
>  2.61    447.83    14.86                             long_copy_user
>  2.59    462.56    14.72                             mcount
>  2.06    474.27    11.71                             cpu_idle

Now, while I don't worry about "getblk()" itself, the request stuff and
blk_get_queue() _can_ be quite an issue even under non-mkfs load, so
that certainly implies that we have some work to do. The area of the
block device request queueing is definitely something that 2.5.x will
start working on (Jens is already doing lots of stuff, obviously).

And your lock profile certainly shows the io_request_lock as a _major_
lock user, although I'm happy to see that contention seems to be
reasonably low. Still, I'd bet that it is worth working on..

		Linus
