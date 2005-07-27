Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262246AbVG0ONn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262246AbVG0ONn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 10:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVG0ONn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 10:13:43 -0400
Received: from [24.24.2.55] ([24.24.2.55]:18914 "EHLO ms-smtp-01.nyroc.rr.com")
	by vger.kernel.org with ESMTP id S262246AbVG0ONi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 10:13:38 -0400
Subject: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 27 Jul 2005 10:13:15 -0400
Message-Id: <1122473595.29823.60.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following patch makes the MAX_RT_PRIO and MAX_USER_RT_PRIO
configurable from the make *config.  This is more of a proposal since
I'm not really sure where in Kconfig this would best fit. I don't see
why these options shouldn't be user configurable without going into the
kernel headers to change them.

Also, is there a way in the Kconfig to force the checking of
MAX_USER_RT_PRIO <= MAX_RT_PRIO?

-- Steve

(Patched against 2.6.12.2)

Index: vanilla_kernel/include/linux/sched.h
===================================================================
--- vanilla_kernel/include/linux/sched.h	(revision 263)
+++ vanilla_kernel/include/linux/sched.h	(working copy)
@@ -389,9 +389,13 @@
  * MAX_RT_PRIO must not be smaller than MAX_USER_RT_PRIO.
  */
 
-#define MAX_USER_RT_PRIO	100
-#define MAX_RT_PRIO		MAX_USER_RT_PRIO
+#define MAX_USER_RT_PRIO	CONFIG_MAX_USER_RT_PRIO
+#define MAX_RT_PRIO		CONFIG_MAX_RT_PRIO
 
+#if MAX_USER_RT_PRIO > MAX_RT_PRIO
+#error MAX_USER_RT_PRIO must not be greater than MAX_RT_PRIO
+#endif
+
 #define MAX_PRIO		(MAX_RT_PRIO + 40)
 
 #define rt_task(p)		(unlikely((p)->prio < MAX_RT_PRIO))
Index: vanilla_kernel/init/Kconfig
===================================================================
--- vanilla_kernel/init/Kconfig	(revision 263)
+++ vanilla_kernel/init/Kconfig	(working copy)
@@ -162,6 +162,32 @@
 	  building a kernel for install/rescue disks or your system is very
 	  limited in memory.
 
+config MAX_RT_PRIO
+	int "Maximum RT priority"
+	default 100
+	help
+	  The real-time priority of threads that have the policy of SCHED_FIFO
+	  or SCHED_RR have a priority higher than normal threads.  This range
+	  can be set here, where the range starts from 0 to MAX_RT_PRIO-1.
+	  If this range is higher than MAX_USER_RT_PRIO than kernel threads
+	  may have a higher priority than any user thread.
+
+	  This may be the same as MAX_USER_RT_PRIO, but do not set this 
+	  to be less than MAX_USER_RT_PRIO.
+
+config MAX_USER_RT_PRIO
+	int "Maximum User RT priority"
+	default 100
+	help
+	  The real-time priority of threads that have the policy of SCHED_FIFO
+	  or SCHED_RR have a priority higher than normal threads.  This range
+	  can be set here, where the range starts from 0 to MAX_USER_RT_PRIO-1.
+	  If this range is lower than MAX_RT_PRIO, than kernel threads may have
+	  a higher priority than any user thread.
+
+	  This may be the same as MAX_RT_PRIO, but do not set this to be
+	  greater than MAX_RT_PRIO.
+	  
 config AUDIT
 	bool "Auditing support"
 	default y if SECURITY_SELINUX


