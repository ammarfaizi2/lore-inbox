Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWIFXBd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWIFXBd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964941AbWIFXB1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:01:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:63435 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964890AbWIFXBC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:01:02 -0400
Date: Wed, 6 Sep 2006 15:55:12 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, gregkh@suse.de
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, dev@openvz.org,
       linux-ia64@vger.kernel.org,
       Fernando Vazquez <fernando@intellilink.co.jp>
Subject: [patch 04/37] fix compilation error on IA64
Message-ID: <20060906225512.GE15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="fix-compilation-error-on-ia64.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Fernando Vazquez <fernando@oss.ntt.co.jp>

The commit 8833ebaa3f4325820fe3338ccf6fae04f6669254 introduced a change that broke 
IA64 compilation as shown below:

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 include/asm-ia64/mman.h |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.17.11.orig/include/asm-ia64/mman.h
+++ linux-2.6.17.11/include/asm-ia64/mman.h
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
 

--
