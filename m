Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262474AbTIHPOP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 11:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbTIHPOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 11:14:15 -0400
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:10128 "EHLO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S262474AbTIHPOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 11:14:10 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: [2.4.23-pre3] Possible bug in fs/buffer.c
Date: Mon, 8 Sep 2003 17:15:09 +0200
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309081715.09657@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is __put_unused_buffer_head from fs/buffer.c, lines 1156 to 1171:


static void __put_unused_buffer_head(struct buffer_head * bh)
{
	if (unlikely(buffer_attached(bh)))
		BUG();
	if (nr_unused_buffer_heads >= MAX_UNUSED_BUFFERS) {
		kmem_cache_free(bh_cachep, bh);
	} else {
		bh->b_dev = B_FREE;
===>		bh->b_blocknr = -1;		<===
		bh->b_this_page = NULL;

		nr_unused_buffer_heads++;
		bh->b_next_free = unused_list;
		unused_list = bh;
	}
}

In include/linux/fs.h "struct buffer_head" is defined this way:

struct buffer_head {
        /* First cache line: */
        struct buffer_head *b_next;     /* Hash queue list */
        unsigned long b_blocknr;        /* block number */
...

So this line (and line 1205, which is the same) is either ugly (and someone
meant ~0UL or something similar) or completely bogus. Same way in 
2.6.0-test4-bk10/fs/buffer.c, line 1031 (b_blocknr is a sector_t, which is an
unsigned long).

Comments?

Eike
