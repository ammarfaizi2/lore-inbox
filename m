Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268728AbUJKJC0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268728AbUJKJC0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 05:02:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268729AbUJKJC0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 05:02:26 -0400
Received: from fmr05.intel.com ([134.134.136.6]:17093 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S268728AbUJKJCV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 05:02:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4AF71.00C5E584"
Subject: ctx64 is not initiated in sys32_io_setup
Date: Mon, 11 Oct 2004 17:02:14 +0800
Message-ID: <8126E4F969BA254AB43EA03C59F44E848B0376@pdsmsx404>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: ctx64 is not initiated in sys32_io_setup
Thread-Index: AcSvcQAwHXz0fOQjRPG8+rJerlZAkQ==
From: "Zhang, Yanmin" <yanmin.zhang@intel.com>
To: <discuss@x86-64.org>, <linux-kernel@vger.kernel.org>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
X-OriginalArrivalTime: 11 Oct 2004 09:02:15.0579 (UTC) FILETIME=[00FA5EB0:01C4AF71]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4AF71.00C5E584
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Kernel 2.6.9-rc3-mm3 has a bug in function sys32_io_setup in file
arch/x86_64/ia32/sys_ia32.c. Local variable ctx64 is not initiated
before sys32_io_setup calls sys_io_setup. If ctx64 is not zero, and
sys_io_setup will return -EINVAL. Generic function compat_sys_io_setup
has not the bug.=20

Here is the patch against 2.6.9-rc3-mm3. Just use compat_sys_io_setup to
replace sys32_io_setup.

Signed-of-by: Zhang Yanmin <yanmin.zhang@intel.com>

diff -Nraup a/arch/x86_64/ia32/ia32entry.S
b/arch/x86_64/ia32/ia32entry.S
--- a/arch/x86_64/ia32/ia32entry.S	2004-10-08 12:09:03.000000000
+0800
+++ b/arch/x86_64/ia32/ia32entry.S	2004-10-10 18:59:38.295452840
+0800
@@ -547,7 +547,7 @@ ia32_sys_call_table:
 	.quad compat_sys_sched_getaffinity
 	.quad sys32_set_thread_area
 	.quad sys32_get_thread_area
-	.quad sys32_io_setup		/* 245 */
+	.quad compat_sys_io_setup	/* 245 */
 	.quad sys_io_destroy
 	.quad sys32_io_getevents
 	.quad sys32_io_submit
diff -Nraup a/arch/x86_64/ia32/sys_ia32.c b/arch/x86_64/ia32/sys_ia32.c
--- a/arch/x86_64/ia32/sys_ia32.c	2004-10-08 12:09:03.000000000
+0800
+++ b/arch/x86_64/ia32/sys_ia32.c	2004-10-10 18:59:38.296452688
+0800
@@ -1185,21 +1185,6 @@ long sys32_kill(int pid, int sig)
 {
 	return sys_kill(pid, sig);
 }
-=20
-
-long sys32_io_setup(unsigned nr_reqs, u32 __user *ctx32p)
-{=20
-	long ret;=20
-	aio_context_t ctx64;
-	mm_segment_t oldfs =3D get_fs(); =09
-	set_fs(KERNEL_DS);=20
-	ret =3D sys_io_setup(nr_reqs, &ctx64);=20
-	set_fs(oldfs);=20
-	/* truncating is ok because it's a user address */
-	if (!ret)=20
-		ret =3D put_user((u32)ctx64, ctx32p);
-	return ret;
-}=20
=20
 asmlinkage long sys32_io_submit(aio_context_t ctx_id, int nr,
 		   compat_uptr_t __user *iocbpp)


 <<sys32_io_setup_initiate.2.6.9.rc3.mm3.patch.diff>>=20

------_=_NextPart_001_01C4AF71.00C5E584
Content-Type: application/octet-stream;
	name="sys32_io_setup_initiate.2.6.9.rc3.mm3.patch.diff"
Content-Transfer-Encoding: base64
Content-Description: sys32_io_setup_initiate.2.6.9.rc3.mm3.patch.diff
Content-Disposition: attachment;
	filename="sys32_io_setup_initiate.2.6.9.rc3.mm3.patch.diff"

ZGlmZiAtTnJhdXAgYS9hcmNoL3g4Nl82NC9pYTMyL2lhMzJlbnRyeS5TIGIvYXJjaC94ODZfNjQv
aWEzMi9pYTMyZW50cnkuUwotLS0gYS9hcmNoL3g4Nl82NC9pYTMyL2lhMzJlbnRyeS5TCTIwMDQt
MTAtMDggMTI6MDk6MDMuMDAwMDAwMDAwICswODAwCisrKyBiL2FyY2gveDg2XzY0L2lhMzIvaWEz
MmVudHJ5LlMJMjAwNC0xMC0xMCAxODo1OTozOC4yOTU0NTI4NDAgKzA4MDAKQEAgLTU0Nyw3ICs1
NDcsNyBAQCBpYTMyX3N5c19jYWxsX3RhYmxlOgogCS5xdWFkIGNvbXBhdF9zeXNfc2NoZWRfZ2V0
YWZmaW5pdHkKIAkucXVhZCBzeXMzMl9zZXRfdGhyZWFkX2FyZWEKIAkucXVhZCBzeXMzMl9nZXRf
dGhyZWFkX2FyZWEKLQkucXVhZCBzeXMzMl9pb19zZXR1cAkJLyogMjQ1ICovCisJLnF1YWQgY29t
cGF0X3N5c19pb19zZXR1cAkvKiAyNDUgKi8KIAkucXVhZCBzeXNfaW9fZGVzdHJveQogCS5xdWFk
IHN5czMyX2lvX2dldGV2ZW50cwogCS5xdWFkIHN5czMyX2lvX3N1Ym1pdApkaWZmIC1OcmF1cCBh
L2FyY2gveDg2XzY0L2lhMzIvc3lzX2lhMzIuYyBiL2FyY2gveDg2XzY0L2lhMzIvc3lzX2lhMzIu
YwotLS0gYS9hcmNoL3g4Nl82NC9pYTMyL3N5c19pYTMyLmMJMjAwNC0xMC0wOCAxMjowOTowMy4w
MDAwMDAwMDAgKzA4MDAKKysrIGIvYXJjaC94ODZfNjQvaWEzMi9zeXNfaWEzMi5jCTIwMDQtMTAt
MTAgMTg6NTk6MzguMjk2NDUyNjg4ICswODAwCkBAIC0xMTg1LDIxICsxMTg1LDYgQEAgbG9uZyBz
eXMzMl9raWxsKGludCBwaWQsIGludCBzaWcpCiB7CiAJcmV0dXJuIHN5c19raWxsKHBpZCwgc2ln
KTsKIH0KLSAKLQotbG9uZyBzeXMzMl9pb19zZXR1cCh1bnNpZ25lZCBucl9yZXFzLCB1MzIgX191
c2VyICpjdHgzMnApCi17IAotCWxvbmcgcmV0OyAKLQlhaW9fY29udGV4dF90IGN0eDY0OwotCW1t
X3NlZ21lbnRfdCBvbGRmcyA9IGdldF9mcygpOyAJCi0Jc2V0X2ZzKEtFUk5FTF9EUyk7IAotCXJl
dCA9IHN5c19pb19zZXR1cChucl9yZXFzLCAmY3R4NjQpOyAKLQlzZXRfZnMob2xkZnMpOyAKLQkv
KiB0cnVuY2F0aW5nIGlzIG9rIGJlY2F1c2UgaXQncyBhIHVzZXIgYWRkcmVzcyAqLwotCWlmICgh
cmV0KSAKLQkJcmV0ID0gcHV0X3VzZXIoKHUzMiljdHg2NCwgY3R4MzJwKTsKLQlyZXR1cm4gcmV0
OwotfSAKIAogYXNtbGlua2FnZSBsb25nIHN5czMyX2lvX3N1Ym1pdChhaW9fY29udGV4dF90IGN0
eF9pZCwgaW50IG5yLAogCQkgICBjb21wYXRfdXB0cl90IF9fdXNlciAqaW9jYnBwKQo=

------_=_NextPart_001_01C4AF71.00C5E584--
