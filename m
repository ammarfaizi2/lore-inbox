Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317037AbSFAUBK>; Sat, 1 Jun 2002 16:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317034AbSFAUBJ>; Sat, 1 Jun 2002 16:01:09 -0400
Received: from p508872AA.dip.t-dialin.net ([80.136.114.170]:28091 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317045AbSFAUAl>; Sat, 1 Jun 2002 16:00:41 -0400
Date: Sat, 1 Jun 2002 13:59:46 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Kernel Build -- Daniel Phillips <phillips@bonn-fries.net>,
        Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
        Keith Owens <kaos@ocs.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][2.5] kbuild-2.5 9/12: s/390 dependant stuff
Message-ID: <Pine.LNX.4.44.0206011359070.4854-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kbuild-2.5 - s/390 dependant stuff

You will need this patch for kbuild-2.5 on s/390 boxes.
You will need most other kbuild-2.5 patches, too!

This patch is also available from
<URL:ftp://luckynet.dynu.com/pub/linux/kbuild-2.5/many-files/kbuild-2.5-arch-s390.patch>

diff -Nur kbuild-2.5/arch/s390/asm-offsets.c kbuild-2.5/arch/s390/asm-offsets.c
--- kbuild-2.5/arch/s390/asm-offsets.c Fri May 31 15:49:45 2002
+++ kbuild-2.5/arch/s390/asm-offsets.c Fri May 31 15:49:45 2002 +0000 thunder (thunder-2.5/arch/s390/asm-offsets.c 1.1 0644)
@@ -0,0 +1,31 @@
+/*
+ * Generate definitions needed by assembly language modules.
+ * This code generates raw asm output which is post-processed to extract
+ * and format the required data.
+ */
+
+#include <linux/config.h>
+#include <linux/sched.h>
+
+/* Use marker if you need to separate the values later */
+
+#define DEFINE(sym, val, marker) \
+	asm volatile("\n->" #sym " %0 " #val " " #marker : : "i" (val))
+
+#define BLANK() asm volatile("\n->" : : )
+
+int main(void)
+{
+	DEFINE(__THREAD_info, offsetof(struct task_struct, thread_info),);
+	DEFINE(__THREAD_ar2, offsetof(struct task_struct, thread.ar2),);
+	DEFINE(__THREAD_ar4, offsetof(struct task_struct, thread.ar4),);
+	DEFINE(__THREAD_ksp, offsetof(struct task_struct, thread.ksp),);
+	DEFINE(__THREAD_per, offsetof(struct task_struct, thread.per_info),);
+	BLANK();
+	DEFINE(__TI_task, offsetof(struct thread_info, task),);
+	DEFINE(__TI_domain, offsetof(struct thread_info, exec_domain),);
+	DEFINE(__TI_flags, offsetof(struct thread_info, flags),);
+	DEFINE(__TI_cpu, offsetof(struct thread_info, cpu),);
+	DEFINE(__TI_precount, offsetof(struct thread_info, preempt_count),);
+	return 0;
+}
diff -Nur kbuild-2.5/arch/s390/boot/config.install-2.5 kbuild-2.5/arch/s390/boot/config.install-2.5
--- kbuild-2.5/arch/s390/boot/config.install-2.5 Fri May 31 15:49:45 2002
+++ kbuild-2.5/arch/s390/boot/config.install-2.5 Fri May 31 15:49:45 2002 +0000 thunder (thunder-2.5/arch/s390/boot/config.install-2.5 1.1 0644)
@@ -0,0 +1,35 @@
+mainmenu_name "ix86 Installation"
+
+choice 'Format to compile kernel in' \
+	"vmlinux	CONFIG_VMLINUX \
+	 image		CONFIG_IMAGE" image
+
+bool 'Use a prefix on install paths' CONFIG_INSTALL_PREFIX
+if [ "$CONFIG_INSTALL_PREFIX" = "y" ]; then
+  string '  Prefix for install paths' CONFIG_INSTALL_PREFIX_NAME ""
+fi
+string 'Where to install the kernel' CONFIG_INSTALL_KERNEL_NAME "/lib/modules/KERNELRELEASE/KERNELBASENAME"
+bool 'Install System.map' CONFIG_INSTALL_SYSTEM_MAP
+if [ "$CONFIG_INSTALL_SYSTEM_MAP" = "y" ]; then
+  string '  Where to install System.map' CONFIG_INSTALL_SYSTEM_MAP_NAME "/lib/modules/KERNELRELEASE/System.map"
+fi
+bool 'Install .config' CONFIG_INSTALL_CONFIG
+if [ "$CONFIG_INSTALL_CONFIG" = "y" ]; then
+  string '  Where to install .config' CONFIG_INSTALL_CONFIG_NAME "/lib/modules/KERNELRELEASE/.config"
+fi
+if [ "$CONFIG_VMLINUX" != "y" ]; then
+  bool '  Install vmlinux for debugging' CONFIG_INSTALL_VMLINUX
+  if [ "$CONFIG_INSTALL_VMLINUX" = "y" ]; then
+    string '    Where to install vmlinux' CONFIG_INSTALL_VMLINUX_NAME "/lib/modules/KERNELRELEASE/vmlinux"
+  fi
+fi
+bool 'Run a post-install script or command' CONFIG_INSTALL_SCRIPT
+if [ "$CONFIG_INSTALL_SCRIPT" = "y" ]; then
+  string '  Post-install script or command name' CONFIG_INSTALL_SCRIPT_NAME ""
+fi
+
+# FIXME: These critical config options should be in arch/$(ARCH)/config.in.  For
+# coexistence of kbuild 2.4 and 2.5 it is easier to put them here, move them
+# later.  KAO
+
+# define_string CONFIG_KBUILD_CRITICAL_ARCH_S390 "CONFIG_ARCH_S390X"
diff -Nur kbuild-2.5/arch/s390/vmlinux.lds.S kbuild-2.5/arch/s390/vmlinux.lds.S
--- kbuild-2.5/arch/s390/vmlinux.lds.S Fri May 31 15:49:45 2002
+++ kbuild-2.5/arch/s390/vmlinux.lds.S Fri May 31 15:49:45 2002 +0000 thunder (thunder-2.5/arch/s390/vmlinux.lds.S 1.1 0644)
@@ -0,0 +1,103 @@
+/* ld script to make s390 Linux kernel
+ * Written by Martin Schwidefsky (schwidefsky@de.ibm.com)
+ */
+#include <linux/config.h>
+
+OUTPUT_FORMAT("elf32-s390", "elf32-s390", "elf32-s390")
+OUTPUT_ARCH(s390)
+ENTRY(_start)
+SECTIONS
+{
+  . = 0x00000000;
+  _text = .;			/* Text and read-only data */
+  .text : {
+	*(.text)
+	*(.fixup)
+	*(.gnu.warning)
+	} = 0x0700
+#ifndef CONFIG_SHARED_KERNEL
+  .rodata : { *(.rodata) *(.rodata.*) }
+#else /* CONFIG_SHARED_KERNEL */
+  .rodata : { *(.rodata) }
+#endif /* CONFIG_SHARED_KERNEL */
+  .kstrtab : { *(.kstrtab) }
+
+  . = ALIGN(16);		/* Exception table */
+  __start___ex_table = .;
+  __ex_table : { *(__ex_table) }
+  __stop___ex_table = .;
+
+  __start___ksymtab = .;	/* Kernel symbol table */
+  __ksymtab : { *(__ksymtab) }
+  __stop___ksymtab = .;
+
+  __start___kallsyms = .;       /* All kernel symbols */
+  __kallsyms : { *(__kallsyms) }
+  __stop___kallsyms = .;
+
+#ifdef CONFIG_SHARED_KERNEL
+  . = ALIGN(1048576);		/* VM shared segments are 1MB aligned */
+#endif /* CONFIG_SHARED_KERNEL */
+
+  _etext = .;			/* End of text section */
+
+  .data : {			/* Data */
+	*(.data)
+	CONSTRUCTORS
+	}
+
+  _edata = .;			/* End of data section */
+
+  . = ALIGN(8192);		/* init_task */
+  .data.init_task : { *(.data.init_task) }
+
+  . = ALIGN(4096);		/* Init code and data */
+  __init_begin = .;
+  .text.init : { *(.text.init) }
+  .data.init : { *(.data.init) }
+  . = ALIGN(4096);
+  __init_end = .;
+
+  __setup_start = .;
+  .setup.init : { *(.setup.init) }
+  __setup_end = .;
+  __initcall_start = .;
+  .initcall.init : {
+	*(.initcall1.init) 
+	*(.initcall2.init) 
+	*(.initcall3.init) 
+	*(.initcall4.init) 
+	*(.initcall5.init) 
+	*(.initcall6.init) 
+	*(.initcall7.init)
+  }
+  __initcall_end = .;
+  . = ALIGN(256);
+  __per_cpu_start = .;
+  .date.percpu  : { *(.data.percpu) }
+  __per_cpu_end = .;
+  . = ALIGN(4096);
+  __init_end = .;
+
+  . = ALIGN(32);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+
+  . = ALIGN(4096);
+  .data.page_aligned : { *(.data.idt) }
+
+
+  __bss_start = .;		/* BSS */
+  .bss : {
+	*(.bss)
+	}
+  _end = . ;
+
+  /* Stabs debugging sections.  */
+  .stab 0 : { *(.stab) }
+  .stabstr 0 : { *(.stabstr) }
+  .stab.excl 0 : { *(.stab.excl) }
+  .stab.exclstr 0 : { *(.stab.exclstr) }
+  .stab.index 0 : { *(.stab.index) }
+  .stab.indexstr 0 : { *(.stab.indexstr) }
+  .comment 0 : { *(.comment) }
+}

