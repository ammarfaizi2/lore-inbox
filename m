Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263699AbREYLA3>; Fri, 25 May 2001 07:00:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263700AbREYLAU>; Fri, 25 May 2001 07:00:20 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:30472 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S263697AbREYLAL>; Fri, 25 May 2001 07:00:11 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Edgar Toernig <froese@gmx.de>
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
Date: Fri, 25 May 2001 13:00:00 +0200
X-Mailer: KMail [version 1.2]
Cc: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.30.0105220957400.19818-100000@waste.org> <0105241925230N.06233@starship> <3B0D763C.26991788@gmx.de>
In-Reply-To: <3B0D763C.26991788@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <0105251300000V.06233@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 May 2001 22:59, Edgar Toernig wrote:
> Daniel Phillips wrote:
> > > > Readdir fills in a directory type, so ls sees it as a directory
> > > > and does the right thing.  On the other hand, we know we're on
> > > > a device filesystem so we will next open the name as a regular
> > > > file, and find ISCHR or ISBLK: good.
> > >
> > > ??? The kernel may know it, but the app?  Or do you really want
> > > to give different stat data on stat(2) and fstat(2)?  These flags
> > > are currently used by archive/backup prgs.  It's a hint that
> > > these files are not regular files and shouldn't be opened for
> > > reading. Having a 'd' would mean that they would really try to
> > > enter the directory and save it's contents.  Don't know what
> > > happens in this case to your "special" files ;-)
> >
> > I guess that's much like the question 'what happens in proc?'.
>
> And that's already bad enough.  Most of the "files" in proc should
> be fifos!  And using proc as an excuse to introduce another set of
> magic dirs?  No, thanks.

Wait a second, I thought proc was here to stay.  Wait another
second, device nodes are already magic.  Magic is magic, just
choose your color ;-)

This set of magic dirs is supposed to clean things up, not mess things 
up.  We already saw how the side-effects-on-open problem in ls -l goes 
away.  There's a much bigger problem I'd love to deal with: the 'no 
heirarchy can please everybody' problem.  In database terms, aheirarchy 
is an insufficiently general model for real-world problems, in other 
words, they never worked.  Tables work.  That's where I'm trying to go 
with this, so please bear with me.  This is not just a solution in 
search of a problem.

> > Correct me if I'm wrong, but what we learn from the proc example
> > is that tarring your whole source tree starting at / is not
> > something you want to do.
>
> IMHO it would be better to fix proc instead of adding more magic.  At
> the moment you have to exclude /proc.  You want to add /dev.

Well, actually no, ls -R, tar, zip, etc, work pretty well with the 
scheme I've described.

> And
> next? Exclude all $HOME/dev (in case process name spaces get added)? 
> Or make fifos magic too and add all of them to the exclude list?  But
> there's no central place for fifos.  So lets add more magic :-(

No, no, no, agreed and sometimes magic is good.  It's not deep magic.  
The only new thing here is the interpretation of the O_DIRECTORY flag, 
or rather, the lack of it.

> > What *won't* happen is, you won't get side effects from opening
> > your serial ports (you'd have to open them without O_DIRECTORY
> > to get that) so that seems like a little step forward.
>
> As already said: depending on O_DIRECTORY breaks POSIX compliance
> and that alone should kill this idea...

Thanks, two good points:
  - libc5 will get confused when doing ls in /magicdev
  - POSIX specifically forbids this

I'll put this away until I've specifically dug into both of them.  OK, 
over and out, thanks for your commentary.

/me peruses man pages

Oops, oh wait, there's already another open point: your breakage 
examples both rely on opening ".".  You're right, "." should always be 
a directory and I believe that's enforced by the VFS.  So we don't have 
an example of breakage yet.

--
Daniel

