Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWBUXpS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWBUXpS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:45:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932342AbWBUXpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:45:18 -0500
Received: from ozlabs.org ([203.10.76.45]:53448 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932302AbWBUXpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:45:17 -0500
Date: Wed, 22 Feb 2006 10:45:25 +1100
From: Michael Neuling <mikey@neuling.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, klibc@zytor.com
Cc: Al Viro <viro@ftp.linux.org.uk>, hpa@zytor.com,
       "miltonm@bga.com" <miltonm@bga.com>
Subject: [PATCH] initramfs: multiple CPIO unpacking fix
Message-Id: <20060222104525.affda1df.mikey@neuling.org>
In-Reply-To: <20060217160621.99b0ffd4.mikey@neuling.org>
References: <20060216183745.50cc2bf6.mikey@neuling.org>
	<20060217160621.99b0ffd4.mikey@neuling.org>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch unlinks (deletes) files, symlinks, FIFOs, devices
etc before writing them when extracting CPIOs.  It doesn't delete
directories.  This stops weird behaviour like:
 1) writing through symlinks created in earlier CPIOs. eg foo->bar in
    the first CPIO.  Having foo as a non link in a subsequent CPIO,
    results in bar being written and foo remaining as a symlink.  
 2) if the first version of file foo is larger than foo in a
    subsequent CPIO, we end up with a mix of the two.  ie. neither
    the first or second version of /foo.
 3) special files like devices, fifo etc can't be overwritten in
    subsequent CPIOS.

With this patch, the kernel will more closely replicate
  for i in *.cpio; do cpio --extract --unconditional < $i ; done

This patch doesn't break hardlinks like my previous attempt.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 initramfs.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6.15/init/initramfs.c
===================================================================
--- linux-2.6.15.orig/init/initramfs.c
+++ linux-2.6.15/init/initramfs.c
@@ -249,6 +249,7 @@ static int __init do_name(void)
 	if (dry_run)
 		return 0;
 	if (S_ISREG(mode)) {
+		sys_unlink(collected);
 		if (maybe_link() >= 0) {
 			wfd = sys_open(collected, O_WRONLY|O_CREAT, mode);
 			if (wfd >= 0) {
@@ -263,6 +264,7 @@ static int __init do_name(void)
 		sys_chmod(collected, mode);
 	} else if (S_ISBLK(mode) || S_ISCHR(mode) ||
 		   S_ISFIFO(mode) || S_ISSOCK(mode)) {
+		sys_unlink(collected);
 		if (maybe_link() == 0) {
 			sys_mknod(collected, mode, rdev);
 			sys_chown(collected, uid, gid);
@@ -291,6 +293,7 @@ static int __init do_copy(void)
 static int __init do_symlink(void)
 {
 	collected[N_ALIGN(name_len) + body_len] = '\0';
+	sys_unlink(collected);
 	sys_symlink(collected + N_ALIGN(name_len), collected);
 	sys_lchown(collected, uid, gid);
 	state = SkipIt;


