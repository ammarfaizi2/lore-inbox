Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261751AbTCLPy0>; Wed, 12 Mar 2003 10:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261754AbTCLPy0>; Wed, 12 Mar 2003 10:54:26 -0500
Received: from comtv.ru ([217.10.32.4]:13005 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S261751AbTCLPyX>;
	Wed, 12 Mar 2003 10:54:23 -0500
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: ext2-devel@lists.sourceforge.net, Andrew Morton <akpm@digeo.com>,
       Alex Tomas <bzzz@tmi.comex.ru>
Subject: [PATCH] minor bugfix agains ext2
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 12 Mar 2003 18:57:26 +0300
Message-ID: <m3hea84ly1.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

looks like following code in 2.5.64 has bug:

        for (bit = 0; !group_alloc &&
                        bit < sbi->s_groups_count; bit++) {
                group_no++;
                if (group_no >= sbi->s_groups_count)
                        group_no = 0;
                desc = ext2_get_group_desc(sb, group_no, &gdp_bh);
                if (!desc)
                        goto io_error;
                group_alloc = group_reserve_blocks(desc, gdp_bh, es_alloc);
        }
        if (bit >= sbi->s_groups_count) {
                *err = -ENOSPC;
                goto out_release;
        }

if group_reserve_blocks() finds free blocks on last repeat then if (bit >= ...)
will be true, and ext2_new_block() will return -ENOSPC.


here is the patch:

--- linux/fs/ext2/balloc.c	Thu Feb 20 16:18:53 2003
+++ balloc.c	Wed Mar 12 18:47:21 2003
@@ -395,7 +395,7 @@
 			goto io_error;
 		group_alloc = group_reserve_blocks(desc, gdp_bh, es_alloc);
 	}
-	if (bit >= sbi->s_groups_count) {
+	if (!group_alloc) {
 		*err = -ENOSPC;
 		goto out_release;
 	}

