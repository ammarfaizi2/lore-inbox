Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751365AbVIHOcL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbVIHOcL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 10:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751367AbVIHOcK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 10:32:10 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:47195
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1751365AbVIHOcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 10:32:09 -0400
Message-Id: <432067CC0200007800024416@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 16:33:16 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] boot-time ioremap alternative
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartFCDE92BC.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartFCDE92BC.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

An alternative to (on i386) boot-time ioremap approaches, which is
more
architecture independent (though arch dependent code needs adjustments
if this is to be made use of, which with this patch only happens for
i386 and x86_64) and doesn't require alternative boot-time interfaces.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/arch/i386/kernel/setup.c
2.6.13-early-ioremap/arch/i386/kernel/setup.c
--- 2.6.13/arch/i386/kernel/setup.c	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-early-ioremap/arch/i386/kernel/setup.c	2005-09-01
13:58:18.000000000 +0200
@@ -1119,6 +1119,9 @@ static unsigned long __init setup_memory
 	}
 	printk(KERN_NOTICE "%ldMB HIGHMEM available.\n",
 		pages_to_mb(highend_pfn - highstart_pfn));
+	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
+#else
+	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
 #endif
 	printk(KERN_NOTICE "%ldMB LOWMEM available.\n",
 			pages_to_mb(max_low_pfn));
diff -Npru 2.6.13/arch/i386/mm/init.c
2.6.13-early-ioremap/arch/i386/mm/init.c
--- 2.6.13/arch/i386/mm/init.c	2005-08-29 01:41:01.000000000 +0200
+++ 2.6.13-early-ioremap/arch/i386/mm/init.c	2005-09-01
13:58:34.000000000 +0200
@@ -559,12 +559,6 @@ void __init mem_init(void)
  
 	set_max_mapnr_init();
 
-#ifdef CONFIG_HIGHMEM
-	high_memory = (void *) __va(highstart_pfn * PAGE_SIZE - 1) + 1;
-#else
-	high_memory = (void *) __va(max_low_pfn * PAGE_SIZE - 1) + 1;
-#endif
-
 	/* this will put all low memory onto the freelists */
 	totalram_pages += free_all_bootmem();
 
diff -Npru 2.6.13/arch/i386/mm/ioremap.c
2.6.13-early-ioremap/arch/i386/mm/ioremap.c
--- 2.6.13/arch/i386/mm/ioremap.c	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-early-ioremap/arch/i386/mm/ioremap.c	2005-09-01
14:00:53.000000000 +0200
@@ -257,7 +257,8 @@ void iounmap(volatile void __iomem *addr
 	} 
 out_unlock:
 	write_unlock(&vmlist_lock);
-	kfree(p); 
+	if (p)
+		free_vm_area(p);
 }
 EXPORT_SYMBOL(iounmap);
 
diff -Npru 2.6.13/arch/i386/mm/pgtable.c
2.6.13-early-ioremap/arch/i386/mm/pgtable.c
--- 2.6.13/arch/i386/mm/pgtable.c	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-early-ioremap/arch/i386/mm/pgtable.c	2005-09-01
11:32:11.000000000 +0200
@@ -11,6 +11,7 @@
 #include <linux/smp.h>
 #include <linux/highmem.h>
 #include <linux/slab.h>
+#include <linux/bootmem.h>
 #include <linux/pagemap.h>
 #include <linux/spinlock.h>
 
@@ -148,7 +149,9 @@ void __set_fixmap (enum fixed_addresses 
 
 pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long
address)
 {
-	return (pte_t
*)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
+	if (likely(totalram_pages))
+		return (pte_t
*)__get_free_page(GFP_KERNEL|__GFP_REPEAT|__GFP_ZERO);
+	return alloc_bootmem_pages(PAGE_SIZE);
 }
 
 struct page *pte_alloc_one(struct mm_struct *mm, unsigned long
address)
diff -Npru 2.6.13/arch/x86_64/kernel/setup.c
2.6.13-early-ioremap/arch/x86_64/kernel/setup.c
--- 2.6.13/arch/x86_64/kernel/setup.c	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-early-ioremap/arch/x86_64/kernel/setup.c	2005-09-01
15:34:02.000000000 +0200
@@ -561,6 +561,7 @@ void __init setup_arch(char **cmdline_p)
 	 * we are rounding upwards:
 	 */
 	end_pfn = e820_end_of_ram();
+	high_memory = (void *)__va(end_pfn * PAGE_SIZE - 1) + 1;
 
 	check_efer();
 
