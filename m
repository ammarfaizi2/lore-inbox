Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129168AbRBEXBs>; Mon, 5 Feb 2001 18:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129930AbRBEXBj>; Mon, 5 Feb 2001 18:01:39 -0500
Received: from zeus.kernel.org ([209.10.41.242]:8416 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S129168AbRBEXBa>;
	Mon, 5 Feb 2001 18:01:30 -0500
Date: Mon, 5 Feb 2001 22:58:04 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Steve Lord <lord@sgi.com>,
        linux-kernel@vger.kernel.org, kiobuf-io-devel@lists.sourceforge.net,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait /notify + callback chains
Message-ID: <20010205225804.Z1167@redhat.com>
In-Reply-To: <20010205121921.C1167@redhat.com> <Pine.LNX.4.30.0102052213470.10520-100000@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.LNX.4.30.0102052213470.10520-100000@elte.hu>; from mingo@elte.hu on Mon, Feb 05, 2001 at 10:28:37PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 05, 2001 at 10:28:37PM +0100, Ingo Molnar wrote:
> 
> On Mon, 5 Feb 2001, Stephen C. Tweedie wrote:
> 
> it's exactly these 'compound' structures i'm vehemently against. I do
> think it's a design nightmare. I can picture these monster kiobufs
> complicating the whole code for no good reason - we couldnt even get the
> bh-list code in block_device.c right - why do you think kiobufs *all
> across the kernel* will be any better?
> 
> RAID0 is not an issue. Split it up, use separate kiobufs for every
> different disk.

Umm, that's not the point --- of course you can use separate kiobufs
for the communication between raid0 and the underlying disks, but what
do you then tell the application _above_ raid0 if one of the
underlying IOs succeeds and the other fails halfway through?

And what about raid1?  Are you really saying that raid1 doesn't need
to know which blocks succeeded and which failed?  That's the level of
completion information I'm worrying about at the moment.

> fragmented skbs are a different matter: they are simply a bit more generic
> abstractions of 'memory buffer'. Clear goal, clear solution. I do not
> think kiobufs have clear goals.

The goal: allow arbitrary IOs to be pushed down through the stack in
such a way that the callers can get meaningful information back about
what worked and what did not.  If the write was a 128kB raw IO, then
you obviously get coarse granularity of completion callback.  If the
write was a series of independent pages which happened to be
contiguous on disk, you actually get told which pages hit disk and
which did not.

> and what is the goal of having multi-page kiobufs. To avoid having to do
> multiple function calls via a simpler interface? Shouldnt we optimize that
> codepath instead?

The original multi-page buffers came from the map_user_kiobuf
interface: they represented a user data buffer.  I'm not wedded to
that format --- we can happily replace it with a fine-grained sg list
--- but the reason they have been pushed so far down the IO stack is
the need for accurate completion information on the originally
requested IOs.

In other words, even if we expand the kiobuf into a sg vector list,
when it comes to merging requests in ll_rw_blk.c we still need to
track the callbacks on each independent source kiobufs.  

--Stephen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
