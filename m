Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSILQkp>; Thu, 12 Sep 2002 12:40:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316608AbSILQkp>; Thu, 12 Sep 2002 12:40:45 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9746 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316595AbSILQko>; Thu, 12 Sep 2002 12:40:44 -0400
Date: Thu, 12 Sep 2002 17:45:30 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Mike Anderson <andmike@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19 SCSI core bug?
Message-ID: <20020912174530.B3121@flint.arm.linux.org.uk>
References: <20020911221859.A17951@flint.arm.linux.org.uk> <20020912100140.A32196@flint.arm.linux.org.uk> <20020912153923.GA8295@beaverton.ibm.com> <20020912164201.A3121@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020912164201.A3121@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Sep 12, 2002 at 04:42:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2002 at 04:42:01PM +0100, Russell King wrote:
> On Thu, Sep 12, 2002 at 08:39:23AM -0700, Mike Anderson wrote:
> > I have a cleanup patch for 2.5 scsi_error I will add this fix in.
> > scsi_send_eh_cmnd should not be retrying the command it should return to
> > the caller the status and let them decide. We also should create a
> > ?restore_scsi_cb? function that is shared so that it is done
> > consistently.
> 
> I've got a patch for both of these now.  I'm working through some other
> issues at the moment though (like, why the hell requests for sectors
> after the sector in error don't have a data phase, and the drive returns
> status = GOOD, message = COMMAND COMPLETE, leading the kernel to believe
> that it did transfer data.)

<mode=fact>
Ok, I've found the cause of this one.  Lets assume we're issuing a
READ10 command (transfer 1) for blocks N to N + L, and N + B is bad.
( L >= 0, B >= 0, B < L )

We successfully transfer blocks N to N + (B - 1) inclusive to the host
without problem.  We think B is bad, so we then request N + B + 1 to
N + L blocks from the device using a READ10 command (transfer 2.)

The device immediately comes back without any data, but with GOOD status
and COMMAND COMPLETED message.  In other words, for transfer 2's command,
it goes through the states:

	Message Out -> Command Out -> Status In -> Message In

Now, the interesting thing is that the READ10 commands have a special
bit - FUA or Force Unit Access.  When I set this bit in _all_ READ10
commands, I _do not_ see this behaviour.

<mode=theory>
It turns out that my drive appears to cache the request for transfer 1
(blocks N to N + L), and tries to satisfy the request from its cache.
However, since block N + B was in error, it appears fill its cache
only for N to N + (B - 1), but reserve N to N + L.

When a request with the FUA bit clear for a block between N + B and
N + L is received, it tries to satisfy it from its cache, which
doesn't contain the data.  It thus responds without a data phase,
indicating that the command was successful and without error.

<mode=fact>
This means that, using READ10, it is possible to issue READ commands
to the drive, and have the drive respond without any error, yet NOT
actually read _or_ transfer any data to the host.  Think about what
can happen to your ext2fs superblocks / bitmaps / inode tables in
this situation, and what happens if something writes back the page to
the drive...

I think we have two options:

1. we need to come up with a way of reasonably handing SCSI medium
   errors if we are going to use the READ10 command with the FUA
   bit clear.

2. we could just set the FUA bit and bypass the drives on-board
   cache completely.

Note that the only reason I've found this is because my HBA drives
are _really_ pedantic about checking that all expected data does
in fact get transferred by the drive.

I wonder how many other drives out there are buggy like this. 8/

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

