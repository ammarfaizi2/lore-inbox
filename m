Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSFQMeX>; Mon, 17 Jun 2002 08:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312590AbSFQMeW>; Mon, 17 Jun 2002 08:34:22 -0400
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:31495 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S312560AbSFQMeV>; Mon, 17 Jun 2002 08:34:21 -0400
Subject: Re: "laptop mode" for floppies too?
In-Reply-To: <3D0DB3A7.C32CCAE9@zip.com.au>
To: Andrew Morton <akpm@zip.com.au>
Date: Mon, 17 Jun 2002 14:34:12 +0200 (CEST)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL95 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <E17Jvi0-0007gl-00@alf.amelek.gda.pl>
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> The key idea of writing back all dirty data when the disk is spun up
> for a read can be implemented by a userspace daemon which polls /proc/stat
> anyway.

Quite a lot of work to parse the /proc output that had to be nicely
formatted by the kernel first...  And, that would be a global sync()
not per-device - looks like a hack to me.

> A proper solution is not feasible with the 2.4 data structures.
> In 2.5, making the "maximum age of dirty data" be a per-queue
> tunable is in fact pretty simple.  The trickiest part would be
> exposing the per-queue tunables to userspace, actually.

The "maximum age of dirty data" should be short (shorter than spin down
timeout) if the disk is already spinning, but longer if not spinning
so it won't spin up too often, otherwise there is little power saving.
Perhaps let the driver itself tune that value, depending on the current
state of the drive (spinning or not), easier than exposing to userspace.

The floppy driver itself controls the motor, so could also somehow
tell the kernel to write back all dirty data just before spinning down.
IDE disks can spin down automatically after some idle time, but perhaps
it would be more efficient if Linux could do that in software instead -
tell the disk to go to sleep ("hdparm -y") if it has not been accessed
for too long, but write all dirty data first (without resetting the idle
timer - possible now that the timer is ours and not in the disk).

OK, it's really a larger issue of more intelligent power management
than the hardware itself can do without OS support...

> I do need to revisit this stuff - we need a way of being able
> to incorporate the nominal write bandwidth of the backing device
> into the memory balancing decisions.  I'll take a look at your
> idea when I get onto that.

Thanks.  Yes, these days bandwidth can vary a lot between ATA100 disks
and floppies :)

Marek

