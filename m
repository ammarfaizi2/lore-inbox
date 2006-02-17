Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWBQCxq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWBQCxq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 21:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWBQCxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 21:53:45 -0500
Received: from cabal.ca ([134.117.69.58]:29843 "EHLO fattire.cabal.ca")
	by vger.kernel.org with ESMTP id S1750950AbWBQCxp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 21:53:45 -0500
Date: Thu, 16 Feb 2006 21:52:42 -0500
From: Kyle McMartin <kyle@parisc-linux.org>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Generic is_compat_task helper
Message-ID: <20060217025242.GM13492@quicksilver.road.mcmartin.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a generic is_compat_task function. It should only be used
when absolutely necessary. For example, to clean up the per-architecture
tests in drivers/input/evdev.c.

Prototype is such that the existing asm-x86_64 helper needs no change.

Architecture maintainers must add an appropriate implementation to
asm/compat.h, if needed.

Signed-off-by: Kyle McMartin <kyle@parisc-linux.org>

---

Yeah, this can be abused... but, blocks like:

#ifdef CONFIG_X86_64
#  define COMPAT_TEST is_compat_task()
#elif defined(CONFIG_IA64)
#  define COMPAT_TEST IS_IA32_PROCESS(task_pt_regs(current))
#elif defined(CONFIG_S390)
#  define COMPAT_TEST test_thread_flag(TIF_31BIT)
#elif defined(CONFIG_MIPS)
#  define COMPAT_TEST (current->thread.mflags & MF_32BIT_ADDR)
#else
#  define COMPAT_TEST test_thread_flag(TIF_32BIT)
#endif

from drivers/input/evdev.c are worse. This style of block also appeared
in a patch on netdev recently...

I think everyone can agree centralizing this is probably better than
the current state of affairs.

diff --git a/include/asm-parisc/compat.h b/include/asm-parisc/compat.h
index 38b918f..a5eb7cd 100644
--- a/include/asm-parisc/compat.h
+++ b/include/asm-parisc/compat.h
@@ -5,6 +5,7 @@
  */
 #include <linux/types.h>
 #include <linux/sched.h>
+#include <linux/personality.h>
 
 #define COMPAT_USER_HZ 100
 
@@ -144,4 +145,14 @@ static __inline__ void __user *compat_al
 	return (void __user *)regs->gr[30];
 }
 
+static inline int __is_compat_task(struct task_struct *t)
+{
+	return (personality(t->personality) == PER_LINUX32);
+}
+
+static inline int is_compat_task(void)
+{
+	return __is_compat_task(current);
+}
+
 #endif /* _ASM_PARISC_COMPAT_H */
diff --git a/include/linux/compat.h b/include/linux/compat.h
index c9ab2a2..d2e0ea9 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -181,5 +181,12 @@ static inline int compat_timespec_compar
 	return lhs->tv_nsec - rhs->tv_nsec;
 }
 
+#else /* !CONFIG_COMPAT */
+
+static inline int is_compat_task(void)
+{
+	return 0;
+}
+
 #endif /* CONFIG_COMPAT */
 #endif /* _LINUX_COMPAT_H */
