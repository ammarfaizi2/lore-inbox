Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbTHTV0W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 17:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262247AbTHTV0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 17:26:19 -0400
Received: from hermes.py.intel.com ([146.152.216.3]:30928 "EHLO
	hermes.py.intel.com") by vger.kernel.org with ESMTP id S262217AbTHTV0N
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 17:26:13 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C36761.AB24CE10"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [2.4][PATCH] Use of Performance Monitoring Counters based on Model number
Date: Wed, 20 Aug 2003 14:26:07 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D1DB@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [2.4][PATCH] Use of Performance Monitoring Counters based on Model number
Thread-Index: AcNnYanWl4HkFN2aQ+mbmUYKavLB2A==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <marcelo@conectiva.com.br>
Cc: <linux-kernel@vger.kernel.org>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 20 Aug 2003 21:26:08.0320 (UTC) FILETIME=[AB7EAC00:01C36761]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C36761.AB24CE10
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Marcelo,

Attached is a small patch to make Linux kernel use of performance=20
monitoring MSRs based on known processor models. Future processor=20
implementation models may not support the same MSR layout.=20

The patch is already in 2.6, and this is a backport from there.=20
Note that the patch also adds support for extended family and=20
model numbers. This part also is a backport from 2.6.

Please consider applying.

Thanks,
-Venkatesh





--- linux-2.4.22-rc2/arch/i386/kernel/nmi.c.org	2003-08-20
15:55:55.000000000 -0700
+++ linux-2.4.22-rc2/arch/i386/kernel/nmi.c	2003-08-20
15:59:22.000000000 -0700
@@ -150,9 +150,15 @@ static void disable_apic_nmi_watchdog(vo
 	case X86_VENDOR_INTEL:
 		switch (boot_cpu_data.x86) {
 		case 6:
+			if (boot_cpu_data.x86_model > 0xd)
+				break;
+
 			wrmsr(MSR_P6_EVNTSEL0, 0, 0);
 			break;
 		case 15:
+			if (boot_cpu_data.x86_model > 0x3)
+				break;
+
 			wrmsr(MSR_P4_IQ_CCCR0, 0, 0);
 			wrmsr(MSR_P4_CRU_ESCR0, 0, 0);
 			break;
@@ -288,9 +294,19 @@ void __pminit setup_apic_nmi_watchdog (v
 	case X86_VENDOR_INTEL:
 		switch (boot_cpu_data.x86) {
 		case 6:
+			if (boot_cpu_data.x86_model > 0xd) {
+				printk (KERN_INFO "Performance Counter
support for this CPU model not yet added.\n");
+				return;
+			}
+
 			setup_p6_watchdog();
 			break;
 		case 15:
+			if (boot_cpu_data.x86_model > 0x3) {
+				printk (KERN_INFO "Performance Counter
support for this CPU model not yet added.\n");
+				return;
+			}
+
 			if (!setup_p4_watchdog())
 				return;
 			break;
--- linux-2.4.22-rc2/arch/i386/kernel/setup.c.org	2003-08-20
15:56:14.000000000 -0700
+++ linux-2.4.22-rc2/arch/i386/kernel/setup.c	2003-08-20
15:57:10.000000000 -0700
@@ -2759,6 +2759,10 @@ void __init identify_cpu(struct cpuinfo_
 			c->x86 =3D (tfms >> 8) & 15;
 			c->x86_model =3D (tfms >> 4) & 15;
 			c->x86_mask =3D tfms & 15;
+			if (c->x86 =3D=3D 0xf) {
+				c->x86 +=3D (tfms >> 20) & 0xff;
+				c->x86_model +=3D ((tfms >> 16) & 0xf) <<
4;
+			}
 		} else {
 			/* Have CPUID level 0 only - unheard of */
 			c->x86 =3D 4;


 <<nmi-2.4.22-rc2.patch>>=20

------_=_NextPart_001_01C36761.AB24CE10
Content-Type: application/octet-stream;
	name="nmi-2.4.22-rc2.patch"
Content-Transfer-Encoding: base64
Content-Description: nmi-2.4.22-rc2.patch
Content-Disposition: attachment;
	filename="nmi-2.4.22-rc2.patch"

LS0tIGxpbnV4LTIuNC4yMi1yYzIvYXJjaC9pMzg2L2tlcm5lbC9ubWkuYy5vcmcJMjAwMy0wOC0y
MCAxNTo1NTo1NS4wMDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNC4yMi1yYzIvYXJjaC9pMzg2
L2tlcm5lbC9ubWkuYwkyMDAzLTA4LTIwIDE1OjU5OjIyLjAwMDAwMDAwMCAtMDcwMApAQCAtMTUw
LDkgKzE1MCwxNSBAQCBzdGF0aWMgdm9pZCBkaXNhYmxlX2FwaWNfbm1pX3dhdGNoZG9nKHZvCiAJ
Y2FzZSBYODZfVkVORE9SX0lOVEVMOgogCQlzd2l0Y2ggKGJvb3RfY3B1X2RhdGEueDg2KSB7CiAJ
CWNhc2UgNjoKKwkJCWlmIChib290X2NwdV9kYXRhLng4Nl9tb2RlbCA+IDB4ZCkKKwkJCQlicmVh
azsKKwogCQkJd3Jtc3IoTVNSX1A2X0VWTlRTRUwwLCAwLCAwKTsKIAkJCWJyZWFrOwogCQljYXNl
IDE1OgorCQkJaWYgKGJvb3RfY3B1X2RhdGEueDg2X21vZGVsID4gMHgzKQorCQkJCWJyZWFrOwor
CiAJCQl3cm1zcihNU1JfUDRfSVFfQ0NDUjAsIDAsIDApOwogCQkJd3Jtc3IoTVNSX1A0X0NSVV9F
U0NSMCwgMCwgMCk7CiAJCQlicmVhazsKQEAgLTI4OCw5ICsyOTQsMTkgQEAgdm9pZCBfX3BtaW5p
dCBzZXR1cF9hcGljX25taV93YXRjaGRvZyAodgogCWNhc2UgWDg2X1ZFTkRPUl9JTlRFTDoKIAkJ
c3dpdGNoIChib290X2NwdV9kYXRhLng4NikgewogCQljYXNlIDY6CisJCQlpZiAoYm9vdF9jcHVf
ZGF0YS54ODZfbW9kZWwgPiAweGQpIHsKKwkJCQlwcmludGsgKEtFUk5fSU5GTyAiUGVyZm9ybWFu
Y2UgQ291bnRlciBzdXBwb3J0IGZvciB0aGlzIENQVSBtb2RlbCBub3QgeWV0IGFkZGVkLlxuIik7
CisJCQkJcmV0dXJuOworCQkJfQorCiAJCQlzZXR1cF9wNl93YXRjaGRvZygpOwogCQkJYnJlYWs7
CiAJCWNhc2UgMTU6CisJCQlpZiAoYm9vdF9jcHVfZGF0YS54ODZfbW9kZWwgPiAweDMpIHsKKwkJ
CQlwcmludGsgKEtFUk5fSU5GTyAiUGVyZm9ybWFuY2UgQ291bnRlciBzdXBwb3J0IGZvciB0aGlz
IENQVSBtb2RlbCBub3QgeWV0IGFkZGVkLlxuIik7CisJCQkJcmV0dXJuOworCQkJfQorCiAJCQlp
ZiAoIXNldHVwX3A0X3dhdGNoZG9nKCkpCiAJCQkJcmV0dXJuOwogCQkJYnJlYWs7Ci0tLSBsaW51
eC0yLjQuMjItcmMyL2FyY2gvaTM4Ni9rZXJuZWwvc2V0dXAuYy5vcmcJMjAwMy0wOC0yMCAxNTo1
NjoxNC4wMDAwMDAwMDAgLTA3MDAKKysrIGxpbnV4LTIuNC4yMi1yYzIvYXJjaC9pMzg2L2tlcm5l
bC9zZXR1cC5jCTIwMDMtMDgtMjAgMTU6NTc6MTAuMDAwMDAwMDAwIC0wNzAwCkBAIC0yNzU5LDYg
KzI3NTksMTAgQEAgdm9pZCBfX2luaXQgaWRlbnRpZnlfY3B1KHN0cnVjdCBjcHVpbmZvXwogCQkJ
Yy0+eDg2ID0gKHRmbXMgPj4gOCkgJiAxNTsKIAkJCWMtPng4Nl9tb2RlbCA9ICh0Zm1zID4+IDQp
ICYgMTU7CiAJCQljLT54ODZfbWFzayA9IHRmbXMgJiAxNTsKKwkJCWlmIChjLT54ODYgPT0gMHhm
KSB7CisJCQkJYy0+eDg2ICs9ICh0Zm1zID4+IDIwKSAmIDB4ZmY7CisJCQkJYy0+eDg2X21vZGVs
ICs9ICgodGZtcyA+PiAxNikgJiAweGYpIDw8IDQ7CisJCQl9CiAJCX0gZWxzZSB7CiAJCQkvKiBI
YXZlIENQVUlEIGxldmVsIDAgb25seSAtIHVuaGVhcmQgb2YgKi8KIAkJCWMtPng4NiA9IDQ7Cg==

------_=_NextPart_001_01C36761.AB24CE10--
