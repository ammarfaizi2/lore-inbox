Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261877AbSJQItz>; Thu, 17 Oct 2002 04:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261882AbSJQItz>; Thu, 17 Oct 2002 04:49:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51641 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261877AbSJQItr>;
	Thu, 17 Oct 2002 04:49:47 -0400
Date: Thu, 17 Oct 2002 01:48:15 -0700 (PDT)
Message-Id: <20021017.014815.02276427.davem@redhat.com>
To: szepe@pinerecords.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.5 sparc32] trivial: fix up check_asm
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021017083102.GA20917@louise.pinerecords.com>
References: <20021017083102.GA20917@louise.pinerecords.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Peter Zaitcev just sent me a patch which handles this differently:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.793   -> 1.794  
#	arch/sparc/kernel/wuf.S	1.2     -> 1.3    
#	 arch/sparc/Makefile	1.12    -> 1.13   
#	arch/sparc/kernel/Makefile	1.9     -> 1.10   
#	arch/sparc/kernel/rtrap.S	1.7     -> 1.8    
#	arch/sparc/kernel/entry.S	1.6     -> 1.7    
#	arch/sparc/kernel/wof.S	1.2     -> 1.3    
#	arch/sparc/kernel/check_asm.sh	1.4     ->         (deleted)      
#	arch/sparc/kernel/sclow.S	1.2     -> 1.3    
#	include/asm-sparc/ptrace.h	1.1     -> 1.2    
#	arch/sparc/kernel/etrap.S	1.2     -> 1.3    
#	               (new)	        -> 1.1     arch/sparc/kernel/asm-offsets.c
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/10/17	zaitcev@redhat.com	1.794
# [sparc] Use Kai's way to make asm_offsets.h
# --------------------------------------------
#
diff -Nru a/arch/sparc/Makefile b/arch/sparc/Makefile
--- a/arch/sparc/Makefile	Thu Oct 17 01:51:11 2002
+++ b/arch/sparc/Makefile	Thu Oct 17 01:51:11 2002
@@ -1,4 +1,4 @@
-# $Id: Makefile,v 1.49 2001/07/27 09:42:22 davem Exp $
+#
 # sparc/Makefile
 #
 # Makefile for the architecture dependent flags and dependencies on the
@@ -47,16 +47,24 @@
 	$(MAKE) -C arch/sparc/boot image
 
 archclean:
+	rm -f arch/sparc/kernel/include
 	rm -f $(TOPDIR)/vmlinux.aout
 	-$(MAKE) -C arch/sparc/boot clean
 
 archmrproper:
 	rm -f $(TOPDIR)/include/asm-sparc/asm_offsets.h
 
-prepare: check_asm
+prepare: include/asm-$(ARCH)/asm_offsets.h
+
+arch/$(ARCH)/kernel/asm-offsets.s: include/asm include/linux/version.h \
+				   include/config/MARKER
+
+include/asm-$(ARCH)/asm_offsets.h.tmp: arch/$(ARCH)/kernel/asm-offsets.s
+	@$(generate-asm-offsets.h) < $< > $@
 
-check_asm: include/linux/version.h include/asm include/config/MARKER
-	$(MAKE) -C arch/sparc/kernel check_asm
+include/asm-$(ARCH)/asm_offsets.h: include/asm-$(ARCH)/asm_offsets.h.tmp
+	@echo -n '  Generating $@'
+	@$(update-if-changed)
 
 tftpboot.img:
 	$(MAKE) -C arch/sparc/boot tftpboot.img
diff -Nru a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
--- a/arch/sparc/kernel/Makefile	Thu Oct 17 01:51:11 2002
+++ b/arch/sparc/kernel/Makefile	Thu Oct 17 01:51:11 2002
@@ -28,95 +28,3 @@
 endif
 
 include $(TOPDIR)/Rules.make
