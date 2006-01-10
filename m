Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932506AbWAJSPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932506AbWAJSPn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 13:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbWAJSPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 13:15:42 -0500
Received: from master.soleranetworks.com ([67.137.28.188]:16535 "EHLO
	master.soleranetworks.com") by vger.kernel.org with ESMTP
	id S932506AbWAJSPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 13:15:42 -0500
Message-ID: <43C3E142.1080206@wolfmountaingroup.com>
Date: Tue, 10 Jan 2006 09:30:58 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bernd Eckenfels <be-news06@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Re: 2G memory split
References: <E1EwNc8-00063F-00@calista.inka.de>
In-Reply-To: <E1EwNc8-00063F-00@calista.inka.de>
Content-Type: multipart/mixed;
 boundary="------------070705020608000904060100"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070705020608000904060100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Bernd Eckenfels wrote:


Here are the patches I use for the splitting.  They work well.    The 
methods employed in Red Hat ES are far better and I am surprised
no one has simply integrated those patches into the kernel which are 4GB 
/ 4GB  kernel/user. 

Jeff

>Mark Lord <lkml@rtr.ca> wrote:
>  
>
>>So, the patch would now look like this:
>>    
>>
>
>can we please state something what the 3G_OPT is suppsoed to do? Is this "optimzed for 1GB Real RAM"? Should this be something like "2.5G" instead?
>
>  
>
>>+       config VMSPLIT_3G_OPT
>>+               bool "3G/1G user/kernel split (for full 1G low memory)"
>>    
>>
>
>  
>
>>+       default 0xC0000000
>>+       default 0xB0000000 if VMSPLIT_3G_OPT
>>+       default 0x78000000 if VMSPLIT_2G
>>+       default 0x40000000 if VMSPLIT_1G
>>    
>>
>
>  
>


--------------070705020608000904060100
Content-Type: text/x-patch;
 name="linux-highmem-2.6.10-01-18-05.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-highmem-2.6.10-01-18-05.patch"

diff -Naur ./arch/i386/Kconfig ../linux-2.6.10-ds/./arch/i386/Kconfig
--- ./arch/i386/Kconfig	2004-12-24 14:34:01.000000000 -0700
+++ ../linux-2.6.10-ds/./arch/i386/Kconfig	2005-01-18 11:43:27.096386256 -0700
@@ -730,6 +730,25 @@
 	depends on HIGHMEM64G
 	default y
 
+choice
+	prompt "User address space size"
+
+config USER_3GB
+        depends on X86
+	bool "3GB User Address Space"
+	default y if (X86)
+
+config USER_2GB
+        depends on X86
+	bool "2GB User Address Space"
+
+config USER_1GB
+        depends on X86
+	bool "1GB User Address Space"
+
+endchoice
+
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
diff -Naur ./include/asm-generic/page_offset.h ../linux-2.6.10-ds/./include/asm-generic/page_offset.h
--- ./include/asm-generic/page_offset.h	1969-12-31 17:00:00.000000000 -0700
+++ ../linux-2.6.10-ds/./include/asm-generic/page_offset.h	2005-01-18 11:43:27.000000000 -0700
@@ -0,0 +1,24 @@
+
+#include <linux/config.h>
+
+#ifdef __ASSEMBLY__
+
+#if defined(CONFIG_USER_1GB)
+#define PAGE_OFFSET_RAW 0x40000000
+#elif defined(CONFIG_USER_2GB)
+#define PAGE_OFFSET_RAW 0x80000000
+#elif defined(CONFIG_USER_3GB)
+#define PAGE_OFFSET_RAW 0xC0000000
+#endif
+
+#else
+
+#if defined(CONFIG_USER_1GB)
+#define PAGE_OFFSET_RAW 0x40000000UL
+#elif defined(CONFIG_USER_2GB)
+#define PAGE_OFFSET_RAW 0x80000000UL
+#elif defined(CONFIG_USER_3GB)
+#define PAGE_OFFSET_RAW 0xC0000000UL
+#endif
+
+#endif
diff -Naur ./include/asm-generic/vmlinux.lds.h ../linux-2.6.10-ds/./include/asm-generic/vmlinux.lds.h
--- ./include/asm-generic/vmlinux.lds.h	2004-12-24 14:33:50.000000000 -0700
+++ ../linux-2.6.10-ds/./include/asm-generic/vmlinux.lds.h	2005-01-18 11:43:27.000000000 -0700
@@ -1,3 +1,6 @@
+
+#include <asm-generic/page_offset.h>
+
 #ifndef LOAD_OFFSET
 #define LOAD_OFFSET 0
 #endif
diff -Naur ./include/asm-i386/page.h ../linux-2.6.10-ds/./include/asm-i386/page.h
--- ./include/asm-i386/page.h	2004-12-24 14:34:01.000000000 -0700
+++ ../linux-2.6.10-ds/./include/asm-i386/page.h	2005-01-18 11:43:27.000000000 -0700
@@ -121,9 +121,11 @@
 #endif /* __ASSEMBLY__ */
 
 #ifdef __ASSEMBLY__
-#define __PAGE_OFFSET		(0xC0000000)
+#include <asm-generic/page_offset.h>
+#define __PAGE_OFFSET		(PAGE_OFFSET_RAW)
 #else
-#define __PAGE_OFFSET		(0xC0000000UL)
+#include <asm-generic/page_offset.h>
+#define __PAGE_OFFSET		(PAGE_OFFSET_RAW)
 #endif
 
 
diff -Naur ./mem.err ../linux-2.6.10-ds/./mem.err
--- ./mem.err	1969-12-31 17:00:00.000000000 -0700
+++ ../linux-2.6.10-ds/./mem.err	2005-01-18 11:43:27.000000000 -0700
@@ -0,0 +1,7 @@
+patching file arch/i386/Kconfig
+Hunk #1 succeeded at 730 (offset 6 lines).
+patching file include/asm-generic/page_offset.h
+patching file include/asm-generic/vmlinux.lds.h
+patching file include/asm-i386/page.h
+patching file mm/memory.c
+Hunk #1 succeeded at 120 (offset 1 line).
diff -Naur ./mm/memory.c ../linux-2.6.10-ds/./mm/memory.c
--- ./mm/memory.c	2005-01-18 11:25:26.000000000 -0700
+++ ../linux-2.6.10-ds/./mm/memory.c	2005-01-18 11:43:27.000000000 -0700
@@ -120,8 +120,7 @@
 
 static inline void free_one_pgd(struct mmu_gather *tlb, pgd_t * dir)
 {
-	int j;
-	pmd_t * pmd;
+	pmd_t *pmd, *md, *emd;
 
 	if (pgd_none(*dir))
 		return;
@@ -132,8 +131,8 @@
 	}
 	pmd = pmd_offset(dir, 0);
 	pgd_clear(dir);
-	for (j = 0; j < PTRS_PER_PMD ; j++)
-		free_one_pmd(tlb, pmd+j);
+	for (md = pmd, emd = pmd + PTRS_PER_PMD; md < emd; md++) 
+	   free_one_pmd(tlb, md);
 	pmd_free_tlb(tlb, pmd);
 }
 

