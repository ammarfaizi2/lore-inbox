Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263943AbUFXHTT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263943AbUFXHTT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 03:19:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbUFXHTT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 03:19:19 -0400
Received: from ausmtp02.au.ibm.com ([202.81.18.187]:33459 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP id S263943AbUFXHTF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 03:19:05 -0400
Subject: Re: [PATCH][2.6] Fix module_text_address/store_stackinfo race
From: Rusty Russell <rusty@rustcorp.com.au>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <Pine.LNX.4.58.0406240040330.3273@montezuma.fsmlabs.com>
References: <Pine.LNX.4.58.0406230349390.3273@montezuma.fsmlabs.com>
	 <1088051071.21510.8.camel@bach>
	 <Pine.LNX.4.58.0406240040330.3273@montezuma.fsmlabs.com>
Content-Type: text/plain
Message-Id: <1088061512.22860.252.camel@bach>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 24 Jun 2004 17:18:33 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-06-24 at 14:42, Zwane Mwaikambo wrote:
> On Thu, 24 Jun 2004, Rusty Russell wrote:
> 
> > On Wed, 2004-06-23 at 18:02, Zwane Mwaikambo wrote:
> > > store_stackinfo() does an unlocked module list walk during normal runtime
> > > which opens up a race with the module load/unload code. This can be
> > > triggered by simply unloading and loading a module in a loop with
> > > CONFIG_DEBUG_PAGEALLOC resulting in store_stackinfo() tripping over bad
> > > list pointers.
> >
> > Hmmm...
> >
> > 	You can't move kernel_text_address into module.c, since it isn't
> > compiled for CONFIG_MODULES=n.
> 
> Good point, how about if i make modlist_lock a global?

I keep fighting to keep it static 8)

How's this:

Name: Fix race between CONFIG_DEBUG_SLABALLOC and modules
Status: Compiled on 2.6.7
Version: -mm
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au> (modified)
Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

store_stackinfo() does an unlocked module list walk during normal runtime
which opens up a race with the module load/unload code. This can be
triggered by simply unloading and loading a module in a loop with
CONFIG_DEBUG_PAGEALLOC resulting in store_stackinfo() tripping over bad
list pointers.

