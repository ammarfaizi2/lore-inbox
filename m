Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291385AbSAaWxr>; Thu, 31 Jan 2002 17:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291386AbSAaWxj>; Thu, 31 Jan 2002 17:53:39 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:33464 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id <S291385AbSAaWxc>;
	Thu, 31 Jan 2002 17:53:32 -0500
Date: Thu, 31 Jan 2002 23:53:06 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: torvalds@transmeta.com
Cc: garzik@havoc.gtf.org, linux-kernel@vger.kernel.org, davem@redhat.com,
        paulus@samba.org, davidm@hpl.hp.com, ralf@gnu.org
Subject: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does not
Message-ID: <20020131225306.GA23758@vana.vc.cvut.cz>
In-Reply-To: <107F105A2B71@vcnet.vc.cvut.cz> <20020131153115.A5370@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020131153115.A5370@havoc.gtf.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2002 at 03:31:15PM -0500, Jeff Garzik wrote:
> > Unfortunately during conversion I found that there is lib/bust_spinlocks.c,
> > which is always included in lib.a, is always compiled, even if architecture
> > provides its own bust_spinlocks function.
> 
> Yep

> > But of course if there is consensus that I should convert lib/lib.a
> > into lib/lib.o, I can either create Config.in symbol 
> > CONFIG_NEED_GENERIC_BUST_SPINLOCK, or add HAVE_ARCH_BUST_SPINLOCK #define
> > into some of i386, ia64, mips64, s390 and s390x architecture dependent
> > headers.
> 
> Implementing HAVE_ARCH_BUST_SPINLOCK would follow kernel convention
> quite nicely...

Hi Linus,
   included patch (for 2.5.3) fixes problems with late initialization
of lib/crc32.o - as it was part of .a library file, it was picked by
link process AFTER at least one .o file required it - for example
when ipv4 autoconfiguration file needed it. So crc32's initalization
function was invoked after ipconfig's one - and it crashed inside
of ipconfig due to this problem.

   Jeff Garzik advised me that I should convert lib.a to lib.o instead
of moving crc32 somewhere else, so I did it. I decided to put 
HAVE_ARCH_BUST_SPINLOCKS macro to asm/system.h headers - if you disagree
with this location, tell me.

   Couple of architectures adds $(TOPDIR)/lib/lib.o into its LIBS
instead of reusing already set $(LIBS) variable. I was not sure
what PPC people meant with this, so I left it as is.

   I'd like to ask architecture maintainers (especially ia64, PPC, Sparc 
and Sparc64 maintainers) for verification that my changes did not break 
anything... I tested only i386, but changes were obvious...

				Best regards,
					Petr Vandrovec
					vandrove@vc.cvut.cz


diff -urdN linux/Makefile linux/Makefile
--- linux/Makefile	Wed Jan 30 02:24:01 2002
+++ linux/Makefile	Thu Jan 31 19:36:31 2002
@@ -121,7 +121,7 @@
 CORE_FILES	=kernel/kernel.o mm/mm.o fs/fs.o ipc/ipc.o
 NETWORKS	=net/network.o
 
-LIBS		=$(TOPDIR)/lib/lib.a
+LIBS		=$(TOPDIR)/lib/lib.o
 SUBDIRS		=kernel lib drivers mm fs net ipc
 
 DRIVERS-n :=
diff -urdN linux/arch/ia64/boot/Makefile linux/arch/ia64/boot/Makefile
--- linux/arch/ia64/boot/Makefile	Thu Jan  4 20:50:17 2001
+++ linux/arch/ia64/boot/Makefile	Thu Jan 31 19:31:04 2002
@@ -23,7 +23,7 @@
 all:	$(targets-y)
 
 bootloader: $(OBJECTS)
-	$(LD) $(LINKFLAGS) $(OBJECTS) $(TOPDIR)/lib/lib.a $(TOPDIR)/arch/$(ARCH)/lib/lib.a \
+	$(LD) $(LINKFLAGS) $(OBJECTS) $(TOPDIR)/lib/lib.o $(TOPDIR)/arch/$(ARCH)/lib/lib.a \
 	-o bootloader
 
 clean:
diff -urdN linux/arch/ppc/boot/chrp/Makefile linux/arch/ppc/boot/chrp/Makefile
--- linux/arch/ppc/boot/chrp/Makefile	Tue Aug 28 13:58:33 2001
+++ linux/arch/ppc/boot/chrp/Makefile	Thu Jan 31 19:29:34 2002
@@ -23,7 +23,7 @@
 
 OBJS = ../common/crt0.o start.o main.o misc.o ../common/string.o image.o \
 	../common/ofcommon.o
-LIBS = $(TOPDIR)/lib/lib.a ../lib/zlib.a
+LIBS = $(TOPDIR)/lib/lib.o ../lib/zlib.a
 ADDNOTE = ../utils/addnote
 PIGGYBACK = ../utils/piggyback
 
diff -urdN linux/arch/ppc/boot/pmac/Makefile linux/arch/ppc/boot/pmac/Makefile
--- linux/arch/ppc/boot/pmac/Makefile	Tue Aug 28 13:58:33 2001
+++ linux/arch/ppc/boot/pmac/Makefile	Thu Jan 31 19:29:14 2002
@@ -15,7 +15,7 @@
 COMMONOBJS = start.o misc.o ../common/string.o image.o ../common/ofcommon.o
 COFFOBJS = ../common/coffcrt0.o $(COMMONOBJS) coffmain.o
 CHRPOBJS = ../common/crt0.o $(COMMONOBJS) chrpmain.o
-LIBS = $(TOPDIR)/lib/lib.a ../lib/zlib.a
+LIBS = $(TOPDIR)/lib/lib.o ../lib/zlib.a
 
 MKNOTE := ../utils/mknote
 SIZE := ../utils/size
