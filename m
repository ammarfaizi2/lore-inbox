Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031567AbWLEVYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031567AbWLEVYY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031570AbWLEVYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:24:23 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:57531 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031567AbWLEVYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:24:22 -0500
Date: Tue, 5 Dec 2006 22:17:14 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 19/35] Unionfs: Directory file operations
In-Reply-To: <11652354702670-git-send-email-jsipek@cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612052213530.18570@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <11652354702670-git-send-email-jsipek@cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>+++ b/fs/unionfs/dirfops.c

>+/* This is not meant to be a generic repositioning function.  If you do
>+ * things that aren't supported, then we return EINVAL.
>+ *
>+ * What is allowed:
>+ *  (1) seeking to the same position that you are currently at
>+ *	This really has no effect, but returns where you are.
>+ *  (2) seeking to the end of the file, if you've read everything
>+ *	This really has no effect, but returns where you are.
>+ *  (3) seeking to the beginning of the file
>+ *	This throws out all state, and lets you begin again.
>+ */
>+static loff_t unionfs_dir_llseek(struct file *file, loff_t offset, int origin)
>+{
[...]
>+	/* We let users seek to their current position, but not anywhere else. */
>+	if (!offset) {
[...]
>+		case SEEK_END:
>+			/* Unsupported, because we would break everything.  */
>+			err = -EINVAL;
>+			break;
[...]

This SEEK_END implementation clashes with (2).

>+	} else {
[...]
>+	}
>+
>+out:
>+	return err;
>+}
>+
>+/* Trimmed directory options, we shouldn't pass everything down since
>+ * we don't want to operate on partial directories.
>+ */
>+struct file_operations unionfs_dir_fops = {
>+	.llseek =		unionfs_dir_llseek,
>+	.read =			generic_read_dir,
>+	.readdir =		unionfs_readdir,
>+	.unlocked_ioctl =	unionfs_ioctl,
>+	.open =			unionfs_open,
>+	.release =		unionfs_file_release,
>+	.flush =		unionfs_flush,
>+};

Prefers

+struct file_operations unionfs_dir_fops = {
+	.llseek         = unionfs_dir_llseek,
+	.read           = generic_read_dir,
+	.readdir        = unionfs_readdir,
+	.unlocked_ioctl = unionfs_ioctl,
+	.open           = unionfs_open,
+	.release        = unionfs_file_release,
+	.flush          = unionfs_flush,
+};

BTW, you could line up other structs too! :)



	-`J'
-- 
