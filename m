Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750916AbWFANDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750916AbWFANDo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 09:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbWFANDo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 09:03:44 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:38108 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750916AbWFANDn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 09:03:43 -0400
Message-ID: <447EE5A4.7050201@fr.ibm.com>
Date: Thu, 01 Jun 2006 15:03:32 +0200
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>, arjan@infradead.org
Subject: Re: 2.6.17-rc5-mm2 link issues on s390
References: <20060601014806.e86b3cc0.akpm@osdl.org>
In-Reply-To: <20060601014806.e86b3cc0.akpm@osdl.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here are small link issues on s390.

  ...
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
init/built-in.o(.init.text+0x564): In function `start_kernel':
: undefined reference to `early_init_irq_lock_type'
lib/built-in.o(.text+0xaf6): In function `__iowrite64_copy':
: undefined reference to `__raw_writeq'
make: *** [.tmp_vmlinux1] Error 1


I think the early_init_irq_lock_type() undef is related to the
lock-validator patch. Shall I just :

--- 2.6.17-rc5-mm2.orig/init/main.c
+++ 2.6.17-rc5-mm2/init/main.c
@@ -473,7 +473,9 @@

        local_irq_disable();
        early_boot_irqs_off();
+#ifdef CONFIG_GENERIC_HARDIRQS
        early_init_irq_lock_type();
+#endif


too easy ... the lock-validator should be ported to s390 I guess. What are
the steps to follow ?

As for the `__iowrite64_copy', shall we :

#define writeq(b,addr) (*(volatile unsigned long *) __io_virt(addr) = (b))
#define __raw_writeq writeq

For the moment, it boots but I'd like to make sure i'm in the right
direction before sending patches. However, the following one is safe and
fixes a very small compil issue on s390 in klibc.

thanks,

C.

--
 usr/klibc/arch/s390/mmap.c |    1 +
 1 files changed, 1 insertion(+)

Index: 2.6.17-rc5-mm2/usr/klibc/arch/s390/mmap.c
===================================================================
--- 2.6.17-rc5-mm2.orig/usr/klibc/arch/s390/mmap.c
+++ 2.6.17-rc5-mm2/usr/klibc/arch/s390/mmap.c
@@ -1,5 +1,6 @@
 #include <sys/types.h>
 #include <linux/unistd.h>
+#include <errno.h>

 struct mmap_arg_struct {
        unsigned long addr;

