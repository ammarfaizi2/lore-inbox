Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266320AbTABSmd>; Thu, 2 Jan 2003 13:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266323AbTABSmd>; Thu, 2 Jan 2003 13:42:33 -0500
Received: from ligur.expressz.com ([212.24.178.154]:17852 "EHLO expressz.com")
	by vger.kernel.org with ESMTP id <S266320AbTABSma>;
	Thu, 2 Jan 2003 13:42:30 -0500
Date: Thu, 2 Jan 2003 19:50:59 +0100 (CET)
From: "BODA Karoly jr." <woockie@expressz.com>
Reply-To: "BODA Karoly jr." <woockie@expressz.com>
To: linux-kernel@vger.kernel.org
Subject: Linux-2.5.54-sparc64 compile errors
Message-ID: <Pine.LNX.3.96.1030102191604.22760J-100000@ligur.expressz.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Some errors and patches, but I'm not sure they are correct:

o There was no archclean which is needed to make clean

--- arch/sparc64/Makefile       2003-01-02 04:23:15.000000000 +0100
+++ arch/sparc64/Makefile~      2003-01-02 16:56:48.000000000 +0100
@@ -74,6 +74,9 @@ drivers-$(CONFIG_OPROFILE)    += arch/sparc
 tftpboot.img vmlinux.aout:
        $(Q)$(MAKE) $(build)=arch/sparc64/boot arch/sparc64/boot/$@

+archclean:
+       $(Q)$(MAKE) $(clean)=arch/sparc64/boot
+
 define archhelp
   echo  '* vmlinux       - Standard sparc64 kernel'
   echo  '  vmlinux.aout  - a.out kernel for sparc64'


o Missing "drivers/scsi/aic7xxx/Kconfig" in arch/sparc64/Kconfig line 990

--- arch/sparc64/Kconfig        2003-01-02 04:23:01.000000000 +0100
+++ arch/sparc64/Kconfig~       2003-01-02 19:09:53.000000000 +0100
@@ -986,7 +986,8 @@ choice
        optional
        depends on SCSI && PCI

-source "drivers/scsi/aic7xxx/Kconfig"
+source "drivers/scsi/aic7xxx/Kconfig.aic7xxx"
+source "drivers/scsi/aic7xxx/Kconfig.aic79xx"

 config SCSI_AIC7XXX_OLD
        tristate "Old driver"


o Compile error of arch/sparc64/kernel/power.c

  sparc64-linux-gcc -Wp,-MD,arch/sparc64/kernel/.power.o.d -D__KERNEL__
-Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2
-fno-strict-aliasing -fno-common -m64 -pipe -mno-fpu -mcpu=ultrasparc
-mcmodel=medlow -ffixed-g4 -fcall-used-g5 -fcall-used-g7 -Wno-sign-compare
-Wa,--undeclared-regs -fomit-frame-pointer -nostdinc -iwithprefix include
-DKBUILD_BASENAME=power -DKBUILD_MODNAME=power   -c -o
arch/sparc64/kernel/power.o arch/sparc64/kernel/power.c
In file included from include/linux/interrupt.h:9,
                 from arch/sparc64/kernel/power.c:13:
include/asm/hardirq.h:23: parse error before `irq_cpustat_t'
include/asm/hardirq.h:23: warning: type defaults to `int' in declaration of `irq_cpustat_t'
include/asm/hardirq.h:23: warning: data definition has no type or storage class
In file included from include/asm/hardirq.h:25,
                 from include/linux/interrupt.h:9,
                 from arch/sparc64/kernel/power.c:13:
include/linux/irq_cpustat.h:20: parse error before `irq_stat'
include/linux/irq_cpustat.h:20: warning: type defaults to `int' in declaration of `irq_stat'
include/linux/irq_cpustat.h:20: warning: data definition has no type or storage class
include/linux/irq_cpustat.h:20: warning: array `irq_stat' assumed to have one element
make[2]: *** [arch/sparc64/kernel/power.o] Error 1
make[1]: *** [arch/sparc64/kernel] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.54'
make: *** [stamp-build] Error 2

This patch makes it compile:
--- include/linux/interrupt.h   2003-01-02 04:22:17.000000000 +0100
+++ include/linux/interrupt.h~  2003-01-02 19:29:15.000000000 +0100
@@ -5,6 +5,7 @@
 #include <linux/config.h>
 #include <linux/linkage.h>
 #include <linux/bitops.h>
+#include <linux/cache.h>
 #include <asm/atomic.h>
 #include <asm/hardirq.h>
 #include <asm/ptrace.h>


o And an error which with I can't do anything... :(

  sparc64-linux-gcc -Wp,-MD,arch/sparc64/kernel/.head.o.d -D__ASSEMBLY__
-D__KERNEL__ -Iinclude -m64 -mcpu=ultrasparc -Wa,--undeclared-regs
-nostdinc -iwithprefix include  -ansi  -c -o arch/sparc64/kernel/head.o
arch/sparc64/kernel/head.S
In file included from include/linux/cache.h:4,
                 from include/asm/smp.h:11,
                 from arch/sparc64/kernel/entry.S:15,
                 from arch/sparc64/kernel/head.S:734:
include/linux/kernel.h:31: warning: `ALIGN' redefined
include/linux/linkage.h:24: warning: this is the location of the previous definition
/usr/lib/gcc-lib/sparc64-linux/egcs-2.92.11/include/va-sparc.h: Assembler messages:
/usr/lib/gcc-lib/sparc64-linux/egcs-2.92.11/include/va-sparc.h:15: Error: Unknown opcode: `typedef'
/usr/lib/gcc-lib/sparc64-linux/egcs-2.92.11/include/va-sparc.h:50: Error: Unknown opcode: `void'
/usr/lib/gcc-lib/sparc64-linux/egcs-2.92.11/include/va-sparc.h:54: Error: Unknown opcode: `enum'
/usr/lib/gcc-lib/sparc64-linux/egcs-2.92.11/include/va-sparc.h:55:
Warning: rest of line ignored; first ignored character is `,'/usr/lib/gcc-lib/sparc64-linux/egcs-2.92.11/include/va-sparc.h:56:
Fatal error: Unknown opcode: `__void_type_class,'
make[2]: *** [arch/sparc64/kernel/head.o] Error 1
make[1]: *** [arch/sparc64/kernel] Error 2
make[1]: Leaving directory `/usr/src/linux-2.5.54'
make: *** [stamp-build] Error 2


	Sorry if my patches are not correct, I'm not a kernel developer.:)
If need any information about my machine, please ask for it.:)

-- 
						Woockie
..."what is there in this world that makes living worthwhile?"
Death thought about it. "CATS," he said eventually, "CATS ARE NICE."
			           (Terry Pratchett, Sourcery)


