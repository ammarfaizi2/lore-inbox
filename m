Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267023AbSLXBFc>; Mon, 23 Dec 2002 20:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267024AbSLXBFc>; Mon, 23 Dec 2002 20:05:32 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:58848 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267023AbSLXBF3>; Mon, 23 Dec 2002 20:05:29 -0500
Date: Tue, 24 Dec 2002 02:12:27 +0100
From: Andi Kleen <ak@muc.de>
To: kai@tp1.ruhr-uni-bochum.de, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Stem compression for kallsyms
Message-ID: <20021224011227.GA3171@averell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch implements simple stem compression for the kallsyms symbol 
table. Each symbol has as first byte a count on how many characters
are identical to the previous symbol. This compresses the often
common repetive prefixes (like subsys_) fairly effectively.

On a fairly full featured monolithic i386 kernel this saves about 60k in 
the kallsyms symbol table.

The changes are very simple, so the 60k are not shabby.

One visible change is that the caller of kallsyms_lookup has to pass in 
a buffer now, because it has to be modified. I added an arbitary
127 character limit to it.

Still >210k left in the symbol table unfortunately. Another idea would be to 
delta encode the addresses in 16bits (functions are all likely to be smaller 
than 64K).  This would especially help on 64bit hosts. Not done yet, however.

No, before someone asks, I don't want to use zlib for that. Far too fragile 
during an oops and overkill too and it would require to link it into all
kernels.

Patch for 2.5.52. Please consider applying.

-Andi

diff -u linux-2.5.52/include/linux/kallsyms.h-STEM linux-2.5.52/include/linux/kallsyms.h
--- linux-2.5.52/include/linux/kallsyms.h-STEM	2002-11-23 03:49:10.000000000 +0100
+++ linux-2.5.52/include/linux/kallsyms.h	2002-12-23 15:27:54.000000000 +0100
@@ -12,7 +12,7 @@
 const char *kallsyms_lookup(unsigned long addr,
 			    unsigned long *symbolsize,
 			    unsigned long *offset,
-			    char **modname);
+			    char **modname, char *namebuf);
 
 /* Replace "%s" in format with address, if found */
 extern void __print_symbol(const char *fmt, unsigned long address);
@@ -22,7 +22,7 @@
 static inline const char *kallsyms_lookup(unsigned long addr,
 					  unsigned long *symbolsize,
 					  unsigned long *offset,
-					  char **modname)
+					  char **modname, char *namebuf)
 {
 	return NULL;
 }
diff -u linux-2.5.52/fs/proc/base.c-STEM linux-2.5.52/fs/proc/base.c
--- linux-2.5.52/fs/proc/base.c-STEM	2002-11-30 13:58:18.000000000 +0100
+++ linux-2.5.52/fs/proc/base.c	2002-12-23 15:26:16.000000000 +0100
@@ -258,10 +258,11 @@
 	char *modname;
 	const char *sym_name;
 	unsigned long wchan, size, offset;
+	char namebuf[128];
 
 	wchan = get_wchan(task);
 
-	sym_name = kallsyms_lookup(wchan, &size, &offset, &modname);
+	sym_name = kallsyms_lookup(wchan, &size, &offset, &modname, namebuf);
 	if (sym_name)
 		return sprintf(buffer, "%s", sym_name);
 	return sprintf(buffer, "%lu", wchan);
diff -u linux-2.5.52/scripts/kallsyms.c-STEM linux-2.5.52/scripts/kallsyms.c
--- linux-2.5.52/scripts/kallsyms.c-STEM	2002-12-23 14:04:43.000000000 +0100
+++ linux-2.5.52/scripts/kallsyms.c	2002-12-23 14:07:20.000000000 +0100
@@ -93,6 +93,7 @@
 {
 	unsigned long long last_addr;
 	int i, valid = 0;
+	char *prev;
 
 	printf(".data\n");
 
@@ -121,15 +122,22 @@
 	printf(".globl kallsyms_names\n");
 	printf("\t.align 8\n");
 	printf("kallsyms_names:\n");
+	prev = ""; 
 	for (i = 0, last_addr = 0; i < cnt; i++) {
+		int k;
+
 		if (!symbol_valid(&table[i]))
 			continue;
 		
 		if (table[i].addr == last_addr)
 			continue;
 
-		printf("\t.string\t\"%s\"\n", table[i].sym);
+		for (k = 0; table[i].sym[k] && table[i].sym[k] == prev[k]; ++k)
+			; 
+
+		printf("\t.asciz\t\"\\x%02x%s\"\n", k, table[i].sym + k);
 		last_addr = table[i].addr;
+		prev = table[i].sym;
 	}
 	printf("\n");
 }
diff -u linux-2.5.52/kernel/kallsyms.c-STEM linux-2.5.52/kernel/kallsyms.c
--- linux-2.5.52/kernel/kallsyms.c-STEM	2002-12-19 13:53:02.000000000 +0100
+++ linux-2.5.52/kernel/kallsyms.c	2002-12-23 19:34:38.000000000 +0100
@@ -4,6 +4,7 @@
  * Rewritten and vastly simplified by Rusty Russell for in-kernel
  * module loader:
  *   Copyright 2002 Rusty Russell <rusty@rustcorp.com.au> IBM Corporation
+ * Stem compression by Andi Kleen.
  */
 #include <linux/kallsyms.h>
 #include <linux/module.h>
@@ -22,7 +23,7 @@
 const char *kallsyms_lookup(unsigned long addr,
 			    unsigned long *symbolsize,
 			    unsigned long *offset,
-			    char **modname)
+			    char **modname, char *namebuf)
 {
 	unsigned long i, best = 0;
 
@@ -30,6 +31,8 @@
 	if ((void *)kallsyms_addresses == &kallsyms_dummy)
 		BUG();
 
+	namebuf[127] = 0;
+
 	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_etext) {
 		unsigned long symbol_end;
 		char *name = kallsyms_names;
@@ -42,8 +45,11 @@
 		}
 
 		/* Grab name */
-		for (i = 0; i < best; i++)
+		for (i = 0; i < best; i++) { 
+			++name;
+			strncpy(namebuf + name[-1], name, 127); 
 			name += strlen(name)+1;
+		} 
 
 		/* Base symbol size on next symbol. */
 		if (best + 1 < kallsyms_num_syms)
@@ -54,7 +60,7 @@
 		*symbolsize = symbol_end - kallsyms_addresses[best];
 		*modname = NULL;
 		*offset = addr - kallsyms_addresses[best];
-		return name;
+		return namebuf;
 	}
 
 	return module_address_lookup(addr, symbolsize, offset, modname);
@@ -66,8 +72,9 @@
 	char *modname;
 	const char *name;
 	unsigned long offset, size;
+	char namebuf[128];
 
-	name = kallsyms_lookup(address, &size, &offset, &modname);
+	name = kallsyms_lookup(address, &size, &offset, &modname, namebuf);
 
 	if (!name) {
 		char addrstr[sizeof("0x%lx") + (BITS_PER_LONG*3/10)];
