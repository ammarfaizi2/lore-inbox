Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932503AbWBPHhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbWBPHhs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 02:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWBPHhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 02:37:48 -0500
Received: from ozlabs.org ([203.10.76.45]:54466 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932503AbWBPHhs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 02:37:48 -0500
Date: Thu, 16 Feb 2006 18:37:45 +1100
From: Michael Neuling <mikey@neuling.org>
To: Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Chained CPIOs writing to the same file bug
Message-Id: <20060216183745.50cc2bf6.mikey@neuling.org>
X-Mailer: Sylpheed version 2.1.1 (GTK+ 2.8.6; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

You can chain CPIOs together for the initramfs, but if two CPIOs write
to the same file, we don't clear the first before writing the second.
If the first is larger than the second, we end up with a mash of the
two.  Trivial patch below to fix this.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 init/initramfs.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6-linus/init/initramfs.c
===================================================================
--- linux-2.6-linus.orig/init/initramfs.c
+++ linux-2.6-linus/init/initramfs.c
@@ -250,7 +250,8 @@ static int __init do_name(void)
 		return 0;
 	if (S_ISREG(mode)) {
 		if (maybe_link() >= 0) {
-			wfd = sys_open(collected, O_WRONLY|O_CREAT, mode);
+			wfd = sys_open(collected, O_WRONLY|O_CREAT|O_TRUNC,
+				       mode);
 			if (wfd >= 0) {
 				sys_fchown(wfd, uid, gid);
 				sys_fchmod(wfd, mode);
