Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbVKVRs3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbVKVRs3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 12:48:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965034AbVKVRs3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 12:48:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:27867 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965032AbVKVRs1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 12:48:27 -0500
Message-ID: <438359D7.7090308@suse.de>
Date: Tue, 22 Nov 2005 18:48:07 +0100
From: Gerd Knorr <kraxel@suse.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: [patch] SMP alternatives
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com> <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com> <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org> <4374FB89.6000304@vmware.com> <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org> <20051113074241.GA29796@redhat.com> <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org> <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de> <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de> <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de>
In-Reply-To: <437B5A83.8090808@suse.de>
Content-Type: multipart/mixed;
 boundary="------------050009050009080601050607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050009050009080601050607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Gerd Knorr wrote:
> Gerd Knorr wrote:
> 
>> i.e. something like this (as basic idea, patch is far away from doing 
>> anything useful ...)?
> 
> Adapting $subject to the actual topic, so other lkml readers can catch 
> up ;)
> 
> Ok, here new version of the SMP alternatives patch.  It features:

Now, some days hacking & debugging and kernel crashing later I have 
something more than just proof-of-concept ;)

Modules are supported now, fully modularized distro kernel works fine 
with it.  If you have a kernel with HOTPLUG_CPU compiled you can 
shutdown the second CPU of your dual-processor system via sysfs (echo 0 
 > /sys/devices/system/cpu/cpu1/online) and watch the kernel switch over 
to UP code without lock-prefixed instructions and simplified spinlocks, 
then power up the second CPU again (echo 1 > /sys/...) and watch it 
patching back in the SMP locking.

For testing & benchmarking purposes I've put also in two (temporary) 
sysrq's to switch between UP and SMP bits without booting/shutting down 
the second CPU.  That one breaks non-i386 builds which are trivially 
fixable by just dropping the drivers/char/sysrq.c changes ;)

enjoy,

   Gerd

--------------050009050009080601050607
Content-Type: text/x-patch;
 name="smp-alternatives-22.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="smp-alternatives-22.diff"

diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.14/arch/i386/kernel/Makefile work-2.6.14/arch/i386/kernel/Makefile
--- linux-2.6.14/arch/i386/kernel/Makefile	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/arch/i386/kernel/Makefile	2005-11-21 09:19:52.000000000 +0100
@@ -7,7 +7,7 @@
 obj-y	:= process.o semaphore.o signal.o entry.o traps.o irq.o vm86.o \
 		ptrace.o time.o ioport.o ldt.o setup.o i8259.o sys_i386.o \
 		pci-dma.o i386_ksyms.o i387.o dmi_scan.o bootflag.o \
-		doublefault.o quirks.o i8237.o
+		doublefault.o quirks.o i8237.o alternative.o
 
 obj-y				+= cpu/
 obj-y				+= timers/
diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.14/arch/i386/kernel/alternative.c work-2.6.14/arch/i386/kernel/alternative.c
--- linux-2.6.14/arch/i386/kernel/alternative.c	1970-01-01 01:00:00.000000000 +0100
+++ work-2.6.14/arch/i386/kernel/alternative.c	2005-11-22 16:58:59.000000000 +0100
@@ -0,0 +1,285 @@
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
+/* Replace instructions with better alternatives for this CPU type.
+
+   This runs before SMP is initialized to avoid SMP problems with
+   self modifying code. This implies that assymetric systems where
+   APs have less capabilities than the boot processor are not handled. 
+   Tough. Make sure you disable such features by hand. */ 
+void apply_alternatives(struct alt_instr *start, struct alt_instr *end,
+			__u8 *tstart, __u8 *tend)
+{ 
+        unsigned char **noptable = intel_nops;
+	struct alt_instr *a; 
+	int diff, i, k;
+
+	DPRINTK("%s: alts %p-%p, text %p-%p\n", __FUNCTION__,
+		start, end, tstart, tend);
+	for (i = 0; noptypes[i].cpuid >= 0; i++) { 
+		if (boot_cpu_has(noptypes[i].cpuid)) { 
+			noptable = noptypes[i].noptable;
+			break;
+		}
+	} 
+	for (a = start; a < end; a++) { 
+		BUG_ON(a->replacementlen > a->instrlen); 
+		if (!boot_cpu_has(a->cpuid))
+			continue;
+		if (tstart && a->instr < tstart)
+			continue;
+		if (tend && a->instr > tend)
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
+
+	/* Paranoia */
+	asm volatile ("jmp 1f\n1:");
+	mb();
+} 
+
+struct smp_alt_module {
+	/* what is this ??? */
+	struct module    *mod;
+	char             *name;
+
+	/* our SMP alternatives table */
+	struct alt_instr *astart;
+	struct alt_instr *aend;
+
+	/* .text segment, needed to avoid patching init code ;) */
+	__u8             *tstart;
+	__u8             *tend;
+
+	struct list_head next;
+};
+static LIST_HEAD(smp_alt_modules);
+static DEFINE_SPINLOCK(smp_alt);
+static enum {
+	ALT_UP, ALT_SMP
+} smp_alt_state = ALT_SMP;
+
+static void save_alternatives_smp(struct smp_alt_module *mod)
+{
+	struct alt_instr *a;
+
+	DPRINTK("%s: alts %p-%p, text %p-%p, name %s\n", __FUNCTION__,
+		mod->astart, mod->aend, mod->tstart, mod->tend, mod->name);
+	for (a = mod->astart; a < mod->aend; a++) {
+		if (a->instr < mod->tstart)
+			continue;
+		if (a->instr > mod->tend)
+			continue;
+		memcpy(a->replacement + a->replacementlen,
+		       a->instr,
+		       a->instrlen);
+	}
+}
+
+static void apply_alternatives_smp(struct smp_alt_module *mod)
+{
+	struct alt_instr *a;
+
+	DPRINTK("%s: alts %p-%p, text %p-%p, name %s\n", __FUNCTION__,
+		mod->astart, mod->aend, mod->tstart, mod->tend, mod->name);
+	for (a = mod->astart; a < mod->aend; a++) {
+		if (a->instr < mod->tstart)
+			continue;
+		if (a->instr > mod->tend)
+			continue;
+		memcpy(a->instr,
+		       a->replacement + a->replacementlen,
+		       a->instrlen);
+	}
+
+	/* Paranoia */
+	asm volatile ("jmp 1f\n1:");
+	mb();
+}
+
+extern struct alt_instr __alt_instructions[], __alt_instructions_end[];
+extern struct alt_instr __smp_alt_instructions[], __smp_alt_instructions_end[];
+extern __u8 _text[], _etext[];
+
+void alternatives_smp_module_add(struct module *mod, char *name,
+				 void *astart, void *aend,
+				 void *tstart, void *tend)
+{
+	struct smp_alt_module *smp;
+	unsigned long flags;
+
+	smp = kmalloc(sizeof(*smp), GFP_KERNEL);
+	if (NULL == smp)
+		return; /* we'll run the (safe but slow) SMP code then ... */
+
+	memset(smp,0,sizeof(*smp));
+	smp->mod    = mod;
+	smp->name   = name;
+	smp->astart = astart;
+	smp->aend   = aend;
+	smp->tstart = tstart;
+	smp->tend   = tend;
+	DPRINTK("%s: alts %p-%p, text %p-%p, name %s\n", __FUNCTION__,
+		smp->astart, smp->aend, smp->tstart, smp->tend, smp->name);
+
+	spin_lock_irqsave(&smp_alt, flags);
+	list_add_tail(&smp->next, &smp_alt_modules);
+	save_alternatives_smp(smp);
+	if (ALT_UP == smp_alt_state)
+		apply_alternatives(smp->astart, smp->aend,
+				   smp->tstart, smp->tend);
+	spin_unlock_irqrestore(&smp_alt, flags);
+
+}
+
+void alternatives_smp_module_del(struct module *mod)
+{
+	struct smp_alt_module *item;
+	unsigned long flags;
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
+void switch_alternatives_up(void) 
+{
+	struct smp_alt_module *mod;
+	unsigned long flags;
+
+	if (num_online_cpus() > 1) {
+		/* shouldn't happen in theory ... */
+		printk("%s: Uh, oh, %d cpus active, NOT patching ...\n",
+		       __FUNCTION__, num_online_cpus());
+		dump_stack();
+		return;
+	}
+
+	spin_lock_irqsave(&smp_alt, flags);
+
+	if (ALT_UP == smp_alt_state)
+		goto out;
+	smp_alt_state = ALT_UP;
+	printk(KERN_INFO "alternatives: switching to UP code\n");
+
+	set_bit(X86_FEATURE_UP, boot_cpu_data.x86_capability);
+	list_for_each_entry(mod, &smp_alt_modules, next)
+		apply_alternatives(mod->astart, mod->aend,
+				   mod->tstart, mod->tend);
+
+ out:
+	spin_unlock_irqrestore(&smp_alt, flags);
+} 
+
+void switch_alternatives_smp(void) 
+{ 
+	struct smp_alt_module *mod;
+	unsigned long flags;
+
+	spin_lock_irqsave(&smp_alt, flags);
+
+	if (ALT_SMP == smp_alt_state)
+		goto out;
+	smp_alt_state = ALT_SMP;
+	printk(KERN_INFO "alternatives: switching to SMP code\n");
+
+	clear_bit(X86_FEATURE_UP, boot_cpu_data.x86_capability);
+	list_for_each_entry(mod, &smp_alt_modules, next)
+		apply_alternatives_smp(mod);
+
+ out:
+	spin_unlock_irqrestore(&smp_alt, flags);
+} 
+
+void __init alternative_instructions(void)
+{
+	apply_alternatives(__alt_instructions, __alt_instructions_end,
+			   NULL, NULL);
+	alternatives_smp_module_add(NULL, "core kernel",
+				    __smp_alt_instructions,
+				    __smp_alt_instructions_end,
+				    _text, _etext);
+	switch_alternatives_up();
+}
+
diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.14/arch/i386/kernel/module.c work-2.6.14/arch/i386/kernel/module.c
--- linux-2.6.14/arch/i386/kernel/module.c	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/arch/i386/kernel/module.c	2005-11-22 15:59:19.000000000 +0100
@@ -104,26 +104,39 @@
 	return -ENOEXEC;
 }
 
-extern void apply_alternatives(void *start, void *end); 
-
 int module_finalize(const Elf_Ehdr *hdr,
 		    const Elf_Shdr *sechdrs,
 		    struct module *me)
 {
-	const Elf_Shdr *s;
+	const Elf_Shdr *s, *text = NULL, *alt = NULL, *smpalt = NULL;
 	char *secstrings = (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
 
-	/* look for .altinstructions to patch */ 
 	for (s = sechdrs; s < sechdrs + hdr->e_shnum; s++) { 
-		void *seg; 		
-		if (strcmp(".altinstructions", secstrings + s->sh_name))
-			continue;
-		seg = (void *)s->sh_addr; 
-		apply_alternatives(seg, seg + s->sh_size); 
-	} 	
+		if (0 == strcmp(".text", secstrings + s->sh_name))
+			text = s;
+		if (0 == strcmp(".altinstructions", secstrings + s->sh_name))
+			alt = s;
+		if (0 == strcmp(".smp_altinstructions", secstrings + s->sh_name))
+			smpalt = s;
+	}
+
+	if (alt) {
+		/* patch .altinstructions */ 
+		void *aseg = (void *)alt->sh_addr;
+		apply_alternatives(aseg, aseg + alt->sh_size, NULL, NULL);
+	}
+	if (smpalt && text) {
+		void *aseg = (void *)smpalt->sh_addr;
+		void *tseg = (void *)text->sh_addr;
+		alternatives_smp_module_add(me, me->name,
+					    aseg, aseg + smpalt->sh_size,
+					    tseg, tseg + text->sh_size);
+	}
+
 	return 0;
 }
 
 void module_arch_cleanup(struct module *mod)
 {
+	alternatives_smp_module_del(mod);
 }
diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.14/arch/i386/kernel/semaphore.c work-2.6.14/arch/i386/kernel/semaphore.c
--- linux-2.6.14/arch/i386/kernel/semaphore.c	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/arch/i386/kernel/semaphore.c	2005-11-17 11:17:58.000000000 +0100
@@ -110,11 +110,11 @@
 ".align	4\n"
 ".globl	__write_lock_failed\n"
 "__write_lock_failed:\n\t"
-	LOCK "addl	$" RW_LOCK_BIAS_STR ",(%eax)\n"
+	LOCK_PRE "addl	$" RW_LOCK_BIAS_STR ",(%eax)" LOCK_POST "\n"
 "1:	rep; nop\n\t"
 	"cmpl	$" RW_LOCK_BIAS_STR ",(%eax)\n\t"
 	"jne	1b\n\t"
-	LOCK "subl	$" RW_LOCK_BIAS_STR ",(%eax)\n\t"
+	LOCK_PRE "subl	$" RW_LOCK_BIAS_STR ",(%eax)" LOCK_POST "\n\t"
 	"jnz	__write_lock_failed\n\t"
 	"ret"
 );
