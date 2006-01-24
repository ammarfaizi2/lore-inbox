Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964991AbWAXPdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964991AbWAXPdg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 10:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964992AbWAXPdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 10:33:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:38019 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964991AbWAXPdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 10:33:35 -0500
Message-ID: <43D648CC.4090101@suse.de>
Date: Tue, 24 Jan 2006 16:33:32 +0100
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH] SMP alternatives
Content-Type: multipart/mixed;
 boundary="------------010204000904050907080308"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010204000904050907080308
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


  Hi Andrew,

Can you include the patch in -mm to give it some testing?  Then merge
maybe for 2.6.17?  Posted last time in december, with nobody complaining
any more about the most recent version.  The patch is almost unmodified
since, I've only had to add a small chunk due to the mutex merge.
Description is below, the patch (against -rc1-git4 snapshot) is attached.

cheers,

  Gerd

=====================================================================

This patch implements SMP alternatives, i.e. switching at runtime
between different code versions for UP and SMP.  The code can patch both
SMP->UP and UP->SMP.  The UP->SMP case is useful for CPU hotplug.

With CONFIG_CPU_HOTPLUG enabled the code switches to UP at boot
time and when the number of CPUs goes down to 1, and switches to
SMP when the number of CPUs goes up to 2.

Without CONFIG_CPU_HOTPLUG or on non-SMP-capable systems the code
is patched once at boot time (if needed) and the tables are
released afterwards.

The changes in detail:

  * The current alternatives bits are moved to a separate file,
    the SMP alternatives code is added there.

  * The patch adds some new elf sections to the kernel:
    .smp_altinstructions
        like .altinstructions, also contains a list
        of alt_instr structs.
    .smp_altinstr_replacement
        like .altinstr_replacement, but also has some space to
        save original instruction before replaving it.
    .smp_locks
        list of pointers to lock prefixes which can be nop'ed
        out on UP.
    The first two are used to replace more complex instruction
    sequences such as spinlocks and semaphores.  It would be possible
    to deal with the lock prefixes with that as well, but by handling
    them as special case the table sizes become much smaller.

 * The sections are page-aligned and padded up to page size, so they
   can be free if they are not needed.

 * Splitted the code to release init pages to a separate function and
   use it to release the elf sections if they are unused.

-- 
Gerd 'just married' Hoffmann <kraxel@suse.de>
I'm the hacker formerly known as Gerd Knorr.
http://www.suse.de/~kraxel/just-married.jpeg

--------------010204000904050907080308
Content-Type: text/plain;
 name="smp-alternatives"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smp-alternatives"

This patch implements SMP alternatives, i.e. switching at runtime
between different code versions for UP and SMP.  The code can patch both
SMP->UP and UP->SMP.  The UP->SMP case is useful for CPU hotplug.

With CONFIG_CPU_HOTPLUG enabled the code switches to UP at boot
time and when the number of CPUs goes down to 1, and switches to
SMP when the number of CPUs goes up to 2.

Without CONFIG_CPU_HOTPLUG or on non-SMP-capable systems the code
is patched once at boot time (if needed) and the tables are
released afterwards.

The changes in detail:

  * The current alternatives bits are moved to a separate file,
    the SMP alternatives code is added there.

  * The patch adds some new elf sections to the kernel:
    .smp_altinstructions
	like .altinstructions, also contains a list
	of alt_instr structs.
    .smp_altinstr_replacement
	like .altinstr_replacement, but also has some space to
	save original instruction before replaving it.
    .smp_locks
	list of pointers to lock prefixes which can be nop'ed
	out on UP.
    The first two are used to replace more complex instruction
    sequences such as spinlocks and semaphores.  It would be possible
    to deal with the lock prefixes with that as well, but by handling
    them as special case the table sizes become much smaller.

 * The sections are page-aligned and padded up to page size, so they
   can be free if they are not needed.

 * Splitted the code to release init pages to a separate function and
   use it to release the elf sections if they are unused.

