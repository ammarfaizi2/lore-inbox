Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129413AbQLGOXQ>; Thu, 7 Dec 2000 09:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129784AbQLGOXF>; Thu, 7 Dec 2000 09:23:05 -0500
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:18073 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S129413AbQLGOWv>; Thu, 7 Dec 2000 09:22:51 -0500
From: schwidefsky@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: linux-kernel@vger.kernel.org
Message-ID: <C12569AE.004C2D5A.00@d12mta07.de.ibm.com>
Date: Thu, 7 Dec 2000 14:15:54 +0100
Subject: 64 bit s390 and 2.4.0-test11 (was Memory management bug)
Mime-Version: 1.0
Content-type: multipart/mixed; 
	Boundary="0__=kl0sDe32BfBi9eWGCcDDXHWRMw6LECXJDXljxfHC2cdxKLi0NNIhk9Ek"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0__=kl0sDe32BfBi9eWGCcDDXHWRMw6LECXJDXljxfHC2cdxKLi0NNIhk9Ek
Content-type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-transfer-encoding: quoted-printable




Hi,
good news (at least for us): linux on the 64 bit S/390 (aka zServer)
is now running pretty stable. Our implementation of ptep_get_and_clear
didn't clear the pte if the invalid bit was already set. But a swapped
page has the invalid bit set too and in that case we didn't clear the
pte. That did cause the BUG() in swap_state.c:60.

With this new backend in mind I'd like to suggest two small changes
for the common code.
1) move establish_pte to the architecture dependent folders. Our
implementation looks like this:

static inline void ptep_invalidate_and_flush(pte_t *ptep, unsigned long=

addr)
{
        if (!(pte_val(*ptep) & _PAGE_INVALID))
                __asm__ __volatile__ ("ipte %0,%1" : : "a" (ptep), "a"
(addr));
}

static inline void establish_pte(struct vm_area_struct * vma,
                                 unsigned long address,
                                 pte_t *page_table, pte_t entry)
{
        ptep_invalidate_and_flush(page_table, address);
        set_pte(page_table, entry);
}

The question I face at the moment is: where is the right place in
include/asm for establish_pte. I added it to include/asm-generic/pgtabl=
e.h
and include/asm-i386/pgtable.h but I now face the problem that the
default implementation has a call to flush_tlb_page and that is defined=

in pgalloc.h. I added an #include <asm/pgalloc.h> but I fear that this
could
cause compile errors. For details see establish_pte.diff.

2) add a check for EI_CLASS in the binfmt_elf loader. We will use the
same EM_S390 for 31 bit and 64 bit binaries. The distinction is done
by means of the EI_CLASS byte in the ELF header. See binfmt_elf.diff

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Sch=F6naicherstr. 220, D-71032 B=F6blingen, Telefon: 49 - (0)7031 - 16-=
2247
E-Mail: schwidefsky@de.ibm.com

(See attached file: establish_pte.diff)(See attached file: binfmt_elf.d=
iff)
=

--0__=kl0sDe32BfBi9eWGCcDDXHWRMw6LECXJDXljxfHC2cdxKLi0NNIhk9Ek
Content-type: application/octet-stream; 
	name="establish_pte.diff"
Content-Disposition: attachment; filename="establish_pte.diff"
Content-transfer-encoding: base64

