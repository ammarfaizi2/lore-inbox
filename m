Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316408AbSFUGss>; Fri, 21 Jun 2002 02:48:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316423AbSFUGss>; Fri, 21 Jun 2002 02:48:48 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:23050 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S316408AbSFUGsq>; Fri, 21 Jun 2002 02:48:46 -0400
Date: Fri, 21 Jun 2002 08:48:35 +0200
From: Jurriaan on Alpha <thunder7@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: 2.5.24 doesn't compile on Alpha
Message-ID: <20020621064835.GA13502@alpha.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Message-Flag: Still using Outlook? Please Upgrade to real software!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After applying this diff to get past the most obvious errors:

[yes, it applies clean against 2.5.24 still]

diff -Br -b -U 3 -N linux-2.5.20/drivers/char/rtc.c linux-2.5.20-jwk/drivers/char/rtc.c
--- linux-2.5.20/drivers/char/rtc.c	Sat Jun  8 15:44:46 2002
+++ linux-2.5.20-jwk/drivers/char/rtc.c	Sun Jun  9 08:28:23 2002
@@ -72,6 +72,7 @@
 #include <linux/sysctl.h>
 
 #include <asm/io.h>
+#include <asm/irq.h>
 #include <asm/uaccess.h>
 #include <asm/system.h>
 
diff -Br -b -U 3 -N linux-2.5.20/include/asm-alpha/bitops.h linux-2.5.20-jwk/include/asm-alpha/bitops.h
--- linux-2.5.20/include/asm-alpha/bitops.h	Wed Apr 24 09:15:19 2002
+++ linux-2.5.20-jwk/include/asm-alpha/bitops.h	Sun Jun  9 08:51:55 2002
@@ -451,6 +451,12 @@
 }
 
 /*
+ * fls: find last bit set.
+ */
+
+#define fls(x) generic_fls(x)
+
+/*
  * The optimizer actually does good code for this case.
  */
 #define find_first_zero_bit(addr, size) \
diff -Br -b -U 3 -N linux-2.5.20/include/asm-alpha/irq.h linux-2.5.20-jwk/include/asm-alpha/irq.h
--- linux-2.5.20/include/asm-alpha/irq.h	Wed Apr 24 09:15:18 2002
+++ linux-2.5.20-jwk/include/asm-alpha/irq.h	Sun Jun  9 08:51:56 2002
@@ -37,6 +37,7 @@
       defined(CONFIG_ALPHA_RX164)     || \
       defined(CONFIG_ALPHA_NORITAKE)
 # define NR_IRQS	48
+# define RTC_IRQ	8
 
 #elif defined(CONFIG_ALPHA_SABLE)     || \
       defined(CONFIG_ALPHA_SX164)
diff -Br -b -U 3 -N linux-2.5.20/include/asm-alpha/page.h linux-2.5.20-jwk/include/asm-alpha/page.h
--- linux-2.5.20/include/asm-alpha/page.h	Wed Apr 24 09:15:21 2002
+++ linux-2.5.20-jwk/include/asm-alpha/page.h	Sun Jun  9 08:51:55 2002
@@ -15,10 +15,10 @@
 #define STRICT_MM_TYPECHECKS
 
 extern void clear_page(void *page);
-#define clear_user_page(page, vaddr)	clear_page(page)
+#define clear_user_page(page, vaddr, pg)	clear_page(page)
 
 extern void copy_page(void * _to, void * _from);
