Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316705AbSIIJQL>; Mon, 9 Sep 2002 05:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316788AbSIIJQK>; Mon, 9 Sep 2002 05:16:10 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:29944 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S316705AbSIIJQK>; Mon, 9 Sep 2002 05:16:10 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Subject: [RFC] On paging of kernel VM.
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Date: Mon, 09 Sep 2002 10:20:53 +0100
Message-ID: <2653.1031563253@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I'd like to introduce 'real' VMAs into kernel space, so that areas
in the vmalloc range can have 'real' vm_ops and more to the point a real
nopage function.

Unfortunately AFAICT this would involve changing the fault handler on every 
platform, so I'm debating whether it's really worth it -- if anyone else 
could use it and if I could get round my problem any other way.

The problem is flash chips. These basically behave as ROM, but you write to 
them by writing magic values to magic addresses, and during a write 
operation the _whole_ chip returns status bits instead of data.

To avoid taking up precious RAM with copies of data which are already in 
flash, we can map pages of flash directly into userspace. On taking a 
fault, we wait for any pending write to complete, mark the chip as busy, 
then set up the page tables appropriately so that userspace can read from 
it. On starting a write operation, you invalidate all currently-visible 
pages before starting to talk to the chip.

There are cases in the kernel where we'd really like the same setup --
mounting a JFFS2 file system, for example, is a slow operation because it's
entirely log-structured and we have to read every log entry on the file
system. The current method of reading into a RAM buffer under a lock and
then dealing with stuff in RAM is entirely suboptimal, and proof-of-concept
hacks to just use a pointer into the flash chip have been observed to
improve mount time by about a factor of 4.

The locking is a problem though. Flash chips may be divided into multiple
partitions and other code may want to write to its partition while a mount
is in progress. The naïve approach of just locking the chip into read mode
on giving out a pointer to it, and unlocking it when the mount is complete,
is going to suck royally. Hence, it would be very nice if we could play the
same trick as we do for userspace; giving out a pointer which is always
going to be valid; you just might have to wait for it. 

But as I said, this means screwing with every fault handler. It doesn't 
have to affect the fast path -- we can go looking for these vmas only in 
the case where we've already tried looking for the appropriate pte in 
init_mm and haven't found it. But it's still an intrusive change that would 
need to be done on every architecture.

I'm wondering what else could use this if it were implemented. Is there any
need for something like vmalloc_pageable(), for example? Anything else?
Rusty and I have wittered about marking certain kernel functions and data as
__pageable to go into a special such section too, but I'm wondering if that
conversation was slightly Guinness-influenced :)

Or is there another way to solve my original problem that I've overlooked?

Answers on a postcard to...

--
dwmw2


