Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131363AbRAABg4>; Sun, 31 Dec 2000 20:36:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131365AbRAABgq>; Sun, 31 Dec 2000 20:36:46 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:19986 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S131363AbRAABge>; Sun, 31 Dec 2000 20:36:34 -0500
Date: Mon, 1 Jan 2001 02:06:05 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: Kostas Nikoloudakis <kostas@corp124.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: system call fails with ENOMEM after long operation
In-Reply-To: <3A4FBD2F.D80A7716@corp124.com>
Message-ID: <Pine.LNX.3.96.1010101015330.22558B-100000@artax.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So why is the kernel having difficulty allocating memory for its
> internal operations? We are suspecting memory fragmentation issues 
> (at the application level which might have adverse sideefects for the
> kernel). Is it something that we can do so that the kernel will be
> able to allocate the needed memory for carrying out the system call?

Try this patch.

Mikulas

--- linux/mm/page_alloc.c__	Thu Mar  9 15:12:31 2000
+++ linux/mm/page_alloc.c	Tue Mar 21 09:50:12 2000
@@ -237,6 +237,15 @@
 	RMQUEUE_TYPE(order, 1);
 	spin_unlock_irqrestore(&page_alloc_lock, flags);
 
+	if (!(current->flags & PF_MEMALLOC) && (gfp_mask & __GFP_WAIT)) {
+		int freed;
+		current->trashing_mem = 1;
+		current->flags |= PF_MEMALLOC;
+		freed = try_to_free_pages(gfp_mask);
+		current->flags &= ~PF_MEMALLOC;
+		if (freed) goto ok_to_allocate;
+	}
+
 nopage:
 	return 0;
 }


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
