Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271614AbRHPSku>; Thu, 16 Aug 2001 14:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271610AbRHPSkk>; Thu, 16 Aug 2001 14:40:40 -0400
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:29592 "EHLO
	alloc.wat.veritas.com") by vger.kernel.org with ESMTP
	id <S271615AbRHPSkg>; Thu, 16 Aug 2001 14:40:36 -0400
Date: Thu, 16 Aug 2001 19:44:04 +0100 (BST)
From: Mark Hemment <markhe@veritas.com>
X-X-Sender: <markhe@alloc.wat.veritas.com>
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Align VM locks
In-Reply-To: <20010816202606.B8726@athlon.random>
Message-ID: <Pine.LNX.4.33.0108161933240.3340-100000@alloc.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Aug 2001, Andrea Arcangeli wrote:
> BTW, for your other patch you sent a few hours ago you forgot to drop
> the KMAP entry that is wasting NR_CPUS*PAGE_SIZE of virtual address
> space:
>
> 	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.8aa1/00_create_bounces-sleeps-1

  Eh, no I didn't.

  At least on the work load I'm interest in, SpecFS v2.0 over NFSv3,
removing the KM_BOUNCE_WRITE results in a performance drop (confirmed
today).

  It is often the case that when it comes time to write a page out it has
lost any mapping it had when it was made dirty via a write(), so there is
no side benefit of using a straight kmap().

  By having KM_BOUNCE_WRITE we don't run through the "normal" mapping
space on I/O.  Not having KM_BOUNCE_WRITE causing extra shootdowns, which
_are_ expensive, as the code needs to busy-wait for all the other engines
(while the kmap_lock held - and on a 4-way there is a good chance one of
the processors is running with interrupts disabled).
  KM_BOUNCE_WRITE may waste virtual address-space, but it saves on
expensive shootdowns.

Mark

