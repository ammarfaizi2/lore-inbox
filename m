Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266161AbRGHTbM>; Sun, 8 Jul 2001 15:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266442AbRGHTbC>; Sun, 8 Jul 2001 15:31:02 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:12041 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266161AbRGHTax>; Sun, 8 Jul 2001 15:30:53 -0400
Date: Sun, 8 Jul 2001 12:30:02 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Mike Galbraith <mikeg@wen-online.de>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VM in 2.4.7-pre hurts...
In-Reply-To: <Pine.LNX.4.33L.0107081521510.4598-100000@imladris.rielhome.conectiva>
Message-ID: <Pine.LNX.4.33.0107081227020.7044-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 8 Jul 2001, Rik van Riel wrote:
>
> If __wait_on_buffer and ___wait_on_page get stuck, this could
> mean a page doesn't get unlocked.  When this is happening, we
> may well be running into a dozens of pages which aren't getting
> properly unlocked on IO completion.

Absolutely. But that, in turn, should cause just others getting stuck, not
running, no?

Anyway, having looked at the buffer case, I htink I found a potentially
nasty bug: "unlock_buffer()" with a buffer cout of zero.

Why is this nasty? unlock_buffer() does:

	extern inline void unlock_buffer(struct buffer_head *bh)
	{
	        clear_bit(BH_Lock, &bh->b_state);
	        smp_mb__after_clear_bit();
	        if (waitqueue_active(&bh->b_wait))
	                wake_up(&bh->b_wait);
	}

but by doing the "clear_bit()", it also potentially free's the buffer, so
an interrupt coming in (or another CPU) can end up doing a kfree() on the
bh.

At which point the "waitqueue_active()" and the wakeup call are operating
on random memory.

This does not explain __wait_on_buffer(), but it's a bug none-the-less.

Anybody can find anything else fishy with buffer handling?

		Linus