-#define copy_user_page(to, from, vaddr)	copy_page(to, from)
+#define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 
 #ifdef STRICT_MM_TYPECHECKS
 /*


I still get errors:

alpha:/usr/src/linux-2.5.24# make boot
make[1]: Entering directory `/usr/src/linux-2.5.24/scripts'
make[1]: Leaving directory `/usr/src/linux-2.5.24/scripts'
make[1]: Entering directory `/usr/src/linux-2.5.24/arch/alpha/kernel'
  gcc -Wp,-MD,./.asm-offsets.s.d -D__KERNEL__ -I/usr/src/linux-2.5.24/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-fra
me-pointer -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6 -nostdinc -iwithprefix include    -DKBU
ILD_BASENAME=asm_offsets   -S -o asm-offsets.s asm-offsets.c
make[1]: Leaving directory `/usr/src/linux-2.5.24/arch/alpha/kernel'
  Generating include/asm-alpha/asm_offsets.h (unchanged)
  Starting the build. KBUILD_BUILTIN=1 KBUILD_MODULES=
make[1]: Entering directory `/usr/src/linux-2.5.24/init'
  gcc -Wp,-MD,./.main.o.d -D__KERNEL__ -I/usr/src/linux-2.5.24/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-poin
ter -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6 -nostdinc -iwithprefix include    -DKBUILD_BAS
ENAME=main   -c -o main.o main.c
  Generating /usr/src/linux-2.5.24/include/linux/compile.h (updated)
  gcc -Wp,-MD,./.version.o.d -D__KERNEL__ -I/usr/src/linux-2.5.24/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-p
ointer -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6 -nostdinc -iwithprefix include    -DKBUILD_
BASENAME=version   -c -o version.o version.c
  gcc -Wp,-MD,./.do_mounts.o.d -D__KERNEL__ -I/usr/src/linux-2.5.24/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame
-pointer -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6 -nostdinc -iwithprefix include    -DKBUIL
D_BASENAME=do_mounts   -c -o do_mounts.o do_mounts.c
   ld  -r -o init.o main.o version.o do_mounts.o
make[1]: Leaving directory `/usr/src/linux-2.5.24/init'
make[1]: Entering directory `/usr/src/linux-2.5.24/kernel'
  gcc -Wp,-MD,./.sched.o.d -D__KERNEL__ -I/usr/src/linux-2.5.24/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-poi
nter -fno-strict-aliasing -fno-common -pipe -mno-fp-regs -ffixed-8 -mcpu=ev56 -Wa,-mev6 -nostdinc -iwithprefix include    -fno-omit-f
rame-pointer -DKBUILD_BASENAME=sched   -c -o sched.o sched.c
sched.c:469: macro `switch_to' used with too many (3) args
In file included from sched.c:25:
/usr/src/linux-2.5.24/include/asm/mmu_context.h: In function `init_new_context':
/usr/src/linux-2.5.24/include/asm/mmu_context.h:230: `smp_num_cpus' undeclared (first use in this function)
/usr/src/linux-2.5.24/include/asm/mmu_context.h:230: (Each undeclared identifier is reported only once
/usr/src/linux-2.5.24/include/asm/mmu_context.h:230: for each function it appears in.)
/usr/src/linux-2.5.24/include/asm/mmu_context.h:231: warning: implicit declaration of function `cpu_logical_map'
sched.c: In function `schedule':
sched.c:819: warning: implicit declaration of function `prepare_arch_schedule'
sched.c:876: warning: implicit declaration of function `prepare_arch_switch'
sched.c:880: warning: implicit declaration of function `finish_arch_switch'
sched.c:883: warning: implicit declaration of function `finish_arch_schedule'
make[1]: *** [sched.o] Error 1
make[1]: Leaving directory `/usr/src/linux-2.5.24/kernel'
make: *** [kernel] Error 2
alpha:/usr/src/linux-2.5.24#

I know I can fix the smp_num_cpus thing, but the prepare_arch_switch()
etc. things are another matter. Every now and again I see a post to lkml
for the Alpha, which suggest some people succeed in compiling it. Any
hints?

Thanks,
Jurriaan
-- 
I'm a mean green mother from outer space.
        Audrey II, The Little Shop of Horrors
Debian GNU/Linux 2.4.19p10 on Alpha 990 bogomips load:0.66 0.17 0.36
