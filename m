Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264739AbTAJJnt>; Fri, 10 Jan 2003 04:43:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264745AbTAJJnt>; Fri, 10 Jan 2003 04:43:49 -0500
Received: from exzh001.alcatel.ch ([212.243.156.171]:49935 "HELO
	exzh001.alcatel.ch") by vger.kernel.org with SMTP
	id <S264739AbTAJJnm>; Fri, 10 Jan 2003 04:43:42 -0500
Subject: [PATCH 2.5] speedup kallsyms_lookup
From: Daniel Ritz <daniel.ritz@gmx.ch>
To: linux-kernel@vger.kernel.org, hugh@veritas.com, ak@suse.de
Cc: daniel.ritz@alcatel.ch
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 10 Jan 2003 10:53:39 +0100
Message-Id: <1042192419.1415.49.camel@cast2.alcatel.ch>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[please cc...you know why]

a patch to speed up the kallsyms_lookup() function while still doing
compression. 
- make 4 sections: addresses, lens, stem, strings
- only strncpy() when needed
- no strlen() at all (only in the script)
- save space we lose for len table by not making strings zero terminated

not yet included is hugh's patch to sort the symbols by name, i didn't
look at it yet. but at least it should not be off-by-one...i din't test
it that much, but it looks quiet ok..

not yet sent to linus. comments first. against 2.5.55.


beep
-daniel



--- 2555-clean/scripts/kallsyms.c	2003-01-09 05:04:27.000000000 +0100
+++ 2555/scripts/kallsyms.c	2003-01-10 10:16:41.000000000 +0100
@@ -26,7 +26,8 @@
 static void
 usage(void)
 {
-	fprintf(stderr, "Usage: kallsyms < in.map > out.S\n");
+	fprintf(stderr, "Usage: kallsyms out.S < in.map\n");
+	fprintf(stderr, "       Generates out.S.[123], cat them together.\n");
 	exit(1);
 }
 
@@ -89,26 +90,42 @@
 }
 
 static void
-write_src(void)
+write_src(char *name)
 {
 	unsigned long long last_addr;
 	int i, valid = 0;
 	char *prev;
 
-	printf("#include <asm/types.h>\n");
-	printf("#if BITS_PER_LONG == 64\n");
-	printf("#define PTR .quad\n");
-	printf("#define ALGN .align 8\n");
-	printf("#else\n");
-	printf("#define PTR .long\n");
-	printf("#define ALGN .align 4\n");
-	printf("#endif\n");
+	char *tname;
+	int len;
+	FILE *f1, *f2, *f3;
 
-	printf(".data\n");
+	len = strlen(name);
+	tname = malloc(len + 3);
+	strcpy(tname, name);
 
-	printf(".globl kallsyms_addresses\n");
-	printf("\tALGN\n");
-	printf("kallsyms_addresses:\n");
+	strcpy(tname + len, ".1");
+	f1 = fopen(tname, "w");
+	strcpy(tname + len, ".2");
+	f2 = fopen(tname, "w");
+	strcpy(tname + len, ".3");
+	f3 = fopen(tname, "w");
+	free(tname);
+
+	fprintf(f1, "#include <asm/types.h>\n");
+	fprintf(f1, "#if BITS_PER_LONG == 64\n");
+	fprintf(f1, "#define PTR .quad\n");
+	fprintf(f1, "#define ALGN .align 8\n");
+	fprintf(f1, "#else\n");
+	fprintf(f1, "#define PTR .long\n");
+	fprintf(f1, "#define ALGN .align 4\n");
+	fprintf(f1, "#endif\n");
+
+	fprintf(f1, ".data\n");
+
+	fprintf(f1, ".globl kallsyms_addresses\n");
+	fprintf(f1, "\tALGN\n");
+	fprintf(f1, "kallsyms_addresses:\n");
 	for (i = 0, last_addr = 0; i < cnt; i++) {
 		if (!symbol_valid(&table[i]))
 			continue;
@@ -116,21 +133,29 @@
 		if (table[i].addr == last_addr)
 			continue;
 
-		printf("\tPTR\t%#llx\n", table[i].addr);
+		fprintf(f1, "\tPTR\t%#llx\n", table[i].addr);
 		valid++;
 		last_addr = table[i].addr;
 	}
-	printf("\n");
+	fprintf(f1, "\n");
 
-	printf(".globl kallsyms_num_syms\n");
-	printf("\tALGN\n");
-	printf("kallsyms_num_syms:\n");
-	printf("\tPTR\t%d\n", valid);
-	printf("\n");
+	fprintf(f1, ".globl kallsyms_num_syms\n");
+	fprintf(f1, "\tALGN\n");
+	fprintf(f1, "kallsyms_num_syms:\n");
+	fprintf(f1, "\tPTR\t%d\n", valid);
+	fprintf(f1, "\n");
 
-	printf(".globl kallsyms_names\n");
-	printf("\tALGN\n");
-	printf("kallsyms_names:\n");
+	fprintf(f1, ".globl kallsyms_lens\n");
+	fprintf(f1, "\tALGN\n");
+	fprintf(f1, "kallsyms_lens:\n");
+
+	fprintf(f2, ".globl kallsyms_stem\n");
+	fprintf(f2, "\tALGN\n");
+	fprintf(f2, "kallsyms_stem:\n");
+
+	fprintf(f3, ".globl kallsyms_names\n");
+	fprintf(f3, "\tALGN\n");
+	fprintf(f3, "kallsyms_names:\n");
 	prev = ""; 
 	for (i = 0, last_addr = 0; i < cnt; i++) {
 		int k;
@@ -144,21 +169,29 @@
 		for (k = 0; table[i].sym[k] && table[i].sym[k] == prev[k]; ++k)
 			; 
 
-		printf("\t.byte 0x%02x ; .asciz\t\"%s\"\n", k, table[i].sym + k);
+		fprintf(f1, "\t.byte 0x%02x\n", strlen(table[i].sym) - k);
+		fprintf(f2, "\t.byte 0x%02x\n", k);
+		fprintf(f3, "\t.ascii\t\"%s\"\n", table[i].sym + k);
 		last_addr = table[i].addr;
 		prev = table[i].sym;
 	}
-	printf("\n");
+	fprintf(f1, "\n");
+	fprintf(f2, "\n");
+	fprintf(f3, "\n");
+
+	fclose(f1);
+	fclose(f2);
+	fclose(f3);
 }
 
 int
 main(int argc, char **argv)
 {
-	if (argc != 1)
+	if (argc != 2)
 		usage();
 
 	read_map(stdin);
-	write_src();
+	write_src(argv[1]);
 
 	return 0;
 }
