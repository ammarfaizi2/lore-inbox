Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317598AbSGOSxq>; Mon, 15 Jul 2002 14:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317600AbSGOSxp>; Mon, 15 Jul 2002 14:53:45 -0400
Received: from lockupnat.curl.com ([216.230.83.254]:41455 "EHLO
	egghead.curl.com") by vger.kernel.org with ESMTP id <S317598AbSGOSxm>;
	Mon, 15 Jul 2002 14:53:42 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
Distribution: local
References: <20020715075221.GC21470@uncarved.com> <Pine.LNX.3.95.1020715084232.22834A-100000@chaos.analogic.com> <20020715133507.GF32155@merlin.emma.line.org> <s5gwurxt59x.fsf@egghead.curl.com> <20020715151833.GA22828@merlin.emma.line.org> <s5g4rf1t1j6.fsf@egghead.curl.com> <20020715181650.GA20665@merlin.emma.line.org>
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 15 Jul 2002 14:56:36 -0400
In-Reply-To: <mit.lcs.mail.linux-kernel/20020715181650.GA20665@merlin.emma.line.org>
Message-ID: <s5gwurwstuj.fsf@egghead.curl.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:

> > For example, a typical MTA might follow this paradigm:
> > 
> >     write temp file
> >     fsync()
> >     rename temp file to destination
> >     fsync()
> 
> So does fsync() guarantee rename() persistence across crash on all file
> systems and kernel versions? IIRC, no.

It depends on what you fsync() :-).

On BSD, fsync() of a file's descriptor will commit the rename of that
file to disk.

On Linux, fsync() of the *directory's* descriptor is required.  And
yes, this will work across file systems and Linux versions, according
to Linus/Alan/etc.

> That'd be inefficient for the double fsync().

But it is necessary.  See below.

> Postfix is ahead of that: it omits the first fsync() you suggest,
> because the +x flag, while necessary, is not sufficient to mark the
> mail as "complete, further processing allowed". The "message file"
> is a structured file format that has an "end" record at the end of
> the file.

This is not sufficient!  Data writes are NOT guaranteed to be ordered.
It is permissible for the file system to flush the first and last
block of a file to disk BEFORE flushing the middle.  You either need
the double fsync() or you need a checksum in the file; simple markers
are not enough to make a real guarantee.  And MTAs should be making
real guarantees!

> But let's keep this unspecific to the MTA. Unless fsync() is used to
> enforce ordering, without data=ordered, journalled file systems can
> "recreate" files that are not there. Undead you may call them if you
> so like...

No, data=ordered has nothing to do with recreating dead files.  What
data=ordered does is make sure bogus blocks do not appear in new files
(or in new extents of old files).

Failing to call fsync() at all (i.e., failing to commit metadata
updates) is what can recreate dead files.

> Postfix' local(8) daemon additionally relies on rename(2) being
> synchronous (in Maildir delivery), it does not fsync() after rename.
> OTOH, the file is completely in Maildir/tmp/somename, so it's not
> really lost, just invisible.

No, it is lost, because the file's creation is not guaranteed to have
happened at all!  (Well, depending on the file system and the
semantics.  I think I need to write this up more clearly.)

> > Summary: *All* MTAs should call fsync() twice.  The only issue is what
> > descriptors they should call it on, exactly :-).
> 
> See above. Before that, we must know that fsync() syncs all directory
> and file data and metadata (that makes four) all the way up to the mount
> point. For Linux 2.0, 2.2, 2.4. For any file system and any mount
> option. See the table project above ;-)

As I said, the issue is what descriptors they should call fsync() on.
On Linux, fsync() on a file's descriptor will commit the file's
contents; a second fsync() on the containing directory's descriptor
will commit the rename()/link().

 - Pat
