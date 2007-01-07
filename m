Return-Path: <linux-kernel-owner+w=401wt.eu-S932422AbXAGH1Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbXAGH1Y (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 02:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbXAGH1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 02:27:24 -0500
Received: from smtp.osdl.org ([65.172.181.24]:39339 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932381AbXAGH1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 02:27:22 -0500
Date: Sat, 6 Jan 2007 23:26:41 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
       kiran@scalex86.org, ak@suse.de, md@google.com, mingo@elte.hu,
       pravin.shelar@calsoftinc.com, shai@scalex86.org
Subject: Re: +
 spin_lock_irq-enable-interrupts-while-spinning-i386-implementation.patch
 added to -mm tree
Message-Id: <20070106232641.68511f15.akpm@osdl.org>
In-Reply-To: <1168122953.26086.230.camel@imap.mvista.com>
References: <200701032112.l03LCnVb031386@shell0.pdx.osdl.net>
	<1168122953.26086.230.camel@imap.mvista.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 Jan 2007 14:35:53 -0800
Daniel Walker <dwalker@mvista.com> wrote:

> On Wed, 2007-01-03 at 13:12 -0800, akpm@osdl.org wrote:
> > -# define __raw_spin_lock_irq(lock) __raw_spin_lock(lock)
> > +
> > +static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
> > +{
> > +       asm volatile("\n1:\t"
> > +                    LOCK_PREFIX " ; decb %0\n\t"
> > +                    "jns 3f\n"
> > +                    STI_STRING "\n"
> > +                    "2:\t"
> > +                    "rep;nop\n\t"
> > +                    "cmpb $0,%0\n\t"
> > +                    "jle 2b\n\t"
> > +                    CLI_STRING "\n"
> > +                    "jmp 1b\n"
> > +                    "3:\n\t"
> > +                    : "+m" (lock->slock) : : "memory");
> > +}
> >  #endif
> >   
> 
> This doesn't compile when CONFIG_PARAVIRT is enabled. It changes the
> CLI_STRING and STI_STRING values.
> 


diff -puN include/asm-i386/spinlock.h~spin_lock_irq-enable-interrupts-while-spinning-i386-implementation-fix include/asm-i386/spinlock.h
--- a/include/asm-i386/spinlock.h~spin_lock_irq-enable-interrupts-while-spinning-i386-implementation-fix
+++ a/include/asm-i386/spinlock.h
@@ -86,17 +86,19 @@ static inline void __raw_spin_lock_flags
 static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
 {
 	asm volatile("\n1:\t"
-		     LOCK_PREFIX " ; decb %0\n\t"
+		     LOCK_PREFIX " ; decb %[slock]\n\t"
 		     "jns 3f\n"
 		     STI_STRING "\n"
 		     "2:\t"
 		     "rep;nop\n\t"
-		     "cmpb $0,%0\n\t"
+		     "cmpb $0,%[slock]\n\t"
 		     "jle 2b\n\t"
 		     CLI_STRING "\n"
 		     "jmp 1b\n"
 		     "3:\n\t"
-		     : "+m" (lock->slock) : : "memory");
+		     : [slock] "+m" (lock->slock)
+		     : __CLI_STI_INPUT_ARGS
+		     : "memory" CLI_STI_CLOBBERS);
 }
 #endif
 
diff -puN include/asm-i386/paravirt.h~spin_lock_irq-enable-interrupts-while-spinning-i386-implementation-fix include/asm-i386/paravirt.h
--- a/include/asm-i386/paravirt.h~spin_lock_irq-enable-interrupts-while-spinning-i386-implementation-fix
+++ a/include/asm-i386/paravirt.h
@@ -509,10 +509,10 @@ static inline unsigned long __raw_local_
 		     "popl %%edx; popl %%ecx",				\
 		     PARAVIRT_IRQ_ENABLE, CLBR_EAX)
 #define CLI_STI_CLOBBERS , "%eax"
-#define CLI_STI_INPUT_ARGS \
-	,								\
+#define __CLI_STI_INPUT_ARGS						\
 	[irq_disable] "i" (offsetof(struct paravirt_ops, irq_disable)),	\
 	[irq_enable] "i" (offsetof(struct paravirt_ops, irq_enable))
+#define CLI_STI_INPUT_ARGS , __CLI_STI_INPUT_ARGS
 
 #else  /* __ASSEMBLY__ */
 
_

