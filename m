Return-Path: <linux-kernel-owner+willy=40w.ods.org-S938013AbWLGTzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S938013AbWLGTzj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 14:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938012AbWLGTzj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 14:55:39 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:59498 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S938010AbWLGTzi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 14:55:38 -0500
Date: Thu, 7 Dec 2006 11:55:18 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@google.com>
Subject: Re: Status of buffered write path (deadlock fixes)
Message-ID: <20061207195518.GG4497@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <45751712.80301@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45751712.80301@yahoo.com.au>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Tue, Dec 05, 2006 at 05:52:02PM +1100, Nick Piggin wrote:
> Hi,
> 
> I'd like to try to state where we are WRT the buffered write patches,
> and ask for comments. Sorry for the wide cc list, but this is an
> important issue which hasn't had enough review.

I pulled broken-out-2006-12-05-01-0.tar.gz from ftp.kernel.org and applied
the following patches to get a reasonable idea of what the final product
would look like:

revert-generic_file_buffered_write-handle-zero-length-iovec-segments.patch
revert-generic_file_buffered_write-deadlock-on-vectored-write.patch
generic_file_buffered_write-cleanup.patch
mm-only-mm-debug-write-deadlocks.patch
mm-fix-pagecache-write-deadlocks.patch
mm-fix-pagecache-write-deadlocks-comment.patch
mm-fix-pagecache-write-deadlocks-xip.patch
mm-fix-pagecache-write-deadlocks-mm-pagecache-write-deadlocks-efault-fix.patch
mm-fix-pagecache-write-deadlocks-zerolength-fix.patch
mm-fix-pagecache-write-deadlocks-stale-holes-fix.patch
fs-prepare_write-fixes.patch

If this is incorrect, or I should apply further patches, please let me know.

Hopefully my feedback can be of use to you.


> Well the next -mm will include everything we've done so far. I won't
> repost patches unless someone would like to comment on a specific one.
> 
> I think the core generic_file_buffered_write is fairly robust, after
> fixing the efault and zerolength iov problems picked up in testing
> (thanks, very helpful!).
> 
> So now I *believe* we have an approach that solves the deadlock and
> doesn't expose transient or stale data, transient zeroes, or anything
> like that.

In generic_file_buffered_write() we now do:

	status = a_ops->commit_write(file, page, offset,offset+copied);

Which tells the file system to commit only the amount of data that
filemap_copy_from_user() was able to pull in, despite our zeroing of 
the newly allocated buffers in the copied != bytes case. Shouldn't we be
doing:

        status = a_ops->commit_write(file, page, offset,offset+bytes);

instead, thus preserving ordered writeout (for ext3, ocfs2, etc) for those
parts of the page which are properly allocated and zero'd but haven't been
copied into yet? I think that in the case of a crash just after the
transaction is closed in ->commit_write(), we might lose those guarantees,
exposing stale data on disk.

 
> Error handling is getting close, but there may be cases that nobody
> has picked up, and I've noticed a couple which I'll explain below.
> 
> I think we do the right thing WRT pagecache error handling: a
> !uptodate page remains !uptodate, an uptodate page can handle the
> write being done in several parts. Comments in the patches attempt
> to explain how this works. I think it is pretty straightforward.
> 
> But WRT block allocation in the case of errors, it needs more review.
> 
> Block allocation:
> - prepare_write can allocate blocks
> - prepare_write doesn't need to initialize the pagecache on top of
>   these blocks where it is within the range specified in prepare_write
>   (because the copy_from_user will initialise it correctly)
> - In the case of a !uptodate page, unless the page is brought uptodate
>   (ie the copy_from_user completely succeeds) and marked dirty, then
>   a read that sneaks in after we unlock the page (to retry the write)
>   will try to bring it uptodate by pulling in the uninitialised blocks.

For some reason, I'm not seeing where BH_New is being cleared in case with
no errors or faults. Hopefully I'm wrong, but if I'm not I believe we need
to clear the flag somewhere (perhaps in block_commit_write()?).


Ok, that's it for now. I have some thoughts regarding the asymmetry between
ranges passed to ->prepare_write() and ->commit_write(), but I'd like to
save those thoughts until I know whether my comments above uncovered real
issues :)

Thanks,
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
