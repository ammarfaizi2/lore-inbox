Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbVKXNbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbVKXNbs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 08:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbVKXNbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 08:31:48 -0500
Received: from matrix.drigon.com ([205.177.72.21]:50398 "EHLO
	matrix.drigon.com") by vger.kernel.org with ESMTP id S1750908AbVKXNbr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 08:31:47 -0500
Date: Thu, 24 Nov 2005 05:30:29 -0800
From: Chris Humbert <mahadri-kernel@drigon.com>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@trained-monkey.org>
Subject: [PATCH] fix broken lib/genalloc.c
Message-ID: <20051124133029.GA21470@matrix.drigon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: Mutt http://www.mutt.org/
X-Uptime: 27 days
X-Accept-Language: en, ja
X-Editor: Vim 6.2 http://www.vim.org/
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

genalloc improperly stores the size of freed chunks, allocates
overlapping memory regions, and oopses after its in-band data is
overwritten.  Jes Sorensen's original patch to LKML used:

> +	s = (1 << ALLOC_MIN_SHIFT);
> +	while (size > s) {
> +		s <<= 1;
> +		i++;
> +	}

After Andrew Morton suggested roundup_pow_of_two(), Jes changed
it to:

> +	size = max(size, 1 << ALLOC_MIN_SHIFT);
> +	s = roundup_pow_of_two(size);

but this does not set 'i'.  I have verified that genalloc with
the attached patch works correctly.

Chris Humbert



[PATCH] fix broken lib/genalloc.c

genalloc improperly stores the sizes of freed chunks, allocates
overlapping memory regions, and oopses after its in-band data is
overwritten.

Signed-off-by: Chris Humbert <mahadri-kernel@drigon.com>

diff --git a/lib/genalloc.c b/lib/genalloc.c
--- a/lib/genalloc.c
+++ b/lib/genalloc.c
@@ -95,12 +95,10 @@ unsigned long gen_pool_alloc(struct gen_
 	if (size > max_chunk_size)
 		return 0;
 
-	i = 0;
-
 	size = max(size, 1 << ALLOC_MIN_SHIFT);
-	s = roundup_pow_of_two(size);
-
-	j = i;
+	i = fls(size - 1);
+	s = 1 << i;
+	j = i -= ALLOC_MIN_SHIFT;
 
 	spin_lock_irqsave(&poolp->lock, flags);
 	while (!h[j].next) {
@@ -153,10 +151,10 @@ void gen_pool_free(struct gen_pool *pool
 	if (size > max_chunk_size)
 		return;
 
-	i = 0;
-
 	size = max(size, 1 << ALLOC_MIN_SHIFT);
-	s = roundup_pow_of_two(size);
+	i = fls(size - 1);
+	s = 1 << i;
+	i -= ALLOC_MIN_SHIFT;
 
 	a = ptr;
 
