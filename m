Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129619AbRBFU2V>; Tue, 6 Feb 2001 15:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129571AbRBFU2G>; Tue, 6 Feb 2001 15:28:06 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:42420 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129219AbRBFU1o>; Tue, 6 Feb 2001 15:27:44 -0500
Date: Tue, 6 Feb 2001 15:25:00 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: Ingo Molnar <mingo@elte.hu>
cc: Linus Torvalds <torvalds@transmeta.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Manfred Spraul <manfred@colorfullife.com>, Steve Lord <lord@sgi.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        <kiobuf-io-devel@lists.sourceforge.net>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [Kiobuf-io-devel] RFC: Kernel mechanism: Compound event wait
In-Reply-To: <Pine.LNX.4.30.0102062052110.8926-100000@elte.hu>
Message-ID: <Pine.LNX.4.30.0102061521270.15204-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2001, Ingo Molnar wrote:

>
> On Tue, 6 Feb 2001, Ben LaHaise wrote:
>
> > This small correction is the crux of the problem: if it blocks, it
> > takes away from the ability of the process to continue doing useful
> > work.  If it returns -EAGAIN, then that's okay, the io will be
> > resubmitted later when other disk io has completed.  But, it should be
> > possible to continue servicing network requests or user io while disk
> > io is underway.
>
> typical blocking point is waiting for page completion, not
> __wait_request(). But, this is really not an issue, NR_REQUESTS can be
> increased anytime. If NR_REQUESTS is large enough then think of it as the
> 'absolute upper limit of doing IO', and think of the blocking as 'the
> kernel pulling the brakes'.

=)  This is what I'm seeing: lots of processes waiting with wchan ==
__get_request_wait.  With async io and a database flushing lots of io
asynchronously spread out across the disk, the NR_REQUESTS limit is hit
very quickly.

> [overhead of 512-byte bhs in the raw IO code is an artificial problem of
> the raw IO code.]

True, and in the tests I've run, raw io is using 2KB blocks (same as the
database).

		-ben

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