diff -Npru 2.6.13/arch/x86_64/mm/init.c
2.6.13-early-ioremap/arch/x86_64/mm/init.c
--- 2.6.13/arch/x86_64/mm/init.c	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-early-ioremap/arch/x86_64/mm/init.c	2005-09-01
11:32:11.000000000 +0200
@@ -427,7 +427,6 @@ void __init mem_init(void)
 	max_low_pfn = end_pfn;
 	max_pfn = end_pfn;
 	num_physpages = end_pfn;
-	high_memory = (void *) __va(end_pfn * PAGE_SIZE);
 
 	/* clear the zero-page */
 	memset(empty_zero_page, 0, PAGE_SIZE);
diff -Npru 2.6.13/arch/x86_64/mm/ioremap.c
2.6.13-early-ioremap/arch/x86_64/mm/ioremap.c
--- 2.6.13/arch/x86_64/mm/ioremap.c	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-early-ioremap/arch/x86_64/mm/ioremap.c	2005-09-01
16:47:08.000000000 +0200
@@ -266,5 +266,6 @@ void iounmap(volatile void __iomem *addr
 	else if (p->flags >> 20)
 		ioremap_change_attr(p->phys_addr, p->size, 0);
 	write_unlock(&vmlist_lock);
-	kfree(p); 
+	if(p)
+		free_vm_area(p);
 }
diff -Npru 2.6.13/include/linux/vmalloc.h
2.6.13-early-ioremap/include/linux/vmalloc.h
--- 2.6.13/include/linux/vmalloc.h	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-early-ioremap/include/linux/vmalloc.h	2005-09-01
17:47:16.000000000 +0200
@@ -8,6 +8,7 @@
 #define VM_IOREMAP	0x00000001	/* ioremap() and friends */
 #define VM_ALLOC	0x00000002	/* vmalloc() */
 #define VM_MAP		0x00000004	/* vmap()ed pages */
