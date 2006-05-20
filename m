Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964787AbWETJy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964787AbWETJy1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 May 2006 05:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbWETJy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 May 2006 05:54:27 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:57485 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964787AbWETJy1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 May 2006 05:54:27 -0400
Date: Sat, 20 May 2006 11:54:23 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, kraxel@suse.de, zach@vmware.com
Subject: Re: [patch] i386, vdso=[0|1] boot option and /proc/sys/vm/vdso_enabled
Message-ID: <20060520095423.GA660@elte.hu>
References: <1147759423.5492.102.camel@localhost.localdomain> <20060516064723.GA14121@elte.hu> <1147852189.1749.28.camel@localhost.localdomain> <20060519174303.5fd17d12.akpm@osdl.org> <20060520010303.GA17858@elte.hu> <20060519181125.5c8e109e.akpm@osdl.org> <Pine.LNX.4.64.0605191813050.10823@g5.osdl.org> <20060520085351.GA28716@elte.hu> <20060520022650.46b048f8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060520022650.46b048f8.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> >  arch/i386/kernel/sysenter.c |   21 +++++++++++++++++++++
> >  include/linux/sysctl.h      |    1 +
> >  kernel/sysctl.c             |   16 ++++++++++++++++
> >  3 files changed, 38 insertions(+)
> 
> Documentation/kernel-parameters.txt, please.

grumble. I had this done but quilt didnt pick it up.

> > +unsigned int vdso_enabled = 1;
> 
> __read_mostly.

done. New patch attached.

------
Subject: i386, vdso=[0|1] boot option and /proc/sys/vm/vdso_enabled
From: Ingo Molnar <mingo@elte.hu>

add the vdso=0 boot option and the /proc/sys/vm/vdso_enabled
sysctl, on i386. VDSO defaults to enabled.

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
 Documentation/kernel-parameters.txt |    4 ++++
 arch/i386/kernel/sysenter.c         |   21 +++++++++++++++++++++
 include/linux/sysctl.h              |    1 +
 kernel/sysctl.c                     |   16 ++++++++++++++++
 4 files changed, 42 insertions(+)

Index: linux-vdso-rand.q/Documentation/kernel-parameters.txt
===================================================================
--- linux-vdso-rand.q.orig/Documentation/kernel-parameters.txt
+++ linux-vdso-rand.q/Documentation/kernel-parameters.txt
@@ -1646,6 +1646,10 @@ running once the system is up.
 	usbhid.mousepoll=
 			[USBHID] The interval which mice are to be polled at.
 
+	vdso=		[IA-32]
+			vdso=1: enable VDSO (default)
+			vdso=0: disable VDSO mapping
+
 	video=		[FB] Frame buffer configuration
 			See Documentation/fb/modedb.txt.
 
Index: linux-vdso-rand.q/arch/i386/kernel/sysenter.c
===================================================================
--- linux-vdso-rand.q.orig/arch/i386/kernel/sysenter.c
+++ linux-vdso-rand.q/arch/i386/kernel/sysenter.c
@@ -22,6 +22,21 @@
 #include <asm/pgtable.h>
 #include <asm/unistd.h>
 
+/*
+ * Should the kernel map a VDSO page into processes and pass its
+ * address down to glibc upon exec()?
+ */
+unsigned int __read_mostly vdso_enabled = 1;
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
 
Index: linux-vdso-rand.q/include/linux/sysctl.h
===================================================================
--- linux-vdso-rand.q.orig/include/linux/sysctl.h
+++ linux-vdso-rand.q/include/linux/sysctl.h
@@ -186,6 +186,7 @@ enum
 	VM_PERCPU_PAGELIST_FRACTION=30,/* int: fraction of pages in each percpu_pagelist */
 	VM_ZONE_RECLAIM_MODE=31, /* reclaim local zone memory before going off node */
 	VM_ZONE_RECLAIM_INTERVAL=32, /* time period to wait after reclaim failure */
+	VM_VDSO_ENABLED=33,	/* map VDSO into new processes? */
 };
 
 
Index: linux-vdso-rand.q/kernel/sysctl.c
===================================================================
--- linux-vdso-rand.q.orig/kernel/sysctl.c
+++ linux-vdso-rand.q/kernel/sysctl.c
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
 