--- 2555-clean/Makefile	2003-01-09 05:03:54.000000000 +0100
+++ 2555/Makefile	2003-01-10 00:14:21.000000000 +0100
@@ -355,7 +355,7 @@
 kallsyms.o := .tmp_kallsyms2.o
 
 quiet_cmd_kallsyms = KSYM    $@
-cmd_kallsyms = $(NM) -n $< | scripts/kallsyms > $@
+cmd_kallsyms = $(NM) -n $< | scripts/kallsyms $@; cat $@.1 $@.2 $@.3 > $@
 
 .tmp_kallsyms1.o .tmp_kallsyms2.o: %.o: %.S scripts FORCE
 	$(call if_changed_dep,as_o_S)
--- 2555-clean/kernel/kallsyms.c	2003-01-09 05:04:26.000000000 +0100
+++ 2555/kernel/kallsyms.c	2003-01-10 01:32:00.000000000 +0100
@@ -14,6 +14,8 @@
 /* These will be re-linked against their real values during the second link stage */
 extern unsigned long kallsyms_addresses[1] __attribute__((weak, alias("kallsyms_dummy")));
 extern unsigned long kallsyms_num_syms __attribute__((weak, alias("kallsyms_dummy")));
+extern char kallsyms_lens[1] __attribute__((weak, alias("kallsyms_dummy")));
+extern char kallsyms_stem[1] __attribute__((weak, alias("kallsyms_dummy")));
 extern char kallsyms_names[1] __attribute__((weak, alias("kallsyms_dummy")));
 
 /* Defined by the linker script. */
@@ -26,6 +28,7 @@
 			    char **modname, char *namebuf)
 {
 	unsigned long i, best = 0;
+	unsigned long sym_offs = 0, stem = 0, stem_tmp, len;
 
 	/* This kernel should never had been booted. */
 	if ((void *)kallsyms_addresses == &kallsyms_dummy)
@@ -45,13 +48,31 @@
 				best = i;
 		}
 
-		/* Grab name */
-		for (i = 0; i < best; i++) { 
-			unsigned prefix = *name++;
-			strncpy(namebuf + prefix, name, 127 - prefix);
-			name += strlen(name) + 1;
+		/* find name offset */
+		for (i = 0; i < best; i++)
+			sym_offs += (unsigned long) kallsyms_lens[i];
+
+		/* go for the end of the name */
+		name = kallsyms_names + sym_offs;
+		stem = (unsigned long) kallsyms_stem[best];
+		len  = (unsigned long) kallsyms_lens[best];
+		strncpy(namebuf + stem, name, len);
+		namebuf[stem + len] = '\0';
+
+		/* go back, find the beginning */
+		if (stem) {
+			i = best;
+			do {
+				i--;
+				name -= kallsyms_lens[i];
+				stem_tmp = (unsigned long) kallsyms_stem[i];
+
+				if (stem_tmp < stem)
+					strncpy(namebuf + stem_tmp, name, stem - stem_tmp);
+			} while (stem_tmp);
 		}
 
+
 		/* Base symbol size on next symbol. */
 		if (best + 1 < kallsyms_num_syms)
 			symbol_end = kallsyms_addresses[best + 1];





