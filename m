Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263257AbTCNHEp>; Fri, 14 Mar 2003 02:04:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263258AbTCNHEp>; Fri, 14 Mar 2003 02:04:45 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:39480
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S263257AbTCNHEo>; Fri, 14 Mar 2003 02:04:44 -0500
Date: Fri, 14 Mar 2003 02:12:14 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Andrey Panin <pazke@orbita1.ru>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] irq handling code consolidation (i386 part)
In-Reply-To: <Pine.LNX.4.50.0303140057580.17112-100000@montezuma.mastecende.com>
Message-ID: <Pine.LNX.4.50.0303140157480.17112-100000@montezuma.mastecende.com>
References: <20030313132449.GH1393@pazke>
 <Pine.LNX.4.50.0303140057580.17112-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Mar 2003, Zwane Mwaikambo wrote:

> On Thu, 13 Mar 2003, Andrey Panin wrote:
> 
> > Hi,
> > 
> > irq handling consolidation continues !
> > 
> > i386 specific patch attached. Compiled and WorksForMe(tm)
> 
> I'm still going through a few tests but here are some compile fixes for 
> some configurations i was trying.

Does this look ok? I tested compiled the following combinations;

i386 - NUMAQ, SMP, UP w/ IOAPIC, UP VISWS and SMP VISWS, i only did visual 
inspection of Alpha.

ccache gcc -Wp,-MD,kernel/.irq.o.d -D__KERNEL__ -Iinclude -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -g -fno-strict-aliasing -fno-common 
-pipe -mpreferred-stack-boundary=2 -march=i586 
-Iinclude/asm-i386/mach-default -nostdinc -iwithprefix include    
-DKBUILD_BASENAME=irq -DKBUILD_MODNAME=irq -c -o kernel/irq.o kernel/irq.c

kernel/irq.c: In function `irq_affinity_read_proc':
kernel/irq.c:691: `irq_affinity' undeclared (first use in this function)
kernel/irq.c:691: (Each undeclared identifier is reported only once
kernel/irq.c:691: for each function it appears in.)
kernel/irq.c: In function `irq_affinity_write_proc':
kernel/irq.c:713: `irq_affinity' undeclared (first use in this function) 
include/asm/uaccess.h: At top level:
kernel/irq.c:687: warning: `irq_affinity_read_proc' defined but not used
kernel/irq.c:696: warning: `irq_affinity_write_proc' defined but not used
kernel/irq.c:756: warning: `prof_cpu_mask_read_proc' defined but not used
kernel/irq.c:766: warning: `prof_cpu_mask_write_proc' defined but not used
make[2]: *** [kernel/irq.o] Error 1
make[1]: *** [kernel] Error 2
make: *** [vmlinux] Error 2

Index: linux-2.5.64-unwashed/kernel/irq.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.64/kernel/Attic/irq.c,v
retrieving revision 1.1.2.1
diff -u -r1.1.2.1 irq.c
--- linux-2.5.64-unwashed/kernel/irq.c	14 Mar 2003 06:59:57 -0000	1.1.2.1
+++ linux-2.5.64-unwashed/kernel/irq.c	14 Mar 2003 07:00:23 -0000
@@ -680,7 +680,6 @@
 unsigned long irq_affinity[NR_IRQS] = { 
 	[0 ... NR_IRQS - 1] = ARCH_DEFAULT_IRQ_AFFINITY
 };
-#endif
 
 static int irq_affinity_read_proc(char *page, char **start, off_t off,
 				  int count, int *eof, void *data)
@@ -715,6 +714,7 @@
 
 	return full_count;
 }
+#endif
 
 void register_irq_proc(unsigned int irq)
 {
@@ -751,6 +751,7 @@
 
 unsigned long prof_cpu_mask = ~0UL;
 
+#ifdef CONFIG_SMP
 static int prof_cpu_mask_read_proc(char *page, char **start, off_t off,
 				   int count, int *eof, void *data)
 {
@@ -774,6 +775,7 @@
 	*mask = new_value;
 	return full_count;
 }
+#endif
 
 void init_irq_proc(void)
 {

