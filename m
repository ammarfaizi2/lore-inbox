Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbWFNNfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbWFNNfa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbWFNNfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:35:30 -0400
Received: from nz-out-0102.google.com ([64.233.162.198]:33928 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964920AbWFNNf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:35:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CP2wMj/d4bptUN7Uz4yXgZ8b0W8UBhEvVtZXO93iG8yzo2dBsuOtGZq8Iy9bQBanUcOrO41+/peEfAX62ilZj0G7AQuDOrHOYXeDqhuEQUZRTlLxSaVZvgKji3uLJb8BLROAz7aUSXIhkojbm6N9/XsQ7ZMAq9Ml6Z0E5RfTD4U=
Message-ID: <b0943d9e0606140635u2268c457rb82281a8587368e4@mail.gmail.com>
Date: Wed, 14 Jun 2006 14:35:25 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Jeremy Fitzhardinge" <jeremy@goop.org>
Subject: Re: [PATCH 2.6.17-rc6 7/9] Remove some of the kmemleak false positives
Cc: "Ingo Molnar" <mingo@elte.hu>, "Pekka J Enberg" <penberg@cs.helsinki.fi>,
       linux-kernel@vger.kernel.org
In-Reply-To: <448FA476.8000705@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060611112156.8641.94787.stgit@localhost.localdomain>
	 <Pine.LNX.4.58.0606121111440.7129@sbz-30.cs.Helsinki.FI>
	 <20060612105345.GA8418@elte.hu>
	 <b0943d9e0606120556h185f2079x6d5a893ed3c5cd0f@mail.gmail.com>
	 <20060612192227.GA5497@elte.hu>
	 <Pine.LNX.4.58.0606130850430.15861@sbz-30.cs.Helsinki.FI>
	 <20060613072646.GA17978@elte.hu>
	 <b0943d9e0606130349s24614bbcia6a650342437d3d1@mail.gmail.com>
	 <20060614040707.GA7503@elte.hu> <448FA476.8000705@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeremy,

It's good to hear some experience from the Valgrind world :-)

On 14/06/06, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> Ingo Molnar wrote:
> > But it's not just about the amount of false negatives, but also about
> > the overhead of scanning. You are concentrated on embedded systems with
> > small RAM - but most of the testers will be running this with at last
> > 1GB of RAM - which is _alot_ of memory to scan.
> >
> It seems to me that most types with any pointers are fairly
> pointer-dense.

There seem to be many structures containing mostly data and only one
or two list_head structures with pointers. Here only the list_head
member would need to be scanned.

> False pointers in kernel allocations can be avoided in a few ways.  The
> first, obviously, is the make sure all memory is initialized to a known
> non-pointer value.

This is done already by the DEBUG_SLAB configuration.

> The second is to ignore pointers which don't point
> near the start of an allocated region (possibly unsafe in the kernel,
> depending on the definition of "near").

Kmemleak only accepts values that point to either the beginning of the
allocated block or to one of its aliases (a offset from the beginning
which is determined from the container_of() usages on that
structure/member - most of the list usages). There is a discussion one
whether to allow a value to point anywhere inside a block but I would
need to investigate the risks.

> You can get more sophisticated
> from there; the Boehm GC keeps tracks of things which look like pointers
> but turn out not to be (they don't point to allocated memory); it marks
> that memory as being unusable, so that the false pointer won't get
> mistaken for one later on, with the obvious risk that lots of false
> pointers can render large parts of your heap address space unusable.

This would increase the overhead as in my tests around 15% of all the
values scanned look like pointers (i.e. between PAGE_OFFSET and
PAGE_OFFSET + ram_size).

> There's some risk of false positives.  You can imagine cases where the
> last reference to a block is transformed into a bus address, and in
> effect a piece of hardware holds it.  You don't get to know about the
> pointer until the hardware gives it back.

This is pretty rare and you can easily tell kmemleak to ignore it.

-- 
Catalin
