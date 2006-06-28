Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932756AbWF1HPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932756AbWF1HPo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 03:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932758AbWF1HPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 03:15:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:57325 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932756AbWF1HPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 03:15:43 -0400
Date: Wed, 28 Jun 2006 00:12:08 -0700
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org, mingo@elte.hu,
       rmk@arm.linux.org.uk
Subject: Re: 2.6.17-mm3: arm: *_irq_wake compile error
Message-Id: <20060628001208.2b034afd.akpm@osdl.org>
In-Reply-To: <1151478544.25491.485.camel@localhost.localdomain>
References: <20060627015211.ce480da6.akpm@osdl.org>
	<20060627224038.GF13915@stusta.de>
	<1151478544.25491.485.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jun 2006 09:09:04 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Wed, 2006-06-28 at 00:40 +0200, Adrian Bunk wrote:
> > genirq-add-irq-wake-power-management-support.patch causes the following 
> > compile error on arm:
> > 
> > <--  snip  -->
> > 
> > ...
> >   CC      init/main.o
> > In file included from include/linux/rtc.h:102,
> >                  from include/linux/efi.h:19,
> >                  from init/main.c:47:
> > include/linux/interrupt.h:108: error: conflicting types for 'enable_irq_wake'
> > include/asm/irq.h:47: error: previous declaration of 'enable_irq_wake' was here
> > include/linux/interrupt.h:113: error: conflicting types for 'disable_irq_wake'
> > include/asm/irq.h:46: error: previous declaration of 'disable_irq_wake' was here
> > make[1]: *** [init/main.o] Error 1
> 
> Thats a mismerge with LOCKDEP
> 
> This section was originally inside #ifdef CONFIG_GENERIC_HARDIRQS
> 
> /* IRQ wakeup (PM) control: */
> extern int set_irq_wake(unsigned int irq, unsigned int on);
> 
> static inline int enable_irq_wake(unsigned int irq)
> {
>         return set_irq_wake(irq, 1);
> }
> 
> static inline int disable_irq_wake(unsigned int irq)
> {
>         return set_irq_wake(irq, 0);
> }
> 
> The patch is:
> 
> lockdep-add-disable-enable_irq_lockdep-api.patch
> 

OK, so I moved the above lines inside #ifdef CONFIG_GENERIC_HARDIRQS (diff
did a strange-looking thing with it):

diff -puN include/linux/interrupt.h~lockdep-add-disable-enable_irq_lockdep-api-fix include/linux/interrupt.h
--- a/include/linux/interrupt.h~lockdep-add-disable-enable_irq_lockdep-api-fix
+++ a/include/linux/interrupt.h
@@ -71,17 +71,6 @@ static inline void enable_irq_lockdep(un
 #endif
 	enable_irq(irq);
 }
-#else /* !CONFIG_GENERIC_HARDIRQS */
-/*
- * NOTE: non-genirq architectures, if they want to support the lock
- * validator need to define the methods below in their asm/irq.h
- * files, under an #ifdef CONFIG_LOCKDEP section.
- */
-# ifndef CONFIG_LOCKDEP
-#  define disable_irq_nosync_lockdep(irq)	disable_irq_nosync(irq)
-#  define disable_irq_lockdep(irq)		disable_irq(irq)
-#  define enable_irq_lockdep(irq)		enable_irq(irq)
-# endif
 
 /* IRQ wakeup (PM) control: */
 extern int set_irq_wake(unsigned int irq, unsigned int on);
@@ -96,6 +85,18 @@ static inline int disable_irq_wake(unsig
 	return set_irq_wake(irq, 0);
 }
 
+#else /* !CONFIG_GENERIC_HARDIRQS */
+/*
+ * NOTE: non-genirq architectures, if they want to support the lock
+ * validator need to define the methods below in their asm/irq.h
+ * files, under an #ifdef CONFIG_LOCKDEP section.
+ */
+# ifndef CONFIG_LOCKDEP
+#  define disable_irq_nosync_lockdep(irq)	disable_irq_nosync(irq)
+#  define disable_irq_lockdep(irq)		disable_irq(irq)
+#  define enable_irq_lockdep(irq)		enable_irq(irq)
+# endif
+
 #endif /* CONFIG_GENERIC_HARDIRQS */
 
 #ifndef __ARCH_SET_SOFTIRQ_PENDING
_

