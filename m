Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbUJ0M3q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbUJ0M3q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 08:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbUJ0M3q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 08:29:46 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60898 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262409AbUJ0M3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 08:29:25 -0400
Date: Wed, 27 Oct 2004 14:29:24 +0200
From: Jan Kara <jack@suse.cz>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] Quota warnings somewhat broken
Message-ID: <20041027122924.GE29852@atrey.karlin.mff.cuni.cz>
References: <Pine.LNX.4.53.0410211807020.12823@yvahk01.tjqt.qr> <20041022093423.GC31932@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.58.0410220804040.2101@ppc970.osdl.org> <20041025111517.GF13208@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041025111517.GF13208@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On Fri, 22 Oct 2004, Jan Kara wrote:
> > >
> > >   Thanks for notifying. It looks like a good idea. Attached patch should apply
> > > well to 2.6.9. Linus, please apply.
> > 
> > Why does this code use tty_write_message() in the first place? It's a bit 
> > rude to mess up the users tty without any way to disable it, isn't it? 
>   OK, I'll tide up a bit a patch of Jan Engelhardt <jengelh@linux01.gwdg.de>
> and send it to you.
  Here's the promised patch to allow root to turn off quota warnings
into the console. The patch is based on the one by Jan Engelhardt. Please
apply.
								Honza

Allow root to turn off quota warnings into the console.

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
