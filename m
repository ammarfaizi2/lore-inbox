Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWETIxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWETIxz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 04:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbWETIxz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 04:53:55 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:21977 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751409AbWETIxy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 04:53:54 -0400
Date: Sat, 20 May 2006 10:53:51 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       kraxel@suse.de, zach@vmware.com
Subject: [patch] i386, vdso=[0|1] boot option and /proc/sys/vm/vdso_enabled
Message-ID: <20060520085351.GA28716@elte.hu>
References: <1147759423.5492.102.camel@localhost.localdomain> <20060516064723.GA14121@elte.hu> <1147852189.1749.28.camel@localhost.localdomain> <20060519174303.5fd17d12.akpm@osdl.org> <20060520010303.GA17858@elte.hu> <20060519181125.5c8e109e.akpm@osdl.org> <Pine.LNX.4.64.0605191813050.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605191813050.10823@g5.osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@osdl.org> wrote:

> > Well that patch took a machine from working to non-working.  Pretty serious
> > stuff.  We should get to the bottom of the problem so we can assess the
> > risk and impact, no?
> 
> Yes. And it would be good to have a way to turn it off - either 
> globally of by some per-process setup (eg off by default, but turn on 
> when doing some magic).
> 
> The per-process one would be the harder one, because it would require 
> the fixmap entry, but not globally. So I suspect the only practical 
> thing would be to have it be a kernel boot-time option.

below is a patch that adds the vdso=0 boot option from exec-shield and 
the /proc/sys/vm/vdso_enabled per-system sysctl.

Andrew, could you try this - do newly started processes work fine if you 
re-enable the vdso after booting with vdso=0? That could tell us whether 
it's an init bug or a glibc bug.

	Ingo

--------
Subject: i386, vdso=[0|1] boot option and /proc/sys/vm/vdso_enabled
From: Ingo Molnar <mingo@elte.hu>

add the vdso=0 boot option and the /proc/sys/vm/vdso_enabled sysctl, on 
i386. VDSO defaults to enabled. The runtime switch works fine for newly 
started processes [it does not impact existing process images]:

 # cat /proc/self/maps | grep vdso
 b7f42000-b7f43000 r-xp b7f42000 00:00 0          [vdso]
 # echo 0 > /proc/sys/vm/vdso_enabled
 # cat /proc/self/maps | grep vdso
 # echo 1 > /proc/sys/vm/vdso_enabled
 # cat /proc/self/maps | grep vdso
 b7f05000-b7f06000 r-xp b7f05000 00:00 0          [vdso]
 #

Signed-off-by: Ingo Molnar <mingo@elte.hu>

---
 arch/i386/kernel/sysenter.c |   21 +++++++++++++++++++++
 include/linux/sysctl.h      |    1 +
 kernel/sysctl.c             |   16 ++++++++++++++++
 3 files changed, 38 insertions(+)

Index: linux/arch/i386/kernel/sysenter.c
===================================================================
--- linux.orig/arch/i386/kernel/sysenter.c
+++ linux/arch/i386/kernel/sysenter.c
@@ -22,6 +22,21 @@
 #include <asm/pgtable.h>
 #include <asm/unistd.h>
 
+/*
+ * Should the kernel map a VDSO page into processes and pass its
+ * address down to glibc upon exec()?
+ */
+unsigned int vdso_enabled = 1;
+
+static int __init vdso_setup(char *s)
+{
+	vdso_enabled = simple_strtoul(s, NULL, 0);
+
+	return 1;
+}
+
+__setup("vdso=", vdso_setup);
+
 extern asmlinkage void sysenter_entry(void);
 
 void enable_sep_cpu(void)
@@ -97,6 +112,9 @@ int arch_setup_additional_pages(struct l
 	unsigned long addr;
 	int ret;
 
+	if (unlikely(!vdso_enabled))
+		return 0;
+
 	down_write(&mm->mmap_sem);
 	addr = get_unmapped_area(NULL, 0, PAGE_SIZE, 0, 0);
 	if (IS_ERR_VALUE(addr)) {
@@ -122,16 +140,19 @@ int arch_setup_additional_pages(struct l
 	ret = insert_vm_struct(mm, vma);
 	if (ret)
 		goto free_vma;
+
 	current->mm->context.vdso = (void *)addr;
 	current_thread_info()->sysenter_return = SYSENTER_RETURN_OFFSET + addr;
 	mm->total_vm++;
 	up_write(&mm->mmap_sem);
+
 	return 0;
 
 free_vma:
 	kmem_cache_free(vm_area_cachep, vma);
 up_fail:
 	up_write(&mm->mmap_sem);
+
 	return ret;
 }
 
Index: linux/include/linux/sysctl.h
===================================================================
--- linux.orig/include/linux/sysctl.h
+++ linux/include/linux/sysctl.h
@@ -186,6 +186,7 @@ enum
 	VM_PERCPU_PAGELIST_FRACTION=30,/* int: fraction of pages in each percpu_pagelist */
 	VM_ZONE_RECLAIM_MODE=31, /* reclaim local zone memory before going off node */
 	VM_ZONE_RECLAIM_INTERVAL=32, /* time period to wait after reclaim failure */
+	VM_VDSO_ENABLED=33,	/* map VDSO into new processes? */
 };
 
 
Index: linux/kernel/sysctl.c
===================================================================
--- linux.orig/kernel/sysctl.c
+++ linux/kernel/sysctl.c
@@ -158,6 +158,10 @@ extern ctl_table inotify_table[];
 int sysctl_legacy_va_layout;
 #endif
 
+#ifdef CONFIG_X86_32
+extern int vdso_enabled;
+#endif
+
 /* /proc declarations: */
 
 #ifdef CONFIG_PROC_FS
@@ -915,6 +919,18 @@ static ctl_table vm_table[] = {
 		.strategy	= &sysctl_jiffies,
 	},
 #endif
+#ifdef CONFIG_X86_32
+	{
+		.ctl_name	= VM_VDSO_ENABLED,
+		.procname	= "vdso_enabled",
+		.data		= &vdso_enabled,
+		.maxlen		= sizeof(vdso_enabled),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+		.strategy	= &sysctl_intvec,
+		.extra1		= &zero,
+	},
+#endif
 	{ .ctl_name = 0 }
 };
 