Signed-off-by: Gerd Knorr <kraxel@suse.de>
Index: vanilla-2.6.15/arch/i386/kernel/Makefile
===================================================================
--- vanilla-2.6.15.orig/arch/i386/kernel/Makefile
+++ vanilla-2.6.15/arch/i386/kernel/Makefile
@@ -7,7 +7,7 @@ extra-y := head.o init_task.o vmlinux.ld
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		quirks.o i8237.o
+		quirks.o i8237.o alternative.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
Index: vanilla-2.6.15/arch/i386/kernel/alternative.c
===================================================================
--- /dev/null
+++ vanilla-2.6.15/arch/i386/kernel/alternative.c
@@ -0,0 +1,320 @@
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <linux/list.h>
+#include <asm/alternative.h>
+
+#define DEBUG 0
+#if DEBUG
+# define DPRINTK(fmt, args...) printk(fmt, args)
+#else
+# define DPRINTK(fmt, args...)
+#endif
+
+/* Use inline assembly to define this because the nops are defined 
+   as inline assembly strings in the include files and we cannot 
+   get them easily into strings. */
+asm("\t.data\nintelnops: " 
+    GENERIC_NOP1 GENERIC_NOP2 GENERIC_NOP3 GENERIC_NOP4 GENERIC_NOP5 GENERIC_NOP6
+    GENERIC_NOP7 GENERIC_NOP8); 
+asm("\t.data\nk8nops: " 
+    K8_NOP1 K8_NOP2 K8_NOP3 K8_NOP4 K8_NOP5 K8_NOP6
+    K8_NOP7 K8_NOP8); 
+asm("\t.data\nk7nops: " 
+    K7_NOP1 K7_NOP2 K7_NOP3 K7_NOP4 K7_NOP5 K7_NOP6
+    K7_NOP7 K7_NOP8); 
+    
+extern unsigned char intelnops[], k8nops[], k7nops[];
+static unsigned char *intel_nops[ASM_NOP_MAX+1] = { 
+     NULL,
+     intelnops,
+     intelnops + 1,
+     intelnops + 1 + 2,
+     intelnops + 1 + 2 + 3,
+     intelnops + 1 + 2 + 3 + 4,
+     intelnops + 1 + 2 + 3 + 4 + 5,
+     intelnops + 1 + 2 + 3 + 4 + 5 + 6,
+     intelnops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
+}; 
+static unsigned char *k8_nops[ASM_NOP_MAX+1] = { 
+     NULL,
+     k8nops,
+     k8nops + 1,
+     k8nops + 1 + 2,
+     k8nops + 1 + 2 + 3,
+     k8nops + 1 + 2 + 3 + 4,
+     k8nops + 1 + 2 + 3 + 4 + 5,
+     k8nops + 1 + 2 + 3 + 4 + 5 + 6,
+     k8nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
+}; 
+static unsigned char *k7_nops[ASM_NOP_MAX+1] = { 
+     NULL,
+     k7nops,
+     k7nops + 1,
+     k7nops + 1 + 2,
+     k7nops + 1 + 2 + 3,
+     k7nops + 1 + 2 + 3 + 4,
+     k7nops + 1 + 2 + 3 + 4 + 5,
+     k7nops + 1 + 2 + 3 + 4 + 5 + 6,
+     k7nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
+}; 
+static struct nop { 
+     int cpuid; 
+     unsigned char **noptable; 
+} noptypes[] = { 
+     { X86_FEATURE_K8, k8_nops }, 
+     { X86_FEATURE_K7, k7_nops }, 
+     { -1, NULL }
+}; 
+
+
+extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
+extern struct alt_instr __smp_alt_instructions[], __smp_alt_instructions_end[];
+extern u8 *__smp_locks[], *__smp_locks_end[];
+
+extern u8 _text[], _etext[];
+extern u8 __smp_alt_begin[], __smp_alt_end[];
+
+
+static unsigned char** find_nop_table(void)
+{
+        unsigned char **noptable = intel_nops;
+	int i;
+
+	for (i = 0; noptypes[i].cpuid >= 0; i++) { 
+		if (boot_cpu_has(noptypes[i].cpuid)) { 
+			noptable = noptypes[i].noptable;
+			break;
+		}
+	}
+	return noptable;
+}
+
+/* Replace instructions with better alternatives for this CPU type.
+   This runs before SMP is initialized to avoid SMP problems with
+   self modifying code. This implies that assymetric systems where
+   APs have less capabilities than the boot processor are not handled. 
+   Tough. Make sure you disable such features by hand. */
+
+void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
+{ 
+        unsigned char **noptable = find_nop_table();
+	struct alt_instr *a; 
+	int diff, i, k;
+
+	DPRINTK("%s: alt table %p -> %p\n", __FUNCTION__, start, end);
+	for (a = start; a < end; a++) { 
+		BUG_ON(a->replacementlen > a->instrlen); 
+		if (!boot_cpu_has(a->cpuid))
+			continue;
+		memcpy(a->instr, a->replacement, a->replacementlen); 
+		diff = a->instrlen - a->replacementlen; 
+		/* Pad the rest with nops */
+		for (i = a->replacementlen; diff > 0; diff -= k, i += k) {
+			k = diff;
+			if (k > ASM_NOP_MAX)
+				k = ASM_NOP_MAX;
+			memcpy(a->instr + i, noptable[k], k); 
+		} 
+	}
+} 
+
+static void alternatives_smp_save(struct alt_instr *start, struct alt_instr *end)
+{
+	struct alt_instr *a;
+
+	DPRINTK("%s: alt table %p-%p\n", __FUNCTION__, start, end);
+	for (a = start; a < end; a++) {
+		memcpy(a->replacement + a->replacementlen,
+		       a->instr,
+		       a->instrlen);
+	}
+}
+
+static void alternatives_smp_apply(struct alt_instr *start, struct alt_instr *end)
+{
+	struct alt_instr *a;
+
+	for (a = start; a < end; a++) {
+		memcpy(a->instr,
+		       a->replacement + a->replacementlen,
+		       a->instrlen);
+	}
+}
+
+static void alternatives_smp_lock(u8 **start, u8 **end, u8 *text, u8 *text_end)
+{
+	u8 **ptr;
+
+	for (ptr = start; ptr < end; ptr++) {
+		if (*ptr < text)
+			continue;
+		if (*ptr > text_end)
+			continue;
+		**ptr = 0xf0; /* lock prefix */
+	};
+}
+
+static void alternatives_smp_unlock(u8 **start, u8 **end, u8 *text, u8 *text_end)
+{
+        unsigned char **noptable = find_nop_table();
+	u8 **ptr;
+
+	for (ptr = start; ptr < end; ptr++) {
+		if (*ptr < text)
+			continue;
+		if (*ptr > text_end)
+			continue;
+		**ptr = noptable[1][0];
+	};
+}
+
+struct smp_alt_module {
+	/* what is this ??? */
+	struct module    *mod;
+	char             *name;
+
+	/* ptrs to lock prefixes */
+	u8               **locks;
+	u8               **locks_end;
+
+	/* .text segment, needed to avoid patching init code ;) */
+	u8               *text;
+	u8               *text_end;
+
+	struct list_head next;
+};
+static LIST_HEAD(smp_alt_modules);
+static DEFINE_SPINLOCK(smp_alt);
+
+static int smp_alt_once = 0;
+static int __init bootonly(char *str)
+{
+	smp_alt_once = 1;
+	return 1;
+}
+__setup("smp-alt-boot", bootonly);
+
+void alternatives_smp_module_add(struct module *mod, char *name,
+				 void *locks, void *locks_end,
+				 void *text,  void *text_end)
+{
+	struct smp_alt_module *smp;
+	unsigned long flags;
+
+	if (smp_alt_once) {
+		if (boot_cpu_has(X86_FEATURE_UP))
+			alternatives_smp_unlock(locks, locks_end,
+						text, text_end);
+		return;
+	}
+
+	smp = kzalloc(sizeof(*smp), GFP_KERNEL);
+	if (NULL == smp)
+		return; /* we'll run the (safe but slow) SMP code then ... */
+
+	smp->mod       = mod;
+	smp->name      = name;
+	smp->locks     = locks;
+	smp->locks_end = locks_end;
+	smp->text      = text;
+	smp->text_end  = text_end;
+	DPRINTK("%s: locks %p -> %p, text %p -> %p, name %s\n",
+		__FUNCTION__, smp->locks, smp->locks_end,
+		smp->text, smp->text_end, smp->name);
+
+	spin_lock_irqsave(&smp_alt, flags);
+	list_add_tail(&smp->next, &smp_alt_modules);
+	if (boot_cpu_has(X86_FEATURE_UP))
+		alternatives_smp_unlock(smp->locks, smp->locks_end,
+					smp->text, smp->text_end);
+	spin_unlock_irqrestore(&smp_alt, flags);
+}
+
+void alternatives_smp_module_del(struct module *mod)
+{
+	struct smp_alt_module *item;
+	unsigned long flags;
+
+	if (smp_alt_once)
+		return;
+
+	spin_lock_irqsave(&smp_alt, flags);
+	list_for_each_entry(item, &smp_alt_modules, next) {
+		if (mod != item->mod)
+			continue;
+		list_del(&item->next);
+		spin_unlock_irqrestore(&smp_alt, flags);
+		DPRINTK("%s: %s\n", __FUNCTION__, item->name);
+		kfree(item);
+		return;
+	}
+	spin_unlock_irqrestore(&smp_alt, flags);
+}
+
+void alternatives_smp_switch(int smp) 
+{
+	struct smp_alt_module *mod;
+	unsigned long flags;
+
+	if (smp_alt_once)
+		return;
+	BUG_ON(!smp && (num_online_cpus() > 1));
+
+	spin_lock_irqsave(&smp_alt, flags);
+	if (smp) {
+		printk(KERN_INFO "SMP alternatives: switching to SMP code\n");
+		clear_bit(X86_FEATURE_UP, boot_cpu_data.x86_capability);
+		alternatives_smp_apply(__smp_alt_instructions,
+				       __smp_alt_instructions_end);
+		list_for_each_entry(mod, &smp_alt_modules, next)
+			alternatives_smp_lock(mod->locks, mod->locks_end,
+					      mod->text, mod->text_end);
+	} else {
+		printk(KERN_INFO "SMP alternatives: switching to UP code\n");
+		set_bit(X86_FEATURE_UP, boot_cpu_data.x86_capability);
+		apply_alternatives(__smp_alt_instructions,
+				   __smp_alt_instructions_end);
+		list_for_each_entry(mod, &smp_alt_modules, next)
+			alternatives_smp_unlock(mod->locks, mod->locks_end,
+						mod->text, mod->text_end);
+	}
+	spin_unlock_irqrestore(&smp_alt, flags);
+} 
+
+extern void free_init_pages(char *what, unsigned long begin, unsigned long end);
+
+void __init alternative_instructions(void)
+{
+	apply_alternatives(__alt_instructions, __alt_instructions_end);
+
+	/* switch to patch-once-at-boottime-only mode and free the
+	 * tables in case we know the number of CPUs will never ever
+	 * change */
+#ifdef CONFIG_HOTPLUG_CPU
+	if (num_possible_cpus() < 2)
+		smp_alt_once = 1;
+#else
+	smp_alt_once = 1;
+#endif
+	
+	if (smp_alt_once) {
+		if (1 == num_possible_cpus()) {
+			printk(KERN_INFO "SMP alternatives: switching to UP code\n");
+			set_bit(X86_FEATURE_UP, boot_cpu_data.x86_capability);
+			apply_alternatives(__smp_alt_instructions,
+					   __smp_alt_instructions_end);
+			alternatives_smp_unlock(__smp_locks, __smp_locks_end,
+						_text, _etext);
+		}
+		free_init_pages("SMP alternatives",
+				(unsigned long)__smp_alt_begin,
+				(unsigned long)__smp_alt_end);
+	} else {
+		alternatives_smp_save(__smp_alt_instructions,
+				      __smp_alt_instructions_end);
+		alternatives_smp_module_add(NULL, "core kernel",
+					    __smp_locks, __smp_locks_end,
+					    _text, _etext);
+		alternatives_smp_switch(0);
+	}
+}
Index: vanilla-2.6.15/arch/i386/kernel/module.c
===================================================================
--- vanilla-2.6.15.orig/arch/i386/kernel/module.c
+++ vanilla-2.6.15/arch/i386/kernel/module.c
@@ -104,26 +104,38 @@ int apply_relocate_add(Elf32_Shdr *sechd
 	return -ENOEXEC;
 }
 
