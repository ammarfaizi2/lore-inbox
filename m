Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965060AbVLVGk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965060AbVLVGk2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 01:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbVLVGk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 01:40:28 -0500
Received: from [202.125.80.34] ([202.125.80.34]:41551 "EHLO mail.esn.co.in")
	by vger.kernel.org with ESMTP id S965060AbVLVGk2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 01:40:28 -0500
Subject: RE: PATCH:  day of week (RE: Kernel interrupts disable at user level -RIGHT/ WRONG - Help)
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C606C2.20A3A83A"
Date: Thu, 22 Dec 2005 12:06:22 +0530
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Message-ID: <3AEC1E10243A314391FE9C01CD65429B223440@mail.esn.co.in>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH:  day of week (RE: Kernel interrupts disable at user level -RIGHT/ WRONG - Help)
Thread-Index: AcYFwQqWn5xdd+NiRpOIZTvXwSNxYgA/hibg
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Dave Jones" <davej@redhat.com>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C606C2.20A3A83A
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


Dear Alan,

The Application we are planning should not require to rebuild the =
kernel.=20
So, I have found something like /dev/port through which I can access any =
port i need.
I understand this would be a best interface which will does not require =
any patch and I will have the complete register values I need.

Quite a GOOD one. Thanks for all your help.
You can see the attached souce code I am planning to use.

Regards,
Mukund Jampala


> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Wednesday, December 21, 2005 5:31 AM
> To: Mukund JB.
> Cc: Dave Jones; linux-kernel@vger.kernel.org
> Subject: PATCH: day of week (RE: Kernel interrupts disable at=20
> user level
> -RIGHT/ WRONG - Help)
>=20
>=20
> On Maw, 2005-12-20 at 14:32 +0530, Mukund JB. wrote:
> > >  > I tried the /dev/rtc but I don't get it there.
> > >=20
> > > Use /dev/nvram instead.
> > >=20
> > > 		Dave
> >=20
> > /dev/nvram does not give the cpomplete CMOS details. A part=20
> of RTC & date, tine and other info will be missing.
>=20
>=20
> What Dave should have said is use /dev/nvram as well.
>=20
> >From /dev/rtc you get registers 0-9 except as you said 6
> >From /dev/nvram you get A+
>=20
> The lack of day of week is odd but fixable. The struct tm=20
> already has a
> field for tm_wday (day of week) so we can fill it in. Whether it is
> valid is another question.
>=20
> What do people thing about this ?
>=20
> Signed-off-by: Alan Cox <alan@redhat.com>
>=20
> --- drivers/char/rtc.c~	2005-12-20 23:40:34.912559808 +0000
> +++ drivers/char/rtc.c	2005-12-20 23:51:16.428034632 +0000
> @@ -46,10 +46,10 @@
>   *      1.11a   Daniele Bellucci: Audit=20
> create_proc_read_entry in rtc_init
>   *	1.12	Venkatesh Pallipadi: Hooks for emulating rtc on=20
> HPET base-timer
>   *		CONFIG_HPET_EMULATE_RTC
> - *
> + *	1.12ac	Alan Cox: Allow read access to the day of week register
>   */
> =20
> -#define RTC_VERSION		"1.12"
> +#define RTC_VERSION		"1.12ac"
> =20
>  #define RTC_IO_EXTENT	0x8
> =20
> @@ -1250,9 +1250,9 @@
> =20
>  	/*
>  	 * Only the values that we read from the RTC are set. We leave
> -	 * tm_wday, tm_yday and tm_isdst untouched. Even though the
> -	 * RTC has RTC_DAY_OF_WEEK, we ignore it, as it is only updated
> -	 * by the RTC when initially set to a non-zero value.
> +	 * tm_wday, tm_yday and tm_isdst untouched. Note that while the
> +	 * RTC has RTC_DAY_OF_WEEK, we should usually ignore=20
> it, as it is
> +	 * only updated by the RTC when initially set to a=20
> non-zero value.
>  	 */
>  	spin_lock_irq(&rtc_lock);
>  	rtc_tm->tm_sec =3D CMOS_READ(RTC_SECONDS);
> @@ -1261,6 +1261,9 @@
>  	rtc_tm->tm_mday =3D CMOS_READ(RTC_DAY_OF_MONTH);
>  	rtc_tm->tm_mon =3D CMOS_READ(RTC_MONTH);
>  	rtc_tm->tm_year =3D CMOS_READ(RTC_YEAR);
> +	/* Only set from 2.6.16 onwards */
> +	rtc_tm->tm_wday =3D CMOS_READ(RTC_DAY_OF_WEEK);
> +=09
>  #ifdef CONFIG_MACH_DECSTATION
>  	real_year =3D CMOS_READ(RTC_DEC_YEAR);
>  #endif
> @@ -1275,6 +1278,7 @@
>  		BCD_TO_BIN(rtc_tm->tm_mday);
>  		BCD_TO_BIN(rtc_tm->tm_mon);
>  		BCD_TO_BIN(rtc_tm->tm_year);
> +		BCD_TO_BIN(rtc_tm->tm_wday);
>  	}
> =20
>  #ifdef CONFIG_MACH_DECSTATION
>=20
>=20

