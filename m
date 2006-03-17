Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030202AbWCQQOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030202AbWCQQOT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 11:14:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030204AbWCQQOS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 11:14:18 -0500
Received: from mail.shareable.org ([81.29.64.88]:36839 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S1030193AbWCQQOR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 11:14:17 -0500
Date: Fri, 17 Mar 2006 15:32:13 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Theodore Ts'o" <tytso@mit.edu>, Badari Pulavarty <pbadari@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, sct@redhat.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       jack@suse.cz
Subject: Re: ext3_ordered_writepage() questions
Message-ID: <20060317153213.GA20161@mail.shareable.org>
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com> <20060308124726.GC4128@lst.de> <4410551D.5000303@us.ibm.com> <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com> <20060316180904.GA29275@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316180904.GA29275@thunk.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Theodore Ts'o wrote:
> > >Yup.  Ordered-mode JBD commit needs to write and wait upon all dirty
> > >file-data buffers prior to journalling the metadata.  If we didn't run
> > >journal_dirty_data_fn() against those buffers then they'd still be under
> > >I/O after commit had completed.
> > >
> > In non-block allocation case, what metadata are we journaling in
> > writepage() ?  block allocation happend in prepare_write() and
> > commit_write() journaled the transaction. All the meta data
> > updates should be done there.  What JBD commit are you refering to
> > here ?
> 
> Basically, this boils down to what is our definition of ordered-mode?
> 
> If the goal is to make sure we avoid the security exposure of
> allocating a block and then crashing before we write the data block,
> potentially exposing previously written data that might be belong to
> another user, then what Badari is suggesting would avoid this
> particular problem.
> 
> However, if what we are doing is overwriting our own data with more an
> updated, more recent version of the data block, do we guarantee that
> any ordering semantics apply?  For example, what if we write a data
> block, and then follow it up with some kind of metadata update (say we
> touch atime, or add an extended attribute).  Do we guarantee that if
> the metadata update is committed, that the data block will have made
> it to disk as well?  Today that is the way things work, but is that
> guarantee part of the contract of ordered-mode?

That's the wrong way around for uses which check mtimes to revalidate
information about a file's contents.

Local search engines like Beagle, and also anything where "make" is
involved, and "rsync" come to mind.

Then the mtime update should committed _before_ the data begins to be
written, not after, so that after a crash, programs will know those
files may not contain the expected data.

A notable example is "rsync".  After a power cycle, you may want to
synchronise some files from another machine.

Ideally, running "rsync" to copy from the other machine would do the trick.

But if data is committed to files on the power cycled machine, and
mtime updates for those writes did not get committed, when "rsync" is
later run it will assume those files are already correct and not
update them.  The result is that the data is not copied properly in
the way the user expects.

With "rsync" this problem can be avoided using the --checksum option,
but that's not something a person is likely to think of needing when
they assume ext3 provides reasonable consistency guarantees, so that
it's safe to pull the plug.

-- Jamie
