Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267775AbTAMDly>; Sun, 12 Jan 2003 22:41:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267782AbTAMDly>; Sun, 12 Jan 2003 22:41:54 -0500
Received: from pacific.moreton.com.au ([203.143.238.4]:53776 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id <S267775AbTAMDlw>; Sun, 12 Jan 2003 22:41:52 -0500
Message-ID: <3E223756.3010200@snapgear.com>
Date: Mon, 13 Jan 2003 13:49:42 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Rusty Russell <rusty@rustcorp.com.au>, Miles Bader <miles@gnu.org>,
       linux-kernel@vger.kernel.org, David McCullough <davidm@snapgear.com>
Subject: Re: exception tables in 2.5.55
References: <Pine.LNX.4.44.0301121921570.24605-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0301121921570.24605-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Linus Torvalds wrote:
> On Mon, 13 Jan 2003, Greg Ungerer wrote:
> 
>>Tested and working on m68knommu architecture.
> 
> 
> Why does exceptions have anything to do with no-mmu?
> 
> There are exceptions that have nothing to do with MMU's, and a no-mmu 
> architecture should still support them.  On x86, we have a number of such 
> exceptions, for example general protection stuff for wrong values for 
> special registers etc.
> 
> In other words, not applied.

Good thing I was only after comments then :-)


> Page table exceptions are just the most 
> _common_ exception type, but there's absolutely nothing in the mechanism 
> that has anything at all to do with MMU-less.
> 
> If some archtiecture happens to have an empty exception table, that's 
> fine. 

OK, heres an alternative patch that fully supports exception tables
for m68knommu (Miles you'll need to do the same for v850).

This is tested on my ColdFire targets...

Regards
Greg




diff -Naur linux-2.5.56/arch/m68knommu/mm/Makefile 
linux-2.5.56-uc0/arch/m68knommu/mm/Makefile
--- linux-2.5.56/arch/m68knommu/mm/Makefile	Sat Jan 11 06:12:25 2003
+++ linux-2.5.56-uc0/arch/m68knommu/mm/Makefile	Mon Jan 13 13:43:22 2003
@@ -2,4 +2,4 @@
  # Makefile for the linux m68knommu specific parts of the memory manager.
  #

-obj-y += init.o fault.o memory.o kmap.o
+obj-y += init.o fault.o memory.o kmap.o extable.o
diff -Naur linux-2.5.56/arch/m68knommu/mm/extable.c 
linux-2.5.56-uc0/arch/m68knommu/mm/extable.c
--- linux-2.5.56/arch/m68knommu/mm/extable.c	Thu Jan  1 10:00:00 1970
+++ linux-2.5.56-uc0/arch/m68knommu/mm/extable.c	Mon Jan 13 13:43:08 
2003@@ -0,0 +1,30 @@
+/*
+ * linux/arch/m68knommu/mm/extable.c
+ */
+
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/spinlock.h>
+#include <asm/uaccess.h>
+
+/* Simple binary search */
+const struct exception_table_entry *
+search_extable(const struct exception_table_entry *first,
+	       const struct exception_table_entry *last,
+	       unsigned long value)
+{
+        while (first <= last) {
+		const struct exception_table_entry *mid;
+		long diff;
+
+		mid = (last - first) / 2 + first;
+		diff = mid->insn - value;
+                if (diff == 0)
+                        return mid;
+                else if (diff < 0)
+                        first = mid+1;
+                else
+                        last = mid-1;
+        }
+        return NULL;
+}

------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Wizard        EMAIL:  gerg@snapgear.com
SnapGear Pty Ltd                               PHONE:    +61 7 3435 2888
825 Stanley St,                                  FAX:    +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia              WEB:   www.SnapGear.com

