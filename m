Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129391AbQLRW26>; Mon, 18 Dec 2000 17:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130559AbQLRW2s>; Mon, 18 Dec 2000 17:28:48 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:38671 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129391AbQLRW2b>; Mon, 18 Dec 2000 17:28:31 -0500
Date: Mon, 18 Dec 2000 22:57:44 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Rik van Riel <riel@conectiva.com.br>
cc: Andrea Arcangeli <andrea@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Pavel Machek <pavel@suse.cz>, Chris Lattner <sabre@nondot.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ANNOUNCE: Linux Kernel ORB: kORBit
In-Reply-To: <Pine.LNX.4.21.0012181847360.2595-100000@duckman.distro.conectiva>
Message-ID: <Pine.LNX.3.96.1001218224636.1190D-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2000, Rik van Riel wrote:

> On Mon, 18 Dec 2000, Andrea Arcangeli wrote:
> > On Mon, Dec 18, 2000 at 06:29:24PM -0200, Rik van Riel wrote:
> > > Wrong. Getblk won't deadlock, it will just sleep and another
> > 
> > getblk will deadlock.
> 
> OUCH. The only protection we have against this is the fact
> that atomic allocations are not allowed to eat up all memory
> in the system and that every thread can only have 1 getblk
> operation at a time, right?

You have small posibility that interrupt will eat up memory - interrupt in
process that has PF_MEMALLOC. Patch: 

--- linux/mm/page_alloc.c_	Mon Dec 18 22:48:47 2000
+++ linux/mm/page_alloc.c	Mon Dec 18 22:53:52 2000
@@ -516,7 +516,7 @@
 
 		/* XXX: is pages_min/4 a good amount to reserve for this? */
 		if (z->free_pages < z->pages_min / 4 &&
-				!(current->flags & PF_MEMALLOC))
+				(!(current->flags & PF_MEMALLOC) || in_interrupt()))
 			continue;
 		page = rmqueue(z, order);
 		if (page)

Mikulas

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
