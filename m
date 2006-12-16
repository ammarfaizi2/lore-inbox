Return-Path: <linux-kernel-owner+w=401wt.eu-S965232AbWLPBH1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965232AbWLPBH1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 20:07:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965281AbWLPBH1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 20:07:27 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33410 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965232AbWLPBH0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 20:07:26 -0500
Date: Sat, 16 Dec 2006 01:07:02 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: rmk@arm.linux.org.uk, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>, Dirk@Opfer-Online.de,
       arminlitzel@web.de, pavel.urban@ct.cz, metan@seznam.cz
Subject: Re: Nasty warnings on arm (+ one compile problem -- INIT_WORK related)
Message-ID: <20061216010702.GB17561@ftp.linux.org.uk>
References: <20061215235818.GD2853@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061215235818.GD2853@elf.ucw.cz>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 16, 2006 at 12:58:18AM +0100, Pavel Machek wrote:
> Hi!
> 
> I get nasty warning for each file compiled:
> 
>   CC      drivers/video/sa1100fb.o
> In file included from include/asm/bitops.h:23,
>                  from include/linux/bitops.h:9,
>                  from include/linux/thread_info.h:20,
>                  from include/linux/preempt.h:9,
>                  from include/linux/spinlock.h:49,
>                  from include/linux/module.h:9,
>                  from drivers/video/sa1100fb.c:163:
> include/asm/system.h: In function `adjust_cr':
> include/asm/system.h:185: warning: implicit declaration of function
> `local_irq_save'
> include/asm/system.h:192: warning: implicit declaration of function
> `local_irq_restore'
> include/asm/system.h:179: warning: unused variable `cr'

That's dealt with by the following:

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
diff --git a/include/asm-arm/system.h b/include/asm-arm/system.h
index e160aeb..bf44782 100644
--- a/include/asm-arm/system.h
+++ b/include/asm-arm/system.h
@@ -173,10 +173,12 @@ static inline void set_copro_access(unsi
 extern unsigned long cr_no_alignment;	/* defined in entry-armv.S */
 extern unsigned long cr_alignment;	/* defined in entry-armv.S */
 
+#include <linux/irqflags.h>
+
 #ifndef CONFIG_SMP
 static inline void adjust_cr(unsigned long mask, unsigned long set)
 {
-	unsigned long flags, cr;
+	unsigned long flags;
 
 	mask &= ~CR_A;
 
@@ -248,8 +250,6 @@ static inline void sched_cacheflush(void
 {
 }
 
-#include <linux/irqflags.h>
-
 #ifdef CONFIG_SMP
 
 #define smp_mb()		mb()
