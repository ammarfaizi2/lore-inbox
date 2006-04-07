Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWDGPh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWDGPh3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 11:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964809AbWDGPh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 11:37:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:9 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964808AbWDGPh2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 11:37:28 -0400
Date: Fri, 7 Apr 2006 16:37:15 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Fix warning in fs/select.c
Message-ID: <20060407153715.GA31458@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/select.c: In function `core_sys_select':
fs/select.c:339: warning: assignment from incompatible pointer type
fs/select.c:376: warning: comparison of distinct pointer types lacks a cast

	char *bits;
	long stack_fds[SELECT_STACK_ALLOC/sizeof(long)];
...
		bits = stack_fds;
...
        if (bits != stack_fds)

Fix this warning by calculating the number of longs we need for 'n' fds.
This then allows us to do correct pointer arithmetic with the minimum
of fuss.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff --git a/fs/select.c b/fs/select.c
--- a/fs/select.c
+++ b/fs/select.c
@@ -310,8 +310,8 @@ static int core_sys_select(int n, fd_set
 			   fd_set __user *exp, s64 *timeout)
 {
 	fd_set_bits fds;
-	char *bits;
-	int ret, size, max_fdset;
+	long *bits;
+	int ret, size_longs, max_fdset;
 	struct fdtable *fdt;
 	/* Allocate small arguments on the stack to save memory and be faster */
 	long stack_fds[SELECT_STACK_ALLOC/sizeof(long)];
@@ -334,19 +334,19 @@ static int core_sys_select(int n, fd_set
 	 * long-words. 
 	 */
 	ret = -ENOMEM;
-	size = FDS_BYTES(n);
-	if (6*size < SELECT_STACK_ALLOC)
+	size_longs = FDS_LONGS(n);
+	if (6 * size_longs * sizeof(long) < SELECT_STACK_ALLOC)
 		bits = stack_fds;
 	else
-		bits = kmalloc(6 * size, GFP_KERNEL);
+		bits = kmalloc(6 * size_longs * sizeof(long), GFP_KERNEL);
 	if (!bits)
 		goto out_nofds;
-	fds.in      = (unsigned long *)  bits;
-	fds.out     = (unsigned long *) (bits +   size);
-	fds.ex      = (unsigned long *) (bits + 2*size);
-	fds.res_in  = (unsigned long *) (bits + 3*size);
-	fds.res_out = (unsigned long *) (bits + 4*size);
-	fds.res_ex  = (unsigned long *) (bits + 5*size);
+	fds.in      = bits;
+	fds.out     = bits +     size_longs;
+	fds.ex      = bits + 2 * size_longs;
+	fds.res_in  = bits + 3 * size_longs;
+	fds.res_out = bits + 4 * size_longs;
+	fds.res_ex  = bits + 5 * size_longs;
 
 	if ((ret = get_fd_set(n, inp, fds.in)) ||
 	    (ret = get_fd_set(n, outp, fds.out)) ||

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
