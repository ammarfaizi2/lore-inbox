Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSHJShj>; Sat, 10 Aug 2002 14:37:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317191AbSHJShj>; Sat, 10 Aug 2002 14:37:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12807 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317189AbSHJShi>; Sat, 10 Aug 2002 14:37:38 -0400
Date: Sat, 10 Aug 2002 11:42:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 6/12] hold atomic kmaps across generic_file_read
In-Reply-To: <20020810185508.A423@kushida.apsleyroad.org>
Message-ID: <Pine.LNX.4.44.0208101134510.2197-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 10 Aug 2002, Jamie Lokier wrote:
> 
> Don't forget to include the need for mmap(... MAP_ANON ...) prior to the
> read.

Ahhah! But I _don't_.

Yes, with read() you have to do a brk() or mmap(MAP_ANON) (and brk() is 
the _much_ faster of the two).

But with mmap() you need to do a fstat() and a munmap() (while with read
you just re-use the area, and we'd do the right thing thanks to the
COW-ness of the pages).

So I don't think the MAP_ANON thing is a loss for the read.

And read() is often the much nicer interface, simply because you don't
need to worry about the size of the file up-front etc.

Also, because of the delayed nature of mmap()/fault, it has some strange
behaviour if somebody is editing your file in the middle of the compile -
with read() you might get strange syntax errors if somebody changes the
file half-way, but with mmap() your preprocessor may get a SIGSEGV in the
middle just because the file was truncated..

In general, I think read() tends to be the right (and simpler) interface
to use if you don't explicitly want to take advantage of the things mmap
offers (on-demand mappings, no-write-back pageouts, VM coherency etc).

		Linus

