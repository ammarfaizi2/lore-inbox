Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVBYUz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVBYUz0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 15:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVBYUz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 15:55:26 -0500
Received: from [195.23.16.24] ([195.23.16.24]:36577 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261384AbVBYUy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 15:54:59 -0500
Message-ID: <421F90A0.7060404@grupopie.com>
Date: Fri, 25 Feb 2005 20:54:56 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: ARM undefined symbols.  Again.
References: <20050124154326.A5541@flint.arm.linux.org.uk> <20050131161753.GA15674@mars.ravnborg.org> <20050207114359.A32277@flint.arm.linux.org.uk> <20050208194243.GA8505@mars.ravnborg.org> <20050208200501.B3544@flint.arm.linux.org.uk> <20050209104053.A31869@flint.arm.linux.org.uk> <20050213172940.A12469@flint.arm.linux.org.uk> <4210A345.6030304@grupopie.com> <20050225194823.A27842@flint.arm.linux.org.uk> <Pine.LNX.4.58.0502251158280.9237@ppc970.osdl.org> <20050225202349.C27842@flint.arm.linux.org.uk> <Pine.LNX.4.58.0502251227480.9237@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0502251227480.9237@ppc970.osdl.org>
Content-Type: multipart/mixed;
 boundary="------------010309060109060007040306"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------010309060109060007040306
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Linus Torvalds wrote:
>[...]
> That makes no sense. Or, more likely, it means that the toolchain people 
> are incompetent bastards who don't care about bugs and have no pride at 
> all in what they do.

Errmm... I really feel pretty small coming in on a Russell King / Linus 
Torvalds discussion, but I was the one who promised the patch and I just 
wanted to keep my promises.

The patch (against 2.6.11-rc5) is attached, should you decide to use it.

IMHO it makes the kallsyms code look nicer, by getting rid of the 
__attribute__((weak)) statements int kernel/kallsyms.c code.

Me getting out of here now....

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)

--------------010309060109060007040306
Content-Type: text/plain;
 name="kallpatch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kallpatch"

diff -uprN -X dontdiff linux-2.6.11-rc5-vanilla/kernel/kallsyms.c linux-2.6.11-rc5/kernel/kallsyms.c
--- linux-2.6.11-rc5-vanilla/kernel/kallsyms.c	2005-02-25 20:36:44.000000000 +0000
+++ linux-2.6.11-rc5/kernel/kallsyms.c	2005-02-25 20:15:19.000000000 +0000
@@ -29,14 +29,14 @@
 #endif
 
 /* These will be re-linked against their real values during the second link stage */
-extern unsigned long kallsyms_addresses[] __attribute__((weak));
-extern unsigned long kallsyms_num_syms __attribute__((weak,section("data")));
-extern u8 kallsyms_names[] __attribute__((weak));
+extern unsigned long kallsyms_addresses[];
+extern unsigned long kallsyms_num_syms;
+extern u8 kallsyms_names[];
 
-extern u8 kallsyms_token_table[] __attribute__((weak));
-extern u16 kallsyms_token_index[] __attribute__((weak));
+extern u8 kallsyms_token_table[];
+extern u16 kallsyms_token_index[];
 
