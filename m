Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265789AbUHFLff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265789AbUHFLff (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 07:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUHFLff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 07:35:35 -0400
Received: from cantor.suse.de ([195.135.220.2]:5310 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265789AbUHFLfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 07:35:30 -0400
Date: Fri, 6 Aug 2004 13:31:02 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: torvalds@osdl.org, vda@port.imtp.ilyichevsk.odessa.ua,
       gene.heskett@verizon.net, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: Possible dcache BUG
Message-Id: <20040806133102.25a7c2bf.ak@suse.de>
In-Reply-To: <20040806073739.GA6617@elte.hu>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<200408042216.12215.gene.heskett@verizon.net>
	<Pine.LNX.4.58.0408042359460.24588@ppc970.osdl.org>
	<200408051133.55359.vda@port.imtp.ilyichevsk.odessa.ua>
	<Pine.LNX.4.58.0408050913320.24588@ppc970.osdl.org>
	<20040805180634.GA26732@elte.hu>
	<Pine.LNX.4.58.0408051144520.24588@ppc970.osdl.org>
	<20040806073739.GA6617@elte.hu>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004 09:37:39 +0200
Ingo Molnar <mingo@elte.hu> wrote:


> 
> ebx is 00000008, it came in from (%esi), which is (0xc20a7b30) - that
> looks like a valid pointer.
> 
> to me this crash seems to imply prefetch.


Can you add the following patch and see if it triggers at all? 

Maybe it is just the software prefetch fault handler that is somehow buggy.
There was a change there recently to handle NX, maybe that broke something.

Also testing with prefetch disabled (see my earlier patch) may also be useful
just to see if it triggers then too.

-Andi

diff -u linux-2.6.8rc2-update/arch/i386/mm/fault.c-o linux-2.6.8rc2-update/arch/i386/mm/fault.c
--- linux-2.6.8rc2-update/arch/i386/mm/fault.c-o	2004-07-28 02:23:24.000000000 +0200
+++ linux-2.6.8rc2-update/arch/i386/mm/fault.c	2004-08-05 22:20:02.000000000 +0200
@@ -21,6 +21,7 @@
 #include <linux/vt_kern.h>		/* For unblank_screen() */
 #include <linux/highmem.h>
 #include <linux/module.h>
+#include <linux/kallsyms.h>
 
 #include <asm/system.h>
 #include <asm/uaccess.h>
@@ -185,6 +186,12 @@
 			break;
 		} 
 	}
+
+	if (prefetch) {		
+		printk("corrected prefetch fault at %lx ", addr);
+		print_symbol("eip %s\n", regs->eip);
+	} 
+
 	return prefetch;
 }
 
@@ -193,6 +200,9 @@
 {
 	if (unlikely(boot_cpu_data.x86_vendor == X86_VENDOR_AMD &&
 		     boot_cpu_data.x86 >= 6)) {
+		printk("possible prefetch fault at %lx ", addr);
+		print_symbol("eip %s\n", regs->eip);
+
 		/* Catch an obscure case of prefetch inside an NX page. */
 		if (nx_enabled && (error_code & 16))
 			return 0;




