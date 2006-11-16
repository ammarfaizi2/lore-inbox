Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031038AbWKPBag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031038AbWKPBag (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 20:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031041AbWKPBag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 20:30:36 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:38560 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1031038AbWKPBaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 20:30:35 -0500
Message-ID: <455BBF38.5030503@vmware.com>
Date: Wed, 15 Nov 2006 17:30:32 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org,
       "virtualization@lists.osdl.org" <virtualization@lists.osdl.org>
Subject: Re: 2.6.19-rc5-mm2: paravirt X86_PAE=y compile error
References: <20061114014125.dd315fff.akpm@osdl.org>	<20061115231626.GC31879@stusta.de> <20061115153614.a71f944d.akpm@osdl.org>
In-Reply-To: <20061115153614.a71f944d.akpm@osdl.org>
Content-Type: multipart/mixed;
 boundary="------------070201010000080000010505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070201010000080000010505
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Andrew Morton wrote:
> On Thu, 16 Nov 2006 00:16:26 +0100
> Adrian Bunk <bunk@stusta.de> wrote:
>
>   
>> Paravirt breaks CONFIG_X86_PAE=y compilation:
>>
>> <--  snip  -->
>>
>> ...
>>   CC      init/main.o
>> In file included from include2/asm/pgtable.h:245,
>>                  from 
>> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/mm.h:40,
>>                  from 
>> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/poll.h:11,
>>                  from 
>> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/rtc.h:113,
>>                  from 
>> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/include/linux/efi.h:19,
>>                  from 
>> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/init/main.c:43:
>> include2/asm/pgtable-3level.h:108: error: redefinition of 'pte_clear'
>> include2/asm/paravirt.h:365: error: previous definition of 'pte_clear' was here
>> include2/asm/pgtable-3level.h:115: error: redefinition of 'pmd_clear'
>> include2/asm/paravirt.h:370: error: previous definition of 'pmd_clear' was here
>> make[2]: *** [init/main.o] Error 1
>>
>>     
>
> So it does.  Zach will save us.
>
>   

Well that shouldn't have happened.  Must have been some reject that went 
unnoticed?  Try this.

--------------070201010000080000010505
Content-Type: text/plain;
 name="pae-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pae-fix.patch"

Save big on PAE patches, now cheaper by the dozen!
I hope this doesn't trip someone's ham filter.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.18/include/asm-i386/pgtable-3level.h
===================================================================
--- linux-2.6.18.orig/include/asm-i386/pgtable-3level.h	2006-11-10 14:49:51.000000000 -0800
+++ linux-2.6.18/include/asm-i386/pgtable-3level.h	2006-11-15 17:26:54.000000000 -0800
@@ -78,26 +78,6 @@ static inline void set_pte_present(struc
 		set_64bit((unsigned long long *)(pmdptr),pmd_val(pmdval))
 #define set_pud(pudptr,pudval) \
 		(*(pudptr) = (pudval))
-#endif
-
-/*
- * Pentium-II erratum A13: in PAE mode we explicitly have to flush
- * the TLB via cr3 if the top-level pgd is changed...
- * We do not let the generic code free and clear pgd entries due to
- * this erratum.
- */
-static inline void pud_clear (pud_t * pud) { }
-
-#define pud_page(pud) \
-((struct page *) __va(pud_val(pud) & PAGE_MASK))
-
-#define pud_page_vaddr(pud) \
-((unsigned long) __va(pud_val(pud) & PAGE_MASK))
-
-
-/* Find an entry in the second-level page table.. */
-#define pmd_offset(pud, address) ((pmd_t *) pud_page(*(pud)) + \
-			pmd_index(address))
 
 /*
  * For PTEs and PDEs, we must clear the P-bit first when clearing a page table
@@ -118,6 +98,26 @@ static inline void pmd_clear(pmd_t *pmd)
 	smp_wmb();
 	*(tmp + 1) = 0;
 }
+#endif
+
+/*
+ * Pentium-II erratum A13: in PAE mode we explicitly have to flush
+ * the TLB via cr3 if the top-level pgd is changed...
+ * We do not let the generic code free and clear pgd entries due to
+ * this erratum.
+ */
+static inline void pud_clear (pud_t * pud) { }
+
+#define pud_page(pud) \
+((struct page *) __va(pud_val(pud) & PAGE_MASK))
+
+#define pud_page_vaddr(pud) \
+((unsigned long) __va(pud_val(pud) & PAGE_MASK))
+
+
+/* Find an entry in the second-level page table.. */
+#define pmd_offset(pud, address) ((pmd_t *) pud_page(*(pud)) + \
+			pmd_index(address))
 
 #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
 static inline pte_t ptep_get_and_clear(struct mm_struct *mm, unsigned long addr, pte_t *ptep)

--------------070201010000080000010505--
