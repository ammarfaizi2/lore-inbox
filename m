Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284336AbRLUX0z>; Fri, 21 Dec 2001 18:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284659AbRLUX0p>; Fri, 21 Dec 2001 18:26:45 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:64005 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S284336AbRLUX03>; Fri, 21 Dec 2001 18:26:29 -0500
Message-ID: <3C23C4D9.F11B2472@zip.com.au>
Date: Fri, 21 Dec 2001 15:25:13 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Marxmeier <mike@marxmeier.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Question on sys_readahead()
In-Reply-To: <3C23BF4B.70BDABBE@marxmeier.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Marxmeier wrote:
> 
> I have a question on sys_readahead and would appreciate
> some hint or a pointer.
> 
> - When was this call added?

Very late one night, we think :)  It was added in linux-2.4.13-pre4.

> - As far as i understand the code it reads the data into
>   the page cache. The data is ready sync and there is no
>   way to do this async and have a notification unless using
>   a separate thread.

It is async.  The call will submit the IO and will return immediately.
It could block on things like memory shortage, request queue exhaustion,
but this is unlikely, and pretty much any syscall could block under these
conditions.

You should be able to poll the status of the readhead pages by mmapping
the relevant section of the file and then using mincore() to find out if
the IO has completed.

> A typical use i could see is preloading some data in the
> page cache from a separate thread (eg. for a media player).

Or from the same thread.
 
> BTW: AFAICS the code is off by one if offset/count is not in
> PAGE_SIZE chunks?
> 
>   unsigned long start = offset >> PAGE_CACHE_SHIFT;
>   unsigned long len = (count + ((long)offset & ~PAGE_CACHE_MASK)) >> PAGE_CACHE_SHIFT;

Looks like it.  If offset is zero and count is 4097, it will only read
one page.

-
