Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262991AbREWElx>; Wed, 23 May 2001 00:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262992AbREWEln>; Wed, 23 May 2001 00:41:43 -0400
Received: from pop.gmx.net ([194.221.183.20]:19691 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262990AbREWEl0>;
	Wed, 23 May 2001 00:41:26 -0400
Message-ID: <3B0B3A4C.FD7143F9@gmx.de>
Date: Wed, 23 May 2001 06:19:25 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <Pine.LNX.4.30.0105220957400.19818-100000@waste.org> <0105221851200C.06233@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Tuesday 22 May 2001 17:24, Oliver Xymoron wrote:
> > On Mon, 21 May 2001, Daniel Phillips wrote:
> > > On Monday 21 May 2001 19:16, Oliver Xymoron wrote:
> > > > What I'd like to see:
> > > >
> > > > - An interface for registering an array of related devices
> > > > (almost always two: raw and ctl) and their legacy device numbers
> > > > with a single userspace callout that does whatever /dev/ creation
> > > > needs to be done. Thus, naming and permissions live in user
> > > > space. No "device node is also a directory" weirdness...
> > >
> > > Could you be specific about what is weird about it?
> >
> > *boggle*
> >
> >[general sense of unease]

I fully agree with Oliver.  It's an abomination.

> > I don't think it's likely to be even workable. Just consider the
> > directory entry for a moment - is it going to be marked d or [cb]?
> 
> It's going to be marked 'd', it's a directory, not a file.

Aha.  So you lose the S_ISCHR/BLK attribute.

> > If it doesn't have the directory bit set, Midnight commander won't
> > let me look at it, and I wouldn't blame cd or ls for complaining. If it
> > does have the 'd' bit set, I wouldn't blame cp, tar, find, or a
> > million other programs if they did the wrong thing. They've had 30
> > years to expect that files aren't directories. They're going to act
> > weird.
> 
> No problem, it's a directory.

Directories are not allowed to be read from/written to.  The VFS may
support it, but it's not (current) UNIX.

> > Linus has been kicking this idea around for a couple years now and
> > it's still a cute solution looking for a problem. It just doesn't
> > belong in UNIX.
> 
> Hmm, ok, do we still have any *technical* reasons?

So with your definition, I have a fs-object that is marked as a directory
but opening it opens a device.  Pretty nice.  How I'm supposed to list
it's contents?  open+readdir?  But the open has nasty side effects.
So you have a directory that you are not allowed to list (because of the
possible side effects) but is allowed to be read from/written to maybe
even issue ioctls to?.  And you call that sane???

IMO the whole idea of arguments following the device name is junk (incl
a "/ctrl").

Just think about the implications of the original "/dev/ttyS0/19200"
suggestion.  It sounds nice and tempting.  But which programs will
benefit.  Which gets confused.  What will be cleaned up.  After some
thoughts you'll find out that it's useless ;-)

And with special "ctrl" devices (ie /dev/ttyS0 and /dev/ttyS0ctrl):
This _may_ work for some kind of devices.  But serial ports are one
example where it simply will _not_.  It requires that you know the
name of the device.  For ttys this is often not the case.  Even if
you manage to get some name for stdin for example - now I should
simply attach a "ctrl" to that name to get a control channel???
At least dangerous.  If I'm lucky I only get an EPERM...

Ciao, ET.

