Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWE3XYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWE3XYX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 19:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWE3XYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 19:24:23 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:24332 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964806AbWE3XYW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 19:24:22 -0400
Date: Wed, 31 May 2006 01:09:28 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Javier Olivares <jolivares@gigablast.com>
Cc: linux-kernel@vger.kernel.org, marcelo@kvack.org
Subject: Re: Bug Fix for 2GB core limit in 2.4
Message-ID: <20060530230928.GA7125@w.ods.org>
References: <447C7B49.4010003@gigablast.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447C7B49.4010003@gigablast.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, May 30, 2006 at 11:05:13AM -0600, Javier Olivares wrote:
> We were having problems when running programs that used over 2GB of ram 
> not being able to generate core files over 2GB, these are some very 
> simple changes that fixed the problem.
> 
> linux-2.4.31/fs/binfmt_elf.c
> 1024c1024
> < static int dump_seek(struct file *file, off_t off)
> ---
> > static int dump_seek(struct file *file, loff_t off)
> 
> Changed the function parameter "off" from type "off_t" to "loff_t".  The 
> parameter was truncating the incoming long long type to a long, causing 
> the seek to fail and kill the dump when off grew above 2GB.

You change looks right.


> /kernels/2.4.31/linux-2.4.31/fs/exec.c
> 1151c1151
> <     file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW, 0600);
> ---
> >     file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW | 
> O_LARGEFILE, 0600);
> 
> Included the O_LARGEFILE flag in order to create files over 2GB.
> 
> The changes have been running on many Debian systems for a couple of 
> months.  Valid core files just over 3GB have been created without any 
> problem.  I have never submitted anything like this before so please 
> excuse any lack of proper protocol.

You would be interested in reading this file in the kernel sources :

   Documentation/SubmittingPatches

Most important to remember : use "diff -u" to make the patch, and don't
forget to CC the maintainer, particularly on 2.4 patches, because very
few patches are related to 2.4 right now on LKML and it's easy to miss
them. Anyway, your changes are quite self-explanatory and are very easy
to redo by hand. Here's the patch re-done as a diff -u (in fact, as
exported by Git but the output from diff -u would be the same).

--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1026,7 +1026,7 @@ static int dump_write(struct file *file,
 	return file->f_op->write(file, addr, nr, &file->f_pos) == nr;
 }
 
-static int dump_seek(struct file *file, off_t off)
+static int dump_seek(struct file *file, loff_t off)
 {
 	if (file->f_op->llseek) {
 		if (file->f_op->llseek(file, off, 0) != off)

--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1148,7 +1148,8 @@ int do_coredump(long signr, struct pt_re
 		goto fail;
 
  	format_corename(corename, core_pattern, signr);
-	file = filp_open(corename, O_CREAT | 2 | O_NOFOLLOW, 0600);
+	file = filp_open(corename,
+	                 O_CREAT | 2 | O_NOFOLLOW | O_LARGEFILE, 0600);
 	if (IS_ERR(file))
 		goto fail;
 	inode = file->f_dentry->d_inode;


> Thank you.
> 
> -Javier Olivares

Thank you.

Marcelo, this looks valid to me, I've queued it.
Willy


