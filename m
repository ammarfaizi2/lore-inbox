Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWAUCWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWAUCWt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 21:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWAUCWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 21:22:49 -0500
Received: from z2.cat.iki.fi ([212.16.98.133]:6617 "EHLO z2.cat.iki.fi")
	by vger.kernel.org with ESMTP id S1750746AbWAUCWt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 21:22:49 -0500
Date: Sat, 21 Jan 2006 04:22:37 +0200
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: sendfile() with 100 simultaneous 100MB files
Message-ID: <20060121022237.GW3927@mea-ext.zmailer.org>
References: <9e4733910601201353g36284133xf68c4f6eae1344b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e4733910601201353g36284133xf68c4f6eae1344b4@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 20, 2006 at 04:53:44PM -0500, Jon Smirl wrote:
> I was reading this blog post about the lighttpd web server.
> http://blog.lighttpd.net/articles/2005/11/11/optimizing-lighty-for-high-concurrent-large-file-downloads
> It describes problems they are having downloading 100 simultaneous 100MB files.

    "more than 100 files of each more than 100 MB"

> In this post they complain about sendfile() getting into seek storms and
> ending up in 72% IO wait. As a result they built a user space
> mechanism to work around the problems.
> 
> I tried looking at how the kernel implements sendfile(), I have
> minimal understanding of how the fs code works but it looks to me like
> sendfile() is working a page at a time. I was looking for code that
> does something like this...
> 
> 1) Compute an adaptive window size and read ahead the appropriate
> number of pages.  A larger window would minimize disk seeks.

Or maybe not..   larger main memory would help more.  But there is
another issue...

> 2) Something along the lines of as soon as a page is sent age the page
> down in to the middle of page ages. That would allow for files that
> are repeatedly sent, but also reduce thrashing from files that are not
> sent frequently and shouldn't stay in the page cache.
> 
> Any other ideas why sendfile() would get into a seek storm?


Deep inside the  do_generic_mapping_read() there is a loop that
reads the source file with read-ahead processing, processes it
one page at the time, calls actor (which sends the file) and
releases the page cache of that page.  -- with convoluted things
done when page isn't in page cache, etc..


                /*
                 * Ok, we have the page, and it's up-to-date, so
                 * now we can copy it to user space...
                 *
                 * The actor routine returns how many bytes were actually used..
                 * NOTE! This may not be the same as how much of a user buffer
                 * we filled up (we may be padding etc), so we can only update
                 * "pos" here (the actor routine has to update the user buffer
                 * pointers and the remaining count).
                 */
                ret = actor(desc, page, offset, nr);
                offset += ret;
                index += offset >> PAGE_CACHE_SHIFT;
                offset &= ~PAGE_CACHE_MASK;

                page_cache_release(page);
                if (ret == nr && desc->count)
                        continue;


That is, if machine memory is so limited (file pages + network
tcp buffers!) that source file pages gets constantly purged out, 
there is not much that one can do.

That described workaround is essentially to read the file to server
process memory with half an MB sliding window, and then  writev()
from there to socket.  Most importantly it does the reading in _large_
chunks.

The read-ahead in sendfile is done by  page_cache_readahead(), and
via fairly complicated circumstances it ends up using 

        bdi = mapping->backing_dev_info;

        switch (advice) {
        case POSIX_FADV_NORMAL:
                file->f_ra.ra_pages = bdi->ra_pages;
                break;
        case POSIX_FADV_RANDOM:
                file->f_ra.ra_pages = 0;
                break;
        case POSIX_FADV_SEQUENTIAL:
                file->f_ra.ra_pages = bdi->ra_pages * 2;
                break;
	....


Default value for ra_pages is equivalent of  128 kB, which
should be enough...  

Why it goes to seek trashing ?   Because read-ahead buffer memory
space is being processed in very small fragments, and the sendpage
to socket writing logic pauses frequently, during which read-ahead
buffers become recycled...

In  writev()  solution the pausing in socket sending side does
not appear so heavily in source file reading side, as things
get buffered in non-discardable memory space of userspace process.

> --
> Jon Smirl
> jonsmirl@gmail.com

/Matti Aarnio
