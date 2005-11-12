Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbVKLQfE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbVKLQfE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 11:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbVKLQfE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 11:35:04 -0500
Received: from everest.sosdg.org ([66.93.203.161]:53146 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S932411AbVKLQfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 11:35:03 -0500
Date: Sat, 12 Nov 2005 11:34:55 -0500
From: Coywolf Qi Hunt <coywolf@sosdg.org>
To: akpm@osdl.org
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>, Josh Boyer <jdub@us.ibm.com>,
       akpm@osdl.org
Subject: [patch] mark text section read-only
Message-ID: <20051112163455.GA1425@everest.sosdg.org>
Reply-To: coywolf@sosdg.org
References: <20051107105624.GA6531@infradead.org> <2cd57c900511111057n3a7741ddw@mail.gmail.com> <20051111190447.GA14481@everest.sosdg.org> <200511112243.42255.ak@suse.de> <2cd57c900511120632y1e7993ber@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c900511120632y1e7993ber@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: coywolf@mail.sosdg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 12, 2005 at 10:32:34PM +0800, Coywolf Qi Hunt wrote:
> 2005/11/12, Andi Kleen <ak@suse.de>:
> > On Friday 11 November 2005 20:04, Coywolf Qi Hunt wrote:
> > > On Sat, Nov 12, 2005 at 02:57:02AM +0800, Coywolf Qi Hunt wrote:
> > > > And we could also mark text section read-only and data/stack section
> > > > noexec if NX is supported. But I doubt the whole thing would really
> > > > help much. Kill the kernel thread? We can't. We only run into a panic.
> > > > Anyway I'd attach a quick patch to mark text section read only in the
> > > > next mail.
> >
> >
> > I think this whole thing is only usable as a debugging option. It shouldn't
> > be used by default on production systems because it will increase TLB
> > pressure by splitting up the large pages used by kernel. And TLB pressure
> > is critical in many workloads.
> >
> > It definitely shouldn't be on by default.
> >
> > Then the text section will likely not be page aligned, so it would be
> > surprising if it even worked.
> 
> It works. I have tested it with { c=_stext[0]; _stext[0]=c;}. No
> effect when it's disabled; panic when it's enabled.
> 
> The symbol `_text' is always page aligned. `_etext' is not, but we don't care.
> 
> (Bugs: It would conflict with kprobes.)
> 
> >
> > At least on x86-64 it is pretty useless too because the .text section can
> > be accessed over its alias in the direct mapping.
> 
> OK, for x86 only then.
> 
> >
> > Overall I doubt it is worth it even as a debugging option. I so far cannot
> > remember a single bug that was caused by overwriting kernel text.
> 
> I had the same concern basically. But I am convinced after seeing the
> bug Nikita Danilov points out.

Mark text section read-only for debug purpose. This is paranoid, but useful to
guard on some bugs.

Signed-off-by: Coywolf Qi Hunt <qiyong@fc-cn.com>
---
 arch/i386/Kconfig.debug |    9 +++++++++
 arch/i386/mm/init.c     |   15 ++++++++++++++-
 init/main.c             |   10 +++++++++-
 3 files changed, 32 insertions(+), 2 deletions(-)

diff -pruN 2.6.14-mm2/arch/i386/Kconfig.debug 2.6.14-mm2-cy/arch/i386/Kconfig.debug
--- 2.6.14-mm2/arch/i386/Kconfig.debug	2005-11-11 22:33:28.000000000 +0800
+++ 2.6.14-mm2-cy/arch/i386/Kconfig.debug	2005-11-12 23:10:23.000000000 +0800
@@ -42,6 +42,15 @@ config DEBUG_PAGEALLOC
 	  This results in a large slowdown, but helps to find certain types
 	  of memory corruptions.
 
+config DEBUG_ROTEXT
+	bool "Write protect kernel text"
+	depends on DEBUG_KERNEL
+	help
+	  Mark the kernel text as write-protected in the pagetables,
+	  in order to catch accidental (and incorrect) writes to kernel text
+	  area. This option will increase TLB pressure thus impact performance.
+	  Note this may conflict with kprobes. If in doubt, say "N".
+
 config DEBUG_RODATA
 	bool "Write protect kernel read-only data structures"
 	depends on DEBUG_KERNEL
diff -pruN 2.6.14-mm2/arch/i386/mm/init.c 2.6.14-mm2-cy/arch/i386/mm/init.c
--- 2.6.14-mm2/arch/i386/mm/init.c	2005-11-11 22:33:29.000000000 +0800
+++ 2.6.14-mm2-cy/arch/i386/mm/init.c	2005-11-12 23:07:12.000000000 +0800
@@ -735,8 +735,21 @@ void free_initmem(void)
 	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n", (__init_end - __init_begin) >> 10);
 }
 
-#ifdef CONFIG_DEBUG_RODATA
+#ifdef CONFIG_DEBUG_ROTEXT
+void mark_text_ro(void)
+{
+	unsigned long addr = (unsigned long)&_text;
+
+	for (; addr < (unsigned long)&_etext; addr += PAGE_SIZE)
+		change_page_attr(virt_to_page(addr), 1, PAGE_KERNEL_RO);
+	
+	printk ("Write protecting the kernel text data: %luk\n",
+			(unsigned long)(_etext - _text) >> 10);
+	global_flush_tlb();
+}
+#endif
 
+#ifdef CONFIG_DEBUG_RODATA
 extern char __start_rodata, __end_rodata;
 void mark_rodata_ro(void)
 {
diff -pruN 2.6.14-mm2/init/main.c 2.6.14-mm2-cy/init/main.c
--- 2.6.14-mm2/init/main.c	2005-11-11 22:34:21.000000000 +0800
+++ 2.6.14-mm2-cy/init/main.c	2005-11-12 23:07:12.000000000 +0800
@@ -100,8 +100,15 @@ extern void acpi_early_init(void);
 #else
 static inline void acpi_early_init(void) { }
 #endif
+
+#ifdef CONFIG_DEBUG_ROTEXT
+ extern void mark_text_ro(void);
+#else
+ static inline void mark_text_ro(void) { }
+#endif
+
 #ifndef CONFIG_DEBUG_RODATA
-inline void mark_rodata_ro(void) { }
+static inline void mark_rodata_ro(void) { }
 #endif
 
 #ifdef CONFIG_TC
@@ -716,6 +723,7 @@ static int init(void * unused)
 	 */
 	free_initmem();
 	unlock_kernel();
+	mark_text_ro();
 	mark_rodata_ro();
 	system_state = SYSTEM_RUNNING;
 	numa_default_policy();