-extern void apply_alternatives(void *start, void *end); 
-
 int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
-	const Elf_Shdr *s;
+	const Elf_Shdr *s, *text = NULL, *alt = NULL, *locks = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
-	/* look for .altinstructions to patch */ 
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) { 
-		void *seg; 		
-		if (strcmp(".altinstructions", secstrings + s->sh_name))
-			continue;
-		seg = (void *)s->sh_addr; 
-		apply_alternatives(seg, seg + s->sh_size); 
-	} 	
+		if (!strcmp(".text", secstrings + s->sh_name))
+			text = s;
+		if (!strcmp(".altinstructions", secstrings + s->sh_name))
+			alt = s;
+		if (!strcmp(".smp_locks", secstrings + s->sh_name))
+			locks= s;
+	}
+
+	if (alt) {
+		/* patch .altinstructions */ 
+		void *aseg = (void *)alt->sh_addr;
+		apply_alternatives(aseg, aseg + alt->sh_size);
+	}
+	if (locks && text) {
+		void *lseg = (void *)locks->sh_addr;
+		void *tseg = (void *)text->sh_addr;
+		alternatives_smp_module_add(me, me->name,
+					    lseg, lseg + locks->sh_size,
+					    tseg, tseg + text->sh_size);
+	}
 	return 0;
 }
 
 void module_arch_cleanup(struct module *mod)
 {
+	alternatives_smp_module_del(mod);
 }
Index: vanilla-2.6.15/arch/i386/kernel/semaphore.c
===================================================================
--- vanilla-2.6.15.orig/arch/i386/kernel/semaphore.c
+++ vanilla-2.6.15/arch/i386/kernel/semaphore.c
@@ -110,11 +110,11 @@ asm(
 ".align	4\n"
 ".globl	__write_lock_failed\n"
 "__write_lock_failed:\n\t"
-	LOCK "addl	$" RW_LOCK_BIAS_STR ",(%eax)\n"
+	LOCK_PREFIX "addl	$" RW_LOCK_BIAS_STR ",(%eax)\n"
 "1:	rep; nop\n\t"
 	"cmpl	$" RW_LOCK_BIAS_STR ",(%eax)\n\t"
 	"jne	1b\n\t"
-	LOCK "subl	$" RW_LOCK_BIAS_STR ",(%eax)\n\t"
+	LOCK_PREFIX "subl	$" RW_LOCK_BIAS_STR ",(%eax)\n\t"
 	"jnz	__write_lock_failed\n\t"
 	"ret"
 );
@@ -124,11 +124,11 @@ asm(
 ".align	4\n"
 ".globl	__read_lock_failed\n"
 "__read_lock_failed:\n\t"
-	LOCK "incl	(%eax)\n"
+	LOCK_PREFIX "incl	(%eax)\n"
 "1:	rep; nop\n\t"
 	"cmpl	$1,(%eax)\n\t"
 	"js	1b\n\t"
-	LOCK "decl	(%eax)\n\t"
+	LOCK_PREFIX "decl	(%eax)\n\t"
 	"js	__read_lock_failed\n\t"
 	"ret"
 );
Index: vanilla-2.6.15/arch/i386/kernel/setup.c
===================================================================
--- vanilla-2.6.15.orig/arch/i386/kernel/setup.c
+++ vanilla-2.6.15/arch/i386/kernel/setup.c
@@ -1377,101 +1377,6 @@ static void __init register_memory(void)
 		pci_mem_start, gapstart, gapsize);
 }
 
