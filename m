Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265091AbUG1Vvs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265091AbUG1Vvs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUG1Vup
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:50:45 -0400
Received: from aun.it.uu.se ([130.238.12.36]:49285 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264984AbUG1Vuk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:50:40 -0400
Date: Wed, 28 Jul 2004 23:50:27 +0200 (MEST)
Message-Id: <200407282150.i6SLoRGA016101@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.8-rc2-mm1] x86_64 signal handling fix
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The signal-race-fixes patch in 2.6.8-rc2-mm1 appears to
have broken x86-64's ia32 emulation.

When forcing a SIGSEGV the old code updated "*ka", where
ka was a pointer to current's k_sigaction for SIGSEGV.
Now "ka_copy" points to a copy of that structure, so
assigning "*ka_copy" doesn't do what we want. Instead
do the assignment via current->... just like the normal
signal delivery code does.

/Mikael Pettersson

diff -rupN linux-2.6.8-rc2-mm1/arch/x86_64/ia32/ia32_signal.c linux-2.6.8-rc2-mm1.x86_64-signal-fixes/arch/x86_64/ia32/ia32_signal.c
--- linux-2.6.8-rc2-mm1/arch/x86_64/ia32/ia32_signal.c	2004-07-28 18:51:59.000000000 +0200
+++ linux-2.6.8-rc2-mm1.x86_64-signal-fixes/arch/x86_64/ia32/ia32_signal.c	2004-07-28 23:40:49.107995240 +0200
@@ -495,7 +495,7 @@ void ia32_setup_frame(int sig, struct k_
 
 give_sigsegv:
 	if (sig == SIGSEGV)
-		ka_copy->sa.sa_handler = SIG_DFL;
+		current->sighand->action[SIGSEGV-1].sa.sa_handler = SIG_DFL;
 	signal_fault(regs,frame,"32bit signal deliver");
 }
 
