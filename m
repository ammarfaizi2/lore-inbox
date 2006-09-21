Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751562AbWIUVHm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbWIUVHm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 17:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbWIUVHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 17:07:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7362 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751560AbWIUVHl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 17:07:41 -0400
Subject: Re: 2.6.18-rc7-mm1
From: Mark Haverkamp <markh@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <20060919012848.4482666d.akpm@osdl.org>
References: <20060919012848.4482666d.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 21 Sep 2006 14:07:33 -0700
Message-Id: <1158872854.7064.22.camel@markh3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-19 at 01:28 -0700, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc7/2.6.18-rc7-mm1/
> 

> 
> +rename-the-provided-execve-functions-to-kernel_execve-headers-fix.patch
> 
>  Fix rename-the-provided-execve-functions-to-kernel_execve.patch some more
> 

While running cross compile tests for prpmc750 we got the following
error that I think is related to the above patches.


  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      vmlinux
init/built-in.o: In function `run_init_process':
main.c:(.text+0x20): undefined reference to `kernel_execve'
init/built-in.o: In function `do_linuxrc':
do_mounts_initrd.c:(.init.text+0x3a98): undefined reference to `kernel_execve'
arch/ppc/kernel/built-in.o: In function `execve':
arch/ppc/kernel/entry.S:(.text+0x24a2): undefined reference to `errno'
arch/ppc/kernel/entry.S:(.text+0x24a6): undefined reference to `errno'
kernel/built-in.o: In function `____call_usermodehelper':
kmod.c:(.text+0x163f8): undefined reference to `kernel_execve'
make: [vmlinux] Error 1 (ignored)
  SYSMAP  System.map
powerpc-750-linux-gnu-nm: 'vmlinux': No such file
make: [vmlinux] Error 1 (ignored)
  MODPOST vmlinux


Here is a patch that fixes the compile errors.  I took the code from
misc_32.S.  

Signed-off-by: Mark Haverkamp <markh@osdl.org>

---

--- linux-2.6.17.orig/arch/ppc/kernel/misc.S	2006-09-21 08:43:08.000000000 -0700
+++ linux-2.6.17/arch/ppc/kernel/misc.S	2006-09-21 12:48:56.000000000 -0700
@@ -1030,20 +1030,16 @@
 	addi	r1,r1,16
 	blr
 
+_GLOBAL(kernel_execve)
+	li	r0,__NR_execve
+	sc
+	bnslr
+	neg	r3,r3
+	blr
+
 /*
  * This routine is just here to keep GCC happy - sigh...
  */
 _GLOBAL(__main)
 	blr
 
-#define SYSCALL(name) \
-_GLOBAL(name) \
-	li	r0,__NR_##name; \
-	sc; \
-	bnslr; \
-	lis	r4,errno@ha; \
-	stw	r3,errno@l(r4); \
-	li	r3,-1; \
-	blr
-
-SYSCALL(execve)

-- 
Mark Haverkamp <markh@osdl.org>

