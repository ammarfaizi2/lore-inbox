Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWJDUyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWJDUyE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 16:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWJDUyD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 16:54:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11216 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751113AbWJDUyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 16:54:00 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Zach Brown <zach.brown@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] call truncate_inode_pages in the DIO fallback to buffered I/O path
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
References: <x49zmcc6mhh.fsf@segfault.boston.devel.redhat.com>
	<20061004102522.d58c00ef.akpm@osdl.org> <4523F486.1000604@oracle.com>
	<x49mz8c6k83.fsf@segfault.boston.devel.redhat.com>
	<20061004111603.20cdaa35.akpm@osdl.org> <45240034.2040704@oracle.com>
	<20061004121645.fd2765e4.akpm@osdl.org>
From: Jeff Moyer <jmoyer@redhat.com>
Date: Wed, 04 Oct 2006 16:53:53 -0400
In-Reply-To: <20061004121645.fd2765e4.akpm@osdl.org> (Andrew Morton's message of "Wed, 4 Oct 2006 12:16:45 -0700")
Message-ID: <x49ejtn7qfy.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: [patch] call truncate_inode_pages in the DIO fallback to buffered I/O path; Andrew Morton <akpm@osdl.org> adds:

akpm> On Wed, 04 Oct 2006 11:40:52 -0700
akpm> Zach Brown <zach.brown@oracle.com> wrote:

>> > We have lots of nice new tools in-kernel which permit applications to
>> > manipulate and to invalidate pagecache.  Please, start using them
>> rather > than pushing bits of oracle into the core vfs ;)
>> 
>> And apps that were written before they were available? :) We're OK with
>> their behaviour changing under newer kernels because they now have a
>> previous source of memory pressure that they didn't have before?
>> 
>> It seems a bit much to suggest that retaining the previous behaviour of
>> avoiding memory pressure by using the O_DIRECT API is somehow "pushing
>> bits of oracle into the core vfs" :).
>> 
>> Maybe that aspect of the API was unintentional, though.  That would be a
>> shame.  I suspect Oracle isn't alone in relying on it.

akpm> Why do so many patches degenerate into these little
akpm> question-and-answer sessions?  It's like pulling teeth.  Please
akpm> completely describe the problem.

akpm> What "newer kernels"?  The kernel has had the fall-back-to-buffered
akpm> behaviour for *ages*.

akpm> What's so bad about having a bit of pagecache floating about during
akpm> what is, I expect, a fairly rare operation?

akpm> What are the user-visible effects of this pagecache?

akpm> Please don't just sling a patch at us and leave us to guess what it's
akpm> for.

This is my fault and I apologize.

Starting again from the beginning, Oracle table creates will create sparse
redo logs and database files, and then populate them sequentially.  A table
create can happen at any time, though it is arguably a rare occurrence
(some administrators have creates scripted to run nightly, others much
less).  Allocating memory to the page cache for these operations is
sub-optimal, since Oracle maintains its own cache layer.  The pages will
eventually need to be reaped, anyway, and this doesn't happen until there
is memory pressure.  I asked for performance numbers showing the impact of
this behaviour, and I'm working on producing some numbers here.  I'll
post the results when they are available.

So, how did this work in the past?  In kernels prior to 2.6.12,
generic_file_direct_IO looked like so:

	retval = mapping->a_ops->direct_IO(rw, iocb, iov,
					offset, nr_segs);
	if (rw == WRITE && mapping->nrpages) {
                int err = invalidate_inode_pages2(mapping);
	        if (err)
	                retval = err;
	}

If this was a write to a hole in a file, retval will be 0 and we fall back
to buffered I/O.  In this case, the invalidate_inode_pages2 call may not
invalidate any pages at all.  Here is the caller:

	if (unlikely(file->f_flags & O_DIRECT)) {
		written = generic_file_direct_write(iocb, iov,
				&nr_segs, pos, ppos, count, ocount);
		if (written < 0 || written == count)
			goto out;
		/*
		 * direct-io write to a hole: fall through to buffered I/O
		 * for completing the rest of the request.
		 */
		pos += written;
		count -= written;
	}

	written = generic_file_buffered_write(iocb, iov, nr_segs,
			pos, ppos, count, written);

Here, we end up populating the page cache.  Notice that, just like in
current kernels, there is no invalidation logic here.  The catch is that on
the next I/O to this file, all of the pages associated with the file will
be invalidated by the call to invalidate_inode_pages2 in
generic_file_direct_IO.  So, each I/O clears the page cache pages used by
the one before it.

In 2.6.12, the call to invalidate_inode_pages2 in generic_file_direct_IO was
changed to invalidate_inode_pages2_range:

		retval = mapping->a_ops->direct_IO(rw, iocb, iov,
						offset, nr_segs);
		if (rw == WRITE && mapping->nrpages) {
			pgoff_t end = (offset + write_len - 1)
						>> PAGE_CACHE_SHIFT;
			int err = invalidate_inode_pages2_range(mapping,
					offset >> PAGE_CACHE_SHIFT, end);
			if (err)
				retval = err;
		}

So this means that we no longer invalidate the pages used by the previous
I/O.  This is the source of the regression.

akpm> What I've thus far been able to decrypt from this exchange has been
akpm> that you think that the Linux direct-IO API should, as a side-effect,
akpm> guarantee that a direct-io write (and read?) of a file area should
akpm> not leave that part of the file in pagecache.

I think it is expected that a direct I/O should not populate the page
cache.  I think your statement is correct for writes.  For reads, I don't
think we need to shoot down the page cache (we do a filemap_write_and_wait
on the mapping before issuing the I/O, so the on-disk copy should be up to
date).

The man page for open states:

       O_DIRECT
              Try to minimize cache effects of the I/O to and from this file.

I think that invalidating the page cache pages we use when falling back to
buffered I/O stays true to the above description.

akpm> Well we _could_ define the API in that fashion.  It'd need to be
akpm> carefully documented somewhere.  But it's a fairly bizarre
akpm> requirement, especially as userspace already has quite rich ways of
akpm> manipulating pagecache.

I don't think it's a bizarre requirement that we invalidate the page cache
that we may have used while falling back to buffered I/O.

akpm> To do this right without modifying userspace we're going to need to
akpm> sync these pages to disk within the write() syscall and then
akpm> invalidate them. That might screw somebody else up, but I think it
akpm> could be justified on the grounds that direct-io is a synchronous
akpm> operation, so we should still be synchronous if we went the buffered
akpm> route.

I'm sure I'm missing something.  But I think that if I can get a suitable
patch posted for this issue, then there is no further work needed.

Again, sorry that I didn't include a better description.  I've attached my
reproducer to this message.

akpm> And no sneaking changes like this into vendor kernels either!  Fix
akpm> Oracle.

'Sneaking' is certainly not my intention.  =)

Cheers,

Jeff