------_=_NextPart_001_01C606C2.20A3A83A
Content-Type: application/octet-stream;
	name="CMOS.C"
Content-Transfer-Encoding: base64
Content-Description: CMOS.C
Content-Disposition: attachment;
	filename="CMOS.C"

LyoNCiogY21vcy5jIC0tIHVzaW5nIHBhcnRzIG9mIHB3ZGlnaXQuYyBieSBKYW4gU3RvaG5lcg0K
KiBBIHNpbXBsZSBpbnRlcmZhY2UgZm9yIGFjY2Vzc2luZyBjbW9zL252cmFtDQoqDQoqIExpbnV4
IHByb2dyYW1zIHVzaW5nIG91dGIvaW5iIHJlcXVpcmVzIHRoZSBnY2MgLU8yIG9wdGlvbg0KKg0K
KiBNdWx0aS1wbGF0Zm9ybSBzdXBwb3J0OiAobW9kaWZ5IGRlZmluZXMpDQoqICUgTGludXggdXNp
bmcgL2Rldi9wb3J0DQoqICUgTGludXggdXNpbmcgaW5iIGFuZCBvdXRiDQoqICUgQlNEIHVzaW5n
IGluYiBhbmQgb3V0YiwgYWNjZXNzaW5nIC9kZXYvaW8NCiogJSBCU0QgdXNpbmcgaW5iIGFuZCBv
dXRiIGFuZCBpMzg2X3NldF9pb3Blcm0NCiogJSBtc2RvcyAodHVyYm8gYykgdXNpbmcgaW5wL291
dHANCiovDQoNCi8qI2lmIGRlZmluZWQgKCBDTU9TX0RPVF9DICkqLw0KLyoNCiogY21vcy5jIGhh
cyBhbGxyZWFkeSBiZWVuIGluY2x1ZGVkIGluIHRoZSBzb3VyY2UuIHN0YXkgaWRsZS4NCiogSSdt
IGFsaXZlLi4uIGFnYWluISAtLXBvaW50bGVzcyBkdWtlIHF1b3RlDQoqLw0KLyojZWxzZSovDQov
KiNkZWZpbmUgQ01PU19ET1RfQyovDQovKg0KKiBmaXN0IGluY2x1ZGU7IGRlZmluZSBhbGwgY21v
cyBmdW5jdGlvbnMuDQoqIFRydXN0IHRoZSBzb3VyY2UsIEx1a2UhIC0tcG9pbnRsZXNzIHN0YXJ3
YXJzIHF1b3RlDQoqLw0KDQojaW5jbHVkZSA8c3RkaW8uaD4NCiNpbmNsdWRlIDxzdGRsaWIuaD4N
Cg0KLyojZGVmaW5lIENNT1NfTElOVVhfREVWUE9SVA0KI2RlZmluZSBDTU9TX0xJTlVYX09VVEJJ
TkINCiNkZWZpbmUgQ01PU19CU0RfT1VUQklOQg0KI2RlZmluZSBDTU9TX0JTRF9PVVRCSU5CX0lP
UEVSTQ0KI2RlZmluZSBDTU9TX0RPU19PVVRQSU5QKi8NCiNkZWZpbmUgQ01PU19ET1NfT1VUUElO
UA0KDQoNCiNpZiBkZWZpbmVkKCBDTU9TX0xJTlVYX0RFVlBPUlQgKQ0KCUZJTEUgKmNtb3NfZmQ7
DQojZWxpZiBkZWZpbmVkKCBDTU9TX0xJTlVYX09VVEJJTkIgKQ0KCSNpbmNsdWRlIDxhc20vaW8u
aD4NCiNlbGlmIGRlZmluZWQoIENNT1NfQlNEX09VVEJJTkIgKQ0KCS8vI2luY2x1ZGUgPGxpYmlv
Lmg+IGlzIGFsc28gbmVlZGVkIGJ5IEJTRCBhbHBoYQ0KCSNpbmNsdWRlIDxpMzg2L3Bpby5oPg0K
CUZJTEUgKmNtb3NfZmQ7DQojZWxpZiBkZWZpbmVkKCBDTU9TX0JTRF9PVVRCSU5CX0lPUEVSTSAp
DQoJLy8jaW5jbHVkZSA8bGliaW8uaD4gaXMgYWxzbyBuZWVkZWQgYnkgQlNEIGFscGhhDQoJI2lu
Y2x1ZGUgPGkzODYvcGlvLmg+DQoJdV9sb25nIGNtb3NfaW9wWzMyXTsNCgl1X2xvbmcgY21vc19p
b3BfYmFja3VwWzMyXTsNCiNlbGlmIGRlZmluZWQoIENNT1NfRE9TX09VVFBJTlAgKQ0KCSNpbmNs
dWRlIDxjb25pby5oPg0KCSNpbmNsdWRlIDxkb3MuaD4NCiNlbmRpZg0KDQpjaGFyIGNtb3NfaW5p
dGVkID0gMDsNCnR5cGVkZWYgdW5zaWduZWQgY2hhciBCWVRFOw0KDQovKg0Kdm9pZCBjbW9zX2lu
aXQoKQ0KLS0gcmVxdWVzdHMgSS9PIHBlcm1pc3Npb24gdG8gYWNjZXNzIGNtb3MvbnZyYW0NCg0K
Y29pZCBjbW9zX2ZpbmlzaCgpDQotLSByZXNldHMgSS9PIHBlcm1pc3Npb24NCg0KdW5zaWduZWQg
Y2hhciBjbW9zX2J5dGUoY2hhciBvZmZzKQ0KLS0gcmV0dXJucyAoYnl0ZSkgb2Zmcw0KDQp1bnNp
Z25lZCBpbnQgY21vc19ieXRlKGNoYXIgb2ZmcykNCi0tIHJldHVybnMgKHdvcmQpIG9mZnMNCg0K
Y2hhciogY21vc19jb3B5IChjaGFyKiBzdHIsIGludCBvZmZzLCBpbnQgbGVuKQ0KLS0gY29waWVz
IGxlbiBjaGFycyBmcm9tIGNtb3NmZnMgdG8gc3RyLCByZXR1cm5zIHN0cg0KLS0gc3RyIG11c3Qg
YmUgb2Ygc2l6ZSBsZW4rMSBvciBncmVhdGVyDQoqLw0Kdm9pZCBjbW9zX2luaXQoKQ0Kew0KCSNp
ZiBkZWZpbmVkKCBDTU9TX0xJTlVYX0RFVlBPUlQgKQ0KCQljbW9zX2ZkID0gZm9wZW4oIi9kZXYv
cG9ydCIsICJ3K2IiKTsNCgkJaWYoY21vc19mZD09TlVMTCkgew0KCQkJcGVycm9yKCJmb3BlbiAv
ZGV2L3BvcnQgZmFpbGVkIik7DQoJCQlleGl0KDEpOw0KCQl9DQoJI2VsaWYgZGVmaW5lZCggQ01P
U19MSU5VWF9PVVRCSU5CICkNCgkJaWYoc2V0dWlkKDApPT0tMSkgew0KCQkJcGVycm9yKCJzZXR1
aWQgMCAobmVlZGVkIGJ5IGlvcGVybSkgZmFpbGVkIik7DQoJCQlleGl0KDEpOw0KCQl9DQoJCWlv
cGVybSgweDcwLDIsMSk7DQoJI2VsaWYgZGVmaW5lZCggQ01PU19CU0RfT1VUQklOQiApDQoJCWNt
b3NfZmQgPSBmb3BlbigiL2Rldi9pbyIsICJyIik7DQoJCWlmKGNtb3NfZmQ9PU5VTEwpew0KCQkJ
cGVycm9yKCJmb3BlbiAvZGV2L2lvIGZhaWxlZCIpOw0KCQkJZXhpdCgxKTsNCgkJfQ0KCSNlbGlm
IGRlZmluZWQoIENNT1NfQlNEX09VVEJJTkJfSU9QRVJNICkNCgkJaTM4Nl9nZXRfaW9wZXJtKGNt
b3NfaW9wKTsNCgkJYmNvcHkoY21vc19pb3BfYmFja3VwLGNtb3NfaW9wLDMyKnNpemVvZih1X2xv
bmcpKTsNCgkJY21vc19pb3BbM109MDsNCgkJY21vc19pb3BbNF09MDsNCgkvKiBoZXJlIHdlIGFj
dHVhbGx5IHdvdWxkIGhhdmUgdG8gc2V0IDE2dGggYW5kIDE3dGggYml0ZXMNCgl0byAwIGJ1dCBJ
IGNsZW4gdG9ucywgdG8gYXZvaWQgYml0ZXMgY291bnRpbmcsIGV0YyAqLw0KCQlpZihpMzg2X3Nl
dF9pb3Blcm0oY21vc19pb3ApIT0wKXsNCgkJCXBlcnJvcigiaTM4Nl9zZXRfaW9wZXJtIGZhaWxl
ZCIpOw0KCQkJZXhpdCgxKTsNCgkJfQ0KCSNlbGlmIGRlZmluZWQoIENNT1NfRE9TX09VVFBJTlAg
KQ0KCSNlbmRpZg0KDQoJY21vc19pbml0ZWQgPSAxOw0KfQ0KDQp2b2lkIGNtb3NfZmluaXNoKCkN
CnsNCgkjaWYgZGVmaW5lZCggQ01PU19MSU5VWF9ERVZQT1JUICkNCgkJZmNsb3NlKGNtb3NfZmQp
Ow0KDQoJI2VsaWYgZGVmaW5lZCggQ01PU19MSU5VWF9PVVRCSU5CICkNCgkJaW9wZXJtKDB4NzAs
MiwwKTsNCg0KCSNlbGlmIGRlZmluZWQoIENNT1NfQlNEX09VVEJJTkIgKQ0KCQlmY2xvc2UoY21v
c19mZCk7DQoNCgkjZWxpZiBkZWZpbmVkKCBDTU9TX0JTRF9PVVRCSU5CX0lPUEVSTSApDQoJCWkz
ODZfc2V0X2lvcGVybShjbW9zX2lvcF9iYWNrdXApOw0KDQoJI2VsaWYgZGVmaW5lZCggQ01PU19E
T1NfT1VUUElOUCApDQoJI2VuZGlmDQoJY21vc19pbml0ZWQgPSAwOw0KfQ0KDQp1bnNpZ25lZCBj
aGFyIGNtb3NfYnl0ZShjaGFyIG9mZnNldCkNCnsNCgl1bnNpZ25lZCBjaGFyIGJ1ZixhOw0KDQoJ
aWYgKGNtb3NfaW5pdGVkID09IDApDQoJCWNtb3NfaW5pdCgpOw0KDQoJI2lmIGRlZmluZWQoIENN
T1NfTElOVVhfREVWUE9SVCApDQoJCWZzZWVrKGNtb3NfZmQsIChsb25nKSAweDcwLCBTRUVLX1NF
VCk7DQoJCWJ1ZiA9IG9mZnNldDsNCgkJZndyaXRlKCZidWYsIDEsIDEsIGNtb3NfZmQpOw0KCQlm
cmVhZCgmYSwgMSwgMSwgY21vc19mZCk7DQoNCgkjZWxpZiBkZWZpbmVkKCBDTU9TX0xJTlVYX09V
VEJJTkIgKQ0KCQlvdXRiKG9mZnNldCwweDcwKTsNCgkJYSA9IGluYigweDcxKTsNCg0KCSNlbGlm
IGRlZmluZWQoIENNT1NfQlNEX09VVEJJTkIgKQ0KCQlvdXRiKDB4NzAsb2Zmc2V0KTsNCgkJYSA9
IGluYigweDcxKTsNCg0KCSNlbGlmIGRlZmluZWQoIENNT1NfQlNEX09VVEJJTkJfSU9QRVJNICkN
CgkJb3V0YigweDcwLG9mZnNldCk7DQoJCWEgPSBpbmIoMHg3MSk7DQoNCgkjZWxpZiBkZWZpbmVk
KCBDTU9TX0RPU19PVVRQSU5QICkNCgkJb3V0cCgweDcwLG9mZnNldCk7DQoJCWEgPSBpbnAoMHg3
MSk7DQoNCgkjZW5kaWYNCglyZXR1cm4oYSk7DQp9DQoNCnVuc2lnbmVkIGludCBjbW9zX3dvcmQo
Y2hhciBvZmZzKQ0Kew0KCXVuc2lnbmVkIGNoYXIgYSxiOw0KCWEgPSBjbW9zX2J5dGUob2Zmcyk7
DQoJYiA9IGNtb3NfYnl0ZShvZmZzKzEpOw0KCXJldHVybigodW5zaWduZWQgaW50KWErMjU2Kih1
bnNpZ25lZCBpbnQpYik7DQp9DQoNCmNoYXIqIGNtb3NfY29weSAoY2hhciogc3RyLCBpbnQgb2Zm
c2V0LCBpbnQgbGVuKQ0Kew0KCS8qDQoJKiBjbW9zX2NvcHkgY29waWVzIGxlbiBjaGFyYWN0ZXJz
IGZyb20gY21vcyBvZmZzZXQNCgkqIHN0ciBtdXN0IGJlIG9mIHNpemUgbGVuKzENCgkqLw0KCWlu
dCBjbnQ7DQoJZm9yIChjbnQ9MDsgY250PGxlbjsgY250KyspDQoJCXN0cltjbnRdID0gY21vc19i
eXRlKCBvZmZzZXQrY250ICk7DQoJc3RyW2xlbl0gPSAnXDAnOw0KCXJldHVybiAoc3RyKTsNCn0N
Cg0KaW50IG1haW4odm9pZCkNCnsNCglpbnQgaTsNCglCWVRFIGRhdGE7DQoNCglwcmludGYoIlxu
XHRcdENvcHlyaWdodCAyMDA1IFRlY2hub2xvZ2llcyBQYXRod2F5cywgTExDIik7DQoJcHJpbnRm
KCJcblx0XHRcdHd3dy5UZWNoUGF0aHdheXMuY29tXG5cblxuXG4iKTsNCg0KCWNtb3NfaW5pdCgp
Ow0KCWZvcihpPTA7IGkgPCAyNTY7IGkrKykNCgkgew0KCQkgZGF0YSA9IGNtb3NfYnl0ZShpKTsN
CgkJIHByaW50ZigiJTAyeGggOiAlMDJ4aFx0IiwgaSwgZGF0YSk7DQoJIH0NCgljbW9zX2Zpbmlz
aCgpOw0KCWdldGNoKCk7DQoNCglyZXR1cm4gMDsNCn0NCg0KDQovKiNlbmRpZiovIC8qIGlmIGRl
ZmluZWQgKCBDTU9TX0RPVF9DICkgKi8NCho=

------_=_NextPart_001_01C606C2.20A3A83A--
