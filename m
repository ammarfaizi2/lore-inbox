Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264962AbUFTRQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264962AbUFTRQq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 13:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264979AbUFTRQq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 13:16:46 -0400
Received: from witte.sonytel.be ([80.88.33.193]:64923 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S264962AbUFTRQo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 13:16:44 -0400
Date: Sun, 20 Jun 2004 19:16:40 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.27-rc1
In-Reply-To: <20040620004520.GA4599@logos.cnet>
Message-ID: <Pine.GSO.4.58.0406201910300.23356@waterleaf.sonytel.be>
References: <20040620004520.GA4599@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004, Marcelo Tosatti wrote:
> Marcelo Tosatti:
>   o journal_try_to_free_buffers(): Add debug print in case of bh list corruption

Which introduced 4 warnings. Here's a fix:

--- linux-2.4.27-rc1/fs/jbd/transaction.c.orig	2004-06-20 13:04:20.000000000 +0200
+++ linux-2.4.27-rc1/fs/jbd/transaction.c	2004-06-20 19:08:07.000000000 +0200
@@ -1700,11 +1700,11 @@ void debug_page(struct page *p)

 	bh = p->buffers;

-	printk(KERN_ERR "%s: page index:%u count:%d flags:%x\n", __FUNCTION__,
+	printk(KERN_ERR "%s: page index:%lu count:%d flags:%lx\n", __FUNCTION__,
 		 p->index, atomic_read(&p->count), p->flags);

 	while (bh) {
-		printk(KERN_ERR "%s: bh b_next:%p blocknr:%u b_list:%u state:%x\n",
+		printk(KERN_ERR "%s: bh b_next:%p blocknr:%lu b_list:%u state:%lx\n",
 			__FUNCTION__, bh->b_next, bh->b_blocknr, bh->b_list,
 				bh->b_state);
 		bh = bh->b_this_page;


And now I just looked at the original patch:

| --- linux-2.4.26/fs/jbd/transaction.c	2004-02-18 13:36:31.000000000 +0000
| +++ linux-2.4.27-rc1/fs/jbd/transaction.c	2004-06-19 23:37:33.000000000 +0000
| @@ -1752,6 +1769,11 @@ int journal_try_to_free_buffers(journal_
|  	do {
|  		struct buffer_head *p = tmp;
|
| +		if (!unlikely(tmp)) {
                    ^^^^^^^^^^^^^^
Shouldn't this be `unlikely(!tmp))'?

| +			debug_page(page);
| +			BUG();
| +		}
| +
|  		tmp = tmp->b_this_page;
|  		if (buffer_jbd(p))
|  			if (!__journal_try_to_free_buffer(p, &locked_or_dirty))

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
