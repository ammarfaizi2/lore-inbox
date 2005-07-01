Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262317AbVGAUiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262317AbVGAUiT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbVGAUiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:38:18 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:321 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S262317AbVGAUde (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:33:34 -0400
X-IronPort-AV: i="3.94,159,1118034000"; 
   d="scan'208"; a="261248989:sNHT47990656"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C57E7C.2645D68A"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: page allocation/attributes question (i386/x86_64 specific)
Date: Fri, 1 Jul 2005 15:33:33 -0500
Message-ID: <B1939BC11A23AE47A0DBE89A37CB26B4074359@ausx3mps305.aus.amer.dell.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: page allocation/attributes question (i386/x86_64 specific)
Thread-Index: AcV9jvboLnykyAOORAS/GMIhlJZYBQABJtZgAAB8XiAAORqqUA==
From: <Stuart_Hayes@Dell.com>
To: <ak@suse.de>
Cc: <riel@redhat.com>, <andrea@suse.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 01 Jul 2005 20:33:33.0930 (UTC) FILETIME=[26A4B4A0:01C57E7C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C57E7C.2645D68A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

>=20
> So, if I understand correctly what's going on in x86_64, your fix
> wouldn't be applicable to i386.  In x86_64, every large page has a
> correct "ref_prot" that is the normal setting for that page... but in
> i386, the kernel text area does not--it should ideally be split into
> small pages all the time if there are both kernel code & free pages
> residing in the same 2M area.    =20
>=20
> Stuart

(This isn't a submission--I'm just posting this for comments.)

Right now, any large page that touches anywhere from PAGE_OFFSET to
__init_end is initially set up as a large, executable page... but some
of this area contains data & free pages.  The patch below adds a
"cleanup_nx_in_kerneltext()" function, called at the end of
free_initmem(), which changes these pages--except for the range from
"_text" to "_etext"--to PAGE_KERNEL (i.e., non-executable).

This does result in two large pages being split up into small PTEs
permanently, but all the non-code regions will be non-executable, and
change_page_attr() will work correctly.

What do you think of this?  I have tested this on 2.6.12.

(I've attached the patch as a file, too, since my mail server can't be
convinced to not wrap text.)

Stuart

-----


diff -purN --exclude=3D'*.o' --exclude=3D'*.cmd'
linux-2.6.12grep/arch/i386/mm/init.c linux-2.6.12/arch/i386/mm/init.c
--- linux-2.6.12grep/arch/i386/mm/init.c	2005-07-01
15:09:27.000000000 -0500
+++ linux-2.6.12/arch/i386/mm/init.c	2005-07-01 15:13:06.000000000
-0500
@@ -666,6 +666,30 @@ static int noinline do_test_wp_bit(void)
 	return flag;
 }
=20
+extern int change_page_attr_perm(struct page *, int, pgprot_t);
+
+/*
+ * In kernel_physical_mapping_init(), any big pages that contained
kernel text area were
+ * set up as big executable pages.  This function should be called when
the initmem
+ * is freed, to correctly set up the executable & non-executable pages
in this area.
+ */
+static void cleanup_nx_in_kerneltext(void)
+{
+	unsigned long from, to;
+
+	if (!nx_enabled) return;
+
+	from =3D PAGE_OFFSET;
+	to =3D (unsigned long)_text & PAGE_MASK;
+	for (; from<to; from +=3D PAGE_SIZE)
+		change_page_attr_perm(virt_to_page(from), 1,
PAGE_KERNEL);=20
+=09
+	from =3D ((unsigned long)_etext + PAGE_SIZE - 1) & PAGE_MASK;
+	to =3D ((unsigned long)__init_end + LARGE_PAGE_SIZE) &
LARGE_PAGE_MASK;
+	for (; from<to; from +=3D PAGE_SIZE)
+		change_page_attr_perm(virt_to_page(from), 1,
PAGE_KERNEL);=20
+}
+
 void free_initmem(void)
 {
 	unsigned long addr;
@@ -679,6 +703,8 @@ void free_initmem(void)
 		totalram_pages++;
 	}
 	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n",
(__init_end - __init_begin) >> 10);
+
+	cleanup_nx_in_kerneltext();
 }
=20
 #ifdef CONFIG_BLK_DEV_INITRD
