Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422642AbWHYC42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbWHYC42 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 22:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422646AbWHYC42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 22:56:28 -0400
Received: from ns.oss.ntt.co.jp ([222.151.198.98]:24803 "EHLO
	serv1.oss.ntt.co.jp") by vger.kernel.org with ESMTP
	id S1422642AbWHYC41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 22:56:27 -0400
Subject: [PATCH] Linux 2.6.17.11 - fix compilation error on IA64 (try #2)
From: Fernando Luis =?ISO-8859-1?Q?V=E1zquez?= Cao 
	<fernando@oss.ntt.co.jp>
To: gregkh@suse.de
Cc: dev@openvz.org, xemul@openvz.org, davem@davemloft.net,
       linux-kernel@vger.kernel.org, stable@kernel.org, akpm@osdl.org,
       davidm@hpl.hp.com
In-Reply-To: <1156383636.1899.15.camel@localhost.localdomain>
References: <1156383636.1899.15.camel@localhost.localdomain>
Content-Type: text/plain
Organization: =?UTF-8?Q?NTT=E3=82=AA=E3=83=BC=E3=83=97=E3=83=B3=E3=82=BD=E3=83=BC?=
	=?UTF-8?Q?=E3=82=B9=E3=82=BD=E3=83=95=E3=83=88=E3=82=A6=E3=82=A7?=
	=?UTF-8?Q?=E3=82=A2=E3=82=BB=E3=83=B3=E3=82=BF?=
Date: Fri, 25 Aug 2006 11:56:24 +0900
Message-Id: <1156474584.2239.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I am resending this patch because I removed the "#ifdef __KERNEL__" protection in
the previous version by mistake.

---

The commit 8833ebaa3f4325820fe3338ccf6fae04f6669254 introduced a change that makes
the compilation of a IA64 kernel fail as shown below:

  gcc -Wp,-MD,arch/ia64/kernel/.entry.o.d  -nostdinc -isystem /usr/lib/gcc/ia64-linux-gnu/4.1.2/include -D__KERNEL__ -Iinclude  -include include/linux/autoconf.h -DHAVE_WORKING_TEXT_ALIGN -DHAVE_MODEL_SMALL_ATTRIBUTE -DHAVE_SERIALIZE_DIRECTIVE -D__ASSEMBLY__   -mconstant-gp -c -o arch/ia64/kernel/entry.o arch/ia64/kernel/entry.S
include/asm/mman.h: Assembler messages:
include/asm/mman.h:13: Error: Unknown opcode `int ia64_map_check_rgn(unsigned long addr,unsigned long len,'
include/asm/mman.h:14: Error: Unknown opcode `unsigned long flags)'
make[1]: *** [arch/ia64/kernel/entry.o] Error 1
make: *** [arch/ia64/kernel] Error 2

The reason is that "asm/mman.h" is being included from entry.S indirectly through
"asm/pgtable.h" (see code snips below).

* arch/ia64/kernel/entry.S:
...
#include <asm/pgtable.h>
...

* include/asm-ia64/pgtable.h:
...
#include <asm/mman.h>
...

* include/asm-ia64/mman.h
...
#ifdef __KERNEL__
#define arch_mmap_check ia64_map_check_rgn
int ia64_map_check_rgn(unsigned long addr, unsigned long len,
                unsigned long flags);
#endif
...

Signed-off-by: Fernando Vazquez <fernando@intellilink.co.jp>
---

diff -urNp linux-2.6.17.11/include/asm-ia64/mman.h linux-2.6.17.11-fix/include/asm-ia64/mman.h
--- linux-2.6.17.11/include/asm-ia64/mman.h	2006-08-25 11:36:09.000000000 +0900
+++ linux-2.6.17.11-fix/include/asm-ia64/mman.h	2006-08-25 11:39:16.000000000 +0900
@@ -9,10 +9,12 @@
  */
 
 #ifdef __KERNEL__
+#ifndef __ASSEMBLY__
 #define arch_mmap_check	ia64_map_check_rgn
 int ia64_map_check_rgn(unsigned long addr, unsigned long len,
 		unsigned long flags);
 #endif
+#endif
 
 #include <asm-generic/mman.h>
 