ZGlmZiAtdSAtciAtLW5ldy1maWxlIGxpbnV4LTIuNC4wLXRlc3QxMS9pbmNsdWRlL2FzbS1nZW5l
cmljL3BndGFibGUuaCBsaW51eC0yLjQuMC10ZXN0MTEtZXN0YWJsaXNoX3B0ZS9pbmNsdWRlL2Fz
bS1nZW5lcmljL3BndGFibGUuaAotLS0gbGludXgtMi40LjAtdGVzdDExL2luY2x1ZGUvYXNtLWdl
bmVyaWMvcGd0YWJsZS5oCUZyaSBPY3QgMjAgMDA6NTE6MTYgMjAwMAorKysgbGludXgtMi40LjAt
dGVzdDExLWVzdGFibGlzaF9wdGUvaW5jbHVkZS9hc20tZ2VuZXJpYy9wZ3RhYmxlLmgJV2VkIERl
YyAgNiAyMDo1MjowMCAyMDAwCkBAIC0xLDYgKzEsOCBAQAogI2lmbmRlZiBfQVNNX0dFTkVSSUNf
UEdUQUJMRV9ICiAjZGVmaW5lIF9BU01fR0VORVJJQ19QR1RBQkxFX0gKCisjaW5jbHVkZSA8YXNt
L3BnYWxsb2MuaD4KKwogc3RhdGljIGlubGluZSBpbnQgcHRlcF90ZXN0X2FuZF9jbGVhcl95b3Vu
ZyhwdGVfdCAqcHRlcCkKIHsKIAlwdGVfdCBwdGUgPSAqcHRlcDsKQEAgLTQwLDQgKzQwLDE3IEBA
CiAKICNkZWZpbmUgcHRlX3NhbWUoQSxCKQkocHRlX3ZhbChBKSA9PSBwdGVfdmFsKEIpKQogCisv
KgorICogRXN0YWJsaXNoIGEgbmV3IG1hcHBpbmc6CisgKiAgLSBmbHVzaCB0aGUgb2xkIG9uZQor
ICogIC0gdXBkYXRlIHRoZSBwYWdlIHRhYmxlcworICogIC0gaW5mb3JtIHRoZSBUTEIgYWJvdXQg
dGhlIG5ldyBvbmUKKyAqLworc3RhdGljIGlubGluZSB2b2lkIGVzdGFibGlzaF9wdGUoc3RydWN0
IHZtX2FyZWFfc3RydWN0ICogdm1hLCB1bnNpZ25lZCBsb25nIGFkZHJlc3MsIHB0ZV90ICpwYWdl
X3RhYmxlLCBwdGVfdCBlbnRyeSkKK3sKKwlzZXRfcHRlKHBhZ2VfdGFibGUsIGVudHJ5KTsKKwlm
bHVzaF90bGJfcGFnZSh2bWEsIGFkZHJlc3MpOworCXVwZGF0ZV9tbXVfY2FjaGUodm1hLCBhZGRy
ZXNzLCBlbnRyeSk7Cit9CisKICNlbmRpZiAvKiBfQVNNX0dFTkVSSUNfUEdUQUJMRV9IICovCmRp
ZmYgLXUgLXIgLS1uZXctZmlsZSBsaW51eC0yLjQuMC10ZXN0MTEvaW5jbHVkZS9hc20taTM4Ni9w
Z3RhYmxlLmggbGludXgtMi40LjAtdGVzdDExLWVzdGFibGlzaF9wdGUvaW5jbHVkZS9hc20taTM4
Ni9wZ3RhYmxlLmgKLS0tIGxpbnV4LTIuNC4wLXRlc3QxMS9pbmNsdWRlL2FzbS1pMzg2L3BndGFi
bGUuaAlTdW4gTm92IDE5IDA1OjU2OjU5IDIwMDAKKysrIGxpbnV4LTIuNC4wLXRlc3QxMS1lc3Rh
Ymxpc2hfcHRlL2luY2x1ZGUvYXNtLWkzODYvcGd0YWJsZS5oCVdlZCBEZWMgIDYgMjA6NTM6NDMg
MjAwMApAQCAtMjg3LDYgKzI4NywyMCBAQAogc3RhdGljIGlubGluZSB2b2lkIHB0ZXBfbWtkaXJ0
eShwdGVfdCAqcHRlcCkJCQl7IHNldF9iaXQoX1BBR0VfQklUX1JXLCBwdGVwKTsgfQogCiAvKgor
ICogRXN0YWJsaXNoIGEgbmV3IG1hcHBpbmc6CisgKiAgLSBmbHVzaCB0aGUgb2xkIG9uZQorICog
IC0gdXBkYXRlIHRoZSBwYWdlIHRhYmxlcworICogIC0gaW5mb3JtIHRoZSBUTEIgYWJvdXQgdGhl
IG5ldyBvbmUKKyAqLworc3RhdGljIGlubGluZSB2b2lkIGVzdGFibGlzaF9wdGUoc3RydWN0IHZt
X2FyZWFfc3RydWN0ICogdm1hLCB1bnNpZ25lZCBsb25nIGFkZHJlc3MsIHB0ZV90ICpwYWdlX3Rh
YmxlLCBwdGVfdCBlbnRyeSkKK3sKKwlzZXRfcHRlKHBhZ2VfdGFibGUsIGVudHJ5KTsKKwlpZiAo
dm1hLT52bV9tbSA9PSBjdXJyZW50LT5hY3RpdmVfbW0pCisJCV9fZmx1c2hfdGxiX29uZShhZGRy
KTsKKwl1cGRhdGVfbW11X2NhY2hlKHZtYSwgYWRkcmVzcywgZW50cnkpOworfQorCisvKgogICog
Q29udmVyc2lvbiBmdW5jdGlvbnM6IGNvbnZlcnQgYSBwYWdlIGFuZCBwcm90ZWN0aW9uIHRvIGEg
cGFnZSBlbnRyeSwKICAqIGFuZCBhIHBhZ2UgZW50cnkgYW5kIHBhZ2UgZGlyZWN0b3J5IHRvIHRo
ZSBwYWdlIHRoZXkgcmVmZXIgdG8uCiAgKi8KZGlmZiAtdSAtciAtLW5ldy1maWxlIGxpbnV4LTIu
NC4wLXRlc3QxMS9tbS9tZW1vcnkuYyBsaW51eC0yLjQuMC10ZXN0MTEtZXN0YWJsaXNoX3B0ZS9t
bS9tZW1vcnkuYwotLS0gbGludXgtMi40LjAtdGVzdDExL21tL21lbW9yeS5jCVdlZCBOb3YgIDEg
MTY6NDU6MDkgMjAwMAorKysgbGludXgtMi40LjAtdGVzdDExLWVzdGFibGlzaF9wdGUvbW0vbWVt
b3J5LmMJV2VkIERlYyAgNiAyMDo1MjowMCAyMDAwCkBAIC03NzMsMTkgKzc3Myw2IEBACiAJcmV0
dXJuIGVycm9yOwogfQogCi0vKgotICogRXN0YWJsaXNoIGEgbmV3IG1hcHBpbmc6Ci0gKiAgLSBm
bHVzaCB0aGUgb2xkIG9uZQotICogIC0gdXBkYXRlIHRoZSBwYWdlIHRhYmxlcwotICogIC0gaW5m
b3JtIHRoZSBUTEIgYWJvdXQgdGhlIG5ldyBvbmUKLSAqLwotc3RhdGljIGlubGluZSB2b2lkIGVz
dGFibGlzaF9wdGUoc3RydWN0IHZtX2FyZWFfc3RydWN0ICogdm1hLCB1bnNpZ25lZCBsb25nIGFk
ZHJlc3MsIHB0ZV90ICpwYWdlX3RhYmxlLCBwdGVfdCBlbnRyeSkKLXsKLQlzZXRfcHRlKHBhZ2Vf
dGFibGUsIGVudHJ5KTsKLQlmbHVzaF90bGJfcGFnZSh2bWEsIGFkZHJlc3MpOwotCXVwZGF0ZV9t
bXVfY2FjaGUodm1hLCBhZGRyZXNzLCBlbnRyeSk7Ci19Ci0KIHN0YXRpYyBpbmxpbmUgdm9pZCBi
cmVha19jb3coc3RydWN0IHZtX2FyZWFfc3RydWN0ICogdm1hLCBzdHJ1Y3QgcGFnZSAqCW9sZF9w
YWdlLCBzdHJ1Y3QgcGFnZSAqIG5ld19wYWdlLCB1bnNpZ25lZCBsb25nIGFkZHJlc3MsIAogCQlw
dGVfdCAqcGFnZV90YWJsZSkKIHsK

