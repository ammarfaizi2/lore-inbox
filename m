Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262529AbTIQJXb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 05:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbTIQJXa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 05:23:30 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29706 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262529AbTIQJX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 05:23:28 -0400
Date: Wed, 17 Sep 2003 10:23:25 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Make modules work in Linus' tree on ARM
Message-ID: <20030917102325.A11125@flint.arm.linux.org.uk>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20030814130810.A332@flint.arm.linux.org.uk> <Pine.LNX.4.44.0308140917350.8148-100000@home.osdl.org> <20030814173249.C332@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030814173249.C332@flint.arm.linux.org.uk>; from rmk@arm.linux.org.uk on Thu, Aug 14, 2003 at 05:32:49PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 14, 2003 at 05:32:49PM +0100, Russell King wrote:
> I was thinking afterwards about a patch to allow /proc/kcore to be
> entirely disabled and dropped out of the kernel - we already select
> between a.out and ELF.

Ok, it's been a while, but here's the patch which does this - it only
drops /proc/kcore out of the kernel for ARM.

diff -u orig/fs/Kconfig linux/fs/Kconfig
--- orig/fs/Kconfig	Tue Sep  9 23:08:10 2003
+++ linux/fs/Kconfig	Sat Aug 23 10:12:27 2003
@@ -761,6 +761,10 @@
 	  This option will enlarge your kernel by about 67 KB. Several
 	  programs depend on this, so everyone should say Y here.
 
+config PROC_KCORE
+	bool
+	default y if !ARM
+
 config DEVFS_FS
 	bool "/dev file system support (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
diff -u orig/fs/proc/Makefile linux/fs/proc/Makefile
--- orig/fs/proc/Makefile	Thu Sep  4 23:58:31 2003
+++ linux/fs/proc/Makefile	Thu Aug 14 18:27:31 2003
@@ -8,6 +8,7 @@
 proc-$(CONFIG_MMU)	:= task_mmu.o
 
 proc-y       += inode.o root.o base.o generic.o array.o \
-		kmsg.o proc_tty.o proc_misc.o kcore.o
+		kmsg.o proc_tty.o proc_misc.o
 
-proc-$(CONFIG_PROC_DEVICETREE)    += proc_devtree.o
+proc-$(CONFIG_PROC_KCORE)	+= kcore.o
+proc-$(CONFIG_PROC_DEVICETREE)	+= proc_devtree.o
diff -u orig/fs/proc/proc_misc.c linux/fs/proc/proc_misc.c
--- orig/fs/proc/proc_misc.c	Tue Sep  9 23:08:11 2003
+++ linux/fs/proc/proc_misc.c	Mon Sep  8 22:52:18 2003
@@ -685,12 +685,14 @@
 #ifdef CONFIG_MODULES
 	create_seq_entry("modules", 0, &proc_modules_operations);
 #endif
+#ifdef CONFIG_PROC_KCORE
 	proc_root_kcore = create_proc_entry("kcore", S_IRUSR, NULL);
 	if (proc_root_kcore) {
 		proc_root_kcore->proc_fops = &proc_kcore_operations;
 		proc_root_kcore->size =
 				(size_t)high_memory - PAGE_OFFSET + PAGE_SIZE;
 	}
+#endif
 	if (prof_on) {
 		entry = create_proc_entry("profile", S_IWUSR | S_IRUGO, NULL);
 		if (entry) {


-- 
Russell King (rmk@arm.linux.org.uk)	http://www.arm.linux.org.uk/personal/
Linux kernel maintainer of:
  2.6 ARM Linux   - http://www.arm.linux.org.uk/
  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
  2.6 Serial core
