Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268045AbRG2PeO>; Sun, 29 Jul 2001 11:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268047AbRG2PeE>; Sun, 29 Jul 2001 11:34:04 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:38156 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268045AbRG2Pd5>; Sun, 29 Jul 2001 11:33:57 -0400
Date: Sun, 29 Jul 2001 08:30:19 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Hugh Dickins <hugh@veritas.com>
cc: Ingo Molnar <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hold cow while breaking
In-Reply-To: <Pine.LNX.4.21.0107291404410.897-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0107290827430.7119-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On Sun, 29 Jul 2001, Hugh Dickins wrote:
>
> do_wp_page() COW breaking is now very slightly unsafe.  Please don't
> ask me to provide a test case! but the pte_same() check after regetting
> page_table_lock is not quite enough to guarantee that the old_page was
> not reaped, reused for something else, copy_cow_paged while containing
> that other data, freed and then reused for precisely its original pte.

Oh, but it is.

We do hold the MM semaphore over the whole sequence, so there's no way the
page table entry can be replaced by anything else than a non-present one
(ie vmscan can swap it out, but nothing can swap it in because of the
lock).

So yes, we may copy data that is "garbage", but re-testing the page table
will make sure that if it was garbage we will never use it.

		Linus

