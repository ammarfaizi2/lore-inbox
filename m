Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbUKSLrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbUKSLrt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 06:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbUKSLrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 06:47:49 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:49615 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261359AbUKSLp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 06:45:59 -0500
Date: Fri, 19 Nov 2004 12:45:58 +0100
From: Jan Kara <jack@suse.cz>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Allow disabling quota messages to console
Message-ID: <20041119114558.GA11334@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

  Hello!

  Attached patch allows disabling of quota messages about exceeding of
limits to console (some people don't like them disturbing their output).
The patch applies well to any recent kernel. Please apply.

								Honza

-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs

--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="quota-2.6.9-quotawarn.diff"

Allow disabling of quota messages to console (they can disturb other output).

Signed-off-by: Jan Kara <jack@suse.cz>

diff -ru linux-2.6.9/fs/dquot.c linux-2.6.9-quotawarn/fs/dquot.c
--- linux-2.6.9/fs/dquot.c	2004-10-18 23:54:39.000000000 +0200
+++ linux-2.6.9-quotawarn/fs/dquot.c	2004-10-25 15:48:56.000000000 +0200
@@ -774,8 +774,13 @@
 	clear_bit(DQ_BLKS_B, &dquot->dq_flags);
 }
 
+static int flag_print_warnings = 1;
+
 static inline int need_print_warning(struct dquot *dquot)
 {
+	if (!flag_print_warnings)
+		return 0;
+
 	switch (dquot->dq_type) {
 		case USRQUOTA:
 			return current->fsuid == dquot->dq_id;
@@ -803,6 +808,7 @@
 
 	if (!need_print_warning(dquot) || (flag && test_and_set_bit(flag, &dquot->dq_flags)))
 		return;
+
 	tty_write_message(current->signal->tty, dquot->dq_sb->s_id);
 	if (warntype == ISOFTWARN || warntype == BSOFTWARN)
 		tty_write_message(current->signal->tty, ": warning, ");
@@ -1722,6 +1728,14 @@
 		.mode		= 0444,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= FS_DQ_WARNINGS,
+		.procname	= "warnings",
+		.data		= &flag_print_warnings,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 	{ .ctl_name = 0 },
 };
 
diff -ru linux-2.6.9/include/linux/sysctl.h linux-2.6.9-quotawarn/include/linux/sysctl.h
--- linux-2.6.9/include/linux/sysctl.h	2004-10-18 23:54:31.000000000 +0200
+++ linux-2.6.9-quotawarn/include/linux/sysctl.h	2004-10-25 15:43:47.000000000 +0200
@@ -662,7 +662,7 @@
 	FS_LEASES=13,	/* int: leases enabled */
 	FS_DIR_NOTIFY=14,	/* int: directory notification enabled */
 	FS_LEASE_TIME=15,	/* int: maximum time to wait for a lease break */
-	FS_DQSTATS=16,	/* disc quota usage statistics */
+	FS_DQSTATS=16,	/* disc quota usage statistics and control */
 	FS_XFS=17,	/* struct: control xfs parameters */
 	FS_AIO_NR=18,	/* current system-wide number of aio requests */
 	FS_AIO_MAX_NR=19,	/* system-wide maximum number of aio requests */
@@ -678,6 +678,7 @@
 	FS_DQ_ALLOCATED = 6,
 	FS_DQ_FREE = 7,
 	FS_DQ_SYNCS = 8,
+	FS_DQ_WARNINGS = 9,
 };
 
 /* CTL_DEBUG names: */

--Dxnq1zWXvFF0Q93v--
