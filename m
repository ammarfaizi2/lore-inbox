Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbVCUPUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVCUPUy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 10:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVCUPUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 10:20:53 -0500
Received: from aun.it.uu.se ([130.238.12.36]:25013 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261569AbVCUPUO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 10:20:14 -0500
Date: Mon, 21 Mar 2005 16:19:55 +0100 (MET)
Message-Id: <200503211519.j2LFJtWU021931@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org, paulus@samba.org
Subject: [PATCH][2.6.12-rc1-mm1] fix ppc64 linkage error on G5
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When 2.6.12-rc1-mm1 is configured for a ppc64/G5, so CONFIG_PPC_PSERIES
is disabled, linking of vmlinux fails with:

arch/ppc64/kernel/built-in.o(.text+0x7de0): In function `.sys_call_table32':
: undefined reference to `.ppc_rtas'
arch/ppc64/kernel/built-in.o(.text+0x8668): In function `.sys_call_table':
: undefined reference to `.ppc_rtas'
make: *** [.tmp_vmlinux1] Error 1

This is because 2.6.12-rc1-mm1 contains the apparently broken patch:

>--- linux-2.6.12-rc1/arch/ppc64/kernel/misc.S   2005-03-17 21:43:54.000000000 -0800
>+++ 25/arch/ppc64/kernel/misc.S 2005-03-21 01:07:42.000000000 -0800
>@@ -680,7 +680,7 @@ _GLOBAL(kernel_thread)
>        ld      r30,-16(r1)
>        blr
> 
>-#ifndef CONFIG_PPC_PSERIES     /* hack hack hack */
>+#ifdef CONFIG_PPC_RTAS /* hack hack hack */
> #define ppc_rtas       sys_ni_syscall
> #endif

PPC_PSERIES implies PPC_RTAS. It seems someone tried to clean up the
condition but accidentally negated it: on PSERIES the system call will
now go to sys_ni_syscall, and on !PSERIES linking will fail.

Fix: negate the condition.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.12-rc1-mm1/arch/ppc64/kernel/misc.S.~1~	2005-03-21 14:48:51.000000000 +0100
+++ linux-2.6.12-rc1-mm1/arch/ppc64/kernel/misc.S	2005-03-21 15:22:04.000000000 +0100
@@ -680,7 +680,7 @@ _GLOBAL(kernel_thread)
 	ld	r30,-16(r1)
 	blr
 
-#ifdef CONFIG_PPC_RTAS /* hack hack hack */
+#ifndef CONFIG_PPC_RTAS /* hack hack hack */
 #define ppc_rtas	sys_ni_syscall
 #endif
 
