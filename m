Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316578AbSHJDjw>; Fri, 9 Aug 2002 23:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316580AbSHJDjw>; Fri, 9 Aug 2002 23:39:52 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:31236 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316578AbSHJDjv>;
	Fri, 9 Aug 2002 23:39:51 -0400
Message-ID: <3D548E3D.4F8DC107@zip.com.au>
Date: Fri, 09 Aug 2002 20:53:33 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
References: <3D5464E3.74ED07CC@zip.com.au> <Pine.LNX.4.44.0208091813470.1165-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> ...
>         repeat:
>                 kmap_atomic(..); // this increments preempt count
>                 nr = copy_from_user(..);
>                 kunmap_atomic(..);
> 
>                 /* bytes uncopied? */
>                 if (nr) {
>                         if (!get_user(dummy, start_addr) &&
>                             !get_user(dummy, end_addr))
>                                 goto repeat;
>                         .. handle EFAULT ..
>                 }
> 
> Yes, the above requires some care about getting the details right, but
> notice how it requires absolutely no magic new code, and how it actually
> uses existing well-documented (and has-to-work-anyway) features.
> 

OK.  The kunmap_atomic() could happen on a different CPU, which will
die with CONFIG_DEBUG_HIGHMEM but apart from that, looks much saner.
 
We'll need need to manually fault in the user page on the
generic_file_read() path before taking the kmap, because reading
into an unmapped page is a common case: malloc/read.

Actually, p = malloc(lots); write(fd, p, lots); isn't totally
uncommon either, so the prefault on the write path would help
highmem machines (in which case it'd be best to leave it there
for all machines).

> And notice how it works as a _much_ more generic fix - the above actually
> allows the true anti-deadlock thing where you can basically "test" whether
> the page is already mapped with zero cost, and if it isn't mapped (and you
> worry about deadlocking because you've already locked the page that we're
> writing into), you can make the slow path do a careful "look up the page
> tables by hand" thing.

I don't understand what the pagetable walk is here for?

The kernel will sometimes need to read the page from disk to service
the fault, but it's locked...

We could drop the page lock before the __get_user, but that may
break the expectations of some filesystem's prepare/commit pair.

So I'm not clear on how we can lose the (racy, especially with
preemption) "one huge big hack".

The implicit use of preempt_count to mean "in kmap_copy_user" may
turn ugly.  But if so another tsk->flags bit can be created.   We'll
see...
