Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317505AbSGOQHq>; Mon, 15 Jul 2002 12:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317508AbSGOQHp>; Mon, 15 Jul 2002 12:07:45 -0400
Received: from lockupnat.curl.com ([216.230.83.254]:59384 "EHLO
	egghead.curl.com") by vger.kernel.org with ESMTP id <S317505AbSGOQHm>;
	Mon, 15 Jul 2002 12:07:42 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.19-rc1/2.5.25 provide dummy fsync() routine for directories on NFS mounts
References: <20020715075221.GC21470@uncarved.com> <Pine.LNX.3.95.1020715084232.22834A-100000@chaos.analogic.com> <20020715133507.GF32155@merlin.emma.line.org> <s5gwurxt59x.fsf@egghead.curl.com> <20020715151833.GA22828@merlin.emma.line.org>
From: "Patrick J. LoPresti" <patl@curl.com>
Date: 15 Jul 2002 12:10:37 -0400
In-Reply-To: <mit.lcs.mail.linux-kernel/20020715151833.GA22828@merlin.emma.line.org>
Message-ID: <s5g4rf1t1j6.fsf@egghead.curl.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@stud.uni-dortmund.de> writes:

> The data= mode was not part of the past discussion, that's why I
> brought this up now. However, reiserfs or ext3fs with data=writeback
> only journal the fsync() metadata involved, not the order of data
> (file contents) versus directory contents, so you can end up with a
> "crash - journal replay - file with bogus contents" scenario.

This should not happen with a properly written application.  fsync()
flushes a bunch of stuff to disk, but it normally makes no promise
about the ORDER in which that stuff goes out.  fsync() itself is how
application authors can enforce an ordering on disk operations.

For example, a typical MTA might follow this paradigm:

    write temp file
    fsync()
    rename temp file to destination
    fsync()
    report success

(Yes, I know, "link/unlink" is more common in practice than rename().
But the principle is the same.)

Or, in the case of Postfix:

    write message file
    fsync()
    chmod +x message file
    fsync()
    report success

The first paradigm uses the presence of a directory entry to represent
"committed" data.  The second uses a mode bit on the file.

Both of these paradigms work fine with data=writeback.  Yes, they
require calling fsync() twice, but that is exactly what you need to
enforce the ordering constraints!

An MTA has two ordering constraints:

  1) Data must be flushed to disk before it is marked on disk as
     "committed".  This is to ensure that, after a crash, the MTA does
     not read a corrupted mail file.

  2) Data must be marked on disk as "committed" before a success code
     is reported to the remote MTA.  This is to ensure that no mail is
     lost.

The ext3 data=ordered mode enforces the first constraint for mailers
using the "rename" paradigm, eliminating the need for the first
fsync() call.  But any MTA which relies on data=ordered semantics is
not only Linux-specific, but ext3/reiserfs specific!

Synchronous directory updates, a la FFS, enforce the second constraint
(again for the "rename" paradigm), eliminating the need for the second
fsync().

But to be robust across platforms and file systems, a mailer needs
both fsync() calls.  (On Linux, you actually need to fsync() the
*directory*, not the file, for the "rename" paradigm.  It would be
nice if we could convince MTA authors to do this.)

> I don't think so. They'd rather declare ReiserFS unsupported and go with
> chattr +S. Seen that.
> 
> New implementations (Courier's maildrop) still rely on BSD FFS
> "synchronous directory" semantics.

Are you sure?  Because that is ridiculous...  Modern BSDs like to use
"soft updates", which need that second fsync() to commit the metadata.
So as long as fsync() commits the journal, either paradigm above
should work fine under any journaling mode.

Summary: *All* MTAs should call fsync() twice.  The only issue is what
descriptors they should call it on, exactly :-).

 - Pat
