Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265225AbUFWIAb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265225AbUFWIAb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 04:00:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265237AbUFWIAb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 04:00:31 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:1667 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S265225AbUFWIAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 04:00:14 -0400
Date: Wed, 23 Jun 2004 04:02:24 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: [PATCH][2.6] Fix module_text_address/store_stackinfo race
Message-ID: <Pine.LNX.4.58.0406230349390.3273@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

store_stackinfo() does an unlocked module list walk during normal runtime
which opens up a race with the module load/unload code. This can be
triggered by simply unloading and loading a module in a loop with
CONFIG_DEBUG_PAGEALLOC resulting in store_stackinfo() tripping over bad
list pointers.

root@arusha ~ {0:0} Unable to handle kernel paging request at virtual address 00100100
 printing eip:
c013c46e
*pde = 00000000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in: usbserial
CPU:    1
EIP:    0060:[<c013c46e>]    Not tainted
EFLAGS: 00010083   (2.6.7)
EIP is at module_text_address+0x4e/0x70
eax: 001000fc   ebx: d736faec   ecx: 001000fc   edx: 00100100
esi: d736faec   edi: dff2cef8   ebp: dff2ce8c   esp: dff2ce88
ds: 007b   es: 007b   ss: 0068
Process init (pid: 1, threadinfo=dff2c000 task=dff2da60)
Stack: d736fb04 dff2ce98 c0134e16 d736faec dff2ceb4 c0147ecb d736faec 000004f4
       c012b711 d736f000 dfffbc60 dff2cee8 c014ae85 dfffbc60 d736f000 c012b711
       1736f000 c012b711 d736f000 dff0bf78 00000082 d611aa60 00000000 00000002
Call Trace:
 [<c0107675>] show_stack+0x75/0x90
 [<c01077d5>] show_registers+0x125/0x180
 [<c0107966>] die+0xa6/0xd0
 [<c0118538>] do_page_fault+0x1e8/0x535
 [<c01072cd>] error_code+0x2d/0x40
 [<c0134e16>] kernel_text_address+0x36/0x50
 [<c0147ecb>] store_stackinfo+0x7b/0xa0
 [<c014ae85>] kmem_cache_free+0x1a5/0x340
 [<c012b711>] __exit_sighand+0x31/0x40
 [<c0122a1b>] release_task+0xab/0x2c0
 [<c0124dae>] wait_task_zombie+0x1be/0x260
 [<c01252a2>] sys_wait4+0x222/0x270
 [<c0125306>] sys_waitpid+0x16/0x1a
 [<c0106139>] sysenter_past_esp+0x52/0x79

Code: 8b 40 04 8d 74 26 00 81 fa c0 d3 5d c0 75 c3 31 c0 5b 5d c3

