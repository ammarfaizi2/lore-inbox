Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266236AbUHBDT6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266236AbUHBDT6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 23:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266237AbUHBDT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 23:19:57 -0400
Received: from digitalimplant.org ([64.62.235.95]:58325 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S266236AbUHBDTy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 23:19:54 -0400
Date: Sun, 1 Aug 2004 20:19:44 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: Pavel Machek <pavel@ucw.cz>
cc: linux-kernel@vger.kernel.org
Subject: Re: [6/25] Merge pmdisk and swsusp
In-Reply-To: <20040718220954.GB31958@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.50.0408012018370.30101-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0407171528280.22290-100000@monsoon.he.net>
 <20040718220954.GB31958@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry about the delay; all the conferences are finally over (for now)

On Mon, 19 Jul 2004, Pavel Machek wrote:

> Hi!
>
> > +static void calc_order(void)
> > +{
> > +	int diff;
> > +	int order;
> > +
> > +	order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
> > +	nr_copy_pages += 1 << order;
> > +	do {
> > +		diff = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages)) - order;
> > +		if (diff) {
> > +			order += diff;
> > +			nr_copy_pages += 1 << diff;
> > +		}
> > +	} while(diff);
> > +	pagedir_order = order;
> > +}
>
> This code is "interesting". Perhaps at least comment would be good
> here?

Sure, patch below.



	Pat

diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-08-01 20:18:35 -07:00
+++ b/kernel/power/swsusp.c	2004-08-01 20:18:35 -07:00
@@ -659,13 +659,38 @@
 }


+/**
+ *	calc_order - Determine the order of allocation needed for pagedir_save.
+ *
+ *	This looks tricky, but is just subtle. Please fix it some time.
+ *	Since there are %nr_copy_pages worth of pages in the snapshot, we need
+ *	to allocate enough contiguous space to hold
+ *		(%nr_copy_pages * sizeof(struct pbe)),
+ *	which has the saved/orig locations of the page..
+ *
+ *	SUSPEND_PD_PAGES() tells us how many pages we need to hold those
+ *	structures, then we call get_bitmask_order(), which will tell us the
+ *	last bit set in the number, starting with 1. (If we need 30 pages, that
+ *	is 0x0000001e in hex. The last bit is the 5th, which is the order we
+ *	would use to allocate 32 contiguous pages).
+ *
+ *	Since we also need to save those pages, we add the number of pages that
+ *	we need to nr_copy_pages, and in case of an overflow, do the
+ *	calculation again to update the number of pages needed.
+ *
+ *	With this model, we will tend to waste a lot of memory if we just cross
+ *	an order boundary. Plus, the higher the order of allocation that we try
+ *	to do, the more likely we are to fail in a low-memory situtation
+ *	(though	we're unlikely to get this far in such a case, since swsusp
+ *	requires half of memory to be free anyway).
+ */
+
+
 static void calc_order(void)
 {
-	int diff;
-	int order;
+	int diff = 0;
+	int order = 0;

-	order = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages));
-	nr_copy_pages += 1 << order;
 	do {
 		diff = get_bitmask_order(SUSPEND_PD_PAGES(nr_copy_pages)) - order;
 		if (diff) {
@@ -687,7 +712,7 @@
 static int alloc_pagedir(void)
 {
 	calc_order();
-	pagedir_save = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD,
+	pagedir_save = (suspend_pagedir_t *)__get_free_pages(GFP_ATOMIC | __GFP_COLD,
 							     pagedir_order);
 	if(!pagedir_save)
 		return -ENOMEM;
