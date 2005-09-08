Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932703AbVIHPfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703AbVIHPfv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932704AbVIHPfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:35:50 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:25959
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932703AbVIHPft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:35:49 -0400
Message-Id: <432076B502000078000244B4@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:36:53 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] introduce THREAD_ORDER to i386
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartD4F6BA85.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartD4F6BA85.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

This introduces THREAD_ORDER (to accompany THREAD_SIZE, which now
becomes
a derivate of the former) in order to easily pass this to page
allocation
routines. Code consuming this (fixing the double fault handler to use
per-
CPU stacks) will soon follow.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/arch/i386/kernel/asm-offsets.c
2.6.13-i386-THREAD_SIZE_asm/arch/i386/kernel/asm-offsets.c
--- 2.6.13/arch/i386/kernel/asm-offsets.c	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-i386-THREAD_SIZE_asm/arch/i386/kernel/asm-offsets.c	2005-09-02
16:19:30.000000000 +0200
@@ -68,5 +68,6 @@ void foo(void)
 		 sizeof(struct tss_struct));
 
 	DEFINE(PAGE_SIZE_asm, PAGE_SIZE);
+	DEFINE(THREAD_SIZE_asm, THREAD_SIZE);
 	DEFINE(VSYSCALL_BASE, __fix_to_virt(FIX_VSYSCALL));
 }
diff -Npru 2.6.13/arch/i386/kernel/entry.S
2.6.13-i386-THREAD_SIZE_asm/arch/i386/kernel/entry.S
--- 2.6.13/arch/i386/kernel/entry.S	2005-08-29 01:41:01.000000000
+0200
+++
2.6.13-i386-THREAD_SIZE_asm/arch/i386/kernel/entry.S	2005-09-02
16:17:45.000000000 +0200
@@ -537,8 +537,8 @@ ENTRY(nmi)
 	/* Do not access memory above the end of our stack page,
 	 * it might not exist.
 	 */
-	andl $(THREAD_SIZE-1),%eax
-	cmpl $(THREAD_SIZE-20),%eax
+	andl $(THREAD_SIZE_asm-1),%eax
+	cmpl $(THREAD_SIZE_asm-20),%eax
 	popl %eax
 	jae nmi_stack_correct
 	cmpl $sysenter_entry,12(%esp)
diff -Npru 2.6.13/arch/i386/kernel/head.S
2.6.13-i386-THREAD_SIZE_asm/arch/i386/kernel/head.S
--- 2.6.13/arch/i386/kernel/head.S	2005-08-29 01:41:01.000000000
+0200
+++
2.6.13-i386-THREAD_SIZE_asm/arch/i386/kernel/head.S	2005-09-01
13:06:01.000000000 +0200
@@ -425,7 +425,7 @@ ENTRY(empty_zero_page)
 .data
 
 ENTRY(stack_start)
-	.long init_thread_union+THREAD_SIZE
+	.long init_thread_union+THREAD_SIZE_asm
 	.long __BOOT_DS
 
 ready:	.byte 0
diff -Npru 2.6.13/arch/i386/kernel/vmlinux.lds.S
2.6.13-i386-THREAD_SIZE_asm/arch/i386/kernel/vmlinux.lds.S
--- 2.6.13/arch/i386/kernel/vmlinux.lds.S	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-i386-THREAD_SIZE_asm/arch/i386/kernel/vmlinux.lds.S	2005-09-05
10:51:10.000000000 +0200
@@ -4,8 +4,9 @@
 
 #define LOAD_OFFSET __PAGE_OFFSET
 
+#include <linux/config.h>
 #include <asm-generic/vmlinux.lds.h>
-#include <asm/thread_info.h>
+#include <asm/asm_offsets.h>
 #include <asm/page.h>
 
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
@@ -62,7 +63,7 @@ SECTIONS
   .data.read_mostly : AT(ADDR(.data.read_mostly) - LOAD_OFFSET) {
*(.data.read_mostly) }
   _edata = .;			/* End of data section */
 
-  . = ALIGN(THREAD_SIZE);	/* init_task */
+  . = ALIGN(THREAD_SIZE_asm);	/* init_task */
   .data.init_task : AT(ADDR(.data.init_task) - LOAD_OFFSET) {
 	*(.data.init_task)
   }
