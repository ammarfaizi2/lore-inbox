Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315388AbSGYREI>; Thu, 25 Jul 2002 13:04:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315414AbSGYREI>; Thu, 25 Jul 2002 13:04:08 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:32448 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S315388AbSGYREH>;
	Thu, 25 Jul 2002 13:04:07 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 25 Jul 2002 11:00:33 -0600
To: linux-kernel@vger.kernel.org
Subject: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020725110033.G2276@host110.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is from the -atp (Aunt Tillie and Penelope) tree.

This patch adds a small function that looks up symbol names that correspond
to given addresses by digging through the already existent ksyms table.
It's invaluable for debugging on embedded systems - especially when testing
modules - since ksymoops is a hassle to deal with in cross-build
environments.  We already have this info in the kernel so we might as well
use it.

This patch adds use of the function for PPC and i386.

diff -Nru a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
--- a/arch/i386/kernel/traps.c	Thu Jul 25 01:11:24 2002
+++ b/arch/i386/kernel/traps.c	Thu Jul 25 01:11:24 2002
@@ -201,8 +201,11 @@
 		esp = regs->esp;
 		ss = regs->xss & 0xffff;
 	}
-	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]    %s\nEFLAGS: %08lx\n",
-		smp_processor_id(), 0xffff & regs->xcs, regs->eip, print_tainted(), regs->eflags);
+	printk("CPU:    %d\nEIP:    %04x:[<%08lx>]",
+	       smp_processor_id(), 0xffff & regs->xcs, regs->eip );
+	module_print_addr(" ", regs->eip, NULL);
+	printk(" %s\nEFLAGS: %08lx\n",
+	       print_tainted(), regs->eflags);
 	printk("eax: %08lx   ebx: %08lx   ecx: %08lx   edx: %08lx\n",
 		regs->eax, regs->ebx, regs->ecx, regs->edx);
 	printk("esi: %08lx   edi: %08lx   ebp: %08lx   esp: %08lx\n",
diff -Nru a/arch/i386/mm/fault.c b/arch/i386/mm/fault.c
--- a/arch/i386/mm/fault.c	Thu Jul 25 01:11:24 2002
+++ b/arch/i386/mm/fault.c	Thu Jul 25 01:11:24 2002
@@ -323,7 +323,9 @@
 		printk(KERN_ALERT "Unable to handle kernel paging request");
 	printk(" at virtual address %08lx\n",address);
 	printk(" printing eip:\n");
-	printk("%08lx\n", regs->eip);
+	printk("%08lx", regs->eip);
+	module_print_addr(" ",regs->eip, NULL);
+	printk("\n");
 	asm("movl %%cr3,%0":"=r" (page));
 	page = ((unsigned long *) __va(page))[address >> 22];
 	printk(KERN_ALERT "*pde = %08lx\n", page);
diff -Nru a/arch/ppc/kernel/process.c b/arch/ppc/kernel/process.c
--- a/arch/ppc/kernel/process.c	Thu Jul 25 01:11:24 2002
+++ b/arch/ppc/kernel/process.c	Thu Jul 25 01:11:24 2002
@@ -245,8 +245,11 @@
 {
 	int i;
 
-	printk("NIP: %08lX XER: %08lX LR: %08lX SP: %08lX REGS: %p TRAP: %04lx    %s\n",
-	       regs->nip, regs->xer, regs->link, regs->gpr[1], regs,regs->trap, print_tainted());
+	printk("NIP: %08lX");
+	module_print_addr(" ", regs->nip, NULL);
+	printk("\n");
+	printk("XER: %08lX LR: %08lX SP: %08lX REGS: %p TRAP: %04lx    %s\n",
+	       regs->xer, regs->link, regs->gpr[1], regs,regs->trap, print_tainted());
 	printk("MSR: %08lx EE: %01x PR: %01x FP: %01x ME: %01x IR/DR: %01x%01x\n",
 	       regs->msr, regs->msr&MSR_EE ? 1 : 0, regs->msr&MSR_PR ? 1 : 0,
 	       regs->msr & MSR_FP ? 1 : 0,regs->msr&MSR_ME ? 1 : 0,
diff -Nru a/include/linux/module.h b/include/linux/module.h
--- a/include/linux/module.h	Thu Jul 25 01:11:24 2002
+++ b/include/linux/module.h	Thu Jul 25 01:11:24 2002
@@ -411,4 +411,10 @@
 #define SET_MODULE_OWNER(some_struct) do { } while (0)
 #endif
 
+#ifdef CONFIG_MODULES
+void module_print_addr(char *, unsigned long, char *);
+#else /* CONFIG_MODULES */
+#define module_print_addr(x,y,z) do { } while (0)
+#endif /* CONFIG_MODULES */
+
 #endif /* _LINUX_MODULE_H */
diff -Nru a/kernel/module.c b/kernel/module.c
--- a/kernel/module.c	Thu Jul 25 01:11:24 2002
+++ b/kernel/module.c	Thu Jul 25 01:11:24 2002
@@ -238,6 +238,63 @@
 struct module *find_module(const char *name);
 void free_module(struct module *, int tag_freed);
 
+/*
+ * Lookup an address in all modules (including the kernel) ksyms
+ * and print any corresponding symbol name.  Useful for quick
+ * recognition of faulting addresses during panics without
+ * the need for user space tools.
+ *  -- Cort <cort@fsmlabs.com>
+ */
+void module_print_addr(char *s1, unsigned long addr, char *s2)
+{
+        unsigned long best_match = 0; /* so far */
+        char best_match_string[60] = {0, }; /* so far */
+        struct module *mod;
+        struct module_symbol *sym;
+        int j;
+
+        /* user addresses - just print user and return -- Cort */
+        if ( addr < PAGE_OFFSET )
+        {
+		if ( s1 )
+			printk("%s", s1);
+                printk("(user)");
+		if ( s2 )
+			printk("%s", s2);
+                return;
+        }
+
+        for (mod = module_list; mod; mod = mod->next)
+        {
+                for ( j = 0, sym = mod->syms; j < mod->nsyms; ++j, ++sym)
+                {
+                        /* is this a better match than what we've
+                         * found so far? -- Cort */
+                        if ( (sym->value < addr) &&
+                             ((addr - sym->value) < (addr - best_match)) )
+                        {
+                                best_match = sym->value;
+                                /* kernelmodule.name is "" so we
+                                 * have a special case -- Cort */
+                                if ( mod->name[0] == 0 )
+                                        sprintf(best_match_string, "%s",
+                                                sym->name);
+                                else
+                                        sprintf(best_match_string, "%s:%s",
+                                                sym->name, mod->name);
+                        }
+                }
+        }
+
+        if ( best_match )
+	{
+		if ( s1 )
+			printk("%s", s1);
+		printk("(%s + 0x%lx)", best_match_string, addr - best_match);
+		if ( s2 )
+			printk("%s", s2);
+	}
+}
 
 /*
  * Called at boot time