diff -urdN linux/arch/sparc/Makefile linux/arch/sparc/Makefile
--- linux/arch/sparc/Makefile	Sat Jul 28 19:12:37 2001
+++ linux/arch/sparc/Makefile	Thu Jan 31 19:26:07 2002
@@ -41,7 +41,7 @@
 CORE_FILES := arch/sparc/kernel/kernel.o arch/sparc/mm/mm.o $(CORE_FILES) \
 	arch/sparc/math-emu/math-emu.o
 
-LIBS := $(TOPDIR)/lib/lib.a $(LIBS) $(TOPDIR)/arch/sparc/prom/promlib.a \
+LIBS := $(LIBS) $(TOPDIR)/arch/sparc/prom/promlib.a \
 	$(TOPDIR)/arch/sparc/lib/lib.a
 
 # This one has to come last
diff -urdN linux/arch/sparc64/Makefile linux/arch/sparc64/Makefile
--- linux/arch/sparc64/Makefile	Mon Jan 14 18:10:44 2002
+++ linux/arch/sparc64/Makefile	Thu Jan 31 19:30:09 2002
@@ -69,7 +69,7 @@
 
 CORE_FILES += arch/sparc64/math-emu/math-emu.o
 
-LIBS := $(TOPDIR)/lib/lib.a $(LIBS) $(TOPDIR)/arch/sparc64/prom/promlib.a \
+LIBS := $(LIBS) $(TOPDIR)/arch/sparc64/prom/promlib.a \
 	$(TOPDIR)/arch/sparc64/lib/lib.a
 
 vmlinux.aout: vmlinux
diff -urdN linux/include/asm-i386/system.h linux/include/asm-i386/system.h
--- linux/include/asm-i386/system.h	Wed Jan 30 05:41:09 2002
+++ linux/include/asm-i386/system.h	Thu Jan 31 20:38:16 2002
@@ -123,6 +123,8 @@
 	__asm__("movl %0,%%cr4": :"r" (x));
 #define stts() write_cr0(8 | read_cr0())
 
+#define HAVE_ARCH_BUST_SPINLOCKS
+
 #endif	/* __KERNEL__ */
 
 #define wbinvd() \
diff -urdN linux/include/asm-ia64/system.h linux/include/asm-ia64/system.h
--- linux/include/asm-ia64/system.h	Fri Nov  9 22:26:17 2001
+++ linux/include/asm-ia64/system.h	Thu Jan 31 20:38:55 2002
@@ -412,6 +412,8 @@
 } while (0)
 #endif
 
+#define HAVE_ARCH_BUST_SPINLOCKS
+
 #endif /* __KERNEL__ */
 
 #endif /* __ASSEMBLY__ */
diff -urdN linux/include/asm-mips64/system.h linux/include/asm-mips64/system.h
--- linux/include/asm-mips64/system.h	Wed Jul  4 18:50:39 2001
+++ linux/include/asm-mips64/system.h	Thu Jan 31 20:39:49 2002
@@ -256,4 +256,6 @@
 
 extern void set_except_vector(int n, void *addr);
 
+#define HAVE_ARCH_BUST_SPINLOCKS
+
 #endif /* _ASM_SYSTEM_H */
diff -urdN linux/include/asm-s390/system.h linux/include/asm-s390/system.h
--- linux/include/asm-s390/system.h	Wed Jul 25 21:12:02 2001
+++ linux/include/asm-s390/system.h	Thu Jan 31 20:40:24 2002
@@ -250,6 +250,9 @@
 extern void save_fp_regs(s390_fp_regs *fpregs);
 extern int restore_fp_regs1(s390_fp_regs *fpregs);
 extern void restore_fp_regs(s390_fp_regs *fpregs);
+
+#define HAVE_ARCH_BUST_SPINLOCKS
+
 #endif
 
 #endif
diff -urdN linux/include/asm-s390x/system.h linux/include/asm-s390x/system.h
--- linux/include/asm-s390x/system.h	Wed Jul 25 21:12:03 2001
+++ linux/include/asm-s390x/system.h	Thu Jan 31 20:40:40 2002
@@ -260,6 +260,9 @@
 extern void save_fp_regs(s390_fp_regs *fpregs);
 extern int restore_fp_regs1(s390_fp_regs *fpregs);
 extern void restore_fp_regs(s390_fp_regs *fpregs);
+
+#define HAVE_ARCH_BUST_SPINLOCKS
+
 #endif
 
 #endif
diff -urdN linux/lib/Makefile linux/lib/Makefile
--- linux/lib/Makefile	Wed Jan 30 05:30:41 2002
+++ linux/lib/Makefile	Thu Jan 31 20:28:16 2002
@@ -6,7 +6,7 @@
 # unless it's something special (ie not a .c file).
 #
 
-L_TARGET := lib.a
+O_TARGET := lib.o
 
 export-objs := cmdline.o dec_and_lock.o rwsem-spinlock.o rwsem.o crc32.o
 
diff -urdN linux/lib/bust_spinlocks.c linux/lib/bust_spinlocks.c
--- linux/lib/bust_spinlocks.c	Mon Sep 17 04:22:40 2001
+++ linux/lib/bust_spinlocks.c	Thu Jan 31 20:43:10 2002
@@ -14,6 +14,8 @@
 #include <linux/wait.h>
 #include <linux/vt_kern.h>
 
+#ifndef HAVE_ARCH_BUST_SPINLOCKS
+
 extern spinlock_t timerlist_lock;
 
 void bust_spinlocks(int yes)
@@ -38,4 +40,4 @@
 	}
 }
 
-
+#endif /* HAVE_ARCH_BUST_SPINLOCKS */
