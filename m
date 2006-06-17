Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750963AbWFQVpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750963AbWFQVpR (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jun 2006 17:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWFQVpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jun 2006 17:45:16 -0400
Received: from 1wt.eu ([62.212.114.60]:49416 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1750963AbWFQVpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jun 2006 17:45:15 -0400
Date: Sat, 17 Jun 2006 23:45:07 +0200
From: Willy Tarreau <w@1wt.eu>
To: marcelo@kvack.org
Cc: jolivares@gigablast.com, linux-kernel@vger.kernel.org
Subject: [PATCH-2.4] allow core files bigger than 2GB
Message-ID: <20060617214507.GA1213@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,

I think I have not sent you this one. It looks valid to me.
I can queue it in -upstream if you prefer to pull everything
at once.

Cheers,
Willy
--

>From nobody Mon Sep 17 00:00:00 2001
From: Javier Olivares <jolivares@gigablast.com>
Date: Wed, 31 May 2006 00:32:59 +0200
Subject: [PATCH] bug fix for 2GB core limit in 2.4

We were having problems when running programs that used over 2GB of ram
not being able to generate core files over 2GB, these are some very
simple changes that fixed the problem.

The changes have been running on many Debian systems for a couple of
months.  Valid core files just over 3GB have been created without any
problem.

---

 fs/binfmt_elf.c |    2 +-
 fs/exec.c       |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

04d0e7780b49eeef578ceec8901c71ac356df504
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index b0ad905..6c2f357 100644
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
diff --git a/fs/exec.c b/fs/exec.c
index f196e7e..aec92be 100644
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
-- 
1.3.3


