Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275012AbRKAKUq>; Thu, 1 Nov 2001 05:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278649AbRKAKUh>; Thu, 1 Nov 2001 05:20:37 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:22957 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S275012AbRKAKUS>; Thu, 1 Nov 2001 05:20:18 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>
Date: Thu, 1 Nov 2001 21:20:02 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15329.8658.642254.284398@notabene.cse.unsw.edu.au>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>
Subject: Re: 2.4.14-pre6
In-Reply-To: message from Linus Torvalds on Wednesday October 31
In-Reply-To: <Pine.LNX.4.33.0110310809200.32460-100000@penguin.transmeta.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday October 31, torvalds@transmeta.com wrote:
> 
> We have actually talked about some higher-level ordering of the dirty list
> for at least five years, but nobody has ever done it. And I bet you $5
> that you'll get (a) better throughput than by making the queues longer and
> (b) you'll have fine latency while you write and (c) that you want to
> order the write-queue anyway for filesystems that care about ordering.
> 

But what is the "right" order. A raid5 array might well respond to a
different ordering that an JBOD.

I've thought a bit about how to best give blocks to RAID5 so that they
can be written efficiently.  I suspect the issues are similar for
normal disk io:

Currently the device (or block-device-layer) doesn't see a block until
the upper levels really want the IO to happen.  There is a little bit
of a grace period betwen the submit_bh and the run_task_queue(&tq_disk) 
when re-ordering can happen, but it isn't very long.  There is a bit
more grace time while waiting to get a turn on the device.  But it is
still a lot less time than the amount of time that most buffers are
sitting around in cache.

What I would like is that as soon as a buffer was marked "dirty", it 
would get passed down to the driver (or at least to the
block-device-layer) with something like 
    submit_bh(WRITEA, bh);
i.e. a write ahead. (or is it write-behind...)
The device handler (the elevator algorithm for normal disks, other
code for other devices) could keep them ordered in whatever way it
chooses, and feed them into the queues at some appropriate time.

The submit_bh(WRITE, bh) would then push the buffer out if it hadn't
gone already.

The elevator code could possibly keep two sorted lists: one of WRITEA
(or READA) requests and one of WRITE (or READ) requests.
It processes the second merging in some of the first as it goes.
Maybe capping it to 2 -ahead blocks for every immediate block.
Probably also allowing for larger numbers of -ahead blocks if they are
contiguous with an immediate block.

RAID5 would do something a bit different.  Possibly whenever it wanted
to write a stripe, it would hunt though the -ahead list (sort of like
the 2.2 code did) for other blocks that could be proactive added to
the stripe.


This would allow a nice ordering of write-behind (and read-ahead)
requests but give the driver control of latency by allowing it to
limit the extent to which write-behind/read-ahead blocks can usurp the
position of other blocks.

Does that make any sense?  Is it conceptually simple enough?

NeilBrown
