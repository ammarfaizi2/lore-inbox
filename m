Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261229AbVCMNca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261229AbVCMNca (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 08:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVCMNca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 08:32:30 -0500
Received: from mail.dif.dk ([193.138.115.101]:53664 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261229AbVCMNcY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 08:32:24 -0500
Date: Sun, 13 Mar 2005 14:33:46 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH][2.6.11-mm3] Warning fix and be extra careful about array in
 kernel/module.c
Message-ID: <Pine.LNX.4.62.0503131412070.2501@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fix warning in kernel/module.c::who_is_doing_it()
kernel/module.c:1405: warning: ignoring return value of `copy_from_user', declared with attribute warn_unused_result
by subtracting copy_from_user return value from 'len' - if we copy less 
data than we intend there's no point in looping over more than we actually 
copy.
I've also changed the type of 'len' and 'i' from unsigned int to 
unsigned long since that's the type of mm_struct.arg_start/arg_end and 
it's also the type of the last argument to copy_from_user. Sure, it'll be 
promoted and truncated between int/long just fine, but it seems cleaner to 
me that it's just the same type all the way.
I also added an explicit check of the value of 'len' after the calcolation 
of arg_start - arg_end since they are both long values subtracting one 
from the other could theoretically ield a value larger than 512 and such a 
value would cause us to overflow our statically allocated array. I don't 
know if that can actually ever occour, I don't know the code that well, 
but I thought it would be better to be safe than sorry.

The code compiles and I've been running the kernel with this change for a 
few hrs, but that's all the testing I've done.

If this seems OK to you, please consider merging it. If there's something 
wrong with it I'm always looking forward to being enlightened.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.11-mm3-orig/kernel/module.c linux-2.6.11-mm3/kernel/module.c
--- linux-2.6.11-mm3-orig/kernel/module.c	2005-03-13 00:52:51.000000000 +0100
+++ linux-2.6.11-mm3/kernel/module.c	2005-03-13 01:51:11.000000000 +0100
@@ -1400,9 +1400,12 @@ static void who_is_doing_it(void)
 {
 	/* Print out all the args. */
 	char args[512];
-	unsigned int i, len = current->mm->arg_end - current->mm->arg_start;
+	unsigned long i, len = current->mm->arg_end - current->mm->arg_start;
 
-	copy_from_user(args, (void *)current->mm->arg_start, len);
+	if (len > 512)
+		len = 512;
+
+	len -= copy_from_user(args, (void *)current->mm->arg_start, len);
 
 	for (i = 0; i < len; i++) {
 		if (args[i] == '\0')



