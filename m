Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277319AbRJJROS>; Wed, 10 Oct 2001 13:14:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277325AbRJJROF>; Wed, 10 Oct 2001 13:14:05 -0400
Received: from chaos.analogic.com ([204.178.40.224]:19329 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S277319AbRJJRNx>; Wed, 10 Oct 2001 13:13:53 -0400
Date: Wed, 10 Oct 2001 13:14:10 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: "'adilger@turbolabs.com'" <adilger@turbolabs.com>
cc: Venkatesh Ramamurthy <Venkateshr@ami.com>,
        "'xuan--lkml@baldauf.org'" <xuan--lkml@baldauf.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: dynamic swap prioritizing
In-Reply-To: <20011010095536.C10443@turbolinux.com>
Message-ID: <Pine.LNX.3.95.1011010124847.14802A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think that when the kernel needs a page of memory, it needs it
NOW! Swapping a dirty page to other in-memory pages wastes the
very page(s) that you need.

The contents of a least-recently used page should be written to
the swap device to free it for immediate use, regardless of the
disk-write speed, and regardless of how close the kernel thinks
the heads are to some track. Other stuff, like "prioritizing"
wastes resources you are trying to obtain. Further, all attempts
so-far, to use "elevator" algorithms to speed disk access fails
to provide any measurable improvements in anything. In fact,
buffering until the data will fit on a nearby track wastes
memory pages and the CPU resources necessary to manage them.

In the days when CPUs were slow, memory was scarce, and I/O
was at a crawl, Digital made a VMS system that worked. Using
the same kind of memory handling should be suburb now-days.

(1)	You keep a page of zeroed data. This is used by
all processes for new buffers. A single page handles all.
Reads are always allowed. Writes cause a page-fault. This
is called demand-zero paging.

(2)	Pages used for shared file mapping are kept in real
memory as long as possible (run-time libraries). 

(3)	All other pages are available for swapping. The page-
stealer grabs the least-recently used pages from sleeping
processes first. Tasks that are waiting for I/O are the
next to have their least-recently used pages stolen. Tasks
that are waiting for kernel services are the last to have
their least-recently used pages swiped.

The Linux kernel is not a task, so "waiting for kernel services"
is not valid here. Everything else is.

Not every machine runs with gigahertz processors where CPU
overhead of keeping track of pages is in the noise.

Additionally, prioritizing based upon some "goodness" puts policy in the
kernel.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


