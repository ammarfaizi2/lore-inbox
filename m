Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263250AbSJCMI0>; Thu, 3 Oct 2002 08:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263251AbSJCMI0>; Thu, 3 Oct 2002 08:08:26 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:45460 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263250AbSJCMHz>; Thu, 3 Oct 2002 08:07:55 -0400
Date: Thu, 3 Oct 2002 17:56:00 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: richardj_moore@uk.ibm.com, grundym@us.ibm.com, vamsi_krishna@in.ibm.com,
       suparna <bsuparna@in.ibm.com>
Subject: [rfc] [patch] kernel hooks
Message-ID: <20021003175600.A17884@in.ibm.com>
Reply-To: vamsi@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Kernel Hooks Interface is a generalised facility for placing 
hooks in arbitrary kernel locations. A hook is a location in the
kernel that calls out of the kernel to a kernel module routine - 
a hook exit routine. It enables many kernel enhancements, which 
are otherwise self-contained, to become loadable kernel modules 
and retain a substantial degree of independence from the kernel 
source.

Hooks are implemented as fast and slim-line insertions to kernel 
space code. When not active that have practically no overhead to
the kernel. Optimized versions are implemented on ia32, ppc, 
ppc64, s390, s390x archs, where they expand to:
	movl $0, %reg
	     ^x
	testl %reg, %reg
	jz out
	call out exits
	out:

Hooks are armed by editing the number at ^x above to a non-zero 
value so that the exits will be now be called out. 

