Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbUCAF6X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 00:58:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbUCAF6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 00:58:23 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14994 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262252AbUCAF6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 00:58:19 -0500
To: <linux-kernel@vger.kernel.org>
CC: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] 2.6.4-rc1 fix x86 early_printk and make it early
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Feb 2004 22:24:12 -0700
Message-ID: <m165dp9m2r.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Trying to use early_printk on x86 I found two issues.
- setup_early_printk is currently called much later than necessary.
- VGABASE is using an identity mapped physical address on x86.
  o That is problematic with PAE support, because there is a moment
    during paging_init() when the physical identity mappings do not
    work. 
  o Using raw physical addresses is in bad form, and doesn't always work.
  o I can't possibly see how Andrew's Changelog that using __pa
    is more friendly to the 4G/4G split is correct.  Unless someone
    was hard coding a virtual address previously.


The first hunk of this patch moves setup_early_printk as
early as possible on x86.

The second hunk in early_printk.c redefines VGABASE as __va(0xb8000).
This is correct on both x86 and x86-64 so we don't need any more
special cases.  The only thing that might be slightly more correct
would be to use isa_readw/isa_writew but the only difference is
in where PAGE_OFFSET is added in.

Eric


diff -uNrX linux-ignore-files linux-2.6.4-rc1/arch/i386/kernel/setup.c linux-2.6.4-rc1.earlyprintk/arch/i386/kernel/setup.c
--- linux-2.6.4-rc1/arch/i386/kernel/setup.c	Sun Feb 29 14:09:16 2004
+++ linux-2.6.4-rc1.earlyprintk/arch/i386/kernel/setup.c	Sun Feb 29 19:10:40 2004
@@ -1048,6 +1048,18 @@
 {
 	unsigned long max_low_pfn;
 
+#ifdef CONFIG_EARLY_PRINTK
+	extern void setup_early_printk(char *);
+	char *str;
+
+	COMMAND_LINE[COMMAND_LINE_SIZE -1] = '\0';
+	str = strstr(COMMAND_LINE, "earlyprintk=");
+	if (str) {
+		setup_early_printk(str);
+		printk("early console enabled\n");
+	}
+#endif
+
 	memcpy(&boot_cpu_data, &new_cpu_data, sizeof(new_cpu_data));
 	pre_setup_arch_hook();
 	early_cpu_init();
@@ -1117,19 +1129,6 @@
 	smp_alloc_memory(); /* AP processor realmode stacks in low memory*/
 #endif
 	paging_init();
-
-#ifdef CONFIG_EARLY_PRINTK
-	{
-		char *s = strstr(*cmdline_p, "earlyprintk=");
-		if (s) {
-			extern void setup_early_printk(char *);
-
-			setup_early_printk(s);
-			printk("early console enabled\n");
-		}
-	}
-#endif
-
 
 	dmi_scan_machine();
 
diff -uNrX linux-ignore-files linux-2.6.4-rc1/arch/x86_64/kernel/early_printk.c linux-2.6.4-rc1.earlyprintk/arch/x86_64/kernel/early_printk.c
--- linux-2.6.4-rc1/arch/x86_64/kernel/early_printk.c	Sun Feb 29 21:24:55 2004
+++ linux-2.6.4-rc1.earlyprintk/arch/x86_64/kernel/early_printk.c	Sun Feb 29 21:26:02 2004
@@ -7,11 +7,7 @@
 
 /* Simple VGA output */
 
-#ifdef __i386__
-#define VGABASE		__pa(__PAGE_OFFSET + 0xb8000UL)
-#else
-#define VGABASE		0xffffffff800b8000UL
-#endif
+#define VGABASE		__va(0xb8000UL)
 
 #define MAX_YPOS	25
 #define MAX_XPOS	80
