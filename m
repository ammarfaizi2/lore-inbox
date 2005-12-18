Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965214AbVLRSis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965214AbVLRSis (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 13:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932707AbVLRSis
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 13:38:48 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:61847 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932704AbVLRSis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 13:38:48 -0500
Subject: Re: [PATCH] micro optimization of cache_estimate in slab.c
From: Steven Rostedt <rostedt@goodmis.org>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Luuk van der Duim <luukvanderduim@gmail.com>,
       LKML <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <84144f020512180927lc6492abpb28c047f9e0c535c@mail.gmail.com>
References: <1134894189.13138.208.camel@localhost.localdomain>
	 <84144f020512180927lc6492abpb28c047f9e0c535c@mail.gmail.com>
Content-Type: text/plain
Date: Sun, 18 Dec 2005 13:37:42 -0500
Message-Id: <1134931062.13138.214.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-12-18 at 19:27 +0200, Pekka Enberg wrote:
> Hi Steven,
> 
> On 12/18/05, Steven Rostedt <rostedt@goodmis.org> wrote:
> > +       do {
> > +               x = 1;
> > +               while ((x+i)*size + ALIGN(base+(x+i)*extra, align) <= wastage)
> > +                       x <<= 1;
> > +               i += (x >> 1);
> > +       } while (x > 1);
> 
> The above is pretty hard to read. Perhaps we could give x and i better
> names? Also, couldn't we move left part of the expression into a
> separate static inline function for readability?

Actually, Luuk sent me this patch made by Balbir Singh that was done a
while ago.

                extra = sizeof(kmem_bufctl_t);
        }
-       i = 0;
+       i = (wastage - base)/(size + extra);
        while (i*size + L1_CACHE_ALIGN(base+i*extra) <= wastage)
                i++;

-       if (i > 0)
+       while (i*size + L1_CACHE_ALIGN(base+i*extra) > wastage)
                i--;


This actually has a O(1) with a K=2.  Analyzing this further, I've come
up with the below patch.  This patch removes the need for the second
while, and adds a comment to why. The size is already calculated to be
no smaller than the alignment. So that the division will not return
something greater than 1 of what is needed.  So the if (i > 0) after the
while is all that is needed.  So this patch is O(1) K=1.

-- Steve

Index: linux-2.6.15-rc5/mm/slab.c
===================================================================
--- linux-2.6.15-rc5.orig/mm/slab.c	2005-12-16 16:24:09.000000000 -0500
+++ linux-2.6.15-rc5/mm/slab.c	2005-12-18 13:30:13.000000000 -0500
@@ -708,7 +708,14 @@
 		base = sizeof(struct slab);
 		extra = sizeof(kmem_bufctl_t);
 	}
-	i = 0;
+	/*
+	 * Divide the amount we have, by the amount we need for
+	 * each object.  Since the size is already calculated
+	 * to be no less than the alignment, this result will
+	 * not be any greater than 1 that we need, and this will
+	 * be subtracted after the while loop.
+	 */
+	i = (wastage - base)/(size + extra);
 	while (i*size + ALIGN(base+i*extra, align) <= wastage)
 		i++;
 	if (i > 0)