--0__=kl0sDe32BfBi9eWGCcDDXHWRMw6LECXJDXljxfHC2cdxKLi0NNIhk9Ek
Content-type: application/octet-stream; 
	name="binfmt_elf.diff"
Content-Disposition: attachment; filename="binfmt_elf.diff"
Content-transfer-encoding: base64

ZGlmZiAtdSAtciAtLW5ldy1maWxlIGxpbnV4LTIuNC4wLXRlc3QxMS9mcy9iaW5mbXRfZWxmLmMg
bGludXgtMi40LjAtdGVzdDExLWVzdGFibGlzaF9wdGUvZnMvYmluZm10X2VsZi5jCi0tLSBsaW51
eC0yLjQuMC10ZXN0MTEvZnMvYmluZm10X2VsZi5jCUZyaSBPY3QgMjcgMjA6MDQ6NDMgMjAwMAor
KysgbGludXgtMi40LjAtdGVzdDExLWVzdGFibGlzaF9wdGUvZnMvYmluZm10X2VsZi5jCVdlZCBE
ZWMgIDYgMjA6NTI6MDAgMjAwMApAQCAtMjQ3LDYgKzI0Nyw4IEBACiAJCWdvdG8gb3V0OwogCWlm
ICghZWxmX2NoZWNrX2FyY2goaW50ZXJwX2VsZl9leCkpCiAJCWdvdG8gb3V0OworICAgICAgICBp
ZiAoaW50ZXJwX2VsZl9leC0+ZV9pZGVudFtFSV9DTEFTU10gIT0gRUxGX0NMQVNTKQorICAgICAg
ICAgICAgICAgIGdvdG8gb3V0OwogCWlmICghaW50ZXJwcmV0ZXItPmZfb3AtPm1tYXApCiAJCWdv
dG8gb3V0OwogCkBAIC00MjIsNiArNDI0LDggQEAKIAlpZiAoZWxmX2V4LmVfdHlwZSAhPSBFVF9F
WEVDICYmIGVsZl9leC5lX3R5cGUgIT0gRVRfRFlOKQogCQlnb3RvIG91dDsKIAlpZiAoIWVsZl9j
aGVja19hcmNoKCZlbGZfZXgpKQorCQlnb3RvIG91dDsKKwlpZiAoZWxmX2V4LmVfaWRlbnRbRUlf
Q0xBU1NdICE9IEVMRl9DTEFTUykKIAkJZ290byBvdXQ7CiAJaWYgKCFicHJtLT5maWxlLT5mX29w
fHwhYnBybS0+ZmlsZS0+Zl9vcC0+bW1hcCkKIAkJZ290byBvdXQ7Cg==

--0__=kl0sDe32BfBi9eWGCcDDXHWRMw6LECXJDXljxfHC2cdxKLi0NNIhk9Ek--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
