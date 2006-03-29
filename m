Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751113AbWC2N10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751113AbWC2N10 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 08:27:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751114AbWC2N10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 08:27:26 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:46368 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751113AbWC2N10 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 08:27:26 -0500
Date: Wed, 29 Mar 2006 15:27:25 +0200
From: Jens Axboe <axboe@suse.de>
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH][RFC] splice support
Message-ID: <20060329132724.GF8186@suse.de>
References: <20060329122841.GC8186@suse.de> <442A8883.9060909@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <442A8883.9060909@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29 2006, Jeff Garzik wrote:
> Jens Axboe wrote:
> 
> >index 509ccec..23e2c7c 100644
> >--- a/fs/ext2/file.c
> >+++ b/fs/ext2/file.c
> >@@ -53,6 +53,8 @@ const struct file_operations ext2_file_o
> > 	.readv		= generic_file_readv,
> > 	.writev		= generic_file_writev,
> > 	.sendfile	= generic_file_sendfile,
> >+	.splice_read	= generic_file_splice_read,
> >+	.splice_write	= generic_file_splice_write,
> > };
> > 
> > #ifdef CONFIG_EXT2_FS_XIP
> >diff --git a/fs/ext3/file.c b/fs/ext3/file.c
> >index 783a796..1efefb6 100644
> >--- a/fs/ext3/file.c
> >+++ b/fs/ext3/file.c
> >@@ -119,6 +119,8 @@ const struct file_operations ext3_file_o
> > 	.release	= ext3_release_file,
> > 	.fsync		= ext3_sync_file,
> > 	.sendfile	= generic_file_sendfile,
> >+	.splice_read	= generic_file_splice_read,
> >+	.splice_write	= generic_file_splice_write,
> 
> >+static long do_splice_from(struct inode *pipe, struct file *out, size_t 
> >len,
> >+			   unsigned long flags)
> >+{
> >+	if (out->f_op && out->f_op->splice_write)
> >+		return out->f_op->splice_write(pipe, out, len, flags);
> 
> 1) What are the consequences of doing
> 
> 	if (f_op->splice_write)
> 		f_op->splice_write(...);
> 	else
> 		generic_file_splice_write(...);
> 
> to cause sys_splice() to default to supported?

It should probably work, the fs guys should know more about that. Any fs
that ->prepare_write(), ->commit_write() works for can use
generic_file_splice_write(). I prefer to keep it sane for now, mason
tells me that eg xfs might need special care.

> 2) Do you really have to test f_op itself for NULL?  Is that a stealth 
> closed-file check or something?  I would be surprised if f_op was ever 
> really NULL.

Probably not, paranoia.

After posting I fixed another bug, essentially making the 'more' flag to
sendpage() be correct. Should improve throughput a little.

-- 
Jens Axboe

