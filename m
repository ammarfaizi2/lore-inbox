Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbUARXHA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 18:07:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264261AbUARXHA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 18:07:00 -0500
Received: from colin2.muc.de ([193.149.48.15]:53261 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264258AbUARXG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 18:06:57 -0500
Date: 19 Jan 2004 00:07:43 +0100
Date: Mon, 19 Jan 2004 00:07:43 +0100
From: Andi Kleen <ak@colin2.muc.de>
To: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>, jh@suse.cz,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Add noinline attribute - new extable sort patch
Message-ID: <20040118230743.GA12989@colin2.muc.de>
References: <20040114083114.GA1784@averell> <Pine.LNX.4.58.0401141519260.4500@evo.osdl.org> <20040115074834.GA38796@colin2.muc.de> <Pine.LNX.4.58.0401151448200.2597@evo.osdl.org> <20040116101345.GA96037@colin2.muc.de> <20040118204700.GA31601@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040118204700.GA31601@twiddle.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 18, 2004 at 12:47:00PM -0800, Richard Henderson wrote:
> On Fri, Jan 16, 2004 at 11:13:45AM +0100, Andi Kleen wrote:
> > Ok, here is a new patch that does the whole thing in generic code and for
> > modules too. I didn't bother to change the sort algorithm because the 
> > existing one works well enough.
> 
> One, you've still got the function marked __init.
> 
> Two, the format of struct exception_table_entry is arch specific.
> That comparison won't work on Alpha, because "insn" is encoded 
> pc-relative.

I looked at it more closely now. Alpha (and IA64 which uses the same
format) would be relatively easy to do. But sparc and sparc64 have a
very strange different format which would be too complicated to handle.

I withdraw the patch that does the sort in init/main.c. Instead just
let's do it in arch/i386 like in the original patch
Also it doesn't do it for modules because there are no __init sections
there (avoids some ifdefs) 

Andrew, please replace the previous patch with that one.

Thanks,

-Andi


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
