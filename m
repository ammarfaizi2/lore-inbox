Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263861AbTEOH6z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 03:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263865AbTEOH6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 03:58:55 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:18818
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S263861AbTEOH6y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 03:58:54 -0400
Date: Thu, 15 May 2003 04:02:31 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Linux Kernel <linux-kernel@vger.kernel.org>
cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Subject: [PATCH][2.5] VMWare doesn't like sysenter
Message-ID: <Pine.LNX.4.50.0305150400550.19782-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get a monitor error in VMWare4 with a sysenter syscall enabled kernel, 
this patch simply disables sysenter based syscalls but doesn't clear the 
SEP bit in the capabilities.

Index: linux-2.5.69-mm5/arch/i386/kernel/sysenter.c
===================================================================
RCS file: /build/cvsroot/linux-2.5.69/arch/i386/kernel/sysenter.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 sysenter.c
--- linux-2.5.69-mm5/arch/i386/kernel/sysenter.c	6 May 2003 12:20:51 -0000	1.1.1.1
+++ linux-2.5.69-mm5/arch/i386/kernel/sysenter.c	15 May 2003 07:46:05 -0000
@@ -20,6 +20,7 @@
 #include <asm/unistd.h>
 
 extern asmlinkage void sysenter_entry(void);
+static int nosysenter __initdata;
 
 /*
  * Create a per-cpu fake "SEP thread" stack, so that we can
@@ -51,6 +52,13 @@ void enable_sep_cpu(void *info)
 	put_cpu();	
 }
 
+static int __init do_nosysenter(char *s)
+{
+	nosysenter = 1;
+	return 1;
+}
+__setup("nosysenter", do_nosysenter);
+
 /*
  * These symbols are defined by vsyscall.o to mark the bounds
  * of the ELF DSO images included therein.
@@ -64,7 +72,7 @@ static int __init sysenter_setup(void)
 
 	__set_fixmap(FIX_VSYSCALL, __pa(page), PAGE_READONLY);
 
-	if (!boot_cpu_has(X86_FEATURE_SEP)) {
+	if (nosysenter || !boot_cpu_has(X86_FEATURE_SEP)) {
 		memcpy((void *) page,
 		       &vsyscall_int80_start,
 		       &vsyscall_int80_end - &vsyscall_int80_start);

-- 
function.linuxpower.ca