-/* Use inline assembly to define this because the nops are defined 
-   as inline assembly strings in the include files and we cannot 
-   get them easily into strings. */
-asm("\t.data\nintelnops: " 
-    GENERIC_NOP1 GENERIC_NOP2 GENERIC_NOP3 GENERIC_NOP4 GENERIC_NOP5 GENERIC_NOP6
-    GENERIC_NOP7 GENERIC_NOP8); 
-asm("\t.data\nk8nops: " 
-    K8_NOP1 K8_NOP2 K8_NOP3 K8_NOP4 K8_NOP5 K8_NOP6
-    K8_NOP7 K8_NOP8); 
-asm("\t.data\nk7nops: " 
-    K7_NOP1 K7_NOP2 K7_NOP3 K7_NOP4 K7_NOP5 K7_NOP6
-    K7_NOP7 K7_NOP8); 
-    
-extern unsigned char intelnops[], k8nops[], k7nops[];
-static unsigned char *intel_nops[ASM_NOP_MAX+1] = { 
-     NULL,
-     intelnops,
-     intelnops + 1,
-     intelnops + 1 + 2,
-     intelnops + 1 + 2 + 3,
-     intelnops + 1 + 2 + 3 + 4,
-     intelnops + 1 + 2 + 3 + 4 + 5,
-     intelnops + 1 + 2 + 3 + 4 + 5 + 6,
-     intelnops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-}; 
-static unsigned char *k8_nops[ASM_NOP_MAX+1] = { 
-     NULL,
-     k8nops,
-     k8nops + 1,
-     k8nops + 1 + 2,
-     k8nops + 1 + 2 + 3,
-     k8nops + 1 + 2 + 3 + 4,
-     k8nops + 1 + 2 + 3 + 4 + 5,
-     k8nops + 1 + 2 + 3 + 4 + 5 + 6,
-     k8nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-}; 
-static unsigned char *k7_nops[ASM_NOP_MAX+1] = { 
-     NULL,
-     k7nops,
-     k7nops + 1,
-     k7nops + 1 + 2,
-     k7nops + 1 + 2 + 3,
-     k7nops + 1 + 2 + 3 + 4,
-     k7nops + 1 + 2 + 3 + 4 + 5,
-     k7nops + 1 + 2 + 3 + 4 + 5 + 6,
-     k7nops + 1 + 2 + 3 + 4 + 5 + 6 + 7,
-}; 
-static struct nop { 
-     int cpuid; 
-     unsigned char **noptable; 
-} noptypes[] = { 
-     { X86_FEATURE_K8, k8_nops }, 
-     { X86_FEATURE_K7, k7_nops }, 
-     { -1, NULL }
-}; 
-
-/* Replace instructions with better alternatives for this CPU type.
-
-   This runs before SMP is initialized to avoid SMP problems with
-   self modifying code. This implies that assymetric systems where
-   APs have less capabilities than the boot processor are not handled. 
-   Tough. Make sure you disable such features by hand. */ 
-void apply_alternatives(void *start, void *end) 
-{ 
-	struct alt_instr *a; 
-	int diff, i, k;
-        unsigned char **noptable = intel_nops; 
-	for (i = 0; noptypes[i].cpuid >= 0; i++) { 
-		if (boot_cpu_has(noptypes[i].cpuid)) { 
-			noptable = noptypes[i].noptable;
-			break;
-		}
-	} 
-	for (a = start; (void *)a < end; a++) { 
-		if (!boot_cpu_has(a->cpuid))
-			continue;
-		BUG_ON(a->replacementlen > a->instrlen); 
-		memcpy(a->instr, a->replacement, a->replacementlen); 
-		diff = a->instrlen - a->replacementlen; 
-		/* Pad the rest with nops */
-		for (i = a->replacementlen; diff > 0; diff -= k, i += k) {
-			k = diff;
-			if (k > ASM_NOP_MAX)
-				k = ASM_NOP_MAX;
-			memcpy(a->instr + i, noptable[k], k); 
-		} 
-	}
-} 
-
-void __init alternative_instructions(void)
-{
-	extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
-	apply_alternatives(__alt_instructions, __alt_instructions_end);
-}
-
 static char * __init machine_specific_memory_setup(void);
 
 #ifdef CONFIG_MCA
Index: vanilla-2.6.15/arch/i386/kernel/smpboot.c
===================================================================
--- vanilla-2.6.15.orig/arch/i386/kernel/smpboot.c
+++ vanilla-2.6.15/arch/i386/kernel/smpboot.c
@@ -909,6 +909,7 @@ static int __devinit do_boot_cpu(int api
 	}
 
 	++cpucount;
+	alternatives_smp_switch(1);
 
 	/*
 	 * We can't use kernel_thread since we must avoid to
@@ -1368,6 +1369,8 @@ void __cpu_die(unsigned int cpu)
 		/* They ack this in play_dead by setting CPU_DEAD */
 		if (per_cpu(cpu_state, cpu) == CPU_DEAD) {
 			printk ("CPU %d is now offline\n", cpu);
+			if (1 == num_online_cpus())
+				alternatives_smp_switch(0);
 			return;
 		}
 		msleep(100);
Index: vanilla-2.6.15/arch/i386/kernel/vmlinux.lds.S
===================================================================
--- vanilla-2.6.15.orig/arch/i386/kernel/vmlinux.lds.S
+++ vanilla-2.6.15/arch/i386/kernel/vmlinux.lds.S
@@ -68,6 +68,26 @@ SECTIONS
 	*(.data.init_task)
   }
 
+  /* might get freed after init */
+  . = ALIGN(4096);
+  __smp_alt_begin = .;
+  __smp_alt_instructions = .;
+  .smp_altinstructions : AT(ADDR(.smp_altinstructions) - LOAD_OFFSET) {
+	*(.smp_altinstructions)
+  }
+  __smp_alt_instructions_end = .; 
+  . = ALIGN(4);
+  __smp_locks = .;
+  .smp_locks : AT(ADDR(.smp_locks) - LOAD_OFFSET) {
+	*(.smp_locks)
+  }
+  __smp_locks_end = .; 
+  .smp_altinstr_replacement : AT(ADDR(.smp_altinstr_replacement) - LOAD_OFFSET) {
+	*(.smp_altinstr_replacement)
+  }
+  . = ALIGN(4096);
+  __smp_alt_end = .;
+
   /* will be freed after init */
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
Index: vanilla-2.6.15/arch/i386/mm/init.c
===================================================================
--- vanilla-2.6.15.orig/arch/i386/mm/init.c
+++ vanilla-2.6.15/arch/i386/mm/init.c
@@ -720,21 +720,6 @@ static int noinline do_test_wp_bit(void)
 	return flag;
 }
 
