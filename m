Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261485AbREXAyu>; Wed, 23 May 2001 20:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261864AbREXAyk>; Wed, 23 May 2001 20:54:40 -0400
Received: from pop.gmx.net ([194.221.183.20]:54094 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261422AbREXAyU>;
	Wed, 23 May 2001 20:54:20 -0400
Message-ID: <3B0C547F.DE9E9214@gmx.de>
Date: Thu, 24 May 2001 02:23:27 +0200
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Oliver Xymoron <oxymoron@waste.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD 
 w/info-PATCH]device arguments from lookup)
In-Reply-To: <Pine.LNX.4.30.0105220957400.19818-100000@waste.org> <0105221851200C.06233@starship> <3B0B3A4C.FD7143F9@gmx.de> <0105231550390K.06233@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> On Wednesday 23 May 2001 06:19, Edgar Toernig wrote:
> > Daniel Phillips wrote:
> > > On Tuesday 22 May 2001 17:24, Oliver Xymoron wrote:
> > > > On Mon, 21 May 2001, Daniel Phillips wrote:
> > > > > On Monday 21 May 2001 19:16, Oliver Xymoron wrote:
> > > > > > What I'd like to see:
> > > > > >
> > > > > > - An interface for registering an array of related devices
> > > > > > (almost always two: raw and ctl) and their legacy device
> > > > > > numbers with a single userspace callout that does whatever
> > > > > > /dev/ creation needs to be done. Thus, naming and permissions
> > > > > > live in user space. No "device node is also a directory"
> > > > > > weirdness...
> > > > >
> > > > > Could you be specific about what is weird about it?
> > > >
> > > > *boggle*
> > > >
> > > >[general sense of unease]
> >
> > I fully agree with Oliver.  It's an abomination.
> 
> We are, or at least, I am, investigating this question purely on
> technical grounds - name calling is a noop.

Right.  But sometimes new ideas raise these kind of feelings ;)

> > > It's going to be marked 'd', it's a directory, not a file.
> >
> > Aha.  So you lose the S_ISCHR/BLK attribute.
> 
> Readdir fills in a directory type, so ls sees it as a directory and does
> the right thing.  On the other hand, we know we're on a device
> filesystem so we will next open the name as a regular file, and find
> ISCHR or ISBLK: good.

??? The kernel may know it, but the app?  Or do you really want to
give different stat data on stat(2) and fstat(2)?  These flags are
currently used by archive/backup prgs.  It's a hint that these files
are not regular files and shouldn't be opened for reading.
Having a 'd' would mean that they would really try to enter the
directory and save it's contents.  Don't know what happens in this
case to your "special" files ;-)

> The rule for this filesystem is: if you open with O_DIRECTORY then
> directory operations are permitted, nothing else.  If you open without
> O_DIRECTORY then directory operations are forbidden (as
> usual) and normal device semantics apply.

As usual?  I think you've just changed the rules for O_DIRECTORY.  Up
to now it's only a flag that tells open it should fail if the name
does not refer to a directory.  Nothing else.  It was introduced to
remove a race condition in user space applications.  Especially it
is optional - everything works the same whether you give the flag
or not (except the race avoidance of course).  And there are a lot
of programs that do not use O_DIRECTORY (it's a Linux private flag,
not even mentioned in POSIX).  Every program that does:

	fd = open(foo, O_RDONLY);
	fchdir(fd);
	x = opendir(".")

will break.  And that is POSIX conform.  And I know that there are
programs that use this when recursively scanning directories (avoids
name mangling and repeated name lookups of the directory on later
stat calls).

> > Directories are not allowed to be read from/written to.  The VFS may
> > support it, but it's not (current) UNIX.
> 
> Here, we obey this rule: if you open it with O_DIRECTORY then you
> can't read from or write to it.

IMHO you've just invented opendir(2).

> Nothing breaks here, ls works as it always did.
> 
> This is what ls does:
> 
> open("foobar", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 3
> fstat(3, {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
> fcntl64(0x3, 0x2, 0x1, 0x2)             = -1 ENOSYS (Function not implemented)
> fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
> brk(0x805b000)                          = 0x805b000
> getdents64(0x3, 0x8058270, 0x1000, 0x26) = -1 ENOSYS (Function not implemented)
> getdents(3, /* 2 entries */, 2980)      = 28
> getdents(3, /* 0 entries */, 2980)      = 0
> close(3)                                = 0
> 
> Note that ls doesn't do anything as inconvenient as opening
> foobar as a normal file first, expecting that operation to fail.

Well, your ls does not work "as it always did".  Here's an strace of
my libc5 system ls:

open(".", O_RDONLY)                     = 3
fcntl(3, F_SETFD, FD_CLOEXEC)           = 0
getdents(3, /* 64 entries */, 4096)     = 1216
getdents(3, /* 9 entries */, 4096)      = 168
getdents(3, /* 0 entries */, 4096)      = 0
close(3)                                = 0

And my find(1) does:

open(".", O_RDONLY)                     = 3
[scan all dirs]
fchdir(3)                               = 0

to return to its initial dir.  Will break too.

> No, you would get side effects only if you open as a regular file.

IMHO your assumption that opening a dir _requires_ O_DIRECTORY is
wrong.  You've put in a new semantic that has not been there and
that will break programs and POSIX conformance.

> Please, if you know something that actually breaks, tell me.

Yeah, see above ;)

Ciao, ET.

