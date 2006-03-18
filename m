Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751144AbWCRXkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbWCRXkb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 18:40:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWCRXka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 18:40:30 -0500
Received: from thunk.org ([69.25.196.29]:30647 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S1751135AbWCRXk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 18:40:29 -0500
Date: Sat, 18 Mar 2006 18:40:18 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Jamie Lokier <jamie@shareable.org>
Cc: "Stephen C. Tweedie" <sct@redhat.com>,
       Badari Pulavarty <pbadari@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       jack@suse.cz
Subject: Re: ext3_ordered_writepage() questions
Message-ID: <20060318234018.GK21232@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Jamie Lokier <jamie@shareable.org>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, jack@suse.cz
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com> <20060308124726.GC4128@lst.de> <4410551D.5000303@us.ibm.com> <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com> <20060316180904.GA29275@thunk.org> <20060317153213.GA20161@mail.shareable.org> <1142632221.3641.33.camel@orbit.scot.redhat.com> <20060317221103.GA17337@thunk.org> <20060317224439.GB14552@mail.shareable.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060317224439.GB14552@mail.shareable.org>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2006 at 10:44:39PM +0000, Jamie Lokier wrote:
>    - Sometimes they do work on A, sometimes they do work on B.
>      Things like editing pictures or spreadsheets or whatever.
> 
>    - They use "rsync" to copy their working directory from A to B, or
>      B to A, when they move between computers.
> 
>    - They're working on A one day, and there's a power cut.

... and this is not a problem, because rsync works works by building
the file to be copied via a name such as .filename.NoC10k.  If there
is a power cut, there will be a stale dot file on A that might take up
some extra disk space, but it won't cause a problem with a loss of
synchronization between B and A.  

Hence, in your scenario, nothing would go wrong.  And since rsync
builds up a new file each time, and only deletes the old file and
moves the new file to replace the old file when it is successful, in
ordered data mode all of the data blocks will be forced to disk before
the metadata operations for the close and rename are allowed to be
commited.  Hence, it's perfectly safe, even with Badari's proposed
change.

I would also note that in the even with rsync doing the checksum test,
*even* if it didn't use the dotfile with the uniquifer, rsync always
did check to see if file sizes matched, and since the file sizes would
be different, it would have caught it that way.

						- Ted

P.S.  There is a potential problem with mtimes causing confusing
results with make, but it has nothing to do with ext3 journalling
modes, and everything to do with the fact that most programs,
including the compiler and linker, do not write their output files
using the rsync technique of using a temporary filename, and then
renaming the file to its final location once the compiler or linker
operation is complete.  So it doesn't matter what filesystem you use,
if you are writing out some garguantuan .o file, and the system
crashes before the .o file is written out, the fact that it exist
means and is newer than the source files will lead make(1) to conclude
that the file is up to date, and not try to rebuild it.  This has been
true for three decades or so that make has been around, yet I don't
see people running around in histronics about how this "horrible
problem".  If people did care, the right way to fix it would be to
make the C compiler use the temp filename and rename trick, or change
the default .c.o rule in Makefiles to do the same thing.  But in
reality, it doesn't seem to bother most developers, so no one has
really bothered.
