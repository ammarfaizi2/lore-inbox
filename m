Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751709AbWDCJvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbWDCJvY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 05:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751710AbWDCJvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 05:51:24 -0400
Received: from gaz.sfgoth.com ([69.36.241.230]:51414 "EHLO gaz.sfgoth.com")
	by vger.kernel.org with ESMTP id S1751708AbWDCJvY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 05:51:24 -0400
Date: Mon, 3 Apr 2006 02:55:30 -0700
From: Mitchell Blank Jr <mitch@sfgoth.com>
To: Andrew Morton <akpm@osdl.org>
Cc: kaos@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc1 core_sys_select incompatible pointer types
Message-ID: <20060403095530.GE3157@gaz.sfgoth.com>
References: <25355.1144052926@kao2.melbourne.sgi.com> <20060403084410.GD3157@gaz.sfgoth.com> <20060403020916.57c9eaec.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060403020916.57c9eaec.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.2.2 (gaz.sfgoth.com [127.0.0.1]); Mon, 03 Apr 2006 02:55:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Nope.  I queued up the below.  If anything additional is needed, please
> resend.

Could you at least apply this bit on top?  I actually combed select.c
yesterday and have a bunch of changes, but I can send those to you as a
patch series later.  This one I'd like to land now since it fixes a bug
introduced within the last week (even though the bug isn't currently
triggerable)

The code is (very slightly) rearranged; should be a little more readable
and quicker for the fastpath.

Subject: [SELECT] don't overflow if (SELECT_STACK_ALLOC % sizeof(long) != 0)

If SELECT_STACK_ALLOC is not a multiple of sizeof(long) then stack_fds[]
would be shorter than SELECT_STACK_ALLOC bytes and could overflow later
in the function.  Fixed by simply rearranging the test later to work on
sizeof(stack_fds)  Currently SELECT_STACK_ALLOC is 256 so this doesn't happen,
but it's nasty to have things like this hidden in the code.  What if later
someone decides to change SELECT_STACK_ALLOC to 300?

Signed-off-by: Mitchell Blank Jr <mitch@sfgoth.com>

--- linux-2.6/fs/select.c-AKPM	2006-04-03 02:25:34.000000000 -0700
+++ linux-2.6/fs/select.c	2006-04-03 02:32:53.000000000 -0700
@@ -311,7 +311,8 @@
 {
 	fd_set_bits fds;
 	void *bits;
-	int ret, size, max_fdset;
+	int ret, max_fdset;
+	unsigned int size;
 	struct fdtable *fdt;
 	/* Allocate small arguments on the stack to save memory and be faster */
 	long stack_fds[SELECT_STACK_ALLOC/sizeof(long)];
@@ -333,14 +334,15 @@
 	 * since we used fdset we need to allocate memory in units of
 	 * long-words. 
 	 */
-	ret = -ENOMEM;
 	size = FDS_BYTES(n);
-	if (6*size < SELECT_STACK_ALLOC)
-		bits = stack_fds;
-	else
+	bits = stack_fds;
+	if (size > sizeof(stack_fds) / 6) {
+		/* Not enough space in on-stack array; must use kmalloc */
+		ret = -ENOMEM;
 		bits = kmalloc(6 * size, GFP_KERNEL);
-	if (!bits)
-		goto out_nofds;
+		if (!bits)
+			goto out_nofds;
+	}
 	fds.in      = bits;
 	fds.out     = bits +   size;
 	fds.ex      = bits + 2*size;