diff -Npru 2.6.13/include/asm-i386/thread_info.h
2.6.13-i386-THREAD_SIZE_asm/include/asm-i386/thread_info.h
--- 2.6.13/include/asm-i386/thread_info.h	2005-08-29
01:41:01.000000000 +0200
+++
2.6.13-i386-THREAD_SIZE_asm/include/asm-i386/thread_info.h	2005-09-01
11:32:12.000000000 +0200
@@ -54,10 +54,11 @@ struct thread_info {
 
 #define PREEMPT_ACTIVE		0x10000000
 #ifdef CONFIG_4KSTACKS
-#define THREAD_SIZE            (4096)
+#define THREAD_ORDER 0
 #else
-#define THREAD_SIZE		(8192)
+#define THREAD_ORDER 1
 #endif
+#define THREAD_SIZE (PAGE_SIZE << THREAD_ORDER)
 
 #define STACK_WARN             (THREAD_SIZE/8)
 /*
@@ -118,12 +119,12 @@ register unsigned long current_stack_poi
 
 /* how to get the thread information struct from ASM */
 #define GET_THREAD_INFO(reg) \
-	movl $-THREAD_SIZE, reg; \
+	movl $-THREAD_SIZE_asm, reg; \
 	andl %esp, reg
 
 /* use this one if reg already contains %esp */
 #define GET_THREAD_INFO_WITH_ESP(reg) \
-	andl $-THREAD_SIZE, reg
+	andl $-THREAD_SIZE_asm, reg
 
 #endif
 


--=__PartD4F6BA85.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-i386-THREAD_ORDER.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-i386-THREAD_ORDER.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKClRoaXMgaW50cm9kdWNlcyBUSFJFQURfT1JE
RVIgKHRvIGFjY29tcGFueSBUSFJFQURfU0laRSwgd2hpY2ggbm93IGJlY29tZXMKYSBkZXJpdmF0
ZSBvZiB0aGUgZm9ybWVyKSBpbiBvcmRlciB0byBlYXNpbHkgcGFzcyB0aGlzIHRvIHBhZ2UgYWxs
b2NhdGlvbgpyb3V0aW5lcy4gQ29kZSBjb25zdW1pbmcgdGhpcyAoZml4aW5nIHRoZSBkb3VibGUg
ZmF1bHQgaGFuZGxlciB0byB1c2UgcGVyLQpDUFUgc3RhY2tzKSB3aWxsIHNvb24gZm9sbG93LgoK
U2lnbmVkLW9mZi1ieTogSmFuIEJldWxpY2ggPGpiZXVsaWNoQG5vdmVsbC5jb20+CgpkaWZmIC1O
cHJ1IDIuNi4xMy9hcmNoL2kzODYva2VybmVsL2FzbS1vZmZzZXRzLmMgMi42LjEzLWkzODYtVEhS
RUFEX1NJWkVfYXNtL2FyY2gvaTM4Ni9rZXJuZWwvYXNtLW9mZnNldHMuYwotLS0gMi42LjEzL2Fy
Y2gvaTM4Ni9rZXJuZWwvYXNtLW9mZnNldHMuYwkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAw
MCArMDIwMAorKysgMi42LjEzLWkzODYtVEhSRUFEX1NJWkVfYXNtL2FyY2gvaTM4Ni9rZXJuZWwv
YXNtLW9mZnNldHMuYwkyMDA1LTA5LTAyIDE2OjE5OjMwLjAwMDAwMDAwMCArMDIwMApAQCAtNjgs
NSArNjgsNiBAQCB2b2lkIGZvbyh2b2lkKQogCQkgc2l6ZW9mKHN0cnVjdCB0c3Nfc3RydWN0KSk7
CiAKIAlERUZJTkUoUEFHRV9TSVpFX2FzbSwgUEFHRV9TSVpFKTsKKwlERUZJTkUoVEhSRUFEX1NJ
WkVfYXNtLCBUSFJFQURfU0laRSk7CiAJREVGSU5FKFZTWVNDQUxMX0JBU0UsIF9fZml4X3RvX3Zp
cnQoRklYX1ZTWVNDQUxMKSk7CiB9CmRpZmYgLU5wcnUgMi42LjEzL2FyY2gvaTM4Ni9rZXJuZWwv
ZW50cnkuUyAyLjYuMTMtaTM4Ni1USFJFQURfU0laRV9hc20vYXJjaC9pMzg2L2tlcm5lbC9lbnRy
eS5TCi0tLSAyLjYuMTMvYXJjaC9pMzg2L2tlcm5lbC9lbnRyeS5TCTIwMDUtMDgtMjkgMDE6NDE6
MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMtaTM4Ni1USFJFQURfU0laRV9hc20vYXJjaC9p
Mzg2L2tlcm5lbC9lbnRyeS5TCTIwMDUtMDktMDIgMTY6MTc6NDUuMDAwMDAwMDAwICswMjAwCkBA
IC01MzcsOCArNTM3LDggQEAgRU5UUlkobm1pKQogCS8qIERvIG5vdCBhY2Nlc3MgbWVtb3J5IGFi
b3ZlIHRoZSBlbmQgb2Ygb3VyIHN0YWNrIHBhZ2UsCiAJICogaXQgbWlnaHQgbm90IGV4aXN0Lgog
CSAqLwotCWFuZGwgJChUSFJFQURfU0laRS0xKSwlZWF4Ci0JY21wbCAkKFRIUkVBRF9TSVpFLTIw
KSwlZWF4CisJYW5kbCAkKFRIUkVBRF9TSVpFX2FzbS0xKSwlZWF4CisJY21wbCAkKFRIUkVBRF9T
SVpFX2FzbS0yMCksJWVheAogCXBvcGwgJWVheAogCWphZSBubWlfc3RhY2tfY29ycmVjdAogCWNt
cGwgJHN5c2VudGVyX2VudHJ5LDEyKCVlc3ApCmRpZmYgLU5wcnUgMi42LjEzL2FyY2gvaTM4Ni9r
ZXJuZWwvaGVhZC5TIDIuNi4xMy1pMzg2LVRIUkVBRF9TSVpFX2FzbS9hcmNoL2kzODYva2VybmVs
L2hlYWQuUwotLS0gMi42LjEzL2FyY2gvaTM4Ni9rZXJuZWwvaGVhZC5TCTIwMDUtMDgtMjkgMDE6
NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMtaTM4Ni1USFJFQURfU0laRV9hc20vYXJj
aC9pMzg2L2tlcm5lbC9oZWFkLlMJMjAwNS0wOS0wMSAxMzowNjowMS4wMDAwMDAwMDAgKzAyMDAK
QEAgLTQyNSw3ICs0MjUsNyBAQCBFTlRSWShlbXB0eV96ZXJvX3BhZ2UpCiAuZGF0YQogCiBFTlRS
WShzdGFja19zdGFydCkKLQkubG9uZyBpbml0X3RocmVhZF91bmlvbitUSFJFQURfU0laRQorCS5s
b25nIGluaXRfdGhyZWFkX3VuaW9uK1RIUkVBRF9TSVpFX2FzbQogCS5sb25nIF9fQk9PVF9EUwog
CiByZWFkeToJLmJ5dGUgMApkaWZmIC1OcHJ1IDIuNi4xMy9hcmNoL2kzODYva2VybmVsL3ZtbGlu
dXgubGRzLlMgMi42LjEzLWkzODYtVEhSRUFEX1NJWkVfYXNtL2FyY2gvaTM4Ni9rZXJuZWwvdm1s
aW51eC5sZHMuUwotLS0gMi42LjEzL2FyY2gvaTM4Ni9rZXJuZWwvdm1saW51eC5sZHMuUwkyMDA1
LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysgMi42LjEzLWkzODYtVEhSRUFEX1NJ
WkVfYXNtL2FyY2gvaTM4Ni9rZXJuZWwvdm1saW51eC5sZHMuUwkyMDA1LTA5LTA1IDEwOjUxOjEw
LjAwMDAwMDAwMCArMDIwMApAQCAtNCw4ICs0LDkgQEAKIAogI2RlZmluZSBMT0FEX09GRlNFVCBf
X1BBR0VfT0ZGU0VUCiAKKyNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4KICNpbmNsdWRlIDxhc20t
Z2VuZXJpYy92bWxpbnV4Lmxkcy5oPgotI2luY2x1ZGUgPGFzbS90aHJlYWRfaW5mby5oPgorI2lu
Y2x1ZGUgPGFzbS9hc21fb2Zmc2V0cy5oPgogI2luY2x1ZGUgPGFzbS9wYWdlLmg+CiAKIE9VVFBV
VF9GT1JNQVQoImVsZjMyLWkzODYiLCAiZWxmMzItaTM4NiIsICJlbGYzMi1pMzg2IikKQEAgLTYy
LDcgKzYzLDcgQEAgU0VDVElPTlMKICAgLmRhdGEucmVhZF9tb3N0bHkgOiBBVChBRERSKC5kYXRh
LnJlYWRfbW9zdGx5KSAtIExPQURfT0ZGU0VUKSB7ICooLmRhdGEucmVhZF9tb3N0bHkpIH0KICAg
X2VkYXRhID0gLjsJCQkvKiBFbmQgb2YgZGF0YSBzZWN0aW9uICovCiAKLSAgLiA9IEFMSUdOKFRI
UkVBRF9TSVpFKTsJLyogaW5pdF90YXNrICovCisgIC4gPSBBTElHTihUSFJFQURfU0laRV9hc20p
OwkvKiBpbml0X3Rhc2sgKi8KICAgLmRhdGEuaW5pdF90YXNrIDogQVQoQUREUiguZGF0YS5pbml0
X3Rhc2spIC0gTE9BRF9PRkZTRVQpIHsKIAkqKC5kYXRhLmluaXRfdGFzaykKICAgfQpkaWZmIC1O
cHJ1IDIuNi4xMy9pbmNsdWRlL2FzbS1pMzg2L3RocmVhZF9pbmZvLmggMi42LjEzLWkzODYtVEhS
RUFEX1NJWkVfYXNtL2luY2x1ZGUvYXNtLWkzODYvdGhyZWFkX2luZm8uaAotLS0gMi42LjEzL2lu
Y2x1ZGUvYXNtLWkzODYvdGhyZWFkX2luZm8uaAkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAw
MCArMDIwMAorKysgMi42LjEzLWkzODYtVEhSRUFEX1NJWkVfYXNtL2luY2x1ZGUvYXNtLWkzODYv
dGhyZWFkX2luZm8uaAkyMDA1LTA5LTAxIDExOjMyOjEyLjAwMDAwMDAwMCArMDIwMApAQCAtNTQs
MTAgKzU0LDExIEBAIHN0cnVjdCB0aHJlYWRfaW5mbyB7CiAKICNkZWZpbmUgUFJFRU1QVF9BQ1RJ
VkUJCTB4MTAwMDAwMDAKICNpZmRlZiBDT05GSUdfNEtTVEFDS1MKLSNkZWZpbmUgVEhSRUFEX1NJ
WkUgICAgICAgICAgICAoNDA5NikKKyNkZWZpbmUgVEhSRUFEX09SREVSIDAKICNlbHNlCi0jZGVm
aW5lIFRIUkVBRF9TSVpFCQkoODE5MikKKyNkZWZpbmUgVEhSRUFEX09SREVSIDEKICNlbmRpZgor
I2RlZmluZSBUSFJFQURfU0laRSAoUEFHRV9TSVpFIDw8IFRIUkVBRF9PUkRFUikKIAogI2RlZmlu
ZSBTVEFDS19XQVJOICAgICAgICAgICAgIChUSFJFQURfU0laRS84KQogLyoKQEAgLTExOCwxMiAr
MTE5LDEyIEBAIHJlZ2lzdGVyIHVuc2lnbmVkIGxvbmcgY3VycmVudF9zdGFja19wb2kKIAogLyog
aG93IHRvIGdldCB0aGUgdGhyZWFkIGluZm9ybWF0aW9uIHN0cnVjdCBmcm9tIEFTTSAqLwogI2Rl
ZmluZSBHRVRfVEhSRUFEX0lORk8ocmVnKSBcCi0JbW92bCAkLVRIUkVBRF9TSVpFLCByZWc7IFwK
Kwltb3ZsICQtVEhSRUFEX1NJWkVfYXNtLCByZWc7IFwKIAlhbmRsICVlc3AsIHJlZwogCiAvKiB1
c2UgdGhpcyBvbmUgaWYgcmVnIGFscmVhZHkgY29udGFpbnMgJWVzcCAqLwogI2RlZmluZSBHRVRf
VEhSRUFEX0lORk9fV0lUSF9FU1AocmVnKSBcCi0JYW5kbCAkLVRIUkVBRF9TSVpFLCByZWcKKwlh
bmRsICQtVEhSRUFEX1NJWkVfYXNtLCByZWcKIAogI2VuZGlmCiAK

--=__PartD4F6BA85.0__=--
