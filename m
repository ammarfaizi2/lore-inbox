Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262090AbVAJF3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262090AbVAJF3i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 00:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbVAJF3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 00:29:37 -0500
Received: from pool-151-203-193-191.bos.east.verizon.net ([151.203.193.191]:17412
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262090AbVAJFOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 00:14:08 -0500
Message-Id: <200501100735.j0A7ZGPW005755@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/28] UML - x86-64 core support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 10 Jan 2005 02:35:16 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the new files from the x86_64 port which just drop in and don't
require any work anywhere else.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/Makefile
===================================================================
--- 2.6.10.orig/arch/um/Makefile	2005-01-09 19:09:20.000000000 -0500
+++ 2.6.10/arch/um/Makefile	2005-01-09 22:00:31.000000000 -0500
@@ -12,8 +12,7 @@
 filechk_gen_header = $<
 
 core-y			+= $(ARCH_DIR)/kernel/		\
-			   $(ARCH_DIR)/drivers/		\
-			   $(ARCH_DIR)/sys-$(SUBARCH)/
+			   $(ARCH_DIR)/drivers/
 
 # Have to precede the include because the included Makefiles reference them.
 SYMLINK_HEADERS = archparam.h system.h sigcontext.h processor.h ptrace.h \
@@ -38,6 +37,9 @@
 include $(srctree)/$(ARCH_DIR)/Makefile-$(SUBARCH)
 include $(srctree)/$(ARCH_DIR)/Makefile-os-$(OS)
 
+core-y += $(SUBARCH_CORE)
+libs-y += $(SUBARCH_LIBS)
+
 # -Derrno=kernel_errno - This turns all kernel references to errno into
 # kernel_errno to separate them from the libc errno.  This allows -fno-common
 # in CFLAGS.  Otherwise, it would cause ld to complain about the two different
Index: 2.6.10/arch/um/Makefile-i386
===================================================================
--- 2.6.10.orig/arch/um/Makefile-i386	2005-01-09 19:06:08.000000000 -0500
+++ 2.6.10/arch/um/Makefile-i386	2005-01-09 21:59:49.000000000 -0500
@@ -1,3 +1,5 @@
+SUBARCH_CORE := arch/um/sys-i386/
+
 ifeq ($(CONFIG_HOST_2G_2G), y)
 TOP_ADDR := 0x80000000
 else
Index: 2.6.10/arch/um/Makefile-x86_64
===================================================================
--- 2.6.10.orig/arch/um/Makefile-x86_64	2005-01-09 19:06:08.000000000 -0500
+++ 2.6.10/arch/um/Makefile-x86_64	2005-01-09 21:52:21.000000000 -0500
@@ -1 +1,36 @@
+# Copyright 2003 - 2004 Pathscale, Inc
+# Released under the GPL
+
+SUBARCH_LIBS := arch/um/sys-x86_64/
+START := 0x60000000
+
+CFLAGS += -U__$(SUBARCH)__ -fno-builtin
 ARCH_USER_CFLAGS := -D__x86_64__
