Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266245AbRF3SW3>; Sat, 30 Jun 2001 14:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266244AbRF3SWT>; Sat, 30 Jun 2001 14:22:19 -0400
Received: from deliverator.sgi.com ([204.94.214.10]:63271 "EHLO
	deliverator.sgi.com") by vger.kernel.org with ESMTP
	id <S266241AbRF3SWN>; Sat, 30 Jun 2001 14:22:13 -0400
Message-Id: <200106301823.f5UINct03361@jen.americas.sgi.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: Linus Torvalds <torvalds@transmeta.com>
cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Bounce buffer deadlock 
In-Reply-To: <Pine.LNX.4.33.0106301048180.1470-100000@penguin.transmeta.com>
Comments: In-reply-to Linus Torvalds <torvalds@transmeta.com>
   message dated "Sat, 30 Jun 2001 10:50:56 -0700."
Date: Sat, 30 Jun 2001 13:23:37 -0500
From: Steve Lord <lord@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sat, 30 Jun 2001, Steve Lord wrote:
> >
> > OK, sounds reasonable, time to go download and merge again I guess!
> 
> For 2.4.7 or so, I'll make a backwards-compatibility define (ie make
> GFP_BUFFER be the same as the new GFP_NOIO, which is the historical
> behaviour and the anally safe value, if not very efficient), but I'm
> planning on releasing 2.4.6 without it, to try to flush out people who are
> able to take advantage of the new extended semantics out of the
> woodworks..
> 
> 		Linus

Consider XFS flushed out (once I merge). This, for us, is the tricky part:


torvalds@transmeta.com said:
>> That allows us to do the best we can - still flushing out dirty
>> buffers when that's ok (like when a filesystem wants more memory), and
>> giving the allocator better control over exactly _what_ he objects to.

XFS introduces the concept of the low level flush of a buffer not always
being really a low level flush, since a delayed allocate buffer can end
up reentering the filesystem in order to create the true on disk allocation.
This in turn can cause a transaction and more memory allocations. The really
nasty case we were using GFP_BUFFER for is a memory allocation which is from
within a transaction, we cannot afford to have another transaction start out
of the bottom of memory allocation as it may require resources locked by
the transaction which is allocating memory.

Steve



