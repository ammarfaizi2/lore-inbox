Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965238AbVHPN4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965238AbVHPN4J (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 09:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965240AbVHPN4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 09:56:08 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:19347 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S965237AbVHPN4H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 09:56:07 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6.13-rc6] MODULE_DEVICE_TABLE for cpqfcTS driver
Date: Tue, 16 Aug 2005 15:57:35 +0200
User-Agent: KMail/1.8.2
Cc: Jiri Slaby <jirislaby@gmail.com>, linux-scsi@vger.kernel.org,
       James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bolke de Bruin <bdbruin@aub.nl>, Greg KH <greg@kroah.com>
References: <200508051202.07091@bilbo.math.uni-mannheim.de> <200508161111.35431@bilbo.math.uni-mannheim.de> <4301E1AE.6010501@gmail.com>
In-Reply-To: <4301E1AE.6010501@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1243065.6xEbQJN4la";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200508161557.44013@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1243065.6xEbQJN4la
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jiri Slaby wrote:
>Rolf Eike Beer napsal(a):
>>Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
>>
>>--- a/drivers/scsi/cpqfcTSinit.c	2005-08-14 14:20:40.000000000 +0200
>>+++ b/drivers/scsi/cpqfcTSinit.c	2005-08-14 14:25:33.000000000 +0200
>>@@ -264,18 +264,14 @@ static void launch_FCworker_thread(struc
>>  * Agilent XL2
>>  * HP Tachyon
>>  */
>>-#define HBA_TYPES 3
>>-
>>-#ifndef PCI_DEVICE_ID_COMPAQ_
>>-#define PCI_DEVICE_ID_COMPAQ_TACHYON	0xa0fc
>>-#endif
>>-
>>-static struct SupportedPCIcards cpqfc_boards[] __initdata =3D {
>>-	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_TACHYON},
>>-	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_TACHLITE},
>>-	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_TACHYON},
>>+static struct pci_device_id cpqfc_boards[] __initdata =3D {
>>+	{PCI_VENDOR_ID_COMPAQ, PCI_DEVICE_ID_COMPAQ_TACHYON, PCI_ANY_ID,
>> PCI_ANY_ID, 0, 0, 0}, +	{PCI_VENDOR_ID_HP, PCI_DEVICE_ID_HP_TACHLITE,
>> PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, +	{PCI_VENDOR_ID_HP,
>> PCI_DEVICE_ID_HP_TACHYON, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0}, +	{0, }
>> };
>
>Wouldn't be better to use PCI_DEVICE macro for better readability?

Yes, useful little thing. Thanks, I wasn't aware of it.

>>+MODULE_DEVICE_TABLE(pci, cpqfc_boards);
>>
>> int cpqfcTS_detect(Scsi_Host_Template *ScsiHostTemplate)
>> {
>>@@ -294,14 +290,9 @@ int cpqfcTS_detect(Scsi_Host_Template *S
>>   ScsiHostTemplate->proc_name =3D "cpqfcTS";
>> #endif
>>
>>-  for( i=3D0; i < HBA_TYPES; i++)
>>-  {
>>-    // look for all HBAs of each type
>>-
>>-    while((PciDev =3D pci_find_device(cpqfc_boards[i].vendor_id,
>>-				    cpqfc_boards[i].device_id, PciDev)))
>>-    {
>>-
>>+  for(i =3D 0; cpqfc_boards[i]; i++) {
>>+    while((PciDev =3D pci_get_device(cpqfc_boards[i].vendor,
>>+				    cpqfc_boards[i].device, PciDev))) {
>>       if (pci_enable_device(PciDev)) {
>> 	printk(KERN_ERR
>> 		"cpqfc: can't enable PCI device at %s\n", pci_name(PciDev));
>
>You maybe forgot to add pci_dev_put in error cases.=20

No, all errors will result in next iteration of this loop. Anyway this=20
function should be rewritten. Once I figure out how to do the correct=20
register stuff for SCSI drivers I'll port this over to Linux 2.6 driver=20
model. Then this loop will go away.

>You can inspire yourself here:
>http://www.fi.muni.cz/~xslaby/lnx/pci_find/drivers:scsi:cpqfcTSinit.c.txt
>(it wasn't accepted yet).

*g* I've done such patches more than once ;)

>BTW. Greg KH wants me to cc him, if some of these changes are being done.

I read that, yes. But I had reasons not to CC him. This change is more or l=
ess=20
to prevent others touching this file ;)

Eike

P.S.: your host is listed in cbl.abuseat.org. You should go and check this.=
=20
Either you have a dynamic IP used by someone dumb before (than you have to=
=20
ask them for delisting) or you probably have some sort of security hole.

--nextPart1243065.6xEbQJN4la
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBDAfDXXKSJPmm5/E4RAjIzAJ9HqtTUKJtmaXLZ1uhd67qC8t3hrQCeN3yg
MkM682KWkfB5GeFMGwmnjz4=
=ZYE6
-----END PGP SIGNATURE-----

--nextPart1243065.6xEbQJN4la--
