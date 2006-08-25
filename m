Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932296AbWHYJBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932296AbWHYJBk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 05:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWHYJBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 05:01:40 -0400
Received: from cantor.suse.de ([195.135.220.2]:6378 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751356AbWHYJBk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 05:01:40 -0400
From: Andi Kleen <ak@suse.de>
To: akpm@osdl.org
Subject: [PATCH -mm] Disable core ulimit for user core process
Date: Fri, 25 Aug 2006 11:01:35 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608251101.35877.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I can't remember if I already sent this one off or not. If yes
please ignore the dup.]
[This is an incremental patch for the user-core patch series which
is in -mm]

Disable core files for pipe user helpers

This addresses one of the review comments earlier for the user core
patchkit: when the core dump handler is executed make sure there
is no potential for recursion in case it crashes again.

This currently does it for all pipe user mode helpers. In theory
it could be done only for core dump user helpers, but there are
currently no other users of this function.

Signed-off-by: Andi Kleen <ak@suse.de>

Index: linux/kernel/kmod.c
===================================================================
--- linux.orig/kernel/kmod.c
+++ linux/kernel/kmod.c
@@ -35,6 +35,7 @@
 #include <linux/mount.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/resource.h>
 #include <asm/uaccess.h>
 
 extern int max_threads;
@@ -158,6 +159,9 @@ static int ____call_usermodehelper(void 
 		FD_SET(0, fdt->open_fds);
 		FD_CLR(0, fdt->close_on_exec);
 		spin_unlock(&f->file_lock);
+
+		/* and disallow core files too */
+		current->signal->rlim[RLIMIT_CORE] = (struct rlimit){0, 0};
 	}
 
 	/* We can run anywhere, unlike our parent keventd(). */
