Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVGEUDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVGEUDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 16:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVGEUDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 16:03:24 -0400
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:2993 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S261736AbVGEUC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 16:02:28 -0400
X-IronPort-AV: i="3.94,170,1118034000"; 
   d="scan'208"; a="262136144:sNHT58100706"
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5819C.7750BB8C"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Subject: RE: page allocation/attributes question (i386/x86_64 specific)
Date: Tue, 5 Jul 2005 15:02:26 -0500
Message-ID: <B1939BC11A23AE47A0DBE89A37CB26B407435C@ausx3mps305.aus.amer.dell.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: page allocation/attributes question (i386/x86_64 specific)
Thread-Index: AcV9jvboLnykyAOORAS/GMIhlJZYBQABJtZgAAB8XiAAORqqUADIN3xA
From: <Stuart_Hayes@Dell.com>
To: <ak@suse.de>
Cc: <riel@redhat.com>, <andrea@suse.de>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 05 Jul 2005 20:02:27.0575 (UTC) FILETIME=[77DC8870:01C5819C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5819C.7750BB8C
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hayes, Stuart wrote:
>> So, if I understand correctly what's going on in x86_64, your fix
>> wouldn't be applicable to i386.  In x86_64, every large page has a
>> correct "ref_prot" that is the normal setting for that page... but in
>> i386, the kernel text area does not--it should ideally be split into
>> small pages all the time if there are both kernel code & free pages
>> residing in the same 2M area.=20
>>=20
>> Stuart
>=20
> (This isn't a submission--I'm just posting this for comments.)
>=20
> Right now, any large page that touches anywhere from PAGE_OFFSET to
> __init_end is initially set up as a large, executable page... but
> some of this area contains data & free pages.  The patch below adds a
> "cleanup_nx_in_kerneltext()" function, called at the end of
> free_initmem(), which changes these pages--except for the range from
> "_text" to "_etext"--to PAGE_KERNEL (i.e., non-executable).    =20
>=20
> This does result in two large pages being split up into small PTEs
> permanently, but all the non-code regions will be non-executable, and
> change_page_attr() will work correctly. =20
>=20
> What do you think of this?  I have tested this on 2.6.12.
>=20
> (I've attached the patch as a file, too, since my mail server can't
> be convinced to not wrap text.)=20
>=20
> Stuart
>=20

Andi--

I made another pass at this.  This does roughly the same thing, but it
doesn't create the new "change_page_attr_perm()" functions.  With this
patch, the change to init.c (cleanup_nx_in_kerneltext()) is optional.  I
changed __change_page_attr() so that, if the page to be changed is part
of a large executable page, it splits the page up *keeping the
executability of the extra 511 pages*, and then marks the new PTE page
as reserved so that it won't be reverted.

So, basically, without the changes to init.c, the NX bits for data in
the first two big pages won't get fixed until someone calls
change_page_attr() on them.  If NX is disabled, these patches have no
functional effect at all.

How does this look?
Thanks!
Stuart

-----

diff -purN linux-2.6.12grep/arch/i386/mm/init.c
linux-2.6.12/arch/i386/mm/init.c
--- linux-2.6.12grep/arch/i386/mm/init.c	2005-07-01
15:09:27.000000000 -0500
+++ linux-2.6.12/arch/i386/mm/init.c	2005-07-05 14:32:57.000000000
-0500
@@ -666,6 +666,28 @@ static int noinline do_test_wp_bit(void)
 	return flag;
 }
=20
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
+		change_page_attr(virt_to_page(from), 1, PAGE_KERNEL);=20
+=09
+	from =3D ((unsigned long)_etext + PAGE_SIZE - 1) & PAGE_MASK;
+	to =3D ((unsigned long)__init_end + LARGE_PAGE_SIZE) &
LARGE_PAGE_MASK;
+	for (; from<to; from +=3D PAGE_SIZE)
+		change_page_attr(virt_to_page(from), 1, PAGE_KERNEL);=20
+}
+
 void free_initmem(void)
 {
 	unsigned long addr;
@@ -679,6 +701,8 @@ void free_initmem(void)
 		totalram_pages++;
 	}
 	printk (KERN_INFO "Freeing unused kernel memory: %dk freed\n",
(__init_end - __init_begin) >> 10);
+
+	cleanup_nx_in_kerneltext();
 }
=20
 #ifdef CONFIG_BLK_DEV_INITRD
diff -purN linux-2.6.12grep/arch/i386/mm/pageattr.c
linux-2.6.12/arch/i386/mm/pageattr.c
--- linux-2.6.12grep/arch/i386/mm/pageattr.c	2005-07-01
15:09:08.000000000 -0500
+++ linux-2.6.12/arch/i386/mm/pageattr.c	2005-07-05
14:44:53.000000000 -0500
@@ -35,7 +35,8 @@ pte_t *lookup_address(unsigned long addr
         return pte_offset_kernel(pmd, address);
 }=20
