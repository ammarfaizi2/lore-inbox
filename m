Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbUCBI34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 03:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbUCBI34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 03:29:56 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:4244 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261657AbUCBI3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 03:29:51 -0500
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] 2.6.4-rc1 fix x86 early_printk and make it early
References: <m165dp9m2r.fsf@ebiederm.dsl.xmission.com>
	<20040301115813.6194f2fe.ak@suse.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 Mar 2004 01:21:11 -0700
In-Reply-To: <20040301115813.6194f2fe.ak@suse.de>
Message-ID: <m1u11764nc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

> On 29 Feb 2004 22:24:12 -0700
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> 
> >   o That is problematic with PAE support, because there is a moment
> >     during paging_init() when the physical identity mappings do not
> >     work. 
> 
> Just don't printk in that moment then.
> 
> >   o Using raw physical addresses is in bad form, and doesn't always work.
> 
> On x86-64 it's that __pa() doesn't always work very early.
> 
> >   o I can't possibly see how Andrew's Changelog that using __pa
> >     is more friendly to the 4G/4G split is correct.  Unless someone
> >     was hard coding a virtual address previously.
> 
> Yes, it shouldn't make any difference for 4/4.
> 
> > The second hunk in early_printk.c redefines VGABASE as __va(0xb8000).
> > This is correct on both x86 and x86-64 so we don't need any more
> > special cases.  
> 
> Please don't do that on x86-64. On x86-64 there are two ways to reach this
> address and the previous one is available earlier.  Keep the current
> address for x86-64 please.

Andi much to my great surprise after reading through the comments 
that actually didn't work on x86-64.   So here is my corrected patch.

It still uses __va() for everything but it fixes x86-64 so that it works,
I just had to move one page table entry...

As for 0xffff000000000000 which the old page table entry applied to
I grepped the entire kernel tree and could not find anything that
applied to x86_64.  So it looks like a left over from an earlier definition
of PAGE_OFFSET.

So can we please get this applied to 2.6?  Now that it is almost purely
mini bug fixes?

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
diff -uNrX linux-ignore-files linux-2.6.4-rc1/arch/x86_64/kernel/head.S linux-2.6.4-rc1.earlyprintk/arch/x86_64/kernel/head.S
--- linux-2.6.4-rc1/arch/x86_64/kernel/head.S	Sun Feb 29 14:09:23 2004
+++ linux-2.6.4-rc1.earlyprintk/arch/x86_64/kernel/head.S	Tue Mar  2 01:10:52 2004
@@ -206,9 +206,10 @@
 .org 0x1000
 ENTRY(init_level4_pgt)
 	.quad	0x0000000000102007		/* -> level3_ident_pgt */
-	.fill	255,8,0
+	.fill	1,8,0
+	/* 2^40/2^39 = 2 */
 	.quad	0x000000000010a007
-	.fill	254,8,0
+	.fill	508,8,0
 	/* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
 	.quad	0x0000000000103007		/* -> level3_kernel_pgt */
 

