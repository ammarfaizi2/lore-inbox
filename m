Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932546AbVI3C1c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932546AbVI3C1c (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 22:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932419AbVI3C1F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 22:27:05 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:5845 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932546AbVI3C0o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 22:26:44 -0400
Date: Fri, 30 Sep 2005 03:26:43 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, pj@sgi.com
Subject: [PATCH] cpuset crapectomy
Message-ID: <20050930022643.GA7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Switched cpuset_common_file_read() to simple_read_from_buffer(),
killed a bunch of useless (and not quite correct - e.g. min(size_t,ssize_t))
code.
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-base/kernel/cpuset.c current/kernel/cpuset.c
--- RC14-rc2-git6-base/kernel/cpuset.c	2005-09-28 21:33:37.000000000 -0400
+++ current/kernel/cpuset.c	2005-09-29 16:09:00.000000000 -0400
@@ -968,8 +968,6 @@
 	char *page;
 	ssize_t retval = 0;
 	char *s;
-	char *start;
-	ssize_t n;
 
 	if (!(page = (char *)__get_free_page(GFP_KERNEL)))
 		return -ENOMEM;
@@ -999,15 +997,7 @@
 	*s++ = '\n';
 	*s = '\0';
 
-	start = page + *ppos;
-	n = s - start;
-
-	/* Do nothing if *ppos is at the eof or beyond the eof. */
-	if (n <= 0)
-		goto out;
-
-	retval = n - copy_to_user(buf, start, min(n, nbytes));
-	*ppos += retval;
+	retval = simple_read_from_buffer(buf, nbytes, ppos, page, s - page);
 out:
 	free_page((unsigned long)page);
 	return retval;
