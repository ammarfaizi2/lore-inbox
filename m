Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265359AbUAPKMy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jan 2004 05:12:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265362AbUAPKMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jan 2004 05:12:54 -0500
Received: from colin2.muc.de ([193.149.48.15]:18963 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265359AbUAPKMr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jan 2004 05:12:47 -0500
Date: 16 Jan 2004 11:13:45 +0100
Date: Fri, 16 Jan 2004 11:13:45 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>, jh@suse.cz,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add noinline attribute
Message-ID: <20040116101345.GA96037@colin2.muc.de>
References: <20040114083114.GA1784@averell> <Pine.LNX.4.58.0401141519260.4500@evo.osdl.org> <20040115074834.GA38796@colin2.muc.de> <Pine.LNX.4.58.0401151448200.2597@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401151448200.2597@evo.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ugh. Can't we just make this be generic code (and that means calling it in
> the module loading code too..)?

Ok, here is a new patch that does the whole thing in generic code and for
modules too. I didn't bother to change the sort algorithm because the 
existing one works well enough.

-Andi

------------------------------------------------------------------

Sort exception tables at runtime. This avoids problems with out of
order sections like __init. Needed for gcc 3.4 or 3.3-hammer with
-funit-at-a-time.

diff -u linux-34/init/main.c-o linux-34/init/main.c
--- linux-34/init/main.c-o	2004-01-09 09:27:20.000000000 +0100
+++ linux-34/init/main.c	2004-01-16 10:07:00.699618728 +0100
@@ -289,6 +289,32 @@
 }
 __setup("init=", init_setup);
 
+extern struct exception_table_entry __start___ex_table[];
+extern struct exception_table_entry  __stop___ex_table[];
+
+/* When an exception handler is in an non standard section (like __init)
+   the fixup table can end up unordered. Fix that here. */
+__init void sort_extable(struct exception_table_entry *start,
+			 struct exception_table_entry *end)
+{
+	struct exception_table_entry *e;
+	int change;
+
+	/* The input is near completely presorted, which makes bubble sort the
+	   best (and simplest) sort algorithm. */
+	do {
+		change = 0;
+		for (e = start+1; e < end; e++) {
+			if (e->insn < e[-1].insn) {
+				struct exception_table_entry tmp = e[-1];
+				e[-1] = e[0];
+				e[0] = tmp;
+				change = 1;
+			}
+		}
+	} while (change != 0);
+}
+
 extern void setup_arch(char **);
 extern void cpu_idle(void);
 
@@ -394,6 +420,7 @@
 	lock_kernel();
 	printk(linux_banner);
 	setup_arch(&command_line);
+	sort_extable(__start___ex_table, __stop___ex_table);
 	setup_per_cpu_areas();
 
 	/*
diff -u linux-34/kernel/module.c-o linux-34/kernel/module.c
--- linux-34/kernel/module.c-o	2004-01-09 09:27:20.000000000 +0100
+++ linux-34/kernel/module.c	2004-01-16 10:06:14.945574400 +0100
@@ -37,6 +37,9 @@
 #include <asm/pgalloc.h>
 #include <asm/cacheflush.h>
 
+extern void sort_extable(const struct exception_table_entry *start,
+			 const struct exception_table_entry *end);
+
 #if 0
 #define DEBUGP printk
 #else
@@ -1614,6 +1617,7 @@
   	/* Set up exception table */
 	mod->num_exentries = sechdrs[exindex].sh_size / sizeof(*mod->extable);
 	mod->extable = (void *)sechdrs[exindex].sh_addr;
+	sort_extable(mod->extable, mod->extable+mod->num_exentries); 
 
 	/* Now do relocations. */
 	for (i = 1; i < hdr->e_shnum; i++) {
