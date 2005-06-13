Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbVFMURq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbVFMURq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 16:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVFMUPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 16:15:37 -0400
Received: from nevyn.them.org ([66.93.172.17]:38346 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S261266AbVFMUN4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 16:13:56 -0400
Date: Mon, 13 Jun 2005 16:13:47 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc6-git6] Fix large core dumps with a 32-bit off_t
Message-ID: <20050613201347.GA4617@nevyn.them.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ELF core dump code has one use of off_t when writing out segments.  Some
of the segments may be passed the 2GB limit of an off_t, even on a 32-bit
system, so it's important to use loff_t instead.  This fixes a corrupted
core dump in the bigcore test in GDB's testsuite.

Signed-off-by: Daniel Jacobowitz <dan@codesourcery.com>

Index: linux-2.6.11/fs/binfmt_elf.c
===================================================================
--- linux-2.6.11.orig/fs/binfmt_elf.c	2005-06-09 16:38:17.000000000 -0400
+++ linux-2.6.11/fs/binfmt_elf.c	2005-06-10 00:10:52.000000000 -0400
@@ -1125,7 +1125,7 @@ static int dump_write(struct file *file,
 	return file->f_op->write(file, addr, nr, &file->f_pos) == nr;
 }
 
-static int dump_seek(struct file *file, off_t off)
+static int dump_seek(struct file *file, loff_t off)
 {
 	if (file->f_op->llseek) {
 		if (file->f_op->llseek(file, off, 0) != off)

-- 
Daniel Jacobowitz
CodeSourcery, LLC
