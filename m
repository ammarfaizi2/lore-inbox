Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131339AbQKUVnu>; Tue, 21 Nov 2000 16:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131459AbQKUVnj>; Tue, 21 Nov 2000 16:43:39 -0500
Received: from tstac.esa.lanl.gov ([128.165.46.3]:40196 "EHLO
	tstac.esa.lanl.gov") by vger.kernel.org with ESMTP
	id <S131339AbQKUVn2>; Tue, 21 Nov 2000 16:43:28 -0500
From: Steven Cole <scole@lanl.gov>
Reply-To: scole@lanl.gov
Date: Tue, 21 Nov 2000 14:13:25 -0700
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.4.0-test11-ac1 compile error fix
MIME-Version: 1.0
Message-Id: <00112114132500.00902@spc.esa.lanl.gov>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch to fix a compile error which I previously reported on
the 2.4.0test11-ac1 thread.

I tried to compile 2.4.0-test11-ac1, and here is where the compile bombed 
out:

/usr/bin/kgcc -D__KERNEL__ -I/usr/src/linux/include -Wall -Wstrict-prototypes 
-O2 -fomit-frame-pointer -fno-strict-aliasing -pipe  -march=i686    -c -o 
sched.o sched.c
irq.c:182: conflicting types for `global_irq_lock'
/usr/src/linux/include/asm/hardirq.h:45: previous declaration of 
`global_irq_lock'
make[1]: *** [irq.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.4.0-test11-ac1/arch/i386/kernel'
make: *** [_dir_arch/i386/kernel] Error 2

Evidently, global_irq_lock was changed to a long in several places in
the 2.4.0-test11-ac1 patch, but was left as an int in 
linux/include/asm/hardirq.h.

I'm running 2.4.0-test11-ac1 with this patch now.

diff -u linux/include/asm/hardirq.h.orig linux/include/asm/hardirq.h
--- linux/include/asm/hardirq.h.orig    Tue Nov 21 13:38:07 2000
+++ linux/include/asm/hardirq.h Tue Nov 21 13:40:13 2000
@@ -42,7 +42,7 @@
 #include <asm/smp.h>

 extern unsigned char global_irq_holder;
-extern unsigned volatile int global_irq_lock;
+extern unsigned volatile long global_irq_lock; /* long for set_bit -RR */

 static inline int irqs_running (void)
 {

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
