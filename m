Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262658AbTCYN5t>; Tue, 25 Mar 2003 08:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262655AbTCYN5s>; Tue, 25 Mar 2003 08:57:48 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:529 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S261218AbTCYN5q>; Tue, 25 Mar 2003 08:57:46 -0500
To: Richard Henderson <rth@twiddle.net>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] Fix Alpha cond_syscall
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 25 Mar 2003 15:05:46 +0100
Message-ID: <wrpel4vo81x.fsf@hina.wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard,

The recent changes in CONFIG_NET=n handling have broken cond_syscall
implementation on Alpha, since some functions prototypes are visible
in kernel/sys.c, while cond_syscall defines them as x(void).

I used the same method as the other platforms to get rid of the
problem, and added a comment found in asm-v850/unistd.h explaining the
problem.

I'm currently running 2.5.66 with this patch on the Jensen without
problems.

Thanks,

        M.

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1017  -> 1.1018 
#	include/asm-alpha/unistd.h	1.17    -> 1.18   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/03/25	maz@hina.wild-wind.fr.eu.org	1.1018
# Fix alpha cond_syscall to be immune to type-checking.
# --------------------------------------------
#
diff -Nru a/include/asm-alpha/unistd.h b/include/asm-alpha/unistd.h
--- a/include/asm-alpha/unistd.h	Tue Mar 25 14:56:07 2003
+++ b/include/asm-alpha/unistd.h	Tue Mar 25 14:56:07 2003
@@ -612,6 +612,12 @@
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
  * but it doesn't work on all toolchains, so we just do it by hand
  */
+#if 0
+/* This doesn't work if there's a function prototype for NAME visible,
+   because the argument types probably won't match.  */
 #define cond_syscall(x) asmlinkage long x(void) __attribute__((weak,alias("sys_ni_syscall")));
+#else
+#define cond_syscall(x) asm (".weak\t" #x ";\n\t" #x "=sys_ni_syscall");
+#endif
 
 #endif /* _ALPHA_UNISTD_H */

-- 
Places change, faces change. Life is so very strange.