+#define VM_BOOTMEM	0x00000008	/* allocated from bootmem */
 /* bits [20..32] reserved for arch specific ioremap internals */
 
 struct vm_struct {
@@ -42,6 +43,7 @@ extern struct vm_struct *__get_vm_area(u
 					unsigned long start, unsigned
long end);
 extern struct vm_struct *remove_vm_area(void *addr);
 extern struct vm_struct *__remove_vm_area(void *addr);
+extern void free_vm_area(struct vm_struct *area);
 extern int map_vm_area(struct vm_struct *area, pgprot_t prot,
 			struct page ***pages);
 extern void unmap_vm_area(struct vm_struct *area);
diff -Npru 2.6.13/mm/page_alloc.c 2.6.13-early-ioremap/mm/page_alloc.c
--- 2.6.13/mm/page_alloc.c	2005-08-29 01:41:01.000000000 +0200
+++ 2.6.13-early-ioremap/mm/page_alloc.c	2005-09-02
10:02:41.000000000 +0200
@@ -987,6 +987,15 @@ fastcall unsigned long get_zeroed_page(u
 {
 	struct page * page;
 
+	if (unlikely(!totalram_pages)) {
+		/* This exists solely for page table allocation; pages
+		   allocated this way must never be freed! */
+		void *address = alloc_bootmem_pages(PAGE_SIZE);
+
+		clear_page(address);
+		return (unsigned long) address;
+	}
+
 	/*
 	 * get_zeroed_page() returns a 32-bit address, which cannot
represent
 	 * a highmem page
diff -Npru 2.6.13/mm/vmalloc.c 2.6.13-early-ioremap/mm/vmalloc.c
--- 2.6.13/mm/vmalloc.c	2005-08-29 01:41:01.000000000 +0200
+++ 2.6.13-early-ioremap/mm/vmalloc.c	2005-09-02 10:09:12.000000000
+0200
@@ -11,6 +11,7 @@
 #include <linux/module.h>
 #include <linux/highmem.h>
 #include <linux/slab.h>
+#include <linux/bootmem.h>
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
 
@@ -179,20 +180,24 @@ struct vm_struct *__get_vm_area(unsigned
 	}
 	addr = ALIGN(start, align);
 	size = PAGE_ALIGN(size);
-
-	area = kmalloc(sizeof(*area), GFP_KERNEL);
-	if (unlikely(!area))
-		return NULL;
-
-	if (unlikely(!size)) {
-		kfree (area);
+	if (unlikely(!size))
 		return NULL;
-	}
-
 	/*
 	 * We always allocate a guard page.
 	 */
 	size += PAGE_SIZE;
+	if (unlikely(!size))
+		return NULL;
+
+	BUG_ON(flags & VM_BOOTMEM);
+	if (likely(malloc_sizes->cs_cachep))
+		area = kmalloc(sizeof(*area), GFP_KERNEL);
+	else {
+		area = alloc_bootmem(sizeof(*area));
+		flags |= VM_BOOTMEM;
+	}
+	if (unlikely(!area))
+		return NULL;
 
 	write_lock(&vmlist_lock);
 	for (p = &vmlist; (tmp = *p) != NULL ;p = &tmp->next) {
@@ -227,7 +232,7 @@ found:
 
 out:
 	write_unlock(&vmlist_lock);
-	kfree(area);
+	free_vm_area(area);
 	if (printk_ratelimit())
 		printk(KERN_WARNING "allocation failed: out of vmalloc
space - use vmalloc=<size> to increase size.\n");
 	return NULL;
@@ -288,6 +293,14 @@ struct vm_struct *remove_vm_area(void *a
 	return v;
 }
 
+void free_vm_area(struct vm_struct *area)
+{
+	if (likely(!(area->flags & VM_BOOTMEM)))
+		kfree(area);
+	else if (!malloc_sizes->cs_cachep)
+		free_bootmem(virt_to_phys(area), sizeof(*area));
+}
+
 void __vunmap(void *addr, int deallocate_pages)
 {
 	struct vm_struct *area;
@@ -324,7 +337,7 @@ void __vunmap(void *addr, int deallocate
 			kfree(area->pages);
 	}
 
-	kfree(area);
+	free_vm_area(area);
 	return;
 }
 
@@ -413,7 +426,7 @@ void *__vmalloc_area(struct vm_struct *a
 	area->pages = pages;
 	if (!area->pages) {
 		remove_vm_area(area->addr);
-		kfree(area);
+		free_vm_area(area);
 		return NULL;
 	}
 	memset(area->pages, 0, array_size);


--=__PartFCDE92BC.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-early-ioremap.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-early-ioremap.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCkFuIGFsdGVybmF0aXZlIHRvIChvbiBpMzg2
KSBib290LXRpbWUgaW9yZW1hcCBhcHByb2FjaGVzLCB3aGljaCBpcyBtb3JlCmFyY2hpdGVjdHVy
ZSBpbmRlcGVuZGVudCAodGhvdWdoIGFyY2ggZGVwZW5kZW50IGNvZGUgbmVlZHMgYWRqdXN0bWVu
dHMKaWYgdGhpcyBpcyB0byBiZSBtYWRlIHVzZSBvZiwgd2hpY2ggd2l0aCB0aGlzIHBhdGNoIG9u
bHkgaGFwcGVucyBmb3IKaTM4NiBhbmQgeDg2XzY0KSBhbmQgZG9lc24ndCByZXF1aXJlIGFsdGVy
bmF0aXZlIGJvb3QtdGltZSBpbnRlcmZhY2VzLgoKU2lnbmVkLW9mZi1ieTogSmFuIEJldWxpY2gg
PGpiZXVsaWNoQG5vdmVsbC5jb20+CgpkaWZmIC1OcHJ1IDIuNi4xMy9hcmNoL2kzODYva2VybmVs
L3NldHVwLmMgMi42LjEzLWVhcmx5LWlvcmVtYXAvYXJjaC9pMzg2L2tlcm5lbC9zZXR1cC5jCi0t
LSAyLjYuMTMvYXJjaC9pMzg2L2tlcm5lbC9zZXR1cC5jCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAw
MDAwMDAwICswMjAwCisrKyAyLjYuMTMtZWFybHktaW9yZW1hcC9hcmNoL2kzODYva2VybmVsL3Nl
dHVwLmMJMjAwNS0wOS0wMSAxMzo1ODoxOC4wMDAwMDAwMDAgKzAyMDAKQEAgLTExMTksNiArMTEx
OSw5IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIF9faW5pdCBzZXR1cF9tZW1vcnkKIAl9CiAJcHJp
bnRrKEtFUk5fTk9USUNFICIlbGRNQiBISUdITUVNIGF2YWlsYWJsZS5cbiIsCiAJCXBhZ2VzX3Rv
X21iKGhpZ2hlbmRfcGZuIC0gaGlnaHN0YXJ0X3BmbikpOworCWhpZ2hfbWVtb3J5ID0gKHZvaWQg
KikgX192YShoaWdoc3RhcnRfcGZuICogUEFHRV9TSVpFIC0gMSkgKyAxOworI2Vsc2UKKwloaWdo
X21lbW9yeSA9ICh2b2lkICopIF9fdmEobWF4X2xvd19wZm4gKiBQQUdFX1NJWkUgLSAxKSArIDE7
CiAjZW5kaWYKIAlwcmludGsoS0VSTl9OT1RJQ0UgIiVsZE1CIExPV01FTSBhdmFpbGFibGUuXG4i
LAogCQkJcGFnZXNfdG9fbWIobWF4X2xvd19wZm4pKTsKZGlmZiAtTnBydSAyLjYuMTMvYXJjaC9p
Mzg2L21tL2luaXQuYyAyLjYuMTMtZWFybHktaW9yZW1hcC9hcmNoL2kzODYvbW0vaW5pdC5jCi0t
LSAyLjYuMTMvYXJjaC9pMzg2L21tL2luaXQuYwkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAw
MCArMDIwMAorKysgMi42LjEzLWVhcmx5LWlvcmVtYXAvYXJjaC9pMzg2L21tL2luaXQuYwkyMDA1
LTA5LTAxIDEzOjU4OjM0LjAwMDAwMDAwMCArMDIwMApAQCAtNTU5LDEyICs1NTksNiBAQCB2b2lk
IF9faW5pdCBtZW1faW5pdCh2b2lkKQogIAogCXNldF9tYXhfbWFwbnJfaW5pdCgpOwogCi0jaWZk
ZWYgQ09ORklHX0hJR0hNRU0KLQloaWdoX21lbW9yeSA9ICh2b2lkICopIF9fdmEoaGlnaHN0YXJ0
X3BmbiAqIFBBR0VfU0laRSAtIDEpICsgMTsKLSNlbHNlCi0JaGlnaF9tZW1vcnkgPSAodm9pZCAq
KSBfX3ZhKG1heF9sb3dfcGZuICogUEFHRV9TSVpFIC0gMSkgKyAxOwotI2VuZGlmCi0KIAkvKiB0
aGlzIHdpbGwgcHV0IGFsbCBsb3cgbWVtb3J5IG9udG8gdGhlIGZyZWVsaXN0cyAqLwogCXRvdGFs
cmFtX3BhZ2VzICs9IGZyZWVfYWxsX2Jvb3RtZW0oKTsKIApkaWZmIC1OcHJ1IDIuNi4xMy9hcmNo
L2kzODYvbW0vaW9yZW1hcC5jIDIuNi4xMy1lYXJseS1pb3JlbWFwL2FyY2gvaTM4Ni9tbS9pb3Jl
bWFwLmMKLS0tIDIuNi4xMy9hcmNoL2kzODYvbW0vaW9yZW1hcC5jCTIwMDUtMDgtMjkgMDE6NDE6
MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMtZWFybHktaW9yZW1hcC9hcmNoL2kzODYvbW0v
aW9yZW1hcC5jCTIwMDUtMDktMDEgMTQ6MDA6NTMuMDAwMDAwMDAwICswMjAwCkBAIC0yNTcsNyAr
MjU3LDggQEAgdm9pZCBpb3VubWFwKHZvbGF0aWxlIHZvaWQgX19pb21lbSAqYWRkcgogCX0gCiBv
dXRfdW5sb2NrOgogCXdyaXRlX3VubG9jaygmdm1saXN0X2xvY2spOwotCWtmcmVlKHApOyAKKwlp
ZiAocCkKKwkJZnJlZV92bV9hcmVhKHApOwogfQogRVhQT1JUX1NZTUJPTChpb3VubWFwKTsKIApk
aWZmIC1OcHJ1IDIuNi4xMy9hcmNoL2kzODYvbW0vcGd0YWJsZS5jIDIuNi4xMy1lYXJseS1pb3Jl
bWFwL2FyY2gvaTM4Ni9tbS9wZ3RhYmxlLmMKLS0tIDIuNi4xMy9hcmNoL2kzODYvbW0vcGd0YWJs
ZS5jCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMtZWFybHkt
aW9yZW1hcC9hcmNoL2kzODYvbW0vcGd0YWJsZS5jCTIwMDUtMDktMDEgMTE6MzI6MTEuMDAwMDAw
MDAwICswMjAwCkBAIC0xMSw2ICsxMSw3IEBACiAjaW5jbHVkZSA8bGludXgvc21wLmg+CiAjaW5j
bHVkZSA8bGludXgvaGlnaG1lbS5oPgogI2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4KKyNpbmNsdWRl
IDxsaW51eC9ib290bWVtLmg+CiAjaW5jbHVkZSA8bGludXgvcGFnZW1hcC5oPgogI2luY2x1ZGUg
PGxpbnV4L3NwaW5sb2NrLmg+CiAKQEAgLTE0OCw3ICsxNDksOSBAQCB2b2lkIF9fc2V0X2ZpeG1h
cCAoZW51bSBmaXhlZF9hZGRyZXNzZXMgCiAKIHB0ZV90ICpwdGVfYWxsb2Nfb25lX2tlcm5lbChz
dHJ1Y3QgbW1fc3RydWN0ICptbSwgdW5zaWduZWQgbG9uZyBhZGRyZXNzKQogewotCXJldHVybiAo
cHRlX3QgKilfX2dldF9mcmVlX3BhZ2UoR0ZQX0tFUk5FTHxfX0dGUF9SRVBFQVR8X19HRlBfWkVS
Tyk7CisJaWYgKGxpa2VseSh0b3RhbHJhbV9wYWdlcykpCisJCXJldHVybiAocHRlX3QgKilfX2dl
dF9mcmVlX3BhZ2UoR0ZQX0tFUk5FTHxfX0dGUF9SRVBFQVR8X19HRlBfWkVSTyk7CisJcmV0dXJu
IGFsbG9jX2Jvb3RtZW1fcGFnZXMoUEFHRV9TSVpFKTsKIH0KIAogc3RydWN0IHBhZ2UgKnB0ZV9h
bGxvY19vbmUoc3RydWN0IG1tX3N0cnVjdCAqbW0sIHVuc2lnbmVkIGxvbmcgYWRkcmVzcykKZGlm
ZiAtTnBydSAyLjYuMTMvYXJjaC94ODZfNjQva2VybmVsL3NldHVwLmMgMi42LjEzLWVhcmx5LWlv
cmVtYXAvYXJjaC94ODZfNjQva2VybmVsL3NldHVwLmMKLS0tIDIuNi4xMy9hcmNoL3g4Nl82NC9r
ZXJuZWwvc2V0dXAuYwkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42
LjEzLWVhcmx5LWlvcmVtYXAvYXJjaC94ODZfNjQva2VybmVsL3NldHVwLmMJMjAwNS0wOS0wMSAx
NTozNDowMi4wMDAwMDAwMDAgKzAyMDAKQEAgLTU2MSw2ICs1NjEsNyBAQCB2b2lkIF9faW5pdCBz
ZXR1cF9hcmNoKGNoYXIgKipjbWRsaW5lX3ApCiAJICogd2UgYXJlIHJvdW5kaW5nIHVwd2FyZHM6
CiAJICovCiAJZW5kX3BmbiA9IGU4MjBfZW5kX29mX3JhbSgpOworCWhpZ2hfbWVtb3J5ID0gKHZv
aWQgKilfX3ZhKGVuZF9wZm4gKiBQQUdFX1NJWkUgLSAxKSArIDE7CiAKIAljaGVja19lZmVyKCk7
CiAKZGlmZiAtTnBydSAyLjYuMTMvYXJjaC94ODZfNjQvbW0vaW5pdC5jIDIuNi4xMy1lYXJseS1p
b3JlbWFwL2FyY2gveDg2XzY0L21tL2luaXQuYwotLS0gMi42LjEzL2FyY2gveDg2XzY0L21tL2lu
aXQuYwkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLWVhcmx5
LWlvcmVtYXAvYXJjaC94ODZfNjQvbW0vaW5pdC5jCTIwMDUtMDktMDEgMTE6MzI6MTEuMDAwMDAw
MDAwICswMjAwCkBAIC00MjcsNyArNDI3LDYgQEAgdm9pZCBfX2luaXQgbWVtX2luaXQodm9pZCkK
IAltYXhfbG93X3BmbiA9IGVuZF9wZm47CiAJbWF4X3BmbiA9IGVuZF9wZm47CiAJbnVtX3BoeXNw
YWdlcyA9IGVuZF9wZm47Ci0JaGlnaF9tZW1vcnkgPSAodm9pZCAqKSBfX3ZhKGVuZF9wZm4gKiBQ
QUdFX1NJWkUpOwogCiAJLyogY2xlYXIgdGhlIHplcm8tcGFnZSAqLwogCW1lbXNldChlbXB0eV96
ZXJvX3BhZ2UsIDAsIFBBR0VfU0laRSk7CmRpZmYgLU5wcnUgMi42LjEzL2FyY2gveDg2XzY0L21t
L2lvcmVtYXAuYyAyLjYuMTMtZWFybHktaW9yZW1hcC9hcmNoL3g4Nl82NC9tbS9pb3JlbWFwLmMK
LS0tIDIuNi4xMy9hcmNoL3g4Nl82NC9tbS9pb3JlbWFwLmMJMjAwNS0wOC0yOSAwMTo0MTowMS4w
MDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xMy1lYXJseS1pb3JlbWFwL2FyY2gveDg2XzY0L21tL2lv
cmVtYXAuYwkyMDA1LTA5LTAxIDE2OjQ3OjA4LjAwMDAwMDAwMCArMDIwMApAQCAtMjY2LDUgKzI2
Niw2IEBAIHZvaWQgaW91bm1hcCh2b2xhdGlsZSB2b2lkIF9faW9tZW0gKmFkZHIKIAllbHNlIGlm
IChwLT5mbGFncyA+PiAyMCkKIAkJaW9yZW1hcF9jaGFuZ2VfYXR0cihwLT5waHlzX2FkZHIsIHAt
PnNpemUsIDApOwogCXdyaXRlX3VubG9jaygmdm1saXN0X2xvY2spOwotCWtmcmVlKHApOyAKKwlp
ZihwKQorCQlmcmVlX3ZtX2FyZWEocCk7CiB9CmRpZmYgLU5wcnUgMi42LjEzL2luY2x1ZGUvbGlu
dXgvdm1hbGxvYy5oIDIuNi4xMy1lYXJseS1pb3JlbWFwL2luY2x1ZGUvbGludXgvdm1hbGxvYy5o
Ci0tLSAyLjYuMTMvaW5jbHVkZS9saW51eC92bWFsbG9jLmgJMjAwNS0wOC0yOSAwMTo0MTowMS4w
MDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xMy1lYXJseS1pb3JlbWFwL2luY2x1ZGUvbGludXgvdm1h
bGxvYy5oCTIwMDUtMDktMDEgMTc6NDc6MTYuMDAwMDAwMDAwICswMjAwCkBAIC04LDYgKzgsNyBA
QAogI2RlZmluZSBWTV9JT1JFTUFQCTB4MDAwMDAwMDEJLyogaW9yZW1hcCgpIGFuZCBmcmllbmRz
ICovCiAjZGVmaW5lIFZNX0FMTE9DCTB4MDAwMDAwMDIJLyogdm1hbGxvYygpICovCiAjZGVmaW5l
IFZNX01BUAkJMHgwMDAwMDAwNAkvKiB2bWFwKCllZCBwYWdlcyAqLworI2RlZmluZSBWTV9CT09U
TUVNCTB4MDAwMDAwMDgJLyogYWxsb2NhdGVkIGZyb20gYm9vdG1lbSAqLwogLyogYml0cyBbMjAu
LjMyXSByZXNlcnZlZCBmb3IgYXJjaCBzcGVjaWZpYyBpb3JlbWFwIGludGVybmFscyAqLwogCiBz
dHJ1Y3Qgdm1fc3RydWN0IHsKQEAgLTQyLDYgKzQzLDcgQEAgZXh0ZXJuIHN0cnVjdCB2bV9zdHJ1
Y3QgKl9fZ2V0X3ZtX2FyZWEodQogCQkJCQl1bnNpZ25lZCBsb25nIHN0YXJ0LCB1bnNpZ25lZCBs
b25nIGVuZCk7CiBleHRlcm4gc3RydWN0IHZtX3N0cnVjdCAqcmVtb3ZlX3ZtX2FyZWEodm9pZCAq
YWRkcik7CiBleHRlcm4gc3RydWN0IHZtX3N0cnVjdCAqX19yZW1vdmVfdm1fYXJlYSh2b2lkICph
ZGRyKTsKK2V4dGVybiB2b2lkIGZyZWVfdm1fYXJlYShzdHJ1Y3Qgdm1fc3RydWN0ICphcmVhKTsK
IGV4dGVybiBpbnQgbWFwX3ZtX2FyZWEoc3RydWN0IHZtX3N0cnVjdCAqYXJlYSwgcGdwcm90X3Qg
cHJvdCwKIAkJCXN0cnVjdCBwYWdlICoqKnBhZ2VzKTsKIGV4dGVybiB2b2lkIHVubWFwX3ZtX2Fy
ZWEoc3RydWN0IHZtX3N0cnVjdCAqYXJlYSk7CmRpZmYgLU5wcnUgMi42LjEzL21tL3BhZ2VfYWxs
b2MuYyAyLjYuMTMtZWFybHktaW9yZW1hcC9tbS9wYWdlX2FsbG9jLmMKLS0tIDIuNi4xMy9tbS9w
YWdlX2FsbG9jLmMJMjAwNS0wOC0yOSAwMTo0MTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4x
My1lYXJseS1pb3JlbWFwL21tL3BhZ2VfYWxsb2MuYwkyMDA1LTA5LTAyIDEwOjAyOjQxLjAwMDAw
MDAwMCArMDIwMApAQCAtOTg3LDYgKzk4NywxNSBAQCBmYXN0Y2FsbCB1bnNpZ25lZCBsb25nIGdl
dF96ZXJvZWRfcGFnZSh1CiB7CiAJc3RydWN0IHBhZ2UgKiBwYWdlOwogCisJaWYgKHVubGlrZWx5
KCF0b3RhbHJhbV9wYWdlcykpIHsKKwkJLyogVGhpcyBleGlzdHMgc29sZWx5IGZvciBwYWdlIHRh
YmxlIGFsbG9jYXRpb247IHBhZ2VzCisJCSAgIGFsbG9jYXRlZCB0aGlzIHdheSBtdXN0IG5ldmVy
IGJlIGZyZWVkISAqLworCQl2b2lkICphZGRyZXNzID0gYWxsb2NfYm9vdG1lbV9wYWdlcyhQQUdF
X1NJWkUpOworCisJCWNsZWFyX3BhZ2UoYWRkcmVzcyk7CisJCXJldHVybiAodW5zaWduZWQgbG9u
ZykgYWRkcmVzczsKKwl9CisKIAkvKgogCSAqIGdldF96ZXJvZWRfcGFnZSgpIHJldHVybnMgYSAz
Mi1iaXQgYWRkcmVzcywgd2hpY2ggY2Fubm90IHJlcHJlc2VudAogCSAqIGEgaGlnaG1lbSBwYWdl
CmRpZmYgLU5wcnUgMi42LjEzL21tL3ZtYWxsb2MuYyAyLjYuMTMtZWFybHktaW9yZW1hcC9tbS92
bWFsbG9jLmMKLS0tIDIuNi4xMy9tbS92bWFsbG9jLmMJMjAwNS0wOC0yOSAwMTo0MTowMS4wMDAw
MDAwMDAgKzAyMDAKKysrIDIuNi4xMy1lYXJseS1pb3JlbWFwL21tL3ZtYWxsb2MuYwkyMDA1LTA5
LTAyIDEwOjA5OjEyLjAwMDAwMDAwMCArMDIwMApAQCAtMTEsNiArMTEsNyBAQAogI2luY2x1ZGUg
PGxpbnV4L21vZHVsZS5oPgogI2luY2x1ZGUgPGxpbnV4L2hpZ2htZW0uaD4KICNpbmNsdWRlIDxs
aW51eC9zbGFiLmg+CisjaW5jbHVkZSA8bGludXgvYm9vdG1lbS5oPgogI2luY2x1ZGUgPGxpbnV4
L3NwaW5sb2NrLmg+CiAjaW5jbHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CiAKQEAgLTE3OSwyMCAr
MTgwLDI0IEBAIHN0cnVjdCB2bV9zdHJ1Y3QgKl9fZ2V0X3ZtX2FyZWEodW5zaWduZWQKIAl9CiAJ
YWRkciA9IEFMSUdOKHN0YXJ0LCBhbGlnbik7CiAJc2l6ZSA9IFBBR0VfQUxJR04oc2l6ZSk7Ci0K
LQlhcmVhID0ga21hbGxvYyhzaXplb2YoKmFyZWEpLCBHRlBfS0VSTkVMKTsKLQlpZiAodW5saWtl
bHkoIWFyZWEpKQotCQlyZXR1cm4gTlVMTDsKLQotCWlmICh1bmxpa2VseSghc2l6ZSkpIHsKLQkJ
a2ZyZWUgKGFyZWEpOworCWlmICh1bmxpa2VseSghc2l6ZSkpCiAJCXJldHVybiBOVUxMOwotCX0K
LQogCS8qCiAJICogV2UgYWx3YXlzIGFsbG9jYXRlIGEgZ3VhcmQgcGFnZS4KIAkgKi8KIAlzaXpl
ICs9IFBBR0VfU0laRTsKKwlpZiAodW5saWtlbHkoIXNpemUpKQorCQlyZXR1cm4gTlVMTDsKKwor
CUJVR19PTihmbGFncyAmIFZNX0JPT1RNRU0pOworCWlmIChsaWtlbHkobWFsbG9jX3NpemVzLT5j
c19jYWNoZXApKQorCQlhcmVhID0ga21hbGxvYyhzaXplb2YoKmFyZWEpLCBHRlBfS0VSTkVMKTsK
KwllbHNlIHsKKwkJYXJlYSA9IGFsbG9jX2Jvb3RtZW0oc2l6ZW9mKCphcmVhKSk7CisJCWZsYWdz
IHw9IFZNX0JPT1RNRU07CisJfQorCWlmICh1bmxpa2VseSghYXJlYSkpCisJCXJldHVybiBOVUxM
OwogCiAJd3JpdGVfbG9jaygmdm1saXN0X2xvY2spOwogCWZvciAocCA9ICZ2bWxpc3Q7ICh0bXAg
PSAqcCkgIT0gTlVMTCA7cCA9ICZ0bXAtPm5leHQpIHsKQEAgLTIyNyw3ICsyMzIsNyBAQCBmb3Vu
ZDoKIAogb3V0OgogCXdyaXRlX3VubG9jaygmdm1saXN0X2xvY2spOwotCWtmcmVlKGFyZWEpOwor
CWZyZWVfdm1fYXJlYShhcmVhKTsKIAlpZiAocHJpbnRrX3JhdGVsaW1pdCgpKQogCQlwcmludGso
S0VSTl9XQVJOSU5HICJhbGxvY2F0aW9uIGZhaWxlZDogb3V0IG9mIHZtYWxsb2Mgc3BhY2UgLSB1
c2Ugdm1hbGxvYz08c2l6ZT4gdG8gaW5jcmVhc2Ugc2l6ZS5cbiIpOwogCXJldHVybiBOVUxMOwpA
QCAtMjg4LDYgKzI5MywxNCBAQCBzdHJ1Y3Qgdm1fc3RydWN0ICpyZW1vdmVfdm1fYXJlYSh2b2lk
ICphCiAJcmV0dXJuIHY7CiB9CiAKK3ZvaWQgZnJlZV92bV9hcmVhKHN0cnVjdCB2bV9zdHJ1Y3Qg
KmFyZWEpCit7CisJaWYgKGxpa2VseSghKGFyZWEtPmZsYWdzICYgVk1fQk9PVE1FTSkpKQorCQlr
ZnJlZShhcmVhKTsKKwllbHNlIGlmICghbWFsbG9jX3NpemVzLT5jc19jYWNoZXApCisJCWZyZWVf
Ym9vdG1lbSh2aXJ0X3RvX3BoeXMoYXJlYSksIHNpemVvZigqYXJlYSkpOworfQorCiB2b2lkIF9f
dnVubWFwKHZvaWQgKmFkZHIsIGludCBkZWFsbG9jYXRlX3BhZ2VzKQogewogCXN0cnVjdCB2bV9z
dHJ1Y3QgKmFyZWE7CkBAIC0zMjQsNyArMzM3LDcgQEAgdm9pZCBfX3Z1bm1hcCh2b2lkICphZGRy
LCBpbnQgZGVhbGxvY2F0ZQogCQkJa2ZyZWUoYXJlYS0+cGFnZXMpOwogCX0KIAotCWtmcmVlKGFy
ZWEpOworCWZyZWVfdm1fYXJlYShhcmVhKTsKIAlyZXR1cm47CiB9CiAKQEAgLTQxMyw3ICs0MjYs
NyBAQCB2b2lkICpfX3ZtYWxsb2NfYXJlYShzdHJ1Y3Qgdm1fc3RydWN0ICphCiAJYXJlYS0+cGFn
ZXMgPSBwYWdlczsKIAlpZiAoIWFyZWEtPnBhZ2VzKSB7CiAJCXJlbW92ZV92bV9hcmVhKGFyZWEt
PmFkZHIpOwotCQlrZnJlZShhcmVhKTsKKwkJZnJlZV92bV9hcmVhKGFyZWEpOwogCQlyZXR1cm4g
TlVMTDsKIAl9CiAJbWVtc2V0KGFyZWEtPnBhZ2VzLCAwLCBhcnJheV9zaXplKTsK

--=__PartFCDE92BC.0__=--
