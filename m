Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130329AbRAXKJl>; Wed, 24 Jan 2001 05:09:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130075AbRAXKJc>; Wed, 24 Jan 2001 05:09:32 -0500
Received: from duck.doc.ic.ac.uk ([146.169.1.46]:1805 "EHLO duck.doc.ic.ac.uk")
	by vger.kernel.org with ESMTP id <S129401AbRAXKJ0>;
	Wed, 24 Jan 2001 05:09:26 -0500
To: "Benjamin C.R. LaHaise" <blah@kvack.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: limit on number of kmapped pages
In-Reply-To: <Pine.LNX.3.96.1010123205643.7482A-100000@kanga.kvack.org>
From: David Wragg <dpw@doc.ic.ac.uk>
Date: 24 Jan 2001 10:09:22 +0000
In-Reply-To: "Benjamin C.R. LaHaise"'s message of "Tue, 23 Jan 2001 21:03:09 -0500 (EST)"
Message-ID: <y7r7l3ldzxp.fsf@sytry.doc.ic.ac.uk>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Benjamin C.R. LaHaise" <blah@kvack.org> writes:
> On 24 Jan 2001, David Wragg wrote:
> 
> > ebiederm@xmission.com (Eric W. Biederman) writes:
> > > Why do you need such a large buffer? 
> > 
> > ext2 doesn't guarantee sustained write bandwidth (in particular,
> > writing a page to an ext2 file can have a high latency due to reading
> > the block bitmap synchronously).  To deal with this I need at least a
> > 2MB buffer.
> 
> This is the wrong way of going about things -- you should probably insert
> the pages into the page cache and write them into the filesystem via
> writepage. 

I currently use prepare_write/commit_write, but I think writepage
would have the same issue: When ext2 allocates a block, and has to
allocate from a new block group, it may do a synchronous read of the
new block group bitmap.  So before the writepage (or whatever) that
causes this completes, it has to wait for the read to get picked by
the elevator, the seek for the read, etc.  By the time it gets back to
writing normally, I've buffered a couple of MB of data.

But I do have a workaround for the ext2 issue.

> That way the pages don't need to be mapped while being written
> out.

Point taken, though the kmap needed before prepare_write is much less
significant than the kmap I need to do before copying data into the
page.

> For incoming data from a network socket, making use of the
> data_ready callbacks and directly copying from the skbs in one pass with a
> kmap of only one page at a time.
>
> Maybe I'm guessing incorrect at what is being attempted, but kmap should
> be used sparingly and as briefly as possible.

I'm going to see if the one-page-kmapped approach makes a measurable
difference.

I'd still like to know what the basis for the current kmap limit
setting is.


David Wragg
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
