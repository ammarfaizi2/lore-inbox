Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267196AbRG1Wec>; Sat, 28 Jul 2001 18:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267188AbRG1WeN>; Sat, 28 Jul 2001 18:34:13 -0400
Received: from oboe.it.uc3m.es ([163.117.139.101]:22789 "EHLO oboe.it.uc3m.es")
	by vger.kernel.org with ESMTP id <S267180AbRG1WeG>;
	Sat, 28 Jul 2001 18:34:06 -0400
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200107282234.f6SMY8421363@oboe.it.uc3m.es>
Subject: Re: what's the semaphore in requests for?
In-Reply-To: From (env: ptb) at "Jul 24, 2001 01:39:33 am"
To: "linux kernel" <linux-kernel@vger.kernel.org>
Date: Sun, 29 Jul 2001 00:34:08 +0200 (MET DST)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

"A month of sundays ago ptb wrote:"
> What's the semaphore field in requests for?  Are driver writers supposed
> to be using it?

It seems nobody knows.

> The reason I ask is that I've been chasing an smp bug in a block driver
> of mine for a week.  The bug only shows up in 2.4 kernels (not in same
> code under 2.2.18) and only with smp ("nosmp" squashes it).  It only

I've made more progress in seeking this bug.  The test is
just dd if=/dev/mine of=/dev/null bs=4k over 2GB of data.

2 processors + 1 userspace helper daemon on device = no bug 
2 processors + 2 userspace helper daemon on device = bug  (lockup)
1 processors + 1 userspace helper daemon on device = no bug 
1 processors + 2 userspace helper daemon on device = no bug 

Seeing this, I added a semaphore that forces the helper daemons to
exclude each other as they enter the kernel in their ioctl calls.
Still the lockup occurred with two processors and two daemons.

IMO that's impossible.  With the semaphore, the daemons should have
behaved like one daemon, since they don't maintain any state.  They just
run in two threads instead of one.  I was careful to lock the entire
daemon interaction cycle with the kernel (a get and an ack ioctl) into
one atomic unit with the semaphore, not just exclude simultaneous entry.

OK .. so let's treat this as an opportunity to learn something more
about the kernel.

I believe the above data indicates that the act of doing an ioctl
may prompt activity in the kernel request function, perhaps as the
scheduler triggers the helper daemon process on the way in to the
kernel. And perhaps that leads to the kernel request function for
the device running twice simultaneously? It runs when the device
unplugs, surely, and never any other time?

I've been through adding spinlocks to exclude the kernel request
function and the helper daemon ioctls on shared resources. Surely
if there were a problem there I'd see it with 2 cpus and 1 helper
daemon!

Peter