-
-HPATH := $(objtree)/include
-
-check_asm: FORCE
-	@if [ ! -r $(HPATH)/asm/asm_offsets.h ] ; then \
-	  touch $(HPATH)/asm/asm_offsets.h ; \
-	fi
-	@echo "/* Automatically generated. Do not edit. */" > asm_offsets.h
-	@echo "#ifndef __ASM_OFFSETS_H__" >> asm_offsets.h
-	@echo "#define __ASM_OFFSETS_H__" >> asm_offsets.h
-	@echo "" >> asm_offsets.h
-	@echo "#include <linux/config.h>" >> asm_offsets.h
-	@echo "" >> asm_offsets.h
-	@echo "#ifndef CONFIG_SMP" >> asm_offsets.h
-	@echo "" >> asm_offsets.h
-	@echo "#include <linux/config.h>" > tmp.c
-	@echo "#undef CONFIG_SMP" >> tmp.c
-	@echo "#include <linux/sched.h>" >> tmp.c
-	$(CPP) $(CPPFLAGS) tmp.c -o tmp.i
-	@echo "/* Automatically generated. Do not edit. */" > check_asm_data.c
-	@echo "#include <linux/config.h>" >> check_asm_data.c
-	@echo "#undef CONFIG_SMP" >> check_asm_data.c
-	@echo "#include <linux/sched.h>" >> check_asm_data.c
-	@echo "unsigned int check_asm_data[] = {" >> check_asm_data.c
-	$(SH) ./check_asm.sh -data task tmp.i check_asm_data.c
-	$(SH) ./check_asm.sh -data mm tmp.i check_asm_data.c
-	$(SH) ./check_asm.sh -data thread tmp.i check_asm_data.c
-	@echo '};' >> check_asm_data.c
-	$(CC) $(CFLAGS) -S -o check_asm_data.s check_asm_data.c
-	@echo "/* Automatically generated. Do not edit. */" > check_asm.c
-	@echo 'extern int printf(const char *fmt, ...);' >>check_asm.c
-	@echo "unsigned int check_asm_data[] = {" >> check_asm.c
-	$(SH) ./check_asm.sh -ints check_asm_data.s check_asm.c
-	@echo "};" >> check_asm.c
-	@echo 'int main(void) {' >> check_asm.c
-	@echo 'int i = 0;' >> check_asm.c
-	$(SH) ./check_asm.sh -printf task tmp.i check_asm.c
-	$(SH) ./check_asm.sh -printf mm tmp.i check_asm.c
-	$(SH) ./check_asm.sh -printf thread tmp.i check_asm.c
-	@echo 'return 0; }' >> check_asm.c
-	@rm -f tmp.[ci] check_asm_data.[cs]
-	$(HOSTCC) -o check_asm check_asm.c
-	./check_asm >> asm_offsets.h
-	@rm -f check_asm check_asm.c
-	@echo "" >> asm_offsets.h
-	@echo "#else /* CONFIG_SMP */" >> asm_offsets.h
-	@echo "" >> asm_offsets.h
-	@echo "#include <linux/config.h>" > tmp.c
-	@echo "#undef CONFIG_SMP" >> tmp.c
-	@echo "#define CONFIG_SMP 1" >> tmp.c
-	@echo "#include <linux/sched.h>" >> tmp.c
-	$(CPP) $(CPPFLAGS) tmp.c -o tmp.i
-	@echo "/* Automatically generated. Do not edit. */" > check_asm_data.c
-	@echo "#include <linux/config.h>" >> check_asm_data.c
-	@echo "#undef CONFIG_SMP" >> check_asm_data.c
-	@echo "#define CONFIG_SMP 1" >> check_asm_data.c
-	@echo "#include <linux/sched.h>" >> check_asm_data.c
-	@echo "unsigned int check_asm_data[] = {" >> check_asm_data.c
-	$(SH) ./check_asm.sh -data task tmp.i check_asm_data.c
-	$(SH) ./check_asm.sh -data mm tmp.i check_asm_data.c
-	$(SH) ./check_asm.sh -data thread tmp.i check_asm_data.c
-	@echo '};' >> check_asm_data.c
-	$(CC) $(CFLAGS) -S -o check_asm_data.s check_asm_data.c
-	@echo "/* Automatically generated. Do not edit. */" > check_asm.c
-	@echo 'extern int printf(const char *fmt, ...);' >>check_asm.c
-	@echo "unsigned int check_asm_data[] = {" >> check_asm.c
-	$(SH) ./check_asm.sh -ints check_asm_data.s check_asm.c
-	@echo "};" >> check_asm.c
-	@echo 'int main(void) {' >> check_asm.c
-	@echo 'int i = 0;' >> check_asm.c
-	$(SH) ./check_asm.sh -printf task tmp.i check_asm.c
-	$(SH) ./check_asm.sh -printf mm tmp.i check_asm.c
-	$(SH) ./check_asm.sh -printf thread tmp.i check_asm.c
-	@echo 'return 0; }' >> check_asm.c
-	@rm -f tmp.[ci] check_asm_data.[cs]
-	$(HOSTCC) -o check_asm check_asm.c
-	./check_asm >> asm_offsets.h
-	@rm -f check_asm check_asm.c
-	@echo "" >> asm_offsets.h
-	@echo "#endif /* CONFIG_SMP */" >> asm_offsets.h
-	@echo "" >> asm_offsets.h
-	@echo "#endif /* __ASM_OFFSETS_H__ */" >> asm_offsets.h
-	@if test -r $(HPATH)/asm/asm_offsets.h; then \
-	  if cmp -s asm_offsets.h $(HPATH)/asm/asm_offsets.h; then \
-	    echo $(HPATH)/asm/asm_offsets.h is unchanged; \
-	    rm -f asm_offsets.h; \
-	  else \
-	    mv -f asm_offsets.h $(HPATH)/asm/asm_offsets.h; \
-	  fi; \
-	else \
-	  mv -f asm_offsets.h $(HPATH)/asm/asm_offsets.h; \
-	fi
diff -Nru a/arch/sparc/kernel/asm-offsets.c b/arch/sparc/kernel/asm-offsets.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/sparc/kernel/asm-offsets.c	Thu Oct 17 01:51:11 2002
@@ -0,0 +1,53 @@
+/*
+ * This program is used to generate definitions needed by
+ * assembly language modules.
+ *
+ * We use the technique used in the OSF Mach kernel code:
+ * generate asm statements containing #defines,
+ * compile this file to assembler, and then extract the
+ * #defines from the assembly-language output.
+ *
+ * On sparc, thread_info data is static and TI_XXX offsets are computed by hand.
+ */
+
+#include <linux/config.h>
+#include <linux/sched.h>
+// #include <linux/mm.h>
+
+#define DEFINE(sym, val) \
+	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+
+#define BLANK() asm volatile("\n->" : : )
+
+int foo(void)
+{
+	DEFINE(AOFF_task_thread, offsetof(struct task_struct, thread));
+	DEFINE(AOFF_task_ptrace, offsetof(struct task_struct, ptrace));
+	DEFINE(AOFF_task_blocked, offsetof(struct task_struct, blocked));
+	BLANK();
+	/* XXX This is the stuff for sclow.S, kill it. */
+	DEFINE(AOFF_task_pid, offsetof(struct task_struct, pid));
+	DEFINE(AOFF_task_uid, offsetof(struct task_struct, uid));
+	DEFINE(AOFF_task_gid, offsetof(struct task_struct, gid));
+	DEFINE(AOFF_task_euid, offsetof(struct task_struct, euid));
+	DEFINE(AOFF_task_egid, offsetof(struct task_struct, egid));
+	/* DEFINE(THREAD_INFO, offsetof(struct task_struct, thread_info)); */
+	DEFINE(ASIZ_task_uid,	sizeof(current->uid));
+	DEFINE(ASIZ_task_gid,	sizeof(current->gid));
+	DEFINE(ASIZ_task_euid,	sizeof(current->euid));
+	DEFINE(ASIZ_task_egid,	sizeof(current->egid));
+	BLANK();
+	DEFINE(AOFF_thread_fork_kpsr,
+			offsetof(struct thread_struct, fork_kpsr));
+	BLANK();
+	DEFINE(AOFF_thread_w_saved, offsetof(struct thread_struct, w_saved));
+	DEFINE(AOFF_thread_rwbuf_stkptrs,
+			offsetof(struct thread_struct, rwbuf_stkptrs));
+	DEFINE(AOFF_thread_reg_window,
+			offsetof(struct thread_struct, reg_window));
+	BLANK();
+	DEFINE(AOFF_mm_context, offsetof(struct mm_struct, context));
+
+	/* DEFINE(NUM_USER_SEGMENTS, TASK_SIZE>>28); */
+	return 0;
+}
diff -Nru a/arch/sparc/kernel/check_asm.sh b/arch/sparc/kernel/check_asm.sh
--- a/arch/sparc/kernel/check_asm.sh	Thu Oct 17 01:51:11 2002
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,19 +0,0 @@
-#!/bin/sh
-case $1 in
-  -printf)
-    sed -n -e '/^#/d;/struct[ 	]*'$2'_struct[ 	]*{/,/};/p' < $3 | sed '/struct[ 	]*'$2'_struct[ 	]*{/d;/:[0-9]*[ 	]*;/d;/^[ 	]*$/d;/};/d;s/^[ 	]*//;s/volatile[ 	]*//;s/\(unsigned\|signed\|struct\)[ 	]*//;s/\(\[\|__attribute__\).*;[ 	]*$//;s/(\*//;s/)(.*)//;s/;[ 	]*$//;s/^[^ 	]*[ 	]*//;s/,/\
-/g' | sed 's/^[ 	*]*//;s/[ 	]*$//;s/^.*$/printf ("#define AOFF_'$2'_\0	0x%08x\\n", check_asm_data[i++]); printf("#define ASIZ_'$2'_\0	0x%08x\\n", check_asm_data[i++]);/' >> $4
-    echo "printf (\"#define ASIZ_$2\\t0x%08x\\n\", check_asm_data[i++]);" >> $4
-  ;;
-  -data)
-    sed -n -e '/^#/d;/struct[ 	]*'$2'_struct[ 	]*{/,/};/p' < $3 | sed '/struct[ 	]*'$2'_struct[ 	]*{/d;/:[0-9]*[ 	]*;/d;/^[ 	]*$/d;/};/d;s/^[ 	]*//;s/volatile[ 	]*//;s/\(unsigned\|signed\|struct\)[ 	]*//;s/\(\[\|__attribute__\).*;[ 	]*$//;s/(\*//;s/)(.*)//;s/;[ 	]*$//;s/^[^ 	]*[ 	]*//;s/,/\
-/g' | sed 's/^[ 	*]*//;s/[ 	]*$//;s/^.*$/	((char *)\&((struct '$2'_struct *)0)->\0) - ((char *)((struct '$2'_struct *)0)),	sizeof(((struct '$2'_struct *)0)->\0),/' >> $4
-    echo "	sizeof(struct $2_struct)," >> $4
-  ;;
-  -ints)
-    sed -n -e '/check_asm_data:/,/\.size/p' <$2 | sed -e 's/check_asm_data://' -e 's/\.size.*//' -e 's/\.ident.*//' -e 's/\.global.*//' -e 's/\.long[ 	]\([0-9]*\)/\1,/' >>$3  ;;
-  *)
-    exit 1
-  ;;
-esac
-exit 0
diff -Nru a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
--- a/arch/sparc/kernel/entry.S	Thu Oct 17 01:51:11 2002
+++ b/arch/sparc/kernel/entry.S	Thu Oct 17 01:51:11 2002
@@ -17,6 +17,7 @@
 #include <asm/kgdb.h>
 #include <asm/contregs.h>
 #include <asm/ptrace.h>
