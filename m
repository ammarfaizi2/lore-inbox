Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316465AbSGYVJH>; Thu, 25 Jul 2002 17:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316477AbSGYVJH>; Thu, 25 Jul 2002 17:09:07 -0400
Received: from hq.fsmlabs.com ([209.155.42.197]:6344 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S316465AbSGYVJE>;
	Thu, 25 Jul 2002 17:09:04 -0400
From: Cort Dougan <cort@fsmlabs.com>
Date: Thu, 25 Jul 2002 15:05:25 -0600
To: Andrea Arcangeli <andrea@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020725150525.Q2276@host110.fsmlabs.com>
References: <20020725110033.G2276@host110.fsmlabs.com> <20020725181126.A17859@infradead.org> <20020725112142.I2276@host110.fsmlabs.com> <20020725190445.GO1180@dualathlon.random> <20020725142716.N2276@host110.fsmlabs.com> <20020725205910.GR1180@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020725205910.GR1180@dualathlon.random>; from andrea@suse.de on Thu, Jul 25, 2002 at 10:59:10PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What I meant was - "none of your changes seem to cause problems, and I'll
absorb them and send another patch" and not "your changes don't fix any
problems".  Yes, I see that your changes address real problems.

Patch (with the indentation fixed) below.

} > None of the changes look like a problem.  I'll absorb them and send another
} 
} the lack of <= was a bug, the buffer overflows on the stack with symbols
} > 60 was a bug too even if less likely to trigger.
} 
} > patch.  One that fixes Ben's criticisms of spurious whitespace, even :)
} > 
} > Are you suggesting that it should print the start/end of the module in each
} > trace in addition to the symbol names or instead of them?
} 
} Not the end, just the start, and not in addition, but only the start
} address of each module without any symbol.
} 
} > I've found it valuable to have the EIP resolved.  Even though the symbol
} > name may not be perfect (only resolves exported names) it is valuable to
} > see that the function crashed 0x1fe bytes after a given symbol name.

That's only true for kernel names.  Function names that are not static in
modules are given - and it's been useful for quickly finding which function
in what module caused the trap.

I must misunderstand you since it seems you're suggesting that the symbol
names aren't useful.  That's the whole point of the patch - to give symbol
names :)

} valuable for what? you need the system.map or the .o disassembly of the
} module anyways to take advantage of such symbol. I don't find it useful.
} Furthmore ksymoops will prefer to work with hex numbers rather than
} doing the reverse lookup to the number and then resolving to the right
} symbol (and not only ksymoops, me too while doing by hand and that's why
} I prefer hex there)

On PPC I just tack the system.map.gz to the xmon debugger and lookup
there.  That doesn't help with module oops' since it doesn't enter the
debugger.  It's also an extra set of steps when looking at a symbol name
and the actual address is much easier when looking at a target board.

} One thing is if you have ksymall ala kdb and you can resolve to
} something where you don't need the system.map to guess what happened,
} but without the ksymall you need the system.map or vmlinux anyways.

diff -Nru a/arch/i386/kernel/traps.c b/arch/i386/kernel/traps.c
--- a/arch/i386/kernel/traps.c	Thu Jul 25 15:02:22 2002
+++ b/arch/i386/kernel/traps.c	Thu Jul 25 15:02:22 2002
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
--- a/arch/i386/mm/fault.c	Thu Jul 25 15:02:22 2002
+++ b/arch/i386/mm/fault.c	Thu Jul 25 15:02:22 2002
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
--- a/arch/ppc/kernel/process.c	Thu Jul 25 15:02:22 2002
+++ b/arch/ppc/kernel/process.c	Thu Jul 25 15:02:22 2002
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
--- a/include/linux/module.h	Thu Jul 25 15:02:22 2002
+++ b/include/linux/module.h	Thu Jul 25 15:02:22 2002
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
--- a/kernel/module.c	Thu Jul 25 15:02:22 2002
+++ b/kernel/module.c	Thu Jul 25 15:02:22 2002
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
+#define PRINT_ADDR_LENGTH 60
+void module_print_addr(char *s1, unsigned long addr, char *s2)
+{
+	unsigned long best_match = 0; /* so far */
+	char best_match_string[PRINT_ADDR_LENGTH];
+	struct module *mod;
+	struct module_symbol *sym;
+	int j;
+
+	/* user addresses - just print user and return -- Cort */
+	if ( addr < PAGE_OFFSET ) {
+		if ( s1 )
+			printk("%s", s1);
+		printk("(user)");
+		if ( s2 )
+			printk("%s", s2);
+		return;
+	}
+
+	for (mod = module_list; mod != &kernel_module; mod = mod->next) {
+		if (!mod_bound(addr, 0, mod))
+			continue;
+		for ( j = 0, sym = mod->syms; j < mod->nsyms; ++j, ++sym) {
+			/* is this a better match than what we've
+			 * found so far? -- Cort */
+			if (sym->value <= addr &&
+			    addr - sym->value < addr - best_match) {
+				best_match = sym->value;
+				/* kernelmodule.name is "" so we
+				 * have a special case -- Cort */
+				if ( mod->name[0] == 0 )
+					snprintf(best_match_string,
+						 PRINT_ADDR_LENGTH, "%s",
+						 sym->name);
+				else
+					snprintf(best_match_string,
+						 PRINT_ADDR_LENGTH, "%s:%s",
+						 sym->name, mod->name);
+			}
+		}
+	}
+
+	if ( best_match ) {
+		if ( s1 )
+			printk("%s", s1);
+		printk("(%s + 0x%lx)", best_match_string, addr - best_match);
+		if ( s2 )
+			printk("%s", s2);
+	}
+}
 
 /*
  * Called at boot time
