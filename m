Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315948AbSEGTMv>; Tue, 7 May 2002 15:12:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315949AbSEGTMt>; Tue, 7 May 2002 15:12:49 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:10019 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S315948AbSEGTMo>; Tue, 7 May 2002 15:12:44 -0400
Message-ID: <61DB42B180EAB34E9D28346C11535A783A75DF@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'Thunder from the hill'" <thunder@ngforever.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: pfn-Functionset out of order for sparc64 in current Bk tree?
Date: Tue, 7 May 2002 14:12:29 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C1F5FA.AF1089CF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C1F5FA.AF1089CF
Content-Type: text/plain;
	charset="iso-8859-1"

>  - pfn_to_page(pfn) is declared as (mem_map + (pfn)) for 
> i386. Can this 
>    apply to Sparc64 as well?
>  - pte_pfn(x) is declared as
>    ((unsigned long)(((x).pte_low >> PAGE_SHIFT)))
>    in 2-level pgtable,
>    (((x).pte_low >> PAGE_SHIFT) | ((x).pte_high << (32 - PAGE_SHIFT)))
>    in 3-level. I suppose 2-level shouldn't exactly match 
> here, how far 
>    must the 3-level version be changed in order to fit sparc64? A lot?
>  - pfn_valid(pfn) is described as ((pfn) < max_mapnr). 
> Suppose this is OK 
>    on Sparc64 either?
>  - pfn_pte(page,prot) is defined as
>    __pte(((pfn) << PAGE_SHIFT) | pgprot_val(prot))
>    How far does this go for Sparc64?
> 

I think about an hour or so ago, Tom Duffy posted some fixes to the
Sparclinux mailing list that may help you out.  I cc'd them here.  They may
help you out, I havn't looked at them yet, so YMMV.

Bruce H.

<snip>
On Sun, 2002-05-05 at 23:27, Keith Owens wrote:
> kbuild-2.5-common-2.5.14-1 and kbuild-2.5-i386-2.5.14-1 are available.
> Upgraded to kernel 2.5.14.

here is the sparc64 kbuild against core-11 and 2.5.14

you must apply the linux-2.5.14-sparc64-hacks.patch first to get sparc64
to build on 2.5.14 (even using kbuild 2.4)

0) untar linux-2.5.14.tar.bz2
1) apply linux-2.5.14-sparc64-hacks.patch
2) apply kbuild-2.5-core-11
3) apply kbuild-2.5-common-2.5.14-1
4) apply kbuild-2.5-sparc64-2.5.14-1

you should be good to go...

this patch still needs work on the asm-offsets to get it work The Right
Way (tm)

-tduffy
</snip>


------_=_NextPart_000_01C1F5FA.AF1089CF
Content-Type: application/octet-stream;
	name="linux-2.5.14-sparc64-hacks.patch"
Content-Disposition: attachment;
	filename="linux-2.5.14-sparc64-hacks.patch"

--- linux-2.5.14+kbuild-v2.1+common-1+core-11+i386-1/include/asm-sparc64/page.h	Sun May  5 20:38:01 2002
+++ linux-2.5.14+kbuild-v2.1+common-1+core-11+i386-1+sparc64-1/include/asm-sparc64/page.h	Mon May  6 11:02:04 2002
@@ -113,8 +113,17 @@
 
 #define __pa(x)			((unsigned long)(x) - PAGE_OFFSET)
 #define __va(x)			((void *)((unsigned long) (x) + PAGE_OFFSET))
+
+#if 0
 #define virt_to_page(kaddr)	(mem_map + ((__pa(kaddr)-phys_base) >> PAGE_SHIFT))
 #define VALID_PAGE(page)	((page - mem_map) < max_mapnr)
+#endif
+
+#define pfn_to_page(pfn)	(mem_map + (pfn))
+#define page_to_pfn(page)	((unsigned long)((page) - mem_map))
+#define virt_to_page(kaddr)	pfn_to_page(__pa(kaddr-phys_base) >> PAGE_SHIFT)
+#define pfn_valid(pfn)		((pfn) < max_mapnr)
+#define virt_addr_valid(kaddr)	pfn_valid(__pa(kaddr-phys_base) >> PAGE_SHIFT)
 
 #define virt_to_phys __pa
 #define phys_to_virt __va
