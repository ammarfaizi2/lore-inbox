Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281005AbRLIBPP>; Sat, 8 Dec 2001 20:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280984AbRLIBPG>; Sat, 8 Dec 2001 20:15:06 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:11727 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S281024AbRLIBOz>;
	Sat, 8 Dec 2001 20:14:55 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15378.47872.93458.589286@napali.hpl.hp.com>
Date: Sat, 8 Dec 2001 17:14:40 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: davidm@hpl.hp.com, marcelo@conectiva.com.br (Marcelo Tosatti),
        akpm@zip.com.au (Andrew Morton), j-nomura@ce.jp.nec.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processorinitializationcheck)
In-Reply-To: <E16CsYv-0003QO-00@the-village.bc.nu>
In-Reply-To: <15378.46887.160213.680268@napali.hpl.hp.com>
	<E16CsYv-0003QO-00@the-village.bc.nu>
X-Mailer: VM 6.76 under Emacs 20.4.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Sun, 9 Dec 2001 01:15:25 +0000 (GMT), Alan Cox <alan@lxorguk.ukuu.org.uk> said:

  Alan> And break the ability for non broken setups to debug SMP boot
  Alan> up. Lets do the job properly.

Then use Andrew's patch (attached below).

	--david

--- linux-2.4.17-pre4/include/asm-ia64/system.h	Thu Nov 22 23:02:59 2001
+++ linux-akpm/include/asm-ia64/system.h	Wed Dec  5 23:09:15 2001
@@ -405,6 +405,10 @@ extern void ia64_load_extra (struct task
 	ia64_psr(ia64_task_regs(prev))->dfh = 1;				\
 	__switch_to(prev,next,last);						\
   } while (0)
+
+/* Return true if this CPU can call the console drivers in printk() */
+#define arch_consoles_callable() (cpu_online_map & (1UL << smp_processor_id()))
+
 #else
 # define switch_to(prev,next,last) do {						\
 	ia64_psr(ia64_task_regs(next))->dfh = (ia64_get_fpu_owner() != (next));	\
--- linux-2.4.17-pre4/kernel/printk.c	Thu Nov 22 23:02:59 2001
+++ linux-akpm/kernel/printk.c	Wed Dec  5 23:03:54 2001
@@ -38,6 +38,10 @@
 
 #define LOG_BUF_MASK	(LOG_BUF_LEN-1)
 
+#ifndef arch_consoles_callable
+#define arch_consoles_callable() (1)
+#endif
+
 /* printk's without a loglevel use this.. */
 #define DEFAULT_MESSAGE_LOGLEVEL 4 /* KERN_WARNING */
 
@@ -438,6 +442,14 @@ asmlinkage int printk(const char *fmt, .
 			log_level_unknown = 1;
 	}
 
+	if (!arch_consoles_callable()) {
+		/*
+		 * On some architectures, the consoles are not usable
+		 * on secondary CPUs early in the boot process.
+		 */
+		spin_unlock_irqrestore(&logbuf_lock, flags);
+		goto out;
+	}
 	if (!down_trylock(&console_sem)) {
 		/*
 		 * We own the drivers.  We can drop the spinlock and let
@@ -454,6 +466,7 @@ asmlinkage int printk(const char *fmt, .
 		 */
 		spin_unlock_irqrestore(&logbuf_lock, flags);
 	}
+out:
 	return printed_len;
 }
 EXPORT_SYMBOL(printk);
