Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423060AbWJGCdx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423060AbWJGCdx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 22:33:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423061AbWJGCdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 22:33:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12734 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423060AbWJGCdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 22:33:52 -0400
Date: Fri, 6 Oct 2006 19:33:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       James.Bottomley@HansenPartnership.com
Subject: Re: Merge window closed: v2.6.19-rc1
In-Reply-To: <9a8748490610061547g6c62ee7dq37c139c1966ea8c5@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0610061932280.3952@g5.osdl.org>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
 <9a8748490610061547g6c62ee7dq37c139c1966ea8c5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 7 Oct 2006, Jesper Juhl wrote:
>
> arch/i386/mach-voyager/voyager_basic.c:170: error: conflicting types
> for 'voyager_timer_interrupt'

Gaah. That voyager timer handling is a bit confusing.

Maybe something like this would fix it?

Untested. Need James or the other alledged voyager-owner to actually test 
or do somethign better..

		Linus
---
diff --git a/include/asm-i386/mach-voyager/do_timer.h b/include/asm-i386/mach-voyager/do_timer.h
index 04e69c1..ada5bb9 100644
--- a/include/asm-i386/mach-voyager/do_timer.h
+++ b/include/asm-i386/mach-voyager/do_timer.h
@@ -3,12 +3,13 @@ #include <asm/voyager.h>
 
 static inline void do_timer_interrupt_hook(void)
 {
+	struct pt_regs *regs = get_irq_regs();
 	do_timer(1);
 #ifndef CONFIG_SMP
-	update_process_times(user_mode_vm(irq_regs));
+	update_process_times(user_mode_vm(regs));
 #endif
 
-	voyager_timer_interrupt();
+	voyager_timer_interrupt(regs);
 }
 
 static inline int do_timer_overflow(int count)
diff --git a/include/asm-i386/voyager.h b/include/asm-i386/voyager.h
index e74c54a..fad31ca 100644
--- a/include/asm-i386/voyager.h
+++ b/include/asm-i386/voyager.h
@@ -505,7 +505,7 @@ extern int voyager_memory_detect(int reg
 extern void voyager_smp_intr_init(void);
 extern __u8 voyager_extended_cmos_read(__u16 cmos_address);
 extern void voyager_smp_dump(void);
-extern void voyager_timer_interrupt(void);
+extern void voyager_timer_interrupt(struct pt_regs *);
 extern void smp_local_timer_interrupt(void);
 extern void voyager_power_off(void);
 extern void smp_voyager_power_off(void *dummy);
