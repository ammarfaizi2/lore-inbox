Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261940AbVEWTxu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261940AbVEWTxu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 15:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261937AbVEWTxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 15:53:49 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:38756 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S261941AbVEWTxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 15:53:37 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C55FD1.15C9C588"
Subject: RE: [PATCH] bug in VIA PCI IRQ routing
Date: Mon, 23 May 2005 12:53:41 -0700
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C31B4902@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] bug in VIA PCI IRQ routing
Thread-Index: AcVfxIcJY+b9DhzqRjKIhA2HkKwI9AAC/+UA
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: "Ondrej Zary" <linux@rainbow-software.org>
Cc: "Karsten Keil" <kkeil@suse.de>, <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, <jgarzik@pobox.com>
X-OriginalArrivalTime: 23 May 2005 19:53:36.0387 (UTC) FILETIME=[1B7C6D30:01C55FD1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C55FD1.15C9C588
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20

>-----Original Message-----
>From: Ondrej Zary [mailto:linux@rainbow-software.org]=20
>Sent: Monday, May 23, 2005 11:25 AM
>To: Aleksey Gorelov
>Cc: Karsten Keil; linux-kernel@vger.kernel.org; Andrew Morton;=20
>jgarzik@pobox.com
>Subject: Re: [PATCH] bug in VIA PCI IRQ routing
>
>Aleksey Gorelov wrote:
>>>-----Original Message-----
>>>From: Karsten Keil [mailto:kkeil@suse.de]=20
>>>Sent: Monday, May 23, 2005 5:59 AM
>>>To: linux-kernel@vger.kernel.org
>>>Cc: Andrew Morton; Aleksey Gorelov
>>>Subject: [PATCH] bug in VIA PCI IRQ routing
>>>
>>>Hi,
>>>
>>>during certification of some systems with VIA 82C586_0 chipset
>>>we found that the PCI IRQ routing of PIRQD line goes wrong and=20
>>>the system
>>>will get stuck because of unacknowledged IRQs.
>>>It seems that the special case for PIRQD (pirq 4) is not=20
>needed for all
>>>VIA versions. With this patch, the IRQ routing on these systems works
>>>again (It did work with older 2.4 kernel versions prior the=20
>>>PIRQD change)
>>=20
>>=20
>>  Does anybody have 82C586 datasheet to verify 0x57 register ?=20
>> For all I can say, both 82C686 & 8231 DO need special handling for
>> PIRQD,=20
>> since PIRQD routing is setup via bits 7-4 in 0x57 (see=20
>datasheets from
>> VIA=20
>> website). It seems like 82C586 might be different...
>>=20
>> Aleks.
>>=20
>
>This is from 82C586B datasheet (the 82C586A datasheet shows the same=20
>register layout):
>
>Note: The definitions of the fields of the following three
>registers were incorrectly documented in some earlier
>revisions of this document. The silicon has not changed
>and the following definition should be used for all silicon
>revisions:
>
>Offset 55 - PNP IRQ Routing 1=20
>....................................... RW
>These bits control routing for external IRQ inputs MIRQ0-1.
>7-4 PIRQD# Routing (see PnP IRQ routing table)
>3-0 MIRQ0 Routing (see PnP IRQ routing table)
>
>Offset 56 - PNP IRQ Routing 2=20
>....................................... RW
>7-4 PIRQA# Routing (see PnP IRQ routing table)
>3-0 PIRQB# Routing (see PnP IRQ routing table)
>
>Offset 57 - PNP IRQ Routing 3=20
>....................................... RW
>7-4 PIRQC# Routing (see PnP IRQ routing table)
>3-0 MIRQ1 Routing (see PnP IRQ routing table)
>
>Note: these bits must be set to 0 if Rx48[4]=3D1 and
>Rx59[1]=3D1 (input IRQ8# on MIRQ1 pin 106)
>
>PnP IRQ Routing Table
>0000 Disabled................................................. default
>0001 IRQ1
>0010 Reserved
>0011 IRQ3
>0100 IRQ4
>0101 IRQ5
>0110 IRQ6
>0111 IRQ7
>1000 Reserved
>1001 IRQ9
>1010 IRQ10
>1011 IRQ11
>1100 IRQ12
>1101 Reserved
>1110 IRQ14
>1111 IRQ15

Hmm, this is way different.

Karsten,=20

  could you please verify if attached patch works for you ?
  Another unknown C596 south bridge. I wonder if it the same as 586, or
closer to 686 ?

Aleks.

>
>
>>=20
>>>diff -urN linux-2.6.12-rc4-git7.org/arch/i386/pci/irq.c=20
>>>linux-2.6.12-rc4-git7/arch/i386/pci/irq.c
>>>--- linux-2.6.12-rc4-git7.org/arch/i386/pci/irq.c=09
>>>2005-05-23 13:35:48.562759583 +0200
>>>+++ linux-2.6.12-rc4-git7/arch/i386/pci/irq.c	2005-05-23=20
>>>13:41:47.349473060 +0200
>>>@@ -26,6 +26,7 @@
>>>
>>>static int broken_hp_bios_irq9;
>>>static int acer_tm360_irqrouting;
>>>+static int via_pirq_patch_value =3D 5;
>>>
>>>static struct irq_routing_table *pirq_table;
>>>
>>>@@ -217,12 +218,12 @@
>>> */
>>>static int pirq_via_get(struct pci_dev *router, struct=20
>>>pci_dev *dev, int pirq)
>>>{
>>>-	return read_config_nybble(router, 0x55, pirq =3D=3D 4 ? 5 : pirq);
>>>+	return read_config_nybble(router, 0x55, pirq =3D=3D 4 ?=20
>>>via_pirq_patch_value : pirq);
>>>}
>>>
>>>static int pirq_via_set(struct pci_dev *router, struct=20
>>>pci_dev *dev, int pirq, int irq)
>>>{
>>>-	write_config_nybble(router, 0x55, pirq =3D=3D 4 ? 5 : pirq, irq);
>>>+	write_config_nybble(router, 0x55, pirq =3D=3D 4 ?=20
>>>via_pirq_patch_value : pirq, irq);
>>>	return 1;
>>>}
>>>
>>>@@ -512,6 +513,7 @@
>>>	switch(device)
>>>	{
>>>		case PCI_DEVICE_ID_VIA_82C586_0:
>>>+			via_pirq_patch_value =3D 4;
>>>		case PCI_DEVICE_ID_VIA_82C596:
>>>		case PCI_DEVICE_ID_VIA_82C686:
>>>		case PCI_DEVICE_ID_VIA_8231:
>>>
>>>--=20
>>>Karsten Keil
>>>SuSE Labs
>>>ISDN development
>>>
>>=20
>>=20
>> -
>> To unsubscribe from this list: send the line "unsubscribe=20
>linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>=20
>
>
>--=20
>Ondrej Zary
>

------_=_NextPart_001_01C55FD1.15C9C588
Content-Type: application/octet-stream;
	name="via.patch"
Content-Transfer-Encoding: base64
Content-Description: via.patch
Content-Disposition: attachment;
	filename="via.patch"

LS0tIGxpbnV4LTIuNi4xMS4xMC9hcmNoL2kzODYvcGNpL2lycS5jCTIwMDUtMDUtMTYgMTA6NTA6
MzAuMDAwMDAwMDAwIC0wNzAwCisrKyBuZXcvYXJjaC9pMzg2L3BjaS9pcnEuYwkyMDA1LTA1LTIz
IDEyOjQ3OjE5LjAwMDAwMDAwMCAtMDcwMApAQCAtMjI3LDYgKzIyNywyNCBAQAogfQogCiAvKgor
ICogVGhlIFZJQSBwaXJxIHJ1bGVzIGFyZSBuaWJibGUtYmFzZWQsIGxpa2UgQUxJLAorICogYnV0
IHdpdGhvdXQgdGhlIHVnbHkgaXJxIG51bWJlciBtdW5naW5nLgorICogSG93ZXZlciwgZm9yIDgy
QzU4NiwgbmliYmxlIG1hcCBpcyBkaWZmZXJlbnQgLgorICovCitzdGF0aWMgaW50IHBpcnFfdmlh
NTg2X2dldChzdHJ1Y3QgcGNpX2RldiAqcm91dGVyLCBzdHJ1Y3QgcGNpX2RldiAqZGV2LCBpbnQg
cGlycSkKK3sKKwlzdGF0aWMgdW5zaWduZWQgaW50IHBpcnFtYXBbNF0gPSB7IDMsIDIsIDUsIDEg
fTsKKwlyZXR1cm4gcmVhZF9jb25maWdfbnliYmxlKHJvdXRlciwgMHg1NSwgcGlycW1hcFtwaXJx
LTFdKTsKK30KKworc3RhdGljIGludCBwaXJxX3ZpYTU4Nl9zZXQoc3RydWN0IHBjaV9kZXYgKnJv
dXRlciwgc3RydWN0IHBjaV9kZXYgKmRldiwgaW50IHBpcnEsIGludCBpcnEpCit7CisJc3RhdGlj
IHVuc2lnbmVkIGludCBwaXJxbWFwWzRdID0geyAzLCAyLCA1LCAxIH07CisJd3JpdGVfY29uZmln
X255YmJsZShyb3V0ZXIsIDB4NTUsIHBpcnFtYXBbcGlycS0xXSwgaXJxKTsKKwlyZXR1cm4gMTsK
K30KKworLyoKICAqIElURSA4MzMwRyBwaXJxIHJ1bGVzIGFyZSBuaWJibGUtYmFzZWQKICAqIEZJ
WE1FOiBwaXJxbWFwIG1heSBiZSB7IDEsIDAsIDMsIDIgfSwKICAqIAkgIDIrMyBhcmUgYm90aCBt
YXBwZWQgdG8gaXJxIDkgb24gbXkgc3lzdGVtCkBAIC01MDksNiArNTI3LDEwIEBACiAJc3dpdGNo
KGRldmljZSkKIAl7CiAJCWNhc2UgUENJX0RFVklDRV9JRF9WSUFfODJDNTg2XzA6CisJCQlyLT5u
YW1lID0gIlZJQSI7CisJCQlyLT5nZXQgPSBwaXJxX3ZpYTU4Nl9nZXQ7CisJCQlyLT5zZXQgPSBw
aXJxX3ZpYTU4Nl9zZXQ7CisJCQlyZXR1cm4gMTsKIAkJY2FzZSBQQ0lfREVWSUNFX0lEX1ZJQV84
MkM1OTY6CiAJCWNhc2UgUENJX0RFVklDRV9JRF9WSUFfODJDNjg2OgogCQljYXNlIFBDSV9ERVZJ
Q0VfSURfVklBXzgyMzE6Cg==

------_=_NextPart_001_01C55FD1.15C9C588--
