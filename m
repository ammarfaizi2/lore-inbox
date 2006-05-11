Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbWEKKHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbWEKKHz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 06:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWEKKHy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 06:07:54 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:46521 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751265AbWEKKHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 06:07:54 -0400
Date: Thu, 11 May 2006 06:07:37 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Andrew Morton <akpm@osdl.org>
cc: Al Viro <viro@ftp.linux.org.uk>, davem@davemloft.net, dwalker@mvista.com,
       alan@lxorguk.ukuu.org.uk, LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH -mm] introduce a false positive macro
In-Reply-To: <Pine.LNX.4.58.0605110400340.1121@gandalf.stny.rr.com>
Message-ID: <Pine.LNX.4.58.0605110558070.4333@gandalf.stny.rr.com>
References: <20060510162106.GC27946@ftp.linux.org.uk> <20060510150321.11262b24.akpm@osdl.org>
 <20060510221024.GH27946@ftp.linux.org.uk> <20060510.153129.122741274.davem@davemloft.net>
 <20060510224549.GI27946@ftp.linux.org.uk> <20060510160548.36e92daf.akpm@osdl.org>
 <20060510232042.GJ27946@ftp.linux.org.uk> <20060510164554.27a13ca9.akpm@osdl.org>
 <20060511012818.GL27946@ftp.linux.org.uk> <Pine.LNX.4.58.0605110400340.1121@gandalf.stny.rr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a patch to introduce a macro that can be used to suppress false
positives caused by GCC and looked at by a developer to turn off the
warning.

It does NOT turn off the warnings by default!!!

This is to give developers that usually ignore all the "uninitialized
variable" warings an opportunity to turn off these warnings to concentrate
on the ones that they make.

The only true arguement against this is that it makes the code not so
pretty.  Otherwise, it causes no more bloat and may even allow those to
debug better.

Now kernel hacking has an option for developers to turn off the warnings
that were looked at and marked.

This patch only introduces the macro.  If it is accepted, then more
patches need to be made to mark the variables.

Even if a variable is marked incorrectly as not a bug, it's still not
bad, in fact, I would say is better.  Only those that need to look at that
that code should keep this off.  Remember, this only turns off the
warnings if you explicitly do so yourself.

-- Steve

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

Index: linux-2.6.17-rc3-mm1/include/linux/types.h
===================================================================
--- linux-2.6.17-rc3-mm1.orig/include/linux/types.h	2006-05-11 05:35:33.000000000 -0400
+++ linux-2.6.17-rc3-mm1/include/linux/types.h	2006-05-11 05:49:06.000000000 -0400
@@ -192,4 +192,15 @@ struct ustat {
 	char			f_fpack[6];
 };

+#ifdef CONFIG_HIDE_FALSE_POSITIVES
+/*
+ *  No parentheses around x = x  because
+ *    int (i=i);
+ *  doesn't compile.
+ */
+# define uninit_var(x) x = x
+#else
+# define uninit_var(x) x
+#endif
+
 #endif /* _LINUX_TYPES_H */
Index: linux-2.6.17-rc3-mm1/lib/Kconfig.debug
===================================================================
--- linux-2.6.17-rc3-mm1.orig/lib/Kconfig.debug	2006-05-11 05:37:58.000000000 -0400
+++ linux-2.6.17-rc3-mm1/lib/Kconfig.debug	2006-05-11 05:48:28.000000000 -0400
@@ -254,6 +254,22 @@ config FORCED_INLINING
 	  become the default in the future, until then this option is there to
 	  test gcc for this.

+config HIDE_FALSE_POSITIVES
+	bool "Hide gcc false positives of unititialized variables"
+	depends on DEBUG_KERNEL
+	help
+	  gcc sometimes shows that a variable is uninitialized when the logic
+	  actually does initialize it before use.  The kernel has lots of these
+	  warnings.  This option hides those warnings that were actually looked
+	  at by a human, and decided (right or wrong) that this variable is indeed
+	  properly initialized.
+
+	  If you are a developer that doesn't care about these warnings, and trust
+	  that the one that marked these variables, did so correctly.  Then you
+	  may turn on this option, to look for your own mistakes.
+
+	  Otherwise, say N
+
 config DEBUG_SYNCHRO_TEST
 	tristate "Synchronisation primitive testing module"
 	depends on DEBUG_KERNEL
