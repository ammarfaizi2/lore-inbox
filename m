Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315525AbSGOPPv>; Mon, 15 Jul 2002 11:15:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316167AbSGOPPu>; Mon, 15 Jul 2002 11:15:50 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:27144 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S315525AbSGOPPt>; Mon, 15 Jul 2002 11:15:49 -0400
Date: Mon, 15 Jul 2002 17:18:33 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
Message-ID: <20020715151833.GA22828@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020715075221.GC21470@uncarved.com> <Pine.LNX.3.95.1020715084232.22834A-100000@chaos.analogic.com> <20020715133507.GF32155@merlin.emma.line.org> <s5gwurxt59x.fsf@egghead.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5gwurxt59x.fsf@egghead.curl.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2002, Patrick J. LoPresti wrote:

> I do not recall anything about data=ordered or data=journal mode being
> required.  I thought someone authoritative (Stephen Tweedie?) said
> that ext3 happens to commit the journal on fsync(), independent of the
> journaling mode, but that this behavior was an implementation
> coincidence and not guaranteed.  (Unfortunately, I am having trouble
> finding that message...  Can someone familiar with the source confirm
> or deny this?)

I know about the "happens to...", but I think after that discussion,
they'd keep it that way.

The data= mode was not part of the past discussion, that's why I brought
this up now. However, reiserfs or ext3fs with data=writeback only
journal the fsync() metadata involved, not the order of data (file
contents) versus directory contents, so you can end up with a "crash -
journal replay - file with bogus contents" scenario. I've seen this
happen on ReiserFS and I was not too fond of it, particularly not as I
don't have "fast-access" backups, I need to read a full file from SLR
tape up to the point where the desired file is stored.

> I would love to know what IS guaranteed.  This fsync() question keeps
> cropping up, and as far as I know there is no authoritative statement
> anywhere about what Linux promises.  "Read the source code" is the

Indeed not, and a "file system codex" to document these guarantees in
respect to path names, with link, rename, directory updates should be
documented authoritatively and should be valid for one kernel revision
until the next version (i. e. if documented 2.4.18+, it must not change
before 2.5.x).

> > That aside, it would really useful to get this "hog a writer" issue
> > ironed out either way, and that the illogical "fsync() a O_RDONLY"
> > file be resolved somehow.
> 
> It is a non-issue; no resolution is necessary.  If I can even read or
> write a single file on the same DISK (or bus) that some server process
> uses, I can "hog its resources" and slow it down.  Horrors!  Is there
> any solution???  Oh yeah, don't let me do that.

[IRONY DETECTED]

Seriously: imagine another process that opens the file your process
is writing into, but it itself has no write permission -- and busy loops
on fsync(). Should this fsync process really trigger flushing your
blocks although it has no write permissions, this _is_ a problem unless
you have some decent tagged queueing in place.

fsync() as per open group base specs issue 6 is allowed to return EBADF,
EINTR, EINVAL, EIO. Returning EINVAL for fsync(fd) after fd =
open("blah", O_RDONLY) does not sound unreasonable. You have nothing to
write in O_RDONLY, use O_RDWR or O_WRONLY instead.

> The only interesting question here is what the relevant standards say.
> And if they allow fsync() at all on a read-only descriptor, then there
> is pretty clearly only one thing that can mean.  If you have a problem
> with this behavior, then configure your precious servers to keep their
> data unreadable by untrusted parties.

Or moke fsync() a no-op, meaning "your process (group) has no data to
write", or return error... EINVAL.

> > Is fsync()ing directories any portable?
> 
> No, but apparently it is what Linux supports.  If this were documented
> clearly somewhere, maybe application authors could be convinced to
> support it.

I don't think so. They'd rather declare ReiserFS unsupported and go with
chattr +S. Seen that.

New implementations (Courier's maildrop) still rely on BSD FFS
"synchronous directory" semantics.

-- 
Matthias Andree