These hooks are useful especially for invasive facilities like 
security hooks and tracing hooks, which should be compiled in, but 
could be inactive most of the time. The overhead of these hooks 
is very little when they are not armed. These are used by the
Dynamic Probes (http://www.ibm.com/linux/ltc/projects/dprobes/)
and the Linux Kernel State Tracer at (http://lkst.sourceforge.net/)

The patch given below is a slimmed down version of what is at the 
project website http://www.ibm.com/linux/ltc/projects/kernelhooks/. 
I have removed from the full package:
- /proc interface for arming/disarming hooks
- documentation and sample code (could be posted as a seperate patch)
- some extra paranoid checks
- hook exit priorities
- open coded exit lists in favour of using include/linux/list.h
  implementation
- kill typedefs and a number of other cleanups

Todo:
- find some way to eliminate the need for creating a symbol at the 
  hook location so as not to confuse disassembers. We should write 
  the address of the hook location in a seperate section, may be, 
  and set a variable to that location.

Note that the hook structure defined at each hook location is 
exported for use by GPL'ed modules only, just like the security hooks.

Here is an example illustrating how hooks are placed and used:
Defining a hook:
In the source file where you want to place the hook:
DECLARE_HOOK(my_hook);

and at the location where the hook is desired:

	...
	HOOK(my_hook, parm1, parm2);
	...
Now, for this location, exit functions will be called out
when they are registered and enabled.

Before a hook can be used, it needs to be initialised:
	...
	hook_initialise(my_hook);

	...
	hook_terminate(my_hook, force);

To register an exit, say in a different module:

struct hook_rec rec = {
	.hook_exit = exit_fn;
}
	...
	hook_exit_register(my_hook, &rec);

	...
	hook_exit_deregister(&rec);

To enable/disable a hook exit:
	...
	hook_exit_arm(&rec);

	...
	hook_exit_disarm(&rec);
	
Any ideas, suggestions, comments are welcome.

Thanks,
Vamsi.
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
--
 arch/alpha/config.in       |    1
 arch/arm/config.in         |    1
 arch/cris/config.in        |    1
 arch/i386/Config.help      |    9 +
 arch/i386/config.in        |    4
 arch/ia64/config.in        |    1
 arch/m68k/config.in        |    1
 arch/mips/config.in        |    1
 arch/mips64/config.in      |    1
 arch/parisc/config.in      |    1
 arch/ppc/config.in         |    4
 arch/ppc64/config.in       |    4
 arch/s390/config.in        |    4
 arch/s390x/config.in       |    4
 arch/sh/config.in          |    1
 arch/sparc/config.in       |    2
 arch/sparc64/config.in     |    1
 arch/x86_64/config.in      |    1
 include/asm-generic/hook.h |   25 +++++
 include/asm-i386/hook.h    |   47 +++++++++
 include/asm-ppc/hook.h     |   46 +++++++++
 include/asm-ppc64/hook.h   |   46 +++++++++
 include/asm-s390/hook.h    |   48 +++++++++
 include/asm-s390x/hook.h   |   48 +++++++++
 include/linux/hook.h       |  225 +++++++++++++++++++++++++++++++++++++++++++++
 kernel/Makefile            |    3
 kernel/hook.c              |  165 +++++++++++++++++++++++++++++++++
 27 files changed, 693 insertions(+), 2 deletions(-)
--
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/arch/alpha/config.in 40-hooks/arch/alpha/config.in
--- /usr/src/40-pure/arch/alpha/config.in	2002-10-01 12:36:24.000000000 +0530
+++ 40-hooks/arch/alpha/config.in	2002-10-03 16:10:17.000000000 +0530
@@ -394,6 +394,7 @@
    define_tristate CONFIG_MATHEMU y
 fi
 
+tristate '  Kernel Hook support' CONFIG_HOOK
 endmenu
 
 source security/Config.in
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/arch/arm/config.in 40-hooks/arch/arm/config.in
--- /usr/src/40-pure/arch/arm/config.in	2002-10-01 12:36:22.000000000 +0530
+++ 40-hooks/arch/arm/config.in	2002-10-03 16:10:17.000000000 +0530
@@ -546,6 +546,7 @@
 dep_bool '  Kernel low-level debugging functions' CONFIG_DEBUG_LL $CONFIG_DEBUG_KERNEL
 dep_bool '    Kernel low-level debugging messages via footbridge serial port' CONFIG_DEBUG_DC21285_PORT $CONFIG_DEBUG_LL $CONFIG_FOOTBRIDGE
 dep_bool '    Kernel low-level debugging messages via UART2' CONFIG_DEBUG_CLPS711X_UART2 $CONFIG_DEBUG_LL $CONFIG_ARCH_CLPS711X
+tristate '  Kernel Hook support' CONFIG_HOOK
 endmenu
 
 source security/Config.in
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/arch/cris/config.in 40-hooks/arch/cris/config.in
--- /usr/src/40-pure/arch/cris/config.in	2002-10-01 12:37:03.000000000 +0530
+++ 40-hooks/arch/cris/config.in	2002-10-03 16:10:17.000000000 +0530
@@ -213,6 +213,7 @@
 if [ "$CONFIG_SOUND" != "n" ]; then
   source sound/Config.in
 fi
+tristate 'Kernel Hook support' CONFIG_HOOK
 endmenu
 
 source drivers/usb/Config.in
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/arch/i386/Config.help 40-hooks/arch/i386/Config.help
--- /usr/src/40-pure/arch/i386/Config.help	2002-10-01 12:36:17.000000000 +0530
+++ 40-hooks/arch/i386/Config.help	2002-10-03 16:10:17.000000000 +0530
@@ -1058,3 +1058,12 @@
   absence of features.
 
   For more information take a look at Documentation/swsusp.txt.
+
+Kernel Hook Support
+CONFIG_HOOK
+  The Kernel Hooks Interface is a generalised facility for placing hooks in
+  arbitrary kernel locations. A hook is a location in the kernel that
+  calls out of the kernel to a kernel module routine - a hook exit routine.
+  http://www-124.ibm.com/linux/projects/kernelhooks for more details. 
+  If in doubt, say N.
+
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/arch/i386/config.in 40-hooks/arch/i386/config.in
--- /usr/src/40-pure/arch/i386/config.in	2002-10-01 12:36:28.000000000 +0530
+++ 40-hooks/arch/i386/config.in	2002-10-03 16:10:17.000000000 +0530
@@ -461,6 +461,10 @@
    define_bool CONFIG_X86_MPPARSE y
 fi
 
+tristate 'Kernel Hook support' CONFIG_HOOK
+   if [ "$CONFIG_HOOK" != "n" ]; then
+      define_bool CONFIG_ASM_HOOK y
+   fi
 endmenu
 
 source security/Config.in
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/arch/ia64/config.in 40-hooks/arch/ia64/config.in
--- /usr/src/40-pure/arch/ia64/config.in	2002-10-01 12:37:56.000000000 +0530
+++ 40-hooks/arch/ia64/config.in	2002-10-03 16:10:17.000000000 +0530
@@ -281,6 +281,7 @@
    bool '  Turn on irq debug checks (slow!)' CONFIG_IA64_DEBUG_IRQ
 fi
 
+tristate 'Kernel Hook support' CONFIG_HOOK
 endmenu
 
 source security/Config.in
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/arch/m68k/config.in 40-hooks/arch/m68k/config.in
--- /usr/src/40-pure/arch/m68k/config.in	2002-10-01 12:37:33.000000000 +0530
+++ 40-hooks/arch/m68k/config.in	2002-10-03 16:10:17.000000000 +0530
@@ -543,6 +543,7 @@
    bool '  Verbose BUG() reporting' CONFIG_DEBUG_BUGVERBOSE
 fi
 
+tristate 'Kernel Hook support' CONFIG_HOOK
 endmenu
 
 source security/Config.in
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/arch/mips/config.in 40-hooks/arch/mips/config.in
--- /usr/src/40-pure/arch/mips/config.in	2002-10-01 12:37:10.000000000 +0530
+++ 40-hooks/arch/mips/config.in	2002-10-03 16:10:17.000000000 +0530
@@ -492,6 +492,7 @@
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Run uncached' CONFIG_MIPS_UNCACHED
 fi
+tristate 'Kernel Hook support' CONFIG_HOOK
 endmenu
 
 source security/Config.in
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/arch/mips64/config.in 40-hooks/arch/mips64/config.in
--- /usr/src/40-pure/arch/mips64/config.in	2002-10-01 12:37:12.000000000 +0530
+++ 40-hooks/arch/mips64/config.in	2002-10-03 16:10:17.000000000 +0530
@@ -246,6 +246,7 @@
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Run uncached' CONFIG_MIPS_UNCACHED
 fi
+tristate 'Kernel Hook support' CONFIG_HOOK
 endmenu
 
 source security/Config.in
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/arch/parisc/config.in 40-hooks/arch/parisc/config.in
--- /usr/src/40-pure/arch/parisc/config.in	2002-10-01 12:37:48.000000000 +0530
+++ 40-hooks/arch/parisc/config.in	2002-10-03 16:10:17.000000000 +0530
@@ -188,6 +188,7 @@
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+tristate 'Kernel Hook support' CONFIG_HOOK
 endmenu
 
 source security/Config.in
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/arch/ppc/config.in 40-hooks/arch/ppc/config.in
--- /usr/src/40-pure/arch/ppc/config.in	2002-10-01 12:37:02.000000000 +0530
+++ 40-hooks/arch/ppc/config.in	2002-10-03 16:10:17.000000000 +0530
@@ -612,6 +612,10 @@
      -o "$CONFIG_SANDPOINT" = "y" -o "$CONFIG_ZX4500" = "y" ]; then
    bool 'Support for early boot texts over serial port' CONFIG_SERIAL_TEXT_DEBUG
 fi
+tristate 'Kernel Hook support' CONFIG_HOOK
+   if [ "$CONFIG_HOOK" != "n" ]; then
+	define_bool CONFIG_ASM_HOOK y
+   fi
 endmenu
 
 source security/Config.in
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/arch/ppc64/config.in 40-hooks/arch/ppc64/config.in
--- /usr/src/40-pure/arch/ppc64/config.in	2002-10-01 12:36:18.000000000 +0530
+++ 40-hooks/arch/ppc64/config.in	2002-10-03 16:10:17.000000000 +0530
@@ -202,6 +202,10 @@
    fi
    bool '  Include PPCDBG realtime debugging' CONFIG_PPCDBG
 fi
+tristate 'Kernel Hook support' CONFIG_HOOK
+   if [ "$CONFIG_HOOK" != "n" ]; then
+	define_bool CONFIG_ASM_HOOK y
+   fi
 endmenu
 
 source security/Config.in
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/arch/s390/config.in 40-hooks/arch/s390/config.in
--- /usr/src/40-pure/arch/s390/config.in	2002-10-01 12:37:35.000000000 +0530
+++ 40-hooks/arch/s390/config.in	2002-10-03 16:10:17.000000000 +0530
@@ -73,6 +73,10 @@
 #  bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 #fi
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+tristate 'Kernel Hook support' CONFIG_HOOK
+   if [ "$CONFIG_HOOK" != "n" ]; then
+	define_bool CONFIG_ASM_HOOK y
+   fi
 endmenu
 
 source security/Config.in
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/arch/s390x/config.in 40-hooks/arch/s390x/config.in
--- /usr/src/40-pure/arch/s390x/config.in	2002-10-01 12:36:17.000000000 +0530
+++ 40-hooks/arch/s390x/config.in	2002-10-03 16:10:17.000000000 +0530
@@ -76,6 +76,10 @@
 #  bool 'Remote GDB kernel debugging' CONFIG_REMOTE_DEBUG
 #fi
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
+tristate 'Kernel Hook support' CONFIG_HOOK
+   if [ "$CONFIG_HOOK" != "n" ]; then
+	define_bool CONFIG_ASM_HOOK y
+   fi
 endmenu
 
 source security/Config.in
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/arch/sh/config.in 40-hooks/arch/sh/config.in
--- /usr/src/40-pure/arch/sh/config.in	2002-10-01 12:37:00.000000000 +0530
+++ 40-hooks/arch/sh/config.in	2002-10-03 16:10:17.000000000 +0530
@@ -366,6 +366,7 @@
 if [ "$CONFIG_SH_STANDARD_BIOS" = "y" ]; then
    bool 'Early printk support' CONFIG_SH_EARLY_PRINTK
 fi
+tristate 'Kernel Hook support' CONFIG_HOOK
 endmenu
 
 source security/Config.in
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/arch/sparc/config.in 40-hooks/arch/sparc/config.in
--- /usr/src/40-pure/arch/sparc/config.in	2002-10-01 12:36:16.000000000 +0530
+++ 40-hooks/arch/sparc/config.in	2002-10-03 16:10:17.000000000 +0530
@@ -244,7 +244,7 @@
 bool 'Debug memory allocations' CONFIG_DEBUG_SLAB
 bool 'Magic SysRq key' CONFIG_MAGIC_SYSRQ
 bool 'Spinlock debugging' CONFIG_DEBUG_SPINLOCK
-
+tristate 'Kernel Hook support' CONFIG_HOOK
 endmenu
 
 source security/Config.in
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/arch/sparc64/config.in 40-hooks/arch/sparc64/config.in
--- /usr/src/40-pure/arch/sparc64/config.in	2002-10-01 12:36:28.000000000 +0530
+++ 40-hooks/arch/sparc64/config.in	2002-10-03 16:10:17.000000000 +0530
@@ -288,6 +288,7 @@
    define_bool CONFIG_MCOUNT y
 fi
 
+tristate 'Kernel Hook support' CONFIG_HOOK
 endmenu
 
 source security/Config.in
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/arch/x86_64/config.in 40-hooks/arch/x86_64/config.in
--- /usr/src/40-pure/arch/x86_64/config.in	2002-10-01 12:36:25.000000000 +0530
+++ 40-hooks/arch/x86_64/config.in	2002-10-03 16:10:17.000000000 +0530
@@ -223,6 +223,7 @@
    bool '  Spinlock debugging' CONFIG_DEBUG_SPINLOCK
    bool '  Additional run-time checks' CONFIG_CHECKING
    bool '  Debug __init statements' CONFIG_INIT_DEBUG
+   tristate '  Kernel Hook support' CONFIG_HOOK
 fi
 endmenu
 
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/include/asm-generic/hook.h 40-hooks/include/asm-generic/hook.h
--- /usr/src/40-pure/include/asm-generic/hook.h	1970-01-01 05:30:00.000000000 +0530
+++ 40-hooks/include/asm-generic/hook.h	2002-10-03 16:10:17.000000000 +0530
@@ -0,0 +1,25 @@
+#ifndef __ASM_GENERIC_HOOK_H
+#define __ASM_GENERIC_HOOK_H
+/*
+ * Kernel Hooks common code for many archs.
+ * 
+ * Authors: Vamsi Krishna S. <vamsi_krishna@in.ibm.com>
+ */
+#include <asm/cacheflush.h>
+
+static inline void deactivate_asm_hook(struct hook *hook)
+{
+	unsigned char *addr = (unsigned char *) (hook->hook_addr);
+	addr[2] = 0;
+	flush_icache_range(addr + 2, addr + 2);
+	return;
+}
+
+static inline void activate_asm_hook(struct hook *hook)
+{
+	unsigned char *addr = (unsigned char *) (hook->hook_addr);
+	addr[2] = 1;
+	flush_icache_range(addr + 2, addr + 2);
+	return;
+}
+#endif /* __ASM_GENERIC_HOOK_H */
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/include/asm-i386/hook.h 40-hooks/include/asm-i386/hook.h
--- /usr/src/40-pure/include/asm-i386/hook.h	1970-01-01 05:30:00.000000000 +0530
+++ 40-hooks/include/asm-i386/hook.h	2002-10-03 16:10:17.000000000 +0530
@@ -0,0 +1,47 @@
+#ifndef __ASM_I386_HOOK_H
+#define __ASM_I386_HOOK_H
+/*
+ * Kernel Hooks optimized for ia32.
+ * 
+ * Authors: Richard J Moore <richardj_moore@uk.ibm.com>
+ *	    Vamsi Krishna S. <vamsi_krishna@in.ibm.com>
+ */
+#include <asm-generic/hook.h>
+
+#if defined(CONFIG_HOOK) || defined(CONFIG_HOOK_MODULE)
+
+#define IF_HOOK_ENABLED(h, h1) \
+	register int tmp; \
+	__asm__ __volatile__ (".global "h"; "h":movl $0, %0":"=r"(tmp)); \
+	if (unlikely(tmp))
+
+#endif /* CONFIG_HOOK || CONFIG_HOOK_MODULE */
+
+/*
+ * Sanity check the hook location for expected instructions at hook location.
+ * movl $0, %reg, testl %reg, %reg
+ * test doesn't have to follow movl, so don't test for that.
+ */
+#define OPCODE_MOV1			0xb0
+#define OPCODE_MOV1_MASK		0xf0
+#define OPCODE_MOV2_1			0xc6 /* first byte */
+#define OPCODE_MOV2_2			0xc0 /* second byte */
+#define OPCODE_MOV2_1_MASK		0xfe
+#define OPCODE_MOV2_2_MASK		0xf8
+		
+static inline int is_asm_hook(unsigned char *addr)
+{
+	if (!addr)
+		return 0;
+	if((addr[0] & OPCODE_MOV1_MASK) == OPCODE_MOV1) {
+		if (*((unsigned long *)(addr+1)) == 0)
+			return 1;
+	} else if (((addr[0] & OPCODE_MOV2_1_MASK) == OPCODE_MOV2_1) && 
+		    ((addr[1] & OPCODE_MOV2_2_MASK) == OPCODE_MOV2_2)) {
+		if (*((unsigned long *)(addr+2)) == 0)
+			return 1;
+	}
+	return 0;
+}
+
+#endif /* __ASM_I386_HOOK_H */
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/include/asm-ppc/hook.h 40-hooks/include/asm-ppc/hook.h
--- /usr/src/40-pure/include/asm-ppc/hook.h	1970-01-01 05:30:00.000000000 +0530
+++ 40-hooks/include/asm-ppc/hook.h	2002-10-03 16:10:17.000000000 +0530
@@ -0,0 +1,46 @@
+#ifndef __ASM_PPC_HOOK_H
+#define __ASM_PPC_HOOK_H
+/*
+ * Kernel Hooks optimized for PPC.
+ * 
+ * Authors: Mike Grundy <grundym@us.ibm.com> s390x
+ */
+#include <asm-generic/hook.h>
+
+#if defined(CONFIG_HOOK) || defined(CONFIG_HOOK_MODULE)
+
+#define IF_HOOK_ENABLED(h, h1) \
+	register int tmp; \
+	__asm__ __volatile__ (".global "h"; "h":li %0, 0x00":"=r"(tmp)); \
+	if (unlikely(tmp))
+
+#endif /* CONFIG_HOOK || CONFIG_HOOK_MODULE */
+
+
+/*
+ * Sanity check the hook location for valid instructions at hook location.
+ * At hook location, we should find these instructions:
+ *	38 00 00 00       	li    	r0,0
+ *	2c 00 00 00            	cmpwi	r0,0
+ *	
+ * We can check for li and cmpwi instructions. As these instructions encode
+ * the register name in the second byte and the register cannot be predicted, 
+ * we mask out the bits corresponding to registers in the opcode before comparing.
+ * PPC opcodes are six bits, hence mask of 0xFC
+ */
+#define OPCODE_MOV1			0x38 /* LI (really an extended mnemonic for addi */   
+#define OPCODE_MOV1_MASK		0xFC
+/* Compiler generates 2c 00 00 00     cmpwi   r0,0 */
+		
+static inline int is_asm_hook(unsigned char * addr)
+{
+	if (!addr)
+		return 0;
+	
+	if((addr[0] & OPCODE_MOV1_MASK) == OPCODE_MOV1) {
+		if (*((unsigned short *)(addr+1)) == 0)
+			return 1;
+	}
+	return 0;
+}
+#endif /* __ASM_PPC_HOOK_H */
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/include/asm-ppc64/hook.h 40-hooks/include/asm-ppc64/hook.h
--- /usr/src/40-pure/include/asm-ppc64/hook.h	1970-01-01 05:30:00.000000000 +0530
+++ 40-hooks/include/asm-ppc64/hook.h	2002-10-03 16:10:17.000000000 +0530
@@ -0,0 +1,46 @@
+#ifndef __ASM_PPC_HOOK_H
+#define __ASM_PPC_HOOK_H
+/*
+ * Kernel Hooks optimized for PPC64.
+ * 
+ * Authors: Mike Grundy <grundym@us.ibm.com> PPC64
+ */
+#include <asm-generic/hook.h>
+
+#if defined(CONFIG_HOOK) || defined(CONFIG_HOOK_MODULE)
+
+#define IF_HOOK_ENABLED(h, h1) \
+	register int tmp; \
+	__asm__ __volatile__ (".global "h"; "h":li %0, 0x00":"=r"(tmp)); \
+	if (unlikely(tmp))
+
+#endif /* CONFIG_HOOK || CONFIG_HOOK_MODULE */
+
+
+/*
+ * Sanity check the hook location for valid instructions at hook location.
+ * At hook location, we should find these instructions:
+ *	38 00 00 00       	li    	r0,0
+ *	2c 00 00 00            	cmpwi	r0,0
+ *	
+ * We can check for li and cmpwi instructions. As these instructions encode
+ * the register name in the second byte and the register cannot be predicted, 
+ * we mask out the bits corresponding to registers in the opcode before comparing.
+ * PPC opcodes are six bits, hence mask of 0xFC
+ */
+#define OPCODE_MOV1			0x38 /* LI (really an extended mnemonic for addi */   
+#define OPCODE_MOV1_MASK		0xFC
+/* Compiler generates 2c 00 00 00     cmpwi   r0,0 */
+		
+static inline int is_asm_hook(unsigned char * addr)
+{
+	if (!addr)
+		return 0;
+	
+	if((addr[0] & OPCODE_MOV1_MASK) == OPCODE_MOV1) {
+		if (*((unsigned short *)(addr+1)) == 0)
+			return 1;
+	}
+	return 0;
+}
+#endif /* __ASM_PPC_HOOK_H */
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/include/asm-s390/hook.h 40-hooks/include/asm-s390/hook.h
--- /usr/src/40-pure/include/asm-s390/hook.h	1970-01-01 05:30:00.000000000 +0530
+++ 40-hooks/include/asm-s390/hook.h	2002-10-03 16:10:17.000000000 +0530
@@ -0,0 +1,48 @@
+#ifndef __ASM_S390_HOOK_H
+#define __ASM_S390_HOOK_H
+/*
+ * Kernel Hooks optimized for s390.
+ * 
+ * Authors: Mike Grundy <grundym@us.ibm.com> s390
+ */
+#include <asm-generic/hook.h>
+
+#if defined(CONFIG_HOOK) || defined(CONFIG_HOOK_MODULE)
+
+#define IF_HOOK_ENABLED(h, h1) \
+	register int tmp; \
+	__asm__ __volatile__ (".global "h"; "h":lhi %0, 0x00":"=r"(tmp)); \
+	if (unlikely(tmp))
+
+#endif /* CONFIG_HOOK || CONFIG_HOOK_MODULE */
+
+/*
+ * Sanity check the hook location for valid instructions at hook location.
+ * At hook location, we should find these instructions:
+ *  a7 18 00 00             lhi     %r1,0
+ *  12 11                   ltr     %r1,%r1
+ * We can check for the lhi and ltr instructions. As the lhi instruction encodes
+ * the register name in it, and we can't guarantee which register will be used,
+ * we'll mask out the bits corresponding to the target register.
+ */
+#define OPCODE_MOV2_1			0xa7 /* LHI first byte */
+#define OPCODE_MOV2_2			0x08 /* LHI second byte */
+#define OPCODE_MOV2_1_MASK		0xff
+#define OPCODE_MOV2_2_MASK		0x0f
+/* Compiler generates LTR opcode 12, but second op not tested */
+		
+static inline int is_asm_hook(unsigned char * addr)
+{
+	if (!addr){
+		return 0;
+	}
+	if (((addr[0] & OPCODE_MOV2_1_MASK) == OPCODE_MOV2_1) && 
+		    ((addr[1] & OPCODE_MOV2_2_MASK) == OPCODE_MOV2_2)) {
+		/* was checking a 32bit val, need to check 16, cheated with 8+8 */
+		if (addr[2]== 0 && addr[3]== 0){
+			return 1;
+		}
+	}
+	return 0;
+}
+#endif /* __ASM_S390_HOOK_H */
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/include/asm-s390x/hook.h 40-hooks/include/asm-s390x/hook.h
--- /usr/src/40-pure/include/asm-s390x/hook.h	1970-01-01 05:30:00.000000000 +0530
+++ 40-hooks/include/asm-s390x/hook.h	2002-10-03 16:10:17.000000000 +0530
@@ -0,0 +1,48 @@
+#ifndef __ASM_S390X_HOOK_H
+#define __ASM_S390X_HOOK_H
+/*
+ * Kernel Hooks optimized for s390x(64bit).
+ * 
+ * Authors: Mike Grundy <grundym@us.ibm.com> s390x
+ */
+#include <asm-generic/hook.h>
+
+#if defined(CONFIG_HOOK) || defined(CONFIG_HOOK_MODULE)
+
+#define IF_HOOK_ENABLED(h, h1) \
+	register int tmp; \
+	__asm__ __volatile__ (".global "h"; "h":lhi %0, 0x00":"=r"(tmp)); \
+	if (unlikely(tmp))
+
+#endif /* CONFIG_HOOK || CONFIG_HOOK_MODULE */
+
+/*
+ * Sanity check the hook location for valid instructions at hook location.
+ * At hook location, we should find these instructions:
+ *  a7 18 00 00             lhi     %r1,0
+ *  12 11                   ltr     %r1,%r1
+ * We can check for the lhi and ltr instructions. As the lhi instruction encodes
+ * the register name in it, and we can't guarantee which register will be used,
+ * we'll mask out the bits corresponding to the target register.
+ */
+#define OPCODE_MOV2_1			0xa7 /* LHI first byte */
+#define OPCODE_MOV2_2			0x08 /* LHI second byte */
+#define OPCODE_MOV2_1_MASK		0xff
+#define OPCODE_MOV2_2_MASK		0x0f
+/* Compiler generates LTR opcode 12, but second op not tested */
+		
+static inline int is_asm_hook(unsigned char * addr)
+{
+	if (!addr){
+		return 0;
+	}
+	if (((addr[0] & OPCODE_MOV2_1_MASK) == OPCODE_MOV2_1) && 
+		    ((addr[1] & OPCODE_MOV2_2_MASK) == OPCODE_MOV2_2)) {
+		/* was checking a 32bit val, need to check 16, cheated with 8+8 */
+		if (addr[2]== 0 && addr[3]== 0){
+			return 1;
+		}
+	}
+	return 0;
+}
+#endif /* __ASM_S390X_HOOK_H */
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/include/linux/hook.h 40-hooks/include/linux/hook.h
--- /usr/src/40-pure/include/linux/hook.h	1970-01-01 05:30:00.000000000 +0530
+++ 40-hooks/include/linux/hook.h	2002-10-03 16:10:17.000000000 +0530
@@ -0,0 +1,225 @@
+#ifndef __LINUX_HOOK_H
+#define __LINUX_HOOK_H
+/*
+ * Kernel Hooks Interface.
+ * 
+ * Authors: Richard J Moore <richardj_moore@uk.ibm.com>
+ *	    Vamsi Krishna S. <vamsi_krishna@in.ibm.com>
+ */
+#include <linux/compiler.h>
+#include <linux/module.h>
+#include <linux/list.h>
+
+/* define the user (kernel module) hook structure */
+struct hook_rec;
+struct hook;
+
+struct hook_rec {
+	void *hook_exit;
+	struct list_head exit_list;
+	unsigned int hook_flags;
+	struct hook *hook_head;
+};
+
+struct hook {
+	struct list_head exit_list;
+	struct list_head hook_list;
+	unsigned int hook_flags;
+	void *hook_addr;
+	char *hook_name;
+	void *hook_ex_exit;
+};
+
+/* hook flags */
+#define HOOK_ARMED		0x00000001
+#define HOOK_REGISTERED		0x00000002
+#define HOOK_EXCLUSIVE		0x0000000c
+
+/* flag groupings */
+#define HOOK_STATUS		(HOOK_ARMED | HOOK_REGISTERED)
+#define HOOK_OPTIONS		(HOOK_OPTION_DISABLE_IRQS | HOOK_OPTION_STOP_CPUS)
+
+/*
+ * Use the DECLARE_HOOK macro to define the hook structure in global 
+ * memory of a kernel module that is implementing a hook.
+ */
+#if defined(CONFIG_HOOK) || defined(CONFIG_HOOK_MODULE)
+
+#define EXPORT_SYMBOL_NOVERS_GPL(var)  __EXPORT_SYMBOL_GPL(var, __MODULE_STRING(var))
+
+#define DECLARE_HOOK(x) _DECLARE_HOOK(x)
+#define _DECLARE_HOOK(hk) \
+extern void hk; \
+struct hook hk ## _head = { \
+	hook_addr: &(hk), \
+	hook_name: #hk \
+}; \
+EXPORT_SYMBOL_NOVERS_GPL(hk##_head);
+
+#define DECLARE_EXCLUSIVE_HOOK(x) _DECLARE_EXCLUSIVE_HOOK(x)
+#define _DECLARE_EXCLUSIVE_HOOK(hk) \
+extern void hk; \
+struct hook hk ## _head = { \
+	hook_addr: &(hk), \
+	hook_name: #hk, \
+	hook_flags: HOOK_EXCLUSIVE \
+}; \
+EXPORT_SYMBOL_NOVERS_GPL(hk##_head);
+
+/*
+ *  Generic hooks are the same in all architectures and may be used to
+ *  place hooks even in inline functions. They don't define a symbol at hook
+ *  location.
+ */ 
+#define DECLARE_GENERIC_HOOK(x) _DECLARE_GENERIC_HOOK(x)
+#define _DECLARE_GENERIC_HOOK(hk) \
+struct hook hk ## _head = { \
+	hook_addr: NULL, \
+	hook_name: #hk \
+}; \
+EXPORT_SYMBOL_NOVERS_GPL(hk##_head);
+
+#define USE_HOOK(x) _USE_HOOK(x)
+#define _USE_HOOK(hk) extern struct hook hk##_head
+
+/* define head record only flags */
+#define HOOK_ACTIVE	0x80000000
+#define HOOK_ASM_HOOK	0x40000000
+#define HOOK_EXCLUSIVE	0x20000000
+
+typedef int (*hook_fn_t)(struct hook *, ...);
+
+#ifdef CONFIG_ASM_HOOK
+#include <asm/hook.h>
+#else
+static inline int is_asm_hook(unsigned char *addr) {return 0;}
+static inline void activate_asm_hook(struct hook *hook) { }
+static inline void deactivate_asm_hook(struct hook *hook) { }
+#endif
+
+#ifndef IF_HOOK_ENABLED
+#define IF_HOOK_ENABLED(h, h1) \
+	__asm__ __volatile__ (".global "h"; "h":"); \
+	if (unlikely(h1##_head.hook_flags & HOOK_ACTIVE))
+#endif
+
+#define HOOK_TEST(h) \
+	extern struct hook h##_head; \
+	IF_HOOK_ENABLED(#h, h)
+
+#define CALL_EXIT(fn, parm, args...) ((hook_fn_t)(fn)(parm , ##args))
+
+#define DISPATCH_NORMAL(fn, parm, dsprc, args...) \
+	dsprc = CALL_EXIT(fn, parm , ##args);
+
+#define DISPATCH_RET(fn, parm, dsprc, args...) { \
+	int rc; \
+	dsprc = CALL_EXIT(fn, parm, &rc , ##args); \
+	if (dsprc == HOOK_RETURN) \
+		return rc; \
+}
+
+#define DISPATCH_RET_NORC(fn, parm, dsprc, args...) { \
+	dsprc = CALL_EXIT(fn, parm , ##args); \
+	if (dsprc == HOOK_RETURN) \
+		return; \
+}
+
+#define HOOK_DISP_LOOP(h, dispatch, args...) { \
+	register struct hook_rec *rec; \
+	list_for_each_entry(rec, &h##_head.exit_list, exit_list) { \
+		register int dsprc; \
+		if (rec->hook_flags & HOOK_ARMED) { \
+			dispatch(rec->hook_exit, rec->hook_head, dsprc , ##args) \
+			if (dsprc == HOOK_TERMINATE) \
+				break; \
+		} \
+	} \
+}
+
+#define HOOK(h, args...) { \
+	HOOK_TEST(h) \
+	HOOK_DISP_LOOP(h, DISPATCH_NORMAL , ##args); \
+}
+
+#define HOOK_RET(h, args...) { \
+	HOOK_TEST(h) \
+	HOOK_DISP_LOOP(h, DISPATCH_RET , ##args); \
+}
+
+#define HOOK_RET_NORC(h, args...) { \
+	HOOK_TEST(h) \
+	HOOK_DISP_LOOP(h, DISPATCH_RET_NORC , ##args); \
+}
+
+#define EXCLUSIVE_HOOK(h, args...) { \
+	HOOK_TEST(h) \
+	DISPATCH_NORMAL(h##_head.hook_ex_exit, &h##_head , ##args); \
+}
+
+#define EXCLUSIVE_HOOK_RET(h, args...) { \
+	HOOK_TEST(h) \
+	DISPATCH_RET(h##_head.hook_ex_exit, &h##_head , ##args); \
+}
+
+#define EXCLUSIVE_HOOK_RET_NORC(h, args...) { \
+	HOOK_TEST(h) \
+	DISPATCH_RET_NORC(h##_head.hook_ex_exit, &h##_head , ##args); \
+}
+
+#define GENERIC_HOOK(h, args...) { \
+	extern struct hook h##_head; \
+	if (unlikely(h##_head.hook_flags & HOOK_ACTIVE)) { \
+		HOOK_DISP_LOOP(h, DISPATCH_NORMAL , ##args); \
+	} \
+}
+
+/* exported functions wrapped in a macro */
+extern int _hook_initialise(struct hook *);
+extern int _hook_terminate(struct hook *, int);
+extern int _hook_exit_register(struct hook *, struct hook_rec *);
+
+/* exported function prototypes */
+extern void hook_exit_deregister(struct hook_rec *);
+extern void hook_exit_arm(struct hook_rec *);
+extern void hook_exit_disarm(struct hook_rec *);
+
+/* exported functions error codes */
+#define EPRIORITY	1	/* reqd. priority not possible */
+
+/* Return values from Hook Exit routines */
+#define HOOK_CONTINUE 	0
+#define HOOK_TERMINATE 	1
+#define HOOK_RETURN 	-1
+
+/*
+ * public interfaces requiring a macro wrapper
+ *
+ * int hook_exit_register(hook, struct hook_rec *);
+ * int _hook_terminate(hook, int force_flag);/
+ * int hook_initialise(hook);
+ *
+ * where hook is a typeless name
+ */
+#define hook_exit_register(x, y) dummy_hook_exit_register(x, y)
+#define dummy_hook_exit_register(x, y) _hook_exit_register(&(x##_head), y)
+#define hook_terminate(x, y) dummy_hook_terminate(x, y)
+#define dummy_hook_terminate(x, y) _hook_terminate(&(x ## _head), y)
+#define hook_initialise(x) dummy_hook_initialise(x)
+#define dummy_hook_initialise(x) _hook_initialise(&(x ## _head))
+
+#else
+/* dummy macros when hooks are not compiled in */
+#define DECLARE_HOOK(x)
+#define DECLARE_GENERIC_HOOK(x)
+#define USE_HOOK(x)
+#define HOOK(h, args...)
+#define HOOK_RET(h, args...)
+#define HOOK_RET_NORC(h, args...)
+#define EXCLUSIVE_HOOK(h, args...)
+#define EXCLUSIVE_HOOK_RET(h, args...)
+#define EXCLUSIVE_HOOK_RET_NORC(h, args...)
+#define GENERIC_HOOK(h, args...)
+#endif /* !(CONFIG_HOOK || CONFIG_HOOK_MODULE) */
+
+#endif /* __LINUX_HOOK_H */
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/kernel/hook.c 40-hooks/kernel/hook.c
--- /usr/src/40-pure/kernel/hook.c	1970-01-01 05:30:00.000000000 +0530
+++ 40-hooks/kernel/hook.c	2002-10-03 16:10:17.000000000 +0530
@@ -0,0 +1,165 @@
+/*
+ * Kernel Hooks Interface.
+ * 
+ * Authors: Richard J Moore <richardj_moore@uk.ibm.com>
+ *	    Vamsi Krishna S. <vamsi_krishna@in.ibm.com>
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/hook.h>
+#include <asm/system.h>
+#include <asm/uaccess.h>
+
+static spinlock_t hook_lock = SPIN_LOCK_UNLOCKED;
+static LIST_HEAD(hook_list);
+
+static inline void deactivate_hook(struct hook *hook)
+{
+	hook->hook_flags &= ~HOOK_ACTIVE;
+	if(hook->hook_flags & HOOK_ASM_HOOK)
+		deactivate_asm_hook(hook);
+}
+
+static inline void activate_hook(struct hook *hook)
+{
+	hook->hook_flags |= HOOK_ACTIVE;
+	if(hook->hook_flags & HOOK_ASM_HOOK)
+		activate_asm_hook(hook);
+}
+
+static void disarm_one_hook_exit(struct hook_rec *hook_rec)
+{
+	struct hook_rec *rec;
+
+	hook_rec->hook_flags &= ~HOOK_ARMED;
+	list_for_each_entry(rec, &hook_rec->hook_head->exit_list, exit_list) {
+		if(rec->hook_flags & HOOK_ARMED) {
+			return;
+		}
+	}
+	deactivate_hook(hook_rec->hook_head);
+}
+
+int _hook_exit_register(struct hook *hook, struct hook_rec *hook_rec)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hook_lock, flags);
+	if(hook->hook_flags & HOOK_EXCLUSIVE) {
+		if (!list_empty(&hook->exit_list)) {
+			spin_unlock_irqrestore(&hook_lock, flags);
+			return -EPRIORITY;
+		}
+		hook->hook_ex_exit = hook_rec->hook_exit;
+	}
+	list_add(&hook_rec->exit_list, &hook->exit_list);
+	hook_rec->hook_head = hook;
+	spin_unlock_irqrestore(&hook_lock, flags);
+	return 0;
+}
+
+void hook_exit_deregister(struct hook_rec *rec)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hook_lock, flags);
+	if(rec->hook_flags & HOOK_ARMED)
+		disarm_one_hook_exit(rec);
+	if(rec->hook_head->hook_flags & HOOK_EXCLUSIVE)
+		rec->hook_head->hook_ex_exit = NULL;
+	list_del(&rec->exit_list);
+	spin_unlock_irqrestore(&hook_lock, flags);
+}
+
+void hook_exit_arm(struct hook_rec *rec)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hook_lock, flags);
+	rec->hook_flags |= HOOK_ARMED;
+	if(!(rec->hook_head->hook_flags & HOOK_ACTIVE))
+		activate_hook(rec->hook_head);
+	spin_unlock_irqrestore(&hook_lock, flags);
+}
+
+void hook_exit_disarm(struct hook_rec *rec)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hook_lock, flags);
+	disarm_one_hook_exit(rec);
+	spin_unlock_irqrestore(&hook_lock, flags);
+}
+
+int _hook_initialise(struct hook *hook)
+{
+	struct hook *h;
+	unsigned long flags;
+
+	spin_lock_irqsave(&hook_lock, flags);
+	list_for_each_entry(h, &hook_list, hook_list) {
+		if(strcmp(hook->hook_name, h->hook_name) == 0) {
+			spin_unlock_irqrestore(&hook_lock, flags);
+			return -EEXIST;
+		}
+	}
+
+	INIT_LIST_HEAD(&hook->exit_list);
+	if(is_asm_hook(hook->hook_addr)) {
+		hook->hook_flags |= HOOK_ASM_HOOK;
+	}
+
+	list_add(&hook->hook_list, &hook_list);
+
+	MOD_INC_USE_COUNT;
+	spin_unlock_irqrestore(&hook_lock, flags);
+	return 0;
+}
+
+int _hook_terminate(struct hook *hook, int force)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&hook_lock, flags);
+
+	if(hook->hook_flags & HOOK_ACTIVE) {
+		if(force) {
+			deactivate_hook(hook);
+		} else {
+			spin_unlock_irqrestore(&hook_lock, flags);
+			return -EBUSY;
+		}
+	}
+	list_del(&hook->hook_list);
+
+	MOD_DEC_USE_COUNT;
+	spin_unlock_irqrestore(&hook_lock, flags);
+	return 0;
+}
+
+static int __init hook_init_module(void)
+{
+	printk(KERN_INFO "Kernel Hooks Interface installed.\n");
+	return 0;
+}
+
+static void __exit hook_cleanup_module(void)
+{
+	printk(KERN_INFO "Kernel Hooks Interface terminated.\n");
+}
+
+module_init(hook_init_module);
+module_exit(hook_cleanup_module);
+
+EXPORT_SYMBOL(hook_exit_deregister);
+EXPORT_SYMBOL(hook_exit_arm);
+EXPORT_SYMBOL(hook_exit_disarm);
+EXPORT_SYMBOL(_hook_initialise);
+EXPORT_SYMBOL(_hook_terminate);
+EXPORT_SYMBOL(_hook_exit_register);
+
+MODULE_LICENSE("GPL");
diff -urN -X /home/vamsi/.dontdiff /usr/src/40-pure/kernel/Makefile 40-hooks/kernel/Makefile
--- /usr/src/40-pure/kernel/Makefile	2002-10-01 12:36:22.000000000 +0530
+++ 40-hooks/kernel/Makefile	2002-10-03 16:10:53.000000000 +0530
@@ -3,13 +3,14 @@
 #
 
 export-objs = signal.o sys.o kmod.o context.o ksyms.o pm.o exec_domain.o \
-	      printk.o platform.o suspend.o dma.o module.o cpufreq.o
+	      printk.o platform.o suspend.o dma.o module.o cpufreq.o hook.o
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o \
 	    module.o exit.o itimer.o time.o softirq.o resource.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o \
 	    signal.o sys.o kmod.o context.o futex.o platform.o pid.o
 
+obj-$(CONFIG_HOOK) += hook.o
 obj-$(CONFIG_GENERIC_ISA_DMA) += dma.o
 obj-$(CONFIG_SMP) += cpu.o
 obj-$(CONFIG_UID16) += uid16.o
