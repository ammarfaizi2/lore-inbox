Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262171AbSJNUVh>; Mon, 14 Oct 2002 16:21:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262178AbSJNUVh>; Mon, 14 Oct 2002 16:21:37 -0400
Received: from packet.digeo.com ([12.110.80.53]:2496 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262171AbSJNUVf>;
	Mon, 14 Oct 2002 16:21:35 -0400
Message-ID: <3DAB28AA.C5FD10A5@digeo.com>
Date: Mon, 14 Oct 2002 13:27:22 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [patch, feature] nonlinear mappings, prefaulting support, 2.5.42-F8
References: <Pine.LNX.4.44.0210141334100.17808-100000@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Oct 2002 20:27:21.0962 (UTC) FILETIME=[1990A4A0:01C273C0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> ...
> 
> - readahead: currently filemap_populate() does not initiate further
>   readahead - this is mainly to recognize the mostly random nature of
>   remap_file_pages() remappings. Or should we trust the readahead engine
>   and use one filemap_getpage() function for filemap_nopage() and
>   filemap_populate()? The readahead should not go beyond the window
>   specified by the populate() function, which is distinct from the mostly
>   guessing work filemap_nopage() has to do. This is the reason why i
>   separated the two codepaths, although they did similar things.

We will need some way of scheduling large chunks of reads concurrently.
I'd agree that we can do better than just relying on the current
readahead/readaround code though.

It looks to be pretty simple - work out the file offset and number of
pages which are covered by the remap_file_pages() call and then pass
those to do_page_cache_readahead().  It will start async reads of any
not-present pages in the range.  Then we can drop into your current code
and start waiting on the IO.

do_page_cache_readahead() is independent of the file->f_ra state.  It's
just a "get this chunk of the file into pagecache" function.

A few lines on entry to filemap_populate() will do this.  The readahead
code does preallocate and pin its pages before starting IO, so we'd
need some checks that the user isn't asking for a ridiculous amount
of memory.

hm.  Actually this may simplify things.  Just run do_page_cache_readahead()
against the affected file area and then we *know* that all pages are
present, unless there's eviction happening.  And handle the latter
via SIGBUS.  If that's a reasonable approach then filemap_getpage()
just becomes:

	page = find_get_page(mapping, index);
	if (page)
		wait_on_page_locked(page);
	return page;	/* Caller checks PageUptodate */


All the above gives optimal IO scheduling for a single call to
remap_file_pages().  But there are additional IO scheduling 
benefits available from launching IO against the separate chunks
of the file which will be subject to remap_file_pages() in the
future.  Only the application knows that.  Seems that sys_readahead()
is perfectly suited to this.

> i've also tested the patch by unconditionally enabling prefaulting in
> mmap(), which produced a fully working system,

That's a good thing.  If you can suggest any additional temp changes
along these lines, that would help to get this code settled down quickly.
I'd suggest you just include those things in the diff for the while,
if poss.

> all in one, nonlinear mappings (not present in any other OS i'm aware of)
> would IMO be a nice twist to the already excellent and incredibly flexible
> Linux VM. Comments, suggestions are welcome!

Yup.  What additional work do you believe is needed before this
is ready to go?  (Apart from making it compile on sparc ;))

Are you missing a page_cache_release() on the error path in install_page()?
