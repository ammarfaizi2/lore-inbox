Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbUKXAqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbUKXAqT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 19:46:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbUKXApU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 19:45:20 -0500
Received: from mail.dif.dk ([193.138.115.101]:62692 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261404AbUKXAnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 19:43:08 -0500
Date: Wed, 24 Nov 2004 01:52:41 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] remove errornous semicolon in arch/i386/kernel/traps.c::do_general_protection
Message-ID: <Pine.LNX.4.61.0411240139240.3389@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Building with gcc -W revealed this warning:
arch/i386/kernel/traps.c: In function `do_general_protection':
arch/i386/kernel/traps.c:506: warning: empty body in an if-statement

upon inspecting the code I see what looks like a mistakenly placed ";"

        if (!fixup_exception(regs)) {
                if (notify_die(DIE_GPF, "general protection fault", regs,
                                error_code, 13, SIGSEGV) == NOTIFY_STOP);
                        return;
                die("general protection fault", regs, error_code);
        }

Shouldn't that ";" after the second  if  go away so the  return;  before 
die() is not unconditional?

The following patch would seem to make sense to me, but if I'm 
misunderstanding something feel free to let me know :)

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc2-bk8-orig/arch/i386/kernel/traps.c linux-2.6.10-rc2-bk8/arch/i386/kernel/traps.c
--- linux-2.6.10-rc2-bk8-orig/arch/i386/kernel/traps.c	2004-11-24 01:24:41.000000000 +0100
+++ linux-2.6.10-rc2-bk8/arch/i386/kernel/traps.c	2004-11-24 01:47:27.000000000 +0100
@@ -504,7 +504,7 @@ gp_in_vm86:
 gp_in_kernel:
 	if (!fixup_exception(regs)) {
 		if (notify_die(DIE_GPF, "general protection fault", regs,
-				error_code, 13, SIGSEGV) == NOTIFY_STOP);
+				error_code, 13, SIGSEGV) == NOTIFY_STOP)
 			return;
 		die("general protection fault", regs, error_code);
 	}



