Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264880AbUEQGMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264880AbUEQGMF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 02:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264893AbUEQGMF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 02:12:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:61631 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264880AbUEQGL6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 02:11:58 -0400
Date: Sun, 16 May 2004 23:11:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: elenstev@mesatop.com, lm@bitmover.com, wli@holomorphy.com,
       hugh@veritas.com, adi@bitmover.com, scole@lanl.gov,
       support@bitmover.com, linux-kernel@vger.kernel.org
Subject: Re: 1352 NUL bytes at the end of a page? (was Re: Assertion `s &&
 s->tree' failed: The saga continues.)
Message-Id: <20040516231120.405a0d14.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org>
References: <200405132232.01484.elenstev@mesatop.com>
	<20040517022816.GA14939@work.bitmover.com>
	<Pine.LNX.4.58.0405161936490.25502@ppc970.osdl.org>
	<200405162136.24441.elenstev@mesatop.com>
	<Pine.LNX.4.58.0405162152290.25502@ppc970.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> Andrew, the obvious culprit would be the memset() in fs/buffer.c 
>  (block_write_full_page() to be precise):
> 
>  	memset(kaddr + offset, 0, PAGE_CACHE_SIZE - offset);
> 
>  imagine that the "write()" function updates i_size late - after having 
>  written out the new contents to the page, and _after_ havign unlocked the 
>  page, and now we get a writeback at the wrong time, and we decide to clear 
>  out the end of the page because we think it's past i_size.
> 
>  Andrew, what do you think?

Interesting.  Playing with i_size like that in writepage() _is_ scary.  My
immediate reaction is that if this race was real, it's so gross that we
would have spotted it before now in either 2.4 or 2.5->2.6.

Easy test: Steve, could you remove that memset from
block_write_full_page(), see if it changes anything?

It's not very important - it's there because if an application
(incorrectly) writes to mapped data outside EOF we're supposed to drop
their data and write zeroes instead.

>  I think this race does exist, since generic_file_aio_write_nolock()
>  literally _does_ update i_size only after it has written all the pages, so
>  I don't see why a "block_write_full_page()" couldn't come in there between 
>  and zero them out again at the _old_ i_size boundary.

i_size is updated in generic_commit_write(), on a per-page basis, or I'm
missing something?  I sure hope so.

Let's go through the scenarios.

On entry to block_write_full_page(), i_size is in the middle of this page
somewhere.  We're worried that i_size can change, and that this will cause
block_write_full_page() to incorrectly zero out the tail of the page.

Well we can stop right there, because the only way someone can get some
more non-zero user data into this page before we memset and write it is by
locking the page beforehand, and block_write_full_page() has the page lock.
(Or they can write stuff into it via mmap, but writing to the page outside
i_size is an application bug).

Other ways in which i_size can change under block_write_full_page()'s feet
are:

- Someone did a truncate.

  No problem - the page is about to be invalidated and chopped off the
  file anyway.

- Someone did an extending truncate into another page.

  OK, i_size will increase but we're still supposed to write zeroes into
  the rest of this page outside the previous i_size.

- Someone extended the file into another page with lseek+write or pwrite.

  Same argumentation as with extending truncate.

- Someone did an extending truncate to another i_size which lands
  *within* this page.

  Writing zeroes is still OK: nobody can get into this page to write new
  user data anyway - it's locked.


Either all that, or I missed something ;) If Steve can try that test it
would be interesting.  Even if removing the memset does make the corruption
go away, this might not be a kernel bug - it could be that the application
is incorrectly relying on mmapped writes outside i_size making it to disk.

As for O_DIRECT: I need to think about that a bit more.  We hold i_sem and
have done an fdatasync prior to entering generic_file_aio_write_nolock() so
there should be no dirty pagecache at this stage anyway.  The VM may decide
to dirty some pagecache and then block_write_full_page() could come in and
look at i_size and race against generic_file_aio_write_nolock()'s O_DIRECT
i_size_write().  But I doubt if bk is using direct-IO in combination with
MAP_SHARED...
