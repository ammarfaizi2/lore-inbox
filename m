Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261898AbREYVKf>; Fri, 25 May 2001 17:10:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261907AbREYVK0>; Fri, 25 May 2001 17:10:26 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:53336 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S261881AbREYVKW>; Fri, 25 May 2001 17:10:22 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: DVD blockdevice buffers
In-Reply-To: <Pine.LNX.4.21.0105250959580.11312-100000@penguin.transmeta.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 25 May 2001 15:07:11 -0600
In-Reply-To: Linus Torvalds's message of "Fri, 25 May 2001 10:16:00 -0700 (PDT)"
Message-ID: <m166epgmtc.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On 25 May 2001, Eric W. Biederman wrote:
> > 
> > For the small random read case we could use a 
> > mapping->a_ops->readpartialpage 
> 
> No, if so I'd prefer to just change "readpage()" to take the same kinds of
> arguments commit_page() does, namely the beginning and end of the read
> area. 

No.

I obviously picked a bad name, and a bad place to start.
int data_uptodate(struct page *page, unsigned offset, unsigned len)

This is really an extension to PG_uptodate, not readpage.  It should
never ever do any I/O.  It should just implement a check to see
if we have all of the data wanted already in the page in the page
cache.  As simply a buffer checking entity it will likely share
virtualy 0 code with read_page.

> Filesystems could choose to ignore the arguments completely, and just act
> the way they already do - filling in the whole page.
> 
> OR a filesystem might know that the page is partially up-to-date (because
> of a partial write), and just return an immediate "this area is already
> uptodate" return code or something. Or it could even fill in the page
> partially, and just unlock it (but not mark it up-to-date: the reader then
> has to wait for the page and then look at PG_error to decide whether the
> partial read succeeded or not).

First mm/filemap.c has generic cache management, so it should make the
decision.

The logic is does this page have the data in cache?
If so just return it.

Otherwise read all that you can at once.  

So we either want a virtual function that can make the decision on
a per filesystem bases if we have the data we need in the page cache.
Or we need to convert the buffer_head into a more generic entity
so everyone can use it.

> I don't think it really matters, I have to say. It would be very easy to
> implement (all the buffer-based filesystems already use the common
> fs/buffer.c readpage, so it would really need changes in just one place,
> along with some expanded prototypes with ignored arguments in some other
> places).
> 
> But it _could_ be a performance helper for some strange loads (write a
> partial page and immediately read it back - what a stupid program), and
> more importantly Al Viro felt earlier that a "partial read" approach might
> help his metadata-in-page-cache stuff because metadata tends to sometimes
> be scattered wildly across the disk.

Maybe I think despite the similarities (partial pages) Al & and I are
looking at two entirely different problems.

> So then we'd have
> 
> 	int (*readpage)(struct file *, struct page *, unsigned offset, unsigned
> len);
> 
> 
> and the semantics would be:
>  - the function needs to start IO for _at_least_ the page area
>    [offset, offset+len[
>  - return error code for _immediate_ errors (ie not asynchronous)
>  - if there was an asynchronous read error, we set PG_error
>  - if the page is fully populated, we set PG_uptodate
>  - if the page was not fully populated, but the partial read succeeded,
>    the filesystem needs to have some way of keeping track of the partial
>    success ("page->buffers" is obviously the way for a block-based one),
>    and must _not_ set PG_uptodate.
>  - after the asynchronous operation (whether complete, partial or
>    unsuccessful), the page is unlocked to tell the reader that it is done.
> 
> Now, this would be coupled with:
>  - generic_file_read() does the read-ahead decisions, and may decide that
>    we really only need a partial page.
> 
> But NOTE! The above is meant to potentially avoid unnecessary IO and thus
> speed up the read-in. HOWEVER, it _will_ slow down the case where we first
> would read a small part of the page and then soon afterwards read in the
> rest of the page. I suspect that is the common case by far, and that the
> current whole-page approach is the faster one in 99% of all cases. So I'm
> not at all convinced that the above is actually worth it.

I don't want partial I/O at all.  And I always want to see reads
reading in all of the data for a page.  I just want an interface
where we can say hey we don't actually have to do any I/O for this
read request, give them back their data.

> If somebody can show that the above is worth it and worth implementing (ie
> the Al Viro kind of "I have a real-life schenario where I'd like to use
> it"), and implements it (should be a fairly trivial exercise), then I'll
> happily accept new semantics like this.
> 
> But I do _not_ want to see another new function ("partialread()"), and I
> do _not_ want to see synchronous interfaces (Al's first suggestion).

My naming mistake I don't want to see this logic combined with
readpage.  That is an entirely different case.

I can't see how adding a slow case to PageUptodate to check for a
partially uptodate page could hurt our performance.  And I can imagine
how it could help.

Eric
