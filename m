Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263680AbTEGQEt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 12:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263970AbTEGQEt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 12:04:49 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:21519 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S263680AbTEGQEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 12:04:47 -0400
Date: Wed, 7 May 2003 18:17:20 +0200
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] dquot_transfer() fix
Message-ID: <20030507161720.GH28363@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,

  I'm sending a fix which fixes potential problems (dropping references
which were not acquired) when dquot_transfer() fails. Please apply.

								Honza

diff -ruNX /home/jack/.kerndiffexclude linux-2.5.68-1-ext3dfix/fs/dquot.c linux-2.5.68-2-dqtransfix/fs/dquot.c
--- linux-2.5.68-1-ext3dfix/fs/dquot.c	Sun May  4 12:32:23 2003
+++ linux-2.5.68-2-dqtransfix/fs/dquot.c	Wed May  7 14:17:23 2003
@@ -1055,9 +1055,12 @@
 	spin_unlock(&dq_data_lock);
 	flush_warnings(transfer_to, warntype);
 	
-	for (cnt = 0; cnt < MAXQUOTAS; cnt++)
-		if (transfer_from[cnt] != NODQUOT)
+	for (cnt = 0; cnt < MAXQUOTAS; cnt++) {
+		if (ret == QUOTA_OK && transfer_from[cnt] != NODQUOT)
 			dqput(transfer_from[cnt]);
+		if (ret == NO_QUOTA && transfer_to[cnt] != NODQUOT)
+			dqput(transfer_to[cnt]);
+	}
 	up_write(&sb_dqopt(inode->i_sb)->dqptr_sem);
 	return ret;
 }
