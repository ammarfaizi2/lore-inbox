Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266501AbUAOHtT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 02:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266532AbUAOHtT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 02:49:19 -0500
Received: from colin2.muc.de ([193.149.48.15]:41480 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S266501AbUAOHrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 02:47:39 -0500
Date: 15 Jan 2004 08:48:34 +0100
Date: Thu, 15 Jan 2004 08:48:34 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@muc.de>, akpm@osdl.org, jh@suse.cz,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add noinline attribute
Message-ID: <20040115074834.GA38796@colin2.muc.de>
References: <20040114083114.GA1784@averell> <Pine.LNX.4.58.0401141519260.4500@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401141519260.4500@evo.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 03:23:35PM -0800, Linus Torvalds wrote:
> 
> 
> On Wed, 14 Jan 2004, Andi Kleen wrote:
> > 
> > do_test_wp_bit cannot be inlined, otherwise the kernel doesn't boot
> > because the exception tables get reordered. 
> 
> This patch seems to just hide the _real_ bug, which is that the exception 
> table gets confused.
> 
> If the exception table is confused, you'll get oopses on bad user system 
> call pointers, but since that is uncommon, you'll never see it under 
> normal circumstances. This is the only exception that you'll always see.

Actually you would get a non booting system because the broken mount
ABI does a stress test of EFAULT on every boot.

The only problem is using the exception table from __init functions. It is long 
known that this doesn't work because the exception table setup relies 
on the linker generating functions in order and __init violates that. 

This has broken various things over time, but so far nothing in mainline
i386 yet. I think kdb did this sorting forever for example.


> So it sounds like you have a compiler combination that breaks the 
> exception table totally for _any_ function called from any non-regular 
> segment, and this just happens to be the only one you actually saw.
> 
> How about just fixing the exception table instead? A bogo-sort at boot 
> time?

That's fine for me. In fact I did this some time ago on x86-64 when I 
ran into similar problems. Here's a port of the x86-64 sort function.

-AndI


diff -u linux-34/arch/i386/mm/extable.c-o linux-34/arch/i386/mm/extable.c
--- linux-34/arch/i386/mm/extable.c-o	2003-05-27 03:01:00.000000000 +0200
+++ linux-34/arch/i386/mm/extable.c	2004-01-15 08:39:31.657013864 +0100
@@ -5,6 +5,7 @@
 #include <linux/config.h>
 #include <linux/module.h>
 #include <linux/spinlock.h>
+#include <linux/init.h>
 #include <asm/uaccess.h>
 
 /* Simple binary search */
@@ -56,3 +57,28 @@
 
 	return 0;
 }
+
+/* When an exception handler is in an non standard section (like __init)
+   the fixup table can end up unordered. Fix that here. */
+__init int check_extable(void)
+{
+	extern struct exception_table_entry __start___ex_table[];
+	extern struct exception_table_entry  __stop___ex_table[];
+	struct exception_table_entry *e;
+	int change;
+
+	/* The input is near completely presorted, which makes bubble sort the
+	   best (and simplest) sort algorithm. */
+	do {
+		change = 0;
+		for (e = __start___ex_table+1; e < __stop___ex_table; e++) {
+			if (e->insn < e[-1].insn) {
+				struct exception_table_entry tmp = e[-1];
+				e[-1] = e[0];
+				e[0] = tmp;
+				change = 1;
+			}
+		}
+	} while (change != 0);
+	return 0;
+}
diff -u linux-34/arch/i386/kernel/setup.c-o linux-34/arch/i386/kernel/setup.c
--- linux-34/arch/i386/kernel/setup.c-o	2004-01-09 09:27:09.000000000 +0100
+++ linux-34/arch/i386/kernel/setup.c	2004-01-15 08:39:30.438199152 +0100
@@ -119,6 +119,7 @@
 extern void generic_apic_probe(char *);
 extern int root_mountflags;
 extern char _end[];
+extern int check_extable(void);
 
 unsigned long saved_videomode;
 
@@ -1114,6 +1115,8 @@
 #endif
 	paging_init();
 
+	check_extable();
+
 	dmi_scan_machine();
 
 #ifdef CONFIG_X86_GENERICARCH
