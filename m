Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265099AbUEYWia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265099AbUEYWia (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 18:38:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUEYWia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 18:38:30 -0400
Received: from fw.osdl.org ([65.172.181.6]:49313 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265099AbUEYWi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 18:38:27 -0400
Date: Tue, 25 May 2004 15:41:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: olh@suse.de, linux-kernel@vger.kernel.org
Subject: Re: very low performance on SCSI disks if device node is in tmpfs
Message-Id: <20040525154107.053b9ef6.akpm@osdl.org>
In-Reply-To: <20040525145923.68af0ad8.akpm@osdl.org>
References: <20040525184732.GB26661@suse.de>
	<20040525144836.1af59a96.akpm@osdl.org>
	<20040525145923.68af0ad8.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:
>
> Everything there is consistent with "not doing readahead".
>



We need to set file->f_ra _after_ calling blkdev_open(), when inode->i_mapping
points at the right thing.  And we need to get it from
inode->i_mapping->host->i_mapping too, which represents the underlying device.


--- 25/fs/open.c~blockdev-readahead-fix	Tue May 25 15:38:15 2004
+++ 25-akpm/fs/open.c	Tue May 25 15:38:15 2004
@@ -790,7 +790,6 @@ struct file *dentry_open(struct dentry *
 	}
 
 	f->f_mapping = inode->i_mapping;
-	file_ra_state_init(&f->f_ra, f->f_mapping);
 	f->f_dentry = dentry;
 	f->f_vfsmnt = mnt;
 	f->f_pos = 0;
@@ -804,6 +803,8 @@ struct file *dentry_open(struct dentry *
 	}
 	f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
 
+	file_ra_state_init(&f->f_ra, f->f_mapping->host->i_mapping);
+
 	/* NB: we're sure to have correct a_ops only after f_op->open */
 	if (f->f_flags & O_DIRECT) {
 		if (!f->f_mapping || !f->f_mapping->a_ops ||
_

