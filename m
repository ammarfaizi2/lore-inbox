Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUKXBIx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUKXBIx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 20:08:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbUKXBIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 20:08:51 -0500
Received: from fmr17.intel.com ([134.134.136.16]:51930 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261666AbUKXBEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 20:04:49 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4D1C1.8C2FFD87"
Subject: RE: [PATCH 1/2] setup_arg_pages can insert overlapping vma
Date: Wed, 24 Nov 2004 09:04:28 +0800
Message-ID: <894E37DECA393E4D9374E0ACBBE7427013C9AB@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/2] setup_arg_pages can insert overlapping vma
Thread-Index: AcTNl5rA76rARnfyT+SOqXzq8myPLgEJ46LA
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "Hugh Dickins" <hugh@veritas.com>, "Chris Wright" <chrisw@osdl.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "Linus Torvalds" <torvalds@osdl.org>,
       "Luck, Tony" <tony.luck@intel.com>,
       "Martin Schwidefsky" <schwidefsky@de.ibm.com>,
       "Andi Kleen" <ak@suse.de>, <linux-kernel@vger.kernel.org>,
       <linux-ia64@vger.kernel.org>
X-OriginalArrivalTime: 24 Nov 2004 01:04:29.0256 (UTC) FILETIME=[8CB19C80:01C4D1C1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4D1C1.8C2FFD87
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

 <<ia64-vm-overlap.tar.gz>>  <<vma-overlap-fix.patch>> I think ia64 ia32
subsystem is not vulnerable to this kind of overlapping vm problem,
because it does not support a.out binary format,=20
X84_64 is vulnerable to this.=20

just do a=20
perl -e'print"\x07\x01".("\x00"x10)."\x00\xe0\xff\xff".("\x00"x16)'>
evilaout
you will get it.
=20
and IA64 is also vulnerable to this kind of bug in 64 bit elf support,
it just insert a vma of zero page without checking overlap, so user can
construct a elf with section begin from 0x0 to trigger this BUGON().I
attach a testcase to trigger this bug
I don't know what about s390. However, I think it's safe to check
overlap before we actually insert a vma into vma list.
=20
And I also feel check vma overlap everywhere is unnecessary, because
invert_vm_struct will check it again, so the check is duplicated. It's
better to have invert_vm_struct return a value then let caller check if
it successes.
Here is a patch against 2.6.10.rc2-mm3
I have tested it on i386, x86_64 and ia64 machines.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Zou Nan hai <Nanhai.zou@intel.com>


-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Hugh Dickins
Sent: Friday, November 19, 2004 1:40 AM
To: Chris Wright
Cc: Andrew Morton; Linus Torvalds; Luck, Tony; Martin Schwidefsky; Andi
Kleen; linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] setup_arg_pages can insert overlapping vma

On Tue, 16 Nov 2004, Chris Wright wrote:
> Florian Heinz built an a.out binary that could map bss from 0x0 to
> 0xc0000000, and setup_arg_pages() would BUG() in insert_vma_struct
> because the arg pages overlapped.  This just checks before inserting,
> and bails out if it would overlap.

Chris, shouldn't your patch also cover the setup_arg_pages clones for
32-bit support on 64-bit architectures, with something - uncompiled,
untested - like the below?  I'm not sure how necessary the additional
vma->vm_start < mpnt->vm_end test is, but suspect ia64 might need it.

Signed-off-by: Hugh Dickins <hugh@veritas.com>

