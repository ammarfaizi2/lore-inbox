Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264084AbTH2BNO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 21:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbTH2BNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 21:13:14 -0400
Received: from fmr09.intel.com ([192.52.57.35]:65533 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S264084AbTH2BNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 21:13:10 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C36DCA.B3BAD888"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: [2.4][PATCH][RESEND] Use of Performance Monitoring Counters based on Model number
Date: Thu, 28 Aug 2003 18:13:06 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D21C@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [2.4][PATCH][RESEND] Use of Performance Monitoring Counters based on Model number
Thread-Index: AcNtyrOn6iNgVRcFSr+TL2DJZsN+fQ==
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <marcelo@hera.kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 29 Aug 2003 01:13:07.0110 (UTC) FILETIME=[B43B1C60:01C36DCA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C36DCA.B3BAD888
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Marcelo,

Resend:
Attached is a small patch to make Linux kernel use of performance=20
monitoring MSRs based on known processor models. Future processor=20
implementation models may not support the same MSR layout.=20

The patch is already in 2.6, and this is a backport from there.=20
Note that the patch also adds support for extended family and=20
model numbers. This part also is a backport from 2.6.

Please consider applying.

Thanks,
-Venkatesh

--- linux-2.4.22-rc2/arch/i386/kernel/nmi.c.org	2003-08-20 =
15:55:55.000000000 -0700
+++ linux-2.4.22-rc2/arch/i386/kernel/nmi.c	2003-08-20 =
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
+				printk (KERN_INFO "Performance Counter support for this CPU model =
not yet added.\n");
+				return;
+			}
+
 			setup_p6_watchdog();
 			break;
 		case 15:
+			if (boot_cpu_data.x86_model > 0x3) {
+				printk (KERN_INFO "Performance Counter support for this CPU model =
not yet added.\n");
+				return;
+			}
+
 			if (!setup_p4_watchdog())
 				return;
 			break;
--- linux-2.4.22-rc2/arch/i386/kernel/setup.c.org	2003-08-20 =
15:56:14.000000000 -0700
+++ linux-2.4.22-rc2/arch/i386/kernel/setup.c	2003-08-20 =
15:57:10.000000000 -0700
@@ -2759,6 +2759,10 @@ void __init identify_cpu(struct cpuinfo_
 			c->x86 =3D (tfms >> 8) & 15;
 			c->x86_model =3D (tfms >> 4) & 15;
 			c->x86_mask =3D tfms & 15;
+			if (c->x86 =3D=3D 0xf) {
+				c->x86 +=3D (tfms >> 20) & 0xff;
+				c->x86_model +=3D ((tfms >> 16) & 0xf) << 4;
+			}
 		} else {
 			/* Have CPUID level 0 only - unheard of */
 			c->x86 =3D 4;



------_=_NextPart_001_01C36DCA.B3BAD888
Content-Type: application/x-zip-compressed;
	name="nmi-2.4.22-rc2.ZIP"
Content-Transfer-Encoding: base64
Content-Description: nmi-2.4.22-rc2.ZIP
Content-Disposition: attachment;
	filename="nmi-2.4.22-rc2.ZIP"

UEsDBBQAAAAIAEKAFC/c6XtPZAIAADoGAAAUAAAAbm1pLTJfNF8yMi1yYzIucGF0Y2jFVF1P2zAU
fU5/xR0PU0qa1AlpSFuokErR0Fhh5UN7mGSFxKFWUztynAKa+O+z05QFqDS0SVtkyYnv8bm+557Y
tm3IKCsfbM/xHc+zRex1IxHPu3QvDLoLIhjJumxJndjh4s7wENqzUWh7CNzeoKeHgzYP2GgfoZZl
We/lfM3XH3jeG76jI7DdHur0wdKT2wO1UshI0hhWnCaQ0CK6zQiOchpjxYvvIxnPE35nrngLjDgq
CHwLA3wzmR6fz/Dp9GpyNlABo7inCgjmLecSx3mJk0hGzkMYtOGHjlc7g0HLMgyDpltweMkTksEI
0EPSrmDGrSDRYtiy9H7jXiwLYX65nOGLAE9upleXkzPUAT3awwpRwzfJlAjvyrb3m2w+Pv2Kx+Px
7GW2F4jx7BpPLl9DakYtuheGWnSv73fcvha9UhvjfEkZlVAQWeZvRQdz9Q9FV3sqIXJBmVyA+Xky
m6pkJ+ewc0FEysUyYjGBMS+ZJAKKMs+5kKACIOe0gPHFNaz5GJfwSCRESUIS5zvbUYJU1ELVKdj6
46mWel17Hvyy2t/28z8Vog/2oa7Gb1TTrqLPWxql2e+6MirK7ZdGMHD9P7w0atbXjPsDF229Nrz9
Xr8TKAvr2UUND1cOpglhkqaPuitmIUUZS1CvlKUcVyXH9kj1CQ7BlOmygNEIwjZ8VDmHjXDdxgbI
3waKioXCVJB1cOOLTZJD5YP02Qf1qtWg9ZDmVaB02MTU+TXyGeoGNbQNBwfgb3quzvMEJFPGrH41
o7sLn6IV0eY5PYaMrBQPAs6yR7ChZHMSiQR4Crvdl3Iowp9QSwECFAsUAAAACABCgBQv3Ol7T2QC
AAA6BgAAFAAAAAAAAAABACAAAAAAAAAAbm1pLTJfNF8yMi1yYzIucGF0Y2hQSwUGAAAAAAEAAQBC
AAAAlgIAAAAA

------_=_NextPart_001_01C36DCA.B3BAD888--