+#include <asm/asm_offsets.h>
 #include <asm/psr.h>
 #include <asm/cprefix.h>
 #include <asm/vaddrs.h>
diff -Nru a/arch/sparc/kernel/etrap.S b/arch/sparc/kernel/etrap.S
--- a/arch/sparc/kernel/etrap.S	Thu Oct 17 01:51:11 2002
+++ b/arch/sparc/kernel/etrap.S	Thu Oct 17 01:51:11 2002
@@ -12,6 +12,7 @@
 #include <asm/page.h>
 #include <asm/psr.h>
 #include <asm/ptrace.h>
+#include <asm/asm_offsets.h>
 #include <asm/winmacro.h>
 #include <asm/asmmacro.h>
 #include <asm/thread_info.h>
diff -Nru a/arch/sparc/kernel/rtrap.S b/arch/sparc/kernel/rtrap.S
--- a/arch/sparc/kernel/rtrap.S	Thu Oct 17 01:51:11 2002
+++ b/arch/sparc/kernel/rtrap.S	Thu Oct 17 01:51:11 2002
@@ -7,6 +7,7 @@
 #include <asm/cprefix.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
+#include <asm/asm_offsets.h>
 #include <asm/psr.h>
 #include <asm/asi.h>
 #include <asm/smp.h>
