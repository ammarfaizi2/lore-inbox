Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264808AbUEEU7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264808AbUEEU7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 16:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264809AbUEEU7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 16:59:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:62394 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264808AbUEEU7H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 16:59:07 -0400
Date: Wed, 5 May 2004 13:58:34 -0700
From: Andrew Morton <akpm@osdl.org>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: akpm@zip.com.au, ak@muc.de, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2 does not build on AMD64 + essential patch is
 missing
Message-Id: <20040505135834.5edfa5b1.akpm@osdl.org>
In-Reply-To: <200405052210.18074.rjwysocki@sisk.pl>
References: <200405052210.18074.rjwysocki@sisk.pl>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"R. J. Wysocki" <rjwysocki@sisk.pl> wrote:
>
> Hi,
> 
> The 2.6.6-rc3-mm2 kernel does not buld on AMD64 w/ NUMA, it appears.  Here's 
> what the gcc says:
> 
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> arch/x86_64/ia32/built-in.o(.text+0xa164): In function `ia32_setup_arg_pages':
> : undefined reference to `mpol_set_vma_default'
> kernel/built-in.o(.text+0x9ba0): In function `do_exit':
> : undefined reference to `mpol_free'
> make: *** [.tmp_vmlinux1] Error 1

Thanks.  The below should fix it.

> (attached is the .config).  Also, IMHO, the patch:
> 
> --- include/asm-x86_64/processor.h.orig	2004-05-05 21:35:55.890656408 +0200
> +++ include/asm-x86_64/processor.h	2004-05-05 21:41:15.930003032 +0200
> @@ -20,6 +20,8 @@
>  #include <asm/mmsegment.h>
>  #include <linux/personality.h>
>  
> +#define ARCH_MIN_TASKALIGN 16
> +
>  #define TF_MASK		0x00000100
>  #define IF_MASK		0x00000200
>  #define IOPL_MASK	0x00003000
> 
> should be applied to it, so that it does not crash at init.

Are you sure?  This patch should no longer be necessary, because the
default was changed in kernel/fork.c



diff -puN arch/ia64/ia32/binfmt_elf32.c~small-numa-api-fixups-fix arch/ia64/ia32/binfmt_elf32.c
--- 25/arch/ia64/ia32/binfmt_elf32.c~small-numa-api-fixups-fix	2004-05-05 13:37:15.909719656 -0700
+++ 25-akpm/arch/ia64/ia32/binfmt_elf32.c	2004-05-05 13:37:37.615419888 -0700
@@ -14,6 +14,7 @@
 #include <linux/types.h>
 #include <linux/mm.h>
 #include <linux/security.h>
+#include <linux/mempolicy.h>
 
 #include <asm/param.h>
 #include <asm/signal.h>
diff -puN arch/ia64/kernel/perfmon.c~small-numa-api-fixups-fix arch/ia64/kernel/perfmon.c
--- 25/arch/ia64/kernel/perfmon.c~small-numa-api-fixups-fix	2004-05-05 13:37:15.926717072 -0700
+++ 25-akpm/arch/ia64/kernel/perfmon.c	2004-05-05 13:37:45.646199024 -0700
@@ -37,6 +37,7 @@
 #include <linux/pagemap.h>
 #include <linux/mount.h>
 #include <linux/version.h>
+#include <linux/mempolicy.h>
 
 #include <asm/bitops.h>
 #include <asm/errno.h>
diff -puN arch/ia64/mm/init.c~small-numa-api-fixups-fix arch/ia64/mm/init.c
--- 25/arch/ia64/mm/init.c~small-numa-api-fixups-fix	2004-05-05 13:37:15.941714792 -0700
+++ 25-akpm/arch/ia64/mm/init.c	2004-05-05 13:37:50.909398896 -0700
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/swap.h>
 #include <linux/proc_fs.h>
+#include <linux/mempolicy.h>
 
 #include <asm/a.out.h>
 #include <asm/bitops.h>
diff -puN kernel/exit.c~small-numa-api-fixups-fix kernel/exit.c
--- 25/kernel/exit.c~small-numa-api-fixups-fix	2004-05-05 13:37:15.957712360 -0700
+++ 25-akpm/kernel/exit.c	2004-05-05 13:37:55.420713072 -0700
@@ -22,6 +22,7 @@
 #include <linux/profile.h>
 #include <linux/mount.h>
 #include <linux/proc_fs.h>
+#include <linux/mempolicy.h>
 
 #include <asm/uaccess.h>
 #include <asm/pgtable.h>

_

