Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265024AbRGWXkG>; Mon, 23 Jul 2001 19:40:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265042AbRGWXj4>; Mon, 23 Jul 2001 19:39:56 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:53257 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S265024AbRGWXjh>;
	Mon, 23 Jul 2001 19:39:37 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200107232339.f6NNdXB30979@oboe.it.uc3m.es>
Subject: what's the semaphore in requests for?
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Tue, 24 Jul 2001 01:39:33 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

What's the semaphore field in requests for?  Are driver writers supposed
to be using it?

The reason I ask is that I've been chasing an smp bug in a block driver
of mine for a week.  The bug only shows up in 2.4 kernels (not in same
code under 2.2.18) and only with smp ("nosmp" squashes it).  It only
shows up when running dd in user space copying from my device to
a disk device.  It doesn't show when copying to /dev/null.

The symptom is a complete kernel lockup. Not even sysreq works.
It's driving me crazy. It sems to get very easy to trigger in 2.4.6,
while it was hard or impossible to trigger back in 2.4.0 and 2.4.1.

I have added the sgi kdb stuff in order to get a handle. For a while I
was getting some ouches from the nmi watchdog saying that one cpu was
locked, followed by a jump into the kdb monitor. But I'm not getting that
now.  In any case I haven't learned how to use kdb properly yet, so
I couldn't make out much from the stack info.

The bug maybe shows on write from a local disk to the device too, but
it's at least 10 times as hard to trigger that way.  It does NOt trigger
when writing to the device from /dev/zero.  I'm not sure it shows in all
my smp machines either ..  most of them have been slightly unstable
under 2.4.* anyway, locking up on timescales of 1 day to a week.  Could
be apic (asus and dell bx), but I was running my own machine noapic and
it didn't affect the bug.

The block driver is largely in userspace. All the kernel half does
is transfer requests to a local queue (with the io lock still held, of
course). The userspace daemon cycles continously doing ioctls that
copy the requests (bh by bh) into userspace, where its treated via
some networking calls, then return an ack via another ioctl. 

The drivers local queue is protected by a semaphore.  The thing that
puzzles me is that the bug shows only when copying to a disk device,
not to /dev/null, through userspace! Is it that the lifetime of a
request is much longer than expected?

I have some impression that the bug is dependent on speed too. If I
limit the speed of the device, I think I don't see the bug - but
definitive results are very hard to come by because I have to copy
about 2GB from the device to be sure of triggering it.

Oh well, if anyone has any insight or any plans for further hunting,
please let me know.

Peter
