Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932263AbWAUDnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbWAUDnq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 22:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932267AbWAUDnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 22:43:46 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:62934 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932263AbWAUDnp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 22:43:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=G90T4TFpNt5iqOrg4od52P0O9i8bJ0T7osXJfdIINU7xWVM5fx78j9eH9Erasiv0xsT9bFLq6bmdpRpvhuRPcFS9TYRd9bpdDiGdZMAKLV1Wnc9dT8ka54SyKbzpAVzZaZWNYVhCYA9awTtEzL22GloVoLW6XPtueqLSqQAt8Gs=
Message-ID: <9e4733910601201943y77fb9a1fgf2a5f0d48eca1344@mail.gmail.com>
Date: Fri, 20 Jan 2006 22:43:44 -0500
From: Jon Smirl <jonsmirl@gmail.com>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: sendfile() with 100 simultaneous 100MB files
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060121022237.GW3927@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <9e4733910601201353g36284133xf68c4f6eae1344b4@mail.gmail.com>
	 <20060121022237.GW3927@mea-ext.zmailer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/06, Matti Aarnio <matti.aarnio@zmailer.org> wrote:
> On Fri, Jan 20, 2006 at 04:53:44PM -0500, Jon Smirl wrote:
> > I was reading this blog post about the lighttpd web server.
> > http://blog.lighttpd.net/articles/2005/11/11/optimizing-lighty-for-high-concurrent-large-file-downloads
> > It describes problems they are having downloading 100 simultaneous 100MB files.
>
>     "more than 100 files of each more than 100 MB"
>
> > In this post they complain about sendfile() getting into seek storms and
> > ending up in 72% IO wait. As a result they built a user space
> > mechanism to work around the problems.
> >
> > I tried looking at how the kernel implements sendfile(), I have
> > minimal understanding of how the fs code works but it looks to me like
> > sendfile() is working a page at a time. I was looking for code that
> > does something like this...
> >
> > 1) Compute an adaptive window size and read ahead the appropriate
> > number of pages.  A larger window would minimize disk seeks.
>
> Or maybe not..   larger main memory would help more.  But there is
> another issue...
>
> > 2) Something along the lines of as soon as a page is sent age the page
> > down in to the middle of page ages. That would allow for files that
> > are repeatedly sent, but also reduce thrashing from files that are not
> > sent frequently and shouldn't stay in the page cache.
> >
> > Any other ideas why sendfile() would get into a seek storm?
>
>

Thanks for pointing me in the right direction in the source.
Is there a write up anywhere on how sendfile() works?


> Deep inside the  do_generic_mapping_read() there is a loop that
> reads the source file with read-ahead processing, processes it
> one page at the time, calls actor (which sends the file) and
> releases the page cache of that page.  -- with convoluted things
> done when page isn't in page cache, etc..
>
>
>                 /*
>                  * Ok, we have the page, and it's up-to-date, so
>                  * now we can copy it to user space...
>                  *
>                  * The actor routine returns how many bytes were actually used..
>                  * NOTE! This may not be the same as how much of a user buffer
>                  * we filled up (we may be padding etc), so we can only update
>                  * "pos" here (the actor routine has to update the user buffer
>                  * pointers and the remaining count).
>                  */
>                 ret = actor(desc, page, offset, nr);
>                 offset += ret;
>                 index += offset >> PAGE_CACHE_SHIFT;
>                 offset &= ~PAGE_CACHE_MASK;
>
>                 page_cache_release(page);
>                 if (ret == nr && desc->count)
>                         continue;
>
>
> That is, if machine memory is so limited (file pages + network
> tcp buffers!) that source file pages gets constantly purged out,
> there is not much that one can do.
>
> That described workaround is essentially to read the file to server
> process memory with half an MB sliding window, and then  writev()
> from there to socket.  Most importantly it does the reading in _large_
> chunks.

100 users at 500K each is 50MB of read ahead, that's not a huge amount of memory

>
> The read-ahead in sendfile is done by  page_cache_readahead(), and
> via fairly complicated circumstances it ends up using
>
>         bdi = mapping->backing_dev_info;
>
>         switch (advice) {
>         case POSIX_FADV_NORMAL:
>                 file->f_ra.ra_pages = bdi->ra_pages;
>                 break;
>         case POSIX_FADV_RANDOM:
>                 file->f_ra.ra_pages = 0;
>                 break;
>         case POSIX_FADV_SEQUENTIAL:
>                 file->f_ra.ra_pages = bdi->ra_pages * 2;
>                 break;
>         ....
>
>
> Default value for ra_pages is equivalent of  128 kB, which
> should be enough...

Does using sendfile() set MADV_SEQUENTIAL and MADV_DONTNEED implicitly?
If not would setting these help?

> Why it goes to seek trashing ?   Because read-ahead buffer memory
> space is being processed in very small fragments, and the sendpage
> to socket writing logic pauses frequently, during which read-ahead
> buffers become recycled...

I was following with you until this part. I thought sendfile() worked
using mmap'd files and that readahead was done into the global page
cache.

But this makes me think that read ahead is instead going into another
pool. How large is this pool? The user space scheme is using 50MB of
readahead cache, will the kernel do that much readahead if needed?

> In  writev()  solution the pausing in socket sending side does
> not appear so heavily in source file reading side, as things
> get buffered in non-discardable memory space of userspace process.

Does this scenario illustrate a problem with the current sendfile()
implementation? I thought the goal of sendfile() was to always be the
best way to send complete files. This is a case where user space is
clearly beating sendfile().

--
Jon Smirl
jonsmirl@gmail.com
