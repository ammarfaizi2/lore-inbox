Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261914AbUKPXyR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261914AbUKPXyR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 18:54:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261873AbUKPXYg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 18:24:36 -0500
Received: from fw.osdl.org ([65.172.181.6]:29402 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261889AbUKPXXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 18:23:45 -0500
Date: Tue, 16 Nov 2004 15:23:42 -0800
From: Chris Wright <chrisw@osdl.org>
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] a.out: error check on set_brk
Message-ID: <20041116152342.F2357@build.pdx.osdl.net>
References: <20041116151937.E2357@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041116151937.E2357@build.pdx.osdl.net>; from chrisw@osdl.org on Tue, Nov 16, 2004 at 03:19:37PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible for do_brk() to fail during set_brk() when exec'ing and
a.out.  This was noted with Florian's a.out binary and overcommit set
to 0.  Capture this error and terminate properly.

Signed-off-by: Chris Wright <chrisw@osdl.org>

===== fs/binfmt_aout.c 1.25 vs edited =====
--- 1.25/fs/binfmt_aout.c	2004-10-18 22:26:36 -07:00
+++ edited/fs/binfmt_aout.c	2004-11-11 22:28:58 -08:00
@@ -43,13 +43,18 @@
 	.min_coredump	= PAGE_SIZE
 };
 
-static void set_brk(unsigned long start, unsigned long end)
+#define BAD_ADDR(x)	((unsigned long)(x) >= TASK_SIZE)
+
+static int set_brk(unsigned long start, unsigned long end)
 {
 	start = PAGE_ALIGN(start);
 	end = PAGE_ALIGN(end);
-	if (end <= start)
-		return;
-	do_brk(start, end - start);
+	if (end > start) {
+		unsigned long addr = do_brk(start, end - start);
+		if (BAD_ADDR(addr))
+			return addr;
+	}
+	return 0;
 }
 
 /*
@@ -413,7 +418,11 @@
 beyond_if:
 	set_binfmt(&aout_format);
 
-	set_brk(current->mm->start_brk, current->mm->brk);
+	retval = set_brk(current->mm->start_brk, current->mm->brk);
+	if (retval < 0) {
+		send_sig(SIGKILL, current, 0);
+		return retval;
+	}
 
 	retval = setup_arg_pages(bprm, EXSTACK_DEFAULT);
 	if (retval < 0) { 