kernel_text_address doesn't take any locks, because during an OOPS we
don't want to deadlock.  Rename that to __kernel_text_address, and
make kernel_text_address take the lock.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32285-linux-2.6.7-mm1/arch/i386/kernel/traps.c .32285-linux-2.6.7-mm1.updated/arch/i386/kernel/traps.c
--- .32285-linux-2.6.7-mm1/arch/i386/kernel/traps.c	2004-06-22 10:37:21.000000000 +1000
+++ .32285-linux-2.6.7-mm1.updated/arch/i386/kernel/traps.c	2004-06-24 17:17:42.000000000 +1000
@@ -158,7 +158,7 @@ static void print_context_stack(struct t
 
 	while (!kstack_end(stack)) {
 		addr = *stack++;
-		if (kernel_text_address(addr)) {
+		if (__kernel_text_address(addr)) {
 			printk(" [<%08lx>]", addr);
 			print_symbol(" %s", addr);
 			printk("\n");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32285-linux-2.6.7-mm1/arch/m68k/kernel/traps.c .32285-linux-2.6.7-mm1.updated/arch/m68k/kernel/traps.c
--- .32285-linux-2.6.7-mm1/arch/m68k/kernel/traps.c	2004-06-22 10:37:22.000000000 +1000
+++ .32285-linux-2.6.7-mm1.updated/arch/m68k/kernel/traps.c	2004-06-24 17:17:29.000000000 +1000
@@ -911,7 +911,7 @@ void show_trace(unsigned long *stack)
 		 * down the cause of the crash will be able to figure
 		 * out the call path that was taken.
 		 */
-		if (kernel_text_address(addr)) {
+		if (__kernel_text_address(addr)) {
 #ifndef CONFIG_KALLSYMS
 			if (i % 5 == 0)
 				printk("\n       ");
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32285-linux-2.6.7-mm1/arch/mips/kernel/traps.c .32285-linux-2.6.7-mm1.updated/arch/mips/kernel/traps.c
--- .32285-linux-2.6.7-mm1/arch/mips/kernel/traps.c	2004-05-10 15:12:51.000000000 +1000
+++ .32285-linux-2.6.7-mm1.updated/arch/mips/kernel/traps.c	2004-06-24 17:17:29.000000000 +1000
@@ -118,7 +118,7 @@ void show_trace(struct task_struct *task
 #endif
 	while (!kstack_end(stack)) {
 		addr = *stack++;
-		if (kernel_text_address(addr)) {
+		if (__kernel_text_address(addr)) {
 			printk(" [<%0*lx>] ", field, addr);
 			print_symbol("%s\n", addr);
 		}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32285-linux-2.6.7-mm1/arch/parisc/kernel/traps.c .32285-linux-2.6.7-mm1.updated/arch/parisc/kernel/traps.c
--- .32285-linux-2.6.7-mm1/arch/parisc/kernel/traps.c	2004-05-10 15:12:54.000000000 +1000
+++ .32285-linux-2.6.7-mm1.updated/arch/parisc/kernel/traps.c	2004-06-24 17:17:29.000000000 +1000
@@ -188,7 +188,7 @@ void show_trace(struct task_struct *task
 		 * down the cause of the crash will be able to figure
 		 * out the call path that was taken.
 		 */
-		if (kernel_text_address(addr)) {
+		if (__kernel_text_address(addr)) {
 			printk(" [<" RFMT ">] ", addr);
 #ifdef CONFIG_KALLSYMS
 			print_symbol("%s\n", addr);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32285-linux-2.6.7-mm1/arch/um/kernel/sysrq.c .32285-linux-2.6.7-mm1.updated/arch/um/kernel/sysrq.c
--- .32285-linux-2.6.7-mm1/arch/um/kernel/sysrq.c	2004-05-10 15:13:11.000000000 +1000
+++ .32285-linux-2.6.7-mm1.updated/arch/um/kernel/sysrq.c	2004-06-24 17:17:29.000000000 +1000
@@ -23,7 +23,7 @@ void show_trace(unsigned long * stack)
         i = 1;
         while (((long) stack & (THREAD_SIZE-1)) != 0) {
                 addr = *stack++;
-		if (kernel_text_address(addr)) {
+		if (__kernel_text_address(addr)) {
 			if (i && ((i % 6) == 0))
 				printk("\n   ");
 			printk("[<%08lx>] ", addr);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32285-linux-2.6.7-mm1/arch/x86_64/kernel/traps.c .32285-linux-2.6.7-mm1.updated/arch/x86_64/kernel/traps.c
--- .32285-linux-2.6.7-mm1/arch/x86_64/kernel/traps.c	2004-06-22 10:37:26.000000000 +1000
+++ .32285-linux-2.6.7-mm1.updated/arch/x86_64/kernel/traps.c	2004-06-24 17:17:29.000000000 +1000
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32285-linux-2.6.7-mm1/include/linux/kernel.h .32285-linux-2.6.7-mm1.updated/include/linux/kernel.h
--- .32285-linux-2.6.7-mm1/include/linux/kernel.h	2004-06-22 10:37:52.000000000 +1000
+++ .32285-linux-2.6.7-mm1.updated/include/linux/kernel.h	2004-06-24 17:17:30.000000000 +1000
@@ -88,6 +88,7 @@ extern int get_option(char **str, int *p
 extern char *get_options(const char *str, int nints, int *ints);
 extern unsigned long long memparse(char *ptr, char **retptr);
 
+extern int __kernel_text_address(unsigned long addr);
 extern int kernel_text_address(unsigned long addr);
 extern int session_of_pgrp(int pgrp);
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32285-linux-2.6.7-mm1/include/linux/module.h .32285-linux-2.6.7-mm1.updated/include/linux/module.h
--- .32285-linux-2.6.7-mm1/include/linux/module.h	2004-06-17 08:49:34.000000000 +1000
+++ .32285-linux-2.6.7-mm1.updated/include/linux/module.h	2004-06-24 17:17:30.000000000 +1000
@@ -316,8 +316,9 @@ static inline int module_is_live(struct 
 	return mod->state != MODULE_STATE_GOING;
 }
 
-/* Is this address in a module? */
+/* Is this address in a module? (second is with no locks, for oops) */
 struct module *module_text_address(unsigned long addr);
+struct module *__module_text_address(unsigned long addr);
 
 /* Returns module and fills in value, defined and namebuf, or NULL if
    symnum out of range. */
@@ -443,6 +444,12 @@ static inline struct module *module_text
 	return NULL;
 }
 
+/* Is this address in a module? (don't take a lock, we're oopsing) */
+static inline struct module *__module_text_address(unsigned long addr)
+{
+	return NULL;
+}
+
 /* Get/put a kernel symbol (calls should be symmetric) */
 #define symbol_get(x) ({ extern typeof(x) x __attribute__((weak)); &(x); })
 #define symbol_put(x) do { } while(0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32285-linux-2.6.7-mm1/kernel/extable.c .32285-linux-2.6.7-mm1.updated/kernel/extable.c
--- .32285-linux-2.6.7-mm1/kernel/extable.c	2004-02-04 15:39:15.000000000 +1100
+++ .32285-linux-2.6.7-mm1.updated/kernel/extable.c	2004-06-24 17:17:30.000000000 +1000
@@ -40,7 +40,7 @@ const struct exception_table_entry *sear
 	return e;
 }
 
-int kernel_text_address(unsigned long addr)
+static int core_kernel_text(unsigned long addr)
 {
 	if (addr >= (unsigned long)_stext &&
 	    addr <= (unsigned long)_etext)
@@ -49,6 +49,19 @@ int kernel_text_address(unsigned long ad
 	if (addr >= (unsigned long)_sinittext &&
 	    addr <= (unsigned long)_einittext)
 		return 1;
+	return 0;
+}
 
+int __kernel_text_address(unsigned long addr)
+{
+	if (core_kernel_text(addr))
+		return 1;
+	return __module_text_address(addr) != NULL;
+}
+
+int kernel_text_address(unsigned long addr)
+{
+	if (core_kernel_text(addr))
+		return 1;
 	return module_text_address(addr) != NULL;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .32285-linux-2.6.7-mm1/kernel/module.c .32285-linux-2.6.7-mm1.updated/kernel/module.c
--- .32285-linux-2.6.7-mm1/kernel/module.c	2004-06-22 10:37:52.000000000 +1000
+++ .32285-linux-2.6.7-mm1.updated/kernel/module.c	2004-06-24 17:17:30.000000000 +1000
@@ -2028,7 +2028,7 @@ const struct exception_table_entry *sear
 }
 
 /* Is this a valid kernel address?  We don't grab the lock: we are oopsing. */
-struct module *module_text_address(unsigned long addr)
+struct module *__module_text_address(unsigned long addr)
 {
 	struct module *mod;
 
@@ -2039,6 +2039,18 @@ struct module *module_text_address(unsig
 	return NULL;
 }
 
+struct module *module_text_address(unsigned long addr)
+{
+	struct module *mod;
+	unsigned long flags;
+
+	spin_lock_irqsave(&modlist_lock, flags);
+	mod = __module_text_address(addr);
+	spin_unlock_irqrestore(&modlist_lock, flags);
+
+	return mod;
+}
+
 /* Don't grab lock, we're oopsing. */
 void print_modules(void)
 {


-- 
Anyone who quotes me in their signature is an idiot -- Rusty Russell

