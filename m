Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932815AbWCRBO3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932815AbWCRBO3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 20:14:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWCRBO3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 20:14:29 -0500
Received: from mail.shareable.org ([81.29.64.88]:11421 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S932815AbWCRBO2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 20:14:28 -0500
Date: Fri, 17 Mar 2006 22:23:05 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Badari Pulavarty <pbadari@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, jack@suse.cz
Subject: Re: ext3_ordered_writepage() questions
Message-ID: <20060317222305.GA14552@mail.shareable.org>
References: <1141777204.17095.33.camel@dyn9047017100.beaverton.ibm.com> <20060308124726.GC4128@lst.de> <4410551D.5000303@us.ibm.com> <20060309153550.379516e1.akpm@osdl.org> <4410CA25.2090400@us.ibm.com> <20060316180904.GA29275@thunk.org> <20060317153213.GA20161@mail.shareable.org> <1142632221.3641.33.camel@orbit.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1142632221.3641.33.camel@orbit.scot.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie wrote:
> > That's the wrong way around for uses which check mtimes to revalidate
> > information about a file's contents.
> 
> It's actually the right way for newly-allocated data: the blocks being
> written early are invisible until the mtime update, because the mtime
> update is an atomic part of the transaction which links the blocks into
> the inode.

Yes, I agree.  It's right for that.

> > Local search engines like Beagle, and also anything where "make" is
> > involved, and "rsync" come to mind.
> 
> Make and rsync (when writing, that is) are not usually updating in
> place, so they do in fact want the current ordered mode.

I'm referring to make and rsync _after_ a recovery, when _reading_ to
decide whether file data is up to date.  The writing in that scenario
is by other programs.

Those are the times when the current ordering gives surprising
results, to the person who hasn't thought about this ordering, such as
rsync not synchronising a directory properly because it assumes
(incorrectly) a file's mtime is indicative of the last time data was
written to the file.

I agree that when writing data to the end of a new file, the data must
be committed before the metadata.

The weird distinction is really because the order ought to be, if they
can't all be atomic: commit mtime, then data, then size.  But we
always commit size and mtime together.

> It's *only* for updating existing data blocks that there's any
> justification for writing mtime first.  That's the question here.
> 
> There's a significant cost in forcing the mtime to go first: it means
> that the VM cannot perform any data writeback for data written by a
> transaction until the transaction has first been committed.  That's the
> last thing you want to be happening under VM pressure, as you may not in
> fact be able to close the transaction without first allocating more
> memory.

While I agree that it's not good for VM pressure, fooling programs
that rely on mtimes to decide if a file's content has changed is a
correctness issue for some applications.

I picked the example of copying a directory using rsync (or any other
program which compares mtimes) and not getting expected results as one
that's easily understood, that people actually do, and where they may
already be getting surprises that may not be noticed immediately.

Maybe the answer is to make the writeback order for in-place writes a
mount option and/or a file attribute?

-- Jamie
