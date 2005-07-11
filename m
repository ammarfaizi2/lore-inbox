Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262133AbVGKQD3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262133AbVGKQD3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 12:03:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261998AbVGKQBa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 12:01:30 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49604 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262141AbVGKP7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 11:59:34 -0400
Date: Mon, 11 Jul 2005 17:59:28 +0200
From: Jan Kara <jack@suse.cz>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: [PATCH] Change HFS+ to not use ll_rw_block()
Message-ID: <20050711155928.GV12428@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="nYySOmuH/HDX6pKp"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hi,

  attached patch changes HFS+ to use sync_one_buffer() instead of
ll_rw_block() and wait_on_buffer().

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--nYySOmuH/HDX6pKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="hfsplus-2.6.12-ll_rw_block-fix.diff"

Use block layer predefined function.

Signed-off-by: Jan Kara <jack@suse.cz>

diff -rupX /home/jack/.kerndiffexclude linux-2.6.12-1-forgetfix/fs/hfsplus/super.c linux-2.6.12-2-ll_rw_block-fix/fs/hfsplus/super.c
--- linux-2.6.12-1-forgetfix/fs/hfsplus/super.c	2005-06-28 13:26:18.000000000 +0200
+++ linux-2.6.12-2-ll_rw_block-fix/fs/hfsplus/super.c	2005-07-09 01:52:10.000000000 +0200
@@ -217,8 +217,7 @@ static void hfsplus_put_super(struct sup
 		vhdr->attributes |= cpu_to_be32(HFSPLUS_VOL_UNMNT);
 		vhdr->attributes &= cpu_to_be32(~HFSPLUS_VOL_INCNSTNT);
 		mark_buffer_dirty(HFSPLUS_SB(sb).s_vhbh);
-		ll_rw_block(WRITE, 1, &HFSPLUS_SB(sb).s_vhbh);
-		wait_on_buffer(HFSPLUS_SB(sb).s_vhbh);
+		sync_dirty_buffer(HFSPLUS_SB(sb).s_vhbh);
 	}
 
 	hfs_btree_close(HFSPLUS_SB(sb).cat_tree);
@@ -415,8 +414,7 @@ static int hfsplus_fill_super(struct sup
 	vhdr->attributes &= cpu_to_be32(~HFSPLUS_VOL_UNMNT);
 	vhdr->attributes |= cpu_to_be32(HFSPLUS_VOL_INCNSTNT);
 	mark_buffer_dirty(HFSPLUS_SB(sb).s_vhbh);
-	ll_rw_block(WRITE, 1, &HFSPLUS_SB(sb).s_vhbh);
-	wait_on_buffer(HFSPLUS_SB(sb).s_vhbh);
+	sync_dirty_buffer(HFSPLUS_SB(sb).s_vhbh);
 
 	if (!HFSPLUS_SB(sb).hidden_dir) {
 		printk("HFS+: create hidden dir...\n");

--nYySOmuH/HDX6pKp--