@@ -124,11 +124,11 @@
 ".align	4\n"
 ".globl	__read_lock_failed\n"
 "__read_lock_failed:\n\t"
-	LOCK "incl	(%eax)\n"
+	LOCK_PRE "incl	(%eax)" LOCK_POST "\n"
 "1:	rep; nop\n\t"
 	"cmpl	$1,(%eax)\n\t"
 	"js	1b\n\t"
-	LOCK "decl	(%eax)\n\t"
+	LOCK_PRE "decl	(%eax)" LOCK_POST "\n\t"
 	"js	__read_lock_failed\n\t"
 	"ret"
 );
diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.14/arch/i386/kernel/setup.c work-2.6.14/arch/i386/kernel/setup.c
--- linux-2.6.14/arch/i386/kernel/setup.c	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/arch/i386/kernel/setup.c	2005-11-21 09:10:40.000000000 +0100
@@ -1361,101 +1361,6 @@
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
diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.14/arch/i386/kernel/smpboot.c work-2.6.14/arch/i386/kernel/smpboot.c
--- linux-2.6.14/arch/i386/kernel/smpboot.c	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/arch/i386/kernel/smpboot.c	2005-11-18 14:56:37.000000000 +0100
@@ -874,6 +874,7 @@
 	unsigned short nmi_high = 0, nmi_low = 0;
 
 	++cpucount;
+	switch_alternatives_smp();
 
 	/*
 	 * We can't use kernel_thread since we must avoid to
@@ -1315,6 +1316,9 @@
 	fixup_irqs(map);
 	/* It's now safe to remove this processor from the online map */
 	cpu_clear(cpu, cpu_online_map);
+
+	if (1 == num_online_cpus())
+		switch_alternatives_up();
 	return 0;
 }
 
diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.14/arch/i386/kernel/vmlinux.lds.S work-2.6.14/arch/i386/kernel/vmlinux.lds.S
--- linux-2.6.14/arch/i386/kernel/vmlinux.lds.S	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/arch/i386/kernel/vmlinux.lds.S	2005-11-16 09:50:35.000000000 +0100
@@ -68,6 +68,16 @@
 	*(.data.init_task)
   }
 
+  . = ALIGN(4);
+  __smp_alt_instructions = .;
+  .smp_altinstructions : AT(ADDR(.smp_altinstructions) - LOAD_OFFSET) {
+	*(.smp_altinstructions)
+  }
+  __smp_alt_instructions_end = .; 
+  .smp_altinstr_replacement : AT(ADDR(.smp_altinstr_replacement) - LOAD_OFFSET) {
+	*(.smp_altinstr_replacement)
+  }
+
   /* will be freed after init */
   . = ALIGN(4096);		/* Init code and data */
   __init_begin = .;
diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.14/drivers/char/sysrq.c work-2.6.14/drivers/char/sysrq.c
--- linux-2.6.14/drivers/char/sysrq.c	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/drivers/char/sysrq.c	2005-11-21 09:26:30.000000000 +0100
@@ -271,6 +271,34 @@
 	.enable_mask	= SYSRQ_ENABLE_RTNICE,
 };
 
+#ifdef CONFIG_SMP
+/* handy for testing & benchmarking, probably temporary though.
+ *                                       -- kraxel */
+static void sysrq_handle_up(int key, struct pt_regs *pt_regs,
+			    struct tty_struct *tty)
+{
+	switch_alternatives_up();
+}
+static struct sysrq_key_op sysrq_up_op = {
+	.handler	= sysrq_handle_up,
+	.help_msg	= "UP(x)",
+	.action_msg	= "switch smp alternatives to UP",
+	.enable_mask	= SYSRQ_ENABLE_LOG,
+};
+
+static void sysrq_handle_smp(int key, struct pt_regs *pt_regs,
+			    struct tty_struct *tty)
+{
+	switch_alternatives_smp();
+}
+static struct sysrq_key_op sysrq_smp_op = {
+	.handler	= sysrq_handle_smp,
+	.help_msg	= "SMP(y)",
+	.action_msg	= "switch smp alternatives to SMP",
+	.enable_mask	= SYSRQ_ENABLE_LOG,
+};
+#endif
+
 /* Key Operations table and lock */
 static DEFINE_SPINLOCK(sysrq_key_table_lock);
 #define SYSRQ_KEY_TABLE_LENGTH 36
@@ -323,8 +351,13 @@
 /* u */	&sysrq_mountro_op,
 /* v */	NULL, /* May be assigned at init time by SMP VOYAGER */
 /* w */	NULL,
+#ifdef CONFIG_SMP
+/* x */	&sysrq_up_op,
+/* y */	&sysrq_smp_op,
+#else
 /* x */	NULL,
 /* y */	NULL,
+#endif
 /* z */	NULL
 };
 
diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.14/include/asm-i386/alternative.h work-2.6.14/include/asm-i386/alternative.h
--- linux-2.6.14/include/asm-i386/alternative.h	1970-01-01 01:00:00.000000000 +0100
+++ work-2.6.14/include/asm-i386/alternative.h	2005-11-22 15:30:36.000000000 +0100
@@ -0,0 +1,150 @@
+#ifndef _I386_ALTERNATIVE_H
+#define _I386_ALTERNATIVE_H
+
+#ifdef __KERNEL__
+
+struct alt_instr { 
+	__u8 *instr; 		/* original instruction */
+	__u8 *replacement;
+	__u8  cpuid;		/* cpuid bit set for replacement */
+	__u8  instrlen;		/* length of original instruction */
+	__u8  replacementlen; 	/* length of new instruction, <= instrlen */ 
+	__u8  pad;
+}; 
+
+extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end,
+			       __u8 *tstart, __u8 *tend);
+
+struct module;
+extern void alternatives_smp_module_add(struct module *mod, char *name,
+					void *astart, void *aend,
+					void *tstart, void *tend);
+extern void alternatives_smp_module_del(struct module *mod);
+
+extern void switch_alternatives_up(void);
+extern void switch_alternatives_smp(void);
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
+ * alternative_smp_lock() just puts an lock in front of the
+ * instruction which will be nop'ed out for UP.
+ *
+ * The LOCK_PRE and LOCK_POST macros can be placed around the
+ * instruction to be locked in places where the simple
+ * alternative_smp_lock() doesn't work (inline asm also using section
+ * tricks, lock instruction in the middle of a longer sequence,
+ * whatever else ... )
+ *
+ * SMP alternatives use the same data structures as the other
+ * alternatives and the X86_FEATURE_UP flag to indicate the case of a
+ * UP system running a SMP kernel.  The existing apply_alternatives()
+ * works fine for patching a SMP kernel for UP.
+ * 
+ * The SMP alternative tables are kept after boot and contain both UP
+ * and SMP versions of the instructions to allow switching back to SMP
+ * at runtime, when hotplugging in a new CPU, which is especially
+ * useful in virtualized environments.
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
+#define LOCK_PRE \
+	       	"661:\n\tlock; "
+#define LOCK_POST \
+		"\n" 		     \
+		".section .smp_altinstructions,\"a\"\n"          \
+		"  .align 4\n"				       \
+		"  .long 661b\n"            /* label */          \
+		"  .long 663f\n"	    /* new instruction */ 	\
+		"  .byte 0x68\n"            /* X86_FEATURE_UP */    \
+		"  .byte 1\n"               /* sourcelen */      \
+		"  .byte 0\n"               /* replacementlen */ \
+		".previous\n"						\
+		".section .smp_altinstr_replacement,\"awx\"\n"    		\
+		"663:\n"                    /* replacement */    \
+		"664:\n\tlock\n"            /* space for original */ \
+		".previous\n"
+
+#define alternative_smp_lock(lockinstr, args...) 	\
+	asm volatile (LOCK_PRE lockinstr LOCK_POST : args)
+
+#else /* ! CONFIG_SMP */
+#define alternative_smp(smpinstr, upinstr, args...) \
+	asm volatile (upinstr : args)
+#define alternative_smp_lock(lockinstr, args...) \
+	asm volatile (lockinstr : args)
+#define LOCK_PRE    ""
+#define LOCK_POST   ""
+#endif
+
+#endif /* _I386_ALTERNATIVE_H */
diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.14/include/asm-i386/atomic.h work-2.6.14/include/asm-i386/atomic.h
--- linux-2.6.14/include/asm-i386/atomic.h	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/include/asm-i386/atomic.h	2005-11-16 18:18:42.000000000 +0100
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
@@ -51,9 +45,9 @@
  */
 static __inline__ void atomic_add(int i, atomic_t *v)
 {
-	__asm__ __volatile__(
-		LOCK "addl %1,%0"
-		:"=m" (v->counter)
+	alternative_smp_lock(
+		"addl %1,%0",
+		"=m" (v->counter)
 		:"ir" (i), "m" (v->counter));
 }
 
@@ -66,9 +60,9 @@
  */
 static __inline__ void atomic_sub(int i, atomic_t *v)
 {
-	__asm__ __volatile__(
-		LOCK "subl %1,%0"
-		:"=m" (v->counter)
+	alternative_smp_lock(
+		"subl %1,%0",
+		"=m" (v->counter)
 		:"ir" (i), "m" (v->counter));
 }
 
@@ -85,9 +79,9 @@
 {
 	unsigned char c;
 
-	__asm__ __volatile__(
-		LOCK "subl %2,%0; sete %1"
-		:"=m" (v->counter), "=qm" (c)
+	alternative_smp_lock(
+		"subl %2,%0; sete %1",
+		"=m" (v->counter), "=qm" (c)
 		:"ir" (i), "m" (v->counter) : "memory");
 	return c;
 }
@@ -100,9 +94,9 @@
  */ 
 static __inline__ void atomic_inc(atomic_t *v)
 {
-	__asm__ __volatile__(
-		LOCK "incl %0"
-		:"=m" (v->counter)
+	alternative_smp_lock(
+		"incl %0",
+		"=m" (v->counter)
 		:"m" (v->counter));
 }
 
@@ -114,9 +108,9 @@
  */ 
 static __inline__ void atomic_dec(atomic_t *v)
 {
-	__asm__ __volatile__(
-		LOCK "decl %0"
-		:"=m" (v->counter)
+	alternative_smp_lock(
+		"decl %0",
+		"=m" (v->counter)
 		:"m" (v->counter));
 }
 
@@ -132,9 +126,9 @@
 {
 	unsigned char c;
 
-	__asm__ __volatile__(
-		LOCK "decl %0; sete %1"
-		:"=m" (v->counter), "=qm" (c)
+	alternative_smp_lock(
+		"decl %0; sete %1",
+		"=m" (v->counter), "=qm" (c)
 		:"m" (v->counter) : "memory");
 	return c != 0;
 }
@@ -151,9 +145,9 @@
 {
 	unsigned char c;
 
-	__asm__ __volatile__(
-		LOCK "incl %0; sete %1"
-		:"=m" (v->counter), "=qm" (c)
+	alternative_smp_lock(
+		"incl %0; sete %1",
+		"=m" (v->counter), "=qm" (c)
 		:"m" (v->counter) : "memory");
 	return c != 0;
 }
@@ -171,9 +165,9 @@
 {
 	unsigned char c;
 
-	__asm__ __volatile__(
-		LOCK "addl %2,%0; sets %1"
-		:"=m" (v->counter), "=qm" (c)
+	alternative_smp_lock(
+		"addl %2,%0; sets %1",
+		"=m" (v->counter), "=qm" (c)
 		:"ir" (i), "m" (v->counter) : "memory");
 	return c;
 }
@@ -194,9 +188,9 @@
 #endif
 	/* Modern 486+ processor */
 	__i = i;
-	__asm__ __volatile__(
-		LOCK "xaddl %0, %1;"
-		:"=r"(i)
+	alternative_smp_lock(
+		"xaddl %0, %1;",
+		"=r"(i)
 		:"m"(v->counter), "0"(i));
 	return i + __i;
 
@@ -220,12 +214,12 @@
 
 /* These are x86-specific, used by some header files */
 #define atomic_clear_mask(mask, addr) \
-__asm__ __volatile__(LOCK "andl %0,%1" \
-: : "r" (~(mask)),"m" (*addr) : "memory")
+alternative_smp_lock("andl %0,%1", \
+: "r" (~(mask)),"m" (*addr) : "memory")
 
 #define atomic_set_mask(mask, addr) \
-__asm__ __volatile__(LOCK "orl %0,%1" \
-: : "r" (mask),"m" (*(addr)) : "memory")
+alternative_smp_lock("orl %0,%1", \
+: "r" (mask),"m" (*(addr)) : "memory")
 
 /* Atomic operations are already serializing on x86 */
 #define smp_mb__before_atomic_dec()	barrier()
diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.14/include/asm-i386/bitops.h work-2.6.14/include/asm-i386/bitops.h
--- linux-2.6.14/include/asm-i386/bitops.h	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/include/asm-i386/bitops.h	2005-11-17 09:55:40.000000000 +0100
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
@@ -41,9 +36,9 @@
  */
 static inline void set_bit(int nr, volatile unsigned long * addr)
 {
-	__asm__ __volatile__( LOCK_PREFIX
-		"btsl %1,%0"
-		:"=m" (ADDR)
+	alternative_smp_lock(
+		"btsl %1,%0",
+		"=m" (ADDR)
 		:"Ir" (nr));
 }
 
@@ -76,9 +71,9 @@
  */
 static inline void clear_bit(int nr, volatile unsigned long * addr)
 {
-	__asm__ __volatile__( LOCK_PREFIX
-		"btrl %1,%0"
-		:"=m" (ADDR)
+	alternative_smp_lock(
+		"btrl %1,%0",
+		"=m" (ADDR)
 		:"Ir" (nr));
 }
 
@@ -121,9 +116,9 @@
  */
 static inline void change_bit(int nr, volatile unsigned long * addr)
 {
-	__asm__ __volatile__( LOCK_PREFIX
-		"btcl %1,%0"
-		:"=m" (ADDR)
+	alternative_smp_lock(
+		"btcl %1,%0",
+		"=m" (ADDR)
 		:"Ir" (nr));
 }
 
@@ -140,9 +135,9 @@
 {
 	int oldbit;
 
-	__asm__ __volatile__( LOCK_PREFIX
-		"btsl %2,%1\n\tsbbl %0,%0"
-		:"=r" (oldbit),"=m" (ADDR)
+	alternative_smp_lock(
+		"btsl %2,%1\n\tsbbl %0,%0",
+		"=r" (oldbit),"=m" (ADDR)
 		:"Ir" (nr) : "memory");
 	return oldbit;
 }
@@ -180,9 +175,9 @@
 {
 	int oldbit;
 
-	__asm__ __volatile__( LOCK_PREFIX
-		"btrl %2,%1\n\tsbbl %0,%0"
-		:"=r" (oldbit),"=m" (ADDR)
+	alternative_smp_lock(
+		"btrl %2,%1\n\tsbbl %0,%0",
+		"=r" (oldbit),"=m" (ADDR)
 		:"Ir" (nr) : "memory");
 	return oldbit;
 }
@@ -231,9 +226,9 @@
 {
 	int oldbit;
 
-	__asm__ __volatile__( LOCK_PREFIX
-		"btcl %2,%1\n\tsbbl %0,%0"
-		:"=r" (oldbit),"=m" (ADDR)
+	alternative_smp_lock(
+		"btcl %2,%1\n\tsbbl %0,%0",
+		"=r" (oldbit),"=m" (ADDR)
 		:"Ir" (nr) : "memory");
 	return oldbit;
 }
diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.14/include/asm-i386/cpufeature.h work-2.6.14/include/asm-i386/cpufeature.h
--- linux-2.6.14/include/asm-i386/cpufeature.h	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/include/asm-i386/cpufeature.h	2005-11-16 09:43:47.000000000 +0100
@@ -70,6 +70,8 @@
 #define X86_FEATURE_P3		(3*32+ 6) /* P3 */
 #define X86_FEATURE_P4		(3*32+ 7) /* P4 */
 
+#define X86_FEATURE_UP		(3*32+ 8) /* smp kernel running on up */
+
 /* Intel-defined CPU features, CPUID level 0x00000001 (ecx), word 4 */
 #define X86_FEATURE_XMM3	(4*32+ 0) /* Streaming SIMD Extensions-3 */
 #define X86_FEATURE_MWAIT	(4*32+ 3) /* Monitor/Mwait support */
diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.14/include/asm-i386/futex.h work-2.6.14/include/asm-i386/futex.h
--- linux-2.6.14/include/asm-i386/futex.h	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/include/asm-i386/futex.h	2005-11-17 11:19:13.000000000 +0100
@@ -28,7 +28,7 @@
 "1:	movl	%2, %0\n\
 	movl	%0, %3\n"					\
 	insn "\n"						\
-"2:	" LOCK_PREFIX "cmpxchgl %3, %2\n\
+"2:	" LOCK_PRE "cmpxchgl %3, %2" LOCK_POST "\n\
 	jnz	1b\n\
 3:	.section .fixup,\"ax\"\n\
 4:	mov	%5, %1\n\
@@ -68,7 +68,7 @@
 #endif
 		switch (op) {
 		case FUTEX_OP_ADD:
-			__futex_atomic_op1(LOCK_PREFIX "xaddl %0, %2", ret,
+			__futex_atomic_op1(LOCK_PRE "xaddl %0, %2" LOCK_POST, ret,
 					   oldval, uaddr, oparg);
 			break;
 		case FUTEX_OP_OR:
diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.14/include/asm-i386/rwlock.h work-2.6.14/include/asm-i386/rwlock.h
--- linux-2.6.14/include/asm-i386/rwlock.h	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/include/asm-i386/rwlock.h	2005-11-17 09:44:53.000000000 +0100
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
diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.14/include/asm-i386/rwsem.h work-2.6.14/include/asm-i386/rwsem.h
--- linux-2.6.14/include/asm-i386/rwsem.h	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/include/asm-i386/rwsem.h	2005-11-17 11:14:45.000000000 +0100
@@ -99,7 +99,7 @@
 {
 	__asm__ __volatile__(
 		"# beginning down_read\n\t"
-LOCK_PREFIX	"  incl      (%%eax)\n\t" /* adds 0x00000001, returns the old value */
+LOCK_PRE       	"  incl      (%%eax)" LOCK_POST "\n\t" /* adds 0x00000001, returns the old value */
 		"  js        2f\n\t" /* jump if we weren't granted the lock */
 		"1:\n\t"
 		LOCK_SECTION_START("")
@@ -130,7 +130,7 @@
 		"  movl	     %1,%2\n\t"
 		"  addl      %3,%2\n\t"
 		"  jle	     2f\n\t"
-LOCK_PREFIX	"  cmpxchgl  %2,%0\n\t"
+LOCK_PRE       	"  cmpxchgl  %2,%0" LOCK_POST "\n\t"
 		"  jnz	     1b\n\t"
 		"2:\n\t"
 		"# ending __down_read_trylock\n\t"
@@ -150,7 +150,7 @@
 	tmp = RWSEM_ACTIVE_WRITE_BIAS;
 	__asm__ __volatile__(
 		"# beginning down_write\n\t"
-LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtract 0x0000ffff, returns the old value */
+LOCK_PRE       	"  xadd      %%edx,(%%eax)" LOCK_POST "\n\t" /* subtract 0x0000ffff, returns the old value */
 		"  testl     %%edx,%%edx\n\t" /* was the count 0 before? */
 		"  jnz       2f\n\t" /* jump if we weren't granted the lock */
 		"1:\n\t"
@@ -188,7 +188,7 @@
 	__s32 tmp = -RWSEM_ACTIVE_READ_BIAS;
 	__asm__ __volatile__(
 		"# beginning __up_read\n\t"
-LOCK_PREFIX	"  xadd      %%edx,(%%eax)\n\t" /* subtracts 1, returns the old value */
+LOCK_PRE	"  xadd      %%edx,(%%eax)" LOCK_POST "\n\t" /* subtracts 1, returns the old value */
 		"  js        2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
 		LOCK_SECTION_START("")
@@ -214,7 +214,7 @@
 	__asm__ __volatile__(
 		"# beginning __up_write\n\t"
 		"  movl      %2,%%edx\n\t"
-LOCK_PREFIX	"  xaddl     %%edx,(%%eax)\n\t" /* tries to transition 0xffff0001 -> 0x00000000 */
+LOCK_PRE       	"  xaddl     %%edx,(%%eax)" LOCK_POST "\n\t" /* tries to transition 0xffff0001 -> 0x00000000 */
 		"  jnz       2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
 		LOCK_SECTION_START("")
@@ -239,7 +239,7 @@
 {
 	__asm__ __volatile__(
 		"# beginning __downgrade_write\n\t"
-LOCK_PREFIX	"  addl      %2,(%%eax)\n\t" /* transitions 0xZZZZ0001 -> 0xYYYY0001 */
+LOCK_PRE	"  addl      %2,(%%eax)" LOCK_POST "\n\t" /* transitions 0xZZZZ0001 -> 0xYYYY0001 */
 		"  js        2f\n\t" /* jump if the lock is being waited upon */
 		"1:\n\t"
 		LOCK_SECTION_START("")
@@ -262,9 +262,9 @@
  */
 static inline void rwsem_atomic_add(int delta, struct rw_semaphore *sem)
 {
-	__asm__ __volatile__(
-LOCK_PREFIX	"addl %1,%0"
-		: "=m"(sem->count)
+	alternative_smp_lock(
+		"addl %1,%0",
+		"=m"(sem->count)
 		: "ir"(delta), "m"(sem->count));
 }
 
@@ -275,9 +275,9 @@
 {
 	int tmp = delta;
 
-	__asm__ __volatile__(
-LOCK_PREFIX	"xadd %0,(%2)"
-		: "+r"(tmp), "=m"(sem->count)
+	alternative_smp_lock(
+		"xadd %0,(%2)",
+		"+r"(tmp), "=m"(sem->count)
 		: "r"(sem), "m"(sem->count)
 		: "memory");
 
diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.14/include/asm-i386/semaphore.h work-2.6.14/include/asm-i386/semaphore.h
--- linux-2.6.14/include/asm-i386/semaphore.h	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/include/asm-i386/semaphore.h	2005-11-17 11:15:49.000000000 +0100
@@ -102,7 +102,7 @@
 	might_sleep();
 	__asm__ __volatile__(
 		"# atomic down operation\n\t"
-		LOCK "decl %0\n\t"     /* --sem->count */
+		LOCK_PRE "decl %0" LOCK_POST "\n\t"     /* --sem->count */
 		"js 2f\n"
 		"1:\n"
 		LOCK_SECTION_START("")
@@ -126,7 +126,7 @@
 	might_sleep();
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
-		LOCK "decl %1\n\t"     /* --sem->count */
+		LOCK_PRE "decl %1" LOCK_POST "\n\t"     /* --sem->count */
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
@@ -151,7 +151,7 @@
 
 	__asm__ __volatile__(
 		"# atomic interruptible down operation\n\t"
-		LOCK "decl %1\n\t"     /* --sem->count */
+		LOCK_PRE "decl %1" LOCK_POST "\n\t"     /* --sem->count */
 		"js 2f\n\t"
 		"xorl %0,%0\n"
 		"1:\n"
@@ -176,7 +176,7 @@
 {
 	__asm__ __volatile__(
 		"# atomic up operation\n\t"
-		LOCK "incl %0\n\t"     /* ++sem->count */
+		LOCK_PRE "incl %0" LOCK_POST "\n\t"     /* ++sem->count */
 		"jle 2f\n"
 		"1:\n"
 		LOCK_SECTION_START("")
diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.14/include/asm-i386/spinlock.h work-2.6.14/include/asm-i386/spinlock.h
--- linux-2.6.14/include/asm-i386/spinlock.h	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/include/asm-i386/spinlock.h	2005-11-16 16:22:12.000000000 +0100
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
@@ -178,13 +183,16 @@
 
 static inline void __raw_read_unlock(raw_rwlock_t *rw)
 {
-	asm volatile("lock ; incl %0" :"=m" (rw->lock) : : "memory");
+	alternative_smp_lock(
+		"incl %0",
+		"=m" (rw->lock) : : "memory");
 }
 
 static inline void __raw_write_unlock(raw_rwlock_t *rw)
 {
-	asm volatile("lock ; addl $" RW_LOCK_BIAS_STR ", %0"
-				 : "=m" (rw->lock) : : "memory");
+	alternative_smp_lock(
+		"addl $" RW_LOCK_BIAS_STR ", %0",
+		"=m" (rw->lock) : : "memory");
 }
 
 #endif /* __ASM_SPINLOCK_H */
diff -urN -x 'build-*' -x '*~' -x Make -x scripts linux-2.6.14/include/asm-i386/system.h work-2.6.14/include/asm-i386/system.h
--- linux-2.6.14/include/asm-i386/system.h	2005-10-28 02:02:08.000000000 +0200
+++ work-2.6.14/include/asm-i386/system.h	2005-11-17 09:28:29.000000000 +0100
@@ -267,20 +267,20 @@
 	unsigned long prev;
 	switch (size) {
 	case 1:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgb %b1,%2"
-				     : "=a"(prev)
+		alternative_smp_lock("cmpxchgb %b1,%2",
+				     "=a"(prev)
 				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
 				     : "memory");
 		return prev;
 	case 2:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgw %w1,%2"
-				     : "=a"(prev)
+		alternative_smp_lock("cmpxchgw %w1,%2",
+				     "=a"(prev)
 				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
 				     : "memory");
 		return prev;
 	case 4:
-		__asm__ __volatile__(LOCK_PREFIX "cmpxchgl %1,%2"
-				     : "=a"(prev)
+		alternative_smp_lock("cmpxchgl %1,%2",
+				     "=a"(prev)
 				     : "q"(new), "m"(*__xg(ptr)), "0"(old)
 				     : "memory");
 		return prev;
@@ -292,67 +292,6 @@
 	((__typeof__(*(ptr)))__cmpxchg((ptr),(unsigned long)(o),\
 					(unsigned long)(n),sizeof(*(ptr))))
     
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

--------------050009050009080601050607--