-void free_initmem(void)
-{
-	unsigned long addr;
-
-	addr = (unsigned long)(&__init_begin);
-	for (; addr < (unsigned long)(&__init_end); addr += PAGE_SIZE) {
-		ClearPageReserved(virt_to_page(addr));
-		set_page_count(virt_to_page(addr), 1);
-		memset((void *)addr, 0xcc, PAGE_SIZE);
-		free_page(addr);
-		totalram_pages++;
-	}
-	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n", (__init_end - __init_begin) >> 10);
-}
-
 #ifdef CONFIG_DEBUG_RODATA
 
 extern char __start_rodata, __end_rodata;
@@ -758,17 +743,31 @@ void mark_rodata_ro(void)
 }
 #endif
 
+void free_init_pages(char *what, unsigned long begin, unsigned long end)
+{
+	unsigned long addr;
+
+	for (addr = begin; addr < end; addr += PAGE_SIZE) {
+		ClearPageReserved(virt_to_page(addr));
+		set_page_count(virt_to_page(addr), 1);
+		memset((void *)addr, 0xcc, PAGE_SIZE);
+		free_page(addr);
+		totalram_pages++;
+	}
+	printk(KERN_INFO "Freeing %s: %ldk freed\n", what, (end - begin) >> 10);
+}
+
+void free_initmem(void)
+{
+	free_init_pages("unused kernel memory",
+			(unsigned long)(&__init_begin),
+			(unsigned long)(&__init_end));
+}
 
 #ifdef CONFIG_BLK_DEV_INITRD
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
-	if (start < end)
-		printk (KERN_INFO "Freeing initrd memory: %ldk freed\n", (end - start) >> 10);
-	for (; start < end; start += PAGE_SIZE) {
-		ClearPageReserved(virt_to_page(start));
-		set_page_count(virt_to_page(start), 1);
-		free_page(start);
-		totalram_pages++;
-	}
+	free_init_pages("initrd memory", start, end);
 }
 #endif
