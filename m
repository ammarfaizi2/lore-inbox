Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262883AbUKSBOa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbUKSBOa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 20:14:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261217AbUKSBNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 20:13:02 -0500
Received: from www.ssc.unict.it ([151.97.230.9]:49926 "HELO ssc.unict.it")
	by vger.kernel.org with SMTP id S263004AbUKSBLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 20:11:39 -0500
Subject: [patch 2/4] hostfs - uml: add some other pagecache methods
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       blaisorblade_spam@yahoo.it, viro@parcelfarce.linux.theplanet.co.uk
From: blaisorblade_spam@yahoo.it
Date: Fri, 19 Nov 2004 02:13:31 +0100
Message-Id: <20041119011332.64C417B9AA@zion.localdomain>
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.18; VDF: 6.28.0.80; host: ssc.unict.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>

This is a follow-up to my previous "hostfs - uml: set .sendfile to
generic_file_sendfile" patch. I was asking whether other methods should have
been added, and comparing with ext3 I found some more ones.

However, I have not specific clues about them: I know they use the pagecache,
which relies on *page methods, which are defined by hostfs. So I think it
could work.

I have a doubt, whether hostfs needs the commented out method below:

static struct address_space_operations hostfs_aops = {
	.writepage 	= hostfs_writepage,
	.readpage	= hostfs_readpage,
/* 	.set_page_dirty = __set_page_dirty_nobuffers, */
	.prepare_write	= hostfs_prepare_write,
	.commit_write	= hostfs_commit_write
};

Hostfs does not have a underlying device (and I have some rough idea that
buffers cache block devices data), so I wonder if that is needed or not.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 linux-2.6.10-rc-paolo/fs/hostfs/hostfs_kern.c |    5 +++++
 1 files changed, 5 insertions(+)

diff -puN fs/hostfs/hostfs_kern.c~uml-hostfs-add-some-other-pagecache-methods fs/hostfs/hostfs_kern.c
--- linux-2.6.10-rc/fs/hostfs/hostfs_kern.c~uml-hostfs-add-some-other-pagecache-methods	2004-11-18 17:43:38.239312696 +0100
+++ linux-2.6.10-rc-paolo/fs/hostfs/hostfs_kern.c	2004-11-18 17:43:38.242312240 +0100
@@ -394,6 +394,10 @@ static struct file_operations hostfs_fil
 	.llseek		= generic_file_llseek,
 	.read		= generic_file_read,
 	.sendfile	= generic_file_sendfile,
+	.aio_read	= generic_file_aio_read,
+	.aio_write	= generic_file_aio_write,
+	.readv		= generic_file_readv,
+	.writev		= generic_file_writev,
 	.write		= generic_file_write,
 	.mmap		= generic_file_mmap,
 	.open		= hostfs_file_open,
@@ -402,6 +406,7 @@ static struct file_operations hostfs_fil
 };
 
 static struct file_operations hostfs_dir_fops = {
+	.llseek		= generic_file_llseek,
 	.readdir	= hostfs_readdir,
 	.read		= generic_read_dir,
 };
_
