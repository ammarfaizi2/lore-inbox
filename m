Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261686AbTAIGMy>; Thu, 9 Jan 2003 01:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261689AbTAIGMy>; Thu, 9 Jan 2003 01:12:54 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:48153 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id <S261686AbTAIGMt>; Thu, 9 Jan 2003 01:12:49 -0500
Date: Thu, 9 Jan 2003 06:22:50 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@transmeta.com>
cc: Andi Kleen <ak@suse.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] kallsyms off-by-one and sorting
Message-ID: <Pine.LNX.4.44.0301090620040.1104-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Beware of kksymoops reports on 2.5.55:
kallsyms was off-by-one, showing the preceding symbol name.  For
example, if best index 0, no string was copied into the namebuf.

And it seems odd to do stem compression on symbols sorted by value:
save more space sorting by name.  It's harder then to avoid aliases
for a value; but very few in kernel text, so scrap last_addr check.

 Makefile           |    2 +-
 kernel/kallsyms.c  |   32 ++++++++++++++++----------------
 scripts/kallsyms.c |   15 +++------------
 3 files changed, 20 insertions(+), 29 deletions(-)

Resend against 2.5.55: please apply.

Hugh

--- 2.5.55/Makefile	Thu Jan  9 05:34:15 2003
+++ linux/Makefile	Thu Jan  9 05:36:45 2003
@@ -355,7 +355,7 @@
 kallsyms.o := .tmp_kallsyms2.o
 
 quiet_cmd_kallsyms = KSYM    $@
-cmd_kallsyms = $(NM) -n $< | scripts/kallsyms > $@
+cmd_kallsyms = $(NM) $< | scripts/kallsyms > $@
 
 .tmp_kallsyms1.o .tmp_kallsyms2.o: %.o: %.S scripts FORCE
 	$(call if_changed_dep,as_o_S)
--- 2.5.55/kernel/kallsyms.c	Thu Jan  9 05:34:27 2003
+++ linux/kernel/kallsyms.c	Thu Jan  9 05:36:45 2003
@@ -25,8 +25,6 @@
 			    unsigned long *offset,
 			    char **modname, char *namebuf)
 {
-	unsigned long i, best = 0;
-
 	/* This kernel should never had been booted. */
 	if ((void *)kallsyms_addresses == &kallsyms_dummy)
 		BUG();
@@ -35,32 +33,34 @@
 	namebuf[0] = 0;
 
 	if (addr >= (unsigned long)_stext && addr <= (unsigned long)_etext) {
-		unsigned long symbol_end;
+		unsigned long below = 0;
+		unsigned long above = (unsigned long)_etext;
+		unsigned long i, best = 0;
 		char *name = kallsyms_names;
 
-		/* They're sorted, we could be clever here, but who cares? */
 		for (i = 0; i < kallsyms_num_syms; i++) {
-			if (kallsyms_addresses[i] > kallsyms_addresses[best] &&
-			    kallsyms_addresses[i] <= addr)
-				best = i;
+			unsigned long kaddr = kallsyms_addresses[i];
+			if (kaddr <= addr) {
+				if (kaddr > below) {
+					below = kaddr;
+					best = i;
+				}
+			} else {
+				if (kaddr < above)
+					above = kaddr;
+			}
 		}
 
 		/* Grab name */
-		for (i = 0; i < best; i++) { 
+		for (i = 0; i <= best; i++) { 
 			unsigned prefix = *name++;
 			strncpy(namebuf + prefix, name, 127 - prefix);
 			name += strlen(name) + 1;
 		}
 
-		/* Base symbol size on next symbol. */
-		if (best + 1 < kallsyms_num_syms)
-			symbol_end = kallsyms_addresses[best + 1];
-		else
-			symbol_end = (unsigned long)_etext;
-
-		*symbolsize = symbol_end - kallsyms_addresses[best];
+		*symbolsize = above - below;
 		*modname = NULL;
-		*offset = addr - kallsyms_addresses[best];
+		*offset = addr - below;
 		return namebuf;
 	}
 
--- 2.5.55/scripts/kallsyms.c	Thu Jan  9 05:34:28 2003
+++ linux/scripts/kallsyms.c	Thu Jan  9 05:36:45 2003
@@ -5,7 +5,7 @@
  * This software may be used and distributed according to the terms
  * of the GNU General Public License, incorporated herein by reference.
  *
- * Usage: nm -n vmlinux | scripts/kallsyms > symbols.S
+ * Usage: nm vmlinux | scripts/kallsyms > symbols.S
  */
 
 #include <stdio.h>
@@ -91,7 +91,6 @@
 static void
 write_src(void)
 {
-	unsigned long long last_addr;
 	int i, valid = 0;
 	char *prev;
 
@@ -109,16 +108,12 @@
 	printf(".globl kallsyms_addresses\n");
 	printf("\tALGN\n");
 	printf("kallsyms_addresses:\n");
-	for (i = 0, last_addr = 0; i < cnt; i++) {
+	for (i = 0; i < cnt; i++) {
 		if (!symbol_valid(&table[i]))
 			continue;
 		
-		if (table[i].addr == last_addr)
-			continue;
-
 		printf("\tPTR\t%#llx\n", table[i].addr);
 		valid++;
-		last_addr = table[i].addr;
 	}
 	printf("\n");
 
@@ -132,20 +127,16 @@
 	printf("\tALGN\n");
 	printf("kallsyms_names:\n");
 	prev = ""; 
-	for (i = 0, last_addr = 0; i < cnt; i++) {
+	for (i = 0; i < cnt; i++) {
 		int k;
 
 		if (!symbol_valid(&table[i]))
 			continue;
 		
-		if (table[i].addr == last_addr)
-			continue;
-
 		for (k = 0; table[i].sym[k] && table[i].sym[k] == prev[k]; ++k)
 			; 
 
 		printf("\t.byte 0x%02x ; .asciz\t\"%s\"\n", k, table[i].sym + k);
-		last_addr = table[i].addr;
 		prev = table[i].sym;
 	}
 	printf("\n");

