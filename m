Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129257AbQLWJtD>; Sat, 23 Dec 2000 04:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129289AbQLWJsy>; Sat, 23 Dec 2000 04:48:54 -0500
Received: from slc209.modem.xmission.com ([166.70.9.209]:15620 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S129257AbQLWJsh>; Sat, 23 Dec 2000 04:48:37 -0500
To: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        middelink@polyware.nl (Pauline Middelink),
        linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: bigphysarea support in 2.2.19 and 2.4.0 kernels
In-Reply-To: <200012222311.eBMNBgr459298@saturn.cs.uml.edu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Dec 2000 01:40:43 -0700
In-Reply-To: "Albert D. Cahalan"'s message of "Fri, 22 Dec 2000 18:11:42 -0500 (EST)"
Message-ID: <m1g0jfr0ms.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Albert D. Cahalan" <acahalan@cs.uml.edu> writes:

> > bigmem is 'last resort' stuff. I'd much rather it is as now a
> > seperate allocator so you actually have to sit and think and
> > decide to give up on kmalloc/vmalloc/better algorithms and
> > only use it when the hardware sucks
> 
> It isn't just for sucky hardware. It is for performance too.
 
> 1. Linux isn't known for cache coloring ability. 
Most hardware doesn't need it.  It might help a little
but not much.
>    Even if it was,
>    users want to take advantage of large pages or BAT registers
>    to reduce TLB miss costs. (that is, mapping such areas into
>    a process is needed... never mind security for now)

I think the minor cost incurred by uniform size is well made up
for by reliable memory management, and avoidance of swapping, and
needing less total ram.  Besides the fact I don't see large
physical areas of memory being more than a marginal performance gain.

> 2. Programming a DMA controller with multiple addresses isn't
>    as fast as programming it with one.

Garbage collecting is theoretically more efficient than explicit
memory management too.  But seriously I doubt that several pages
have significantly more overhead than a giant burst, per transfer.
 
> Consider what happens when you have the ability to make one
> compute node DMA directly into the physical memory of another.
> With a large block of physical memory, you only need to have
> the destination node give the writer a single physical memory
> address to send the data to. With loose pages, the destination
> has to transmit a great big list. That might be 30 thousand!

Hmm, queuing up enough data for a second at a time seems a little
excessive.  And with a 128M chunk...  your system can't do good
memory management at all.

> The point of all this is to crunch data as fast as possible,
> with Linux mostly getting out of the way. Perhaps you want
> to generate real-time high-resolution video of a human heart
> as it beats inside somebody. You process raw data (audio, X-ray,
> magnetic resonance, or whatever) on one group of processors,
> then hand off the data to another group of processors for the
> rendering task. Actually there might be many stages. Playing
> games with individual pages will cut into your performance.

If you are doing a real time task you don't want to very close
to your performance envelope.  If you are hitting the performance
envelope any small hiccup will cause you to miss your deadline,
and close to your performance envelope hiccups are virtually certain.

Pushing the machine just 5% slower should get everything going
with multiple pages, and you wouldn't be pushing the performance
envelope so your machine can compensate for the occasional hiccup.

> The data stream is fat and relentless.

So you add another node if your current nodes can't handle the load
without using giant physical areas of memory.  Attempt to redesign
the operating system.  Much more cost effective.

Eric

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
