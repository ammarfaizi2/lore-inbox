Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317258AbSHJTH0>; Sat, 10 Aug 2002 15:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317261AbSHJTH0>; Sat, 10 Aug 2002 15:07:26 -0400
Received: from pc-62-30-255-50-az.blueyonder.co.uk ([62.30.255.50]:25797 "EHLO
	kushida.apsleyroad.org") by vger.kernel.org with ESMTP
	id <S317258AbSHJTHZ>; Sat, 10 Aug 2002 15:07:25 -0400
Date: Sat, 10 Aug 2002 20:10:27 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
Message-ID: <20020810201027.E306@kushida.apsleyroad.org>
References: <20020810185508.A423@kushida.apsleyroad.org> <Pine.LNX.4.44.0208101134510.2197-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0208101134510.2197-100000@home.transmeta.com>; from torvalds@transmeta.com on Sat, Aug 10, 2002 at 11:42:44AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Yes, with read() you have to do a brk() or mmap(MAP_ANON) (and brk() is 
> the _much_ faster of the two).

Ouch, that means a typical user-space program/library that wants to use
this technique has to have an intimate relationship with its malloc()
implementation: it's not in general safe to call brk() unless you are
the memory allocator.  (Yes, I know you can call brk() with Glibc's
malloc(), but... dependencies upon dependencies!)  And even when it is
safe to allocate with brk(), there's no safe way to free that memory.

So this would be fine for the stdio built in to Glibc, perhaps.

> But with mmap() you need to do a fstat() and a munmap() (while with read
> you just re-use the area, and we'd do the right thing thanks to the
> COW-ness of the pages).

Granted, you might re-use the area if you're doing block reads like
stdio, compiler, XML parser etc.  But not a few programs want to:

   1. Allocate enough memory to hold whole file.
   2. Load file into memory.

> Also, because of the delayed nature of mmap()/fault, it has some strange
> behaviour if somebody is editing your file in the middle of the compile -
> with read() you might get strange syntax errors if somebody changes the
> file half-way, but with mmap() your preprocessor may get a SIGSEGV in the
> middle just because the file was truncated..

Isn't that SIGBUS :-)
(Not that the architectures are at all consistent on this..)
  
> In general, I think read() tends to be the right (and simpler) interface
> to use if you don't explicitly want to take advantage of the things mmap
> offers (on-demand mappings, no-write-back pageouts, VM coherency etc).

I agree, although I think this particular optimisation requires some
quite unusual preparation by user space - I still think GCC would need
to call open/fstat/mmap/read/munmap/close.

You've rightly pointed out that memcpy() is faster for a page, rather
than VM tweaking.  But this isn't true of large reads, is it?
Then the TLB invalidation cost could, in principle, be amortised over
the whole large read.

-- Jamie