+
+ELF_ARCH := i386:x86-64
+ELF_FORMAT := elf64-x86-64
+
+SYS_UTIL_DIR := $(ARCH_DIR)/sys-x86_64/util
+SYS_DIR := $(ARCH_DIR)/include/sysdep-x86_64
+
+SYS_HEADERS = $(SYS_DIR)/sc.h $(SYS_DIR)/thread.h
+
+prepare: $(SYS_HEADERS)
+
+$(SYS_DIR)/sc.h: $(SYS_UTIL_DIR)/mk_sc
+	$(call filechk,gen_header)
+
+$(SYS_DIR)/thread.h: $(SYS_UTIL_DIR)/mk_thread 
+	$(call filechk,gen_header)
+
+$(SYS_UTIL_DIR)/mk_sc: scripts_basic FORCE
+	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@
+
+$(SYS_UTIL_DIR)/mk_thread: scripts_basic $(ARCH_SYMLINKS) $(GEN_HEADERS) FORCE
+	$(Q)$(MAKE) $(build)=$(SYS_UTIL_DIR) $@
+
+CLEAN_FILES += $(SYS_HEADERS)
+
+LIBC_DIR := /usr/lib64
+
+export LIBC_DIR
Index: 2.6.10/arch/um/include/sysdep-x86_64/checksum.h
===================================================================
--- 2.6.10.orig/arch/um/include/sysdep-x86_64/checksum.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/include/sysdep-x86_64/checksum.h	2005-01-09 19:09:42.000000000 -0500
@@ -0,0 +1,151 @@
+/* 
+ * Licensed under the GPL
+ */
+
+#ifndef __UM_SYSDEP_CHECKSUM_H
+#define __UM_SYSDEP_CHECKSUM_H
+
+#include "linux/string.h"
+#include "linux/in6.h"
+#include "asm/uaccess.h"
+
+extern unsigned int csum_partial_copy_from(const char *src, char *dst, int len,
+					   int sum, int *err_ptr);
+extern unsigned csum_partial(const unsigned char *buff, unsigned len, 
+                             unsigned sum);
+
+/*
+ *	Note: when you get a NULL pointer exception here this means someone
+ *	passed in an incorrect kernel address to one of these functions.
+ *
+ *	If you use these functions directly please don't forget the
+ *	verify_area().
+ */
+
+static __inline__
+unsigned int csum_partial_copy_nocheck(const char *src, char *dst,
+				       int len, int sum)
+{
+	memcpy(dst, src, len);
+	return(csum_partial(dst, len, sum));
+}
+
+static __inline__
+unsigned int csum_partial_copy_from_user(const char *src, char *dst,
+					 int len, int sum, int *err_ptr)
+{
+	return csum_partial_copy_from(src, dst, len, sum, err_ptr);
+}
+
+/** 
+ * csum_fold - Fold and invert a 32bit checksum.
+ * sum: 32bit unfolded sum
+ * 
+ * Fold a 32bit running checksum to 16bit and invert it. This is usually
+ * the last step before putting a checksum into a packet.
+ * Make sure not to mix with 64bit checksums.
+ */
+static inline unsigned int csum_fold(unsigned int sum)
+{
+	__asm__(
+		"  addl %1,%0\n"
+		"  adcl $0xffff,%0"
+		: "=r" (sum)
+		: "r" (sum << 16), "0" (sum & 0xffff0000)
+	);
+	return (~sum) >> 16;
+}
+
+/** 
+ * csum_tcpup_nofold - Compute an IPv4 pseudo header checksum.
+ * @saddr: source address
+ * @daddr: destination address
+ * @len: length of packet
+ * @proto: ip protocol of packet
+ * @sum: initial sum to be added in (32bit unfolded) 
+ * 
+ * Returns the pseudo header checksum the input data. Result is 
+ * 32bit unfolded.
+ */
+static inline unsigned long 
+csum_tcpudp_nofold(unsigned saddr, unsigned daddr, unsigned short len,
+		   unsigned short proto, unsigned int sum) 
+{
+	asm("  addl %1, %0\n"
+	    "  adcl %2, %0\n"
+	    "  adcl %3, %0\n"
+	    "  adcl $0, %0\n"
+		: "=r" (sum)
+	    : "g" (daddr), "g" (saddr), "g" ((ntohs(len)<<16)+proto*256), "0" (sum));
+    return sum;
+}
+
+/*
+ * computes the checksum of the TCP/UDP pseudo-header
+ * returns a 16-bit checksum, already complemented
+ */
+static inline unsigned short int csum_tcpudp_magic(unsigned long saddr,
+						   unsigned long daddr,
+						   unsigned short len,
+						   unsigned short proto,
+						   unsigned int sum)
+{
+	return csum_fold(csum_tcpudp_nofold(saddr,daddr,len,proto,sum));
+}
+
+/**
+ * ip_fast_csum - Compute the IPv4 header checksum efficiently.
+ * iph: ipv4 header
+ * ihl: length of header / 4
+ */ 
+static inline unsigned short ip_fast_csum(unsigned char *iph, unsigned int ihl) 
+{
+	unsigned int sum;
+
+	asm(	"  movl (%1), %0\n"
+		"  subl $4, %2\n"
+		"  jbe 2f\n"
+		"  addl 4(%1), %0\n"
+		"  adcl 8(%1), %0\n"
+		"  adcl 12(%1), %0\n"
+		"1: adcl 16(%1), %0\n"
+		"  lea 4(%1), %1\n"
+		"  decl %2\n"
+		"  jne	1b\n"
+		"  adcl $0, %0\n"
+		"  movl %0, %2\n"
+		"  shrl $16, %0\n"
+		"  addw %w2, %w0\n"
+		"  adcl $0, %0\n"
+		"  notl %0\n"
+		"2:"
+	/* Since the input registers which are loaded with iph and ipl
+	   are modified, we must also specify them as outputs, or gcc
+	   will assume they contain their original values. */
+	: "=r" (sum), "=r" (iph), "=r" (ihl)
+	: "1" (iph), "2" (ihl)
+	: "memory");
+	return(sum);
+}
+
+static inline unsigned add32_with_carry(unsigned a, unsigned b)
+{
+        asm("addl %2,%0\n\t"
+            "adcl $0,%0" 
+            : "=r" (a) 
+            : "0" (a), "r" (b));
+        return a;
+}
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: 2.6.10/arch/um/include/sysdep-x86_64/sigcontext.h
===================================================================
--- 2.6.10.orig/arch/um/include/sysdep-x86_64/sigcontext.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/include/sysdep-x86_64/sigcontext.h	2005-01-09 21:46:47.000000000 -0500
@@ -0,0 +1,49 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#ifndef __SYSDEP_X86_64_SIGCONTEXT_H
+#define __SYSDEP_X86_64_SIGCONTEXT_H
+
+#include "sc.h"
+
+#define IP_RESTART_SYSCALL(ip) ((ip) -= 2)
+
+#define SC_RESTART_SYSCALL(sc) IP_RESTART_SYSCALL(SC_IP(sc))
+#define SC_SET_SYSCALL_RETURN(sc, result) SC_RAX(sc) = (result)
+
+#define SC_FAULT_ADDR(sc) SC_CR2(sc)
+#define SC_FAULT_TYPE(sc) SC_ERR(sc)
+
+#define FAULT_WRITE(err) ((err) & 2)
+
+#define SC_FAULT_WRITE(sc) FAULT_WRITE(SC_FAULT_TYPE(sc))
+
+#define SC_TRAP_TYPE(sc) SC_TRAPNO(sc)
+
+/* ptrace expects that, at the start of a system call, %eax contains
+ * -ENOSYS, so this makes it so.
+ */
+
+#define SC_START_SYSCALL(sc) do SC_RAX(sc) = -ENOSYS; while(0)
+
+#define SEGV_IS_FIXABLE(trap) ((trap) == 14)
+#define SC_SEGV_IS_FIXABLE(sc) SEGV_IS_FIXABLE(SC_TRAP_TYPE(sc))
+
+extern unsigned long *sc_sigmask(void *sc_ptr);
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
+
Index: 2.6.10/arch/um/kernel/tt/Makefile
===================================================================
--- 2.6.10.orig/arch/um/kernel/tt/Makefile	2005-01-09 19:06:08.000000000 -0500
+++ 2.6.10/arch/um/kernel/tt/Makefile	2005-01-09 19:09:42.000000000 -0500
@@ -24,6 +24,9 @@
 $(obj)/unmap.o: $(src)/unmap.c
 	$(CC) $(UNMAP_CFLAGS) -c -o $@ $<
 
