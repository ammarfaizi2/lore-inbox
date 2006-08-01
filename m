Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbWHAXbF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbWHAXbF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:31:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750721AbWHAXbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:31:05 -0400
Received: from rhun.apana.org.au ([64.62.148.172]:17425 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S1750709AbWHAXbE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:31:04 -0400
From: Herbert Xu <herbert@gondor.apana.org.au>
To: axboe@suse.de (Jens Axboe)
Subject: Re: [BLOCK] bh: Ensure bh fits within a page
Cc: herbert@gondor.apana.org.au, akpm@osdl.org, linux-kernel@vger.kernel.org
Organization: Core
In-Reply-To: <20060801072315.GH31908@suse.de>
X-Newsgroups: apana.lists.os.linux.kernel
User-Agent: tin/1.7.4-20040225 ("Benbecula") (UNIX) (Linux/2.6.17-rc4 (i686))
Message-Id: <E1G83hL-00035h-00@gondolin.me.apana.org.au>
Date: Wed, 02 Aug 2006 09:30:51 +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> wrote:
>
> That looks really dangerous, I'd prefer that to be a BUG_ON() as well to
> prevent nastiness further down.

OK, I used a WARN_ON mainly because ext3 has been doing this for years
without killing anyone until now :)

[BLOCK] bh: Ensure bh fits within a page

There is a bug in jbd with slab debugging enabled where it was submitting
a bh obtained via jbd_rep_kmalloc which crossed a page boundary.  A lot
of time was spent on tracking this down because the symptoms were far off
from where the problem was.

This patch adds a sanity check to submit_bh so we can immediately spot
anyone doing similar things in future.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
--
diff --git a/fs/buffer.c b/fs/buffer.c
index 71649ef..ff34881 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2790,6 +2790,7 @@ int submit_bh(int rw, struct buffer_head
 	BUG_ON(!buffer_locked(bh));
 	BUG_ON(!buffer_mapped(bh));
 	BUG_ON(!bh->b_end_io);
+	BUG_ON(bh_offset(bh) + bh->b_size > PAGE_SIZE);
 
 	if (buffer_ordered(bh) && (rw == WRITE))
 		rw = WRITE_BARRIER;
