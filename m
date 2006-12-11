Return-Path: <linux-kernel-owner+w=401wt.eu-S1762665AbWLKJMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762665AbWLKJMG (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 04:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762654AbWLKJMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 04:12:06 -0500
Received: from smtp105.mail.mud.yahoo.com ([209.191.85.215]:26074 "HELO
	smtp105.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1762665AbWLKJME (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 04:12:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:X-YMail-OSG:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=kuzJNUrZ9k1HiIA/dMpmSv0ayhPlCvWmVqKy0ygM7e7BYxbudfO1pvPymMGgOEwbFZC4p4LJtm0ZwfwRp1W8QjWLgfoAE27UoDPyYfBMzQKwxAczz6g6YUKI9a5KjYlIPPCYj6pe41sCtFGbhG8qcoiCRN/2CKNyOy/96fCzvKo=  ;
X-YMail-OSG: 6v_UFwoVM1kswNFRXBn9chW0v5tcPMoIK9D5nNbQZSnciO1nXa5Lk9cd5SbtI6vgU_L0iZrsIHAP5mbeyxrqGYu1e0ChPqk4DCiD8cHmgE1aa58gCaODZmdrggN3tVbVBo5hn0km.OWuyb38TpEIg2pus6rnLqAcpmd6rPzfdw_gfq9alP3SoAZN1bFY
Message-ID: <457D20AE.6040107@yahoo.com.au>
Date: Mon, 11 Dec 2006 20:11:10 +1100
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
References: <45751712.80301@yahoo.com.au> <20061207195518.GG4497@ca-server1.us.oracle.com> <4578DBCA.30604@yahoo.com.au> <20061208234852.GI4497@ca-server1.us.oracle.com>
In-Reply-To: <20061208234852.GI4497@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Fasheh wrote:
> On Fri, Dec 08, 2006 at 02:28:10PM +1100, Nick Piggin wrote:
> 
>>>In generic_file_buffered_write() we now do:
>>>
>>>	status = a_ops->commit_write(file, page, offset,offset+copied);
>>>
>>>Which tells the file system to commit only the amount of data that
>>>filemap_copy_from_user() was able to pull in, despite our zeroing of 
>>>the newly allocated buffers in the copied != bytes case. Shouldn't we be
>>>doing:
>>>
>>>       status = a_ops->commit_write(file, page, offset,offset+bytes);
>>>
>>>instead, thus preserving ordered writeout (for ext3, ocfs2, etc) for those
>>>parts of the page which are properly allocated and zero'd but haven't been
>>>copied into yet? I think that in the case of a crash just after the
>>>transaction is closed in ->commit_write(), we might lose those guarantees,
>>>exposing stale data on disk.
>>
>>No, because we might be talking about buffers that haven't been newly
>>allocated, but are not uptodate (so the pagecache can contain junk).
>>
>>We can't zero these guys and do the commit_write, because that exposes
>>transient zeroes to a concurrent reader.
> 
> 
> Ahh ok - zeroing would populate with incorrect data and we can't write those
> buffers because we'd write junk over good data.
> 
> And of course, the way it works right now will break ordered write mode.
> 
> Sigh.

Yes :P

>>What we *could* do, is to do the full length commit_write for uptodate
>>pages, even if the copy is short. But we still need to do a zero-length
>>commit_write if the page is not uptodate (this would reduce the number
>>of new cases that need to be considered).
>>
>>Does a short commit_write cause a problem for filesystems? They can
>>still do any and all operations they would have with a full-length one.
> 
> 
> If they've done allocation, yes. You're telling the file system to stop
> early in the page, even though there may be BH_New buffers further on which
> should be processed (for things like ordered data mode).

Well they must have done the allocation, right (or be prepared to do the
allocation at a later time) because from the point of view of the fs,
they don't know or care whether the copy has succeeded just so long as
the data is uptodate (ie. zeroed, in the case of a hole).

> Hmm, I think we should just just change functions like walk_page_buffers()
> in fs/ext3/inode.c and fs/ocfs2/aops.c to look for BH_New buffers outside
> the range specified (they walk the entire buffer list anyway). If it finds
> one that's buffer_new() it passes it to the journal unconditionally. You'd
> also have to revert the change you did in fs/ext3/inode.c to at least always
> make the call to walk_page_buffers().

Would this satisfy non jbd filesystems, though? How about data journalling
in the case where there are some underlying buffers which are *not* BH_New?

> I really don't like that we're hiding a detail of this interaction so deep
> within the file system commit_write() callback. I suppose we can just do our
> best to document it.

Well, supposing we do the full-length commit in the case of an uptodate
page, then the *only* thing we have to worry about is a zero length commit
to a !uptodate page.

I guess that still has the same block allocation and journalling problems.

>>But maybe it would be better to eliminate that case. OK.
>>How about a zero-length commit_write? In that case again, they should
>>be able to remain unchanged *except* that they are not to extend i_size
>>or mark the page uptodate.
> 
> 
> If we make the change I described above (looking for BH_New buffers outside
> the range passed), then zero length or partial shouldn't matter, but zero
> length instead of partial would be nicer imho just for the sake of reducing
> the total number of cases down to the entire range or zero length.

We don't want to do zero length, because we might make the theoretical
livelock much easier to hit (eg. in the case of many small iovecs). But
yes we can restrict ourselves to zero-length or full-length.

>>>For some reason, I'm not seeing where BH_New is being cleared in case with
>>>no errors or faults. Hopefully I'm wrong, but if I'm not I believe we need
>>>to clear the flag somewhere (perhaps in block_commit_write()?).
>>
>>Hmm, it is a bit inconsistent. It seems to be anywhere from prepare_write
>>to block_write_full_page.
>>
>>Where do filesystems need the bit? It would be nice to clear it in
>>commit_write if possible. Worst case we'll need a new bit.
> 
> 
> ->commit_write() would probably do fine. Currently, block_prepare_write()
> uses it to know which buffers were newly allocated (the file system specific
> get_block_t sets the bit after allocation). I think we could safely move
> the clearing of that bit to block_commit_write(), thus still allowing us to
> detect and zero those blocks in generic_file_buffered_write()

OK, great, I'll make a few patches and see how they look. What did you
think of those other uninitialised buffer problems in my first email?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