--------------070705020608000904060100
Content-Type: text/x-patch;
 name="linux-highmem-split-2.6.9-10-18-04.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-highmem-split-2.6.9-10-18-04.patch"

diff -Naur ./arch/i386/Kconfig ../linux-2.6.9-mdb/./arch/i386/Kconfig
--- ./arch/i386/Kconfig	2004-10-18 15:53:22.000000000 -0600
+++ ../linux-2.6.9-mdb/./arch/i386/Kconfig	2004-10-18 11:52:51.529009552 -0600
@@ -724,6 +724,25 @@
 	depends on HIGHMEM64G
 	default y
 
+choice
+	prompt "User address space size"
+
+config USER_3GB
+        depends on X86
+	bool "3GB User Address Space"
+	default y if (X86)
+
+config USER_2GB
+        depends on X86
+	bool "2GB User Address Space"
+
+config USER_1GB
+        depends on X86
+	bool "1GB User Address Space"
+
+endchoice
+
+
 # Common NUMA Features
 config NUMA
 	bool "Numa Memory Allocation and Scheduler Support"
diff -Naur ./include/asm-generic/page_offset.h ../linux-2.6.9-mdb/./include/asm-generic/page_offset.h
--- ./include/asm-generic/page_offset.h	1969-12-31 17:00:00.000000000 -0700
+++ ../linux-2.6.9-mdb/./include/asm-generic/page_offset.h	2004-10-18 11:52:51.530009400 -0600
@@ -0,0 +1,24 @@
+
+#include <linux/config.h>
+
+#ifdef __ASSEMBLY__
+
+#if defined(CONFIG_USER_1GB)
+#define PAGE_OFFSET_RAW 0x40000000
+#elif defined(CONFIG_USER_2GB)
+#define PAGE_OFFSET_RAW 0x80000000
+#elif defined(CONFIG_USER_3GB)
+#define PAGE_OFFSET_RAW 0xC0000000
+#endif
+
+#else
+
+#if defined(CONFIG_USER_1GB)
+#define PAGE_OFFSET_RAW 0x40000000UL
+#elif defined(CONFIG_USER_2GB)
+#define PAGE_OFFSET_RAW 0x80000000UL
+#elif defined(CONFIG_USER_3GB)
+#define PAGE_OFFSET_RAW 0xC0000000UL
+#endif
+
+#endif
diff -Naur ./include/asm-generic/vmlinux.lds.h ../linux-2.6.9-mdb/./include/asm-generic/vmlinux.lds.h
--- ./include/asm-generic/vmlinux.lds.h	2004-10-18 15:53:08.000000000 -0600
+++ ../linux-2.6.9-mdb/./include/asm-generic/vmlinux.lds.h	2004-10-18 11:52:51.545007120 -0600
@@ -1,3 +1,6 @@
+
+#include <asm-generic/page_offset.h>
+
 #ifndef LOAD_OFFSET
 #define LOAD_OFFSET 0
 #endif
