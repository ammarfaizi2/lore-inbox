Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293408AbSBYTiL>; Mon, 25 Feb 2002 14:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292944AbSBYTiB>; Mon, 25 Feb 2002 14:38:01 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:13067 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S293454AbSBYThP>; Mon, 25 Feb 2002 14:37:15 -0500
Date: Mon, 25 Feb 2002 20:37:08 +0100
From: Jan Kara <jack@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Quota fixes
Message-ID: <20020225193708.GF25698@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="V0207lvV8h4k8FAm"
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello Alan,

  two attached patches fix bugs in quota code. First one fixes
possible deadlock/inode list corruption (Chris Mason actually
fixed this bug), second one fixes possible quotafile corruption
on heavily loaded machines. Please apply.

								Honza

--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dquot_deadlock.diff"

--- linux/fs/dquot.c Mon, 15 Oct 2001 03:51:05 -0400 root (linux/i/40_dquot.c 1.1.2.1.3.1.1.1 644)
+++ linux/fs/dquot.c Mon, 15 Oct 2001 14:12:57 -0400 root (linux/i/40_dquot.c 1.1.2.1.3.1.1.1 644)
@@ -1246,6 +1246,8 @@
 {
 	if (dquot->dq_dup_ref && dquot->dq_count - dquot->dq_dup_ref <= 1)
 		return 1;
+	if (dquot->dq_count <= 1 && dquot->dq_flags & DQ_MOD) 
+		return 1; 
 	return 0;
 }
 

--V0207lvV8h4k8FAm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-corrupt.diff"

--- linux/fs/dquot.c	Fri Feb  8 00:34:36 2002
+++ linux/fs/dquot.c	Fri Feb  8 00:35:17 2002
@@ -804,9 +804,11 @@
 {
 	uint tmp = DQTREEOFF;
 
-	if (!dquot->dq_off)	/* Even not allocated? */
-		return;
 	down(&sb_dqopt(dquot->dq_sb)->dqio_sem);
+	if (!dquot->dq_off) {	/* Even not allocated? */
+		up(&sb_dqopt(dquot->dq_sb)->dqio_sem);
+		return;
+	}
 	remove_tree(dquot, &tmp, 0);
 	up(&sb_dqopt(dquot->dq_sb)->dqio_sem);
 }

--V0207lvV8h4k8FAm--
