Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272058AbTG2U2V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 16:28:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272069AbTG2U2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 16:28:21 -0400
Received: from fmr04.intel.com ([143.183.121.6]:6877 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id S272058AbTG2U2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 16:28:16 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3560F.EFBECF21"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] [RESEND] Use of Performance Monitoring Counters based on Model number
Date: Tue, 29 Jul 2003 13:28:14 -0700
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1902C7D159@fmsmsx405.fm.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [RESEND] Use of Performance Monitoring Counters based on Model number
Thread-Index: AcNV/VeTZon0D9G9Sf6INTirCqSVzwAEVm4Q
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: <torvalds@osdl.org>
Cc: <linux-kernel@vger.kernel.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 29 Jul 2003 20:28:15.0002 (UTC) FILETIME=[F025E7A0:01C3560F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3560F.EFBECF21
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable



Oops. Sorry about the wrapped lines in my last mail. Sending the patch
as an attachment this time.

Thanks,
-Venkatesh


> -----Original Message-----
> From: Pallipadi, Venkatesh=20
> Sent: Tuesday, July 29, 2003 11:15 AM
> To: torvalds@osdl.org
> Cc: linux-kernel@vger.kernel.org; Mallick, Asit K; Nakajima, Jun
> Subject: [PATCH] [RESEND] Use of Performance Monitoring=20
> Counters based on Model number
>=20
>=20
>=20
>=20
>=20
> Attaching a modified version of this patch, based on the=20
> feedback that I
> got for my previous post.
>=20
> Feedback and Resolution:
> 1) If you're going to do this you should fix up arch/i386/oprofile/ to
> error out similarly at least
> -  Done. Made a similar change in oprofile code. Infact it=20
> already had a
> check for 0xf, 0x3. Added one for 0x6, 0xd.
>=20
> 2) How about some macros for those magic numbers? =20
> #define INTEL_MODEL_THINGABABOBBERPERON 0xd
> -  Not sure whether I need to add macros for family and=20
> models. We don't
> seem to have macros for them anywhere else in kernel code.
>=20
> 3) It'd also be nice to let the user know why things aren't working
> instead of silent failure.
> -  Done. Added a message while in nmi_init.=20
>=20
> Let me know if you have any questions. Please Apply.
>=20
> Thanks,
> -Venkatesh
>=20
> > -----Original Message-----
> > From: Pallipadi, Venkatesh=20
> > Sent: Wednesday, July 16, 2003 10:08 AM
> > To: 'torvalds@osdl.org'
> > Cc: 'linux-kernel@vger.kernel.org'; Mallick, Asit K
> > Subject: [PATCH] Use of Performance Monitoring Counters based=20
> > on Model number
> >=20
> >=20
> >=20
> >=20
> > Attached is a small patch to make Linux kernel use of=20
> > performance monitoring MSRs based on known processor models.=20
> > Future processor implementation models may not support the=20
> > same MSR layout.
> >=20
> > Please apply.
> >=20
> > Thanks,
> > -Venkatesh
>=20
>=20
>=20
>=20
> --- linux-2.6.0-test1/arch/i386/kernel/nmi.c.orig	2003-07-13
> 20:34:40.000000000 -0700
> +++ linux-2.6.0-test1/arch/i386/kernel/nmi.c	2003-07-17
> 17:26:45.000000000 -0700
> @@ -162,9 +162,15 @@
>  	case X86_VENDOR_INTEL:
>  		switch (boot_cpu_data.x86) {
>  		case 6:
> +			if (boot_cpu_data.x86_model > 0xd)
> +				break;
> +
>  			wrmsr(MSR_P6_EVNTSEL0, 0, 0);
>  			break;
>  		case 15:
> +			if (boot_cpu_data.x86_model > 0x3)
> +				break;
> +
>  			wrmsr(MSR_P4_IQ_CCCR0, 0, 0);
>  			wrmsr(MSR_P4_CRU_ESCR0, 0, 0);
>  			break;
> @@ -348,9 +354,19 @@
>  	case X86_VENDOR_INTEL:
>  		switch (boot_cpu_data.x86) {
>  		case 6:
> +			if (boot_cpu_data.x86_model > 0xd) {
> +				printk (KERN_INFO "Performance Counter
> support for this CPU model not yet added.\n");
> +				return;
> +			}
> +
>  			setup_p6_watchdog();
>  			break;
>  		case 15:
> +			if (boot_cpu_data.x86_model > 0x3) {
> +				printk (KERN_INFO "Performance Counter
> support for this CPU model not yet added.\n");
> +				return;
> +			}
> +
>  			if (!setup_p4_watchdog())
>  				return;
>  			break;
> --- linux-2.6.0-test1/arch/i386/oprofile/nmi_int.c.orig=09
> 2003-07-17
> 17:20:30.000000000 -0700
> +++ linux-2.6.0-test1/arch/i386/oprofile/nmi_int.c	2003-07-17
> 17:21:06.000000000 -0700
> @@ -285,6 +285,9 @@
>  {
>  	__u8 cpu_model =3D current_cpu_data.x86_model;
> =20
> +	if (cpu_model > 0xd)
> +		return 0;
> +
>  	if (cpu_model > 5) {
>  		nmi_ops.cpu_type =3D "i386/piii";
>  	} else if (cpu_model > 2) {
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

------_=_NextPart_001_01C3560F.EFBECF21
Content-Type: application/octet-stream;
	name="2.5_nmi_ver1.patch"
Content-Transfer-Encoding: base64
Content-Description: 2.5_nmi_ver1.patch
Content-Disposition: attachment;
	filename="2.5_nmi_ver1.patch"

LS0tIGxpbnV4LTIuNi4wLXRlc3QxL2FyY2gvaTM4Ni9rZXJuZWwvbm1pLmMub3JpZwkyMDAzLTA3
LTEzIDIwOjM0OjQwLjAwMDAwMDAwMCAtMDcwMAorKysgbGludXgtMi42LjAtdGVzdDEvYXJjaC9p
Mzg2L2tlcm5lbC9ubWkuYwkyMDAzLTA3LTE3IDE3OjI2OjQ1LjAwMDAwMDAwMCAtMDcwMApAQCAt
MTYyLDkgKzE2MiwxNSBAQAogCWNhc2UgWDg2X1ZFTkRPUl9JTlRFTDoKIAkJc3dpdGNoIChib290
X2NwdV9kYXRhLng4NikgewogCQljYXNlIDY6CisJCQlpZiAoYm9vdF9jcHVfZGF0YS54ODZfbW9k
ZWwgPiAweGQpCisJCQkJYnJlYWs7CisKIAkJCXdybXNyKE1TUl9QNl9FVk5UU0VMMCwgMCwgMCk7
CiAJCQlicmVhazsKIAkJY2FzZSAxNToKKwkJCWlmIChib290X2NwdV9kYXRhLng4Nl9tb2RlbCA+
IDB4MykKKwkJCQlicmVhazsKKwogCQkJd3Jtc3IoTVNSX1A0X0lRX0NDQ1IwLCAwLCAwKTsKIAkJ
CXdybXNyKE1TUl9QNF9DUlVfRVNDUjAsIDAsIDApOwogCQkJYnJlYWs7CkBAIC0zNDgsOSArMzU0
LDE5IEBACiAJY2FzZSBYODZfVkVORE9SX0lOVEVMOgogCQlzd2l0Y2ggKGJvb3RfY3B1X2RhdGEu
eDg2KSB7CiAJCWNhc2UgNjoKKwkJCWlmIChib290X2NwdV9kYXRhLng4Nl9tb2RlbCA+IDB4ZCkg
eworCQkJCXByaW50ayAoS0VSTl9JTkZPICJQZXJmb3JtYW5jZSBDb3VudGVyIHN1cHBvcnQgZm9y
IHRoaXMgQ1BVIG1vZGVsIG5vdCB5ZXQgYWRkZWQuXG4iKTsKKwkJCQlyZXR1cm47CisJCQl9CisK
IAkJCXNldHVwX3A2X3dhdGNoZG9nKCk7CiAJCQlicmVhazsKIAkJY2FzZSAxNToKKwkJCWlmIChi
b290X2NwdV9kYXRhLng4Nl9tb2RlbCA+IDB4MykgeworCQkJCXByaW50ayAoS0VSTl9JTkZPICJQ
ZXJmb3JtYW5jZSBDb3VudGVyIHN1cHBvcnQgZm9yIHRoaXMgQ1BVIG1vZGVsIG5vdCB5ZXQgYWRk
ZWQuXG4iKTsKKwkJCQlyZXR1cm47CisJCQl9CisKIAkJCWlmICghc2V0dXBfcDRfd2F0Y2hkb2co
KSkKIAkJCQlyZXR1cm47CiAJCQlicmVhazsKLS0tIGxpbnV4LTIuNi4wLXRlc3QxL2FyY2gvaTM4
Ni9vcHJvZmlsZS9ubWlfaW50LmMub3JpZwkyMDAzLTA3LTE3IDE3OjIwOjMwLjAwMDAwMDAwMCAt
MDcwMAorKysgbGludXgtMi42LjAtdGVzdDEvYXJjaC9pMzg2L29wcm9maWxlL25taV9pbnQuYwky
MDAzLTA3LTE3IDE3OjIxOjA2LjAwMDAwMDAwMCAtMDcwMApAQCAtMjg1LDYgKzI4NSw5IEBACiB7
CiAJX191OCBjcHVfbW9kZWwgPSBjdXJyZW50X2NwdV9kYXRhLng4Nl9tb2RlbDsKIAorCWlmIChj
cHVfbW9kZWwgPiAweGQpCisJCXJldHVybiAwOworCiAJaWYgKGNwdV9tb2RlbCA+IDUpIHsKIAkJ
bm1pX29wcy5jcHVfdHlwZSA9ICJpMzg2L3BpaWkiOwogCX0gZWxzZSBpZiAoY3B1X21vZGVsID4g
Mikgewo=

------_=_NextPart_001_01C3560F.EFBECF21--