+
Index: vanilla-2.6.15/include/asm-i386/alternative.h
===================================================================
--- /dev/null
+++ vanilla-2.6.15/include/asm-i386/alternative.h
@@ -0,0 +1,129 @@
+#ifndef _I386_ALTERNATIVE_H
+#define _I386_ALTERNATIVE_H
+
+#ifdef __KERNEL__
+
+struct alt_instr { 
+	u8 *instr; 		/* original instruction */
+	u8 *replacement;
+	u8  cpuid;		/* cpuid bit set for replacement */
+	u8  instrlen;		/* length of original instruction */
+	u8  replacementlen; 	/* length of new instruction, <= instrlen */ 
+	u8  pad;
+}; 
+
+extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
+
+struct module;
+extern void alternatives_smp_module_add(struct module *mod, char *name,
+					void *locks, void *locks_end,
+					void *text, void *text_end);
+extern void alternatives_smp_module_del(struct module *mod);
+extern void alternatives_smp_switch(int smp);
+
+#endif
+
+/* 
+ * Alternative instructions for different CPU types or capabilities.
+ * 
+ * This allows to use optimized instructions even on generic binary
+ * kernels.
+ * 
+ * length of oldinstr must be longer or equal the length of newinstr
+ * It can be padded with nops as needed.
+ * 
+ * For non barrier like inlines please define new variants
+ * without volatile and memory clobber.
+ */
+#define alternative(oldinstr, newinstr, feature) 	\
+	asm volatile ("661:\n\t" oldinstr "\n662:\n" 		     \
+		      ".section .altinstructions,\"a\"\n"     	     \
+		      "  .align 4\n"				       \
+		      "  .long 661b\n"            /* label */          \
+		      "  .long 663f\n"		  /* new instruction */ 	\
+		      "  .byte %c0\n"             /* feature bit */    \
+		      "  .byte 662b-661b\n"       /* sourcelen */      \
+		      "  .byte 664f-663f\n"       /* replacementlen */ \
+		      ".previous\n"						\
+		      ".section .altinstr_replacement,\"ax\"\n"			\
+		      "663:\n\t" newinstr "\n664:\n"   /* replacement */    \
+		      ".previous" :: "i" (feature) : "memory")  
+
+/*
+ * Alternative inline assembly with input.
+ * 
+ * Pecularities:
+ * No memory clobber here. 
+ * Argument numbers start with 1.
+ * Best is to use constraints that are fixed size (like (%1) ... "r")
+ * If you use variable sized constraints like "m" or "g" in the 
+ * replacement maake sure to pad to the worst case length.
+ */
+#define alternative_input(oldinstr, newinstr, feature, input...)		\
+	asm volatile ("661:\n\t" oldinstr "\n662:\n"				\
+		      ".section .altinstructions,\"a\"\n"			\
+		      "  .align 4\n"						\
+		      "  .long 661b\n"            /* label */			\
+		      "  .long 663f\n"		  /* new instruction */ 	\
+		      "  .byte %c0\n"             /* feature bit */		\
+		      "  .byte 662b-661b\n"       /* sourcelen */		\
+		      "  .byte 664f-663f\n"       /* replacementlen */ 		\
+		      ".previous\n"						\
+		      ".section .altinstr_replacement,\"ax\"\n"			\
+		      "663:\n\t" newinstr "\n664:\n"   /* replacement */ 	\
+		      ".previous" :: "i" (feature), ##input)
+
+/*
+ * Alternative inline assembly for SMP.
+ *
+ * alternative_smp() takes two versions (SMP first, UP second) and is
+ * for more complex stuff such as spinlocks.
+ *
+ * The LOCK_PREFIX macro defined here replaces the LOCK and
+ * LOCK_PREFIX macros used everywhere in the source tree.
+ *
+ * SMP alternatives use the same data structures as the other
+ * alternatives and the X86_FEATURE_UP flag to indicate the case of a
+ * UP system running a SMP kernel.  The existing apply_alternatives()
+ * works fine for patching a SMP kernel for UP.
+ * 
+ * The SMP alternative tables can be kept after boot and contain both
+ * UP and SMP versions of the instructions to allow switching back to
+ * SMP at runtime, when hotplugging in a new CPU, which is especially
+ * useful in virtualized environments.
+ *
+ * The very common lock prefix is handled as special case in a
+ * separate table which is a pure address list without replacement ptr
+ * and size information.  That keeps the table sizes small.
+ */ 
+
+#ifdef CONFIG_SMP
+#define alternative_smp(smpinstr, upinstr, args...) 	\
+	asm volatile ("661:\n\t" smpinstr "\n662:\n" 		     \
+		      ".section .smp_altinstructions,\"a\"\n"          \
+		      "  .align 4\n"				       \
+		      "  .long 661b\n"            /* label */          \
+		      "  .long 663f\n"		  /* new instruction */ 	\
+		      "  .byte 0x68\n"            /* X86_FEATURE_UP */    \
+		      "  .byte 662b-661b\n"       /* sourcelen */      \
+		      "  .byte 664f-663f\n"       /* replacementlen */ \
+		      ".previous\n"						\
+		      ".section .smp_altinstr_replacement,\"awx\"\n"   		\
+		      "663:\n\t" upinstr "\n"     /* replacement */    \
+		      "664:\n\t.fill 662b-661b,1,0x42\n" /* space for original */ \
+		      ".previous" : args)
+
+#define LOCK_PREFIX \
+		".section .smp_locks,\"a\"\n"	\
+		"  .align 4\n"			\
+		"  .long 661f\n" /* address */	\
+		".previous\n"			\
+	       	"661:\n\tlock; "
+
+#else /* ! CONFIG_SMP */
+#define alternative_smp(smpinstr, upinstr, args...) \
+	asm volatile (upinstr : args)
+#define LOCK_PREFIX ""
+#endif
+
+#endif /* _I386_ALTERNATIVE_H */
Index: vanilla-2.6.15/include/asm-i386/atomic.h
===================================================================
--- vanilla-2.6.15.orig/include/asm-i386/atomic.h
+++ vanilla-2.6.15/include/asm-i386/atomic.h
@@ -10,12 +10,6 @@
  * resource counting etc..
  */
 
-#ifdef CONFIG_SMP
-#define LOCK "lock ; "
-#else
-#define LOCK ""
-#endif
-
 /*
  * Make sure gcc doesn't try to be clever and move things around
  * on us. We need to use _exactly_ the address the user gave us,
@@ -52,7 +46,7 @@ typedef struct { volatile int counter; }
 static __inline__ void atomic_add(int i, atomic_t *v)
 {
 	__asm__ __volatile__(
-		LOCK "addl %1,%0"
+		LOCK_PREFIX "addl %1,%0"
 		:"=m" (v->counter)
 		:"ir" (i), "m" (v->counter));
 }
@@ -67,7 +61,7 @@ static __inline__ void atomic_add(int i,
 static __inline__ void atomic_sub(int i, atomic_t *v)
 {
 	__asm__ __volatile__(
-		LOCK "subl %1,%0"
+		LOCK_PREFIX "subl %1,%0"
 		:"=m" (v->counter)
 		:"ir" (i), "m" (v->counter));
 }
@@ -86,7 +80,7 @@ static __inline__ int atomic_sub_and_tes
 	unsigned char c;
 
 	__asm__ __volatile__(
-		LOCK "subl %2,%0; sete %1"
+		LOCK_PREFIX "subl %2,%0; sete %1"
 		:"=m" (v->counter), "=qm" (c)
 		:"ir" (i), "m" (v->counter) : "memory");
 	return c;
@@ -101,7 +95,7 @@ static __inline__ int atomic_sub_and_tes
 static __inline__ void atomic_inc(atomic_t *v)
 {
 	__asm__ __volatile__(
-		LOCK "incl %0"
+		LOCK_PREFIX "incl %0"
 		:"=m" (v->counter)
 		:"m" (v->counter));
 }
@@ -115,7 +109,7 @@ static __inline__ void atomic_inc(atomic
 static __inline__ void atomic_dec(atomic_t *v)
 {
 	__asm__ __volatile__(
-		LOCK "decl %0"
+		LOCK_PREFIX "decl %0"
 		:"=m" (v->counter)
 		:"m" (v->counter));
 }
@@ -133,7 +127,7 @@ static __inline__ int atomic_dec_and_tes
 	unsigned char c;
 
 	__asm__ __volatile__(
-		LOCK "decl %0; sete %1"
+		LOCK_PREFIX "decl %0; sete %1"
 		:"=m" (v->counter), "=qm" (c)
 		:"m" (v->counter) : "memory");
 	return c != 0;
@@ -152,7 +146,7 @@ static __inline__ int atomic_inc_and_tes
 	unsigned char c;
 
 	__asm__ __volatile__(
-		LOCK "incl %0; sete %1"
+		LOCK_PREFIX "incl %0; sete %1"
 		:"=m" (v->counter), "=qm" (c)
 		:"m" (v->counter) : "memory");
 	return c != 0;
@@ -172,7 +166,7 @@ static __inline__ int atomic_add_negativ
 	unsigned char c;
 
 	__asm__ __volatile__(
-		LOCK "addl %2,%0; sets %1"
+		LOCK_PREFIX "addl %2,%0; sets %1"
 		:"=m" (v->counter), "=qm" (c)
 		:"ir" (i), "m" (v->counter) : "memory");
 	return c;
@@ -195,7 +189,7 @@ static __inline__ int atomic_add_return(
 	/* Modern 486+ processor */
 	__i = i;
 	__asm__ __volatile__(
-		LOCK "xaddl %0, %1;"
+		LOCK_PREFIX "xaddl %0, %1;"
 		:"=r"(i)
 		:"m"(v->counter), "0"(i));
 	return i + __i;
@@ -242,11 +236,11 @@ static __inline__ int atomic_sub_return(
 
 /* These are x86-specific, used by some header files */
 #define atomic_clear_mask(mask, addr) \
-__asm__ __volatile__(LOCK "andl %0,%1" \
+__asm__ __volatile__(LOCK_PREFIX "andl %0,%1" \
 : : "r" (~(mask)),"m" (*addr) : "memory")
 
 #define atomic_set_mask(mask, addr) \
-__asm__ __volatile__(LOCK "orl %0,%1" \
+__asm__ __volatile__(LOCK_PREFIX "orl %0,%1" \
 : : "r" (mask),"m" (*(addr)) : "memory")
 
 /* Atomic operations are already serializing on x86 */
Index: vanilla-2.6.15/include/asm-i386/bitops.h
===================================================================
--- vanilla-2.6.15.orig/include/asm-i386/bitops.h
+++ vanilla-2.6.15/include/asm-i386/bitops.h
@@ -7,6 +7,7 @@
 
 #include <linux/config.h>
 #include <linux/compiler.h>
+#include <asm/alternative.h>
 
 /*
  * These have to be done with inline assembly: that way the bit-setting
@@ -16,12 +17,6 @@
  * bit 0 is the LSB of addr; bit 32 is the LSB of (addr+1).
  */
 
-#ifdef CONFIG_SMP
-#define LOCK_PREFIX "lock ; "
-#else
-#define LOCK_PREFIX ""
-#endif
-
 #define ADDR (*(volatile long *) addr)
 
 /**
Index: vanilla-2.6.15/include/asm-i386/cpufeature.h
===================================================================
--- vanilla-2.6.15.orig/include/asm-i386/cpufeature.h
+++ vanilla-2.6.15/include/asm-i386/cpufeature.h
@@ -71,6 +71,8 @@
 #define X86_FEATURE_P4		(3*32+ 7) /* P4 */
 #define X86_FEATURE_CONSTANT_TSC (3*32+ 8) /* TSC ticks at a constant rate */
 
+#define X86_FEATURE_UP		(3*32+ 8) /* smp kernel running on up */
+
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
 #define X86_FEATURE_MWAIT	(4*32+ 3) /* Monitor/Mwait support */
Index: vanilla-2.6.15/include/asm-i386/rwlock.h
===================================================================
--- vanilla-2.6.15.orig/include/asm-i386/rwlock.h
+++ vanilla-2.6.15/include/asm-i386/rwlock.h
@@ -21,21 +21,23 @@
 #define RW_LOCK_BIAS_STR	"0x01000000"
 
 #define __build_read_lock_ptr(rw, helper)   \
-	asm volatile(LOCK "subl $1,(%0)\n\t" \
-		     "jns 1f\n" \
-		     "call " helper "\n\t" \
-		     "1:\n" \
-		     ::"a" (rw) : "memory")
+	alternative_smp("lock; subl $1,(%0)\n\t" \
+			"jns 1f\n" \
+			"call " helper "\n\t" \
+			"1:\n", \
+			"subl $1,(%0)\n\t", \
+			:"a" (rw) : "memory")
 
 #define __build_read_lock_const(rw, helper)   \
-	asm volatile(LOCK "subl $1,%0\n\t" \
-		     "jns 1f\n" \
-		     "pushl %%eax\n\t" \
-		     "leal %0,%%eax\n\t" \
-		     "call " helper "\n\t" \
-		     "popl %%eax\n\t" \
-		     "1:\n" \
-		     :"=m" (*(volatile int *)rw) : : "memory")
+	alternative_smp("lock; subl $1,%0\n\t" \
+			"jns 1f\n" \
+			"pushl %%eax\n\t" \
+			"leal %0,%%eax\n\t" \
+			"call " helper "\n\t" \
+			"popl %%eax\n\t" \
+			"1:\n", \
+			"subl $1,%0\n\t", \
+			"=m" (*(volatile int *)rw) : : "memory")
 
 #define __build_read_lock(rw, helper)	do { \
 						if (__builtin_constant_p(rw)) \
@@ -45,21 +47,23 @@
 					} while (0)
 
 #define __build_write_lock_ptr(rw, helper) \
-	asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
-		     "jz 1f\n" \
-		     "call " helper "\n\t" \
-		     "1:\n" \
-		     ::"a" (rw) : "memory")
+	alternative_smp("lock; subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
+			"jz 1f\n" \
+			"call " helper "\n\t" \
+			"1:\n", \
+			"subl $" RW_LOCK_BIAS_STR ",(%0)\n\t", \
+			:"a" (rw) : "memory")
 
 #define __build_write_lock_const(rw, helper) \
-	asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",%0\n\t" \
-		     "jz 1f\n" \
-		     "pushl %%eax\n\t" \
-		     "leal %0,%%eax\n\t" \
-		     "call " helper "\n\t" \
-		     "popl %%eax\n\t" \
-		     "1:\n" \
-		     :"=m" (*(volatile int *)rw) : : "memory")
+	alternative_smp("lock; subl $" RW_LOCK_BIAS_STR ",%0\n\t" \
+			"jz 1f\n" \
+			"pushl %%eax\n\t" \
+			"leal %0,%%eax\n\t" \
+			"call " helper "\n\t" \
+			"popl %%eax\n\t" \
+			"1:\n", \
+			"subl $" RW_LOCK_BIAS_STR ",%0\n\t", \
+			"=m" (*(volatile int *)rw) : : "memory")
 
 #define __build_write_lock(rw, helper)	do { \
 						if (__builtin_constant_p(rw)) \
Index: vanilla-2.6.15/include/asm-i386/semaphore.h
===================================================================
--- vanilla-2.6.15.orig/include/asm-i386/semaphore.h
+++ vanilla-2.6.15/include/asm-i386/semaphore.h
@@ -99,7 +99,7 @@ static inline void down(struct semaphore
 	might_sleep();
 	__asm__ __volatile__(
 		"# atomic down operation\n\t"
-		LOCK "decl %0\n\t"     /* --sem->count */
+		LOCK_PREFIX "decl %0\n\t"     /* --sem->count */
 		"js 2f\n"
 		"1:\n"
 		LOCK_SECTION_START("")
@@ -123,7 +123,7 @@ static inline int down_interruptible(str
 	might_sleep();
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
-		LOCK "decl %1\n\t"     /* --sem->count */
+		LOCK_PREFIX "decl %1\n\t"     /* --sem->count */
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
@@ -148,7 +148,7 @@ static inline int down_trylock(struct se
 
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
-		LOCK "decl %1\n\t"     /* --sem->count */
+		LOCK_PREFIX "decl %1\n\t"     /* --sem->count */
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
@@ -173,7 +173,7 @@ static inline void up(struct semaphore *
 {
 	__asm__ __volatile__(
 		"# atomic up operation\n\t"
-		LOCK "incl %0\n\t"     /* ++sem->count */
+		LOCK_PREFIX "incl %0\n\t"     /* ++sem->count */
 		"jle 2f\n"
 		"1:\n"
 		LOCK_SECTION_START("")
Index: vanilla-2.6.15/include/asm-i386/spinlock.h
===================================================================
--- vanilla-2.6.15.orig/include/asm-i386/spinlock.h
+++ vanilla-2.6.15/include/asm-i386/spinlock.h
@@ -48,18 +48,23 @@
 	"jmp 1b\n" \
 	"4:\n\t"
 
+#define __raw_spin_lock_string_up \
+	"\n\tdecb %0"
+
 static inline void __raw_spin_lock(raw_spinlock_t *lock)
 {
-	__asm__ __volatile__(
-		__raw_spin_lock_string
-		:"=m" (lock->slock) : : "memory");
+	alternative_smp(
+		__raw_spin_lock_string,
+		__raw_spin_lock_string_up,
+		"=m" (lock->slock) : : "memory");
 }
 
 static inline void __raw_spin_lock_flags(raw_spinlock_t *lock, unsigned long flags)
 {
-	__asm__ __volatile__(
-		__raw_spin_lock_string_flags
-		:"=m" (lock->slock) : "r" (flags) : "memory");
+	alternative_smp(
+		__raw_spin_lock_string_flags,
+		__raw_spin_lock_string_up,
+		"=m" (lock->slock) : "r" (flags) : "memory");
 }
 
 static inline int __raw_spin_trylock(raw_spinlock_t *lock)
@@ -178,12 +183,12 @@ static inline int __raw_write_trylock(ra
 
 static inline void __raw_read_unlock(raw_rwlock_t *rw)
 {
-	asm volatile("lock ; incl %0" :"=m" (rw->lock) : : "memory");
+	asm volatile(LOCK_PREFIX "incl %0" :"=m" (rw->lock) : : "memory");
 }
 
 static inline void __raw_write_unlock(raw_rwlock_t *rw)
 {
-	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ", %0"
+	asm volatile(LOCK_PREFIX "addl $" RW_LOCK_BIAS_STR ", %0"
 				 : "=m" (rw->lock) : : "memory");
 }
 
Index: vanilla-2.6.15/include/asm-i386/system.h
===================================================================
--- vanilla-2.6.15.orig/include/asm-i386/system.h
+++ vanilla-2.6.15/include/asm-i386/system.h
@@ -352,67 +352,6 @@ static inline unsigned long long __cmpxc
 
 #endif
     
-#ifdef __KERNEL__
-struct alt_instr { 
-	__u8 *instr; 		/* original instruction */
-	__u8 *replacement;
-	__u8  cpuid;		/* cpuid bit set for replacement */
-	__u8  instrlen;		/* length of original instruction */
-	__u8  replacementlen; 	/* length of new instruction, <= instrlen */ 
-	__u8  pad;
-}; 
-#endif
-
-/* 
- * Alternative instructions for different CPU types or capabilities.
- * 
- * This allows to use optimized instructions even on generic binary
- * kernels.
- * 
- * length of oldinstr must be longer or equal the length of newinstr
- * It can be padded with nops as needed.
- * 
- * For non barrier like inlines please define new variants
- * without volatile and memory clobber.
- */
-#define alternative(oldinstr, newinstr, feature) 	\
-	asm volatile ("661:\n\t" oldinstr "\n662:\n" 		     \
-		      ".section .altinstructions,\"a\"\n"     	     \
-		      "  .align 4\n"				       \
-		      "  .long 661b\n"            /* label */          \
-		      "  .long 663f\n"		  /* new instruction */ 	\
-		      "  .byte %c0\n"             /* feature bit */    \
-		      "  .byte 662b-661b\n"       /* sourcelen */      \
-		      "  .byte 664f-663f\n"       /* replacementlen */ \
-		      ".previous\n"						\
-		      ".section .altinstr_replacement,\"ax\"\n"			\
-		      "663:\n\t" newinstr "\n664:\n"   /* replacement */    \
-		      ".previous" :: "i" (feature) : "memory")  
-
-/*
- * Alternative inline assembly with input.
- * 
- * Pecularities:
- * No memory clobber here. 
- * Argument numbers start with 1.
- * Best is to use constraints that are fixed size (like (%1) ... "r")
- * If you use variable sized constraints like "m" or "g" in the 
- * replacement maake sure to pad to the worst case length.
- */
-#define alternative_input(oldinstr, newinstr, feature, input...)		\
-	asm volatile ("661:\n\t" oldinstr "\n662:\n"				\
-		      ".section .altinstructions,\"a\"\n"			\
-		      "  .align 4\n"						\
-		      "  .long 661b\n"            /* label */			\
-		      "  .long 663f\n"		  /* new instruction */ 	\
-		      "  .byte %c0\n"             /* feature bit */		\
-		      "  .byte 662b-661b\n"       /* sourcelen */		\
-		      "  .byte 664f-663f\n"       /* replacementlen */ 		\
-		      ".previous\n"						\
-		      ".section .altinstr_replacement,\"ax\"\n"			\
-		      "663:\n\t" newinstr "\n664:\n"   /* replacement */ 	\
-		      ".previous" :: "i" (feature), ##input)
-
 /*
  * Force strict CPU ordering.
  * And yes, this is required on UP too when we're talking
Index: vanilla-2.6.15/arch/um/kernel/um_arch.c
===================================================================
--- vanilla-2.6.15.orig/arch/um/kernel/um_arch.c
+++ vanilla-2.6.15/arch/um/kernel/um_arch.c
@@ -477,6 +477,16 @@ void __init check_bugs(void)
 	check_devanon();
 }
 
-void apply_alternatives(void *start, void *end)
+void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
+{
+}
+
+void alternatives_smp_module_add(struct module *mod, char *name,
+				 void *locks, void *locks_end,
+				 void *text,  void *text_end)
+{
+}
+
+void alternatives_smp_module_del(struct module *mod)
 {
 }
Index: vanilla-2.6.15/include/asm-um/alternative.h
===================================================================
--- /dev/null
+++ vanilla-2.6.15/include/asm-um/alternative.h
@@ -0,0 +1,6 @@
+#ifndef __UM_ALTERNATIVE_H
+#define __UM_ALTERNATIVE_H
+
+#include "asm/arch/alternative.h"
+
+#endif
Index: vanilla-2.6.15/include/asm-i386/mutex.h
===================================================================
--- vanilla-2.6.15.orig/include/asm-i386/mutex.h
+++ vanilla-2.6.15/include/asm-i386/mutex.h
@@ -9,6 +9,8 @@
 #ifndef _ASM_MUTEX_H
 #define _ASM_MUTEX_H
 
+#include "asm/alternative.h"
+
 /**
  *  __mutex_fastpath_lock - try to take the lock by moving the count
  *                          from 1 to a 0 value
@@ -27,7 +29,7 @@ do {									\
 	typecheck_fn(fastcall void (*)(atomic_t *), fail_fn);		\
 									\
 	__asm__ __volatile__(						\
-		LOCK	"   decl (%%eax)	\n"			\
+		LOCK_PREFIX "   decl (%%eax)	\n"			\
 			"   js 2f		\n"			\
 			"1:			\n"			\
 									\
@@ -83,7 +85,7 @@ do {									\
 	typecheck_fn(fastcall void (*)(atomic_t *), fail_fn);		\
 									\
 	__asm__ __volatile__(						\
-		LOCK	"   incl (%%eax)	\n"			\
+		LOCK_PREFIX "   incl (%%eax)	\n"			\
 			"   jle 2f		\n"			\
 			"1:			\n"			\
 									\

--------------010204000904050907080308--