--- 2.6.10-rc2-bk2/arch/ia64/ia32/binfmt_elf32.c	2004-10-18
22:57:03.000000000 +0100
+++ linux/arch/ia64/ia32/binfmt_elf32.c	2004-11-18 17:17:57.000000000
+0000
@@ -214,6 +214,8 @@ ia32_setup_arg_pages (struct linux_binpr
=20
 	down_write(&current->mm->mmap_sem);
 	{
+		struct vm_area_struct *vma;
+
 		mpnt->vm_mm =3D current->mm;
 		mpnt->vm_start =3D PAGE_MASK & (unsigned long) bprm->p;
 		mpnt->vm_end =3D IA32_STACK_TOP;
@@ -225,6 +227,12 @@ ia32_setup_arg_pages (struct linux_binpr
 			mpnt->vm_flags =3D VM_STACK_FLAGS;
 		mpnt->vm_page_prot =3D (mpnt->vm_flags & VM_EXEC)?
 					PAGE_COPY_EXEC: PAGE_COPY;
+		vma =3D find_vma(current->mm, mpnt->vm_start);
+		if (vma && vma->vm_start < mpnt->vm_end) {
+			up_write(&current->mm->mmap_sem);
+			kmem_cache_free(vm_area_cachep, mpnt);
+			return -ENOMEM;
+		}
 		insert_vm_struct(current->mm, mpnt);
 		current->mm->stack_vm =3D current->mm->total_vm =3D
vma_pages(mpnt);
 	}
--- 2.6.10-rc2-bk2/arch/s390/kernel/compat_exec.c	2004-10-18
22:56:50.000000000 +0100
+++ linux/arch/s390/kernel/compat_exec.c	2004-11-18
17:17:57.000000000 +0000
@@ -62,12 +62,20 @@ int setup_arg_pages32(struct linux_binpr
=20
 	down_write(&mm->mmap_sem);
 	{
+		struct vm_area_struct *vma;
+
 		mpnt->vm_mm =3D mm;
 		mpnt->vm_start =3D PAGE_MASK & (unsigned long) bprm->p;
 		mpnt->vm_end =3D STACK_TOP;
 		/* executable stack setting would be applied here */
 		mpnt->vm_page_prot =3D PAGE_COPY;
 		mpnt->vm_flags =3D VM_STACK_FLAGS;
+		vma =3D find_vma(mm, mpnt->vm_start);
+		if (vma && vma->vm_start < mpnt->vm_end) {
+			up_write(&mm->mmap_sem);
+			kmem_cache_free(vm_area_cachep, mpnt);
+			return -ENOMEM;
+		}
 		insert_vm_struct(mm, mpnt);
 		mm->stack_vm =3D mm->total_vm =3D vma_pages(mpnt);
 	}=20
--- 2.6.10-rc2-bk2/arch/x86_64/ia32/ia32_binfmt.c	2004-11-15
16:20:34.000000000 +0000
+++ linux/arch/x86_64/ia32/ia32_binfmt.c	2004-11-18
17:17:57.000000000 +0000
@@ -357,6 +357,8 @@ int setup_arg_pages(struct linux_binprm=20
=20
 	down_write(&mm->mmap_sem);
 	{
+		struct vm_area_struct *vma;
+
 		mpnt->vm_mm =3D mm;
 		mpnt->vm_start =3D PAGE_MASK & (unsigned long) bprm->p;
 		mpnt->vm_end =3D IA32_STACK_TOP;
@@ -368,6 +370,12 @@ int setup_arg_pages(struct linux_binprm=20
 			mpnt->vm_flags =3D VM_STACK_FLAGS;
  		mpnt->vm_page_prot =3D (mpnt->vm_flags & VM_EXEC) ?=20
  			PAGE_COPY_EXEC : PAGE_COPY;
+		vma =3D find_vma(mm, mpnt->vm_start);
+		if (vma && vma->vm_start < mpnt->vm_end) {
+			up_write(&mm->mmap_sem);
+			kmem_cache_free(vm_area_cachep, mpnt);
+			return -ENOMEM;
+		}
 		insert_vm_struct(mm, mpnt);
 		mm->stack_vm =3D mm->total_vm =3D vma_pages(mpnt);
 	}=20

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

------_=_NextPart_001_01C4D1C1.8C2FFD87
Content-Type: application/x-gzip;
	name="ia64-vm-overlap.tar.gz"
Content-Transfer-Encoding: base64
Content-Description: ia64-vm-overlap.tar.gz
Content-Disposition: attachment;
	filename="ia64-vm-overlap.tar.gz"

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
UgBQAAA=

------_=_NextPart_001_01C4D1C1.8C2FFD87
Content-Type: application/octet-stream;
	name="vma-overlap-fix.patch"
Content-Transfer-Encoding: base64
Content-Description: vma-overlap-fix.patch
Content-Disposition: attachment;
	filename="vma-overlap-fix.patch"

ZGlmZiAtTnJhdXAgYS9hcmNoL2lhNjQvaWEzMi9iaW5mbXRfZWxmMzIuYyBiL2FyY2gvaWE2NC9p
YTMyL2JpbmZtdF9lbGYzMi5jCi0tLSBhL2FyY2gvaWE2NC9pYTMyL2JpbmZtdF9lbGYzMi5jCTIw
MDQtMTEtMjEgMjM6NTg6MjEuMzQ0NzAwMjE5IC0wODAwCisrKyBiL2FyY2gvaWE2NC9pYTMyL2Jp
bmZtdF9lbGYzMi5jCTIwMDQtMTEtMjEgMjM6NTg6NDUuMTQzNTI4MDUzIC0wODAwCkBAIC0xMDAs
NyArMTAwLDExIEBAIGlhNjRfZWxmMzJfaW5pdCAoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpCiAJCXZt
YS0+dm1fb3BzID0gJmlhMzJfc2hhcmVkX3BhZ2Vfdm1fb3BzOwogCQlkb3duX3dyaXRlKCZjdXJy
ZW50LT5tbS0+bW1hcF9zZW0pOwogCQl7Ci0JCQlpbnNlcnRfdm1fc3RydWN0KGN1cnJlbnQtPm1t
LCB2bWEpOworCQkJaWYgKGluc2VydF92bV9zdHJ1Y3QoY3VycmVudC0+bW0sIHZtYSkpIHsKKwkJ
CQlrbWVtX2NhY2hlX2ZyZWUodm1fYXJlYV9jYWNoZXAsIHZtYSk7CisJCQkJdXBfd3JpdGUoJmN1
cnJlbnQtPm1tLT5tbWFwX3NlbSk7CisJCQkJcmV0dXJuOworCQkJfQogCQl9CiAJCXVwX3dyaXRl
KCZjdXJyZW50LT5tbS0+bW1hcF9zZW0pOwogCX0KQEAgLTEyMyw3ICsxMjcsMTEgQEAgaWE2NF9l
bGYzMl9pbml0IChzdHJ1Y3QgcHRfcmVncyAqcmVncykKIAkJdm1hLT52bV9vcHMgPSAmaWEzMl9n
YXRlX3BhZ2Vfdm1fb3BzOwogCQlkb3duX3dyaXRlKCZjdXJyZW50LT5tbS0+bW1hcF9zZW0pOwog
CQl7Ci0JCQlpbnNlcnRfdm1fc3RydWN0KGN1cnJlbnQtPm1tLCB2bWEpOworCQkJaWYgKGluc2Vy
dF92bV9zdHJ1Y3QoY3VycmVudC0+bW0sIHZtYSkpIHsKKwkJCQlrbWVtX2NhY2hlX2ZyZWUodm1f
YXJlYV9jYWNoZXAsIHZtYSk7CisJCQkJdXBfd3JpdGUoJmN1cnJlbnQtPm1tLT5tbWFwX3NlbSk7
CisJCQkJcmV0dXJuOworCQkJfQogCQl9CiAJCXVwX3dyaXRlKCZjdXJyZW50LT5tbS0+bW1hcF9z
ZW0pOwogCX0KQEAgLTE0Miw3ICsxNTAsMTEgQEAgaWE2NF9lbGYzMl9pbml0IChzdHJ1Y3QgcHRf
cmVncyAqcmVncykKIAkJdm1hLT52bV9mbGFncyA9IFZNX1JFQUR8Vk1fV1JJVEV8Vk1fTUFZUkVB
RHxWTV9NQVlXUklURTsKIAkJZG93bl93cml0ZSgmY3VycmVudC0+bW0tPm1tYXBfc2VtKTsKIAkJ
ewotCQkJaW5zZXJ0X3ZtX3N0cnVjdChjdXJyZW50LT5tbSwgdm1hKTsKKwkJCWlmIChpbnNlcnRf
dm1fc3RydWN0KGN1cnJlbnQtPm1tLCB2bWEpKSB7CisJCQkJa21lbV9jYWNoZV9mcmVlKHZtX2Fy
ZWFfY2FjaGVwLCB2bWEpOworCQkJCXVwX3dyaXRlKCZjdXJyZW50LT5tbS0+bW1hcF9zZW0pOwor
CQkJCXJldHVybjsKKwkJCX0KIAkJfQogCQl1cF93cml0ZSgmY3VycmVudC0+bW0tPm1tYXBfc2Vt
KTsKIAl9CkBAIC0xOTAsNyArMjAyLDcgQEAgaWEzMl9zZXR1cF9hcmdfcGFnZXMgKHN0cnVjdCBs
aW51eF9iaW5wcgogCXVuc2lnbmVkIGxvbmcgc3RhY2tfYmFzZTsKIAlzdHJ1Y3Qgdm1fYXJlYV9z
dHJ1Y3QgKm1wbnQ7CiAJc3RydWN0IG1tX3N0cnVjdCAqbW0gPSBjdXJyZW50LT5tbTsKLQlpbnQg
aTsKKwlpbnQgaSwgcmV0OwogCiAJc3RhY2tfYmFzZSA9IElBMzJfU1RBQ0tfVE9QIC0gTUFYX0FS
R19QQUdFUypQQUdFX1NJWkU7CiAJbW0tPmFyZ19zdGFydCA9IGJwcm0tPnAgKyBzdGFja19iYXNl
OwpAQCAtMjI1LDcgKzIzNywxMSBAQCBpYTMyX3NldHVwX2FyZ19wYWdlcyAoc3RydWN0IGxpbnV4
X2JpbnByCiAJCQltcG50LT52bV9mbGFncyA9IFZNX1NUQUNLX0ZMQUdTOwogCQltcG50LT52bV9w
YWdlX3Byb3QgPSAobXBudC0+dm1fZmxhZ3MgJiBWTV9FWEVDKT8KIAkJCQkJUEFHRV9DT1BZX0VY
RUM6IFBBR0VfQ09QWTsKLQkJaW5zZXJ0X3ZtX3N0cnVjdChjdXJyZW50LT5tbSwgbXBudCk7CisJ
CWlmICgocmV0ID0gaW5zZXJ0X3ZtX3N0cnVjdChjdXJyZW50LT5tbSwgbXBudCkpKSB7CisJCQl1
cF93cml0ZSgmY3VycmVudC0+bW0tPm1tYXBfc2VtKTsKKwkJCWttZW1fY2FjaGVfZnJlZSh2bV9h
cmVhX2NhY2hlcCwgbXBudCk7CisJCQlyZXR1cm4gcmV0OworCQl9CiAJCWN1cnJlbnQtPm1tLT5z
dGFja192bSA9IGN1cnJlbnQtPm1tLT50b3RhbF92bSA9IHZtYV9wYWdlcyhtcG50KTsKIAl9CiAK
ZGlmZiAtTnJhdXAgYS9hcmNoL2lhNjQvbW0vaW5pdC5jIGIvYXJjaC9pYTY0L21tL2luaXQuYwot
LS0gYS9hcmNoL2lhNjQvbW0vaW5pdC5jCTIwMDQtMTEtMjEgMjM6NTg6MjEuMzQ1Njc2NzgyIC0w
ODAwCisrKyBiL2FyY2gvaWE2NC9tbS9pbml0LmMJMjAwNC0xMS0yMiAwMDowMDo1NC41MjczMTU1
MzAgLTA4MDAKQEAgLTEzMSw3ICsxMzEsMTMgQEAgaWE2NF9pbml0X2FkZHJfc3BhY2UgKHZvaWQp
CiAJCXZtYS0+dm1fZW5kID0gdm1hLT52bV9zdGFydCArIFBBR0VfU0laRTsKIAkJdm1hLT52bV9w
YWdlX3Byb3QgPSBwcm90ZWN0aW9uX21hcFtWTV9EQVRBX0RFRkFVTFRfRkxBR1MgJiAweDddOwog
CQl2bWEtPnZtX2ZsYWdzID0gVk1fREFUQV9ERUZBVUxUX0ZMQUdTIHwgVk1fR1JPV1NVUDsKLQkJ
aW5zZXJ0X3ZtX3N0cnVjdChjdXJyZW50LT5tbSwgdm1hKTsKKwkJZG93bl93cml0ZSgmY3VycmVu
dC0+bW0tPm1tYXBfc2VtKTsKKwkJaWYgKGluc2VydF92bV9zdHJ1Y3QoY3VycmVudC0+bW0sIHZt
YSkpIHsKKwkJCXVwX3dyaXRlKCZjdXJyZW50LT5tbS0+bW1hcF9zZW0pOworCQkJa21lbV9jYWNo
ZV9mcmVlKHZtX2FyZWFfY2FjaGVwLCB2bWEpOworCQkJcmV0dXJuOworCQl9CisJCXVwX3dyaXRl
KCZjdXJyZW50LT5tbS0+bW1hcF9zZW0pOwogCX0KIAogCS8qIG1hcCBOYVQtcGFnZSBhdCBhZGRy
ZXNzIHplcm8gdG8gc3BlZWQgdXAgc3BlY3VsYXRpdmUgZGVyZWZlcmVuY2luZyBvZiBOVUxMOiAq
LwpAQCAtMTQzLDcgKzE0OSwxMyBAQCBpYTY0X2luaXRfYWRkcl9zcGFjZSAodm9pZCkKIAkJCXZt
YS0+dm1fZW5kID0gUEFHRV9TSVpFOwogCQkJdm1hLT52bV9wYWdlX3Byb3QgPSBfX3BncHJvdChw
Z3Byb3RfdmFsKFBBR0VfUkVBRE9OTFkpIHwgX1BBR0VfTUFfTkFUKTsKIAkJCXZtYS0+dm1fZmxh
Z3MgPSBWTV9SRUFEIHwgVk1fTUFZUkVBRCB8IFZNX0lPIHwgVk1fUkVTRVJWRUQ7Ci0JCQlpbnNl
cnRfdm1fc3RydWN0KGN1cnJlbnQtPm1tLCB2bWEpOworCQkJZG93bl93cml0ZSgmY3VycmVudC0+
bW0tPm1tYXBfc2VtKTsKKwkJCWlmIChpbnNlcnRfdm1fc3RydWN0KGN1cnJlbnQtPm1tLCB2bWEp
KSB7CisJCQkJdXBfd3JpdGUoJmN1cnJlbnQtPm1tLT5tbWFwX3NlbSk7CisJCQkJa21lbV9jYWNo
ZV9mcmVlKHZtX2FyZWFfY2FjaGVwLCB2bWEpOworCQkJCXJldHVybjsKKwkJCX0KKwkJCXVwX3dy
aXRlKCZjdXJyZW50LT5tbS0+bW1hcF9zZW0pOwogCQl9CiAJfQogfQpkaWZmIC1OcmF1cCBhL2Fy
Y2gvczM5MC9rZXJuZWwvY29tcGF0X2V4ZWMuYyBiL2FyY2gvczM5MC9rZXJuZWwvY29tcGF0X2V4
ZWMuYwotLS0gYS9hcmNoL3MzOTAva2VybmVsL2NvbXBhdF9leGVjLmMJMjAwNC0xMS0yMSAyMzo1
ODoyMS40Mjg2ODQ1OTMgLTA4MDAKKysrIGIvYXJjaC9zMzkwL2tlcm5lbC9jb21wYXRfZXhlYy5j
CTIwMDQtMTEtMjEgMjM6NTg6NDUuMTQ0NTA0NjE1IC0wODAwCkBAIC0zOSw3ICszOSw3IEBAIGlu
dCBzZXR1cF9hcmdfcGFnZXMzMihzdHJ1Y3QgbGludXhfYmlucHIKIAl1bnNpZ25lZCBsb25nIHN0
YWNrX2Jhc2U7CiAJc3RydWN0IHZtX2FyZWFfc3RydWN0ICptcG50OwogCXN0cnVjdCBtbV9zdHJ1
Y3QgKm1tID0gY3VycmVudC0+bW07Ci0JaW50IGk7CisJaW50IGksIHJldDsKIAogCXN0YWNrX2Jh
c2UgPSBTVEFDS19UT1AgLSBNQVhfQVJHX1BBR0VTKlBBR0VfU0laRTsKIAltbS0+YXJnX3N0YXJ0
ID0gYnBybS0+cCArIHN0YWNrX2Jhc2U7CkBAIC02OCw3ICs2OCwxMSBAQCBpbnQgc2V0dXBfYXJn
X3BhZ2VzMzIoc3RydWN0IGxpbnV4X2JpbnByCiAJCS8qIGV4ZWN1dGFibGUgc3RhY2sgc2V0dGlu
ZyB3b3VsZCBiZSBhcHBsaWVkIGhlcmUgKi8KIAkJbXBudC0+dm1fcGFnZV9wcm90ID0gUEFHRV9D
T1BZOwogCQltcG50LT52bV9mbGFncyA9IFZNX1NUQUNLX0ZMQUdTOwotCQlpbnNlcnRfdm1fc3Ry
dWN0KG1tLCBtcG50KTsKKwkJaWYgKChyZXQgPSBpbnNlcnRfdm1fc3RydWN0KG1tLCBtcG50KSkp
IHsKKwkJCXVwX3dyaXRlKCZtbS0+bW1hcF9zZW0pOworCQkJa21lbV9jYWNoZV9mcmVlKHZtX2Fy
ZWFfY2FjaGVwLCBtcG50KTsKKwkJCXJldHVybiByZXQ7CisJCX0KIAkJbW0tPnN0YWNrX3ZtID0g
bW0tPnRvdGFsX3ZtID0gdm1hX3BhZ2VzKG1wbnQpOwogCX0gCiAKZGlmZiAtTnJhdXAgYS9hcmNo
L3g4Nl82NC9pYTMyL2lhMzJfYmluZm10LmMgYi9hcmNoL3g4Nl82NC9pYTMyL2lhMzJfYmluZm10
LmMKLS0tIGEvYXJjaC94ODZfNjQvaWEzMi9pYTMyX2JpbmZtdC5jCTIwMDQtMTEtMjEgMjM6NTg6
MjEuNDIzODAxNzgxIC0wODAwCisrKyBiL2FyY2gveDg2XzY0L2lhMzIvaWEzMl9iaW5mbXQuYwky
MDA0LTExLTIxIDIzOjU4OjQ1LjE0NTQ4MTE3OCAtMDgwMApAQCAtMzM1LDcgKzMzNSw3IEBAIGlu
dCBzZXR1cF9hcmdfcGFnZXMoc3RydWN0IGxpbnV4X2JpbnBybSAKIAl1bnNpZ25lZCBsb25nIHN0
YWNrX2Jhc2U7CiAJc3RydWN0IHZtX2FyZWFfc3RydWN0ICptcG50OwogCXN0cnVjdCBtbV9zdHJ1
Y3QgKm1tID0gY3VycmVudC0+bW07Ci0JaW50IGk7CisJaW50IGksIHJldDsKIAogCXN0YWNrX2Jh
c2UgPSBJQTMyX1NUQUNLX1RPUCAtIE1BWF9BUkdfUEFHRVMgKiBQQUdFX1NJWkU7CiAJbW0tPmFy
Z19zdGFydCA9IGJwcm0tPnAgKyBzdGFja19iYXNlOwpAQCAtMzY5LDcgKzM2OSwxMSBAQCBpbnQg
c2V0dXBfYXJnX3BhZ2VzKHN0cnVjdCBsaW51eF9iaW5wcm0gCiAJCQltcG50LT52bV9mbGFncyA9
IFZNX1NUQUNLX0ZMQUdTOwogIAkJbXBudC0+dm1fcGFnZV9wcm90ID0gKG1wbnQtPnZtX2ZsYWdz
ICYgVk1fRVhFQykgPyAKICAJCQlQQUdFX0NPUFlfRVhFQyA6IFBBR0VfQ09QWTsKLQkJaW5zZXJ0
X3ZtX3N0cnVjdChtbSwgbXBudCk7CisJCWlmICgocmV0ID0gaW5zZXJ0X3ZtX3N0cnVjdChtbSwg
bXBudCkpKSB7CisJCQl1cF93cml0ZSgmbW0tPm1tYXBfc2VtKTsKKwkJCWttZW1fY2FjaGVfZnJl
ZSh2bV9hcmVhX2NhY2hlcCwgbXBudCk7CisJCQlyZXR1cm4gcmV0OworCQl9CiAJCW1tLT5zdGFj
a192bSA9IG1tLT50b3RhbF92bSA9IHZtYV9wYWdlcyhtcG50KTsKIAl9IAogCmRpZmYgLU5yYXVw
IGEvZnMvZXhlYy5jIGIvZnMvZXhlYy5jCi0tLSBhL2ZzL2V4ZWMuYwkyMDA0LTExLTIxIDIzOjU4
OjI3Ljk3MTY1MzI2MyAtMDgwMAorKysgYi9mcy9leGVjLmMJMjAwNC0xMS0yMiAwMDoyNTozOS44
ODU2OTU3NzIgLTA4MDAKQEAgLTM1MSw3ICszNTEsNyBAQCBpbnQgc2V0dXBfYXJnX3BhZ2VzKHN0
cnVjdCBsaW51eF9iaW5wcm0gCiAJdW5zaWduZWQgbG9uZyBzdGFja19iYXNlOwogCXN0cnVjdCB2
bV9hcmVhX3N0cnVjdCAqbXBudDsKIAlzdHJ1Y3QgbW1fc3RydWN0ICptbSA9IGN1cnJlbnQtPm1t
OwotCWludCBpOworCWludCBpLCByZXQ7CiAJbG9uZyBhcmdfc2l6ZTsKIAogI2lmZGVmIENPTkZJ
R19TVEFDS19HUk9XU1VQCkBAIC00MjQsNyArNDI0LDYgQEAgaW50IHNldHVwX2FyZ19wYWdlcyhz
dHJ1Y3QgbGludXhfYmlucHJtIAogCiAJZG93bl93cml0ZSgmbW0tPm1tYXBfc2VtKTsKIAl7Ci0J
CXN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hOwogCQltcG50LT52bV9tbSA9IG1tOwogI2lmZGVm
IENPTkZJR19TVEFDS19HUk9XU1VQCiAJCW1wbnQtPnZtX3N0YXJ0ID0gc3RhY2tfYmFzZTsKQEAg
LTQ0NCwxMyArNDQzLDExIEBAIGludCBzZXR1cF9hcmdfcGFnZXMoc3RydWN0IGxpbnV4X2JpbnBy
bSAKIAkJCW1wbnQtPnZtX2ZsYWdzID0gVk1fU1RBQ0tfRkxBR1M7CiAJCW1wbnQtPnZtX2ZsYWdz
IHw9IG1tLT5kZWZfZmxhZ3M7CiAJCW1wbnQtPnZtX3BhZ2VfcHJvdCA9IHByb3RlY3Rpb25fbWFw
W21wbnQtPnZtX2ZsYWdzICYgMHg3XTsKLQkJdm1hID0gZmluZF92bWEobW0sIG1wbnQtPnZtX3N0
YXJ0KTsKLQkJaWYgKHZtYSkgeworCQlpZiAoKHJldCA9IGluc2VydF92bV9zdHJ1Y3QobW0sIG1w
bnQpKSkgewogCQkJdXBfd3JpdGUoJm1tLT5tbWFwX3NlbSk7CiAJCQlrbWVtX2NhY2hlX2ZyZWUo
dm1fYXJlYV9jYWNoZXAsIG1wbnQpOwotCQkJcmV0dXJuIC1FTk9NRU07CisJCQlyZXR1cm4gcmV0
OwogCQl9Ci0JCWluc2VydF92bV9zdHJ1Y3QobW0sIG1wbnQpOwogCQltbS0+c3RhY2tfdm0gPSBt
bS0+dG90YWxfdm0gPSB2bWFfcGFnZXMobXBudCk7CiAJfQogCmRpZmYgLU5yYXVwIGEvaW5jbHVk
ZS9saW51eC9tbS5oIGIvaW5jbHVkZS9saW51eC9tbS5oCi0tLSBhL2luY2x1ZGUvbGludXgvbW0u
aAkyMDA0LTExLTIxIDIzOjU4OjIxLjU3NTE2ODk2NiAtMDgwMAorKysgYi9pbmNsdWRlL2xpbnV4
L21tLmgJMjAwNC0xMS0yMSAyMzo1ODo0NS4xNDc0MzQzMDMgLTA4MDAKQEAgLTc0Myw3ICs3NDMs
NyBAQCBleHRlcm4gc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWFfbWVyZ2UoCiBleHRlcm4gc3Ry
dWN0IGFub25fdm1hICpmaW5kX21lcmdlYWJsZV9hbm9uX3ZtYShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1
Y3QgKik7CiBleHRlcm4gaW50IHNwbGl0X3ZtYShzdHJ1Y3QgbW1fc3RydWN0ICosCiAJc3RydWN0
IHZtX2FyZWFfc3RydWN0ICosIHVuc2lnbmVkIGxvbmcgYWRkciwgaW50IG5ld19iZWxvdyk7Ci1l
eHRlcm4gdm9pZCBpbnNlcnRfdm1fc3RydWN0KHN0cnVjdCBtbV9zdHJ1Y3QgKiwgc3RydWN0IHZt
X2FyZWFfc3RydWN0ICopOworZXh0ZXJuIGludCBpbnNlcnRfdm1fc3RydWN0KHN0cnVjdCBtbV9z
dHJ1Y3QgKiwgc3RydWN0IHZtX2FyZWFfc3RydWN0ICopOwogZXh0ZXJuIHZvaWQgX192bWFfbGlu
a19yYihzdHJ1Y3QgbW1fc3RydWN0ICosIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqLAogCXN0cnVj
dCByYl9ub2RlICoqLCBzdHJ1Y3QgcmJfbm9kZSAqKTsKIGV4dGVybiBzdHJ1Y3Qgdm1fYXJlYV9z
dHJ1Y3QgKmNvcHlfdm1hKHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqKiwKZGlmZiAtTnJhdXAgYS9t
bS9tbWFwLmMgYi9tbS9tbWFwLmMKLS0tIGEvbW0vbW1hcC5jCTIwMDQtMTEtMjEgMjM6NTg6Mjku
MDU5NTQzODc1IC0wODAwCisrKyBiL21tL21tYXAuYwkyMDA0LTExLTIxIDIzOjU4OjQ1LjE0OTM4
NzQyOCAtMDgwMApAQCAtMTkxMyw3ICsxOTEzLDcgQEAgdm9pZCBleGl0X21tYXAoc3RydWN0IG1t
X3N0cnVjdCAqbW0pCiAgKiBhbmQgaW50byB0aGUgaW5vZGUncyBpX21tYXAgdHJlZS4gIElmIHZt
X2ZpbGUgaXMgbm9uLU5VTEwKICAqIHRoZW4gaV9tbWFwX2xvY2sgaXMgdGFrZW4gaGVyZS4KICAq
Lwotdm9pZCBpbnNlcnRfdm1fc3RydWN0KHN0cnVjdCBtbV9zdHJ1Y3QgKiBtbSwgc3RydWN0IHZt
X2FyZWFfc3RydWN0ICogdm1hKQoraW50IGluc2VydF92bV9zdHJ1Y3Qoc3RydWN0IG1tX3N0cnVj
dCAqIG1tLCBzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKiB2bWEpCiB7CiAJc3RydWN0IHZtX2FyZWFf
c3RydWN0ICogX192bWEsICogcHJldjsKIAlzdHJ1Y3QgcmJfbm9kZSAqKiByYl9saW5rLCAqIHJi
X3BhcmVudDsKQEAgLTE5MzYsOCArMTkzNiw5IEBAIHZvaWQgaW5zZXJ0X3ZtX3N0cnVjdChzdHJ1
Y3QgbW1fc3RydWN0ICoKIAl9CiAJX192bWEgPSBmaW5kX3ZtYV9wcmVwYXJlKG1tLHZtYS0+dm1f
c3RhcnQsJnByZXYsJnJiX2xpbmssJnJiX3BhcmVudCk7CiAJaWYgKF9fdm1hICYmIF9fdm1hLT52
bV9zdGFydCA8IHZtYS0+dm1fZW5kKQotCQlCVUcoKTsKKwkJcmV0dXJuIC1FTk9NRU07CiAJdm1h
X2xpbmsobW0sIHZtYSwgcHJldiwgcmJfbGluaywgcmJfcGFyZW50KTsKKwlyZXR1cm4gMDsKIH0K
IAogLyoK

------_=_NextPart_001_01C4D1C1.8C2FFD87--
