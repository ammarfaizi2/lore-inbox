Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030460AbWARXkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030460AbWARXkh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 18:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030461AbWARXkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 18:40:37 -0500
Received: from liaag2aa.mx.compuserve.com ([149.174.40.154]:24811 "EHLO
	liaag2aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030460AbWARXkg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 18:40:36 -0500
Date: Wed, 18 Jan 2006 18:35:08 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.16-rc1] i386: print kernel version in register
  dumps
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Akinobu Mita <mita@miraclelinux.com>, Andi Kleen <ak@suse.de>
Message-ID: <200601181837_MC3-1-B629-329F@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Show first field of kernel version in register dumps like x86_64 does.

Changes output from e.g.:
	(2.6.16-rc1)
to:
	(2.6.16-rc1 #12)

Signed-Off-By: Chuck Ebbert <76306.1226@compuserve.com>

--- 2.6.15a.orig/arch/i386/kernel/process.c
+++ 2.6.15a/arch/i386/kernel/process.c
@@ -296,8 +296,10 @@ void show_regs(struct pt_regs * regs)
 
 	if (user_mode(regs))
 		printk(" ESP: %04x:%08lx",0xffff & regs->xss,regs->esp);
-	printk(" EFLAGS: %08lx    %s  (%s)\n",
-	       regs->eflags, print_tainted(), system_utsname.release);
+	printk(" EFLAGS: %08lx    %s  (%s %.*s)\n",
+	       regs->eflags, print_tainted(), system_utsname.release,
+	       (int)strcspn(system_utsname.version, " "),
+	       system_utsname.version);
 	printk("EAX: %08lx EBX: %08lx ECX: %08lx EDX: %08lx\n",
 		regs->eax,regs->ebx,regs->ecx,regs->edx);
 	printk("ESI: %08lx EDI: %08lx EBP: %08lx",
--- 2.6.15a.orig/arch/i386/kernel/traps.c
+++ 2.6.15a/arch/i386/kernel/traps.c
@@ -260,9 +260,11 @@ void show_registers(struct pt_regs *regs
 	}
 	print_modules();
 	printk(KERN_EMERG "CPU:    %d\nEIP:    %04x:[<%08lx>]    %s VLI\n"
-			"EFLAGS: %08lx   (%s) \n",
+			"EFLAGS: %08lx   (%s %.*s) \n",
 		smp_processor_id(), 0xffff & regs->xcs, regs->eip,
-		print_tainted(), regs->eflags, system_utsname.release);
+		print_tainted(), regs->eflags, system_utsname.release,
+		(int)strcspn(system_utsname.version, " "),
+		system_utsname.version);
 	print_symbol(KERN_EMERG "EIP is at %s\n", regs->eip);
 	printk(KERN_EMERG "eax: %08lx   ebx: %08lx   ecx: %08lx   edx: %08lx\n",
 		regs->eax, regs->ebx, regs->ecx, regs->edx);
_
