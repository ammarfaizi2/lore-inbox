Return-Path: <linux-kernel-owner+w=401wt.eu-S932499AbWLLWbY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932499AbWLLWbY (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:31:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWLLWbY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:31:24 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:51557 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932499AbWLLWbX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:31:23 -0500
Date: Tue, 12 Dec 2006 14:31:09 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Linux Memory Management <linux-mm@kvack.org>,
       linux-fsdevel@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       Andrew Morton <akpm@google.com>
Subject: Re: Status of buffered write path (deadlock fixes)
Message-ID: <20061212223109.GG6831@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <45751712.80301@yahoo.com.au> <20061207195518.GG4497@ca-server1.us.oracle.com> <4578DBCA.30604@yahoo.com.au> <20061208234852.GI4497@ca-server1.us.oracle.com> <457D20AE.6040107@yahoo.com.au> <457D7EBA.7070005@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <457D7EBA.7070005@yahoo.com.au>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2006 at 02:52:26AM +1100, Nick Piggin wrote:
> Nick Piggin wrote:
> >Mark Fasheh wrote:
> 
> >>->commit_write() would probably do fine. Currently, block_prepare_write()
> >>uses it to know which buffers were newly allocated (the file system 
> >>specific
> >>get_block_t sets the bit after allocation). I think we could safely move
> >>the clearing of that bit to block_commit_write(), thus still allowing 
> >>us to
> >>detect and zero those blocks in generic_file_buffered_write()
> >
> >
> >OK, great, I'll make a few patches and see how they look. What did you
> >think of those other uninitialised buffer problems in my first email?
> 
> Hmm, doesn't look like we can do this either because at least GFS2
> uses BH_New for its own special things.
> 
> Also, I don't know if the trick of only walking over BH_New buffers
> will work anyway, since we may still need to release resources on
> other buffers as well.

Oh, my idea was that only the range passed to ->commit() would be walked,
but any BH_New buffers (regardless of where they are in the page) would be
passed to the journal as well. So the logic would be:

for all the buffers in the page:
  If the buffer is new, or it is within the range passed to commit, pass to
  the journal.

Is there anything I'm still missing here?


> As you say, filesystems are simply not set up to expect this, which is a
> problem.
> 
> Maybe it isn't realistic to change the API this way, no matter how
> bad it is presently.

We definitely agree. It's not intuitive that the range should change
between ->prepare_write() and ->commit_write() and IMHO, all the issues
we've found are good evidence that this particular approach will be
problematic.


> What if we tackle the problem a different way?
> 
> 1. In the case of no page in the pagecache (or an otherwise
> !uptodate page), if the operation is a full-page write then we
> first copy all the user data *then* lock the page *then* insert it
> into pagecache and go on to call into the filesystem.

Silly question - what's preventing a reader from filling the !uptodate page with disk
data while the writer is copying the user buffer into it?


> 2. In the case of a !uptodate page and a partial-page write, then
> we can first bring the page uptodate, then continue (goto 3).
> 
> 3. In the case of an uptodate page, we could perform a full-length
> commit_write so long as we didn't expand i_size further than was
> copied, and were sure to trim off blocks allocated past that
> point.
> 
> This scheme IMO is not as "nice" as the partial commit patches,
> but in practical terms it may be much more realistic.

It seems more realistic in that it makes sure the write is properly setup
before calling into the file system. What do you think is not as nice about
it?
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