diff -Nru a/arch/sparc/kernel/sclow.S b/arch/sparc/kernel/sclow.S
--- a/arch/sparc/kernel/sclow.S	Thu Oct 17 01:51:11 2002
+++ b/arch/sparc/kernel/sclow.S	Thu Oct 17 01:51:11 2002
@@ -36,18 +36,6 @@
 LABEL(sunosnop):
 	CC_AND_RETT
 
-#if 0
-/* Not SMP safe */
-	.globl	LABEL(sunosgetpid)
-LABEL(sunosgetpid):
-	LOAD_CURRENT(l4, l5)
-	ld	[%l4 + TI_TASK], %l4
-	ld	[%l4 + AOFF_task_pid], %i0
-	ld	[%l4 + AOFF_task_p_opptr], %l5
-	ld	[%l5 + AOFF_task_pid], %i1
-	CC_AND_RETT
-#endif
-
 #if (ASIZ_task_uid == 2 && ASIZ_task_euid == 2)
 	.globl	LABEL(sunosgetuid)
 LABEL(sunosgetuid):
diff -Nru a/arch/sparc/kernel/wof.S b/arch/sparc/kernel/wof.S
--- a/arch/sparc/kernel/wof.S	Thu Oct 17 01:51:11 2002
+++ b/arch/sparc/kernel/wof.S	Thu Oct 17 01:51:11 2002
@@ -8,6 +8,7 @@
 #include <asm/contregs.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
