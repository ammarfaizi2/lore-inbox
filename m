Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751420AbWCSFOZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751420AbWCSFOZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 00:14:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751422AbWCSFOZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 00:14:25 -0500
Received: from mail.shareable.org ([81.29.64.88]:1696 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S1751369AbWCSFOY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 00:14:24 -0500
Date: Sun, 19 Mar 2006 02:36:10 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Theodore Ts'o" <tytso@mit.edu>, "Stephen C. Tweedie" <sct@redhat.com>,
       Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       jack@suse.cz
Subject: Re: ext3_ordered_writepage() questions
Message-ID: <20060319023610.GA4824@mail.shareable.org>
References: <20060308124726.GC4128@lst.de> <4410551D.5000303@us.ibm.com> <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com> <20060316180904.GA29275@thunk.org> <20060317153213.GA20161@mail.shareable.org> <1142632221.3641.33.camel@orbit.scot.redhat.com> <20060317221103.GA17337@thunk.org> <20060317224439.GB14552@mail.shareable.org> <20060318234018.GK21232@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060318234018.GK21232@thunk.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> On Fri, Mar 17, 2006 at 10:44:39PM +0000, Jamie Lokier wrote:
> >    - Sometimes they do work on A, sometimes they do work on B.
> >      Things like editing pictures or spreadsheets or whatever.
> > 
> >    - They use "rsync" to copy their working directory from A to B, or
> >      B to A, when they move between computers.
> > 
> >    - They're working on A one day, and there's a power cut.
> 
> ... and this is not a problem, because rsync works works by building
> the file to be copied via a name such as .filename.NoC10k.  If there
> is a power cut, there will be a stale dot file on A that might take up
> some extra disk space, but it won't cause a problem with a loss of
> synchronization between B and A.

Eh?  Yikes, i'm obviously not writing clearly enough, because that's
not what I'm talking about at all.

The power cut doesn't interrupt rsync, it interrupts other programs
(unspecified ones), or just after they've written data but it hasn't
reached the disk.

It occurs in step 3 above: after "working on A", i.e. using
OpenOffice, Emacs, Gnumeric, whatever, etc.

_Those_ are the programs which save files shortly before the power cut
in that scenario.

rsync is relevant only *after* the power cut, because it checks mtimes
to see if files are modified.  The method by which rsync writes files
isn't relevant to this scenario.

> Hence, in your scenario, nothing would go wrong.  And since rsync
> builds up a new file each time, and only deletes the old file and
> moves the new file to replace the old file when it is successful, in
> ordered data mode all of the data blocks will be forced to disk before
> the metadata operations for the close and rename are allowed to be
> commited.  Hence, it's perfectly safe, even with Badari's proposed
> change.

Not relevant; rsync is run after the power cut; how it writes files is
irrelevant.  How it detects changed files is relevant.

It's other programs (OpenOffice, etc.) which are being used just
before the power cut.  If the programs which run just before the power
cut do the above (writing then renaming), then they're fine, but many
programs don't do that.

Now, to be fair, most programs don't overwrite data blocks in place either.

They usually open files with O_TRUNC to write with new contents.  How
does that work out with/without Badari's patch?  Is that safe in the
same way as creating new files and appending to them is?

Or does O_TRUNC mean that the old data blocks might be released and
assigned to other files, before this file's metadata is committed,
opening a security hole where reading this file after a restart might
read blocks belonging to another, unrelated file?

> P.S.  There is a potential problem with mtimes causing confusing
> results with make, but it has nothing to do with ext3 journalling
> modes, and everything to do with the fact that most programs,
> including the compiler and linker, do not write their output files
> using the rsync technique of using a temporary filename, and then
> renaming the file to its final location once the compiler or linker
> operation is complete.  So it doesn't matter what filesystem you use,
> if you are writing out some garguantuan .o file, and the system
> crashes before the .o file is written out, the fact that it exist
> means and is newer than the source files will lead make(1) to conclude
> that the file is up to date, and not try to rebuild it.  This has been
> true for three decades or so that make has been around, yet I don't
> see people running around in histronics about how this "horrible
> problem".  If people did care, the right way to fix it would be to
> make the C compiler use the temp filename and rename trick, or change
> the default .c.o rule in Makefiles to do the same thing.  But in
> reality, it doesn't seem to bother most developers, so no one has
> really bothered.

Again, I know about that problem.  I'm referring to a _different_
problem with make, one that is less well known and has less easily
detected effects.

It's this: you edit a source file with your favourite editor, and save
it.  3 seconds later, there's a power cut.  The next day, power comes
back and you've forgotten that you edited this file.

You type "make", and because the _source_ file's new data was
committed, but the mtime wasn't, "make" doesn't rebuild anything.

The result is output files which are perfectly valid, but inconsistent
with source files.  No truncated output files (which tend to be easily
detected because they don't link or run).

This has nothing to do with partially written output files, and more
importantly, you can't fix it by cleverness in the Makefile.  It's
insiduous because whole builds may appear to be fine for a long time
(something that doesn't occur with partially written output files -
those trigger further errors when used - which is maybe why nobody
much worries about those).  Bugs in behaviour may not be seen from
viewing source code, and if you don't know a power cut was involved,
it may not be obvious to think it could be due to source-object
mismatch.

Similar effects occur with automatic byte-code compilations like
Python to .pyc files, and web sites where a templating system caches
generated output depending on mtimes of source files.

However, all of the above examples really depend on what happens with
O_TRUNC, because in practice all editors etc. that are likely to be
used, use that if they don't do write-then-rename.

So what does happen with O_TRUNC?  Does that commit the size and mtime
change before (or at the same time as) freeing the data blocks?  Or
can the data block freeing be committed first?  If the former, O_TRUNC
is as good as writing to a new file: it's fine.  If the latter, it's
like writing data in-place, and can have the problems I've described.

-- Jamie
