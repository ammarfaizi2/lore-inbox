Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030416AbWHADEv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030416AbWHADEv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 23:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030418AbWHADEv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 23:04:51 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:26633 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1030416AbWHADEu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 23:04:50 -0400
Date: Tue, 1 Aug 2006 13:04:43 +1000
To: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [BLOCK] bh: Ensure bh fits within a page
Message-ID: <20060801030443.GA2221@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew:

[BLOCK] bh: Ensure bh fits within a page

There is a bug in jbd with slab debugging enabled where it was submitting
a bh obtained via jbd_rep_kmalloc which crossed a page boundary.  A lot
of time was spent on tracking this down because the symptoms were far off
from where the problem was.

This patch adds a sanity check to submit_bh so we can immediately spot
anyone doing similar things in future.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

While you're at it, could you fix that jbd bug for us :)

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/fs/buffer.c b/fs/buffer.c
index 71649ef..b998f08 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2790,6 +2790,7 @@ int submit_bh(int rw, struct buffer_head
 	BUG_ON(!buffer_locked(bh));
 	BUG_ON(!buffer_mapped(bh));
 	BUG_ON(!bh->b_end_io);
+	WARN_ON(bh_offset(bh) + bh->b_size > PAGE_SIZE);
 
 	if (buffer_ordered(bh) && (rw == WRITE))
 		rw = WRITE_BARRIER;
