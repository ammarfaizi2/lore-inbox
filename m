Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUJESwQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUJESwQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 14:52:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263664AbUJESwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 14:52:16 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:25742 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261234AbUJESwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 14:52:13 -0400
Date: Tue, 5 Oct 2004 20:52:14 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Message-ID: <20041005185214.GA3691@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Subject: [PATCH] Console: fall back to /dev/null when no console is availlable
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Rcpt-To: akpm@osdl.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: joern@wohnheim.fh-wedel.de
X-SA-Exim-Version: 3.1 (built Son Feb 22 10:54:36 CET 2004)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks pretty trivial, but opinions on this subject may vary.
Comments?

Jörn

-- 
More computing sins are committed in the name of efficiency (without
necessarily achieving it) than for any other single reason - including
blind stupidity.
-- W. A. Wulf 

Some userspace applications rely on the assumption that fd's 0, 1 and
2 are always open and function as raw stdin, stdout and stderr,
respectively.

With no console registered, init get's called without those fd's
already open.  Arguably, init should know better, handle that case and
fix things before forking other processed.  But what about
init=/bin/bash?  Ok, bash could be fixed as well, as could...

Instead, this patch opens /dev/null when /dev/console doesn't work.
It swallows all output and doesn't give much input, but programs can
handle that just fine.

Signed-off-by: Jörn Engel <joern@wohnheim.fh-wedel.de>
---

 main.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

--- linux-2.6.8cow/init/main.c~console	2004-10-05 20:46:40.000000000 +0200
+++ linux-2.6.8cow/init/main.c	2004-10-05 20:46:08.000000000 +0200
@@ -695,8 +695,11 @@
 	system_state = SYSTEM_RUNNING;
 	numa_default_policy();
 
-	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0)
+	if (sys_open((const char __user *) "/dev/console", O_RDWR, 0) < 0) {
 		printk("Warning: unable to open an initial console.\n");
+		if (open("/dev/null", O_RDWR, 0) == 0)
+			printk("         Falling back to /dev/null.\n");
+	}
 
 	(void) sys_dup(0);
 	(void) sys_dup(0);
