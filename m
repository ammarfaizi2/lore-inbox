Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262941AbVDBAYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262941AbVDBAYU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 19:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbVDBARI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 19:17:08 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:49405 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262963AbVDAXzW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:55:22 -0500
Message-ID: <424DDF5F.9080909@mvista.com>
Date: Fri, 01 Apr 2005 15:55:11 -0800
From: Frank Rowand <frowand@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, frowand@mvista.com
Subject: Re: [PATCH 0/5] ppc RT: Realtime preempt support for PPC
References: <422CCC1D.1050902@mvista.com> <20050316100914.GA16012@elte.hu> <423F691E.200@mvista.com> <424B542F.9090308@mvista.com> <20050331091614.GB22397@elte.hu>
In-Reply-To: <20050331091614.GB22397@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Frank Rowand <frowand@mvista.com> wrote:
> 
> 
>>< more stuff deleted >
>>
>>I'm working on the architecture support for realtime on PPC64 now. If 
>>the lock field of struct raw_rwlock_t is a long instead of int then 
>>/proc/meminfo shows MemFree decreasing from 485608 kB to 485352 kB.
>>
>>Do you have a preference for lock to be long instead of int?
>>
>>Do you know if any of the other 64 bit architectures would have an 
>>issue with int?
> 
> 
> that would be nice to know. I have no preference, other than if possible 
> it should be unified, no #ifdefs or other conditionals.
> 
> 	Ingo

I looked at all the architectures and found that the disparity of the
type of the "lock" field in struct rwlock_t is even larger than I had
indicated in my earlier email.  I am attaching a proof of concept patch
to handle this.  If this looks like a good method to you then I will
create a real patch against your current patch, and include i386,
mips, x86_64, and ppc.


Index: linux-2.6.10/include/linux/rt_lock.h
===================================================================
--- linux-2.6.10.orig/include/linux/rt_lock.h
+++ linux-2.6.10/include/linux/rt_lock.h
@@ -37,8 +37,9 @@ typedef struct {
   * but only one writer.
   */
  #ifdef CONFIG_SMP
+#include <asm/raw_spinlock.h>
  typedef struct {
-       volatile unsigned long lock;
+       ARCH_RAW_RWLOCK_LOCK
  # ifdef CONFIG_DEBUG_SPINLOCK
         unsigned magic;
  # endif
Index: linux-2.6.10/include/asm-ppc/raw_spinlock.h
===================================================================
--- /dev/null
+++ linux-2.6.10/include/asm-ppc/raw_spinlock.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_RAW_SPINLOCK_H
+#define __ASM_RAW_SPINLOCK_H
+
+#define ARCH_RAW_RWLOCK_LOCK volatile signed int lock;
+
+#endif /* __ASM_RAW_SPINLOCK_H */
Index: linux-2.6.10/include/asm-i386/raw_spinlock.h
===================================================================
--- /dev/null
+++ linux-2.6.10/include/asm-i386/raw_spinlock.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_RAW_SPINLOCK_H
+#define __ASM_RAW_SPINLOCK_H
+
+#define ARCH_RAW_RWLOCK_LOCK volatile unsigned int lock;
+
+#endif /* __ASM_RAW_SPINLOCK_H */




For the curious, the implementations of the "lock" field are listed
below:


rwlock_t lock implemented as a spinlock field and a counter field

    include/asm-parisc/spinlock.h
    include/asm-sh/spinlock.h

rwlock_t lock implemented as a 31 bit counter field and a 1 bit write lock field
    include/asm-ia64/spinlock.h

rwlock_t lock implemented as a 1 bit write lock field and a 31 bit counter field
    include/asm-alpha/spinlock.h

rwlock_t lock implemented as an unsigned int field

    include/asm-arm/spinlock.h
    include/asm-i386/spinlock.h
    include/asm-mips/spinlock.h
    include/asm-x86_64/spinlock.h
    include/asm-sparc/spinlock.h
    include/asm-sparc64/spinlock.h #ifdef CONFIG_DEBUG_SPINLOCK

rwlock_t lock implemented as a signed int field

    include/asm-m32r/spinlock.h
    include/asm-ppc64/spinlock.h
    include/asm-ppc/spinlock.h

rwlock_t lock implemented as an unsigned long field

    include/asm-s390/spinlock.h

rwlock_t lock implemented as an unsigned int (_not_ in a structure)

    include/asm-sparc64/spinlock.h #ifdef CONFIG_DEBUG_SPINLOCK

SMP rwlock_t not supported (no SMP support)

    include/asm-arm26/spinlock.h
    include/asm-frv/spinlock.h
    include/asm-h8300/spinlock.h
    include/asm-m68knommu/spinlock.h
    include/asm-m68k/spinlock.h
    include/asm-sh64/spinlock.h


-Frank
-- 
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc

