Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbULTXZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbULTXZr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:25:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbULTXZr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 18:25:47 -0500
Received: from mail.dif.dk ([193.138.115.101]:44168 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261706AbULTXXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 18:23:08 -0500
Date: Tue, 21 Dec 2004 00:33:49 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] kill access_ok() call from copy_siginfo_to_user() that we
 might as well avoid.
Message-ID: <Pine.LNX.4.61.0412210025100.3581@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

In kernel/signal.c::copy_siginfo_to_user() we are calling access_ok() 
unconditionally. As I see it there's no need for this since we might as 
well just call copy_to_user() instead of __copy_to_user() later on and 
then only get the overhead of the access_ok() check (inside 
copy_to_user()) when the  if (from->si_code < 0)  branch is actually taken.
In the case where the branch is taken the cost is the same, but when the 
branch is not taken this patch will save us an access_ok() call.

Comments are always welcome.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc3-bk13-orig/kernel/signal.c linux-2.6.10-rc3-bk13/kernel/signal.c
--- linux-2.6.10-rc3-bk13-orig/kernel/signal.c	2004-12-06 22:24:56.000000000 +0100
+++ linux-2.6.10-rc3-bk13/kernel/signal.c	2004-12-21 00:23:46.000000000 +0100
@@ -2070,10 +2070,8 @@ int copy_siginfo_to_user(siginfo_t __use
 {
 	int err;
 
-	if (!access_ok (VERIFY_WRITE, to, sizeof(siginfo_t)))
-		return -EFAULT;
 	if (from->si_code < 0)
-		return __copy_to_user(to, from, sizeof(siginfo_t))
+		return copy_to_user(to, from, sizeof(siginfo_t))
 			? -EFAULT : 0;
 	/*
 	 * If you change siginfo_t structure, please be sure