=20
-static struct page *split_large_page(unsigned long address, pgprot_t
prot)
+static struct page *split_large_page(unsigned long address, pgprot_t
prot,=20
+					pgprot_t ref_prot)
 {=20
 	int i;=20
 	unsigned long addr;
@@ -53,7 +54,7 @@ static struct page *split_large_page(uns
 	pbase =3D (pte_t *)page_address(base);
 	for (i =3D 0; i < PTRS_PER_PTE; i++, addr +=3D PAGE_SIZE) {
 		pbase[i] =3D pfn_pte(addr >> PAGE_SHIFT,=20
-				   addr =3D=3D address ? prot :
PAGE_KERNEL);
+				   addr =3D=3D address ? prot : ref_prot);
 	}
 	return base;
 }=20
@@ -118,11 +119,30 @@ __change_page_attr(struct page *page, pg
 	if (!kpte)
 		return -EINVAL;
 	kpte_page =3D virt_to_page(kpte);
+
+	/*
+	 * If this page is part of a large page that's executable (and
NX is
+	 * enabled), then split page up and set new PTE page as reserved
so
+	 * we won't revert this back into a large page.  This should
only
+	 * happen in large pages that also contain kernel executable
code,
+	 * and shouldn't happen at all if init.c correctly sets up NX
regions.
+	 */
+	if (nx_enabled &&=20
+	    !(pte_val(*kpte) & _PAGE_NX) &&
+	    (pte_val(*kpte) & _PAGE_PSE)) {
+		struct page *split =3D split_large_page(address, prot,
PAGE_KERNEL_EXEC);=20
+		if (!split)
+			return -ENOMEM;
+		set_pmd_pte(kpte,address,mk_pte(split,
PAGE_KERNEL_EXEC));
+		SetPageReserved(split);
+		return 0;
+	}
+
 	if (pgprot_val(prot) !=3D pgprot_val(PAGE_KERNEL)) {=20
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

------_=_NextPart_001_01C5819C.7750BB8C
Content-Type: application/octet-stream;
	name="fixnx2.patch"
Content-Transfer-Encoding: base64
Content-Description: fixnx2.patch
Content-Disposition: attachment;
	filename="fixnx2.patch"

ZGlmZiAtcHVyTiAtLWV4Y2x1ZGU9JypvcmlnJyAtLWV4Y2x1ZGU9JypvJyAtLWV4Y2x1ZGU9Jypj
bWQnIGxpbnV4LTIuNi4xMmdyZXAvYXJjaC9pMzg2L21tL2luaXQuYyBsaW51eC0yLjYuMTIvYXJj
aC9pMzg2L21tL2luaXQuYwotLS0gbGludXgtMi42LjEyZ3JlcC9hcmNoL2kzODYvbW0vaW5pdC5j
CTIwMDUtMDctMDEgMTU6MDk6MjcuMDAwMDAwMDAwIC0wNTAwCisrKyBsaW51eC0yLjYuMTIvYXJj
aC9pMzg2L21tL2luaXQuYwkyMDA1LTA3LTA1IDE0OjMyOjU3LjAwMDAwMDAwMCAtMDUwMApAQCAt
NjY2LDYgKzY2NiwyOCBAQCBzdGF0aWMgaW50IG5vaW5saW5lIGRvX3Rlc3Rfd3BfYml0KHZvaWQp
CiAJcmV0dXJuIGZsYWc7CiB9CiAKKy8qCisgKiBJbiBrZXJuZWxfcGh5c2ljYWxfbWFwcGluZ19p
bml0KCksIGFueSBiaWcgcGFnZXMgdGhhdCBjb250YWluZWQga2VybmVsIHRleHQgYXJlYSB3ZXJl
CisgKiBzZXQgdXAgYXMgYmlnIGV4ZWN1dGFibGUgcGFnZXMuICBUaGlzIGZ1bmN0aW9uIHNob3Vs
ZCBiZSBjYWxsZWQgd2hlbiB0aGUgaW5pdG1lbQorICogaXMgZnJlZWQsIHRvIGNvcnJlY3RseSBz
ZXQgdXAgdGhlIGV4ZWN1dGFibGUgJiBub24tZXhlY3V0YWJsZSBwYWdlcyBpbiB0aGlzIGFyZWEu
CisgKi8KK3N0YXRpYyB2b2lkIGNsZWFudXBfbnhfaW5fa2VybmVsdGV4dCh2b2lkKQoreworCXVu
c2lnbmVkIGxvbmcgZnJvbSwgdG87CisKKwlpZiAoIW54X2VuYWJsZWQpIHJldHVybjsKKworCWZy
b20gPSBQQUdFX09GRlNFVDsKKwl0byA9ICh1bnNpZ25lZCBsb25nKV90ZXh0ICYgUEFHRV9NQVNL
OworCWZvciAoOyBmcm9tPHRvOyBmcm9tICs9IFBBR0VfU0laRSkKKwkJY2hhbmdlX3BhZ2VfYXR0
cih2aXJ0X3RvX3BhZ2UoZnJvbSksIDEsIFBBR0VfS0VSTkVMKTsgCisJCisJZnJvbSA9ICgodW5z
aWduZWQgbG9uZylfZXRleHQgKyBQQUdFX1NJWkUgLSAxKSAmIFBBR0VfTUFTSzsKKwl0byA9ICgo
dW5zaWduZWQgbG9uZylfX2luaXRfZW5kICsgTEFSR0VfUEFHRV9TSVpFKSAmIExBUkdFX1BBR0Vf
TUFTSzsKKwlmb3IgKDsgZnJvbTx0bzsgZnJvbSArPSBQQUdFX1NJWkUpCisJCWNoYW5nZV9wYWdl
X2F0dHIodmlydF90b19wYWdlKGZyb20pLCAxLCBQQUdFX0tFUk5FTCk7IAorfQorCiB2b2lkIGZy
ZWVfaW5pdG1lbSh2b2lkKQogewogCXVuc2lnbmVkIGxvbmcgYWRkcjsKQEAgLTY3OSw2ICs3MDEs
OCBAQCB2b2lkIGZyZWVfaW5pdG1lbSh2b2lkKQogCQl0b3RhbHJhbV9wYWdlcysrOwogCX0KIAlw
cmludGsgKEtFUk5fSU5GTyAiRnJlZWluZyB1bnVzZWQga2VybmVsIG1lbW9yeTogJWRrIGZyZWVk
XG4iLCAoX19pbml0X2VuZCAtIF9faW5pdF9iZWdpbikgPj4gMTApOworCisJY2xlYW51cF9ueF9p
bl9rZXJuZWx0ZXh0KCk7CiB9CiAKICNpZmRlZiBDT05GSUdfQkxLX0RFVl9JTklUUkQKZGlmZiAt
cHVyTiAtLWV4Y2x1ZGU9JypvcmlnJyAtLWV4Y2x1ZGU9JypvJyAtLWV4Y2x1ZGU9JypjbWQnIGxp
bnV4LTIuNi4xMmdyZXAvYXJjaC9pMzg2L21tL3BhZ2VhdHRyLmMgbGludXgtMi42LjEyL2FyY2gv
aTM4Ni9tbS9wYWdlYXR0ci5jCi0tLSBsaW51eC0yLjYuMTJncmVwL2FyY2gvaTM4Ni9tbS9wYWdl
YXR0ci5jCTIwMDUtMDctMDEgMTU6MDk6MDguMDAwMDAwMDAwIC0wNTAwCisrKyBsaW51eC0yLjYu
MTIvYXJjaC9pMzg2L21tL3BhZ2VhdHRyLmMJMjAwNS0wNy0wNSAxNDo0NDo1My4wMDAwMDAwMDAg
LTA1MDAKQEAgLTM1LDcgKzM1LDggQEAgcHRlX3QgKmxvb2t1cF9hZGRyZXNzKHVuc2lnbmVkIGxv
bmcgYWRkcgogICAgICAgICByZXR1cm4gcHRlX29mZnNldF9rZXJuZWwocG1kLCBhZGRyZXNzKTsK
IH0gCiAKLXN0YXRpYyBzdHJ1Y3QgcGFnZSAqc3BsaXRfbGFyZ2VfcGFnZSh1bnNpZ25lZCBsb25n
IGFkZHJlc3MsIHBncHJvdF90IHByb3QpCitzdGF0aWMgc3RydWN0IHBhZ2UgKnNwbGl0X2xhcmdl
X3BhZ2UodW5zaWduZWQgbG9uZyBhZGRyZXNzLCBwZ3Byb3RfdCBwcm90LCAKKwkJCQkJcGdwcm90
X3QgcmVmX3Byb3QpCiB7IAogCWludCBpOyAKIAl1bnNpZ25lZCBsb25nIGFkZHI7CkBAIC01Myw3
ICs1NCw3IEBAIHN0YXRpYyBzdHJ1Y3QgcGFnZSAqc3BsaXRfbGFyZ2VfcGFnZSh1bnMKIAlwYmFz
ZSA9IChwdGVfdCAqKXBhZ2VfYWRkcmVzcyhiYXNlKTsKIAlmb3IgKGkgPSAwOyBpIDwgUFRSU19Q
RVJfUFRFOyBpKyssIGFkZHIgKz0gUEFHRV9TSVpFKSB7CiAJCXBiYXNlW2ldID0gcGZuX3B0ZShh
ZGRyID4+IFBBR0VfU0hJRlQsIAotCQkJCSAgIGFkZHIgPT0gYWRkcmVzcyA/IHByb3QgOiBQQUdF
X0tFUk5FTCk7CisJCQkJICAgYWRkciA9PSBhZGRyZXNzID8gcHJvdCA6IHJlZl9wcm90KTsKIAl9
CiAJcmV0dXJuIGJhc2U7CiB9IApAQCAtMTE4LDExICsxMTksMzAgQEAgX19jaGFuZ2VfcGFnZV9h
dHRyKHN0cnVjdCBwYWdlICpwYWdlLCBwZwogCWlmICgha3B0ZSkKIAkJcmV0dXJuIC1FSU5WQUw7
CiAJa3B0ZV9wYWdlID0gdmlydF90b19wYWdlKGtwdGUpOworCisJLyoKKwkgKiBJZiB0aGlzIHBh
Z2UgaXMgcGFydCBvZiBhIGxhcmdlIHBhZ2UgdGhhdCdzIGV4ZWN1dGFibGUgKGFuZCBOWCBpcwor
CSAqIGVuYWJsZWQpLCB0aGVuIHNwbGl0IHBhZ2UgdXAgYW5kIHNldCBuZXcgUFRFIHBhZ2UgYXMg
cmVzZXJ2ZWQgc28KKwkgKiB3ZSB3b24ndCByZXZlcnQgdGhpcyBiYWNrIGludG8gYSBsYXJnZSBw
YWdlLiAgVGhpcyBzaG91bGQgb25seQorCSAqIGhhcHBlbiBpbiBsYXJnZSBwYWdlcyB0aGF0IGFs
c28gY29udGFpbiBrZXJuZWwgZXhlY3V0YWJsZSBjb2RlLAorCSAqIGFuZCBzaG91bGRuJ3QgaGFw
cGVuIGF0IGFsbCBpZiBpbml0LmMgY29ycmVjdGx5IHNldHMgdXAgTlggcmVnaW9ucy4KKwkgKi8K
KwlpZiAobnhfZW5hYmxlZCAmJiAKKwkgICAgIShwdGVfdmFsKCprcHRlKSAmIF9QQUdFX05YKSAm
JgorCSAgICAocHRlX3ZhbCgqa3B0ZSkgJiBfUEFHRV9QU0UpKSB7CisJCXN0cnVjdCBwYWdlICpz
cGxpdCA9IHNwbGl0X2xhcmdlX3BhZ2UoYWRkcmVzcywgcHJvdCwgUEFHRV9LRVJORUxfRVhFQyk7
IAorCQlpZiAoIXNwbGl0KQorCQkJcmV0dXJuIC1FTk9NRU07CisJCXNldF9wbWRfcHRlKGtwdGUs
YWRkcmVzcyxta19wdGUoc3BsaXQsIFBBR0VfS0VSTkVMX0VYRUMpKTsKKwkJU2V0UGFnZVJlc2Vy
dmVkKHNwbGl0KTsKKwkJcmV0dXJuIDA7CisJfQorCiAJaWYgKHBncHJvdF92YWwocHJvdCkgIT0g
cGdwcm90X3ZhbChQQUdFX0tFUk5FTCkpIHsgCiAJCWlmICgocHRlX3ZhbCgqa3B0ZSkgJiBfUEFH
RV9QU0UpID09IDApIHsgCiAJCQlzZXRfcHRlX2F0b21pYyhrcHRlLCBta19wdGUocGFnZSwgcHJv
dCkpOyAKIAkJfSBlbHNlIHsKLQkJCXN0cnVjdCBwYWdlICpzcGxpdCA9IHNwbGl0X2xhcmdlX3Bh
Z2UoYWRkcmVzcywgcHJvdCk7IAorCQkJc3RydWN0IHBhZ2UgKnNwbGl0ID0gc3BsaXRfbGFyZ2Vf
cGFnZShhZGRyZXNzLCBwcm90LCBQQUdFX0tFUk5FTCk7IAogCQkJaWYgKCFzcGxpdCkKIAkJCQly
ZXR1cm4gLUVOT01FTTsKIAkJCXNldF9wbWRfcHRlKGtwdGUsYWRkcmVzcyxta19wdGUoc3BsaXQs
IFBBR0VfS0VSTkVMKSk7Cg==

------_=_NextPart_001_01C5819C.7750BB8C--