+#include <asm/asm_offsets.h>
 #include <asm/psr.h>
 #include <asm/smp.h>
 #include <asm/asi.h>
diff -Nru a/arch/sparc/kernel/wuf.S b/arch/sparc/kernel/wuf.S
--- a/arch/sparc/kernel/wuf.S	Thu Oct 17 01:51:11 2002
+++ b/arch/sparc/kernel/wuf.S	Thu Oct 17 01:51:11 2002
@@ -8,6 +8,7 @@
 #include <asm/contregs.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
+#include <asm/asm_offsets.h>
 #include <asm/psr.h>
 #include <asm/smp.h>
 #include <asm/asi.h>
diff -Nru a/include/asm-sparc/ptrace.h b/include/asm-sparc/ptrace.h
--- a/include/asm-sparc/ptrace.h	Thu Oct 17 01:51:11 2002
+++ b/include/asm-sparc/ptrace.h	Thu Oct 17 01:51:11 2002
@@ -73,7 +73,12 @@
 #define REGWIN_SZ         0x40
 #endif
 
-#include <asm/asm_offsets.h>
+/*
+ * The asm_offsets.h is a generated file, so we cannot include it.
+ * It may be OK for glibc headers, but it's utterly pointless for C code.
+ * The assembly code using those offsets has to include it explicitly.
+ */
+/* #include <asm/asm_offsets.h> */
 
 /* These are for pt_regs. */
 #define PT_PSR    0x0
