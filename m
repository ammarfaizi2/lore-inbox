Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031508AbWLEVQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031508AbWLEVQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 16:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031503AbWLEVQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 16:16:28 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:46253 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031494AbWLEVQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 16:16:27 -0500
Date: Tue, 5 Dec 2006 22:09:19 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>
cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org,
       hch@infradead.org, viro@ftp.linux.org.uk, linux-fsdevel@vger.kernel.org,
       mhalcrow@us.ibm.com
Subject: Re: [PATCH 16/35] Unionfs: Copyup Functionality
In-Reply-To: <1165235470298-git-send-email-jsipek@cs.sunysb.edu>
Message-ID: <Pine.LNX.4.61.0612052202250.18570@yvahk01.tjqt.qr>
References: <1165235468365-git-send-email-jsipek@cs.sunysb.edu>
 <1165235470298-git-send-email-jsipek@cs.sunysb.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 4 2006 07:30, Josef 'Jeff' Sipek wrote:
>+/* Determine the mode based on the copyup flags, and the existing dentry. */
>+static int copyup_permissions(struct super_block *sb,
>+			      struct dentry *old_hidden_dentry,
>+			      struct dentry *new_hidden_dentry)
>+{
>+	struct inode *i = old_hidden_dentry->d_inode;

Screams for constification. (Or rather I do.)

>+{
>+	int err = 0;
>+	umode_t old_mode = old_hidden_dentry->d_inode->i_mode;

Generel question for everybody: Why do we have two same (at least on i386
that's the case) types, umode_t and mode_t?

>+	} else if (S_ISBLK(old_mode)
>+		   || S_ISCHR(old_mode)
>+		   || S_ISFIFO(old_mode)
>+		   || S_ISSOCK(old_mode)) {
>+		args.mknod.parent = new_hidden_parent_dentry->d_inode;
>+		args.mknod.dentry = new_hidden_dentry;
>+		args.mknod.mode = old_mode;

I'd say the indent got screwed up, and it's not a mailer thing.

>+	} else if (S_ISBLK(old_mode)
>+	    || S_ISCHR(old_mode)
>+	    || S_ISFIFO(old_mode)
>+	    || S_ISSOCK(old_mode)) {
>+		args.mknod.parent = new_hidden_parent_dentry->d_inode;
>+		args.mknod.dentry = new_hidden_dentry;
>+		args.mknod.mode = old_mode;

Try this ^^^. Or even this vvv:

>+	} else if (S_ISBLK(old_mode) || S_ISCHR(old_mode) ||
>+	    S_ISFIFO(old_mode) || S_ISSOCK(old_mode)) {
>+		args.mknod.parent = new_hidden_parent_dentry->d_inode;
>+		args.mknod.dentry = new_hidden_dentry;
>+		args.mknod.mode = old_mode;


>+static inline int __copyup_reg_data(struct dentry *dentry,
>+				    struct dentry *new_hidden_dentry,
>+				    int new_bindex,
>+				    struct dentry *old_hidden_dentry,
>+				    int old_bindex,
>+				    struct file **copyup_file,
>+				    loff_t len)
>+{
>+	struct super_block *sb = dentry->d_sb;
>+	struct file *input_file;
>+	struct file *output_file;
>+	mm_segment_t old_fs;
>+	char *buf = NULL;
>+	ssize_t read_bytes, write_bytes;
>+	loff_t size;
>+	int err = 0;
>+
>+	/* open old file */
>+	mntget(unionfs_lower_mnt_idx(dentry, old_bindex));
>+	branchget(sb, old_bindex);
>+	input_file = dentry_open(old_hidden_dentry,
>+			unionfs_lower_mnt_idx(dentry, old_bindex), O_RDONLY | O_LARGEFILE);
>+	if (IS_ERR(input_file)) {
>+		dput(old_hidden_dentry);
>+		err = PTR_ERR(input_file);
>+		goto out;
>+	}
>+	if (!input_file->f_op || !input_file->f_op->read) {
>+		err = -EINVAL;
>+		goto out_close_in;
>+	}
>+
>+	/* open new file */
>+	dget(new_hidden_dentry);
>+	mntget(unionfs_lower_mnt_idx(dentry, new_bindex));
>+	branchget(sb, new_bindex);
>+	output_file = dentry_open(new_hidden_dentry,
>+			unionfs_lower_mnt_idx(dentry, new_bindex), O_WRONLY | O_LARGEFILE);

Here we got an 80-column buster.

>+	if (IS_ERR(output_file)) {
>+		err = PTR_ERR(output_file);
>+		goto out_close_in2;
>+	}
>+	if (!output_file->f_op || !output_file->f_op->write) {
>+		err = -EINVAL;
>+		goto out_close_out;
>+	}
>+
>+	/* allocating a buffer */
>+	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
>+	if (!buf) {
>+		err = -ENOMEM;
>+		goto out_close_out;
>+	}
>+
>+	input_file->f_pos = 0;
>+	output_file->f_pos = 0;
>+
>+	old_fs = get_fs();
>+	set_fs(KERNEL_DS);
>+
>+	size = len;
>+	err = 0;
>+	do {
>+		if (len >= PAGE_SIZE)
>+			size = PAGE_SIZE;
>+		else if ((len < PAGE_SIZE) && (len > 0))
>+			size = len;

Some redundant () here.

>+
>+		len -= PAGE_SIZE;
>+
>+		read_bytes =
>+		    input_file->f_op->read(input_file,
>+					   (char __user *)buf, size,
>+					   &input_file->f_pos);
>+		if (read_bytes <= 0) {
>+			err = read_bytes;
>+			break;
>+		}
>+
>+		write_bytes =
>+		    output_file->f_op->write(output_file,
>+					     (char __user *)buf,
>+					     read_bytes,
>+					     &output_file->f_pos);
>+		if (write_bytes < 0 || (write_bytes < read_bytes)) {

dit(t)o

>+			err = write_bytes;
>+			break;
>+		}
>+	} while ((read_bytes > 0) && (len > 0));

~

>+
>+	set_fs(old_fs);
>+
>+	kfree(buf);
>+
>+	if (err)
>+		goto out_close_out;
>+	if (copyup_file) {
>+		*copyup_file = output_file;
>+		goto out_close_in;
>+	}
>+
>+out_close_out:
>+	fput(output_file);
>+
>+out_close_in2:
>+	branchput(sb, new_bindex);
>+
>+out_close_in:
>+	fput(input_file);
>+
>+out:
>+	branchput(sb, old_bindex);
>+
>+	return err;
>+}
>+

>+	/* TODO: should we reset the error to something like -EIO? */

Handle it :)  - if it does not take a paper.




	-`J'
-- 
