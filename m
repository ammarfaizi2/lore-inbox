Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280725AbRK1Vr6>; Wed, 28 Nov 2001 16:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280761AbRK1Vrt>; Wed, 28 Nov 2001 16:47:49 -0500
Received: from femail1.sdc1.sfba.home.com ([24.0.95.81]:17363 "EHLO
	femail1.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S280725AbRK1Vrf>; Wed, 28 Nov 2001 16:47:35 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Date: Wed, 28 Nov 2001 13:46:24 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org> <01112715312104.01486@localhost> <20011128194302.A29500@emma1.emma.line.org>
In-Reply-To: <20011128194302.A29500@emma1.emma.line.org>
MIME-Version: 1.0
Message-Id: <01112813462404.01163@driftwood>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is wandering far enough off topic that I'm not going to CC l-k after 
this message...


On Wednesday 28 November 2001 13:43, Matthias Andree wrote:
> On Tue, 27 Nov 2001, Rob Landley wrote:
> > On Tuesday 27 November 2001 11:50, Matthias Andree wrote:
> > > Note, the power must RELIABLY last until all of the data has been
> > > writen, which includes reassigning, seeking and the like, just don't do
> > > it if you cannot get a real solution.
> >
> > A) At most 1 seek to a track other than the one you're on.
>
> Not really, assuming drives don't write to multiple heads concurrently,

Not my area of expertise.  Depends how cheap they're being, I'd guess.  
Writing multiple tracks concurrently is probably more of a current drain than 
writing a single track at a time anyway, by the way.

> 2 MB hardly fit on a track. We can assume several hundred sectors, say
> 1,000, so we need four track writes, four verifies, and not a single
> block may be broken. We need even more time if we need to rewrite.

A 7200 RPM drive does 120 RPS, which means one revolution is 8.3 miliseconds. 
 We're still talking a deterministic number of miliseconds with a 
double-digit total.

And again, it depends on how you define "track".  If you talk about the two 
tracks you can buffer as living on seperate sides of platters you can't write 
to concurrently (not necessarily separated by a seek), then there is still no 
problem.  (After the first track writes and it starts on the second track, 
the system still has 8.3 ms later to buffer another track before it drops 
below full writing speed.

It's all a question of limiting how much you buffer to what you can flush 
out.  Artificial objections about "I could have 8 zillion platters I can only 
write to one at a time" just means you're buffering too much to write out 
then.

> > That's it.  No more buffer than does good at the hardware level for
> > request merging and minimizing seek latency.  Any buffering over and
> > above that is the operating system's job.
>
> Effectively, that's what tagged command queueing is all about, send a
> batch of requests that can be acknowledged individually and possibly out
> of order (which can lead to a trivial write barrier as suggested
> elsewhere, because all you do is wait with scheduling until the disk is
> idle, then send the past-the-barrier block).

Doesn't stop the "die in the middle of a write=crc error" problem.  And I'm 
not saying tagged command queueing is a bad idea, I'm just saying the idea's 
been out there forever and not everybody's done it yet, and this is a 
potentially simpler alternative focusing on the minimal duct-tape approach to 
reliability by reducing the level of guarantees you have to make.

> > (Relocating bad sectors breaks this, but not fatally.  It causes extra
> > seeks in linear writes anyway where the elevator ISN'T involved, so
> > you've already GOT a performance hit.
>
> On modern drives, bad sectors are reassigned within the same track to
> evade seeks for a single bad block. If the spare block area within that
> track is exhausted, bad luck, you're going to seek.

Cool then.

> > The advantage of limiting the amount of data buffered to current track
> > plus one other is you have a fixed amount of work to do on a loss of
> > power.  One seek, two track writes, and a spring-driven park.  The amount
> > of power this takes has a deterministic upper bound.  THAT is why you
> > block before accepting more data than that.
>
> It has not, you don't know in advance how many blocks on your journal
> track are bad.

Another reason to not worry about an explicit dedicatedjournal track and just 
buffer one extra normal data track and budget in the power for a seek to it 
if necessary.

There are circumstances where this will break down, sure.  Any disk that has 
enough bad sectors on it will stop working.  But that shouldn't be the normal 
case on a fresh drive, as is happening now with IBM.

> > You dont' need several seconds.  You need MILISECONDS.  Two track writes
> > and one seek.  This is why you don't accept more data than that before
> > blocking.
>
> No, you must verify the write, so that's one seek (say 35 ms, slow
> drive ;) and two revolutions per track at least, and, as shown, more
> than one track usually

So don't buffer 4 tracks and call it one track.  That's an artificial 
objection.

An extra revolution is less than a seek, and noticeably less in power terms.

>, so any bets of upper bounds are off. In the
> average case, say 70 ms should suffice, but in adverse conditions, that
> does not suffice at all. If writing the journal in the end fails because
> power is failing, the data is lost, so nothing is gained.
>
> > under 50 miliseconds.  Your huge ram cache is there for reads.  For
> > writes you don't accept more than you can reliably flush if you want
> > anything approaching reliability.
>
> Well, that's the point, you don't know in advance how reliable your
> journal track is.

We don't knkow in advance that the drive won't fail completely due to 
excessive bad blocks.  I'm trying to move the failure point, not pretending 
to eliminate it.  Right now we've got something that could easily take out 
multiple drives in a RAID 5, and something that desktop users are likely to 
see more noticeably more often than they upgrade their system.

> > such fun things.  And in a desktop environment, spilled sodas.) 
> > Currently, there are drives out there that stop writing a sector in the
> > middle, leaving a bad CRC at the hardware level.  This isn't exactly
> > graceful.  At the other end, drives with huge caches discard the contents
> > of cache which a journaling filesystem thinks are already on disk.  This
> > isn't graceful either.
>
> No-one said bad things cannot happen, but that is what actually happens.
> Where we started from, fsck would be able to "repair" a bad block by
> just zeroing and writing it, data that used to be there will be lost
> after short write anyhow.

Assuming the drive's inherent bad-block detection mechanisms don't find it 
and remap it on a read first, rapidly consuming the spare block reserve.  But 
that's a firmware problem...

> Assuming that write errors on an emergency cache flush just won't happen
> is just as wrong as assuming 640 kB will suffice or there's an upper
> bound of write time. You just don't know.

I don't assume they won't happen.  They're actually more LIKELY to happen as 
the power level gradually drops as the capacitor discharges.  I'm just saying 
there's a point beyond which any given system can't recover, and a point of 
diminishing returns trying to fix things.

I'm proposing a cheap and easy improvement over the current system.  I'm not 
proposing a system hardened to military specifications, just something that 
shouldn't fail noticeably for the majority of its users on a regular basis.  
(Powering down without flushing the cache is a bad thing.  It shouldn't 
happen often.  This is a last ditch deal-with-evil safety net system that has 
a fairly good chance of saving the data without extensively redesigning the 
whole system.  Never said it was perfect.  If a "1 in 2" failure rate drops 
to "1 in 100,000", it'll still hit people.  But it's a distinct improvement.  
Maybe it can be improved beyond that.  That would be nice.  What's the 
effort, expense, and inconvenience involved?)

Rob
