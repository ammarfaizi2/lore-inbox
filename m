Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263089AbREWNts>; Wed, 23 May 2001 09:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263087AbREWNti>; Wed, 23 May 2001 09:49:38 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:4112 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263056AbREWNtZ>; Wed, 23 May 2001 09:49:25 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Edgar Toernig <froese@gmx.de>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
Date: Wed, 23 May 2001 15:50:39 +0200
X-Mailer: KMail [version 1.2]
Cc: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0105220957400.19818-100000@waste.org> <0105221851200C.06233@starship> <3B0B3A4C.FD7143F9@gmx.de>
In-Reply-To: <3B0B3A4C.FD7143F9@gmx.de>
MIME-Version: 1.0
Message-Id: <0105231550390K.06233@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 May 2001 06:19, Edgar Toernig wrote:
> Daniel Phillips wrote:
> > On Tuesday 22 May 2001 17:24, Oliver Xymoron wrote:
> > > On Mon, 21 May 2001, Daniel Phillips wrote:
> > > > On Monday 21 May 2001 19:16, Oliver Xymoron wrote:
> > > > > What I'd like to see:
> > > > >
> > > > > - An interface for registering an array of related devices
> > > > > (almost always two: raw and ctl) and their legacy device
> > > > > numbers with a single userspace callout that does whatever
> > > > > /dev/ creation needs to be done. Thus, naming and permissions
> > > > > live in user space. No "device node is also a directory"
> > > > > weirdness...
> > > >
> > > > Could you be specific about what is weird about it?
> > >
> > > *boggle*
> > >
> > >[general sense of unease]
>
> I fully agree with Oliver.  It's an abomination.

We are, or at least, I am, investigating this question purely on
technical grounds - name calling is a noop.  I'd be happy to find a
real reason why this is a bad idea but so far none has been
presented.

Don't get me wrong, the fact that people I respect have reservations
about the idea does mean something to me, but this still needs to be
investigated properly.  Now on to the technical content...

> > > I don't think it's likely to be even workable. Just consider the
> > > directory entry for a moment - is it going to be marked d or
> > > [cb]?
> >
> > It's going to be marked 'd', it's a directory, not a file.
>
> Aha.  So you lose the S_ISCHR/BLK attribute.

Readdir fills in a directory type, so ls sees it as a directory and does
the right thing.  On the other hand, we know we're on a device 
filesystem so we will next open the name as a regular file, and find
ISCHR or ISBLK: good.

The rule for this filesystem is: if you open with O_DIRECTORY then
directory operations are permitted, nothing else.  If you open without
O_DIRECTORY then directory operations are forbidden (as
usual) and normal device semantics apply.

If there is weirdness anywhere, it's right here with this rule.  The
question is: what if anything breaks?

> > > If it doesn't have the directory bit set, Midnight commander
> > > won't let me look at it, and I wouldn't blame cd or ls for
> > > complaining. If it does have the 'd' bit set, I wouldn't blame
> > > cp, tar, find, or a million other programs if they did the wrong
> > > thing. They've had 30 years to expect that files aren't
> > > directories. They're going to act weird.
> >
> > No problem, it's a directory.
>
> Directories are not allowed to be read from/written to.  The VFS may
> support it, but it's not (current) UNIX.

Here, we obey this rule: if you open it with O_DIRECTORY then you
can't read from or write to it.

> > > Linus has been kicking this idea around for a couple years now
> > > and it's still a cute solution looking for a problem. It just
> > > doesn't belong in UNIX.
> >
> > Hmm, ok, do we still have any *technical* reasons?
>
> So with your definition, I have a fs-object that is marked as a
> directory but opening it opens a device.  Pretty nice..

No, you have to open it without O_DIRECTORY to get your device
fd handle.

> How I'm supposed to list it's contents?  open+readdir?

Nothing breaks here, ls works as it always did.

This is what ls does:

open("foobar", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
fstat(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
fcntl64(0x3, 0x2, 0x1, 0x2)             = -1 ENOSYS (Function not implemented)
fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
brk(0x805b000)                          = 0x805b000
getdents64(0x3, 0x8058270, 0x1000, 0x26) = -1 ENOSYS (Function not implemented)
getdents(3, /* 2 entries */, 2980)      = 28
getdents(3, /* 0 entries */, 2980)      = 0
close(3)                                = 0

Note that ls doesn't do anything as inconvenient as opening 
foobar as a normal file first, expecting that operation to fail.

> But the open has nasty side effects.
> So you have a directory that you are not allowed
> to list (because of the possible side effects) but is allowed to be
> read from/written to maybe even issue ioctls to?. 

No, you would get side effects only if you open as a regular file.
I'd agree that that sucks, but that's not what we're trying to fix
just now.

> And you call that sane???

I would hope it seems saner now, after the clarification.
Please, if you know something that actually breaks, tell me.

--
Daniel
