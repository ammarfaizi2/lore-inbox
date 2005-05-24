Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262138AbVEXQ0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262138AbVEXQ0v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 12:26:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262137AbVEXQ0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 12:26:50 -0400
Received: from scl-ims.phoenix.com ([216.148.212.222]:60742 "EHLO
	scl-exch2k.phoenix.com") by vger.kernel.org with ESMTP
	id S262138AbVEXQY7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 12:24:59 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5607D.21AF5441"
Subject: RE: [PATCH] bug in VIA PCI IRQ routing
Date: Tue, 24 May 2005 09:24:56 -0700
Message-ID: <0EF82802ABAA22479BC1CE8E2F60E8C31B4A8C@scl-exch2k3.phoenix.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] bug in VIA PCI IRQ routing
Thread-Index: AcVgMld1SwRw+irbTreCpalUP8STOgASc+mA
From: "Aleksey Gorelov" <Aleksey_Gorelov@Phoenix.com>
To: <marcelo.tosatti@cyclades.com>
Cc: "Ondrej Zary" <linux@rainbow-software.org>, <linux-kernel@vger.kernel.org>,
       "Andrew Morton" <akpm@osdl.org>, <jgarzik@pobox.com>,
       "Karsten Keil" <kkeil@suse.de>
X-OriginalArrivalTime: 24 May 2005 16:24:59.0354 (UTC) FILETIME=[212A83A0:01C5607D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5607D.21AF5441
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Marcelo,

  Attached comes appropriate patch for 2.4
 =20
  Signed-off-by: Aleksey Gorelov <aleksey_gorelov@phoenix.com>

Previously posted patch for 2.6 had been verified by Karsten Keil
<kkeil@suse.de>.

According to the VIA 82C586B datasheet (still available from
http://gkernel.sourceforge.net/specs/via/586b.pdf.bz2) this chip needs
a special PIRQ mapping. Again, according to appropriate datasheets,=20
82C596, 82C686 & 8231 should continue utilize old scheme.

>-----Original Message-----
>From: Karsten Keil [mailto:kkeil@suse.de]=20
>Sent: Tuesday, May 24, 2005 12:29 AM
>To: Aleksey Gorelov
>Cc: Ondrej Zary; linux-kernel@vger.kernel.org; Andrew Morton;=20
>jgarzik@pobox.com
>Subject: Re: [PATCH] bug in VIA PCI IRQ routing
>
>Hi,
>
>On Mon, May 23, 2005 at 12:53:41PM -0700, Aleksey Gorelov wrote:
>>=20
>> Karsten,=20
>>=20
>>   could you please verify if attached patch works for you ?
>
>Works and seems to be OK, according to the specs. So this
>patch should go into the kernel, also into 2.4 I think.
>These chipset is still used on small special purpose systems.
>
>--- linux-2.6.11.10/arch/i386/pci/irq.c	2005-05-16=20
>10:50:30.000000000 -0700
>+++ new/arch/i386/pci/irq.c	2005-05-23 12:47:19.000000000 -0700
>@@ -227,6 +227,24 @@
> }
>=20
> /*
>+ * The VIA pirq rules are nibble-based, like ALI,
>+ * but without the ugly irq number munging.
>+ * However, for 82C586, nibble map is different .
>+ */
>+static int pirq_via586_get(struct pci_dev *router, struct=20
>pci_dev *dev, int pirq)
>+{
>+	static unsigned int pirqmap[4] =3D { 3, 2, 5, 1 };
>+	return read_config_nybble(router, 0x55, pirqmap[pirq-1]);
>+}
>+
>+static int pirq_via586_set(struct pci_dev *router, struct=20
>pci_dev *dev, int pirq, int irq)
>+{
>+	static unsigned int pirqmap[4] =3D { 3, 2, 5, 1 };
>+	write_config_nybble(router, 0x55, pirqmap[pirq-1], irq);
>+	return 1;
>+}
>+
>+/*
>  * ITE 8330G pirq rules are nibble-based
>  * FIXME: pirqmap may be { 1, 0, 3, 2 },
>  * 	  2+3 are both mapped to irq 9 on my system
>@@ -509,6 +527,10 @@
> 	switch(device)
> 	{
> 		case PCI_DEVICE_ID_VIA_82C586_0:
>+			r->name =3D "VIA";
>+			r->get =3D pirq_via586_get;
>+			r->set =3D pirq_via586_set;
>+			return 1;
> 		case PCI_DEVICE_ID_VIA_82C596:
> 		case PCI_DEVICE_ID_VIA_82C686:
> 		case PCI_DEVICE_ID_VIA_8231:
>
>--=20
>Karsten Keil
>SuSE Labs
>ISDN development
>

------_=_NextPart_001_01C5607D.21AF5441
Content-Type: application/octet-stream;
	name="via24.patch"
Content-Transfer-Encoding: base64
Content-Description: via24.patch
Content-Disposition: attachment;
	filename="via24.patch"

LS0tIGxpbnV4LTIuNC4zMC9hcmNoL2kzODYva2VybmVsL3BjaS1pcnEuYwkyMDA1LTA0LTAzIDE4
OjQyOjE5LjAwMDAwMDAwMCAtMDcwMAorKysgbmV3L2FyY2gvaTM4Ni9rZXJuZWwvcGNpLWlycS5j
CTIwMDUtMDUtMjQgMDg6NTc6MjIuMDAwMDAwMDAwIC0wNzAwCkBAIC0yMTUsNiArMjE1LDI0IEBA
CiB9CiAKIC8qCisgKiBUaGUgVklBIHBpcnEgcnVsZXMgYXJlIG5pYmJsZS1iYXNlZCwgbGlrZSBB
TEksCisgKiBidXQgd2l0aG91dCB0aGUgdWdseSBpcnEgbnVtYmVyIG11bmdpbmcuCisgKiBIb3dl
dmVyLCBmb3IgODJDNTg2LCBuaWJibGUgbWFwIGlzIGRpZmZlcmVudCAuCisgKi8KK3N0YXRpYyBp
bnQgcGlycV92aWE1ODZfZ2V0KHN0cnVjdCBwY2lfZGV2ICpyb3V0ZXIsIHN0cnVjdCBwY2lfZGV2
ICpkZXYsIGludCBwaXJxKQoreworCXN0YXRpYyB1bnNpZ25lZCBpbnQgcGlycW1hcFs0XSA9IHsg
MywgMiwgNSwgMSB9OworCXJldHVybiByZWFkX2NvbmZpZ19ueWJibGUocm91dGVyLCAweDU1LCBw
aXJxbWFwW3BpcnEtMV0pOworfQorCitzdGF0aWMgaW50IHBpcnFfdmlhNTg2X3NldChzdHJ1Y3Qg
cGNpX2RldiAqcm91dGVyLCBzdHJ1Y3QgcGNpX2RldiAqZGV2LCBpbnQgcGlycSwgaW50IGlycSkK
K3sKKwlzdGF0aWMgdW5zaWduZWQgaW50IHBpcnFtYXBbNF0gPSB7IDMsIDIsIDUsIDEgfTsKKwl3
cml0ZV9jb25maWdfbnliYmxlKHJvdXRlciwgMHg1NSwgcGlycW1hcFtwaXJxLTFdLCBpcnEpOwor
CXJldHVybiAxOworfQorCisvKgogICogSVRFIDgzMzBHIHBpcnEgcnVsZXMgYXJlIG5pYmJsZS1i
YXNlZAogICogRklYTUU6IHBpcnFtYXAgbWF5IGJlIHsgMSwgMCwgMywgMiB9LAogICogCSAgMisz
IGFyZSBib3RoIG1hcHBlZCB0byBpcnEgOSBvbiBteSBzeXN0ZW0KQEAgLTY0OSw2ICs2NjcsMTAg
QEAKIAlzd2l0Y2goZGV2aWNlKQogCXsKIAkJY2FzZSBQQ0lfREVWSUNFX0lEX1ZJQV84MkM1ODZf
MDoKKwkJCXItPm5hbWUgPSAiVklBIjsKKwkJCXItPmdldCA9IHBpcnFfdmlhNTg2X2dldDsKKwkJ
CXItPnNldCA9IHBpcnFfdmlhNTg2X3NldDsKKwkJCXJldHVybiAxOwogCQljYXNlIFBDSV9ERVZJ
Q0VfSURfVklBXzgyQzU5NjoKIAkJY2FzZSBQQ0lfREVWSUNFX0lEX1ZJQV84MkM2ODY6CiAJCWNh
c2UgUENJX0RFVklDRV9JRF9WSUFfODIzMToK

------_=_NextPart_001_01C5607D.21AF5441--