diff -Naur ./include/asm-i386/page.h ../linux-2.6.9-mdb/./include/asm-i386/page.h
--- ./include/asm-i386/page.h	2004-10-18 15:53:22.000000000 -0600
+++ ../linux-2.6.9-mdb/./include/asm-i386/page.h	2004-10-18 11:52:51.545007120 -0600
@@ -121,9 +121,11 @@
 #endif /* __ASSEMBLY__ */
 
 #ifdef __ASSEMBLY__
-#define __PAGE_OFFSET		(0xC0000000)
+#include <asm-generic/page_offset.h>
+#define __PAGE_OFFSET		(PAGE_OFFSET_RAW)
 #else
-#define __PAGE_OFFSET		(0xC0000000UL)
+#include <asm-generic/page_offset.h>
+#define __PAGE_OFFSET		(PAGE_OFFSET_RAW)
 #endif
 
 
diff -Naur ./mm/memory.c ../linux-2.6.9-mdb/./mm/memory.c
--- ./mm/memory.c	2004-10-18 11:46:59.000000000 -0600
+++ ../linux-2.6.9-mdb/./mm/memory.c	2004-10-18 11:52:51.547006816 -0600
@@ -119,8 +119,7 @@
 
 static inline void free_one_pgd(struct mmu_gather *tlb, pgd_t * dir)
 {
-	int j;
-	pmd_t * pmd;
+	pmd_t *pmd, *md, *emd;
 
 	if (pgd_none(*dir))
 		return;
@@ -131,8 +130,8 @@
 	}
 	pmd = pmd_offset(dir, 0);
 	pgd_clear(dir);
-	for (j = 0; j < PTRS_PER_PMD ; j++)
-		free_one_pmd(tlb, pmd+j);
+	for (md = pmd, emd = pmd + PTRS_PER_PMD; md < emd; md++) 
+	   free_one_pmd(tlb, md);
 	pmd_free_tlb(tlb, pmd);
 }
 

--------------070705020608000904060100--
