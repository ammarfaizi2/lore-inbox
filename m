Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVGMSDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVGMSDL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVGMSDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:03:09 -0400
Received: from [151.97.230.9] ([151.97.230.9]:18156 "EHLO ssc.unict.it")
	by vger.kernel.org with ESMTP id S261704AbVGMSAe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:00:34 -0400
Subject: [patch 1/9] uml: fix lvalue for gcc4
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it,
       rmk+lkml@arm.linux.org.uk
From: blaisorblade@yahoo.it
Date: Wed, 13 Jul 2005 20:02:01 +0200
Message-Id: <20050713180210.7DFF621E72A@zion.home.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>, Russell King <rmk+lkml@arm.linux.org.uk>

This construct is refused by GCC 4, so here's the (corrected) fix. Thanks to
Russell for noticing a stupid mistake I did when first sending this.

As he noted, the code is largely suboptimal however it currently works, and
will be fixed shortly. Just read the access_ok check on
fp which is NULL, or the pointer arithmetic below which should be done with a
cast to void*:

 	frame = (struct rt_sigframe __user *)
 		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;

The code shows clearly that has been taken from
arch/x86_64/kernel/signal.c:setup_rt_frame(), maybe in a bit of a hurry.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-broken-paolo/arch/um/sys-x86_64/signal.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/um/sys-x86_64/signal.c~uml-fix-for-gcc4-lvalue arch/um/sys-x86_64/signal.c
--- linux-2.6.git-broken/arch/um/sys-x86_64/signal.c~uml-fix-for-gcc4-lvalue	2005-07-13 19:30:43.000000000 +0200
+++ linux-2.6.git-broken-paolo/arch/um/sys-x86_64/signal.c	2005-07-13 19:30:44.000000000 +0200
@@ -168,7 +168,7 @@ int setup_signal_stack_si(unsigned long 
 
 	frame = (struct rt_sigframe __user *)
 		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;
-	((unsigned char *) frame) -= 128;
+	frame -= 128 / sizeof(*frame);
 
 	if (!access_ok(VERIFY_WRITE, fp, sizeof(struct _fpstate)))
 		goto out;
_
