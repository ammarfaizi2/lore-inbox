Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbREYRRY>; Fri, 25 May 2001 13:17:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261268AbREYRRO>; Fri, 25 May 2001 13:17:14 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:12553 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261386AbREYRQ4>; Fri, 25 May 2001 13:16:56 -0400
Date: Fri, 25 May 2001 10:16:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: DVD blockdevice buffers
In-Reply-To: <m1bsohh3da.fsf@frodo.biederman.org>
Message-ID: <Pine.LNX.4.21.0105250959580.11312-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 25 May 2001, Eric W. Biederman wrote:
> 
> For the small random read case we could use a 
> mapping->a_ops->readpartialpage 

No, if so I'd prefer to just change "readpage()" to take the same kinds of
arguments commit_page() does, namely the beginning and end of the read
area. 

Filesystems could choose to ignore the arguments completely, and just act
the way they already do - filling in the whole page.

OR a filesystem might know that the page is partially up-to-date (because
of a partial write), and just return an immediate "this area is already
uptodate" return code or something. Or it could even fill in the page
partially, and just unlock it (but not mark it up-to-date: the reader then
has to wait for the page and then look at PG_error to decide whether the
partial read succeeded or not).

I don't think it really matters, I have to say. It would be very easy to
implement (all the buffer-based filesystems already use the common
fs/buffer.c readpage, so it would really need changes in just one place,
along with some expanded prototypes with ignored arguments in some other
places).

But it _could_ be a performance helper for some strange loads (write a
partial page and immediately read it back - what a stupid program), and
more importantly Al Viro felt earlier that a "partial read" approach might
help his metadata-in-page-cache stuff because metadata tends to sometimes
be scattered wildly across the disk.

So then we'd have

	int (*readpage)(struct file *, struct page *, unsigned offset, unsigned len);

and the semantics would be:
 - the function needs to start IO for _at_least_ the page area
   [offset, offset+len[
 - return error code for _immediate_ errors (ie not asynchronous)
 - if there was an asynchronous read error, we set PG_error
 - if the page is fully populated, we set PG_uptodate
 - if the page was not fully populated, but the partial read succeeded,
   the filesystem needs to have some way of keeping track of the partial
   success ("page->buffers" is obviously the way for a block-based one),
   and must _not_ set PG_uptodate.
 - after the asynchronous operation (whether complete, partial or
   unsuccessful), the page is unlocked to tell the reader that it is done.

Now, this would be coupled with:
 - generic_file_read() does the read-ahead decisions, and may decide that
   we really only need a partial page.

But NOTE! The above is meant to potentially avoid unnecessary IO and thus
speed up the read-in. HOWEVER, it _will_ slow down the case where we first
would read a small part of the page and then soon afterwards read in the
rest of the page. I suspect that is the common case by far, and that the
current whole-page approach is the faster one in 99% of all cases. So I'm
not at all convinced that the above is actually worth it.

If somebody can show that the above is worth it and worth implementing (ie
the Al Viro kind of "I have a real-life schenario where I'd like to use
it"), and implements it (should be a fairly trivial exercise), then I'll
happily accept new semantics like this.

But I do _not_ want to see another new function ("partialread()"), and I
do _not_ want to see synchronous interfaces (Al's first suggestion).

		Linus

