Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271487AbRHPFxY>; Thu, 16 Aug 2001 01:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271485AbRHPFxO>; Thu, 16 Aug 2001 01:53:14 -0400
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:8718 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S271486AbRHPFxG>;
	Thu, 16 Aug 2001 01:53:06 -0400
From: tpepper@vato.org
Date: Wed, 15 Aug 2001 22:46:04 -0700
To: linux-kernel@vger.kernel.org
Subject: create_bounce() in ll_rw_blk.c
Message-ID: <20010815224604.A3396@cb.vato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In ll_rw_blk.c's __make_request() there is a call to create_bounce() if
CONFIG_HIGHMEM is set.  The commentary in that file indicates that this is a
temporary fix until 2.5 at which point this would be removed in favour of
individual drivers handling this on their own.  I've been trying to figure out
if a driver I'm working on needs to make this call.  That got me wondering...

Is there a reason for pushing this down onto the individual driver writer
instead of placing it once and for all in the ll_rw_block() function like:

--- linux-2.4.8/drivers/block/ll_rw_blk.c.orig	Wed Aug 15 22:15:55 2001
+++ linux-2.4.8/drivers/block/ll_rw_blk.c	Wed Aug 15 22:39:55 2001
@@ -1000,6 +1000,10 @@
 	/* Verify requested block sizes. */
 	for (i = 0; i < nr; i++) {
 		struct buffer_head *bh = bhs[i];
+#if CONFIG_HIGHMEM
+		bh = create_bounce(rw, bh);
+		bhs[i] = &bh;
+#endif
 		if (bh->b_size % correct_size) {
 			printk(KERN_NOTICE "ll_rw_block: device %s: "
 			       "only %d-char blocks implemented (%u)\n",

Since the commentary says the driver writer taking HIGHMEM into
account could call either create_bounce() or bh_kmap() and the latter
deals with bh->b_data, is this something you need to do only if you're
accessing bh->b_data?  In that case putting the work on the driver writer
allows for it to only be done when needed, but are there cases were a
buffer_head would pass down out of ll_rw_block() towards a driver that's
not ultimately going to read or write the b_data member?

I don't know how all the HIGHMEM/PAE stuff actually works, but I'm
guessing that if the heavy handed create_bounce() exists that is because
simply doing a bh_kmap() and replacing the bh->b_data at ll_rw_block()
time doesn't result in a memory address that would work in the drivers'
context?  So to get the efficiency of bh_kmap() over create_bounce()
you'd have to put the calls in all the drivers?

And since create_bounce() stores the original bh in bh->b_private is this
all magically undone then as nested bh->b_end_io's and bh->b_private's
unfold themselves with either of bounce_end_io_read() or _write() being
called somewhere in there?

Anybody care to comment?

t.

--
*********************************************************
*  tpepper@vato dot org             * Venimus, Vidimus, *
*  http://www.vato.org/~tpepper     * Dolavimus         *
*********************************************************
