Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932337AbWESPJ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932337AbWESPJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 11:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932338AbWESPJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 11:09:57 -0400
Received: from mail0.lsil.com ([147.145.40.20]:5847 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932337AbWESPJ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 11:09:56 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C67B56.30783F51"
Subject: [PATCH 1/1] scsi : megaraid_{mm,mbox}: a fix on 64-bit DMA capability check
Date: Fri, 19 May 2006 09:09:13 -0600
Message-ID: <890BF3111FB9484E9526987D912B261901BD91@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] scsi : megaraid_{mm,mbox}: a fix on 64-bit DMA capability check
Thread-Index: AcZ7VjBVpkgX0KAWQ5KtnVztl3eZdw==
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Vasily Averin" <vvs@sw.ru>,
       "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Andrew Morton" <akpm@osdl.org>
Cc: <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 19 May 2006 15:09:14.0283 (UTC) FILETIME=[30CDB7B0:01C67B56]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C67B56.30783F51
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

This patch contains a fix for 64-bit DMA capability check in
megaraid_{mm,mbox} driver. With patch, the driver access PCI
configuration space with dedicated offset to read a signature. If the
signature read, it means that the controller has capability to handle
64-bit DMA. Before this patch, the driver blindly claimed the capability
without checking with controller.
The issue has been reported by Vasily Averin [vvs@sw.ru]. Thank you
Vasily for the reporting.

Thank you,

Seokmann

Signed-Off By: Seokmann Ju <seokmann.ju@lsil.com>
---
diff -Naur old/Documentation/scsi/ChangeLog.megaraid
new/Documentation/scsi/ChangeLog.megaraid
--- old/Documentation/scsi/ChangeLog.megaraid	2006-05-19
08:58:26.000000000 -0400
+++ new/Documentation/scsi/ChangeLog.megaraid	2006-05-19
09:22:48.000000000 -0400
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
diff -Naur old/drivers/scsi/megaraid/mega_common.h
new/drivers/scsi/megaraid/mega_common.h
--- old/drivers/scsi/megaraid/mega_common.h	2006-05-19
08:58:59.000000000 -0400
+++ new/drivers/scsi/megaraid/mega_common.h	2006-05-19
09:51:48.000000000 -0400
@@ -37,7 +37,8 @@
 #define LSI_MAX_CHANNELS		16
 #define LSI_MAX_LOGICAL_DRIVES_64LD	(64+1)
