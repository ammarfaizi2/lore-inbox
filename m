Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVCUQdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVCUQdZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 11:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVCUQdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 11:33:25 -0500
Received: from ozlabs.org ([203.10.76.45]:35215 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261187AbVCUQdP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 11:33:15 -0500
Date: Tue, 22 Mar 2005 03:32:59 +1100
From: Anton Blanchard <anton@samba.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: akpm@osdl.org, paulus@samba.org, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org
Subject: [PATCH] ppc64: fix linkage error on G5
Message-ID: <20050321163259.GA12509@krispykreme>
References: <200503211519.j2LFJtWU021931@harpo.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503211519.j2LFJtWU021931@harpo.it.uu.se>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> When 2.6.12-rc1-mm1 is configured for a ppc64/G5, so CONFIG_PPC_PSERIES
> is disabled, linking of vmlinux fails with:
> 
> arch/ppc64/kernel/built-in.o(.text+0x7de0): In function `.sys_call_table32':
> : undefined reference to `.ppc_rtas'
> arch/ppc64/kernel/built-in.o(.text+0x8668): In function `.sys_call_table':
> : undefined reference to `.ppc_rtas'
> make: *** [.tmp_vmlinux1] Error 1

It turns out we are trying to fix this problem twice, we may as well
remove the #define hack and use cond_syscall.

--

Move the ppc64 specific cond_syscall(ppc_rtas) into sys_ni.c so that it
takes effect. With this fixed we can remove the #define hack.

Signed-off-by: Anton Blanchard <anton@samba.org>

diff -puN arch/ppc64/kernel/misc.S~fix_ppc_rtas arch/ppc64/kernel/misc.S
--- foobar2/arch/ppc64/kernel/misc.S~fix_ppc_rtas	2005-03-22 02:41:53.819634410 +1100
+++ foobar2-anton/arch/ppc64/kernel/misc.S	2005-03-22 02:41:53.851631972 +1100
@@ -680,10 +680,6 @@ _GLOBAL(kernel_thread)
 	ld	r30,-16(r1)
 	blr
 
-#ifdef CONFIG_PPC_RTAS /* hack hack hack */
-#define ppc_rtas	sys_ni_syscall
-#endif
-
 /* Why isn't this a) automatic, b) written in 'C'? */	
 	.balign 8
 _GLOBAL(sys_call_table32)
diff -puN arch/ppc64/kernel/syscalls.c~fix_ppc_rtas arch/ppc64/kernel/syscalls.c
--- foobar2/arch/ppc64/kernel/syscalls.c~fix_ppc_rtas	2005-03-22 02:41:53.825633952 +1100
+++ foobar2-anton/arch/ppc64/kernel/syscalls.c	2005-03-22 02:41:53.852631895 +1100
@@ -256,6 +256,3 @@ void do_show_syscall_exit(unsigned long 
 {
 	printk(" -> %lx, current=%p cpu=%d\n", r3, current, smp_processor_id());
 }
-
-/* Only exists on P-series. */
-cond_syscall(ppc_rtas);
diff -puN kernel/sys_ni.c~fix_ppc_rtas kernel/sys_ni.c
--- foobar2/kernel/sys_ni.c~fix_ppc_rtas	2005-03-22 02:41:53.829633648 +1100
+++ foobar2-anton/kernel/sys_ni.c	2005-03-22 02:41:53.853631819 +1100
@@ -83,3 +83,4 @@ cond_syscall(sys_pciconfig_write);
 cond_syscall(sys_pciconfig_iobase);
 cond_syscall(sys32_ipc);
 cond_syscall(sys32_sysctl);
+cond_syscall(ppc_rtas);