--- linux-2.5.14+kbuild-v2.1+common-1+core-11+i386-1/arch/sparc64/kernel/ioctl32.c	Sun May  5 20:37:59 2002
+++ linux-2.5.14+kbuild-v2.1+common-1+core-11+i386-1+sparc64-1/arch/sparc64/kernel/ioctl32.c	Mon May  6 11:17:15 2002
@@ -4553,8 +4553,8 @@
 COMPATIBLE_IOCTL(HCIDEVUP)
 COMPATIBLE_IOCTL(HCIDEVDOWN)
 COMPATIBLE_IOCTL(HCIDEVRESET)
-COMPATIBLE_IOCTL(HCIRESETSTAT)
-COMPATIBLE_IOCTL(HCIGETINFO)
+/* COMPATIBLE_IOCTL(HCIRESETSTAT) */
+/* COMPATIBLE_IOCTL(HCIGETINFO) */
 COMPATIBLE_IOCTL(HCIGETDEVLIST)
 COMPATIBLE_IOCTL(HCISETRAW)
 COMPATIBLE_IOCTL(HCISETSCAN)
--- linux-2.5.14+kbuild-v2.1+common-1+core-11+i386-1/include/asm-sparc64/pgtable.h	Sun May  5 20:37:53 2002
+++ linux-2.5.14+kbuild-v2.1+common-1+core-11+i386-1+sparc64-1/include/asm-sparc64/pgtable.h	Tue May  7 09:41:53 2002
@@ -194,13 +194,22 @@
 extern struct page *mem_map_zero;
 #define ZERO_PAGE(vaddr)	(mem_map_zero)
 
+#if 0
 /* Warning: These take pointers to page structs now... */
 #define mk_pte(page, pgprot)		\
 	__pte((((page - mem_map) << PAGE_SHIFT)+phys_base) | pgprot_val(pgprot) | _PAGE_SZBITS)
+#endif
+
+#define pfn_pte(pfn, pgprot)		\
+	__pte((((pfn) << PAGE_SHIFT)+phys_base) | pgprot_val(pgprot) | _PAGE_SZBITS)
+#define mk_pte(page, pgprot)	pfn_pte(page_to_pfn(page), (pgprot))
+
 #define page_pte_prot(page, prot)	mk_pte(page, prot)
 #define page_pte(page)			page_pte_prot(page, __pgprot(0))
 
+#if 0
 #define mk_pte_phys(physpage, pgprot)	(__pte((physpage) | pgprot_val(pgprot) | _PAGE_SZBITS))
+#endif
 
 extern inline pte_t pte_modify(pte_t orig_pte, pgprot_t new_prot)
 {
@@ -246,7 +255,12 @@
 /* Permanent address of a page. */
 #define __page_address(page)	page_address(page)
 
+#if 0
 #define pte_page(x) (mem_map+(((pte_val(x)&_PAGE_PADDR)-phys_base)>>PAGE_SHIFT))
+#endif
+
+#define pte_page(x) pfn_to_page(pte_pfn(x))
+#define pte_pfn(x) (((pte_val(x)&_PAGE_PADDR)-phys_base)>>PAGE_SHIFT)
 
 /* Be very careful when you change these three, they are delicate. */
 #define pte_mkyoung(pte)	(__pte(pte_val(pte) | _PAGE_ACCESSED | _PAGE_R))

------_=_NextPart_000_01C1F5FA.AF1089CF
Content-Type: application/octet-stream;
	name="kbuild-2.5-sparc64-2.5.14-1.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="kbuild-2.5-sparc64-2.5.14-1.bz2"

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
OpO8BmnFjDkIC1B/CKtidkT8xdyRThQkEf66+AA=

------_=_NextPart_000_01C1F5FA.AF1089CF--
