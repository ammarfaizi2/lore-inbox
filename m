Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266825AbUI1KQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUI1KQL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 06:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUI1KQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 06:16:10 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:42393 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266825AbUI1KQD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 06:16:03 -0400
Date: Tue, 28 Sep 2004 12:13:22 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Steven Pratt <slpratt@austin.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC] Simplified Readahead
Message-ID: <20040928101322.GJ2301@suse.de>
References: <4152F46D.1060200@austin.ibm.com> <20040923194216.1f2b7b05.akpm@osdl.org> <41543FE2.5040807@austin.ibm.com> <20040924150523.4853465b.akpm@osdl.org> <4154A2F7.1050909@austin.ibm.com> <20040924160147.27dbc589.akpm@osdl.org> <4158342B.4020505@austin.ibm.com> <20040927122606.78feb424.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040927122606.78feb424.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27 2004, Andrew Morton wrote:
> Steven Pratt <slpratt@austin.ibm.com> wrote:
> >
> > >yup.  POSIX_FADV_WILLNEED should just populate pagecache and should launch
> >  >asynchronous I/O.
> >  >
> > 
> >  Well then this could cause problems (other than congestion) on both the 
> >  current and new code since both will effectivly see 2 reads, the second 
> >  of which may appear to be a seek backwards thus confusing the code 
> >  slightly.  Would it be best to just special case the POSIX_FADV_WILLNEED 
> >  and issue the I/O required (via do_page_cache_readahead) without 
> >  updating any of the window or current page offset  information ?
> 
> That's what we do at present.  do_page_cache_readahead() and
> force_page_cache_readahead() are low-level functions which do not affect
> file->ra_state.
> 
> Except whoops.  POSIX_FADV_WILLNEED is using force_page_cache_readahead(),
> which bypasses the congested check.  Wonder how that happened.
> 
> <digs out the changeset>
> 
> ChangeSet 1.1046.589.14 2003/08/01 10:02:32 akpm@osdl.org
>   [PATCH] rework readahead for congested queues
>   
>   Since Jens changed the block layer to fail readahead if the queue has no
>   requests free, a few changes suggest themselves.
>   
>   - It's a bit silly to go and alocate a bunch of pages, build BIOs for them,
>     submit the IO only to have it fail, forcing us to free the pages again.
>   
>     So the patch changes do_page_cache_readahead() to peek at the queue's
>     read_congested state.  If the queue is read-congested we abandon the entire
>     readahead up-front without doing all that work.
>   
>   - If the queue is not read-congested, we go ahead and do the readahead,
>     after having set PF_READAHEAD.
>   
>     The backing_dev_info's read-congested threshold cuts in when 7/8ths of
>     the queue's requests are in flight, so it is probable that the readahead
>     abandonment code in __make_request will now almost never trigger.
>   
>   - The above changes make do_page_cache_readahead() "unreliable", in that it
>     may do nothing at all.
>   
>     However there are some system calls:
>   
>   	- fadvise(POSIX_FADV_WILLNEED)
>   	- madvise(MADV_WILLNEED)
>   	- sys_readahead()
>   
>     In which the user has an expectation that the kernel will actually
>     perform the IO.
>   
>     So the patch creates a new "force_page_cache_readahead()" which will
>     perform the IO regardless of the queue's congestion state.
>   
>     Arguably, this is the wrong thing to do: even though the application
>     requested readahead it could be that the kernel _should_ abandon the user's
>     request because the disk is so busy.
>   
>     I don't know.  But for now, let's keep the above syscalls behaviour
>     unchanged.  It is trivial to switch back to do_page_cache_readahead()
>     later.
> 
> 
> So there we have it.  The reason why normal readahead skips congested
> queues is because the block layer will drop the I/O on the floor *anyway*
> because it also skips congested queues for readahead I/O requests.
> 
> And fadvise() was switched to force_page_cache_readahead() because that was
> the old behaviour.
> 
> But PF_READAHEAD isn't there any more, and BIO_RW_AHEAD and BIO_RW_BLOCK
> are not used anywhere, so we broke that.  Jens, do you remember what
> happened there?

Nothing changed from the block layer point of view (in 2.6 or earler,
rw_ahead was always tossed away for congested queues). Why the
read-ahead algorithms dropped PF_READAHEAD or flagging bio_rw_ahead() I
don't know, I haven't worked on that.

-- 
Jens Axboe

