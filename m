Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280836AbRK1WTv>; Wed, 28 Nov 2001 17:19:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280843AbRK1WTl>; Wed, 28 Nov 2001 17:19:41 -0500
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:63495 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S280836AbRK1WT3>; Wed, 28 Nov 2001 17:19:29 -0500
Date: Wed, 28 Nov 2001 23:19:25 +0100
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Journaling pointless with today's hard disks?
Message-ID: <20011128231925.A7034@emma1.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10111261229190.8817-100000@master.linux-ide.org> <01112715312104.01486@localhost> <20011128194302.A29500@emma1.emma.line.org> <01112813462404.01163@driftwood>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <01112813462404.01163@driftwood>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Nov 2001, Rob Landley wrote:

> Not my area of expertise.  Depends how cheap they're being, I'd guess.  
> Writing multiple tracks concurrently is probably more of a current drain than 
> writing a single track at a time anyway, by the way.

Yes, and you need multiple write amplifiers and programmable filters
(remember we do zoned recording nowadays) rather than just a set of
switches.

> > Effectively, that's what tagged command queueing is all about, send a
> > batch of requests that can be acknowledged individually and possibly out
> > of order (which can lead to a trivial write barrier as suggested
> > elsewhere, because all you do is wait with scheduling until the disk is
> > idle, then send the past-the-barrier block).
> 
> Doesn't stop the "die in the middle of a write=crc error" problem.  And I'm 

Not quite, but once you start journalling the buffer you can also write
tag data -- or you know to discard the journal block when it has a CRC
error and just rewrite it.

> been out there forever and not everybody's done it yet, and this is a 
> potentially simpler alternative focusing on the minimal duct-tape approach to 
> reliability by reducing the level of guarantees you have to make.

Yup.

> > On modern drives, bad sectors are reassigned within the same track to
> > evade seeks for a single bad block. If the spare block area within that
> > track is exhausted, bad luck, you're going to seek.
> 
> Cool then.

I did a complete read-only benchmark of an old IBM DCAS which had like
300 grown defects and which I low-level formatted. Around the errors, it
would seek, and the otherwise good performance would drop to the floor
almost. Not sure whether that already had a strategy similar to that of
the DTLAs or just too many blocks went boom.

> Assuming the drive's inherent bad-block detection mechanisms don't find it 
> and remap it on a read first, rapidly consuming the spare block reserve.  But 
> that's a firmware problem...

Drives should never reassign blocks on read operations, because they'd
take away the chance to try to read that block for say four hours.

> I'm proposing a cheap and easy improvement over the current system.  I'm not 
> proposing a system hardened to military specifications, just something that 
> shouldn't fail noticeably for the majority of its users on a regular basis.  
> (Powering down without flushing the cache is a bad thing.  It shouldn't 
> happen often.  This is a last ditch deal-with-evil safety net system that has 
> a fairly good chance of saving the data without extensively redesigning the 
> whole system.  Never said it was perfect.  If a "1 in 2" failure rate drops 
> to "1 in 100,000", it'll still hit people.  But it's a distinct improvement.  
> Maybe it can be improved beyond that.  That would be nice.  What's the 
> effort, expense, and inconvenience involved?)

As always, the first 90% to perfection consume 10% of the efforts, but
the last 10% to perfection consume the other 90% of the efforts :-)

I'm just proposing to make sure that the margin is not too narrow when
you're writing your last blocks to the disk when you know power is
failing. I'm still wondering if flash memory is really more effort than
saving all the energy to keep this expensive mechanics going properly.

-- 
Matthias Andree

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."         Benjamin Franklin
