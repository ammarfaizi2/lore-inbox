Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315472AbSIHWug>; Sun, 8 Sep 2002 18:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315483AbSIHWug>; Sun, 8 Sep 2002 18:50:36 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:26358 "EHLO
	mtvmime01.veritas.com") by vger.kernel.org with ESMTP
	id <S315472AbSIHWuf>; Sun, 8 Sep 2002 18:50:35 -0400
Date: Sun, 8 Sep 2002 23:55:58 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "H. J. Lu" <hjl@lucon.org>
cc: linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Odd problem with ACPI and i386 kernel
In-Reply-To: <20020908153539.A21352@lucon.org>
Message-ID: <Pine.LNX.4.44.0209082346340.2119-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Sep 2002, H. J. Lu wrote:
> I have a very strange problem with ACPI and i386 kernel. I built an
> i386 kernel with ACPI for RedHat installation since my new P4 machines
> needs ACPI to get IRQ. It works fine on my ASUS P4B533-E MB with Intel
> 845E chipset. However, on my Sony VAIO GRX560 which is a P4 1.6GHz
> with Intel 845 chipset, the machine will reboot as soon as the kernel
> starts to run. I tracked it down to CONFIG_X86_INVLPG. If I enable
> it, kernel will be fine. Has anyone else seen this?

Yes, I sent Marcelo the patch below on 27th Aug, it's in 2.4.20-pre5.
I sent Linus a similar patch (copied to LKML) for the 2.5 tlbflush.h,
but he didn't care for its "cpu_has_pge" test, nor did he put in its
#define cpu_has_invlpg	(boot_cpu_data.x86 > 3)
replacement: I'll resend.

CONFIG_M386 kernel running on PPro+ processor with X86_FEATURE_PGE may
set _PAGE_GLOBAL bit: then __flush_tlb_one must use invlpg instruction.

The need for this was shown by a recent HyperThreading discussion.
Marc Dietrich reported (LKML 22 Aug) that CONFIG_M386 CONFIG_SMP kernel
on P4 Xeon did not support HT: his dmesg showed acpi_tables_init failed
from bad table data due to unflushed TLB: he confirms patch fixes it.

No tears would be shed if CONFIG_M386 could not support HT, but bad TLB
is trouble.  Same CONFIG_M386 bug affects CONFIG_HIGHMEM's kmap_atomic,
and potentially dmi_scan (now using set_fixmap via bt_ioremap).  Though
it's true that none of these uses really needs _PAGE_GLOBAL bit itself.

Patch below to 2.4.20-pre4 or 2.4.20-pre4-ac2: please apply.
I'll mail Linus and Dave separately with the 2.5 version.

Hugh

--- 2.4.20-pre4/include/asm-i386/pgtable.h	Thu Aug 22 20:59:51 2002
+++ linux/include/asm-i386/pgtable.h	Fri Aug 23 00:11:39 2002
@@ -82,11 +82,19 @@
 	} while (0)
 #endif
 
-#ifndef CONFIG_X86_INVLPG
-#define __flush_tlb_one(addr) __flush_tlb()
+#define __flush_tlb_single(addr) \
+	__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
+
+#ifdef CONFIG_X86_INVLPG
+# define __flush_tlb_one(addr) __flush_tlb_single(addr)
 #else
-#define __flush_tlb_one(addr) \
-__asm__ __volatile__("invlpg %0": :"m" (*(char *) addr))
+# define __flush_tlb_one(addr)						\
+	do {								\
+		if (cpu_has_pge)					\
+			__flush_tlb_single(addr);			\
+		else							\
+			__flush_tlb();					\
+	} while (0)
 #endif
 
 /*

