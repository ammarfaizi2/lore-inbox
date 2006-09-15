Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750953AbWIOHMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750953AbWIOHMA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 03:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbWIOHMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 03:12:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25240 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750921AbWIOHL7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 03:11:59 -0400
Date: Fri, 15 Sep 2006 00:11:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-mm@kvack.org, Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Mike Waychison <mikew@google.com>
Subject: Re: [RFC] page fault retry with NOPAGE_RETRY
Message-Id: <20060915001151.75f9a71b.akpm@osdl.org>
In-Reply-To: <1158274508.14473.88.camel@localhost.localdomain>
References: <1158274508.14473.88.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sep 2006 08:55:08 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> in mm.h:
> 
>  #define NOPAGE_SIGBUS   (NULL)
>  #define NOPAGE_OOM      ((struct page *) (-1))
> +#define NOPAGE_RETRY	((struct page *) (-2))
> 
> and in memory.c, in do_no_page():
> 
> 
>         /* no page was available -- either SIGBUS or OOM */
>         if (new_page == NOPAGE_SIGBUS)
>                 return VM_FAULT_SIGBUS;
>         if (new_page == NOPAGE_OOM)
>                 return VM_FAULT_OOM;
> +       if (new_page == NOPAGE_RETRY)
> +               return VM_FAULT_MINOR;

Google are using such a patch (Mike owns it).

It is to reduce mmap_sem contention with threaded apps.  If one thread
takes a major pagefault, it will perform a synchronous disk read while
holding down_read(mmap_sem).  This causes any other thread which wishes to
perform any mmap/munmap/mprotect/etc (which does down_write(mmap_sem)) to
block behind that disk IO.  As you can understand, that can be pretty bad
in the right circumstances.

The patch modifies filemap_nopage() to look to see if it needs to block on
the page coming uptodate and if so, it does up_read(mmap_sem);
wait_on_page_locked(); return NOPAGE_RETRY.  That causes the top-level
do_page_fault() code to rerun the entire pagefault.

It hasn't been submitted for upstream yet because

a) To avoid livelock possibilities (page reclaim, looping FADV_DONTNEED,
   etc) it only does the retry a single time.  After that it falls back to
   the traditional synchronous-read-inside-mmap_sem approach.  A flag in
   current->flags is used to detect the second attempt.  It keeps the patch
   simple, but is a bit hacky.

   To resolve this cleanly I'm thinking we change all the pagefault code
   everywhere: instantiate a new `struct pagefault_args' in do_page_fault()
   and pass that all around the place.  So all the pagefault code, all the
   ->nopage handlers etc will take a single argument.

   This will, I hope, result in less code, faster code and less stack
   consumption.  It could also be used for things like the
   lock-the-page-in-filemap_nopage() proposal: the ->nopage()
   implementation could set a boolean in pagefault_args indicating whether
   the page has been locked.

   And, of course, fielmap_nopage could set another boolean in
   pagefault_args to indicate that it has already tried to rerun the
   pagefault once.

b) It could be more efficient.  Most of the time, there's no need to
   back all the way out of the pagefault handler and rerun the whole thing.
   Because most of the time, nobody changed anything in the mm_struct.  We
   _could_ just retake the mmap_sem after the page comes uptodate and, if
   nothing has changed, proceed.  I see two ways of doing this:

   - The simple way: look to see if any other processes are sharing
     this mm_struct.  If not, just do the synchronous read inside mmap_sem.

   - The better way: put a sequence counter in the mm_struct,
     increment that in every place where down_write(mmap_sem) is performed.
      The pagefault code then can re-take the mmap_sem for reading and look
     to see if the sequence counter is unchanged.  If it is, proceed.  If
     it _has_ changed then drop mmap_sem again and return NOPAGE_RETRY.

otoh, maybe using another bit in page->flags is a good compromise ;)

Mike, could you whip that patch out please?
