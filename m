Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288114AbSAVHU6>; Tue, 22 Jan 2002 02:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288716AbSAVHUt>; Tue, 22 Jan 2002 02:20:49 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:4370 "HELO mail.pha.ha-vel.cz")
	by vger.kernel.org with SMTP id <S288114AbSAVHUi>;
	Tue, 22 Jan 2002 02:20:38 -0500
Date: Tue, 22 Jan 2002 08:20:30 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andre Hedrick <andre@linuxdiskcert.org>
Cc: Jens Axboe <axboe@suse.de>, Davide Libenzi <davidel@xmailserver.org>,
        Anton Altaparmakov <aia21@cam.ac.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.5.3-pre1-aia1
Message-ID: <20020122082030.A12720@suse.cz>
In-Reply-To: <20020121235743.A28134@suse.cz> <Pine.LNX.4.10.10201211535030.15703-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10201211535030.15703-100000@master.linux-ide.org>; from andre@linuxdiskcert.org on Mon, Jan 21, 2002 at 03:53:20PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2002 at 03:53:20PM -0800, Andre Hedrick wrote:
> On Mon, 21 Jan 2002, Vojtech Pavlik wrote:
> 
> > On Mon, Jan 21, 2002 at 12:18:21PM -0800, Andre Hedrick wrote:
> > 
> > > > > Again, the HOST(Linux) is not following the device side rules so expect
> > > > > difficulty when we depart.  The Brain Damage is how to talk to the
> > > > > hardware, and it is clear we are not doing it right because we are bending
> > > > > the rules stuff it into and API that not acceptable.  However we are
> > > > > stuck.  Again, simplicity works, generate a MEMPOOL for PIO such that the
> > > > > buffer pages are contigious and the 4k page dance is a NOOP.  Until that
> > > > > time we will be fussing about.
> > > > 
> > > > Andre,
> > > > 
> > > > Do you know how to say "I was wrong"? You are walking off-track again.
> > > > It's clearly the way that Vojtech and I describe, otherwise current code
> > > > would just not work. And 2.4, 2.2, 2.0 neither.
> > > 
> > > I will and have done so in the past when I am, and it would be nice if you
> > > and Linus could do the same.  However since both are going to enforce the
> > > partial completion of IO on page boundaries or 4k, and you are not
> > > allowed to pause or stop in the middle of a command execution to play
> > > memory games under ATA/IDE PIO rules, period.
> > 
> > Maybe I'm again totally off-the-track, but I see no reason why I
> > couldn't stop in the middle of a PIO transfer (that is anytime, not even
> > on a sector boundary), do whatever I wish, like change the destination
> > buffer or whatever, and then continue. Sure, I can't send ANY commands
> > to the drive, and reading the status might not be a good idea either,
> > but I believe I can do anything else on the system. Is there a reason
> > why this shouldn't be possible?
> 
> Okay if the execution of the command block is ATOMIC, and we want to stop
> an ATOMIC operation to go alter buffers? 

YES! I think you got it! Because atomic here doesn't mean 'do it all as
soon as possible with no delay', but 'do nothing else on the ATA bus
inbetween'.

> But that is not the real question.  The real question is do we stop
> and ATOMIC process to return data of a partial completeion, and then
> return to a HALTED ATOMIC and hope it will still go?

Yes, and we can do this, and there is no reason why this should not
work.

> DEAD Method:
> issue atomic write 255 sectors
> 	write 8 sector or 4k or 1 page of memory
> 
> 	interrupt_issued
> 		exit atomic write
> 			update top layer buffers
> 			return;
> 	continue write_loop;
> 	exit on completion and update remainder.
> 
> BASTARDIZED Method:
> issue write 255 sectors
> 	truncate to max of 8 sectors
> 	issue atomic write 8 sectors
> 		interrupt_issued
> 		end request and notify 4k page complete
> 	make new request and merge and repeat.
> 	note there is a new memcpy fo new request. (max 16 to completion)
> 
> 
> OLD Method, with Request Page Walking:
> issue atomic write 255 sectors
>         write sectors
>         interrupt_issued
> 		walk copy of request
> 	continue write_loop;
> 	exit on completion and request and free local buffer.
> 
> CORRECT Method:
> collect contigious physical buffer of 255 sectors
> memcpy_to_local (one memcpy)
> issue atomic write 255 sectors
> 	write sectors
> 	interrupt_issued
> 		update pointer
> 	continue write_loop;
> 	exit on completion and request and free local buffer.
> 
> The price of the overhead and the direct flakyness of the driver we are
> running from is returning, so the alternative is to disable MULTI-Sector
> Operations.

That's pretty much nonsense, beg my pardon. The real correct way would
be:

issue read of 255 sectors using READ_MULTI, max_mult = 16
receive interrupt
	inw() first 4k to buffer A
	inw() second 4k to buffer B
don't do anything else until the next interrupt

There is absolutely no need for an intermediate scratch buffer, you can
put the inw()ed data anywhere you like, and if you need any post
processing, you can do it as well, at any time.

-- 
Vojtech Pavlik
SuSE Labs
