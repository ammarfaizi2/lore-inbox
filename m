Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424127AbWLHD32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424127AbWLHD32 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 22:29:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424174AbWLHD3H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 22:29:07 -0500
Received: from smtp106.mail.mud.yahoo.com ([209.191.85.216]:28332 "HELO
	smtp106.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1424127AbWLHD26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 22:28:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=xwkC7Snv3VouL0if1ektIKNwCftJTKOzjb4F5aDo5lqsUs/Cwq1N6NDxunFHlEgtXXk01DRnLYtEXKZtTTbC3N8jtXBbWICgJlK8cj12KCU77WY3oxCkuO2BF5TOFxY3bql1lOMIoILtGl9Eb+/8h2dhvzSNJOqiy+kxTD+RrXQ=  ;
X-YMail-OSG: GlrrLOEVM1njoKlyTruA3L6rx7YHyEW0U8LIp3IenW.KnGZXuQf78vI5V3Bk4O13hHR136vrjU0NuR.qMGvNIkg0PdHANPzHyEsMAWiiueQJk66cepZ89NQM99eUPLd_lUUjCDFeITylPSCdEfzUmzMLkh0igsN2ty96SSAHQh09q5wtBo_qsv9ozu3K
Message-ID: <4578DBCA.30604@yahoo.com.au>
Date: Fri, 08 Dec 2006 14:28:10 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Fasheh <mark.fasheh@oracle.com>
CC: Linux Memory Management <linux-mm@kvack.org>,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@google.com>
Subject: Re: Status of buffered write path (deadlock fixes)
References: <45751712.80301@yahoo.com.au> <20061207195518.GG4497@ca-server1.us.oracle.com>
In-Reply-To: <20061207195518.GG4497@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Fasheh wrote:
> Hi Nick,
> 
> On Tue, Dec 05, 2006 at 05:52:02PM +1100, Nick Piggin wrote:
> 
>>Hi,
>>
>>I'd like to try to state where we are WRT the buffered write patches,
>>and ask for comments. Sorry for the wide cc list, but this is an
>>important issue which hasn't had enough review.
> 
> 
> I pulled broken-out-2006-12-05-01-0.tar.gz from ftp.kernel.org and applied
> the following patches to get a reasonable idea of what the final product
> would look like:
> 
> revert-generic_file_buffered_write-handle-zero-length-iovec-segments.patch
> revert-generic_file_buffered_write-deadlock-on-vectored-write.patch
> generic_file_buffered_write-cleanup.patch
> mm-only-mm-debug-write-deadlocks.patch
> mm-fix-pagecache-write-deadlocks.patch
> mm-fix-pagecache-write-deadlocks-comment.patch
> mm-fix-pagecache-write-deadlocks-xip.patch
> mm-fix-pagecache-write-deadlocks-mm-pagecache-write-deadlocks-efault-fix.patch
> mm-fix-pagecache-write-deadlocks-zerolength-fix.patch
> mm-fix-pagecache-write-deadlocks-stale-holes-fix.patch
> fs-prepare_write-fixes.patch
> 
> If this is incorrect, or I should apply further patches, please let me know.
> 
> Hopefully my feedback can be of use to you.

That looks right (there are fixes for the "cont" buffer scheme, but they
probably don't bother you).

>>Well the next -mm will include everything we've done so far. I won't
>>repost patches unless someone would like to comment on a specific one.
>>
>>I think the core generic_file_buffered_write is fairly robust, after
>>fixing the efault and zerolength iov problems picked up in testing
>>(thanks, very helpful!).
>>
>>So now I *believe* we have an approach that solves the deadlock and
>>doesn't expose transient or stale data, transient zeroes, or anything
>>like that.
> 
> 
> In generic_file_buffered_write() we now do:
> 
> 	status = a_ops->commit_write(file, page, offset,offset+copied);
> 
> Which tells the file system to commit only the amount of data that
> filemap_copy_from_user() was able to pull in, despite our zeroing of 
> the newly allocated buffers in the copied != bytes case. Shouldn't we be
> doing:
> 
>         status = a_ops->commit_write(file, page, offset,offset+bytes);
> 
> instead, thus preserving ordered writeout (for ext3, ocfs2, etc) for those
> parts of the page which are properly allocated and zero'd but haven't been
> copied into yet? I think that in the case of a crash just after the
> transaction is closed in ->commit_write(), we might lose those guarantees,
> exposing stale data on disk.

No, because we might be talking about buffers that haven't been newly
allocated, but are not uptodate (so the pagecache can contain junk).

We can't zero these guys and do the commit_write, because that exposes
transient zeroes to a concurrent reader.

What we *could* do, is to do the full length commit_write for uptodate
pages, even if the copy is short. But we still need to do a zero-length
commit_write if the page is not uptodate (this would reduce the number
of new cases that need to be considered).

Does a short commit_write cause a problem for filesystems? They can
still do any and all operations they would have with a full-length one.
But maybe it would be better to eliminate that case. OK.

How about a zero-length commit_write? In that case again, they should
be able to remain unchanged *except* that they are not to extend i_size
or mark the page uptodate.

>>Error handling is getting close, but there may be cases that nobody
>>has picked up, and I've noticed a couple which I'll explain below.
>>
>>I think we do the right thing WRT pagecache error handling: a
>>!uptodate page remains !uptodate, an uptodate page can handle the
>>write being done in several parts. Comments in the patches attempt
>>to explain how this works. I think it is pretty straightforward.
>>
>>But WRT block allocation in the case of errors, it needs more review.
>>
>>Block allocation:
>>- prepare_write can allocate blocks
>>- prepare_write doesn't need to initialize the pagecache on top of
>>  these blocks where it is within the range specified in prepare_write
>>  (because the copy_from_user will initialise it correctly)
>>- In the case of a !uptodate page, unless the page is brought uptodate
>>  (ie the copy_from_user completely succeeds) and marked dirty, then
>>  a read that sneaks in after we unlock the page (to retry the write)
>>  will try to bring it uptodate by pulling in the uninitialised blocks.
> 
> 
> For some reason, I'm not seeing where BH_New is being cleared in case with
> no errors or faults. Hopefully I'm wrong, but if I'm not I believe we need
> to clear the flag somewhere (perhaps in block_commit_write()?).

Hmm, it is a bit inconsistent. It seems to be anywhere from prepare_write
to block_write_full_page.

Where do filesystems need the bit? It would be nice to clear it in
commit_write if possible. Worst case we'll need a new bit.

> Ok, that's it for now. I have some thoughts regarding the asymmetry between
> ranges passed to ->prepare_write() and ->commit_write(), but I'd like to
> save those thoughts until I know whether my comments above uncovered real
> issues :)

Very helpful, thanks ;)

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
