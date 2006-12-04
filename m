Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937087AbWLDQ06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937087AbWLDQ06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 11:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937093AbWLDQ06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 11:26:58 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:40676
	"EHLO emea1-mh.id2.novell.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S937087AbWLDQ05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 11:26:57 -0500
Message-Id: <45745A92.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Mon, 04 Dec 2006 16:27:46 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] move kallsyms data to .rodata
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kallsyms data is never written to, so it can as well benefit from
CONFIG_DEBUG_RODATA.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.19/kernel/kallsyms.c	2006-11-29 22:57:37.000000000 +0100
+++ 2.6.19-kallsyms-rodata/kernel/kallsyms.c	2006-12-04 15:20:16.000000000 +0100
@@ -30,14 +30,14 @@
 #endif
 
 /* These will be re-linked against their real values during the second link stage */
-extern unsigned long kallsyms_addresses[] __attribute__((weak));
-extern unsigned long kallsyms_num_syms __attribute__((weak,section("data")));
-extern u8 kallsyms_names[] __attribute__((weak));
+extern const unsigned long kallsyms_addresses[] __attribute__((weak));
+extern const unsigned long kallsyms_num_syms __attribute__((weak));
+extern const u8 kallsyms_names[] __attribute__((weak));
 
-extern u8 kallsyms_token_table[] __attribute__((weak));
-extern u16 kallsyms_token_index[] __attribute__((weak));
+extern const u8 kallsyms_token_table[] __attribute__((weak));
+extern const u16 kallsyms_token_index[] __attribute__((weak));
 
-extern unsigned long kallsyms_markers[] __attribute__((weak));
+extern const unsigned long kallsyms_markers[] __attribute__((weak));
 
 static inline int is_kernel_inittext(unsigned long addr)
 {
@@ -83,7 +83,7 @@ static int is_ksym_addr(unsigned long ad
 static unsigned int kallsyms_expand_symbol(unsigned int off, char *result)
 {
 	int len, skipped_first = 0;
-	u8 *tptr, *data;
+	const u8 *tptr, *data;
 
 	/* get the compressed symbol length from the first symbol byte */
 	data = &kallsyms_names[off];
@@ -131,7 +131,7 @@ static char kallsyms_get_symbol_type(uns
  * kallsyms array */
 static unsigned int get_symbol_offset(unsigned long pos)
 {
-	u8 *name;
+	const u8 *name;
 	int i;
 
 	/* use the closest marker we have. We have markers every 256 positions,
--- linux-2.6.19/scripts/kallsyms.c	2006-11-29 22:57:37.000000000 +0100
+++ 2.6.19-kallsyms-rodata/scripts/kallsyms.c	2006-12-04 15:25:57.000000000 +0100
@@ -263,7 +263,7 @@ static void write_src(void)
 	printf("#define ALGN .align 4\n");
 	printf("#endif\n");
 
-	printf(".data\n");
+	printf("\t.section .rodata, \"a\"\n");
 
 	output_label("kallsyms_addresses");
 	for (i = 0; i < table_cnt; i++) {


