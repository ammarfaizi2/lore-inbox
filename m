Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318044AbSG2GrZ>; Mon, 29 Jul 2002 02:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318047AbSG2GrZ>; Mon, 29 Jul 2002 02:47:25 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29452 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318044AbSG2GrY>;
	Mon, 29 Jul 2002 02:47:24 -0400
Message-ID: <3D44E7C9.1302DF56@zip.com.au>
Date: Sun, 28 Jul 2002 23:59:21 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch 2/13] remove pages from the LRU in __free_pages_ok()
References: <20020728.231017.40779367.davem@redhat.com> <Pine.LNX.4.44.0207282324340.872-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Sun, 28 Jul 2002, David S. Miller wrote:
> >
> > So when the user's reference is dropped, does that operation kill it
> > from the LRU or will the socket's remaining reference to that page
> > defer the LRU removal?
> 
> That is indeed the question. Right now it will defer, which looks like a
> bug. Or at least it is a bug without the interrupt-safe LRU manipulations.
> 
> I'm starting to be more convinced about Andrew's alternate patch, the
> "move LRU lock innermost and make it irq-safe".
> 
> Which also would make it saner to do the LRU handling inside
> __put_pages_ok() (and actually remove the BUG_ON(in_interrupt()) that
> Andrew had there in the old patch).
> 

That was a big lump of patch, and I need to get all the other
MM developers to say "yes, we can live with this".  Everything which
takes the LRU lock needed to be redone to get the holdtimes and
acquisition frequency down.

It's quite unfeasible for 2.4.   The only 2.4 kernel which
has the in_interrupt() check is Andrea's.  And, I assume,
the SuSE production kernel.  So empirically, we're probably OK there.
But the RH kernel has AIO (yes?) which may change the picture.

A simple little hack which would prevent it in 2.4 would be,
in __free_pages_ok():

	if (PageLRU(page)) {
		if (in_interrupt()) {
			SetPageFoo(page);
			return;
		}
		lru_cache_del(page);
	}

and in shrink_cache(), inside pagemap_lru_lock:

	if (PageFoo(page)) {
		__lru_cache_del(page);
		BUG_ON(page_count(page) != 0);
		page_cache_get(page);
		__free_page(page);
		continue;
	}

This is basically Dave's "defer it to process context", with kswapd
doing the work.
		
-
