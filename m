Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262309AbVAEJ6B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262309AbVAEJ6B (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 04:58:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262310AbVAEJ6B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 04:58:01 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:32406 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262309AbVAEJ56 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 04:57:58 -0500
Subject: [PATCH] oprofile: fix ia64 callgraph bug with old gcc
From: Greg Banks <gnb@melbourne.sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Keith Owens <kaos@sgi.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       OProfile List <oprofile-list@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="=-jDhMDMrJtHty4RnqOOE8"
Organization: Silicon Graphics Inc, Australian Software Group.
Message-Id: <1104919059.10291.246.camel@hole.melbourne.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 05 Jan 2005 20:57:40 +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-jDhMDMrJtHty4RnqOOE8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

G'day,

This patch from Keith Owens fixes a bug in the ia64 port
of oprofile when built without the kdb patch and with a
pre-3.4 gcc.

Greg.
-- 
Greg Banks, R&D Software Engineer, SGI Australian Software Group.
I don't speak for SGI.


--=-jDhMDMrJtHty4RnqOOE8
Content-Disposition: attachment; filename=oprofile-ia64-gcc-pre-34-fix
Content-Type: text/plain; name=oprofile-ia64-gcc-pre-34-fix; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

If you build a standard kernel with gcc < 3.4 then
ia64_spinlock_contention_pre3_4 is defined.  But a standard kernel
does not have ia64_spinlock_contention_pre3_4_end, that label is
only added by the kdb patch.  To get the backtrace profiling with
gcc < 3.4, the _end label needs to be added as part of the kernprof
patch, then I will remove it from kdb.  Send this to akpm.

From: Keith Owens <kaos@sgi.com>
Signed-off-by: Keith Owens <kaos@sgi.com>
Signed-off-by: Greg Banks <gnb@melbourne.sgi.com>

Index: linux/arch/ia64/kernel/head.S
===================================================================
--- linux.orig/arch/ia64/kernel/head.S	2004-10-19 07:54:38.000000000 +1000
+++ linux/arch/ia64/kernel/head.S	2005-01-05 20:37:23.000000000 +1100
@@ -949,6 +949,8 @@ GLOBAL_ENTRY(ia64_spinlock_contention_pr
 (p14)	br.cond.sptk.few .wait
 (p15)	rsm psr.i		// disable interrupts if we reenabled them
 	br.cond.sptk.few b6	// lock is now free, try to acquire
+	.global ia64_spinlock_contention_pre3_4_end	// for kernprof
+ia64_spinlock_contention_pre3_4_end:
 END(ia64_spinlock_contention_pre3_4)
 
 #else

--=-jDhMDMrJtHty4RnqOOE8--

