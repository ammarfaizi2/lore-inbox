Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317568AbSGOSOC>; Mon, 15 Jul 2002 14:14:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317570AbSGOSOB>; Mon, 15 Jul 2002 14:14:01 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:56591 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S317568AbSGOSN7>; Mon, 15 Jul 2002 14:13:59 -0400
Date: Mon, 15 Jul 2002 20:16:50 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
Message-ID: <20020715181650.GA20665@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20020715075221.GC21470@uncarved.com> <Pine.LNX.3.95.1020715084232.22834A-100000@chaos.analogic.com> <20020715133507.GF32155@merlin.emma.line.org> <s5gwurxt59x.fsf@egghead.curl.com> <20020715151833.GA22828@merlin.emma.line.org> <s5g4rf1t1j6.fsf@egghead.curl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5g4rf1t1j6.fsf@egghead.curl.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jul 2002, Patrick J. LoPresti wrote:

> Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:
> 
> > The data= mode was not part of the past discussion, that's why I
> > brought this up now. However, reiserfs or ext3fs with data=writeback
> > only journal the fsync() metadata involved, not the order of data
> > (file contents) versus directory contents, so you can end up with a
> > "crash - journal replay - file with bogus contents" scenario.
> 
> This should not happen with a properly written application.  fsync()
> flushes a bunch of stuff to disk, but it normally makes no promise
> about the ORDER in which that stuff goes out.  fsync() itself is how
> application authors can enforce an ordering on disk operations.

Well, to some extent.

> For example, a typical MTA might follow this paradigm:
> 
>     write temp file
>     fsync()
>     rename temp file to destination
>     fsync()

So does fsync() guarantee rename() persistence across crash on all file
systems and kernel versions? IIRC, no.

We might want to fill in a table, on the rows kernel release and file
system, on the columns whether 1. fsync() syncs all directory updates up
to the root, 2. fsync() syncs rename properly, 3. fsync() syncs link, 4.
fsync() syncs unlink (not too important, at least not for an MTA, if you
ask me), 5. offers dirsync, 6. has dirsync on by default.

Very raw draft:

Linux 2.0
ext2
ufs

Linux 2.2
ufs
ext2
ext3 0.0.7<mumble>
reiserfs 3.5
jfs
xfs? don't think so.

Linux 2.4
ufs
ext2
ext3 0.9.x   1. yes 2. yes 3. yes 4. ? 5. use patch, use sync, use chattr +S 6. no
reiserfs 3.5
reiserfs 3.6 1. yes 2. yes 3. yes 4. ? 5. no, use sync 6. no
jfs 1.0
xfs 1.0
xfs 1.1
you name it

And for completeness:
Free/Net/OpenBSD
ffs 1. yes 2. yes 3. yes 4. yes 5. yes 6. yes
ffs softupdates 1. yes 2. yes 3. yes 4. ? 5. no 6. no
ext2
ufs
lfs

^ editor vacancy...


>     report success
> 
> (Yes, I know, "link/unlink" is more common in practice than rename().
> But the principle is the same.)

doesn't matter except that unlink over a crash is usually unsafe, the
file may reappear.

> Or, in the case of Postfix:
> 
>     write message file
>     fsync()
>     chmod +x message file
>     fsync()
>     report success

That'd be inefficient for the double fsync(). Postfix is ahead of that:
it omits the first fsync() you suggest, because the +x flag, while
necessary, is not sufficient to mark the mail as "complete, further
processing allowed". The "message file" is a structured file format that
has an "end" record at the end of the file.  The +x flag must be set AND
this end marker must be present for Postfix to treat the message file.
So the +x flag is just an accelerator for the concurrent reader that
won't even bother to look into the file that lacks the +x flag.

write - fchmod - fsync - close -> 250 Ok is therefore sound in Postfix.

(but beware of chmod, in publicly accessible places like /tmp, this can
be prone to races, use fchmod if you have an open file descriptor at
hand).

> An MTA has two ordering constraints:
> 
>   1) Data must be flushed to disk before it is marked on disk as
>      "committed".  This is to ensure that, after a crash, the MTA does
>      not read a corrupted mail file.
> 
>   2) Data must be marked on disk as "committed" before a success code
>      is reported to the remote MTA.  This is to ensure that no mail is
>      lost.
> 
> The ext3 data=ordered mode enforces the first constraint for mailers
> using the "rename" paradigm, eliminating the need for the first
> fsync() call.  But any MTA which relies on data=ordered semantics is
> not only Linux-specific, but ext3/reiserfs specific!

You're right for the MTA AFAICT.

But let's keep this unspecific to the MTA. Unless fsync() is used to
enforce ordering, without data=ordered, journalled file systems can
"recreate" files that are not there. Undead you may call them if you so
like...

Let me claim that fsync() is beyond the common hobbyist hacker. Yes, I
have just put Asbestos underwear on :-)

> Synchronous directory updates, a la FFS, enforce the second constraint
> (again for the "rename" paradigm), eliminating the need for the second
> fsync().

...or for systems that don't sync the "new" path name created with
rename(2) from an open file descriptor...

> But to be robust across platforms and file systems, a mailer needs
> both fsync() calls.  (On Linux, you actually need to fsync() the
> *directory*, not the file, for the "rename" paradigm.  It would be
> nice if we could convince MTA authors to do this.)

...and this will not likely happen with Postfix. Wietse uses chattr +S,
and the Postfix queue only works reliably on systems that either (any
one alone is sufficient):

1. mount the file system containing /var/spool/postfix with -o sync
2. support chattr +S /var/spool/postfix
3. behave the way BSD softdeps do, where fsync() also syncs all
   directory changes involved in a rename(2), all the way up to the mount
   point.

Postfix' local(8) daemon additionally relies on rename(2) being
synchronous (in Maildir delivery), it does not fsync() after rename.
OTOH, the file is completely in Maildir/tmp/somename, so it's not really
lost, just invisible.

It'd be interesting if chattr +S Maildir/tmp/ would be sufficient to
make the rename ("tmp/somefile", "cur/somefile") persistent.

> > New implementations (Courier's maildrop) still rely on BSD FFS
> > "synchronous directory" semantics.
> 
> Are you sure?  Because that is ridiculous...  Modern BSDs like to use
> "soft updates", which need that second fsync() to commit the metadata.

Unless I misread maildrop, yes. Anyone is free to show otherwise, and I
will apologize for this false claim.

> Summary: *All* MTAs should call fsync() twice.  The only issue is what
> descriptors they should call it on, exactly :-).

See above. Before that, we must know that fsync() syncs all directory
and file data and metadata (that makes four) all the way up to the mount
point. For Linux 2.0, 2.2, 2.4. For any file system and any mount
option. See the table project above ;-)

-- 
Matthias Andree
