Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262686AbUJ1Bns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262686AbUJ1Bns (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 21:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbUJ1Bns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 21:43:48 -0400
Received: from fw.osdl.org ([65.172.181.6]:11402 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262686AbUJ1Bnk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 21:43:40 -0400
Date: Wed, 27 Oct 2004 18:43:39 -0700
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] error out on execve with no binfmts
Message-ID: <20041027184339.M2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Early calls to userspace can invoke an execve() before any binfmt handlers
are registered.  Properly return an error in this case rather than 0.
On at least one arch (x86_64) without this patch, the system will double
fault on early attempts to call_usermodehelper.  Suggestions on a better
error?

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== fs/exec.c 1.142 vs edited =====
--- 1.142/fs/exec.c	2004-10-22 21:23:42 -07:00
+++ edited/fs/exec.c	2004-10-27 18:11:54 -07:00
@@ -984,7 +984,7 @@
  */
 int search_binary_handler(struct linux_binprm *bprm,struct pt_regs *regs)
 {
-	int try,retval=0;
+	int try,retval;
 	struct linux_binfmt *fmt;
 #ifdef __alpha__
 	/* handle /sbin/loader.. */
@@ -1028,6 +1028,7 @@
 	/* kernel module loader fixup */
 	/* so we don't try to load run modprobe in kernel space. */
 	set_fs(USER_DS);
+	retval = -ENOENT;
 	for (try=0; try<2; try++) {
 		read_lock(&binfmt_lock);
 		for (fmt = formats ; fmt ; fmt = fmt->next) {