Patch against 2.6.7-mm1

 arch/i386/kernel/traps.c   |    2 +-
 arch/m68k/kernel/traps.c   |    2 +-
 arch/mips/kernel/traps.c   |    2 +-
 arch/parisc/kernel/traps.c |    2 +-
 arch/um/kernel/sysrq.c     |    2 +-
 arch/x86_64/kernel/traps.c |    6 +++---
 include/linux/kernel.h     |    1 +
 kernel/extable.c           |   12 ------------
 kernel/module.c            |   28 +++++++++++++++++++++++++++-
 9 files changed, 36 insertions(+), 21 deletions(-)

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.7-mm1/arch/i386/kernel/traps.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.7-mm1/arch/i386/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 traps.c
--- linux-2.6.7-mm1/arch/i386/kernel/traps.c	22 Jun 2004 16:24:54 -0000	1.1.1.1
+++ linux-2.6.7-mm1/arch/i386/kernel/traps.c	23 Jun 2004 07:57:26 -0000
@@ -158,7 +158,7 @@ static void print_context_stack(struct t

 	while (!kstack_end(stack)) {
 		addr = *stack++;
-		if (kernel_text_address(addr)) {
+		if (__kernel_text_address(addr)) {
 			printk(" [<%08lx>]", addr);
 			print_symbol(" %s", addr);
 			printk("\n");
Index: linux-2.6.7-mm1/arch/m68k/kernel/traps.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.7-mm1/arch/m68k/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 traps.c
--- linux-2.6.7-mm1/arch/m68k/kernel/traps.c	22 Jun 2004 16:24:57 -0000	1.1.1.1
+++ linux-2.6.7-mm1/arch/m68k/kernel/traps.c	23 Jun 2004 07:57:10 -0000
@@ -911,7 +911,7 @@ void show_trace(unsigned long *stack)
 		 * down the cause of the crash will be able to figure
 		 * out the call path that was taken.
 		 */
-		if (kernel_text_address(addr)) {
+		if (__kernel_text_address(addr)) {
 #ifndef CONFIG_KALLSYMS
 			if (i % 5 == 0)
 				printk("\n       ");
Index: linux-2.6.7-mm1/arch/mips/kernel/traps.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.7-mm1/arch/mips/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 traps.c
--- linux-2.6.7-mm1/arch/mips/kernel/traps.c	22 Jun 2004 16:24:56 -0000	1.1.1.1
+++ linux-2.6.7-mm1/arch/mips/kernel/traps.c	23 Jun 2004 07:57:10 -0000
@@ -118,7 +118,7 @@ void show_trace(struct task_struct *task
 #endif
 	while (!kstack_end(stack)) {
 		addr = *stack++;
-		if (kernel_text_address(addr)) {
+		if (__kernel_text_address(addr)) {
 			printk(" [<%0*lx>] ", field, addr);
 			print_symbol("%s\n", addr);
 		}
Index: linux-2.6.7-mm1/arch/parisc/kernel/traps.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.7-mm1/arch/parisc/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 traps.c
--- linux-2.6.7-mm1/arch/parisc/kernel/traps.c	22 Jun 2004 16:24:59 -0000	1.1.1.1
+++ linux-2.6.7-mm1/arch/parisc/kernel/traps.c	23 Jun 2004 07:57:10 -0000
@@ -188,7 +188,7 @@ void show_trace(struct task_struct *task
 		 * down the cause of the crash will be able to figure
 		 * out the call path that was taken.
 		 */
-		if (kernel_text_address(addr)) {
+		if (__kernel_text_address(addr)) {
 			printk(" [<" RFMT ">] ", addr);
 #ifdef CONFIG_KALLSYMS
 			print_symbol("%s\n", addr);
Index: linux-2.6.7-mm1/arch/um/kernel/sysrq.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.7-mm1/arch/um/kernel/sysrq.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 sysrq.c
--- linux-2.6.7-mm1/arch/um/kernel/sysrq.c	22 Jun 2004 16:24:55 -0000	1.1.1.1
+++ linux-2.6.7-mm1/arch/um/kernel/sysrq.c	23 Jun 2004 07:57:10 -0000
@@ -23,7 +23,7 @@ void show_trace(unsigned long * stack)
         i = 1;
         while (((long) stack & (THREAD_SIZE-1)) != 0) {
                 addr = *stack++;
-		if (kernel_text_address(addr)) {
+		if (__kernel_text_address(addr)) {
 			if (i && ((i % 6) == 0))
 				printk("\n   ");
 			printk("[<%08lx>] ", addr);
Index: linux-2.6.7-mm1/arch/x86_64/kernel/traps.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.7-mm1/arch/x86_64/kernel/traps.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 traps.c
--- linux-2.6.7-mm1/arch/x86_64/kernel/traps.c	22 Jun 2004 16:24:59 -0000	1.1.1.1
+++ linux-2.6.7-mm1/arch/x86_64/kernel/traps.c	23 Jun 2004 07:57:10 -0000
@@ -143,7 +143,7 @@ void show_trace(unsigned long *stack)
 	if (estack_end) {
 		while (stack < estack_end) {
 			addr = *stack++;
-			if (kernel_text_address(addr)) {
+			if (__kernel_text_address(addr)) {
 				i += printk_address(addr);
 				i += printk(" ");
 				if (i > 50) {
@@ -172,7 +172,7 @@ void show_trace(unsigned long *stack)
 			 * down the cause of the crash will be able to figure
 			 * out the call path that was taken.
 			 */
-			 if (kernel_text_address(addr)) {
+			 if (__kernel_text_address(addr)) {
 				 i += printk_address(addr);
 				 i += printk(" ");
 				 if (i > 50) {
@@ -188,7 +188,7 @@ void show_trace(unsigned long *stack)

 	while (((long) stack & (THREAD_SIZE-1)) != 0) {
 		addr = *stack++;
-		if (kernel_text_address(addr)) {
+		if (__kernel_text_address(addr)) {
 			i += printk_address(addr);
 			i += printk(" ");
 			if (i > 50) {
Index: linux-2.6.7-mm1/include/linux/kernel.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.7-mm1/include/linux/kernel.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 kernel.h
--- linux-2.6.7-mm1/include/linux/kernel.h	22 Jun 2004 16:24:59 -0000	1.1.1.1
+++ linux-2.6.7-mm1/include/linux/kernel.h	23 Jun 2004 07:57:10 -0000
@@ -88,6 +88,7 @@ extern int get_option(char **str, int *p
 extern char *get_options(const char *str, int nints, int *ints);
 extern unsigned long long memparse(char *ptr, char **retptr);

+extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
 extern int session_of_pgrp(int pgrp);

Index: linux-2.6.7-mm1/kernel/extable.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.7-mm1/kernel/extable.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 extable.c
--- linux-2.6.7-mm1/kernel/extable.c	22 Jun 2004 16:25:12 -0000	1.1.1.1
+++ linux-2.6.7-mm1/kernel/extable.c	23 Jun 2004 07:57:10 -0000
@@ -40,15 +40,3 @@ const struct exception_table_entry *sear
 	return e;
 }

-int kernel_text_address(unsigned long addr)
-{
-	if (addr >= (unsigned long)_stext &&
-	    addr <= (unsigned long)_etext)
-		return 1;
-
-	if (addr >= (unsigned long)_sinittext &&
-	    addr <= (unsigned long)_einittext)
-		return 1;
-
-	return module_text_address(addr) != NULL;
-}
Index: linux-2.6.7-mm1/kernel/module.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.7-mm1/kernel/module.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 module.c
--- linux-2.6.7-mm1/kernel/module.c	22 Jun 2004 16:25:12 -0000	1.1.1.1
+++ linux-2.6.7-mm1/kernel/module.c	23 Jun 2004 07:57:10 -0000
@@ -35,6 +35,7 @@
 #include <linux/notifier.h>
 #include <linux/stop_machine.h>
 #include <asm/uaccess.h>
+#include <asm/sections.h>
 #include <asm/semaphore.h>
 #include <asm/cacheflush.h>

@@ -670,7 +671,7 @@ void symbol_put_addr(void *addr)
 	unsigned long flags;

 	spin_lock_irqsave(&modlist_lock, flags);
-	if (!kernel_text_address((unsigned long)addr))
+	if (!__kernel_text_address((unsigned long)addr))
 		BUG();

 	module_put(module_text_address((unsigned long)addr));
@@ -678,6 +679,31 @@ void symbol_put_addr(void *addr)
 }
 EXPORT_SYMBOL_GPL(symbol_put_addr);

+int __kernel_text_address(unsigned long addr)
+{
+	if (addr >= (unsigned long)_stext &&
+	    addr <= (unsigned long)_etext)
+		return 1;
+
+	if (addr >= (unsigned long)_sinittext &&
+	    addr <= (unsigned long)_einittext)
+		return 1;
+
+	return module_text_address(addr) != NULL;
+}
+
+int kernel_text_address(unsigned long addr)
+{
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&modlist_lock, flags);
+	ret = __kernel_text_address(addr);
+	spin_unlock_irqrestore(&modlist_lock, flags);
+
+	return ret;
+}
+
 static int refcnt_get_fn(char *buffer, struct kernel_param *kp)
 {
 	struct module *mod = container_of(kp, struct module, refcnt_param);
