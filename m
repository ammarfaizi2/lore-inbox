Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280365AbRK1Tzj>; Wed, 28 Nov 2001 14:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280592AbRK1Tza>; Wed, 28 Nov 2001 14:55:30 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:19204 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S280556AbRK1TzP> convert rfc822-to-8bit; Wed, 28 Nov 2001 14:55:15 -0500
Date: Wed, 28 Nov 2001 19:43:02 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011128194302.A29500@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org> <0111261535070J.02001@localhost.localdomain> <20011127175016.D13416@emma1.emma.line.org> <01112715312104.01486@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <01112715312104.01486@localhost>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2001, Rob Landley wrote:

> On Tuesday 27 November 2001 11:50, Matthias Andree wrote:
> > Note, the power must RELIABLY last until all of the data has been
> > writen, which includes reassigning, seeking and the like, just don't do
> > it if you cannot get a real solution.
> 
> A) At most 1 seek to a track other than the one you're on.

Not really, assuming drives don't write to multiple heads concurrently,
2 MB hardly fit on a track. We can assume several hundred sectors, say
1,000, so we need four track writes, four verifies, and not a single
block may be broken. We need even more time if we need to rewrite.

> That's it.  No more buffer than does good at the hardware level for request 
> merging and minimizing seek latency.  Any buffering over and above that is 
> the operating system's job.

Effectively, that's what tagged command queueing is all about, send a
batch of requests that can be acknowledged individually and possibly out
of order (which can lead to a trivial write barrier as suggested
elsewhere, because all you do is wait with scheduling until the disk is
idle, then send the past-the-barrier block).

> (Relocating bad sectors breaks this, but not fatally.  It causes extra seeks 
> in linear writes anyway where the elevator ISN'T involved, so you've already 
> GOT a performance hit.

On modern drives, bad sectors are reassigned within the same track to
evade seeks for a single bad block. If the spare block area within that
track is exhausted, bad luck, you're going to seek.

> The advantage of limiting the amount of data buffered to current track plus 
> one other is you have a fixed amount of work to do on a loss of power.  One 
> seek, two track writes, and a spring-driven park.  The amount of power this 
> takes has a deterministic upper bound.  THAT is why you block before 
> accepting more data than that.

It has not, you don't know in advance how many blocks on your journal
track are bad.

> You dont' need several seconds.  You need MILISECONDS.  Two track writes and 
> one seek.  This is why you don't accept more data than that before blocking.  

No, you must verify the write, so that's one seek (say 35 ms, slow
drive ;) and two revolutions per track at least, and, as shown, more
than one track usually, so any bets of upper bounds are off. In the
average case, say 70 ms should suffice, but in adverse conditions, that
does not suffice at all. If writing the journal in the end fails because
power is failing, the data is lost, so nothing is gained.

> under 50 miliseconds.  Your huge ram cache is there for reads.  For writes 
> you don't accept more than you can reliably flush if you want anything 
> approaching reliability. 

Well, that's the point, you don't know in advance how reliable your
journal track is. Worst case means: you need to consume every single
spare block until the cache is flushed. Your point about write caching
is valid, and IBM documentation for DTLA drives (minus their apparent
other issues) declares that the write cache will be ignored when the
spare block count is low.

> such fun things.  And in a desktop environment, spilled sodas.)  Currently, 
> there are drives out there that stop writing a sector in the middle, leaving 
> a bad CRC at the hardware level.  This isn't exactly graceful.  At the other 
> end, drives with huge caches discard the contents of cache which a journaling 
> filesystem thinks are already on disk.  This isn't graceful either.

No-one said bad things cannot happen, but that is what actually happens.
Where we started from, fsck would be able to "repair" a bad block by
just zeroing and writing it, data that used to be there will be lost
after short write anyhow.

> If a block goes bad WHILE power is failing, you're screwed.  This is just a 
> touch unlikely.  It will happen to somebody out there someday, sure.  So will 
> alpha particle decay corrupting a sector that was long ago written to the 
> drive correctly.  Designing for that is not practical.  Recovering after the 
> fact might be, but that doesn't mean you get your data back.

Alpha particles still need to fight against inner (bit-wise) and outer
(symbol- and blockwise) error correction codes, and Alpha particles
don't usually move Bloch walls or get near the coercivity otherwise.
We're talking about magnetic media, not E²PROMs or something.

Assuming that write errors on an emergency cache flush just won't happen
is just as wrong as assuming 640 kB will suffice or there's an upper
bound of write time. You just don't know.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
