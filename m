Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965096AbVINJLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965096AbVINJLP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965098AbVINJLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:11:15 -0400
Received: from colo.lackof.org ([198.49.126.79]:65488 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S965096AbVINJLO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:11:14 -0400
Date: Wed, 14 Sep 2005 03:17:22 -0600
From: Grant Grundler <grundler@parisc-linux.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Grant Grundler <grundler@parisc-linux.org>,
       Alexey Dobriyan <adobriyan@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org, willy@parisc-linux.org
Subject: Re: -git11 breaks parisc and sh even more
Message-ID: <20050914091722.GA27148@colo.lackof.org>
References: <20050913174754.GA13132@mipter.zuzino.mipt.ru> <20050913185759.GA17272@mars.ravnborg.org> <20050913203720.GA12868@mipter.zuzino.mipt.ru> <20050914074248.GA21436@colo.lackof.org> <20050914074309.GA14116@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050914074309.GA14116@elte.hu>
X-Home-Page: http://www.parisc-linux.org/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 09:43:09AM +0200, Ingo Molnar wrote:
> > If someone can give me a recipe how to access 2.6.13-git11 source 
> > tree, I should be able to unravel this and submit a tested patch in < 
> > 48h. I'm pretty sure it's just an issue of parisc being slightly 
> > behind the main tree. Ingo's patch is clearly a step in the right 
> > direction.
> 
> git snapshots dont seem to be working right now, so either you download 
> git and sync up to kernel.org, or try 2.6.14-rc1 to trigger the same 
> problem:
> 
>  http://kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.14-rc1.tar.bz2

thanks!

I already had 2.6.14-rc1 and used that to base this patch.
I *think* the appended patch will fix the problem by moving
the definition of the pa_tlb_lock into it's main user: asm/tlbflush.h.

I'm not certain because the parisc build now fails with:
  CC      arch/parisc/kernel/drivers.o
arch/parisc/kernel/drivers.c: In function 'next_dev':
arch/parisc/kernel/drivers.c:65: error: 'struct device' has no member named 'children'
arch/parisc/kernel/drivers.c:66: warning: implicit declaration of function 'list_to_dev'
...

Looks like parisc/kernel/drivers.c is out of sync with the
parisc-linux.org CVS tree. The p-l.o tree doesn't define "next_dev()"
in drivers.c. It might be obvious to willy what's up here.
ISTR he wanted to sync up tomorrow with linus again anyway.
Willy?

But I'm pretty sure this patch is the first correct step
to unraveling this original build failure.

I didn't see any other spinlocks defined in asm-parisc/system.h.
ISTR the original problem report flagged another lock and I'll
take care of it as well when it pops up again.

thanks,
grant

Signed-off-by: Grant Grundler <grundler@parisc-linux.org>


--- linux-2.6.14-rc1/arch/parisc/kernel/pci-dma.c	2005-09-12 20:12:09.000000000 -0700
+++ pa_tlb_lock-moved/arch/parisc/kernel/pci-dma.c	2005-09-14 01:21:29.000000000 -0700
@@ -26,6 +26,7 @@
 #include <linux/types.h>
 
 #include <asm/cacheflush.h>
+#include <asm/tlbflush.h>
 #include <asm/dma.h>    /* for DMA_CHUNK_SIZE */
 #include <asm/io.h>
 #include <asm/page.h>	/* get_order */
diff -urp linux-2.6.14-rc1/include/asm-parisc/system.h pa_tlb_lock-moved/include/asm-parisc/system.h
--- linux-2.6.14-rc1/include/asm-parisc/system.h	2005-09-12 20:12:09.000000000 -0700
+++ pa_tlb_lock-moved/include/asm-parisc/system.h	2005-09-14 01:25:47.000000000 -0700
@@ -165,24 +165,6 @@ static inline void set_eiem(unsigned lon
 
 #define KERNEL_START (0x10100000 - 0x1000)
 
-/* This is for the serialisation of PxTLB broadcasts.  At least on the
- * N class systems, only one PxTLB inter processor broadcast can be
- * active at any one time on the Merced bus.  This tlb purge
- * synchronisation is fairly lightweight and harmless so we activate
- * it on all SMP systems not just the N class. */
-#ifdef CONFIG_SMP
-extern spinlock_t pa_tlb_lock;
-
-#define purge_tlb_start(x) spin_lock(&pa_tlb_lock)
-#define purge_tlb_end(x) spin_unlock(&pa_tlb_lock)
-
-#else
-
-#define purge_tlb_start(x) do { } while(0)
-#define purge_tlb_end(x) do { } while (0)
-
-#endif
-
 #define arch_align_stack(x) (x)
 
 #endif
diff -urp linux-2.6.14-rc1/include/asm-parisc/tlbflush.h pa_tlb_lock-moved/include/asm-parisc/tlbflush.h
--- linux-2.6.14-rc1/include/asm-parisc/tlbflush.h	2005-09-12 20:12:09.000000000 -0700
+++ pa_tlb_lock-moved/include/asm-parisc/tlbflush.h	2005-09-14 01:26:42.000000000 -0700
@@ -45,7 +45,27 @@ static inline void flush_tlb_mm(struct m
 extern __inline__ void flush_tlb_pgtables(struct mm_struct *mm, unsigned long start, unsigned long end)
 {
 }
+
+
+/* This is for the serialisation of PxTLB broadcasts.  At least on the
+ * N class systems, only one PxTLB inter processor broadcast can be
+ * active at any one time on the Merced bus.  This tlb purge
+ * synchronisation is fairly lightweight and harmless so we activate
+ * it on all SMP systems not just the N class. */
+#ifdef CONFIG_SMP
+extern spinlock_t pa_tlb_lock;
+
+#define purge_tlb_start(x) spin_lock(&pa_tlb_lock)
+#define purge_tlb_end(x) spin_unlock(&pa_tlb_lock)
+
+#else
+
+#define purge_tlb_start(x) do { } while(0)
+#define purge_tlb_end(x) do { } while (0)
+
+#endif
  
+
 static inline void flush_tlb_page(struct vm_area_struct *vma,
 	unsigned long addr)
 {
