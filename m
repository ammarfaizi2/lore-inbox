Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264456AbTDPPu0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 11:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbTDPPu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 11:50:26 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:33037 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264472AbTDPPuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 11:50:20 -0400
Date: Wed, 16 Apr 2003 18:02:13 +0200
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Minor update in quotactl interface
Message-ID: <20030416160213.GA13841@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello Linus,

  I'm resending a patch which implements quotactl(2) call for syncing
all devices. Particulary it allows the caller not to specify the device
for syncing and in that case quotas on all the devices are written.
The patch is rather trivial (mostly moving the code). Please apply
(the patch is against 2.5.67).

							Thanks Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs


diff -ruNX /home/jack/.kerndiffexclude linux-2.5.67/fs/dquot.c linux-2.5.67-1-syncall/fs/dquot.c
--- linux-2.5.67/fs/dquot.c	Sat Mar 22 19:49:03 2003
+++ linux-2.5.67-1-syncall/fs/dquot.c	Tue Apr 15 19:57:17 2003
@@ -345,50 +345,6 @@
 	return 0;
 }
 
-static struct super_block *get_super_to_sync(int type)
-{
-	struct list_head *head;
-	int cnt, dirty;
-
-restart:
-	spin_lock(&sb_lock);
-	list_for_each(head, &super_blocks) {
-		struct super_block *sb = list_entry(head, struct super_block, s_list);
-
-		for (cnt = 0, dirty = 0; cnt < MAXQUOTAS; cnt++)
-			if ((type == cnt || type == -1) && sb_has_quota_enabled(sb, cnt)
-			    && info_any_dquot_dirty(&sb_dqopt(sb)->info[cnt]))
-				dirty = 1;
-		if (!dirty)
-			continue;
-		sb->s_count++;
-		spin_unlock(&sb_lock);
-		down_read(&sb->s_umount);
-		if (!sb->s_root) {
-			drop_super(sb);
-			goto restart;
-		}
-		return sb;
-	}
-	spin_unlock(&sb_lock);
-	return NULL;
-}
-
-void sync_dquots(struct super_block *sb, int type)
-{
-	if (sb) {
-		if (sb->s_qcop->quota_sync)
-			sb->s_qcop->quota_sync(sb, type);
-	}
-	else {
-		while ((sb = get_super_to_sync(type))) {
-			if (sb->s_qcop->quota_sync)
-				sb->s_qcop->quota_sync(sb, type);
-			drop_super(sb);
-		}
-	}
-}
-
 /* Free unused dquots from cache */
 static void prune_dqcache(int count)
 {
diff -ruNX /home/jack/.kerndiffexclude linux-2.5.67/fs/quota.c linux-2.5.67-1-syncall/fs/quota.c
--- linux-2.5.67/fs/quota.c	Tue Apr 15 19:54:25 2003
+++ linux-2.5.67-1-syncall/fs/quota.c	Tue Apr 15 19:59:46 2003
@@ -19,8 +19,10 @@
 {
 	if (type >= MAXQUOTAS)
 		return -EINVAL;
+	if (!sb && cmd != Q_SYNC)
+		return -ENODEV;
 	/* Is operation supported? */
-	if (!sb->s_qcop)
+	if (sb && !sb->s_qcop)
 		return -ENOSYS;
 
 	switch (cmd) {
@@ -51,7 +53,7 @@
 				return -ENOSYS;
 			break;
 		case Q_SYNC:
-			if (!sb->s_qcop->quota_sync)
+			if (sb && !sb->s_qcop->quota_sync)
 				return -ENOSYS;
 			break;
 		case Q_XQUOTAON:
@@ -102,6 +104,50 @@
 	return security_quotactl (cmd, type, id, sb);
 }
 
+static struct super_block *get_super_to_sync(int type)
+{
+	struct list_head *head;
+	int cnt, dirty;
+
+restart:
+	spin_lock(&sb_lock);
+	list_for_each(head, &super_blocks) {
+		struct super_block *sb = list_entry(head, struct super_block, s_list);
+
+		for (cnt = 0, dirty = 0; cnt < MAXQUOTAS; cnt++)
+			if ((type == cnt || type == -1) && sb_has_quota_enabled(sb, cnt)
+			    && info_any_dquot_dirty(&sb_dqopt(sb)->info[cnt]))
+				dirty = 1;
+		if (!dirty)
+			continue;
+		sb->s_count++;
+		spin_unlock(&sb_lock);
+		down_read(&sb->s_umount);
+		if (!sb->s_root) {
+			drop_super(sb);
+			goto restart;
+		}
+		return sb;
+	}
+	spin_unlock(&sb_lock);
+	return NULL;
+}
+
+void sync_dquots(struct super_block *sb, int type)
+{
+	if (sb) {
+		if (sb->s_qcop->quota_sync)
+			sb->s_qcop->quota_sync(sb, type);
+	}
+	else {
+		while ((sb = get_super_to_sync(type))) {
+			if (sb->s_qcop->quota_sync)
+				sb->s_qcop->quota_sync(sb, type);
+			drop_super(sb);
+		}
+	}
+}
+
 /* Copy parameters and call proper function */
 static int do_quotactl(struct super_block *sb, int type, int cmd, qid_t id, caddr_t addr)
 {
@@ -167,7 +213,8 @@
 			return sb->s_qcop->set_dqblk(sb, type, id, &idq);
 		}
 		case Q_SYNC:
-			return sb->s_qcop->quota_sync(sb, type);
+			sync_dquots(sb, type);
+			return 0;
 
 		case Q_XQUOTAON:
 		case Q_XQUOTAOFF:
@@ -222,27 +269,30 @@
 	struct super_block *sb = NULL;
 	struct block_device *bdev;
 	char *tmp;
-	int ret = -ENODEV;
+	int ret;
 
 	cmds = cmd >> SUBCMDSHIFT;
 	type = cmd & SUBCMDMASK;
 
-	tmp = getname(special);
-	if (IS_ERR(tmp))
-		return PTR_ERR(tmp);
-	bdev = lookup_bdev(tmp);
-	putname(tmp);
-	if (IS_ERR(bdev))
-		return PTR_ERR(bdev);
-	sb = get_super(bdev);
-	bdput(bdev);
+	if (cmds != Q_SYNC || special) {
+		tmp = getname(special);
+		if (IS_ERR(tmp))
+			return PTR_ERR(tmp);
+		bdev = lookup_bdev(tmp);
+		putname(tmp);
+		if (IS_ERR(bdev))
+			return PTR_ERR(bdev);
+		sb = get_super(bdev);
+		bdput(bdev);
+		if (!sb)
+			return -ENODEV;
+	}
 
-	if (sb) {
-		ret = check_quotactl_valid(sb, type, cmds, id);
-		if (ret >= 0)
-			ret = do_quotactl(sb, type, cmds, id, addr);
+	ret = check_quotactl_valid(sb, type, cmds, id);
+	if (ret >= 0)
+		ret = do_quotactl(sb, type, cmds, id, addr);
+	if (sb)
 		drop_super(sb);
-	}
 
 	return ret;
 }