diff -purN --exclude=3D'*.o' --exclude=3D'*.cmd'
linux-2.6.12grep/arch/i386/mm/pageattr.c
linux-2.6.12/arch/i386/mm/pageattr.c
--- linux-2.6.12grep/arch/i386/mm/pageattr.c	2005-07-01
15:09:08.000000000 -0500
+++ linux-2.6.12/arch/i386/mm/pageattr.c	2005-07-01
14:56:06.000000000 -0500
@@ -35,7 +35,7 @@ pte_t *lookup_address(unsigned long addr
         return pte_offset_kernel(pmd, address);
 }=20
=20
-static struct page *split_large_page(unsigned long address, pgprot_t
prot)
+static struct page *split_large_page(unsigned long address, pgprot_t
prot, pgprot_t ref_prot)
 {=20
 	int i;=20
 	unsigned long addr;
@@ -53,7 +53,7 @@ static struct page *split_large_page(uns
 	pbase =3D (pte_t *)page_address(base);
 	for (i =3D 0; i < PTRS_PER_PTE; i++, addr +=3D PAGE_SIZE) {
 		pbase[i] =3D pfn_pte(addr >> PAGE_SHIFT,=20
-				   addr =3D=3D address ? prot :
PAGE_KERNEL);
+				   addr =3D=3D address ? prot : ref_prot);
 	}
 	return base;
 }=20
