Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWC3IDF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWC3IDF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:03:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932092AbWC3IDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:03:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:14494 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932093AbWC3IDC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:03:02 -0500
Date: Thu, 30 Mar 2006 00:02:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH][RFC] splice support
Message-Id: <20060330000240.156f4933.akpm@osdl.org>
In-Reply-To: <20060330074534.GL13476@suse.de>
References: <20060329122841.GC8186@suse.de>
	<20060329143758.607c1ccc.akpm@osdl.org>
	<20060330074534.GL13476@suse.de>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> 
> ...
>
> > - I think the `size_t left' in do_splice_to() can overflow if f_pos is
> >   sufficiently different from i_size.
> 
> They're both loff_t.

Nope:

+static long do_splice_to(struct file *in, struct inode *pipe, size_t len,
+			 unsigned long flags)
+{
+	if (in->f_op && in->f_op->splice_read) {
+		loff_t isize = i_size_read(in->f_mapping->host);
+		size_t left;
+
+		if (unlikely(in->f_pos >= isize))
+			return 0;
+	
+		left = isize - in->f_pos;

It's doing

		32bit = 64bit - 64bit;

> 
> > - In generic_file_splice_read():
> > 
> >   - nonatomic modification of f_pos.  Is i_mutex held?  (see
> >     generic_file_llseek())
> 
> Fixed.

OK.  In some ways I agree with Nick that a pwrite/pread-like interface is
nicer, so things are more stateless and threads don't have to fight over
f_pos.  Dunno..

> >   - These pages can get truncated at any time they're unlocked.  Does
> >     the code cope with all that?
> 
> I guess page_cache_pipe_buf_map() needs the same ->mapping check?

That would seem appropriate.

btw, that function might have a problem I think - it returns NULL with
the page locked, but pipe_to_sendpage() and other callers don't appear to
unlock it.

> > - hm.  What happens if the pages which find_get_pages() returned are
> > not contiguous in pagecache?  I think your `pages' array gets all
> > jumbled up.
>
> Hmm please expand. 

find_get_pages() does "find me the next N pages above `index' which are
presently in pagecache'.  So it can return an array of page*'s which do not
represent contiguous pages in the file - there can be holes in there.

IOW: pages[n]->index !necessarily= pages[n+1]->index-1

Maybe the code handles that by making sure that all the pages in the range
are already in pagecache - I didn't check.  But that would take some heroic
locking.

> >   - release_pages() might be faster than one-at-a-time page_cache_release()
> 
> We should not hit that case very often. Not sure how to handle the
> 'cold' right now, so I'll just leave it.

OK.  ("cold" is a wild-ass guess as to whether you think those pages'
contents are likely to be be in CPU cache.  I'd guess "yes", so cold=0).