-extern unsigned long kallsyms_markers[] __attribute__((weak));
+extern unsigned long kallsyms_markers[];
 
 static inline int is_kernel_inittext(unsigned long addr)
 {
diff -uprN -X dontdiff linux-2.6.11-rc5-vanilla/Makefile linux-2.6.11-rc5/Makefile
--- linux-2.6.11-rc5-vanilla/Makefile	2005-02-25 20:36:15.000000000 +0000
+++ linux-2.6.11-rc5/Makefile	2005-02-25 20:25:44.000000000 +0000
@@ -702,14 +702,20 @@ quiet_cmd_kallsyms = KSYM    $@
       cmd_kallsyms = $(NM) -n $< | $(KALLSYMS) \
                      $(if $(CONFIG_KALLSYMS_ALL),--all-symbols) > $@
 
-.tmp_kallsyms1.o .tmp_kallsyms2.o .tmp_kallsyms3.o: %.o: %.S scripts FORCE
+quiet_cmd_kallsyms0 = KSYM    $@
+      cmd_kallsyms0 = $(KALLSYMS) -0 > $@
+
+.tmp_kallsyms0.o .tmp_kallsyms1.o .tmp_kallsyms2.o .tmp_kallsyms3.o: %.o: %.S scripts FORCE
 	$(call if_changed_dep,as_o_S)
 
+.tmp_kallsyms0.S: $(KALLSYMS) FORCE
+	$(call cmd,kallsyms0)
+
 .tmp_kallsyms%.S: .tmp_vmlinux% $(KALLSYMS)
 	$(call cmd,kallsyms)
 
 # .tmp_vmlinux1 must be complete except kallsyms, so update vmlinux version
-.tmp_vmlinux1: $(vmlinux-lds) $(vmlinux-all) FORCE
+.tmp_vmlinux1: $(vmlinux-lds) $(vmlinux-all) .tmp_kallsyms0.o FORCE
 	$(call if_changed_rule,ksym_ld)
 
 .tmp_vmlinux2: $(vmlinux-lds) $(vmlinux-all) .tmp_kallsyms1.o FORCE
diff -uprN -X dontdiff linux-2.6.11-rc5-vanilla/scripts/kallsyms.c linux-2.6.11-rc5/scripts/kallsyms.c
--- linux-2.6.11-rc5-vanilla/scripts/kallsyms.c	2005-02-25 20:36:45.000000000 +0000
+++ linux-2.6.11-rc5/scripts/kallsyms.c	2005-02-25 20:33:25.000000000 +0000
@@ -93,7 +93,7 @@ unsigned char best_table_len[256];
 static void
 usage(void)
 {
-	fprintf(stderr, "Usage: kallsyms [--all-symbols] < in.map > out.S\n");
+	fprintf(stderr, "Usage: kallsyms [--all-symbols] [-0] < in.map > out.S\n");
 	exit(1);
 }
 
@@ -230,6 +230,20 @@ static void output_label(char *label)
 	printf("%s:\n",label);
 }
 
+static void output_header(void)
+{
+	printf("#include <asm/types.h>\n");
+	printf("#if BITS_PER_LONG == 64\n");
+	printf("#define PTR .quad\n");
+	printf("#define ALGN .align 8\n");
+	printf("#else\n");
+	printf("#define PTR .long\n");
+	printf("#define ALGN .align 4\n");
+	printf("#endif\n");
+
+	printf(".data\n");
+}
+
 /* uncompress a compressed symbol. When this function is called, the best table
  * might still be compressed itself, so the function needs to be recursive */
 static int expand_symbol(unsigned char *data, int len, char *result)
@@ -257,6 +271,25 @@ static int expand_symbol(unsigned char *
 	return total;
 }
 
+/* this function writes an empty assembly output with just the definitions
+ * of the variables */
+
+static void write_src_zero_pass(void)
+{
+	output_header();
+
+	output_label("kallsyms_addresses");
+	output_label("kallsyms_num_syms");
+	output_label("kallsyms_names");
+	output_label("kallsyms_markers");
+	output_label("kallsyms_token_table");
+	output_label("kallsyms_token_index");
+
+	printf("\t.byte\t0\n");
+}
+
+/* this one writes the real deal */
+
 static void
 write_src(void)
 {
@@ -265,16 +298,7 @@ write_src(void)
 	unsigned int *markers;
 	char buf[KSYM_NAME_LEN+1];
 
-	printf("#include <asm/types.h>\n");
-	printf("#if BITS_PER_LONG == 64\n");
-	printf("#define PTR .quad\n");
-	printf("#define ALGN .align 8\n");
-	printf("#else\n");
-	printf("#define PTR .long\n");
-	printf("#define ALGN .align 4\n");
-	printf("#endif\n");
-
-	printf(".data\n");
+	output_header();
 
 	output_label("kallsyms_addresses");
 	valid = 0;
@@ -672,11 +696,18 @@ static void optimize_token_table(void)
 int
 main(int argc, char **argv)
 {
-	if (argc == 2 && strcmp(argv[1], "--all-symbols") == 0)
-		all_symbols = 1;
-	else if (argc != 1)
-		usage();
+	int i;
 
+	for (i = 1; i < argc; i++) {
+		if (strcmp(argv[i], "--all-symbols") == 0)
+			all_symbols = 1;
+		else if(strcmp(argv[i], "-0") == 0) {
+			write_src_zero_pass();
+			return 0;
+		} else
+			usage();
+	}
+	
 	read_map(stdin);
 	optimize_token_table();
 	write_src();

--------------010309060109060007040306--
