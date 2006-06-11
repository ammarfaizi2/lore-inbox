Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161083AbWFKGMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161083AbWFKGMG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 02:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161087AbWFKGMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 02:12:06 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:60304 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161083AbWFKGMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 02:12:05 -0400
Date: Sun, 11 Jun 2006 02:09:42 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: IRQ sharing: BUG: spinlock lockup on CPU#0
To: "Keith Chew" <keith.chew@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200606110211_MC3-1-C21E-301E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20f65d530606080351o1be35d15qc528f40c84e6279e@mail.gmail.com>

On Thu, 8 Jun 2006 22:51:17 +1200, Keith Chew wrote:

> We have updated all the 10 PCs kernel to 2.6.16.18. We only have 1 of
> them running in IOAPIC mode (ie local APIC mode support), the rest are
> in XT-PIC. The APIC machine crashed after 24 hours of operation. Below
> is the stack trace. Is this related to the IO APIC, or should we be
> worried about the XT-PIC machines too?

Something has corrupted memory.  thread_info->task points to a task_struct
at ed103560, but that task_struct->thread_info contains 00000000, its
command-line field (comm) contains junk and its pid is -1.  This is
very hard to diagnose.  Are you using 8K stacks?  Stack overflow is one
possible cause, the other likely one is random memory scribbles.

I've been playing with this patch but it's only boot tested on one config.
It should catch this kind of corruption earlier but I can't easily test
that.

Whether IO-APIC caused this bug or not, it's hard to say...


--- 2.6.17-rc6-nb-post.orig/include/asm-i386/current.h
+++ 2.6.17-rc6-nb-post/include/asm-i386/current.h
@@ -3,6 +3,19 @@
 
 #include <linux/thread_info.h>
 
+#define CONFIG_PARANOID
+#ifdef CONFIG_PARANOID
+
+/* must be a macro or things will get ugly */
+#define get_current()						\
+({								\
+	struct task_struct *task = current_thread_info()->task;	\
+	BUG_ON(task->thread_info != current_thread_info());	\
+	task;							\
+})
+
+#else
+
 struct task_struct;
 
 static __always_inline struct task_struct * get_current(void)
@@ -10,6 +23,8 @@ static __always_inline struct task_struc
 	return current_thread_info()->task;
 }
  
+#endif
+
 #define current get_current()
 
 #endif /* !(_I386_CURRENT_H) */
-- 
Chuck
