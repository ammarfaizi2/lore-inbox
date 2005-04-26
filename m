Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261381AbVDZIGv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261381AbVDZIGv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 04:06:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVDZIGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 04:06:51 -0400
Received: from colino.net ([213.41.131.56]:64753 "EHLO paperstreet.colino.net")
	by vger.kernel.org with ESMTP id S261381AbVDZIGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 04:06:43 -0400
Date: Tue, 26 Apr 2005 10:06:36 +0200
From: Colin Leroy <colin@colino.net>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] hfsplus: don't leak sb->s_fs_info and don't oops on bad
 filesystem
Message-ID: <20050426100636.2bda6939@colin.toulouse>
X-Mailer: Sylpheed-Claws 1.9.6 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the second attempt at fixing two bugs in hfsplus; this patch
fixes the leak of sb->s_fs_info, and also fixes an oops [1] when trying
to mount something that isn't hfsplus with hfsplus.

The first hunk is just a protection, the second one fixes the oops, and 
the third one fixes the leak.

[1] http://colino.net/tmp/hfsplus_oops.txt

Signed-off-by: Colin Leroy <colin@colino.net>
--- a/fs/hfsplus/super.c	2005-04-25 21:56:56.000000000 +0200
+++ b/fs/hfsplus/super.c	2005-04-26 09:56:49.000000000 +0200
@@ -207,9 +207,14 @@
 
 static void hfsplus_put_super(struct super_block *sb)
 {
+	if (!sb->s_fs_info)
+		return;
+
 	dprint(DBG_SUPER, "hfsplus_put_super\n");
 	if (!(sb->s_flags & MS_RDONLY)) {
 		struct hfsplus_vh *vhdr = HFSPLUS_SB(sb).s_vhdr;
+		if (!vhdr)
+			goto cleanup;
 
 		vhdr->modify_date = hfsp_now2mt();
 		vhdr->attributes |= cpu_to_be32(HFSPLUS_VOL_UNMNT);
@@ -226,6 +231,10 @@
 	brelse(HFSPLUS_SB(sb).s_vhbh);
 	if (HFSPLUS_SB(sb).nls)
 		unload_nls(HFSPLUS_SB(sb).nls);
+
+cleanup:
+	kfree(sb->s_fs_info);
+	sb->s_fs_info = NULL;
 }
 
 static int hfsplus_statfs(struct super_block *sb, struct kstatfs *buf)
