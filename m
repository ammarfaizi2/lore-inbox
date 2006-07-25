Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbWGYOpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbWGYOpp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 10:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWGYOpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 10:45:19 -0400
Received: from mail0.lsil.com ([147.145.40.20]:14995 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932367AbWGYOpO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 10:45:14 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6AFF8.E0E971E6"
Subject: [PATCH 1/3] scsi : megaraid_{mm,mbox}: 64-bit DMA capability checker
Date: Tue, 25 Jul 2006 08:44:48 -0600
Message-ID: <890BF3111FB9484E9526987D912B261932E2CF@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/3] scsi : megaraid_{mm,mbox}: 64-bit DMA capability checker
Thread-Index: Acav+OCpOKGOzOy/TySmOeN1nSwIBw==
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: <vvs@sw.ru>, <James.Bottomley@SteelEye.com>, <akpm@osdl.org>
Cc: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       "Patro, Sumant" <Sumant.Patro@engenio.com>,
       "Yang, Bo" <Bo.Yang@engenio.com>
X-OriginalArrivalTime: 25 Jul 2006 14:44:49.0441 (UTC) FILETIME=[E15DD110:01C6AFF8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6AFF8.E0E971E6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

This patch contains=20
- a fix for 64-bit DMA capability check in megaraid_{mm,mbox} driver.
- includes changes (going back to 32-bit DMA mask if 64-bit DMA mask
failes) suggested by James with previous patch.
- addition of SATA 150-4/6 as commented by Vasily Averin.

With patch, the driver access PCIconfiguration space with dedicated=20
offset to read a signature. If the signature read, it means that the=20
controller has capability to handle 64-bit DMA.=20
Without this patch, the driver used to blindly claim 64-bit DMA
capability.
The issue has been reported by Vasily Averin [vvs@sw.ru].=20
Thank you Vasily for the reporting.

Thank you,

Seokmann

Signed-Off By: Seokmann Ju <seokmann.ju@lsil.com>
---
diff -Naur git/Documentation/scsi/ChangeLog.megaraid
64bitdma/Documentation/scsi/ChangeLog.megaraid
--- git/Documentation/scsi/ChangeLog.megaraid	2006-07-16
16:22:29.000000000 -0400
+++ 64bitdma/Documentation/scsi/ChangeLog.megaraid	2006-07-17
18:01:21.000000000 -0400
@@ -1,3 +1,64 @@
+Release Date	: Fri May 19 09:31:45 EST 2006 - Seokmann Ju
<sju@lsil.com>
+Current Version : 2.20.4.9 (scsi module), 2.20.2.6 (cmm module)
+Older Version	: 2.20.4.8 (scsi module), 2.20.2.6 (cmm module)
+
+1.	Fixed a bug in megaraid_init_mbox().
+	Customer reported "garbage in file on x86_64 platform".
+	Root Cause: the driver registered controllers as 64-bit DMA
capable
+	for those which are not support it.
+	Fix: Made change in the function inserting identification
machanism
+	identifying 64-bit DMA capable controllers.
+
+	> -----Original Message-----
+	> From: Vasily Averin [mailto:vvs@sw.ru]=20
+	> Sent: Thursday, May 04, 2006 2:49 PM
+	> To: linux-scsi@vger.kernel.org; Kolli, Neela; Mukker, Atul;=20
+	> Ju, Seokmann; Bagalkote, Sreenivas;=20
+	> James.Bottomley@SteelEye.com; devel@openvz.org
+	> Subject: megaraid_mbox: garbage in file
+	>=20
+	> Hello all,
+	>=20
+	> I've investigated customers claim on the unstable work of=20
+	> their node and found a
+	> strange effect: reading from some files leads to the
+	>  "attempt to access beyond end of device" messages.
+	>=20
+	> I've checked filesystem, memory on the node, motherboard BIOS=20
+	> version, but it
+	> does not help and issue still has been reproduced by simple=20
+	> file reading.
+	>=20
+	> Reproducer is simple:
+	>=20
+	> echo 0xffffffff >/proc/sys/dev/scsi/logging_level ;
+	> cat /vz/private/101/root/etc/ld.so.cache >/tmp/ttt  ;
+	> echo 0 >/proc/sys/dev/scsi/logging
+	>=20
+	> It leads to the following messages in dmesg
+	>=20
+	> sd_init_command: disk=3Dsda, block=3D871769260, count=3D26
+	> sda : block=3D871769260
+	> sda : reading 26/26 512 byte blocks.
+	> scsi_add_timer: scmd: f79ed980, time: 7500, (c02b1420)
+	> sd 0:1:0:0: send 0xf79ed980                  sd 0:1:0:0:
+	>         command: Read (10): 28 00 33 f6 24 ac 00 00 1a 00
+	> buffer =3D 0xf7cfb540, bufflen =3D 13312, done =3D 0xc0366b40,=20
+	> queuecommand 0xc0344010
+	> leaving scsi_dispatch_cmnd()
+	> scsi_delete_timer: scmd: f79ed980, rtn: 1
+	> sd 0:1:0:0: done 0xf79ed980 SUCCESS        0 sd 0:1:0:0:
+	>         command: Read (10): 28 00 33 f6 24 ac 00 00 1a 00
+	> scsi host busy 1 failed 0
+	> sd 0:1:0:0: Notifying upper driver of completion (result 0)
+	> sd_rw_intr: sda: res=3D0x0
+	> 26 sectors total, 13312 bytes done.
+	> use_sg is 4
+	> attempt to access beyond end of device
+	> sda6: rw=3D0, want=3D1044134458, limit=3D951401367
+	> Buffer I/O error on device sda6, logical block 522067228
+	> attempt to access beyond end of device
+
 Release Date	: Mon Apr 11 12:27:22 EST 2006 - Seokmann Ju
<sju@lsil.com>
 Current Version : 2.20.4.8 (scsi module), 2.20.2.6 (cmm module)
 Older Version	: 2.20.4.7 (scsi module), 2.20.2.6 (cmm module)
diff -Naur git/drivers/scsi/megaraid/mega_common.h
64bitdma/drivers/scsi/megaraid/mega_common.h
--- git/drivers/scsi/megaraid/mega_common.h	2006-07-16
16:22:29.000000000 -0400
+++ 64bitdma/drivers/scsi/megaraid/mega_common.h	2006-07-24
15:30:45.000000000 -0400
@@ -37,6 +37,9 @@
 #define LSI_MAX_CHANNELS		16
 #define LSI_MAX_LOGICAL_DRIVES_64LD	(64+1)
=20
+#define HBA_SIGNATURE_64_BIT		0x299
+#define PCI_CONF_AMISIG64		0xa4
+
=20
 /**
  * scb_t - scsi command control block
diff -Naur git/drivers/scsi/megaraid/megaraid_mbox.c
64bitdma/drivers/scsi/megaraid/megaraid_mbox.c
--- git/drivers/scsi/megaraid/megaraid_mbox.c	2006-07-16
16:22:29.000000000 -0400
+++ 64bitdma/drivers/scsi/megaraid/megaraid_mbox.c	2006-07-25
09:50:26.000000000 -0400
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mbox.c
- * Version	: v2.20.4.8 (Apr 11 2006)
+ * Version	: v2.20.4.9 (Jul 16 2006)
  *
  * Authors:
  * 	Atul Mukker		<Atul.Mukker@lsil.com>
@@ -720,6 +720,7 @@
 	struct pci_dev		*pdev;
 	mraid_device_t		*raid_dev;
 	int			i;
+	uint32_t		magic64;
=20
=20
 	adapter->ito	=3D MBOX_TIMEOUT;
@@ -863,12 +864,33 @@
=20
 	// Set the DMA mask to 64-bit. All supported controllers as
capable of
 	// DMA in this range
-	if (pci_set_dma_mask(adapter->pdev, DMA_64BIT_MASK) !=3D 0) {
+	pci_read_config_dword(adapter->pdev, PCI_CONF_AMISIG64,
&magic64);
=20
-		con_log(CL_ANN, (KERN_WARNING
-			"megaraid: could not set DMA mask for
64-bit.\n"));
-
-		goto out_free_sysfs_res;
+	if (((magic64 =3D=3D HBA_SIGNATURE_64_BIT) &&
+		((adapter->pdev->subsystem_device !=3D
+		PCI_SUBSYS_ID_MEGARAID_SATA_150_6) ||
+		(adapter->pdev->subsystem_device !=3D
+		PCI_SUBSYS_ID_MEGARAID_SATA_150_4))) ||
+		(adapter->pdev->vendor =3D=3D PCI_VENDOR_ID_LSI_LOGIC &&=20
+		adapter->pdev->device =3D=3D PCI_DEVICE_ID_VERDE) ||=20
+		(adapter->pdev->vendor =3D=3D PCI_VENDOR_ID_LSI_LOGIC &&=20
+		adapter->pdev->device =3D=3D PCI_DEVICE_ID_DOBSON) ||=20
+		(adapter->pdev->vendor =3D=3D PCI_VENDOR_ID_LSI_LOGIC &&=20
+		adapter->pdev->device =3D=3D PCI_DEVICE_ID_LINDSAY) ||=20
+		(adapter->pdev->vendor =3D=3D PCI_VENDOR_ID_DELL &&=20
+		adapter->pdev->device =3D=3D
PCI_DEVICE_ID_PERC4_DI_EVERGLADES) ||=20
+		(adapter->pdev->vendor =3D=3D PCI_VENDOR_ID_DELL &&=20
+		adapter->pdev->device =3D=3D PCI_DEVICE_ID_PERC4E_DI_KOBUK))
{ =20
+		if (pci_set_dma_mask(adapter->pdev, DMA_64BIT_MASK)) {
+			con_log(CL_ANN, (KERN_WARNING=20
+				"megaraid: DMA mask for 64-bit
failed\n"));
+
+			if (pci_set_dma_mask (adapter->pdev,
DMA_32BIT_MASK)) {
+				con_log(CL_ANN, (KERN_WARNING=20
+					"megaraid: 32-bit DMA mask
failed\n"));
+				goto out_free_sysfs_res;
+			}
+		}
 	}
=20
 	// setup tasklet for DPC
diff -Naur git/drivers/scsi/megaraid/megaraid_mbox.h
64bitdma/drivers/scsi/megaraid/megaraid_mbox.h
--- git/drivers/scsi/megaraid/megaraid_mbox.h	2006-07-16
16:22:29.000000000 -0400
+++ 64bitdma/drivers/scsi/megaraid/megaraid_mbox.h	2006-07-24
15:30:23.000000000 -0400
@@ -21,8 +21,8 @@
 #include "megaraid_ioctl.h"
=20
=20
-#define MEGARAID_VERSION	"2.20.4.8"
-#define MEGARAID_EXT_VERSION	"(Release Date: Mon Apr 11 12:27:22 EST
2006)"
+#define MEGARAID_VERSION	"2.20.4.9"
+#define MEGARAID_EXT_VERSION	"(Release Date: Sun Jul 16 12:27:22 EST
2006)"
=20
=20
 /*
---

------_=_NextPart_001_01C6AFF8.E0E971E6
Content-Type: application/octet-stream;
	name="megaraid_64bitdmacheck.patch"
Content-Transfer-Encoding: base64
Content-Description: megaraid_64bitdmacheck.patch
Content-Disposition: attachment;
	filename="megaraid_64bitdmacheck.patch"

ZGlmZiAtTmF1ciBnaXQvRG9jdW1lbnRhdGlvbi9zY3NpL0NoYW5nZUxvZy5tZWdhcmFpZCA2NGJp
dGRtYS9Eb2N1bWVudGF0aW9uL3Njc2kvQ2hhbmdlTG9nLm1lZ2FyYWlkCi0tLSBnaXQvRG9jdW1l
bnRhdGlvbi9zY3NpL0NoYW5nZUxvZy5tZWdhcmFpZAkyMDA2LTA3LTE2IDE2OjIyOjI5LjAwMDAw
MDAwMCAtMDQwMAorKysgNjRiaXRkbWEvRG9jdW1lbnRhdGlvbi9zY3NpL0NoYW5nZUxvZy5tZWdh
cmFpZAkyMDA2LTA3LTE3IDE4OjAxOjIxLjAwMDAwMDAwMCAtMDQwMApAQCAtMSwzICsxLDY0IEBA
CitSZWxlYXNlIERhdGUJOiBGcmkgTWF5IDE5IDA5OjMxOjQ1IEVTVCAyMDA2IC0gU2Vva21hbm4g
SnUgPHNqdUBsc2lsLmNvbT4KK0N1cnJlbnQgVmVyc2lvbiA6IDIuMjAuNC45IChzY3NpIG1vZHVs
ZSksIDIuMjAuMi42IChjbW0gbW9kdWxlKQorT2xkZXIgVmVyc2lvbgk6IDIuMjAuNC44IChzY3Np
IG1vZHVsZSksIDIuMjAuMi42IChjbW0gbW9kdWxlKQorCisxLglGaXhlZCBhIGJ1ZyBpbiBtZWdh
cmFpZF9pbml0X21ib3goKS4KKwlDdXN0b21lciByZXBvcnRlZCAiZ2FyYmFnZSBpbiBmaWxlIG9u
IHg4Nl82NCBwbGF0Zm9ybSIuCisJUm9vdCBDYXVzZTogdGhlIGRyaXZlciByZWdpc3RlcmVkIGNv
bnRyb2xsZXJzIGFzIDY0LWJpdCBETUEgY2FwYWJsZQorCWZvciB0aG9zZSB3aGljaCBhcmUgbm90
IHN1cHBvcnQgaXQuCisJRml4OiBNYWRlIGNoYW5nZSBpbiB0aGUgZnVuY3Rpb24gaW5zZXJ0aW5n
IGlkZW50aWZpY2F0aW9uIG1hY2hhbmlzbQorCWlkZW50aWZ5aW5nIDY0LWJpdCBETUEgY2FwYWJs
ZSBjb250cm9sbGVycy4KKworCT4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0KKwk+IEZyb206
IFZhc2lseSBBdmVyaW4gW21haWx0bzp2dnNAc3cucnVdIAorCT4gU2VudDogVGh1cnNkYXksIE1h
eSAwNCwgMjAwNiAyOjQ5IFBNCisJPiBUbzogbGludXgtc2NzaUB2Z2VyLmtlcm5lbC5vcmc7IEtv
bGxpLCBOZWVsYTsgTXVra2VyLCBBdHVsOyAKKwk+IEp1LCBTZW9rbWFubjsgQmFnYWxrb3RlLCBT
cmVlbml2YXM7IAorCT4gSmFtZXMuQm90dG9tbGV5QFN0ZWVsRXllLmNvbTsgZGV2ZWxAb3BlbnZ6
Lm9yZworCT4gU3ViamVjdDogbWVnYXJhaWRfbWJveDogZ2FyYmFnZSBpbiBmaWxlCisJPiAKKwk+
IEhlbGxvIGFsbCwKKwk+IAorCT4gSSd2ZSBpbnZlc3RpZ2F0ZWQgY3VzdG9tZXJzIGNsYWltIG9u
IHRoZSB1bnN0YWJsZSB3b3JrIG9mIAorCT4gdGhlaXIgbm9kZSBhbmQgZm91bmQgYQorCT4gc3Ry
YW5nZSBlZmZlY3Q6IHJlYWRpbmcgZnJvbSBzb21lIGZpbGVzIGxlYWRzIHRvIHRoZQorCT4gICJh
dHRlbXB0IHRvIGFjY2VzcyBiZXlvbmQgZW5kIG9mIGRldmljZSIgbWVzc2FnZXMuCisJPiAKKwk+
IEkndmUgY2hlY2tlZCBmaWxlc3lzdGVtLCBtZW1vcnkgb24gdGhlIG5vZGUsIG1vdGhlcmJvYXJk
IEJJT1MgCisJPiB2ZXJzaW9uLCBidXQgaXQKKwk+IGRvZXMgbm90IGhlbHAgYW5kIGlzc3VlIHN0
aWxsIGhhcyBiZWVuIHJlcHJvZHVjZWQgYnkgc2ltcGxlIAorCT4gZmlsZSByZWFkaW5nLgorCT4g
CisJPiBSZXByb2R1Y2VyIGlzIHNpbXBsZToKKwk+IAorCT4gZWNobyAweGZmZmZmZmZmID4vcHJv
Yy9zeXMvZGV2L3Njc2kvbG9nZ2luZ19sZXZlbCA7CisJPiBjYXQgL3Z6L3ByaXZhdGUvMTAxL3Jv
b3QvZXRjL2xkLnNvLmNhY2hlID4vdG1wL3R0dCAgOworCT4gZWNobyAwID4vcHJvYy9zeXMvZGV2
L3Njc2kvbG9nZ2luZworCT4gCisJPiBJdCBsZWFkcyB0byB0aGUgZm9sbG93aW5nIG1lc3NhZ2Vz
IGluIGRtZXNnCisJPiAKKwk+IHNkX2luaXRfY29tbWFuZDogZGlzaz1zZGEsIGJsb2NrPTg3MTc2
OTI2MCwgY291bnQ9MjYKKwk+IHNkYSA6IGJsb2NrPTg3MTc2OTI2MAorCT4gc2RhIDogcmVhZGlu
ZyAyNi8yNiA1MTIgYnl0ZSBibG9ja3MuCisJPiBzY3NpX2FkZF90aW1lcjogc2NtZDogZjc5ZWQ5
ODAsIHRpbWU6IDc1MDAsIChjMDJiMTQyMCkKKwk+IHNkIDA6MTowOjA6IHNlbmQgMHhmNzllZDk4
MCAgICAgICAgICAgICAgICAgIHNkIDA6MTowOjA6CisJPiAgICAgICAgIGNvbW1hbmQ6IFJlYWQg
KDEwKTogMjggMDAgMzMgZjYgMjQgYWMgMDAgMDAgMWEgMDAKKwk+IGJ1ZmZlciA9IDB4ZjdjZmI1
NDAsIGJ1ZmZsZW4gPSAxMzMxMiwgZG9uZSA9IDB4YzAzNjZiNDAsIAorCT4gcXVldWVjb21tYW5k
IDB4YzAzNDQwMTAKKwk+IGxlYXZpbmcgc2NzaV9kaXNwYXRjaF9jbW5kKCkKKwk+IHNjc2lfZGVs
ZXRlX3RpbWVyOiBzY21kOiBmNzllZDk4MCwgcnRuOiAxCisJPiBzZCAwOjE6MDowOiBkb25lIDB4
Zjc5ZWQ5ODAgU1VDQ0VTUyAgICAgICAgMCBzZCAwOjE6MDowOgorCT4gICAgICAgICBjb21tYW5k
OiBSZWFkICgxMCk6IDI4IDAwIDMzIGY2IDI0IGFjIDAwIDAwIDFhIDAwCisJPiBzY3NpIGhvc3Qg
YnVzeSAxIGZhaWxlZCAwCisJPiBzZCAwOjE6MDowOiBOb3RpZnlpbmcgdXBwZXIgZHJpdmVyIG9m
IGNvbXBsZXRpb24gKHJlc3VsdCAwKQorCT4gc2RfcndfaW50cjogc2RhOiByZXM9MHgwCisJPiAy
NiBzZWN0b3JzIHRvdGFsLCAxMzMxMiBieXRlcyBkb25lLgorCT4gdXNlX3NnIGlzIDQKKwk+IGF0
dGVtcHQgdG8gYWNjZXNzIGJleW9uZCBlbmQgb2YgZGV2aWNlCisJPiBzZGE2OiBydz0wLCB3YW50
PTEwNDQxMzQ0NTgsIGxpbWl0PTk1MTQwMTM2NworCT4gQnVmZmVyIEkvTyBlcnJvciBvbiBkZXZp
Y2Ugc2RhNiwgbG9naWNhbCBibG9jayA1MjIwNjcyMjgKKwk+IGF0dGVtcHQgdG8gYWNjZXNzIGJl
eW9uZCBlbmQgb2YgZGV2aWNlCisKIFJlbGVhc2UgRGF0ZQk6IE1vbiBBcHIgMTEgMTI6Mjc6MjIg
RVNUIDIwMDYgLSBTZW9rbWFubiBKdSA8c2p1QGxzaWwuY29tPgogQ3VycmVudCBWZXJzaW9uIDog
Mi4yMC40LjggKHNjc2kgbW9kdWxlKSwgMi4yMC4yLjYgKGNtbSBtb2R1bGUpCiBPbGRlciBWZXJz
aW9uCTogMi4yMC40LjcgKHNjc2kgbW9kdWxlKSwgMi4yMC4yLjYgKGNtbSBtb2R1bGUpCmRpZmYg
LU5hdXIgZ2l0L2RyaXZlcnMvc2NzaS9tZWdhcmFpZC9tZWdhX2NvbW1vbi5oIDY0Yml0ZG1hL2Ry
aXZlcnMvc2NzaS9tZWdhcmFpZC9tZWdhX2NvbW1vbi5oCi0tLSBnaXQvZHJpdmVycy9zY3NpL21l
Z2FyYWlkL21lZ2FfY29tbW9uLmgJMjAwNi0wNy0xNiAxNjoyMjoyOS4wMDAwMDAwMDAgLTA0MDAK
KysrIDY0Yml0ZG1hL2RyaXZlcnMvc2NzaS9tZWdhcmFpZC9tZWdhX2NvbW1vbi5oCTIwMDYtMDct
MjQgMTU6MzA6NDUuMDAwMDAwMDAwIC0wNDAwCkBAIC0zNyw2ICszNyw5IEBACiAjZGVmaW5lIExT
SV9NQVhfQ0hBTk5FTFMJCTE2CiAjZGVmaW5lIExTSV9NQVhfTE9HSUNBTF9EUklWRVNfNjRMRAko
NjQrMSkKIAorI2RlZmluZSBIQkFfU0lHTkFUVVJFXzY0X0JJVAkJMHgyOTkKKyNkZWZpbmUgUENJ
X0NPTkZfQU1JU0lHNjQJCTB4YTQKKwogCiAvKioKICAqIHNjYl90IC0gc2NzaSBjb21tYW5kIGNv
bnRyb2wgYmxvY2sKZGlmZiAtTmF1ciBnaXQvZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2FyYWlk
X21ib3guYyA2NGJpdGRtYS9kcml2ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRfbWJveC5jCi0t
LSBnaXQvZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2FyYWlkX21ib3guYwkyMDA2LTA3LTE2IDE2
OjIyOjI5LjAwMDAwMDAwMCAtMDQwMAorKysgNjRiaXRkbWEvZHJpdmVycy9zY3NpL21lZ2FyYWlk
L21lZ2FyYWlkX21ib3guYwkyMDA2LTA3LTI1IDA5OjUwOjI2LjAwMDAwMDAwMCAtMDQwMApAQCAt
MTAsNyArMTAsNyBAQAogICoJICAgMiBvZiB0aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIgb3B0aW9u
KSBhbnkgbGF0ZXIgdmVyc2lvbi4KICAqCiAgKiBGSUxFCQk6IG1lZ2FyYWlkX21ib3guYwotICog
VmVyc2lvbgk6IHYyLjIwLjQuOCAoQXByIDExIDIwMDYpCisgKiBWZXJzaW9uCTogdjIuMjAuNC45
IChKdWwgMTYgMjAwNikKICAqCiAgKiBBdXRob3JzOgogICogCUF0dWwgTXVra2VyCQk8QXR1bC5N
dWtrZXJAbHNpbC5jb20+CkBAIC03MjAsNiArNzIwLDcgQEAKIAlzdHJ1Y3QgcGNpX2RldgkJKnBk
ZXY7CiAJbXJhaWRfZGV2aWNlX3QJCSpyYWlkX2RldjsKIAlpbnQJCQlpOworCXVpbnQzMl90CQlt
YWdpYzY0OwogCiAKIAlhZGFwdGVyLT5pdG8JPSBNQk9YX1RJTUVPVVQ7CkBAIC04NjMsMTIgKzg2
NCwzMyBAQAogCiAJLy8gU2V0IHRoZSBETUEgbWFzayB0byA2NC1iaXQuIEFsbCBzdXBwb3J0ZWQg
Y29udHJvbGxlcnMgYXMgY2FwYWJsZSBvZgogCS8vIERNQSBpbiB0aGlzIHJhbmdlCi0JaWYgKHBj
aV9zZXRfZG1hX21hc2soYWRhcHRlci0+cGRldiwgRE1BXzY0QklUX01BU0spICE9IDApIHsKKwlw
Y2lfcmVhZF9jb25maWdfZHdvcmQoYWRhcHRlci0+cGRldiwgUENJX0NPTkZfQU1JU0lHNjQsICZt
YWdpYzY0KTsKIAotCQljb25fbG9nKENMX0FOTiwgKEtFUk5fV0FSTklORwotCQkJIm1lZ2FyYWlk
OiBjb3VsZCBub3Qgc2V0IERNQSBtYXNrIGZvciA2NC1iaXQuXG4iKSk7Ci0KLQkJZ290byBvdXRf
ZnJlZV9zeXNmc19yZXM7CisJaWYgKCgobWFnaWM2NCA9PSBIQkFfU0lHTkFUVVJFXzY0X0JJVCkg
JiYKKwkJKChhZGFwdGVyLT5wZGV2LT5zdWJzeXN0ZW1fZGV2aWNlICE9CisJCVBDSV9TVUJTWVNf
SURfTUVHQVJBSURfU0FUQV8xNTBfNikgfHwKKwkJKGFkYXB0ZXItPnBkZXYtPnN1YnN5c3RlbV9k
ZXZpY2UgIT0KKwkJUENJX1NVQlNZU19JRF9NRUdBUkFJRF9TQVRBXzE1MF80KSkpIHx8CisJCShh
ZGFwdGVyLT5wZGV2LT52ZW5kb3IgPT0gUENJX1ZFTkRPUl9JRF9MU0lfTE9HSUMgJiYgCisJCWFk
YXB0ZXItPnBkZXYtPmRldmljZSA9PSBQQ0lfREVWSUNFX0lEX1ZFUkRFKSB8fCAKKwkJKGFkYXB0
ZXItPnBkZXYtPnZlbmRvciA9PSBQQ0lfVkVORE9SX0lEX0xTSV9MT0dJQyAmJiAKKwkJYWRhcHRl
ci0+cGRldi0+ZGV2aWNlID09IFBDSV9ERVZJQ0VfSURfRE9CU09OKSB8fCAKKwkJKGFkYXB0ZXIt
PnBkZXYtPnZlbmRvciA9PSBQQ0lfVkVORE9SX0lEX0xTSV9MT0dJQyAmJiAKKwkJYWRhcHRlci0+
cGRldi0+ZGV2aWNlID09IFBDSV9ERVZJQ0VfSURfTElORFNBWSkgfHwgCisJCShhZGFwdGVyLT5w
ZGV2LT52ZW5kb3IgPT0gUENJX1ZFTkRPUl9JRF9ERUxMICYmIAorCQlhZGFwdGVyLT5wZGV2LT5k
ZXZpY2UgPT0gUENJX0RFVklDRV9JRF9QRVJDNF9ESV9FVkVSR0xBREVTKSB8fCAKKwkJKGFkYXB0
ZXItPnBkZXYtPnZlbmRvciA9PSBQQ0lfVkVORE9SX0lEX0RFTEwgJiYgCisJCWFkYXB0ZXItPnBk
ZXYtPmRldmljZSA9PSBQQ0lfREVWSUNFX0lEX1BFUkM0RV9ESV9LT0JVSykpIHsgIAorCQlpZiAo
cGNpX3NldF9kbWFfbWFzayhhZGFwdGVyLT5wZGV2LCBETUFfNjRCSVRfTUFTSykpIHsKKwkJCWNv
bl9sb2coQ0xfQU5OLCAoS0VSTl9XQVJOSU5HIAorCQkJCSJtZWdhcmFpZDogRE1BIG1hc2sgZm9y
IDY0LWJpdCBmYWlsZWRcbiIpKTsKKworCQkJaWYgKHBjaV9zZXRfZG1hX21hc2sgKGFkYXB0ZXIt
PnBkZXYsIERNQV8zMkJJVF9NQVNLKSkgeworCQkJCWNvbl9sb2coQ0xfQU5OLCAoS0VSTl9XQVJO
SU5HIAorCQkJCQkibWVnYXJhaWQ6IDMyLWJpdCBETUEgbWFzayBmYWlsZWRcbiIpKTsKKwkJCQln
b3RvIG91dF9mcmVlX3N5c2ZzX3JlczsKKwkJCX0KKwkJfQogCX0KIAogCS8vIHNldHVwIHRhc2ts
ZXQgZm9yIERQQwpkaWZmIC1OYXVyIGdpdC9kcml2ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRf
bWJveC5oIDY0Yml0ZG1hL2RyaXZlcnMvc2NzaS9tZWdhcmFpZC9tZWdhcmFpZF9tYm94LmgKLS0t
IGdpdC9kcml2ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRfbWJveC5oCTIwMDYtMDctMTYgMTY6
MjI6MjkuMDAwMDAwMDAwIC0wNDAwCisrKyA2NGJpdGRtYS9kcml2ZXJzL3Njc2kvbWVnYXJhaWQv
bWVnYXJhaWRfbWJveC5oCTIwMDYtMDctMjQgMTU6MzA6MjMuMDAwMDAwMDAwIC0wNDAwCkBAIC0y
MSw4ICsyMSw4IEBACiAjaW5jbHVkZSAibWVnYXJhaWRfaW9jdGwuaCIKIAogCi0jZGVmaW5lIE1F
R0FSQUlEX1ZFUlNJT04JIjIuMjAuNC44IgotI2RlZmluZSBNRUdBUkFJRF9FWFRfVkVSU0lPTgki
KFJlbGVhc2UgRGF0ZTogTW9uIEFwciAxMSAxMjoyNzoyMiBFU1QgMjAwNikiCisjZGVmaW5lIE1F
R0FSQUlEX1ZFUlNJT04JIjIuMjAuNC45IgorI2RlZmluZSBNRUdBUkFJRF9FWFRfVkVSU0lPTgki
KFJlbGVhc2UgRGF0ZTogU3VuIEp1bCAxNiAxMjoyNzoyMiBFU1QgMjAwNikiCiAKIAogLyoK

------_=_NextPart_001_01C6AFF8.E0E971E6--
