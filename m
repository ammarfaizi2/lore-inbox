Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318976AbSHMRjV>; Tue, 13 Aug 2002 13:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318968AbSHMRib>; Tue, 13 Aug 2002 13:38:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33035 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318975AbSHMRh4>; Tue, 13 Aug 2002 13:37:56 -0400
Date: Tue, 13 Aug 2002 10:44:05 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 7/21] batched freeing of anonymous pages
In-Reply-To: <3D56148E.D06B13F2@zip.com.au>
Message-ID: <Pine.LNX.4.44.0208131041100.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Aug 2002, Andrew Morton wrote:
> 
> The VMA teardown code is currently removing pages from the LRU
> one-at-a-time.  And it is freeing those pages one-at-a-time.

This patch is wrong.

We already _have_ the pagevec for page table teardown, and by making it a 
per-CPU static structure instead of allocating it on the stack it can be 
made (and is) quite a lot bigger than a pvec.

If you want batching here, then the right approach is to just remove the
"fast" code entirely, and batch it properly at the TLB struct level (since
we _have_ to batch it there anyway, to fix the the thread unmapping TLB
race condition)

This is what "tlbgather" is all about.

		Linus

