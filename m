Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266116AbTABGwm>; Thu, 2 Jan 2003 01:52:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266125AbTABGwm>; Thu, 2 Jan 2003 01:52:42 -0500
Received: from packet.digeo.com ([12.110.80.53]:49599 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266116AbTABGwj>;
	Thu, 2 Jan 2003 01:52:39 -0500
Message-ID: <3E13E3AD.9B255CAE@digeo.com>
Date: Wed, 01 Jan 2003 23:01:01 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Aniruddha M Marathe <aniruddha.marathe@wipro.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.53-mm3
References: <94F20261551DC141B6B559DC491086720447DE@blr-m3-msg.wipro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Jan 2003 07:01:01.0775 (UTC) FILETIME=[B5C5F5F0:01C2B22C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aniruddha M Marathe wrote:
> 
> Failed while booting up.
> It executed mem_init()
> Then during execution of  kmem_cache_sizes_init(),
> It created generic caches.
> After that following error came,
> Invalid operand: 0000
> ...
> Unable to handle kernel paging request at virtual address b08e3fef
> eip 00000000
> 

Please enable "Load all symbols for debugging/kksymoops" in
the "Kernel hacking" menu and send a full report.

kksymoops is a bit broken in 2.5.54.   You may need this patch:



--- 25/fs/proc/base.c~no-stem-compression	Wed Jan  1 22:30:17 2003
+++ 25-akpm/fs/proc/base.c	Wed Jan  1 22:30:17 2003
@@ -259,11 +259,10 @@ static int proc_pid_wchan(struct task_st
 	char *modname;
 	const char *sym_name;
 	unsigned long wchan, size, offset;
-	char namebuf[128];
 
 	wchan = get_wchan(task);
 
-	sym_name = kallsyms_lookup(wchan, &size, &offset, &modname, namebuf);
+	sym_name = kallsyms_lookup(wchan, &size, &offset, &modname);
 	if (sym_name)
 		return sprintf(buffer, "%s", sym_name);
 	return sprintf(buffer, "%lu", wchan);
--- 25/include/linux/kallsyms.h~no-stem-compression	Wed Jan  1 22:30:17 2003
+++ 25-akpm/include/linux/kallsyms.h	Wed Jan  1 22:30:17 2003
@@ -12,7 +12,7 @@
 const char *kallsyms_lookup(unsigned long addr,
 			    unsigned long *symbolsize,
 			    unsigned long *offset,
-			    char **modname, char *namebuf);
+			    char **modname);
 
 /* Replace "%s" in format with address, if found */
 extern void __print_symbol(const char *fmt, unsigned long address);
@@ -22,7 +22,7 @@ extern void __print_symbol(const char *f
 static inline const char *kallsyms_lookup(unsigned long addr,
 					  unsigned long *symbolsize,
 					  unsigned long *offset,
-					  char **modname, char *namebuf)
+					  char **modname)
 {
 	return NULL;
 }
--- 25/kernel/kallsyms.c~no-stem-compression	Wed Jan  1 22:30:17 2003
+++ 25-akpm/kernel/kallsyms.c	Wed Jan  1 22:30:17 2003
@@ -4,7 +4,6 @@
  * Rewritten and vastly simplified by Rusty Russell for in-kernel
  * module loader:
  *   Copyright 2002 Rusty Russell <rusty@rustcorp.com.au> IBM Corporation
- * Stem compression by Andi Kleen.
  */
 #include <linux/kallsyms.h>
 #include <linux/module.h>
@@ -23,7 +22,7 @@ extern char _stext[], _etext[];
 const char *kallsyms_lookup(unsigned long addr,
 			    unsigned long *symbolsize,
 			    unsigned long *offset,
-			    char **modname, char *namebuf)
+			    char **modname)
 {
 	unsigned long i, best = 0;
 
@@ -31,8 +30,6 @@ const char *kallsyms_lookup(unsigned lon
 	if ((void *)kallsyms_addresses == &kallsyms_dummy)
 		BUG();
 
-	namebuf[127] = 0;
-
 	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_etext) {
 		unsigned long symbol_end;
 		char *name = kallsyms_names;
@@ -45,11 +42,8 @@ const char *kallsyms_lookup(unsigned lon
 		}
 
 		/* Grab name */
-		for (i = 0; i < best; i++) { 
-			++name;
-			strncpy(namebuf + name[-1], name, 127); 
+		for (i = 0; i < best; i++)
 			name += strlen(name)+1;
-		} 
 
 		/* Base symbol size on next symbol. */
 		if (best + 1 < kallsyms_num_syms)
@@ -60,7 +54,7 @@ const char *kallsyms_lookup(unsigned lon
 		*symbolsize = symbol_end - kallsyms_addresses[best];
 		*modname = NULL;
 		*offset = addr - kallsyms_addresses[best];
-		return namebuf;
+		return name;
 	}
 
 	return module_address_lookup(addr, symbolsize, offset, modname);
@@ -72,9 +66,8 @@ void __print_symbol(const char *fmt, uns
 	char *modname;
 	const char *name;
 	unsigned long offset, size;
-	char namebuf[128];
 
-	name = kallsyms_lookup(address, &size, &offset, &modname, namebuf);
+	name = kallsyms_lookup(address, &size, &offset, &modname);
 
 	if (!name) {
 		char addrstr[sizeof("0x%lx") + (BITS_PER_LONG*3/10)];
--- 25/scripts/kallsyms.c~no-stem-compression	Wed Jan  1 22:30:17 2003
+++ 25-akpm/scripts/kallsyms.c	Wed Jan  1 22:30:17 2003
@@ -93,7 +93,6 @@ write_src(void)
 {
 	unsigned long long last_addr;
 	int i, valid = 0;
-	char *prev;
 
 	printf("#include <asm/types.h>\n");
 	printf("#if BITS_PER_LONG == 64\n");
@@ -131,22 +130,15 @@ write_src(void)
 	printf(".globl kallsyms_names\n");
 	printf("\tALGN\n");
 	printf("kallsyms_names:\n");
-	prev = ""; 
 	for (i = 0, last_addr = 0; i < cnt; i++) {
-		int k;
-
 		if (!symbol_valid(&table[i]))
 			continue;
 		
 		if (table[i].addr == last_addr)
 			continue;
 
-		for (k = 0; table[i].sym[k] && table[i].sym[k] == prev[k]; ++k)
-			; 
-
-		printf("\t.asciz\t\"\\x%02x%s\"\n", k, table[i].sym + k);
+		printf("\t.string\t\"%s\"\n", table[i].sym);
 		last_addr = table[i].addr;
-		prev = table[i].sym;
 	}
 	printf("\n");
 }

_
