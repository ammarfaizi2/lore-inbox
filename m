Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264236AbTCXPAE>; Mon, 24 Mar 2003 10:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264239AbTCXPAE>; Mon, 24 Mar 2003 10:00:04 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:59404 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S264236AbTCXO77>; Mon, 24 Mar 2003 09:59:59 -0500
Date: Mon, 24 Mar 2003 16:11:06 +0100
From: Jan Kara <jack@ucw.cz>
To: Tim Hockin <thockin@sun.com>
Cc: nathans@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: XFS and Quotas and Q_SYNC
Message-ID: <20030324151106.GD377@atrey.karlin.mff.cuni.cz>
References: <3E653072.5050907@sun.com> <20030305043131.GC1512@frodo> <20030305175431.GK22687@atrey.karlin.mff.cuni.cz> <3E663E5D.4000003@sun.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
Content-Disposition: inline
In-Reply-To: <3E663E5D.4000003@sun.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello,

  so I created the patch which adds possibility to sync all devices at
once to quotactl(2) interface.  Please test it and let me know so I can
send the patch to Linus. The attached patch is against 2.5.64. The
version for 2.4.20 kernel can be found at
ftp://atrey.karlin.mff.cuni.cz/pub/local/jack/quota/v2.4/2.4.20/
(it's actually complete set of my patches containing also the change).

								Honza


> Jan Kara wrote:
> 
> >>>1) quotactl(Q_SYNC, NULL) is supposed to sync all quotas.  This fails. 
> >>>The manpage still documents it.  Is this still valid?  I think it needs 
> >>>to be..
> >>
> >  It should work... I'll have a look at it. For XFS and other fses it might
> >noop but it shouldn't fail.
> 
> Right, it should just loop and noop where needed.  Maybe something like:
> 
>         spin_lock(&sb_lock);
>         list_for_each(p, &super_blocks) {
>                 sb = sb_entry(p);
>                 if (sb->s_qcop->quota_sync)
>                         sb->s_qcop->quota_sync(sb, type);
>                 }
>         spin_unlock(&sb_lock);
>         return 0;
> 
> I appreciate you looking into this one.
> 
> >>I believe the fundamental changes to the API were made to support
> >>32 bit uid's/gid's in the VFS quota implementation and changes to
> >>the ondisk quota file format.  Its my belief that the new versions
> >>of the tools could work with either new or old kernels, best check
> >>with Jan on that one (nothing to do with XFS).
> >
> >  Right. And to the binary compatibility: Linux is not supposed to
> >maintain binary compatibily between major kernel releases (eg.
> >2.2->2.4) and quota changes were accepted in 2.5.
> 
> OK, but what of the 2.4 backport?  Adding XFS to a 2.4.x kernel breaks 
> binary compatibility.  It seems to me that gratuitously changing values 
> so as to gurantee broken compatibility is inane.
> 
> I guess I'll have to deal with this aspect of it.  If Q_SYNC for NULL 
> works, then I can get working systems back with a recompile and new 
> headers.  Uggh.  Not nice to do to me in an update of a backport.
> 
> thanks for the info.
> 
> Tim
> -- 
> Tim Hockin
> Systems Software Engineer
> Sun Microsystems, Linux Kernel Engineering
> thockin@sun.com

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.5.64-2-syncall.diff"

diff -ru linux-2.5.64/fs/dquot.c linux-2.5.64-syncall/fs/dquot.c
--- linux-2.5.64/fs/dquot.c	Wed Mar  5 04:29:31 2003
+++ linux-2.5.64-syncall/fs/dquot.c	Wed Mar 19 11:19:05 2003
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
diff -ru linux-2.5.64/fs/quota.c linux-2.5.64-syncall/fs/quota.c
--- linux-2.5.64/fs/quota.c	Wed Mar  5 04:29:52 2003
+++ linux-2.5.64-syncall/fs/quota.c	Wed Mar 19 11:19:05 2003
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
@@ -221,23 +268,26 @@
 	uint cmds, type;
 	struct super_block *sb = NULL;
 	struct block_device *bdev;
-	int ret = -ENODEV;
+	int ret;
 
 	cmds = cmd >> SUBCMDSHIFT;
 	type = cmd & SUBCMDMASK;
 
-	bdev = lookup_bdev(special);
-	if (IS_ERR(bdev))
-		return PTR_ERR(bdev);
-	sb = get_super(bdev);
-	bdput(bdev);
+	if (cmds != Q_SYNC || special) {
+		bdev = lookup_bdev(special);
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

--0F1p//8PRICkK4MW--
