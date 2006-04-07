Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964826AbWDGRdj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbWDGRdj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 13:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWDGRdj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 13:33:39 -0400
Received: from terminus.zytor.com ([192.83.249.54]:1993 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S964826AbWDGRdi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 13:33:38 -0400
Message-ID: <4436A260.9070603@zytor.com>
Date: Fri, 07 Apr 2006 10:33:20 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, klibc@zytor.com,
       Al Viro <viro@ftp.linux.org.uk>, hpa@zytor.com, miltonm@bga.com
Subject: [PATCH] initramfs: CPIO unpacking fix
References: <20060216183745.50cc2bf6.mikey@neuling.org>	<20060217160621.99b0ffd4.mikey@neuling.org>
In-Reply-To: <20060217160621.99b0ffd4.mikey@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Unlink files, symlinks, FIFOs, devices etc. (except directories) before
writing them when extracting CPIOs.  This stops weird behaviour like:
  1) writing through symlinks created in earlier CPIOs. eg foo->bar in
     the first CPIO.  Having foo as a non-link in a subsequent CPIO,
     results in bar being written and foo remaining as a symlink.
  2) if the first version of file foo is larger than foo in a
     subsequent CPIO, we end up with a mix of the two.  ie. neither
     the first or second version of /foo.
  3) special files like devices, fifo etc. can't be overwritten in
     subsequent CPIOS.

With this, the kernel will more closely replicate
   for i in *.cpio; do cpio --extract --unconditional < $i ; done

This is a change but it's regarded as fixing broken functionality.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Signed-off-by: H. Peter Anvin <hpa@zytor.com>

  init/initramfs.c |    3 +++
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