@@ -122,7 +122,7 @@ __change_page_attr(struct page *page, pg
 		if ((pte_val(*kpte) & _PAGE_PSE) =3D=3D 0) {=20
 			set_pte_atomic(kpte, mk_pte(page, prot));=20
 		} else {
-			struct page *split =3D split_large_page(address,
prot);=20
+			struct page *split =3D split_large_page(address,
prot, PAGE_KERNEL);=20
 			if (!split)
 				return -ENOMEM;
 			set_pmd_pte(kpte,address,mk_pte(split,
PAGE_KERNEL));
@@ -152,6 +152,38 @@ __change_page_attr(struct page *page, pg
 	return 0;
 }=20
=20
+static int __change_page_attr_perm (struct page *page, pgprot_t prot)
+{=20
+	pte_t *kpte;=20
+	unsigned long address;
+	struct page *kpte_page;
+
+	BUG_ON(PageHighMem(page));
+	address =3D (unsigned long)page_address(page);
+
+	kpte =3D lookup_address(address);
+	if (!kpte)
+		return -EINVAL;
+	kpte_page =3D virt_to_page(kpte);
+
+	if ((pte_val(*kpte) & _PAGE_PSE) =3D=3D 0) {=20
+		set_pte_atomic(kpte, mk_pte(page, prot));=20
+	} else {
+		pgprot_t ref_prot;
+
+		if ((pte_val(*kpte) & _PAGE_NX))
+			ref_prot =3D PAGE_KERNEL;
+		else
+			ref_prot =3D PAGE_KERNEL_EXEC;
+		kpte_page =3D split_large_page(address, prot, ref_prot);
+		if (!kpte_page)
+			return -ENOMEM;
+		set_pmd_pte(kpte,address,mk_pte(kpte_page, ref_prot));
+	}=09
+	SetPageReserved(kpte_page);
+	return 0;
+}=20
+
 static inline void flush_map(void)
 {
 	on_each_cpu(flush_kernel_map, NULL, 1, 1);
@@ -186,6 +218,22 @@ int change_page_attr(struct page *page,=20
 	return err;
 }
=20
+int change_page_attr_perm(struct page *page, int numpages, pgprot_t
prot)
+{
+	int err =3D 0;=20
+	int i;=20
+	unsigned long flags;
+
+	spin_lock_irqsave(&cpa_lock, flags);
+	for (i =3D 0; i < numpages; i++, page++) {=20
+		err =3D __change_page_attr_perm(page, prot);
+		if (err)=20
+			break;=20
+	} =09
+	spin_unlock_irqrestore(&cpa_lock, flags);
+	return err;
+}
+
 void global_flush_tlb(void)
 {=20
 	LIST_HEAD(l);

------_=_NextPart_001_01C57E7C.2645D68A
Content-Type: application/octet-stream;
	name="pass1.patch"
Content-Transfer-Encoding: base64
Content-Description: pass1.patch
Content-Disposition: attachment;
	filename="pass1.patch"

ZGlmZiAtcHVyTiAtLWV4Y2x1ZGU9JyoubycgLS1leGNsdWRlPScqLmNtZCcgbGludXgtMi42LjEy
Z3JlcC9hcmNoL2kzODYvbW0vaW5pdC5jIGxpbnV4LTIuNi4xMi9hcmNoL2kzODYvbW0vaW5pdC5j
Ci0tLSBsaW51eC0yLjYuMTJncmVwL2FyY2gvaTM4Ni9tbS9pbml0LmMJMjAwNS0wNy0wMSAxNTow
OToyNy4wMDAwMDAwMDAgLTA1MDAKKysrIGxpbnV4LTIuNi4xMi9hcmNoL2kzODYvbW0vaW5pdC5j
CTIwMDUtMDctMDEgMTU6MTM6MDYuMDAwMDAwMDAwIC0wNTAwCkBAIC02NjYsNiArNjY2LDMwIEBA
IHN0YXRpYyBpbnQgbm9pbmxpbmUgZG9fdGVzdF93cF9iaXQodm9pZCkKIAlyZXR1cm4gZmxhZzsK
IH0KIAorZXh0ZXJuIGludCBjaGFuZ2VfcGFnZV9hdHRyX3Blcm0oc3RydWN0IHBhZ2UgKiwgaW50
LCBwZ3Byb3RfdCk7CisKKy8qCisgKiBJbiBrZXJuZWxfcGh5c2ljYWxfbWFwcGluZ19pbml0KCks
IGFueSBiaWcgcGFnZXMgdGhhdCBjb250YWluZWQga2VybmVsIHRleHQgYXJlYSB3ZXJlCisgKiBz
ZXQgdXAgYXMgYmlnIGV4ZWN1dGFibGUgcGFnZXMuICBUaGlzIGZ1bmN0aW9uIHNob3VsZCBiZSBj
YWxsZWQgd2hlbiB0aGUgaW5pdG1lbQorICogaXMgZnJlZWQsIHRvIGNvcnJlY3RseSBzZXQgdXAg
dGhlIGV4ZWN1dGFibGUgJiBub24tZXhlY3V0YWJsZSBwYWdlcyBpbiB0aGlzIGFyZWEuCisgKi8K
K3N0YXRpYyB2b2lkIGNsZWFudXBfbnhfaW5fa2VybmVsdGV4dCh2b2lkKQoreworCXVuc2lnbmVk
IGxvbmcgZnJvbSwgdG87CisKKwlpZiAoIW54X2VuYWJsZWQpIHJldHVybjsKKworCWZyb20gPSBQ
QUdFX09GRlNFVDsKKwl0byA9ICh1bnNpZ25lZCBsb25nKV90ZXh0ICYgUEFHRV9NQVNLOworCWZv
ciAoOyBmcm9tPHRvOyBmcm9tICs9IFBBR0VfU0laRSkKKwkJY2hhbmdlX3BhZ2VfYXR0cl9wZXJt
KHZpcnRfdG9fcGFnZShmcm9tKSwgMSwgUEFHRV9LRVJORUwpOyAKKwkKKwlmcm9tID0gKCh1bnNp
Z25lZCBsb25nKV9ldGV4dCArIFBBR0VfU0laRSAtIDEpICYgUEFHRV9NQVNLOworCXRvID0gKCh1
bnNpZ25lZCBsb25nKV9faW5pdF9lbmQgKyBMQVJHRV9QQUdFX1NJWkUpICYgTEFSR0VfUEFHRV9N
QVNLOworCWZvciAoOyBmcm9tPHRvOyBmcm9tICs9IFBBR0VfU0laRSkKKwkJY2hhbmdlX3BhZ2Vf
YXR0cl9wZXJtKHZpcnRfdG9fcGFnZShmcm9tKSwgMSwgUEFHRV9LRVJORUwpOyAKK30KKwogdm9p
ZCBmcmVlX2luaXRtZW0odm9pZCkKIHsKIAl1bnNpZ25lZCBsb25nIGFkZHI7CkBAIC02NzksNiAr
NzAzLDggQEAgdm9pZCBmcmVlX2luaXRtZW0odm9pZCkKIAkJdG90YWxyYW1fcGFnZXMrKzsKIAl9
CiAJcHJpbnRrIChLRVJOX0lORk8gIkZyZWVpbmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6ICVkayBm
cmVlZFxuIiwgKF9faW5pdF9lbmQgLSBfX2luaXRfYmVnaW4pID4+IDEwKTsKKworCWNsZWFudXBf
bnhfaW5fa2VybmVsdGV4dCgpOwogfQogCiAjaWZkZWYgQ09ORklHX0JMS19ERVZfSU5JVFJECmRp
ZmYgLXB1ck4gLS1leGNsdWRlPScqLm8nIC0tZXhjbHVkZT0nKi5jbWQnIGxpbnV4LTIuNi4xMmdy
ZXAvYXJjaC9pMzg2L21tL3BhZ2VhdHRyLmMgbGludXgtMi42LjEyL2FyY2gvaTM4Ni9tbS9wYWdl
YXR0ci5jCi0tLSBsaW51eC0yLjYuMTJncmVwL2FyY2gvaTM4Ni9tbS9wYWdlYXR0ci5jCTIwMDUt
MDctMDEgMTU6MDk6MDguMDAwMDAwMDAwIC0wNTAwCisrKyBsaW51eC0yLjYuMTIvYXJjaC9pMzg2
L21tL3BhZ2VhdHRyLmMJMjAwNS0wNy0wMSAxNDo1NjowNi4wMDAwMDAwMDAgLTA1MDAKQEAgLTM1
LDcgKzM1LDcgQEAgcHRlX3QgKmxvb2t1cF9hZGRyZXNzKHVuc2lnbmVkIGxvbmcgYWRkcgogICAg
ICAgICByZXR1cm4gcHRlX29mZnNldF9rZXJuZWwocG1kLCBhZGRyZXNzKTsKIH0gCiAKLXN0YXRp
YyBzdHJ1Y3QgcGFnZSAqc3BsaXRfbGFyZ2VfcGFnZSh1bnNpZ25lZCBsb25nIGFkZHJlc3MsIHBn
cHJvdF90IHByb3QpCitzdGF0aWMgc3RydWN0IHBhZ2UgKnNwbGl0X2xhcmdlX3BhZ2UodW5zaWdu
ZWQgbG9uZyBhZGRyZXNzLCBwZ3Byb3RfdCBwcm90LCBwZ3Byb3RfdCByZWZfcHJvdCkKIHsgCiAJ
aW50IGk7IAogCXVuc2lnbmVkIGxvbmcgYWRkcjsKQEAgLTUzLDcgKzUzLDcgQEAgc3RhdGljIHN0
cnVjdCBwYWdlICpzcGxpdF9sYXJnZV9wYWdlKHVucwogCXBiYXNlID0gKHB0ZV90ICopcGFnZV9h
ZGRyZXNzKGJhc2UpOwogCWZvciAoaSA9IDA7IGkgPCBQVFJTX1BFUl9QVEU7IGkrKywgYWRkciAr
PSBQQUdFX1NJWkUpIHsKIAkJcGJhc2VbaV0gPSBwZm5fcHRlKGFkZHIgPj4gUEFHRV9TSElGVCwg
Ci0JCQkJICAgYWRkciA9PSBhZGRyZXNzID8gcHJvdCA6IFBBR0VfS0VSTkVMKTsKKwkJCQkgICBh
ZGRyID09IGFkZHJlc3MgPyBwcm90IDogcmVmX3Byb3QpOwogCX0KIAlyZXR1cm4gYmFzZTsKIH0g
CkBAIC0xMjIsNyArMTIyLDcgQEAgX19jaGFuZ2VfcGFnZV9hdHRyKHN0cnVjdCBwYWdlICpwYWdl
LCBwZwogCQlpZiAoKHB0ZV92YWwoKmtwdGUpICYgX1BBR0VfUFNFKSA9PSAwKSB7IAogCQkJc2V0
X3B0ZV9hdG9taWMoa3B0ZSwgbWtfcHRlKHBhZ2UsIHByb3QpKTsgCiAJCX0gZWxzZSB7Ci0JCQlz
dHJ1Y3QgcGFnZSAqc3BsaXQgPSBzcGxpdF9sYXJnZV9wYWdlKGFkZHJlc3MsIHByb3QpOyAKKwkJ
CXN0cnVjdCBwYWdlICpzcGxpdCA9IHNwbGl0X2xhcmdlX3BhZ2UoYWRkcmVzcywgcHJvdCwgUEFH
RV9LRVJORUwpOyAKIAkJCWlmICghc3BsaXQpCiAJCQkJcmV0dXJuIC1FTk9NRU07CiAJCQlzZXRf
cG1kX3B0ZShrcHRlLGFkZHJlc3MsbWtfcHRlKHNwbGl0LCBQQUdFX0tFUk5FTCkpOwpAQCAtMTUy
LDYgKzE1MiwzOCBAQCBfX2NoYW5nZV9wYWdlX2F0dHIoc3RydWN0IHBhZ2UgKnBhZ2UsIHBnCiAJ
cmV0dXJuIDA7CiB9IAogCitzdGF0aWMgaW50IF9fY2hhbmdlX3BhZ2VfYXR0cl9wZXJtIChzdHJ1
Y3QgcGFnZSAqcGFnZSwgcGdwcm90X3QgcHJvdCkKK3sgCisJcHRlX3QgKmtwdGU7IAorCXVuc2ln
bmVkIGxvbmcgYWRkcmVzczsKKwlzdHJ1Y3QgcGFnZSAqa3B0ZV9wYWdlOworCisJQlVHX09OKFBh
Z2VIaWdoTWVtKHBhZ2UpKTsKKwlhZGRyZXNzID0gKHVuc2lnbmVkIGxvbmcpcGFnZV9hZGRyZXNz
KHBhZ2UpOworCisJa3B0ZSA9IGxvb2t1cF9hZGRyZXNzKGFkZHJlc3MpOworCWlmICgha3B0ZSkK
KwkJcmV0dXJuIC1FSU5WQUw7CisJa3B0ZV9wYWdlID0gdmlydF90b19wYWdlKGtwdGUpOworCisJ
aWYgKChwdGVfdmFsKCprcHRlKSAmIF9QQUdFX1BTRSkgPT0gMCkgeyAKKwkJc2V0X3B0ZV9hdG9t
aWMoa3B0ZSwgbWtfcHRlKHBhZ2UsIHByb3QpKTsgCisJfSBlbHNlIHsKKwkJcGdwcm90X3QgcmVm
X3Byb3Q7CisKKwkJaWYgKChwdGVfdmFsKCprcHRlKSAmIF9QQUdFX05YKSkKKwkJCXJlZl9wcm90
ID0gUEFHRV9LRVJORUw7CisJCWVsc2UKKwkJCXJlZl9wcm90ID0gUEFHRV9LRVJORUxfRVhFQzsK
KwkJa3B0ZV9wYWdlID0gc3BsaXRfbGFyZ2VfcGFnZShhZGRyZXNzLCBwcm90LCByZWZfcHJvdCk7
CisJCWlmICgha3B0ZV9wYWdlKQorCQkJcmV0dXJuIC1FTk9NRU07CisJCXNldF9wbWRfcHRlKGtw
dGUsYWRkcmVzcyxta19wdGUoa3B0ZV9wYWdlLCByZWZfcHJvdCkpOworCX0JCisJU2V0UGFnZVJl
c2VydmVkKGtwdGVfcGFnZSk7CisJcmV0dXJuIDA7Cit9IAorCiBzdGF0aWMgaW5saW5lIHZvaWQg
Zmx1c2hfbWFwKHZvaWQpCiB7CiAJb25fZWFjaF9jcHUoZmx1c2hfa2VybmVsX21hcCwgTlVMTCwg
MSwgMSk7CkBAIC0xODYsNiArMjE4LDIyIEBAIGludCBjaGFuZ2VfcGFnZV9hdHRyKHN0cnVjdCBw
YWdlICpwYWdlLCAKIAlyZXR1cm4gZXJyOwogfQogCitpbnQgY2hhbmdlX3BhZ2VfYXR0cl9wZXJt
KHN0cnVjdCBwYWdlICpwYWdlLCBpbnQgbnVtcGFnZXMsIHBncHJvdF90IHByb3QpCit7CisJaW50
IGVyciA9IDA7IAorCWludCBpOyAKKwl1bnNpZ25lZCBsb25nIGZsYWdzOworCisJc3Bpbl9sb2Nr
X2lycXNhdmUoJmNwYV9sb2NrLCBmbGFncyk7CisJZm9yIChpID0gMDsgaSA8IG51bXBhZ2VzOyBp
KyssIHBhZ2UrKykgeyAKKwkJZXJyID0gX19jaGFuZ2VfcGFnZV9hdHRyX3Blcm0ocGFnZSwgcHJv
dCk7CisJCWlmIChlcnIpIAorCQkJYnJlYWs7IAorCX0gCQorCXNwaW5fdW5sb2NrX2lycXJlc3Rv
cmUoJmNwYV9sb2NrLCBmbGFncyk7CisJcmV0dXJuIGVycjsKK30KKwogdm9pZCBnbG9iYWxfZmx1
c2hfdGxiKHZvaWQpCiB7IAogCUxJU1RfSEVBRChsKTsK

------_=_NextPart_001_01C57E7C.2645D68A--
