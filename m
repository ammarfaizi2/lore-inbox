Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129618AbRBXVhn>; Sat, 24 Feb 2001 16:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129620AbRBXVhd>; Sat, 24 Feb 2001 16:37:33 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:9229 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129618AbRBXVhQ>; Sat, 24 Feb 2001 16:37:16 -0500
Date: Sat, 24 Feb 2001 17:50:51 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: refill_freelist() and page_launder()
Message-ID: <Pine.LNX.4.21.0102241655520.3804-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, 

refill_freelist() (fs/buffer.c) calls page_launder(GFP_BUFFER) after
syncing some of the oldest dirty buffers.

As fair as I can see, that used to make sense because clean pages could be
freed with page_launder(GFP_BUFFER) -- this could avoid a potential sleep
on kswapd when trying to allocate a buffer page with grow_buffers().

But now __alloc_pages will not wait kswapd anymore. 

Instead the running thread will free clean pages only when it has to call
page_launder() itself because kswapd could not keep up.

Could you remove the call to page_launder() and the if() on top on your
tree ? 

Come one, doing by hand its easier than a patch.

Here's the function:

/*
 * We used to try various strange things. Let's not.
 * We'll just try to balance dirty buffers, and possibly
 * launder some pages.
 */
static void refill_freelist(int size)
{
        balance_dirty(NODEV);
        if (free_shortage())
                page_launder(GFP_BUFFER, 0);
        grow_buffers(size);
}

grow_buffers() calls alloc_page(GFP_BUFFER).

