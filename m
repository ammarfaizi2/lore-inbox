Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129906AbQLVXvN>; Fri, 22 Dec 2000 18:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130133AbQLVXvD>; Fri, 22 Dec 2000 18:51:03 -0500
Received: from d185fcbd7.rochester.rr.com ([24.95.203.215]:25860 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129906AbQLVXus>; Fri, 22 Dec 2000 18:50:48 -0500
Date: Fri, 22 Dec 2000 18:18:51 -0500
From: Chris Mason <mason@suse.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: Andreas Dilger <adilger@turbolinux.com>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Russell Cattelan <cattelan@thebarn.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
Message-ID: <84320000.977527131@coffee>
In-Reply-To: <Pine.LNX.4.21.0012221730270.3382-100000@freak.distro.conectiva>
X-Mailer: Mulberry/2.0.6b1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday, December 22, 2000 17:52:28 -0200 Marcelo Tosatti
<marcelo@conectiva.com.br> wrote:

> There is one more nasty issue to deal with. 
> 
> You only want to take into account the buffer flushtime if
> "check_flushtime" parameter is passed as true to flush_dirty_buffers
> (which is done by kupdate).
> 
> Thinking a bit more about the issue, I dont see any reason why we want to
> write all buffers of an anonymous page at
> sync_buffers/flush_dirty_buffers.
> 
> I think we could simply write the buffer with ll_rw_block() if the page
> which this buffer is sitting on does not have mapping->a_ops->writepage
> operation defined.
> 

It is enough to leave buffer heads we don't flush on the dirty list (and
redirty the page), they'll get written by a future loop through
flush_dirty_pages, or by page_launder.  We could use ll_rw_block instead,
even though anon pages do have a writepage with this patch (just check if
page->mapping == &anon_space_mapping).

There are lots of things we could try here, including some logic inside
block_write_anon_page to check the current memory pressure/dirty levels to
see how much work should be done.

I'll play with this a bit, but more ideas would be appreciated.

BTW, recent change to my local code was to remove the ll_rw_block call from
sync_page_buffers.  It seemed cleaner than making try_to_free_buffers
understand that sometimes writepage will be called, and sometimes the page
will end up unlocked because of it....comments?

-chris

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
