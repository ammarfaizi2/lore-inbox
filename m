Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbTEUSOw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 14:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbTEUSOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 14:14:52 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:38341 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262247AbTEUSOO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 14:14:14 -0400
Subject: Re: userspace irq  =?ISO-8859-1?Q?=20balancer=C2=A0?=
From: Keith Mannthey <kmannth@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: davem@redhat.com, habanero@us.ibm.com, haveblue@us.ibm.com,
       wli@holomorphy.com, arjanv@redhat.com, pbadari@us.ibm.com,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       gh@us.ibm.com, johnstul@us.ltcfwd.linux.ibm, jamesclv@us.ibm.com,
       Andrew Morton <akpm@digeo.com>
Content-Type: multipart/mixed; boundary="=-li6ODuPOH4AyCleuq+1p"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 May 2003 11:28:41 -0700
Message-Id: <1053541725.16886.4711.camel@dyn9-47-17-180.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-li6ODuPOH4AyCleuq+1p
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

  Here is the patch to turn kirqd into a config option if it is really
needed.  I don't see why the noirqbalance functionality isn't enough for
now.  Is there anything currently keeping a userspace irq balancer from
working as 2.5 stands today?  It dosen't look like it to me.

Keith      


--=-li6ODuPOH4AyCleuq+1p
Content-Disposition: attachment; filename=config-irq-2.5.68
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=config-irq-2.5.68; charset=UTF-8

diff -urN linux-2.5.68/arch/i386/Kconfig linux-2.5.68-config-irq/arch/i386/=
Kconfig
--- linux-2.5.68/arch/i386/Kconfig	Sat Apr 19 19:48:52 2003
+++ linux-2.5.68-config-irq/arch/i386/Kconfig	Thu Apr 24 17:04:47 2003
@@ -758,6 +758,14 @@
=20
 	  See <file:Documentation/mtrr.txt> for more information.
=20
+config IRQBALANCE
+ 	bool "Enable kernel irq balancing"
+	depends on SMP
+	default y
+	help
+ 	  The defalut yes will allow the kernel to do irq load balancing. =20
+	  Saying no will keep the kernel from doing irq load balancing. =09
+
 config HAVE_DEC_LOCK
 	bool
 	depends on (SMP || PREEMPT) && X86_CMPXCHG
diff -urN linux-2.5.68/arch/i386/kernel/io_apic.c linux-2.5.68-config-irq/a=
rch/i386/kernel/io_apic.c
--- linux-2.5.68/arch/i386/kernel/io_apic.c	Sat Apr 19 19:49:09 2003
+++ linux-2.5.68-config-irq/arch/i386/kernel/io_apic.c	Thu Apr 24 17:05:30 =
2003
@@ -263,7 +263,7 @@
 	spin_unlock_irqrestore(&ioapic_lock, flags);
 }
=20
-#if defined(CONFIG_SMP)
+#if defined(CONFIG_IRQBALANCE)=20
 # include <asm/processor.h>	/* kernel_thread() */
 # include <linux/kernel_stat.h>	/* kstat */
 # include <linux/slab.h>		/* kmalloc() */
@@ -654,8 +654,6 @@
=20
 __setup("noirqbalance", irqbalance_disable);
=20
-static void set_ioapic_affinity (unsigned int irq, unsigned long mask);
-
 static inline void move_irq(int irq)
 {
 	/* note - we hold the desc->lock */
@@ -667,9 +665,9 @@
=20
 __initcall(balanced_irq_init);
=20
-#else /* !SMP */
+#else /* !IRQBALANCE */
 static inline void move_irq(int irq) { }
-#endif /* defined(CONFIG_SMP) */
+#endif /* defined(IRQBALANCE) */
=20
=20
 /*

--=-li6ODuPOH4AyCleuq+1p--

