Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161664AbWAMDWd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161664AbWAMDWd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:22:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161669AbWAMDUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:20:14 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:9857 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1161667AbWAMDUL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:20:11 -0500
Message-Id: <20060113032246.276436000@sorel.sous-sol.org>
References: <20060113032102.154909000@sorel.sous-sol.org>
Date: Thu, 12 Jan 2006 18:37:50 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       "David S. Miller" <davem@davemloft.net>,
       Richard Mortimer <richm@oldelvet.org.uk>
Subject: [PATCH 12/17] [SPARC64]: Fix ptrace/strace
Content-Disposition: inline; filename=sparc64-fix-ptrace.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

Don't clobber register %l0 while checking TI_SYS_NOERROR value in
syscall return path.  This bug was introduced by:

db7d9a4eb700be766cc9f29241483dbb1e748832

Problem narrowed down by Luis F. Ortiz and Richard Mortimer.

I tried using %l2 as suggested by Luis and that works for me.

Looking at the code I wonder if it makes sense to simplify the code
a little bit. The following works for me but I'm not sure how to
exercise the "NOERROR" codepath.

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---

 arch/sparc64/kernel/entry.S |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

Index: linux-2.6.15.y/arch/sparc64/kernel/entry.S
===================================================================
--- linux-2.6.15.y.orig/arch/sparc64/kernel/entry.S
+++ linux-2.6.15.y/arch/sparc64/kernel/entry.S
@@ -1657,13 +1657,10 @@ ret_sys_call:
 	/* Check if force_successful_syscall_return()
 	 * was invoked.
 	 */
-	ldub		[%curptr + TI_SYS_NOERROR], %l0
-	brz,pt		%l0, 1f
-	 nop
-	ba,pt		%xcc, 80f
+	ldub            [%curptr + TI_SYS_NOERROR], %l2
+	brnz,a,pn       %l2, 80f
 	 stb		%g0, [%curptr + TI_SYS_NOERROR]
 
-1:
 	cmp		%o0, -ERESTART_RESTARTBLOCK
 	bgeu,pn		%xcc, 1f
 	 andcc		%l0, (_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT), %l6

--
