Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289027AbSAVAJH>; Mon, 21 Jan 2002 19:09:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289065AbSAVAI6>; Mon, 21 Jan 2002 19:08:58 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:60944
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S289027AbSAVAIp>; Mon, 21 Jan 2002 19:08:45 -0500
Date: Mon, 21 Jan 2002 15:53:20 -0800 (PST)
From: Andre Hedrick <andre@linuxdiskcert.org>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Jens Axboe <axboe@suse.de>, Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
In-Reply-To: <20020121235743.A28134@suse.cz>
Message-ID: <Pine.LNX.4.10.10201211535030.15703-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2002, Vojtech Pavlik wrote:

> On Mon, Jan 21, 2002 at 12:18:21PM -0800, Andre Hedrick wrote:
> 
> > > > Again, the HOST(Linux) is not following the device side rules so expect
> > > > difficulty when we depart.  The Brain Damage is how to talk to the
> > > > hardware, and it is clear we are not doing it right because we are bending
> > > > the rules stuff it into and API that not acceptable.  However we are
> > > > stuck.  Again, simplicity works, generate a MEMPOOL for PIO such that the
> > > > buffer pages are contigious and the 4k page dance is a NOOP.  Until that
> > > > time we will be fussing about.
> > > 
> > > Andre,
> > > 
> > > Do you know how to say "I was wrong"? You are walking off-track again.
> > > It's clearly the way that Vojtech and I describe, otherwise current code
> > > would just not work. And 2.4, 2.2, 2.0 neither.
> > 
> > I will and have done so in the past when I am, and it would be nice if you
> > and Linus could do the same.  However since both are going to enforce the
> > partial completion of IO on page boundaries or 4k, and you are not
> > allowed to pause or stop in the middle of a command execution to play
> > memory games under ATA/IDE PIO rules, period.
> 
> Maybe I'm again totally off-the-track, but I see no reason why I
> couldn't stop in the middle of a PIO transfer (that is anytime, not even
> on a sector boundary), do whatever I wish, like change the destination
> buffer or whatever, and then continue. Sure, I can't send ANY commands
> to the drive, and reading the status might not be a good idea either,
> but I believe I can do anything else on the system. Is there a reason
> why this shouldn't be possible?

Okay if the execution of the command block is ATOMIC, and we want to stop
an ATOMIC operation to go alter buffers?  But that is not the real
question.  The real question is do we stop and ATOMIC process to return
data of a partial completeion, and then return to a HALTED ATOMIC and hope
it will still go?

DEAD Method:
issue atomic write 255 sectors
	write 8 sector or 4k or 1 page of memory

	interrupt_issued
		exit atomic write
			update top layer buffers
			return;
	continue write_loop;
	exit on completion and update remainder.

BASTARDIZED Method:
issue write 255 sectors
	truncate to max of 8 sectors
	issue atomic write 8 sectors
		interrupt_issued
		end request and notify 4k page complete
	make new request and merge and repeat.
	note there is a new memcpy fo new request. (max 16 to completion)


OLD Method, with Request Page Walking:
issue atomic write 255 sectors
        write sectors
        interrupt_issued
		walk copy of request
	continue write_loop;
	exit on completion and request and free local buffer.

CORRECT Method:
collect contigious physical buffer of 255 sectors
memcpy_to_local (one memcpy)
issue atomic write 255 sectors
	write sectors
	interrupt_issued
		update pointer
	continue write_loop;
	exit on completion and request and free local buffer.

The price of the overhead and the direct flakyness of the driver we are
running from is returning, so the alternative is to disable MULTI-Sector
Operations.

Respectfully,

Andre Hedrick
Linux Disk Certification Project                Linux ATA Development

