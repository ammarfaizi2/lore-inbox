Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132220AbQLVRSu>; Fri, 22 Dec 2000 12:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132236AbQLVRSa>; Fri, 22 Dec 2000 12:18:30 -0500
Received: from hermes.mixx.net ([212.84.196.2]:40454 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S132220AbQLVRSU>;
	Fri, 22 Dec 2000 12:18:20 -0500
Message-ID: <3A438545.2D9998AE@innominate.de>
Date: Fri, 22 Dec 2000 17:45:57 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Mason <mason@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] changes to buffer.c (was Test12 ll_rw_block error)
In-Reply-To: <Pine.LNX.4.21.0012212229190.2603-100000@freak.distro.conectiva> <243950000.977493376@coffee>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason wrote:
> 
> On Thursday, December 21, 2000 22:38:04 -0200 Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
> >
> > On Thu, 21 Dec 2000, Andreas Dilger wrote:
> >
> >> Marcelo Tosatti writes:
> >> > It seems your code has a problem with bh flush time.
> >> >
> >> > In flush_dirty_buffers(), a buffer may (if being called from kupdate) only
> >> > be written in case its old enough. (bh->b_flushtime)
> >> >
> >> > If the flush happens for an anonymous buffer, you'll end up writing all
> >> > buffers which are sitting on the same page (with block_write_anon_page),
> >> > but these other buffers are not necessarily old enough to be flushed.
> >>
> >> This isn't really a "problem" however.  The page is the _maximum_ age of
> >> the buffer before it needs to be written.  If we can efficiently write it
> >> out with another buffer
> >
> >> (essentially for free if they are on the same spot on disk)
> >
> > Are you sure this is true for buffer pages in most cases?
> 
> It's a good point.  block_write_anon_page could be changed to just 
> write the oldest buffer and redirty the page (if the buffers are 
> far apart).  If memory is tight, and we *really* need the page back,
> it will be flushed by try_to_free_buffers.
> 
> It seems a bit nasty to me though...writepage should write the page.

Um.  Why cater to the uncommon case of 1K blocks?  Just let
bdflush/kupdated deal with them in the normal way - it's pretty
efficient.  Only try to do the clustering optimization when buffer size
matches memory page size.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
