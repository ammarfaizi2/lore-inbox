Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbVI1JZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVI1JZ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 05:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751058AbVI1JZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 05:25:59 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:42166 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S1750813AbVI1JZ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 05:25:59 -0400
Date: Wed, 28 Sep 2005 18:25:58 +0900
From: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>
Cc: pj@sgi.com, taka@valinux.co.jp, magnus.damm@gmail.com, dino@in.ibm.com,
       linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: [PATCH][BUG] fix memory leak on reading cpuset files after seeking
 beyond eof
In-Reply-To: <20050927113902.C78A570046@sv1.valinux.co.jp>
References: <20050908225539.0bc1acf6.pj@sgi.com>
	<20050909.203849.33293224.taka@valinux.co.jp>
	<20050909063131.64dc8155.pj@sgi.com>
	<20050910.161145.74742186.taka@valinux.co.jp>
	<20050910015209.4f581b8a.pj@sgi.com>
	<20050926093432.9975870043@sv1.valinux.co.jp>
	<20050927013751.47cbac8b.pj@sgi.com>
	<20050927113902.C78A570046@sv1.valinux.co.jp>
X-Mailer: Sylpheed version 2.1.2+svn (GTK+ 2.6.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20050928092558.61F6170041@sv1.valinux.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2005 20:39:02 +0900
KUROSAWA Takahiro <kurosawa@valinux.co.jp> wrote:

> On Tue, 27 Sep 2005 01:37:51 -0700
> Paul Jackson <pj@sgi.com> wrote:
> 
> > The above reminds me of a bug fix that you provided in the previous
> > patch set, for the case *ppos >= eof.  I wonder if we have duplicated
> > code here.
> Ah, yes, we need to fix the bug in the cpuset code introduced by me...

I fixed the bug.  Sorry for my previous incomplete patch.
The following patch is against linux-2.6.14-rc2.

Signed-off-by: KUROSAWA Takahiro <kurosawa@valinux.co.jp>

--- from-0001/kernel/cpuset.c
+++ to-work/kernel/cpuset.c	2005-09-28 17:42:00.759401736 +0900
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
