Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751327AbWA0Rng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWA0Rng (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 12:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWA0Rnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 12:43:35 -0500
Received: from darwin.snarc.org ([81.56.210.228]:33416 "EHLO darwin.snarc.org")
	by vger.kernel.org with ESMTP id S1751327AbWA0Rnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 12:43:35 -0500
Date: Fri, 27 Jan 2006 18:43:33 +0100
To: Greg KH <gregkh@suse.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] debugfs: hard link count wrong
Message-ID: <20060127174332.GA19649@snarc.org>
References: <20060126141142.GA11599@osiris.boeblingen.de.ibm.com> <20060127032513.GA12559@suse.de> <20060127055607.GA9331@osiris.boeblingen.de.ibm.com> <20060127063804.GA4680@suse.de> <20060127070423.GB9331@osiris.boeblingen.de.ibm.com> <20060127071749.GA13924@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127071749.GA13924@suse.de>
X-Warning: Email may contain unsmilyfied humor and/or satire.
User-Agent: Mutt/1.5.9i
From: tab@snarc.org (Vincent Hanquez)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 11:17:49PM -0800, Greg KH wrote:
> I'm running 4.3.0, not 4.2.30.  I don't know where it came from either,
> gentoo's unstable tree has it, and caused me to download it from
> somewhere when I built it :)

looks like all fs that use simple_fill_super got a root inode with
i_nlink=1 at the start of day.

I've compared with shmem, the nlink is incremented to 2 by a call to
shmem_get_inode, when filling_super.

I've test the following patch with debugfs and securityfs, and its
seems to cure the problem.

------

Fix incorrect nlink of root inode for filesystems that use simple_fill_super

Signed-off-by: Vincent Hanquez <vincent@snarc.org>

diff -Naur a/fs/libfs.c a/fs/libfs.c
--- a/fs/libfs.c	2006-01-03 03:21:10.000000000 +0000
+++ b/fs/libfs.c	2006-01-27 17:43:31.000000000 +0000
@@ -388,6 +388,7 @@
 	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
+	inode->i_nlink = 2;
 	root = d_alloc_root(inode);
 	if (!root) {
 		iput(inode);

