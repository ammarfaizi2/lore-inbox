Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290741AbSBLCx2>; Mon, 11 Feb 2002 21:53:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290743AbSBLCxS>; Mon, 11 Feb 2002 21:53:18 -0500
Received: from zero.tech9.net ([209.61.188.187]:38408 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290741AbSBLCxE>;
	Mon, 11 Feb 2002 21:53:04 -0500
Subject: Re: Linux 2.5.4-dj1
From: Robert Love <rml@tech9.net>
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020212013034.A14368@suse.de>
In-Reply-To: <20020212013034.A14368@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 11 Feb 2002 21:53:08 -0500
Message-Id: <1013482389.6781.645.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-02-11 at 20:30, Dave Jones wrote:

> o   Fix UP Preempt compilation.			(Mikael Pettersson)

I ended up sending the following patch to Linus instead.

Would you merge this into your next release, so we can keep the trees in
sync (and not inadvertently push your fix over Linus's later on).  This
approach removes the conditional altogether in the UP+preempt case, so
it is optimal.

Thanks, 

	Robert Love

diff -urN linux-2.5.4-dj1/include/asm-i386/smplock.h linux/include/asm-i386/smplock.h
--- linux-2.5.4-dj1/include/asm-i386/smplock.h	Sun Feb 10 20:50:13 2002
+++ linux/include/asm-i386/smplock.h	Mon Feb 11 21:34:18 2002
@@ -12,10 +12,15 @@
 
 #ifdef CONFIG_SMP
 #define kernel_locked()		spin_is_locked(&kernel_flag)
+#define check_irq_holder(cpu) \
+do { \
+	if (global_irq_holder == (cpu)) \
+		BUG(); \
+} while(0)
 #else
 #ifdef CONFIG_PREEMPT
 #define kernel_locked()		preempt_get_count()
-#define global_irq_holder      0xFF    /* NO_PROC_ID */
+#define check_irq_holder(cpu)	do { } while(0)
 #else
 #define kernel_locked()		1
 #endif
@@ -28,8 +33,7 @@
 do {						\
 	if (unlikely(task->lock_depth >= 0)) {	\
 		spin_unlock(&kernel_flag);	\
-		if (global_irq_holder == (cpu))	\
-			BUG();			\
+		check_irq_holder(cpu);		\
 	}					\
 } while (0)
 


