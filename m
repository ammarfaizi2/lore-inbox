Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262383AbUKVUxZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbUKVUxZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 15:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbUKVUvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 15:51:31 -0500
Received: from jade.aracnet.com ([216.99.193.136]:7865 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S262384AbUKVUuo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 15:50:44 -0500
Date: Mon, 22 Nov 2004 12:50:22 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@osdl.org>, pbadari@us.ibm.com
cc: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm mailing list <linux-mm@kvack.org>
Subject: [PATCH] Assign PKMAP_BASE dynamically
Message-ID: <73380000.1101156622@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari hit a problem when configuring PAE off (ie CONFIG_4G) where
the pkmap area could end up overlapping the fixmap area. For some
reason, PKMAP_BASE was defined statically, which seems rather pointless,
and asking for trouble. Patch below definines it dynamically, under the
fixmap area. The ordering of the VMALLOC_RESERVE space is:

FIXADDR_TOP
			fixed_addresses
FIXADDR_START
			temp fixed addresses
FIXADDR_BOOT_START
			Persistent kmap area
PKMAP_BASE
VMALLOC_END
			Vmalloc area
VMALLOC_START
high_memory

Could you give this a spin in -mm? I've tested it on the afflicted box,
and confirmed it fixes the problem.

M.

diff -purN -X /home/mbligh/.diff.exclude /home/linux/views/linux-2.6.10-rc1-mm2/include/asm-i386/fixmap.h 2.6.10-rc1-mm2-badari/include/asm-i386/fixmap.h
--- /home/linux/views/linux-2.6.10-rc1-mm2/include/asm-i386/fixmap.h	2004-10-18 15:51:09.000000000 -0700
+++ 2.6.10-rc1-mm2-badari/include/asm-i386/fixmap.h	2004-11-22 10:24:27.000000000 -0800
@@ -109,7 +109,9 @@ extern void __set_fixmap (enum fixed_add
 #define FIXADDR_TOP	((unsigned long)__FIXADDR_TOP)
 
 #define __FIXADDR_SIZE	(__end_of_permanent_fixed_addresses << PAGE_SHIFT)
-#define FIXADDR_START	(FIXADDR_TOP - __FIXADDR_SIZE)
+#define __FIXADDR_BOOT_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
+#define FIXADDR_START		(FIXADDR_TOP - __FIXADDR_SIZE)
+#define FIXADDR_BOOT_START	(FIXADDR_TOP - __FIXADDR_BOOT_SIZE)
 
 #define __fix_to_virt(x)	(FIXADDR_TOP - ((x) << PAGE_SHIFT))
 #define __virt_to_fix(x)	((FIXADDR_TOP - ((x)&PAGE_MASK)) >> PAGE_SHIFT)
diff -purN -X /home/mbligh/.diff.exclude /home/linux/views/linux-2.6.10-rc1-mm2/include/asm-i386/highmem.h 2.6.10-rc1-mm2-badari/include/asm-i386/highmem.h
--- /home/linux/views/linux-2.6.10-rc1-mm2/include/asm-i386/highmem.h	2004-10-29 01:52:51.000000000 -0700
+++ 2.6.10-rc1-mm2-badari/include/asm-i386/highmem.h	2004-11-22 10:28:17.000000000 -0800
@@ -40,16 +40,27 @@ extern void kmap_init(void);
  * easily, subsequent pte tables have to be allocated in one physical
  * chunk of RAM.
  */
-#if NR_CPUS <= 32
-#define PKMAP_BASE (0xff800000UL)
-#else
-#define PKMAP_BASE (0xff600000UL)
-#endif
 #ifdef CONFIG_X86_PAE
 #define LAST_PKMAP 512
 #else
 #define LAST_PKMAP 1024
 #endif
+/*
+ * Ordering is:
+ *
+ * FIXADDR_TOP
+ * 			fixed_addresses
+ * FIXADDR_START
+ * 			temp fixed addresses
+ * FIXADDR_BOOT_START
+ * 			Persistent kmap area
+ * PKMAP_BASE
+ * VMALLOC_END
+ * 			Vmalloc area
+ * VMALLOC_START
+ * high_memory
+ */
+#define PKMAP_BASE ( (FIXADDR_BOOT_START - PAGE_SIZE*(LAST_PKMAP + 1)) & PMD_MASK )
 #define LAST_PKMAP_MASK (LAST_PKMAP-1)
 #define PKMAP_NR(virt)  ((virt-PKMAP_BASE) >> PAGE_SHIFT)
 #define PKMAP_ADDR(nr)  (PKMAP_BASE + ((nr) << PAGE_SHIFT))

