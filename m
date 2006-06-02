Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932570AbWFBUTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932570AbWFBUTG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 16:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932563AbWFBUTG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 16:19:06 -0400
Received: from smtp.innovsys.com ([66.115.232.196]:6477 "EHLO
	mail.innovsys.com") by vger.kernel.org with ESMTP id S932562AbWFBUTE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 16:19:04 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C68681.CA18E5D6"
Subject: [PATCH 2.6.16.16] sata_sil24: SII3124 sata driver endian problem
Date: Fri, 2 Jun 2006 15:19:02 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B0189DE08@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B0189DDFF@ismail.innsys.innovsys.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.16.16] sata_sil24: SII3124 sata driver endian problem
Thread-Index: AcaFv8xqQfnWQQbGTze2ic8xHnA91gAwHs7g
From: "Rune Torgersen" <runet@innovsys.com>
To: <jgarzik@pobox.com>
Cc: <linuxppc-dev@ozlabs.org>, <linux-kernel@vger.kernel.org>,
       <linux-ide@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C68681.CA18E5D6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

> -----Original Message-----
> From: Rune Torgersen
> Sent: Thursday, June 01, 2006 16:10
> To: linuxppc-dev@ozlabs.org
> Subject: SII3124-2
>=20
> Has anybody been successful in getting a SII3124-2 based SATA=20
> controller
> to work under PPC?
>=20
> I have a eval board that I tried on two different freescale boards (a
> MPC8266ADS board and a MPC8560ADS board).
> Kernel 2.6.16.16.
>=20
> Here is the relevant output from the kernel.
>=20
> ata1: SATA max UDMA/100 cmd 0xD1010000 ctl 0x0 bmdma 0x0 irq 115
> ata2: SATA max UDMA/100 cmd 0xD1012000 ctl 0x0 bmdma 0x0 irq 115
> ata3: SATA max UDMA/100 cmd 0xD1014000 ctl 0x0 bmdma 0x0 irq 115
> ata4: SATA max UDMA/100 cmd 0xD1016000 ctl 0x0 bmdma 0x0 irq 115
> ata1: SATA link down (SStatus 0)
> scsi0 : sata_sil24
> ata2: SATA link up 3.0 Gbps (SStatus 123)
> sata_sil24 ata2: SRST failed, disabling port
> scsi1 : sata_sil24
> ata3: SATA link down (SStatus 0)
> scsi2 : sata_sil24
> ata4: SATA link down (SStatus 0)
> scsi3 : sata_sil24
>=20
> I added debug output to see the content of the Command Error register.
> It is set to 26 which according to the datasheet for the 3124-1 (I am
> running a -2), is PLDCMDERRORMASTERABORT, "A PCI Master Abort occurred
> while the SiI3124 was fetching a Port Request Block (PRB) from host
> memory."

There is an endian issue in the sil24 driver.=20
The follwing pathc seems to fix it for me. (it is also attached in case
the mailer borks it for me)

Signed-off-by: Rune Torgersen <runet@innovsys.com>

Index: linux-innsys-2.6.16.16/drivers/scsi/sata_sil24.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-innsys-2.6.16.16/drivers/scsi/sata_sil24.c	(revision 101)
+++ linux-innsys-2.6.16.16/drivers/scsi/sata_sil24.c	(working copy)
@@ -446,7 +446,7 @@
 	 */
 	msleep(10);
=20
-	prb->ctrl =3D PRB_CTRL_SRST;
+	prb->ctrl =3D cpu_to_le16(PRB_CTRL_SRST);
 	prb->fis[1] =3D 0; /* no PM yet */
=20
 	writel((u32)paddr, port + PORT_CMD_ACTIVATE);
@@ -537,9 +537,9 @@
=20
 		if (qc->tf.protocol !=3D ATA_PROT_ATAPI_NODATA) {
 			if (qc->tf.flags & ATA_TFLAG_WRITE)
-				prb->ctrl =3D PRB_CTRL_PACKET_WRITE;
+				prb->ctrl =3D
cpu_to_le16(PRB_CTRL_PACKET_WRITE);
 			else
-				prb->ctrl =3D PRB_CTRL_PACKET_READ;
+				prb->ctrl =3D
cpu_to_le16(PRB_CTRL_PACKET_READ);
 		} else
 			prb->ctrl =3D 0;
=20

------_=_NextPart_001_01C68681.CA18E5D6
Content-Type: application/octet-stream;
	name="sil24_endian_patch"
Content-Transfer-Encoding: base64
Content-Description: sil24_endian_patch
Content-Disposition: attachment;
	filename="sil24_endian_patch"

SW5kZXg6IGxpbnV4LWlubnN5cy0yLjYuMTYuMTYvZHJpdmVycy9zY3NpL3NhdGFfc2lsMjQuYwo9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09Ci0tLSBsaW51eC1pbm5zeXMtMi42LjE2LjE2L2RyaXZlcnMvc2NzaS9zYXRhX3Np
bDI0LmMJKHJldmlzaW9uIDEwMSkKKysrIGxpbnV4LWlubnN5cy0yLjYuMTYuMTYvZHJpdmVycy9z
Y3NpL3NhdGFfc2lsMjQuYwkod29ya2luZyBjb3B5KQpAQCAtNDQ2LDcgKzQ0Niw3IEBACiAJICov
CiAJbXNsZWVwKDEwKTsKIAotCXByYi0+Y3RybCA9IFBSQl9DVFJMX1NSU1Q7CisJcHJiLT5jdHJs
ID0gY3B1X3RvX2xlMTYoUFJCX0NUUkxfU1JTVCk7CiAJcHJiLT5maXNbMV0gPSAwOyAvKiBubyBQ
TSB5ZXQgKi8KIAogCXdyaXRlbCgodTMyKXBhZGRyLCBwb3J0ICsgUE9SVF9DTURfQUNUSVZBVEUp
OwpAQCAtNTM3LDkgKzUzNyw5IEBACiAKIAkJaWYgKHFjLT50Zi5wcm90b2NvbCAhPSBBVEFfUFJP
VF9BVEFQSV9OT0RBVEEpIHsKIAkJCWlmIChxYy0+dGYuZmxhZ3MgJiBBVEFfVEZMQUdfV1JJVEUp
Ci0JCQkJcHJiLT5jdHJsID0gUFJCX0NUUkxfUEFDS0VUX1dSSVRFOworCQkJCXByYi0+Y3RybCA9
IGNwdV90b19sZTE2KFBSQl9DVFJMX1BBQ0tFVF9XUklURSk7CiAJCQllbHNlCi0JCQkJcHJiLT5j
dHJsID0gUFJCX0NUUkxfUEFDS0VUX1JFQUQ7CisJCQkJcHJiLT5jdHJsID0gY3B1X3RvX2xlMTYo
UFJCX0NUUkxfUEFDS0VUX1JFQUQpOwogCQl9IGVsc2UKIAkJCXByYi0+Y3RybCA9IDA7CiAK

------_=_NextPart_001_01C68681.CA18E5D6--
