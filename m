Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbVI1NnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbVI1NnO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 09:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbVI1NnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 09:43:14 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:56798 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1750968AbVI1NnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 09:43:13 -0400
Date: Wed, 28 Sep 2005 06:42:24 -0700
From: Paul Jackson <pj@sgi.com>
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Cc: kurosawa@valinux.co.jp, taka@valinux.co.jp, magnus.damm@gmail.com,
       dino@in.ibm.com, linux-kernel@vger.kernel.org,
       ckrm-tech@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] cpuset read past eof memory leak fix
Message-Id: <20050928064224.49170ca7.pj@sgi.com>
In-Reply-To: <20050928092558.61F6170041@sv1.valinux.co.jp>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
	<20050927013751.47cbac8b.pj@sgi.com>
	<20050927113902.C78A570046@sv1.valinux.co.jp>
	<20050928092558.61F6170041@sv1.valinux.co.jp>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't leak a page of memory if user reads a cpuset file past eof.

Signed-off-by: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Signed-off-by: Paul Jackson <pj@sgi.com>

--- linux-2.6.14-rc2.orig/kernel/cpuset.c
+++ linux-2.6.14-rc2/kernel/cpuset.c	2005-09-28 17:42:00.759401736 +0900
@@ -969,7 +969,7 @@ static ssize_t cpuset_common_file_read(s
 	ssize_t retval = 0;
 	char *s;
 	char *start;
-	size_t n;
+	ssize_t n;
 
 	if (!(page = (char *)__get_free_page(GFP_KERNEL)))
 		return -ENOMEM;
@@ -999,12 +999,13 @@ static ssize_t cpuset_common_file_read(s
 	*s++ = '\n';
 	*s = '\0';
 
-	/* Do nothing if *ppos is at the eof or beyond the eof. */
-	if (s - page <= *ppos)
-		return 0;
-
 	start = page + *ppos;
 	n = s - start;
+
+	/* Do nothing if *ppos is at the eof or beyond the eof. */
+	if (n <= 0)
+		goto out;
+
 	retval = n - copy_to_user(buf, start, min(n, nbytes));
 	*ppos += retval;
 out:


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
