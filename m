Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262604AbUKXKT3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262604AbUKXKT3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 05:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262597AbUKXKTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 05:19:17 -0500
Received: from fmr17.intel.com ([134.134.136.16]:58768 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262595AbUKXKS2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 05:18:28 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C4D20E.EAFD74C1"
Subject: [PATCH] make pm_suspend_disk suspend/resume sysdev and dpm_off_irq
Date: Wed, 24 Nov 2004 18:18:18 +0800
Message-ID: <3ACA40606221794F80A5670F0AF15F8403BD5868@pdsmsx403>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] make pm_suspend_disk suspend/resume sysdev and dpm_off_irq
Thread-Index: AcTSDwb2ASiQRCxBSIyX5ylIvfuOuw==
From: "Zhu, Yi" <yi.zhu@intel.com>
To: <akpm@osdl.org>, <linux-kernel@vger.kernel.org>, <linux-pm@lists.osdl.org>
X-OriginalArrivalTime: 24 Nov 2004 10:18:19.0309 (UTC) FILETIME=[EB594DD0:01C4D20E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C4D20E.EAFD74C1
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi,

This patch makes the new swsusp code ( pm_suspend_disk since 2.6.9-rc3)=20
call suspend/resume functions for sysdev and devices in dpm_off_irq
list.=20
Otherwise, PCI link device in the system won't provide correct interrupt
for PCI
devices during resume.

See the real bug report here:
http://www.bughost.org/bugzilla/show_bug.cgi?id=3D363

Thanks,
-yi


Signed-off-by: Zhu Yi <yi.zhu@intel.com>

diff -urp a/kernel/power/disk.c b/kernel/power/disk.c
--- a/kernel/power/disk.c	2004-11-12 05:45:35.000000000 +0800
+++ b/kernel/power/disk.c	2004-11-21 06:21:28.162720936 +0800
@@ -113,6 +113,11 @@ static inline void platform_finish(void)
=20
 static void finish(void)
 {
+	unsigned long flags;
+
+	local_irq_save(flags);
+	device_power_up();
+	local_irq_restore(flags);
 	device_resume();
 	platform_finish();
 	enable_nonboot_cpus();
@@ -124,6 +129,7 @@ static void finish(void)
 static int prepare(void)
 {
 	int error;
+	unsigned long flags;
=20
 	pm_prepare_console();
=20
@@ -147,7 +153,14 @@ static int prepare(void)
 	if ((error =3D device_suspend(PM_SUSPEND_DISK)))
 		goto Finish;
=20
+	local_irq_save(flags);
+	if ((error =3D device_power_down(PM_SUSPEND_DISK))) {
+		local_irq_restore(flags);
+		goto Finish;
+	}
+	local_irq_restore(flags);
 	return 0;
+
  Finish:
 	platform_finish();
  Thaw:
diff -urp a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-11-12 05:45:35.000000000 +0800
+++ b/kernel/power/swsusp.c	2004-11-21 06:18:55.734893488 +0800
@@ -829,6 +829,11 @@ int suspend_prepare_image(void)
 int swsusp_write(void)
 {
 	int error;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	device_power_up();
+	local_irq_restore(flags);
 	device_resume();
 	lock_swapdevices();
 	error =3D write_suspend_image();

------_=_NextPart_001_01C4D20E.EAFD74C1
Content-Type: application/octet-stream;
	name="swsusp-sysdev.patch"
Content-Transfer-Encoding: base64
Content-Description: swsusp-sysdev.patch
Content-Disposition: attachment;
	filename="swsusp-sysdev.patch"

ZGlmZiAtdXJwIGEva2VybmVsL3Bvd2VyL2Rpc2suYyBiL2tlcm5lbC9wb3dlci9kaXNrLmMKLS0t
IGEva2VybmVsL3Bvd2VyL2Rpc2suYwkyMDA0LTExLTEyIDA1OjQ1OjM1LjAwMDAwMDAwMCArMDgw
MAorKysgYi9rZXJuZWwvcG93ZXIvZGlzay5jCTIwMDQtMTEtMjEgMDY6MjE6MjguMTYyNzIwOTM2
ICswODAwCkBAIC0xMTMsNiArMTEzLDExIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBwbGF0Zm9ybV9m
aW5pc2godm9pZCkKIAogc3RhdGljIHZvaWQgZmluaXNoKHZvaWQpCiB7CisJdW5zaWduZWQgbG9u
ZyBmbGFnczsKKworCWxvY2FsX2lycV9zYXZlKGZsYWdzKTsKKwlkZXZpY2VfcG93ZXJfdXAoKTsK
Kwlsb2NhbF9pcnFfcmVzdG9yZShmbGFncyk7CiAJZGV2aWNlX3Jlc3VtZSgpOwogCXBsYXRmb3Jt
X2ZpbmlzaCgpOwogCWVuYWJsZV9ub25ib290X2NwdXMoKTsKQEAgLTEyNCw2ICsxMjksNyBAQCBz
dGF0aWMgdm9pZCBmaW5pc2godm9pZCkKIHN0YXRpYyBpbnQgcHJlcGFyZSh2b2lkKQogewogCWlu
dCBlcnJvcjsKKwl1bnNpZ25lZCBsb25nIGZsYWdzOwogCiAJcG1fcHJlcGFyZV9jb25zb2xlKCk7
CiAKQEAgLTE0Nyw3ICsxNTMsMTQgQEAgc3RhdGljIGludCBwcmVwYXJlKHZvaWQpCiAJaWYgKChl
cnJvciA9IGRldmljZV9zdXNwZW5kKFBNX1NVU1BFTkRfRElTSykpKQogCQlnb3RvIEZpbmlzaDsK
IAorCWxvY2FsX2lycV9zYXZlKGZsYWdzKTsKKwlpZiAoKGVycm9yID0gZGV2aWNlX3Bvd2VyX2Rv
d24oUE1fU1VTUEVORF9ESVNLKSkpIHsKKwkJbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOworCQln
b3RvIEZpbmlzaDsKKwl9CisJbG9jYWxfaXJxX3Jlc3RvcmUoZmxhZ3MpOwogCXJldHVybiAwOwor
CiAgRmluaXNoOgogCXBsYXRmb3JtX2ZpbmlzaCgpOwogIFRoYXc6CmRpZmYgLXVycCBhL2tlcm5l
bC9wb3dlci9zd3N1c3AuYyBiL2tlcm5lbC9wb3dlci9zd3N1c3AuYwotLS0gYS9rZXJuZWwvcG93
ZXIvc3dzdXNwLmMJMjAwNC0xMS0xMiAwNTo0NTozNS4wMDAwMDAwMDAgKzA4MDAKKysrIGIva2Vy
bmVsL3Bvd2VyL3N3c3VzcC5jCTIwMDQtMTEtMjEgMDY6MTg6NTUuNzM0ODkzNDg4ICswODAwCkBA
IC04MjksNiArODI5LDExIEBAIGludCBzdXNwZW5kX3ByZXBhcmVfaW1hZ2Uodm9pZCkKIGludCBz
d3N1c3Bfd3JpdGUodm9pZCkKIHsKIAlpbnQgZXJyb3I7CisJdW5zaWduZWQgbG9uZyBmbGFnczsK
KworCWxvY2FsX2lycV9zYXZlKGZsYWdzKTsKKwlkZXZpY2VfcG93ZXJfdXAoKTsKKwlsb2NhbF9p
cnFfcmVzdG9yZShmbGFncyk7CiAJZGV2aWNlX3Jlc3VtZSgpOwogCWxvY2tfc3dhcGRldmljZXMo
KTsKIAllcnJvciA9IHdyaXRlX3N1c3BlbmRfaW1hZ2UoKTsK

------_=_NextPart_001_01C4D20E.EAFD74C1--
