Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751679AbWDCJKG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbWDCJKG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 05:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbWDCJKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 05:10:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:54755 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751679AbWDCJKF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 05:10:05 -0400
Date: Mon, 3 Apr 2006 02:09:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mitchell Blank Jr <mitch@sfgoth.com>
Cc: kaos@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc1 core_sys_select incompatible pointer types
Message-Id: <20060403020916.57c9eaec.akpm@osdl.org>
In-Reply-To: <20060403084410.GD3157@gaz.sfgoth.com>
References: <25355.1144052926@kao2.melbourne.sgi.com>
	<20060403084410.GD3157@gaz.sfgoth.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mitchell Blank Jr <mitch@sfgoth.com> wrote:
>
>  Keith Owens wrote:
>  > 2.6.17-rc1, ia64, gcc 3.3.3
>  > 
>  > fs/select.c: In function `core_sys_select':
>  > fs/select.c:339: warning: assignment from incompatible pointer type
>  > fs/select.c:376: warning: comparison of distinct pointer types lacks a cast
> 
>  I posted a patch to fix this and another problem with the recent select
>  changes a couple days ago.
> 
>  Original version, with description:
>    http://lkml.org/lkml/2006/3/31/308
>  Slightly updated:
>    http://lkml.org/lkml/2006/3/31/316
> 
>  I'm hoping that Andrew picked it up.

Nope.  I queued up the below.  If anything additional is needed, please
resend.


diff -puN fs/select.c~select-warning-fixes fs/select.c
--- devel/fs/select.c~select-warning-fixes	2006-04-01 22:27:14.000000000 -0800
+++ devel-akpm/fs/select.c	2006-04-01 22:28:50.000000000 -0800
@@ -310,7 +310,7 @@ static int core_sys_select(int n, fd_set
 			   fd_set __user *exp, s64 *timeout)
 {
 	fd_set_bits fds;
-	char *bits;
+	void *bits;
 	int ret, size, max_fdset;
 	struct fdtable *fdt;
 	/* Allocate small arguments on the stack to save memory and be faster */
@@ -341,12 +341,12 @@ static int core_sys_select(int n, fd_set
 		bits = kmalloc(6 * size, GFP_KERNEL);
 	if (!bits)
 		goto out_nofds;
-	fds.in      = (unsigned long *)  bits;
-	fds.out     = (unsigned long *) (bits +   size);
-	fds.ex      = (unsigned long *) (bits + 2*size);
-	fds.res_in  = (unsigned long *) (bits + 3*size);
-	fds.res_out = (unsigned long *) (bits + 4*size);
-	fds.res_ex  = (unsigned long *) (bits + 5*size);
+	fds.in      = bits;
+	fds.out     = bits +   size;
+	fds.ex      = bits + 2*size;
+	fds.res_in  = bits + 3*size;
+	fds.res_out = bits + 4*size;
+	fds.res_ex  = bits + 5*size;
 
 	if ((ret = get_fd_set(n, inp, fds.in)) ||
 	    (ret = get_fd_set(n, outp, fds.out)) ||
_

