Return-Path: <linux-kernel-owner+w=401wt.eu-S1947503AbWLHXtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947503AbWLHXtM (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 18:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947506AbWLHXtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 18:49:12 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:26774 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1947503AbWLHXtK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 18:49:10 -0500
Date: Fri, 8 Dec 2006 15:48:52 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@google.com>
Subject: Re: Status of buffered write path (deadlock fixes)
Message-ID: <20061208234852.GI4497@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <45751712.80301@yahoo.com.au> <20061207195518.GG4497@ca-server1.us.oracle.com> <4578DBCA.30604@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4578DBCA.30604@yahoo.com.au>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2006 at 02:28:10PM +1100, Nick Piggin wrote:
> >In generic_file_buffered_write() we now do:
> >
> >	status = a_ops->commit_write(file, page, offset,offset+copied);
> >
> >Which tells the file system to commit only the amount of data that
> >filemap_copy_from_user() was able to pull in, despite our zeroing of 
> >the newly allocated buffers in the copied != bytes case. Shouldn't we be
> >doing:
> >
> >        status = a_ops->commit_write(file, page, offset,offset+bytes);
> >
> >instead, thus preserving ordered writeout (for ext3, ocfs2, etc) for those
> >parts of the page which are properly allocated and zero'd but haven't been
> >copied into yet? I think that in the case of a crash just after the
> >transaction is closed in ->commit_write(), we might lose those guarantees,
> >exposing stale data on disk.
> 
> No, because we might be talking about buffers that haven't been newly
> allocated, but are not uptodate (so the pagecache can contain junk).
> 
> We can't zero these guys and do the commit_write, because that exposes
> transient zeroes to a concurrent reader.

Ahh ok - zeroing would populate with incorrect data and we can't write those
buffers because we'd write junk over good data.

And of course, the way it works right now will break ordered write mode.

Sigh.

 
> What we *could* do, is to do the full length commit_write for uptodate
> pages, even if the copy is short. But we still need to do a zero-length
> commit_write if the page is not uptodate (this would reduce the number
> of new cases that need to be considered).
>
> Does a short commit_write cause a problem for filesystems? They can
> still do any and all operations they would have with a full-length one.

If they've done allocation, yes. You're telling the file system to stop
early in the page, even though there may be BH_New buffers further on which
should be processed (for things like ordered data mode).

Hmm, I think we should just just change functions like walk_page_buffers()
in fs/ext3/inode.c and fs/ocfs2/aops.c to look for BH_New buffers outside
the range specified (they walk the entire buffer list anyway). If it finds
one that's buffer_new() it passes it to the journal unconditionally. You'd
also have to revert the change you did in fs/ext3/inode.c to at least always
make the call to walk_page_buffers().

I really don't like that we're hiding a detail of this interaction so deep
within the file system commit_write() callback. I suppose we can just do our
best to document it.


> But maybe it would be better to eliminate that case. OK.
> How about a zero-length commit_write? In that case again, they should
> be able to remain unchanged *except* that they are not to extend i_size
> or mark the page uptodate.

If we make the change I described above (looking for BH_New buffers outside
the range passed), then zero length or partial shouldn't matter, but zero
length instead of partial would be nicer imho just for the sake of reducing
the total number of cases down to the entire range or zero length.


> >For some reason, I'm not seeing where BH_New is being cleared in case with
> >no errors or faults. Hopefully I'm wrong, but if I'm not I believe we need
> >to clear the flag somewhere (perhaps in block_commit_write()?).
> 
> Hmm, it is a bit inconsistent. It seems to be anywhere from prepare_write
> to block_write_full_page.
> 
> Where do filesystems need the bit? It would be nice to clear it in
> commit_write if possible. Worst case we'll need a new bit.

->commit_write() would probably do fine. Currently, block_prepare_write()
uses it to know which buffers were newly allocated (the file system specific
get_block_t sets the bit after allocation). I think we could safely move
the clearing of that bit to block_commit_write(), thus still allowing us to
detect and zero those blocks in generic_file_buffered_write()

Thanks,
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