=20
-
+#define HBA_SIGNATURE_64BIT		0x0299
+#define PCI_CONF_AMISIG64		0xa4
 /**
  * scb_t - scsi command control block
  * @param ccb		: command control block for individual driver
diff -Naur old/drivers/scsi/megaraid/megaraid_mbox.c
new/drivers/scsi/megaraid/megaraid_mbox.c
--- old/drivers/scsi/megaraid/megaraid_mbox.c	2006-05-19
08:58:59.000000000 -0400
+++ new/drivers/scsi/megaraid/megaraid_mbox.c	2006-05-19
10:52:11.000000000 -0400
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mbox.c
- * Version	: v2.20.4.8 (Apr 11 2006)
+ * Version	: v2.20.4.9 (May 19 2006)
  *
  * Authors:
  * 	Atul Mukker		<Atul.Mukker@lsil.com>
@@ -720,7 +720,7 @@
 	struct pci_dev		*pdev;
 	mraid_device_t		*raid_dev;
 	int			i;
-
+	unsigned int		magic64;
=20
 	adapter->ito	=3D MBOX_TIMEOUT;
 	pdev		=3D adapter->pdev;
@@ -863,12 +863,25 @@
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
+	if ((magic64 =3D=3D HBA_SIGNATURE_64BIT) ||=20
+		(adapter->pdev->vendor =3D=3D PCI_VENDOR_ID_DELL &&
+		adapter->pdev->device =3D=3D
PCI_DEVICE_ID_PERC4_DI_EVERGLADES) ||
+		(adapter->pdev->vendor =3D=3D PCI_VENDOR_ID_LSI_LOGIC &&
+		adapter->pdev->device =3D=3D PCI_DEVICE_ID_VERDE) ||
+		(adapter->pdev->vendor =3D=3D PCI_VENDOR_ID_LSI_LOGIC &&
+		adapter->pdev->device =3D=3D PCI_DEVICE_ID_DOBSON) ||
+		(adapter->pdev->vendor =3D=3D PCI_VENDOR_ID_DELL &&
+		adapter->pdev->device =3D=3D PCI_DEVICE_ID_PERC4E_DI_KOBUK)
||
+		(adapter->pdev->vendor =3D=3D PCI_VENDOR_ID_LSI_LOGIC &&
+		adapter->pdev->device =3D=3D PCI_DEVICE_ID_LINDSAY)) {
+		if (pci_set_dma_mask(adapter->pdev, DMA_64BIT_MASK) !=3D
0) {
+			con_log(CL_ANN, (KERN_WARNING
+				"megaraid: could not set DMA mask for
64-bit.\n"));
=20
-		goto out_free_sysfs_res;
+			goto out_free_sysfs_res;
+		}
 	}
=20
 	// setup tasklet for DPC
diff -Naur old/drivers/scsi/megaraid/megaraid_mbox.h
new/drivers/scsi/megaraid/megaraid_mbox.h
--- old/drivers/scsi/megaraid/megaraid_mbox.h	2006-05-19
08:58:59.000000000 -0400
+++ new/drivers/scsi/megaraid/megaraid_mbox.h	2006-05-19
10:22:13.000000000 -0400
@@ -21,8 +21,8 @@
 #include "megaraid_ioctl.h"
=20
=20
-#define MEGARAID_VERSION	"2.20.4.8"
-#define MEGARAID_EXT_VERSION	"(Release Date: Mon Apr 11 12:27:22 EST
2006)"
+#define MEGARAID_VERSION	"2.20.4.9"
+#define MEGARAID_EXT_VERSION	"(Release Date: Fri May 19 09:45:22 EST
2006)"
=20
=20
 /*
---

------_=_NextPart_001_01C67B56.30783F51
Content-Type: application/octet-stream;
	name="megaraid_mm_mbox_64bit_dma_check.patch"
Content-Transfer-Encoding: base64
Content-Description: megaraid_mm_mbox_64bit_dma_check.patch
Content-Disposition: attachment;
	filename="megaraid_mm_mbox_64bit_dma_check.patch"

ZGlmZiAtTmF1ciBvbGQvRG9jdW1lbnRhdGlvbi9zY3NpL0NoYW5nZUxvZy5tZWdhcmFpZCBuZXcv
RG9jdW1lbnRhdGlvbi9zY3NpL0NoYW5nZUxvZy5tZWdhcmFpZAotLS0gb2xkL0RvY3VtZW50YXRp
b24vc2NzaS9DaGFuZ2VMb2cubWVnYXJhaWQJMjAwNi0wNS0xOSAwODo1ODoyNi4wMDAwMDAwMDAg
LTA0MDAKKysrIG5ldy9Eb2N1bWVudGF0aW9uL3Njc2kvQ2hhbmdlTG9nLm1lZ2FyYWlkCTIwMDYt
MDUtMTkgMDk6MjI6NDguMDAwMDAwMDAwIC0wNDAwCkBAIC0xLDMgKzEsNjQgQEAKK1JlbGVhc2Ug
RGF0ZQk6IEZyaSBNYXkgMTkgMDk6MzE6NDUgRVNUIDIwMDYgLSBTZW9rbWFubiBKdSA8c2p1QGxz
aWwuY29tPgorQ3VycmVudCBWZXJzaW9uIDogMi4yMC40LjkgKHNjc2kgbW9kdWxlKSwgMi4yMC4y
LjYgKGNtbSBtb2R1bGUpCitPbGRlciBWZXJzaW9uCTogMi4yMC40LjggKHNjc2kgbW9kdWxlKSwg
Mi4yMC4yLjYgKGNtbSBtb2R1bGUpCisKKzEuCUZpeGVkIGEgYnVnIGluIG1lZ2FyYWlkX2luaXRf
bWJveCgpLgorCUN1c3RvbWVyIHJlcG9ydGVkICJnYXJiYWdlIGluIGZpbGUgb24geDg2XzY0IHBs
YXRmb3JtIi4KKwlSb290IENhdXNlOiB0aGUgZHJpdmVyIHJlZ2lzdGVyZWQgY29udHJvbGxlcnMg
YXMgNjQtYml0IERNQSBjYXBhYmxlCisJZm9yIHRob3NlIHdoaWNoIGFyZSBub3Qgc3VwcG9ydCBp
dC4KKwlGaXg6IE1hZGUgY2hhbmdlIGluIHRoZSBmdW5jdGlvbiBpbnNlcnRpbmcgaWRlbnRpZmlj
YXRpb24gbWFjaGFuaXNtCisJaWRlbnRpZnlpbmcgNjQtYml0IERNQSBjYXBhYmxlIGNvbnRyb2xs
ZXJzLgorCisJPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQorCT4gRnJvbTogVmFzaWx5IEF2
ZXJpbiBbbWFpbHRvOnZ2c0Bzdy5ydV0gCisJPiBTZW50OiBUaHVyc2RheSwgTWF5IDA0LCAyMDA2
IDI6NDkgUE0KKwk+IFRvOiBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZzsgS29sbGksIE5lZWxh
OyBNdWtrZXIsIEF0dWw7IAorCT4gSnUsIFNlb2ttYW5uOyBCYWdhbGtvdGUsIFNyZWVuaXZhczsg
CisJPiBKYW1lcy5Cb3R0b21sZXlAU3RlZWxFeWUuY29tOyBkZXZlbEBvcGVudnoub3JnCisJPiBT
dWJqZWN0OiBtZWdhcmFpZF9tYm94OiBnYXJiYWdlIGluIGZpbGUKKwk+IAorCT4gSGVsbG8gYWxs
LAorCT4gCisJPiBJJ3ZlIGludmVzdGlnYXRlZCBjdXN0b21lcnMgY2xhaW0gb24gdGhlIHVuc3Rh
YmxlIHdvcmsgb2YgCisJPiB0aGVpciBub2RlIGFuZCBmb3VuZCBhCisJPiBzdHJhbmdlIGVmZmVj
dDogcmVhZGluZyBmcm9tIHNvbWUgZmlsZXMgbGVhZHMgdG8gdGhlCisJPiAgImF0dGVtcHQgdG8g
YWNjZXNzIGJleW9uZCBlbmQgb2YgZGV2aWNlIiBtZXNzYWdlcy4KKwk+IAorCT4gSSd2ZSBjaGVj
a2VkIGZpbGVzeXN0ZW0sIG1lbW9yeSBvbiB0aGUgbm9kZSwgbW90aGVyYm9hcmQgQklPUyAKKwk+
IHZlcnNpb24sIGJ1dCBpdAorCT4gZG9lcyBub3QgaGVscCBhbmQgaXNzdWUgc3RpbGwgaGFzIGJl
ZW4gcmVwcm9kdWNlZCBieSBzaW1wbGUgCisJPiBmaWxlIHJlYWRpbmcuCisJPiAKKwk+IFJlcHJv
ZHVjZXIgaXMgc2ltcGxlOgorCT4gCisJPiBlY2hvIDB4ZmZmZmZmZmYgPi9wcm9jL3N5cy9kZXYv
c2NzaS9sb2dnaW5nX2xldmVsIDsKKwk+IGNhdCAvdnovcHJpdmF0ZS8xMDEvcm9vdC9ldGMvbGQu
c28uY2FjaGUgPi90bXAvdHR0ICA7CisJPiBlY2hvIDAgPi9wcm9jL3N5cy9kZXYvc2NzaS9sb2dn
aW5nCisJPiAKKwk+IEl0IGxlYWRzIHRvIHRoZSBmb2xsb3dpbmcgbWVzc2FnZXMgaW4gZG1lc2cK
Kwk+IAorCT4gc2RfaW5pdF9jb21tYW5kOiBkaXNrPXNkYSwgYmxvY2s9ODcxNzY5MjYwLCBjb3Vu
dD0yNgorCT4gc2RhIDogYmxvY2s9ODcxNzY5MjYwCisJPiBzZGEgOiByZWFkaW5nIDI2LzI2IDUx
MiBieXRlIGJsb2Nrcy4KKwk+IHNjc2lfYWRkX3RpbWVyOiBzY21kOiBmNzllZDk4MCwgdGltZTog
NzUwMCwgKGMwMmIxNDIwKQorCT4gc2QgMDoxOjA6MDogc2VuZCAweGY3OWVkOTgwICAgICAgICAg
ICAgICAgICAgc2QgMDoxOjA6MDoKKwk+ICAgICAgICAgY29tbWFuZDogUmVhZCAoMTApOiAyOCAw
MCAzMyBmNiAyNCBhYyAwMCAwMCAxYSAwMAorCT4gYnVmZmVyID0gMHhmN2NmYjU0MCwgYnVmZmxl
biA9IDEzMzEyLCBkb25lID0gMHhjMDM2NmI0MCwgCisJPiBxdWV1ZWNvbW1hbmQgMHhjMDM0NDAx
MAorCT4gbGVhdmluZyBzY3NpX2Rpc3BhdGNoX2NtbmQoKQorCT4gc2NzaV9kZWxldGVfdGltZXI6
IHNjbWQ6IGY3OWVkOTgwLCBydG46IDEKKwk+IHNkIDA6MTowOjA6IGRvbmUgMHhmNzllZDk4MCBT
VUNDRVNTICAgICAgICAwIHNkIDA6MTowOjA6CisJPiAgICAgICAgIGNvbW1hbmQ6IFJlYWQgKDEw
KTogMjggMDAgMzMgZjYgMjQgYWMgMDAgMDAgMWEgMDAKKwk+IHNjc2kgaG9zdCBidXN5IDEgZmFp
bGVkIDAKKwk+IHNkIDA6MTowOjA6IE5vdGlmeWluZyB1cHBlciBkcml2ZXIgb2YgY29tcGxldGlv
biAocmVzdWx0IDApCisJPiBzZF9yd19pbnRyOiBzZGE6IHJlcz0weDAKKwk+IDI2IHNlY3RvcnMg
dG90YWwsIDEzMzEyIGJ5dGVzIGRvbmUuCisJPiB1c2Vfc2cgaXMgNAorCT4gYXR0ZW1wdCB0byBh
Y2Nlc3MgYmV5b25kIGVuZCBvZiBkZXZpY2UKKwk+IHNkYTY6IHJ3PTAsIHdhbnQ9MTA0NDEzNDQ1
OCwgbGltaXQ9OTUxNDAxMzY3CisJPiBCdWZmZXIgSS9PIGVycm9yIG9uIGRldmljZSBzZGE2LCBs
b2dpY2FsIGJsb2NrIDUyMjA2NzIyOAorCT4gYXR0ZW1wdCB0byBhY2Nlc3MgYmV5b25kIGVuZCBv
ZiBkZXZpY2UKKwogUmVsZWFzZSBEYXRlCTogTW9uIEFwciAxMSAxMjoyNzoyMiBFU1QgMjAwNiAt
IFNlb2ttYW5uIEp1IDxzanVAbHNpbC5jb20+CiBDdXJyZW50IFZlcnNpb24gOiAyLjIwLjQuOCAo
c2NzaSBtb2R1bGUpLCAyLjIwLjIuNiAoY21tIG1vZHVsZSkKIE9sZGVyIFZlcnNpb24JOiAyLjIw
LjQuNyAoc2NzaSBtb2R1bGUpLCAyLjIwLjIuNiAoY21tIG1vZHVsZSkKZGlmZiAtTmF1ciBvbGQv
ZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2FfY29tbW9uLmggbmV3L2RyaXZlcnMvc2NzaS9tZWdh
cmFpZC9tZWdhX2NvbW1vbi5oCi0tLSBvbGQvZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2FfY29t
bW9uLmgJMjAwNi0wNS0xOSAwODo1ODo1OS4wMDAwMDAwMDAgLTA0MDAKKysrIG5ldy9kcml2ZXJz
L3Njc2kvbWVnYXJhaWQvbWVnYV9jb21tb24uaAkyMDA2LTA1LTE5IDA5OjUxOjQ4LjAwMDAwMDAw
MCAtMDQwMApAQCAtMzcsNyArMzcsOCBAQAogI2RlZmluZSBMU0lfTUFYX0NIQU5ORUxTCQkxNgog
I2RlZmluZSBMU0lfTUFYX0xPR0lDQUxfRFJJVkVTXzY0TEQJKDY0KzEpCiAKLQorI2RlZmluZSBI
QkFfU0lHTkFUVVJFXzY0QklUCQkweDAyOTkKKyNkZWZpbmUgUENJX0NPTkZfQU1JU0lHNjQJCTB4
YTQKIC8qKgogICogc2NiX3QgLSBzY3NpIGNvbW1hbmQgY29udHJvbCBibG9jawogICogQHBhcmFt
IGNjYgkJOiBjb21tYW5kIGNvbnRyb2wgYmxvY2sgZm9yIGluZGl2aWR1YWwgZHJpdmVyCmRpZmYg
LU5hdXIgb2xkL2RyaXZlcnMvc2NzaS9tZWdhcmFpZC9tZWdhcmFpZF9tYm94LmMgbmV3L2RyaXZl
cnMvc2NzaS9tZWdhcmFpZC9tZWdhcmFpZF9tYm94LmMKLS0tIG9sZC9kcml2ZXJzL3Njc2kvbWVn
YXJhaWQvbWVnYXJhaWRfbWJveC5jCTIwMDYtMDUtMTkgMDg6NTg6NTkuMDAwMDAwMDAwIC0wNDAw
CisrKyBuZXcvZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2FyYWlkX21ib3guYwkyMDA2LTA1LTE5
IDEwOjUyOjExLjAwMDAwMDAwMCAtMDQwMApAQCAtMTAsNyArMTAsNyBAQAogICoJICAgMiBvZiB0
aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KICAqCiAg
KiBGSUxFCQk6IG1lZ2FyYWlkX21ib3guYwotICogVmVyc2lvbgk6IHYyLjIwLjQuOCAoQXByIDEx
IDIwMDYpCisgKiBWZXJzaW9uCTogdjIuMjAuNC45IChNYXkgMTkgMjAwNikKICAqCiAgKiBBdXRo
b3JzOgogICogCUF0dWwgTXVra2VyCQk8QXR1bC5NdWtrZXJAbHNpbC5jb20+CkBAIC03MjAsNyAr
NzIwLDcgQEAKIAlzdHJ1Y3QgcGNpX2RldgkJKnBkZXY7CiAJbXJhaWRfZGV2aWNlX3QJCSpyYWlk
X2RldjsKIAlpbnQJCQlpOwotCisJdW5zaWduZWQgaW50CQltYWdpYzY0OwogCiAJYWRhcHRlci0+
aXRvCT0gTUJPWF9USU1FT1VUOwogCXBkZXYJCT0gYWRhcHRlci0+cGRldjsKQEAgLTg2MywxMiAr
ODYzLDI1IEBACiAKIAkvLyBTZXQgdGhlIERNQSBtYXNrIHRvIDY0LWJpdC4gQWxsIHN1cHBvcnRl
ZCBjb250cm9sbGVycyBhcyBjYXBhYmxlIG9mCiAJLy8gRE1BIGluIHRoaXMgcmFuZ2UKLQlpZiAo
cGNpX3NldF9kbWFfbWFzayhhZGFwdGVyLT5wZGV2LCBETUFfNjRCSVRfTUFTSykgIT0gMCkgewor
CXBjaV9yZWFkX2NvbmZpZ19kd29yZChhZGFwdGVyLT5wZGV2LCBQQ0lfQ09ORl9BTUlTSUc2NCwg
Jm1hZ2ljNjQpOwogCi0JCWNvbl9sb2coQ0xfQU5OLCAoS0VSTl9XQVJOSU5HCi0JCQkibWVnYXJh
aWQ6IGNvdWxkIG5vdCBzZXQgRE1BIG1hc2sgZm9yIDY0LWJpdC5cbiIpKTsKKwlpZiAoKG1hZ2lj
NjQgPT0gSEJBX1NJR05BVFVSRV82NEJJVCkgfHwgCisJCShhZGFwdGVyLT5wZGV2LT52ZW5kb3Ig
PT0gUENJX1ZFTkRPUl9JRF9ERUxMICYmCisJCWFkYXB0ZXItPnBkZXYtPmRldmljZSA9PSBQQ0lf
REVWSUNFX0lEX1BFUkM0X0RJX0VWRVJHTEFERVMpIHx8CisJCShhZGFwdGVyLT5wZGV2LT52ZW5k
b3IgPT0gUENJX1ZFTkRPUl9JRF9MU0lfTE9HSUMgJiYKKwkJYWRhcHRlci0+cGRldi0+ZGV2aWNl
ID09IFBDSV9ERVZJQ0VfSURfVkVSREUpIHx8CisJCShhZGFwdGVyLT5wZGV2LT52ZW5kb3IgPT0g
UENJX1ZFTkRPUl9JRF9MU0lfTE9HSUMgJiYKKwkJYWRhcHRlci0+cGRldi0+ZGV2aWNlID09IFBD
SV9ERVZJQ0VfSURfRE9CU09OKSB8fAorCQkoYWRhcHRlci0+cGRldi0+dmVuZG9yID09IFBDSV9W
RU5ET1JfSURfREVMTCAmJgorCQlhZGFwdGVyLT5wZGV2LT5kZXZpY2UgPT0gUENJX0RFVklDRV9J
RF9QRVJDNEVfRElfS09CVUspIHx8CisJCShhZGFwdGVyLT5wZGV2LT52ZW5kb3IgPT0gUENJX1ZF
TkRPUl9JRF9MU0lfTE9HSUMgJiYKKwkJYWRhcHRlci0+cGRldi0+ZGV2aWNlID09IFBDSV9ERVZJ
Q0VfSURfTElORFNBWSkpIHsKKwkJaWYgKHBjaV9zZXRfZG1hX21hc2soYWRhcHRlci0+cGRldiwg
RE1BXzY0QklUX01BU0spICE9IDApIHsKKwkJCWNvbl9sb2coQ0xfQU5OLCAoS0VSTl9XQVJOSU5H
CisJCQkJIm1lZ2FyYWlkOiBjb3VsZCBub3Qgc2V0IERNQSBtYXNrIGZvciA2NC1iaXQuXG4iKSk7
CiAKLQkJZ290byBvdXRfZnJlZV9zeXNmc19yZXM7CisJCQlnb3RvIG91dF9mcmVlX3N5c2ZzX3Jl
czsKKwkJfQogCX0KIAogCS8vIHNldHVwIHRhc2tsZXQgZm9yIERQQwpkaWZmIC1OYXVyIG9sZC9k
cml2ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRfbWJveC5oIG5ldy9kcml2ZXJzL3Njc2kvbWVn
YXJhaWQvbWVnYXJhaWRfbWJveC5oCi0tLSBvbGQvZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2Fy
YWlkX21ib3guaAkyMDA2LTA1LTE5IDA4OjU4OjU5LjAwMDAwMDAwMCAtMDQwMAorKysgbmV3L2Ry
aXZlcnMvc2NzaS9tZWdhcmFpZC9tZWdhcmFpZF9tYm94LmgJMjAwNi0wNS0xOSAxMDoyMjoxMy4w
MDAwMDAwMDAgLTA0MDAKQEAgLTIxLDggKzIxLDggQEAKICNpbmNsdWRlICJtZWdhcmFpZF9pb2N0
bC5oIgogCiAKLSNkZWZpbmUgTUVHQVJBSURfVkVSU0lPTgkiMi4yMC40LjgiCi0jZGVmaW5lIE1F
R0FSQUlEX0VYVF9WRVJTSU9OCSIoUmVsZWFzZSBEYXRlOiBNb24gQXByIDExIDEyOjI3OjIyIEVT
VCAyMDA2KSIKKyNkZWZpbmUgTUVHQVJBSURfVkVSU0lPTgkiMi4yMC40LjkiCisjZGVmaW5lIE1F
R0FSQUlEX0VYVF9WRVJTSU9OCSIoUmVsZWFzZSBEYXRlOiBGcmkgTWF5IDE5IDA5OjQ1OjIyIEVT
VCAyMDA2KSIKIAogCiAvKgo=

------_=_NextPart_001_01C67B56.30783F51--