+LIBC_DIR ?= /usr/lib
+
 $(obj)/unmap_fin.o : $(obj)/unmap.o
-	ld -r -o $(obj)/unmap_tmp.o  $< -lc -L/usr/lib
+	ld -r -o $(obj)/unmap_tmp.o  $< -lc -L$(LIBC_DIR)
 	objcopy $(obj)/unmap_tmp.o $@ -G switcheroo
+
Index: 2.6.10/arch/um/sys-x86_64/Makefile
===================================================================
--- 2.6.10.orig/arch/um/sys-x86_64/Makefile	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/sys-x86_64/Makefile	2005-01-09 22:00:31.000000000 -0500
@@ -0,0 +1,39 @@
+#
+# Copyright 2003 PathScale, Inc.
+#
+# Licensed under the GPL
+#
+
+lib-y = bitops.o bugs.o csum-partial.o fault.o mem.o memcpy.o \
+	ptrace.o semaphore.o sigcontext.o signal.o syscalls.o \
+	sysrq.o thunk.o
+
+USER_OBJS := sigcontext.o
+USER_OBJS := $(foreach file,$(USER_OBJS),$(obj)/$(file))
+
+SYMLINKS = bitops.c csum-copy.S csum-partial.c csum-wrappers.c memcpy.S \
+	semaphore.c thunk.S
+SYMLINKS := $(foreach f,$(SYMLINKS),$(src)/$f)
+
+clean-files := $(SYMLINKS)
+
+bitops.c-dir = lib
+csum-copy.S-dir = lib
+csum-partial.c-dir = lib
+csum-wrappers.c-dir = lib
+memcpy.S-dir = lib
+semaphore.c-dir = kernel
+thunk.S-dir = lib
+
+define make_link
+       -rm -f $1
+       ln -sf $(TOPDIR)/arch/x86_64/$($(notdir $1)-dir)/$(notdir $1) $1
+endef
+
+$(SYMLINKS): 
+	$(call make_link,$@)
+
+$(USER_OBJS) : %.o: %.c
+	$(CC) $(CFLAGS_$(notdir $@)) $(USER_CFLAGS) -c -o $@ $<
+
+CFLAGS_csum-partial.o := -Dcsum_partial=arch_csum_partial
Index: 2.6.10/arch/um/sys-x86_64/bugs.c
===================================================================
--- 2.6.10.orig/arch/um/sys-x86_64/bugs.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/sys-x86_64/bugs.c	2005-01-09 22:00:41.000000000 -0500
@@ -0,0 +1,122 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#include "linux/sched.h"
+#include "linux/errno.h"
+#include "asm/system.h"
+#include "asm/pda.h"
+#include "sysdep/ptrace.h"
+#include "os.h"
+
+void arch_init_thread(void)
+{
+}
+
+void arch_check_bugs(void)
+{
+}
+
+int arch_handle_signal(int sig, union uml_pt_regs *regs)
+{
+	return(0);
+}
+
+#define MAXTOKEN 64
+
+/* Set during early boot */
+int host_has_cmov = 1;
+int host_has_xmm = 0;
+
+static char token(int fd, char *buf, int len, char stop)
+{
+	int n;
+	char *ptr, *end, c;
+
+	ptr = buf;
+	end = &buf[len];
+	do {
+		n = os_read_file(fd, ptr, sizeof(*ptr));
+		c = *ptr++;
+		if(n != sizeof(*ptr)){
+			if(n == 0) return(0);
+			printk("Reading /proc/cpuinfo failed, err = %d\n", -n);
+			if(n < 0) 
+				return(n);
+			else 
+				return(-EIO);
+		}
+	} while((c != '\n') && (c != stop) && (ptr < end));
+
+	if(ptr == end){
+		printk("Failed to find '%c' in /proc/cpuinfo\n", stop);
+		return(-1);
+	}
+	*(ptr - 1) = '\0';
+	return(c);
+}
+
+static int find_cpuinfo_line(int fd, char *key, char *scratch, int len)
+{
+	int n;
+	char c;
+
+	scratch[len - 1] = '\0';
+	while(1){
+		c = token(fd, scratch, len - 1, ':');
+		if(c <= 0)
+			return(0);
+		else if(c != ':'){
+			printk("Failed to find ':' in /proc/cpuinfo\n");
+			return(0);
+		}
+
+		if(!strncmp(scratch, key, strlen(key))) 
+			return(1);
+
+		do {
+			n = os_read_file(fd, &c, sizeof(c));
+			if(n != sizeof(c)){
+				printk("Failed to find newline in "
+				       "/proc/cpuinfo, err = %d\n", -n);
+				return(0);
+			}
+		} while(c != '\n');
+	}
+	return(0);
+}
+
+int cpu_feature(char *what, char *buf, int len)
+{
+	int fd, ret = 0;
+
+	fd = os_open_file("/proc/cpuinfo", of_read(OPENFLAGS()), 0);
+	if(fd < 0){
+		printk("Couldn't open /proc/cpuinfo, err = %d\n", -fd);
+		return(0);
+	}
+
+	if(!find_cpuinfo_line(fd, what, buf, len)){
+		printk("Couldn't find '%s' line in /proc/cpuinfo\n", what);
+		goto out_close;
+	}
+
+	token(fd, buf, len, '\n');
+	ret = 1;
+
+ out_close:
+	os_close_file(fd);
+	return(ret);
+}
+
+/* Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: 2.6.10/arch/um/sys-x86_64/fault.c
===================================================================
--- 2.6.10.orig/arch/um/sys-x86_64/fault.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/sys-x86_64/fault.c	2005-01-09 19:09:42.000000000 -0500
@@ -0,0 +1,23 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#include "user.h"
+
+int arch_fixup(unsigned long address, void *sc_ptr)
+{
+	/* XXX search_exception_tables() */
+	return(0);
+}
+
+/* Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: 2.6.10/arch/um/sys-x86_64/mem.c
===================================================================
--- 2.6.10.orig/arch/um/sys-x86_64/mem.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/sys-x86_64/mem.c	2005-01-09 19:09:42.000000000 -0500
@@ -0,0 +1,25 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#include "linux/mm.h"
+#include "asm/page.h"
+#include "asm/mman.h"
+
+unsigned long vm_stack_flags = __VM_STACK_FLAGS; 
+unsigned long vm_stack_flags32 = __VM_STACK_FLAGS; 
+unsigned long vm_data_default_flags = __VM_DATA_DEFAULT_FLAGS; 
+unsigned long vm_data_default_flags32 = __VM_DATA_DEFAULT_FLAGS; 
+unsigned long vm_force_exec32 = PROT_EXEC;
+
+/* Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: 2.6.10/arch/um/sys-x86_64/sigcontext.c
===================================================================
--- 2.6.10.orig/arch/um/sys-x86_64/sigcontext.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/sys-x86_64/sigcontext.c	2005-01-09 19:09:42.000000000 -0500
@@ -0,0 +1,39 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <signal.h>
+#include "user.h"
+
+void sc_to_sc(void *to_ptr, void *from_ptr)
+{
+        struct sigcontext *to = to_ptr, *from = from_ptr;
+        int size = sizeof(*to); /* + sizeof(struct _fpstate); */
+
+        memcpy(to, from, size);
+        if(from->fpstate != NULL)
+		to->fpstate = (struct _fpstate *) (to + 1);
+
+	to->fpstate = NULL;
+}
+
+unsigned long *sc_sigmask(void *sc_ptr)
+{
+	struct sigcontext *sc = sc_ptr;
+
+	return(&sc->oldmask);
+}
+
+/* Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: 2.6.10/arch/um/sys-x86_64/signal.c
===================================================================
--- 2.6.10.orig/arch/um/sys-x86_64/signal.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/sys-x86_64/signal.c	2005-01-09 22:01:10.000000000 -0500
@@ -0,0 +1,276 @@
+/* 
+ * Copyright (C) 2003 PathScale, Inc.
+ * Licensed under the GPL
+ */
+
+#include "linux/stddef.h"
+#include "linux/errno.h"
+#include "linux/personality.h"
+#include "linux/ptrace.h"
+#include "asm/current.h"
+#include "asm/uaccess.h"
+#include "asm/sigcontext.h"
+#include "asm/ptrace.h"
+#include "asm/arch/ucontext.h"
+#include "choose-mode.h"
+#include "sysdep/ptrace.h"
+#include "frame_kern.h"
+
+#ifdef CONFIG_MODE_SKAS
+
+#include "skas.h"
+
+static int copy_sc_from_user_skas(struct pt_regs *regs, 
+                                 struct sigcontext *from)
+{
+       int err = 0;
+
+#define GETREG(regs, regno, sc, regname) \
+       __get_user((regs)->regs.skas.regs[(regno) / sizeof(unsigned long)], \
+                  &(sc)->regname)
+
+       err |= GETREG(regs, R8, from, r8);
+       err |= GETREG(regs, R9, from, r9);
+       err |= GETREG(regs, R10, from, r10);
+       err |= GETREG(regs, R11, from, r11);
+       err |= GETREG(regs, R12, from, r12);
+       err |= GETREG(regs, R13, from, r13);
+       err |= GETREG(regs, R14, from, r14);
+       err |= GETREG(regs, R15, from, r15);
+       err |= GETREG(regs, RDI, from, rdi);
+       err |= GETREG(regs, RSI, from, rsi);
+       err |= GETREG(regs, RBP, from, rbp);
+       err |= GETREG(regs, RBX, from, rbx);
+       err |= GETREG(regs, RDX, from, rdx);
+       err |= GETREG(regs, RAX, from, rax);
+       err |= GETREG(regs, RCX, from, rcx);
+       err |= GETREG(regs, RSP, from, rsp);
+       err |= GETREG(regs, RIP, from, rip);
+       err |= GETREG(regs, EFLAGS, from, eflags);
+       err |= GETREG(regs, CS, from, cs);
+
+#undef GETREG
+
+       return(err);
+}
+
+int copy_sc_to_user_skas(struct sigcontext *to, struct _fpstate *to_fp, 
+                        struct pt_regs *regs, unsigned long mask)
+{
+	unsigned long eflags;
+	int err = 0;
+
+	err |= __put_user(0, &to->gs);
+	err |= __put_user(0, &to->fs);
+
+#define PUTREG(regs, regno, sc, regname) \
+       __put_user((regs)->regs.skas.regs[(regno) / sizeof(unsigned long)], \
+                  &(sc)->regname)
+
+	err |= PUTREG(regs, RDI, to, rdi);
+	err |= PUTREG(regs, RSI, to, rsi);
+	err |= PUTREG(regs, RBP, to, rbp);
+	err |= PUTREG(regs, RSP, to, rsp);
+	err |= PUTREG(regs, RBX, to, rbx);
+	err |= PUTREG(regs, RDX, to, rdx);
+	err |= PUTREG(regs, RCX, to, rcx);
+	err |= PUTREG(regs, RAX, to, rax);
+	err |= PUTREG(regs, R8, to, r8);
+	err |= PUTREG(regs, R9, to, r9);
+	err |= PUTREG(regs, R10, to, r10);
+	err |= PUTREG(regs, R11, to, r11);
+	err |= PUTREG(regs, R12, to, r12);
+	err |= PUTREG(regs, R13, to, r13);
+	err |= PUTREG(regs, R14, to, r14);
+	err |= PUTREG(regs, R15, to, r15);
+	err |= PUTREG(regs, CS, to, cs); /* XXX x86_64 doesn't do this */
+	err |= __put_user(current->thread.err, &to->err);
+	err |= __put_user(current->thread.trap_no, &to->trapno);
+	err |= PUTREG(regs, RIP, to, rip);
+	err |= PUTREG(regs, EFLAGS, to, eflags);
+#undef PUTREG
+
+	err |= __put_user(mask, &to->oldmask);
+	err |= __put_user(current->thread.cr2, &to->cr2);
+
+	return(err);
+}
+
+#endif
+
+#ifdef CONFIG_MODE_TT
+int copy_sc_from_user_tt(struct sigcontext *to, struct sigcontext *from, 
+                        int fpsize)
+{
+       struct _fpstate *to_fp, *from_fp;
+       unsigned long sigs;
+       int err;
+
+       to_fp = to->fpstate;
+       from_fp = from->fpstate;
+       sigs = to->oldmask;
+       err = copy_from_user(to, from, sizeof(*to));
+       to->oldmask = sigs;
+       return(err);
+}
+
+int copy_sc_to_user_tt(struct sigcontext *to, struct _fpstate *fp, 
+                      struct sigcontext *from, int fpsize)
+{
+       struct _fpstate *to_fp, *from_fp;
+       int err;
+
+       to_fp = (fp ? fp : (struct _fpstate *) (to + 1));
+       from_fp = from->fpstate;
+       err = copy_to_user(to, from, sizeof(*to));
+       return(err);
+}
+
+#endif
+
+static int copy_sc_from_user(struct pt_regs *to, void *from)
+{
+       int ret;
+
+       ret = CHOOSE_MODE(copy_sc_from_user_tt(UPT_SC(&to->regs), from,
+                                              sizeof(struct _fpstate)),
+                         copy_sc_from_user_skas(to, from));
+       return(ret);
+}
+
+static int copy_sc_to_user(struct sigcontext *to, struct _fpstate *fp, 
+                          struct pt_regs *from, unsigned long mask)
+{
+       return(CHOOSE_MODE(copy_sc_to_user_tt(to, fp, UPT_SC(&from->regs),
+                                             sizeof(*fp)),
+                          copy_sc_to_user_skas(to, fp, from, mask)));
+}
+
+struct rt_sigframe
+{
+       char *pretcode;
+       struct ucontext uc;
+       struct siginfo info;
+};
+
+#define round_down(m, n) (((m) / (n)) * (n))
+
+int setup_signal_stack_si(unsigned long stack_top, int sig, 
+			  struct k_sigaction *ka, struct pt_regs * regs, 
+			  siginfo_t *info, sigset_t *set)
+{
+	struct rt_sigframe __user *frame;
+	struct _fpstate __user *fp = NULL; 
+	int err = 0;
+	struct task_struct *me = current;
+
+	frame = (struct rt_sigframe __user *)
+		round_down(stack_top - sizeof(struct rt_sigframe), 16) - 8;
+	frame -= 128;
+
+	if (!access_ok(VERIFY_WRITE, fp, sizeof(struct _fpstate)))
+		goto out;
+
+#if 0 /* XXX */	
+	if (save_i387(fp) < 0) 
+		err |= -1; 
+#endif
+	if (!access_ok(VERIFY_WRITE, frame, sizeof(*frame)))
+		goto out;
+
+	if (ka->sa.sa_flags & SA_SIGINFO) { 
+		err |= copy_siginfo_to_user(&frame->info, info);
+		if (err)
+			goto out;
+	}
+		
+	/* Create the ucontext.  */
+	err |= __put_user(0, &frame->uc.uc_flags);
+	err |= __put_user(0, &frame->uc.uc_link);
+	err |= __put_user(me->sas_ss_sp, &frame->uc.uc_stack.ss_sp);
+	err |= __put_user(sas_ss_flags(PT_REGS_SP(regs)),
+			  &frame->uc.uc_stack.ss_flags);
+	err |= __put_user(me->sas_ss_size, &frame->uc.uc_stack.ss_size);
+	err |= copy_sc_to_user(&frame->uc.uc_mcontext, fp, regs, set->sig[0]);
+	err |= __put_user(fp, &frame->uc.uc_mcontext.fpstate);
+	if (sizeof(*set) == 16) { 
+		__put_user(set->sig[0], &frame->uc.uc_sigmask.sig[0]);
+		__put_user(set->sig[1], &frame->uc.uc_sigmask.sig[1]); 
+	} 
+	else
+		err |= __copy_to_user(&frame->uc.uc_sigmask, set, 
+				      sizeof(*set));
+
+	/* Set up to return from userspace.  If provided, use a stub
+	   already in userspace.  */
+	/* x86-64 should always use SA_RESTORER. */
+	if (ka->sa.sa_flags & SA_RESTORER)
+		err |= __put_user(ka->sa.sa_restorer, &frame->pretcode);
+	else
+		/* could use a vstub here */
+		goto out; 
+
+	if (err)
+		goto out;
+
+	/* Set up registers for signal handler */
+	{ 
+		struct exec_domain *ed = current_thread_info()->exec_domain;
+		if (unlikely(ed && ed->signal_invmap && sig < 32))
+			sig = ed->signal_invmap[sig];
+	}
+
+	PT_REGS_RDI(regs) = sig;
+	/* In case the signal handler was declared without prototypes */
+	PT_REGS_RAX(regs) = 0;
+
+	/* This also works for non SA_SIGINFO handlers because they expect the
+	   next argument after the signal number on the stack. */
+	PT_REGS_RSI(regs) = (unsigned long) &frame->info; 
+	PT_REGS_RDX(regs) = (unsigned long) &frame->uc; 
+	PT_REGS_RIP(regs) = (unsigned long) ka->sa.sa_handler;
+
+	PT_REGS_RSP(regs) = (unsigned long) frame;
+ out:
+	return(err);
+}
+
+long sys_rt_sigreturn(struct pt_regs *regs)
+{
+	unsigned long __user sp = PT_REGS_SP(&current->thread.regs);
+	struct rt_sigframe __user *frame = 
+		(struct rt_sigframe __user *)(sp - 8);
+	struct ucontext __user *uc = &frame->uc;
+	sigset_t set;
+
+	if(copy_from_user(&set, &uc->uc_sigmask, sizeof(set)))
+		goto segfault;
+
+	sigdelsetmask(&set, ~_BLOCKABLE);
+
+	spin_lock_irq(&current->sighand->siglock);
+	current->blocked = set;
+	recalc_sigpending();
+	spin_unlock_irq(&current->sighand->siglock);
+	
+	if(copy_sc_from_user(&current->thread.regs, &uc->uc_mcontext))
+		goto segfault;
+
+	/* Avoid ERESTART handling */
+	PT_REGS_SYSCALL_NR(&current->thread.regs) = -1;
+	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
+
+ segfault:
+	force_sig(SIGSEGV, current);
+	return 0;
+}	
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: 2.6.10/arch/um/sys-x86_64/sysrq.c
===================================================================
--- 2.6.10.orig/arch/um/sys-x86_64/sysrq.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/sys-x86_64/sysrq.c	2005-01-09 22:01:34.000000000 -0500
@@ -0,0 +1,49 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#include "linux/kernel.h"
+#include "linux/version.h"
+#include "linux/module.h"
+#include "asm/current.h"
+#include "asm/ptrace.h"
+#include "sysrq.h"
+
+void __show_regs(struct pt_regs * regs)
+{
+	printk("\n");
+	print_modules();
+	printk("Pid: %d, comm: %.20s %s %s\n", 
+	       current->pid, current->comm, print_tainted(), UTS_RELEASE);
+	printk("RIP: %04lx:[<%016lx>] ", PT_REGS_CS(regs) & 0xffff, 
+	       PT_REGS_RIP(regs));
+	printk("\nRSP: %016lx  EFLAGS: %08lx\n", PT_REGS_RSP(regs), 
+	       PT_REGS_EFLAGS(regs));
+	printk("RAX: %016lx RBX: %016lx RCX: %016lx\n",
+	       PT_REGS_RAX(regs), PT_REGS_RBX(regs), PT_REGS_RCX(regs));
+	printk("RDX: %016lx RSI: %016lx RDI: %016lx\n",
+	       PT_REGS_RDX(regs), PT_REGS_RSI(regs), PT_REGS_RDI(regs)); 
+	printk("RBP: %016lx R08: %016lx R09: %016lx\n",
+	       PT_REGS_RBP(regs), PT_REGS_R8(regs), PT_REGS_R9(regs)); 
+	printk("R10: %016lx R11: %016lx R12: %016lx\n",
+	       PT_REGS_R10(regs), PT_REGS_R11(regs), PT_REGS_R12(regs)); 
+	printk("R13: %016lx R14: %016lx R15: %016lx\n",
+	       PT_REGS_R13(regs), PT_REGS_R14(regs), PT_REGS_R15(regs)); 
+}
+
+void show_regs(struct pt_regs *regs)
+{
+	__show_regs(regs);
+	show_trace((unsigned long *) &regs);
+}
+
+/* Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: 2.6.10/arch/um/sys-x86_64/util/Makefile
===================================================================
--- 2.6.10.orig/arch/um/sys-x86_64/util/Makefile	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/sys-x86_64/util/Makefile	2005-01-09 19:09:42.000000000 -0500
@@ -0,0 +1,10 @@
+# Copyright 2003 - 2004 Pathscale, Inc
+# Released under the GPL
+
+hostprogs-y	:= mk_sc mk_thread
+always		:= $(hostprogs-y)
+
+mk_thread-objs	:= mk_thread_kern.o mk_thread_user.o
+
+HOSTCFLAGS_mk_thread_kern.o	:= $(CFLAGS) $(CPPFLAGS)
+HOSTCFLAGS_mk_thread_user.o	:= $(USER_CFLAGS)
Index: 2.6.10/arch/um/sys-x86_64/util/mk_sc.c
===================================================================
--- 2.6.10.orig/arch/um/sys-x86_64/util/mk_sc.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/sys-x86_64/util/mk_sc.c	2005-01-09 19:09:42.000000000 -0500
@@ -0,0 +1,58 @@
+/* Copyright (C) 2003 - 2004 PathScale, Inc
+ * Released under the GPL
+ */
+
+#include <stdio.h>
+#include <signal.h>
+#include <linux/stddef.h>
+
+#define SC_OFFSET(name, field) \
+  printf("#define " name \
+	 "(sc) *((unsigned long *) &(((char *) (sc))[%ld]))\n",\
+	 offsetof(struct sigcontext, field))
+
+#define SC_FP_OFFSET(name, field) \
+  printf("#define " name \
+	 "(sc) *((unsigned long *) &(((char *) (SC_FPSTATE(sc)))[%ld]))\n",\
+	 offsetof(struct _fpstate, field))
+
+#define SC_FP_OFFSET_PTR(name, field, type) \
+  printf("#define " name \
+	 "(sc) ((" type " *) &(((char *) (SC_FPSTATE(sc)))[%d]))\n",\
+	 offsetof(struct _fpstate, field))
+
+int main(int argc, char **argv)
+{
+  SC_OFFSET("SC_RBX", rbx);
+  SC_OFFSET("SC_RCX", rcx);
+  SC_OFFSET("SC_RDX", rdx);
+  SC_OFFSET("SC_RSI", rsi);
+  SC_OFFSET("SC_RDI", rdi);
+  SC_OFFSET("SC_RBP", rbp);
+  SC_OFFSET("SC_RAX", rax);
+  SC_OFFSET("SC_R8", r8);
+  SC_OFFSET("SC_R9", r9);
+  SC_OFFSET("SC_R10", r10);
+  SC_OFFSET("SC_R11", r11);
+  SC_OFFSET("SC_R12", r12);
+  SC_OFFSET("SC_R13", r13);
+  SC_OFFSET("SC_R14", r14);
+  SC_OFFSET("SC_R15", r15);
+  SC_OFFSET("SC_IP", rip);
+  SC_OFFSET("SC_SP", rsp);
+  SC_OFFSET("SC_CR2", cr2);
+  SC_OFFSET("SC_ERR", err);
+  SC_OFFSET("SC_TRAPNO", trapno);
+  SC_OFFSET("SC_CS", cs);
+  SC_OFFSET("SC_FS", fs);
+  SC_OFFSET("SC_GS", gs);
+  SC_OFFSET("SC_EFLAGS", eflags);
+  SC_OFFSET("SC_SIGMASK", oldmask);
+#if 0
+  SC_OFFSET("SC_ORIG_RAX", orig_rax);
+  SC_OFFSET("SC_DS", ds);
+  SC_OFFSET("SC_ES", es);
+  SC_OFFSET("SC_SS", ss);
+#endif
+  return(0);
+}
Index: 2.6.10/arch/um/sys-x86_64/util/mk_thread_kern.c
===================================================================
--- 2.6.10.orig/arch/um/sys-x86_64/util/mk_thread_kern.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/sys-x86_64/util/mk_thread_kern.c	2005-01-09 19:09:42.000000000 -0500
@@ -0,0 +1,21 @@
+#include "linux/config.h"
+#include "linux/stddef.h"
+#include "linux/sched.h"
+
+extern void print_head(void);
+extern void print_constant_ptr(char *name, int value);
+extern void print_constant(char *name, char *type, int value);
+extern void print_tail(void);
+
+#define THREAD_OFFSET(field) offsetof(struct task_struct, thread.field)
+
+int main(int argc, char **argv)
+{
+  print_head();
+#ifdef CONFIG_MODE_TT
+  print_constant("TASK_EXTERN_PID", "int", THREAD_OFFSET(mode.tt.extern_pid));
+#endif
+  print_tail();
+  return(0);
+}
+
Index: 2.6.10/arch/um/sys-x86_64/util/mk_thread_user.c
===================================================================
--- 2.6.10.orig/arch/um/sys-x86_64/util/mk_thread_user.c	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/arch/um/sys-x86_64/util/mk_thread_user.c	2005-01-09 19:09:42.000000000 -0500
@@ -0,0 +1,30 @@
+#include <stdio.h>
+
+void print_head(void)
+{
+  printf("/*\n");
+  printf(" * Generated by mk_thread\n");
+  printf(" */\n");
+  printf("\n");
+  printf("#ifndef __UM_THREAD_H\n");
+  printf("#define __UM_THREAD_H\n");
+  printf("\n");
+}
+
+void print_constant_ptr(char *name, int value)
+{
+  printf("#define %s(task) ((unsigned long *) "
+	 "&(((char *) (task))[%d]))\n", name, value);
+}
+
+void print_constant(char *name, char *type, int value)
+{
+  printf("#define %s(task) *((%s *) &(((char *) (task))[%d]))\n", name, type, 
+	 value);
+}
+
+void print_tail(void)
+{
+  printf("\n");
+  printf("#endif\n");
+}
Index: 2.6.10/include/asm-um/apic.h
===================================================================
--- 2.6.10.orig/include/asm-um/apic.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/include/asm-um/apic.h	2005-01-09 19:09:42.000000000 -0500
@@ -0,0 +1,4 @@
+#ifndef __UM_APIC_H
+#define __UM_APIC_H
+
+#endif
Index: 2.6.10/include/asm-um/module-x86_64.h
===================================================================
--- 2.6.10.orig/include/asm-um/module-x86_64.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/include/asm-um/module-x86_64.h	2005-01-09 19:09:42.000000000 -0500
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#ifndef __UM_MODULE_X86_64_H
+#define __UM_MODULE_X86_64_H
+
+/* UML is simple */
+struct mod_arch_specific
+{
+};
+
+#define Elf_Shdr Elf64_Shdr
+#define Elf_Sym Elf64_Sym
+#define Elf_Ehdr Elf64_Ehdr
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: 2.6.10/include/asm-um/pda.h
===================================================================
--- 2.6.10.orig/include/asm-um/pda.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/include/asm-um/pda.h	2005-01-09 19:09:42.000000000 -0500
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#ifndef __UM_PDA_X86_64_H
+#define __UM_PDA_X86_64_H
+
+/* XXX */
+struct foo {
+	unsigned int __softirq_pending;
+	unsigned int __nmi_count;
+};
+
+extern struct foo me;
+
+#define read_pda(me) (&me)
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: 2.6.10/include/asm-um/prctl.h
===================================================================
--- 2.6.10.orig/include/asm-um/prctl.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/include/asm-um/prctl.h	2005-01-09 19:09:42.000000000 -0500
@@ -0,0 +1,6 @@
+#ifndef __UM_PRCTL_H
+#define __UM_PRCTL_H
+
+#include "asm/arch/prctl.h"
+
+#endif
Index: 2.6.10/include/asm-um/processor-x86_64.h
===================================================================
--- 2.6.10.orig/include/asm-um/processor-x86_64.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/include/asm-um/processor-x86_64.h	2005-01-09 21:46:47.000000000 -0500
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#ifndef __UM_PROCESSOR_X86_64_H
+#define __UM_PROCESSOR_X86_64_H
+
+#include "asm/arch/user.h"
+
+struct arch_thread {
+};
+
+#define INIT_ARCH_THREAD { }
+
+#define current_text_addr() \
+	({ void *pc; __asm__("movq $1f,%0\n1:":"=g" (pc)); pc; })
+
+#include "asm/processor-generic.h"
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: 2.6.10/include/asm-um/sigcontext-x86_64.h
===================================================================
--- 2.6.10.orig/include/asm-um/sigcontext-x86_64.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/include/asm-um/sigcontext-x86_64.h	2005-01-09 19:09:42.000000000 -0500
@@ -0,0 +1,22 @@
+/* Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#ifndef __UM_SIGCONTEXT_X86_64_H
+#define __UM_SIGCONTEXT_X86_64_H
+
+#include "asm/sigcontext-generic.h"
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: 2.6.10/include/asm-um/system-x86_64.h
===================================================================
--- 2.6.10.orig/include/asm-um/system-x86_64.h	2003-09-15 09:40:47.000000000 -0400
+++ 2.6.10/include/asm-um/system-x86_64.h	2005-01-09 19:09:42.000000000 -0500
@@ -0,0 +1,23 @@
+/*
+ * Copyright 2003 PathScale, Inc.
+ *
+ * Licensed under the GPL
+ */
+
+#ifndef __UM_SYSTEM_X86_64_H
+#define __UM_SYSTEM_X86_64_H
+
+#include "asm/system-generic.h"
+
+#endif
+
+/*
+ * Overrides for Emacs so that we follow Linus's tabbing style.
+ * Emacs will notice this stuff at the end of the file and automatically
+ * adjust the settings for this buffer only.  This must remain at the end
+ * of the file.
+ * ---------------------------------------------------------------------------
+ * Local variables:
+ * c-file-style: "linux"
+ * End:
+ */
Index: 2.6.10/include/asm-um/vm-flags-x86_64.h
===================================================================
--- 2.6.10.orig/include/asm-um/vm-flags-x86_64.h	2005-01-09 19:09:20.000000000 -0500
+++ 2.6.10/include/asm-um/vm-flags-x86_64.h	2005-01-09 19:09:42.000000000 -0500
@@ -17,11 +17,17 @@
 extern unsigned long vm_data_default_flags, vm_data_default_flags32;
 extern unsigned long vm_force_exec32;
 
+#ifdef TIF_IA32
 #define VM_DATA_DEFAULT_FLAGS \
 	(test_thread_flag(TIF_IA32) ? vm_data_default_flags32 : \
 	  vm_data_default_flags) 
 
 #define VM_STACK_DEFAULT_FLAGS \
 	(test_thread_flag(TIF_IA32) ? vm_stack_flags32 : vm_stack_flags) 
+#endif
+
+#define VM_DATA_DEFAULT_FLAGS vm_data_default_flags
+
+#define VM_STACK_DEFAULT_FLAGS vm_stack_flags
 
 #endif

