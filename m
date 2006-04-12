Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbWDLNJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWDLNJV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Apr 2006 09:09:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWDLNJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Apr 2006 09:09:21 -0400
Received: from mail0.lsil.com ([147.145.40.20]:10215 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932179AbWDLNJU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Apr 2006 09:09:20 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C65E32.4B3B4CCA"
Subject: [PATCH 1/1] megaraid_{mm,mbox}: fix a bug in reset handler
Date: Wed, 12 Apr 2006 07:09:13 -0600
Message-ID: <890BF3111FB9484E9526987D912B261901BCC2@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] megaraid_{mm,mbox}: fix a bug in reset handler
Thread-Index: AcZeMkrxvxAoyH26RlWW1eoca0kNRg==
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Ju, Seokmann" <Seokmann.Ju@engenio.com>,
       "James Bottomley" <James.Bottomley@SteelEye.com>
Cc: <linux-kernel@vger.kernel.org>, "linux-scsi" <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 12 Apr 2006 13:09:13.0522 (UTC) FILETIME=[4B880920:01C65E32]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C65E32.4B3B4CCA
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

This patch has fix for a bug in the 'megaraid_reset_handler()'.

When abort failed, the driver gets reset handleer called. In the reset
handler, driver calls 'scsi_done()' callback for same SCSI command
packet (struct scsi_cmnd) multiple times if there are multiple SCSI
command packet in the pend_list. More over, if there are entry in the
pend_lsit with IOCTL packet associated, the driver returns it to wrong
free_list so that, in turn, the driver could end up with 'NULL pointer
dereference..' during I/O command building with incorrect resource.

Also, the patch contains several minor/cosmetic changes besides this.

Thank you,

Seokmann

Signed-Off By: Seokmann Ju <seokmann.ju@lsil.com>


---
diff -Naur old/Documentation/scsi/ChangeLog.megaraid
new/Documentation/scsi/ChangeLog.megaraid
--- old/Documentation/scsi/ChangeLog.megaraid	2006-04-10
18:04:04.000000000 -0400
+++ new/Documentation/scsi/ChangeLog.megaraid	2006-04-12
09:35:20.939778336 -0400
@@ -1,3 +1,28 @@
+Release Date	: Mon Apr 11 12:27:22 EST 2006 - Seokmann Ju
<sju@lsil.com>
+Current Version : 2.20.4.8 (scsi module), 2.20.2.6 (cmm module)
+Older Version	: 2.20.4.7 (scsi module), 2.20.2.6 (cmm module)
+
+1.	Fixed a bug in megaraid_reset_handler().
+	Customer reported "Unable to handle kernel NULL pointer
dereference
+	at virtual address 00000000" when system goes to reset condition
+	for some reason. It happened randomly.
+	Root Cause: in the megaraid_reset_handler(), there is
possibility not=20
+	returning pending packets in the pend_list if there are multiple
+	pending packets.=20
+	Fix: Made the change in the driver so that it will return all
packets=20
+	in the pend_list.
+
+2.	Added change request.
+	As found in the following URL, rmb() only didn't help the
+	problem. I had to increase the loop counter to 0xFFFFFF. (6 F's)
+	http://marc.theaimsgroup.com/?l=3Dlinux-scsi&m=3D110971060502497&w=3D2
+=20
+	I attached a patch for your reference, too.
+	Could you check and get this fix in your driver?
+=20
+	Best Regards,
+	Jun'ichi Nomura
+
 Release Date	: Fri Nov 11 12:27:22 EST 2005 - Seokmann Ju
<sju@lsil.com>
 Current Version : 2.20.4.7 (scsi module), 2.20.2.6 (cmm module)
 Older Version	: 2.20.4.6 (scsi module), 2.20.2.6 (cmm module)
diff -Naur old/drivers/scsi/megaraid/megaraid_mbox.c
new/drivers/scsi/megaraid/megaraid_mbox.c
--- old/drivers/scsi/megaraid/megaraid_mbox.c	2006-04-10
17:14:22.000000000 -0400
+++ new/drivers/scsi/megaraid/megaraid_mbox.c	2006-04-11
17:32:12.000000000 -0400
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_mbox.c
- * Version	: v2.20.4.7 (Nov 14 2005)
+ * Version	: v2.20.4.8 (Apr 11 2006)
  *
  * Authors:
  * 	Atul Mukker		<Atul.Mukker@lsil.com>
@@ -2655,32 +2655,48 @@
 	// Also, reset all the commands currently owned by the driver
 	spin_lock_irqsave(PENDING_LIST_LOCK(adapter), flags);
 	list_for_each_entry_safe(scb, tmp, &adapter->pend_list, list) {
-
 		list_del_init(&scb->list);	// from pending list
=20
-		con_log(CL_ANN, (KERN_WARNING
-			"megaraid: %ld:%d[%d:%d], reset from pending
list\n",
-				scp->serial_number, scb->sno,
-				scb->dev_channel, scb->dev_target));
+		if (scb->sno >=3D MBOX_MAX_SCSI_CMDS) {
+			con_log(CL_ANN, (KERN_WARNING=20
+			"megaraid: IOCTL packet with %d[%d:%d] being
reset\n",
+			scb->sno, scb->dev_channel, scb->dev_target));
=20
-		scp->result =3D (DID_RESET << 16);
-		scp->scsi_done(scp);
+			scb->status =3D -EFAULT;
=20
-		megaraid_dealloc_scb(adapter, scb);
+			megaraid_mbox_mm_done(adapter, scb);
+		} else {
+			if (scb->scp =3D=3D scp) {	// Found command
+				con_log(CL_ANN, (KERN_WARNING
+					"megaraid: %ld:%d[%d:%d], reset
from pending list\n",
+					scp->serial_number, scb->sno,
+					scb->dev_channel,
scb->dev_target));
+			} else {
+				con_log(CL_ANN, (KERN_WARNING=20
+				"megaraid: IO packet with %d[%d:%d]
being reset\n",
+				scb->sno, scb->dev_channel,
scb->dev_target));
+			}
+
+			scb->scp->result =3D (DID_RESET << 16);
+			scb->scp->scsi_done(scb->scp);
+
+			megaraid_dealloc_scb(adapter, scb);
+		}
 	}
 	spin_unlock_irqrestore(PENDING_LIST_LOCK(adapter), flags);
=20
 	if (adapter->outstanding_cmds) {
 		con_log(CL_ANN, (KERN_NOTICE
 			"megaraid: %d outstanding commands. Max wait %d
sec\n",
-			adapter->outstanding_cmds, MBOX_RESET_WAIT));
+			adapter->outstanding_cmds,=20
+			(MBOX_RESET_WAIT + MBOX_RESET_EXT_WAIT)));
 	}
=20
 	recovery_window =3D MBOX_RESET_WAIT + MBOX_RESET_EXT_WAIT;
=20
 	recovering =3D adapter->outstanding_cmds;
=20
-	for (i =3D 0; i < recovery_window && adapter->outstanding_cmds;
i++) {
+	for (i =3D 0; i < recovery_window; i++) {
=20
 		megaraid_ack_sequence(adapter);
=20
@@ -2689,12 +2705,11 @@
 			con_log(CL_ANN, (
 			"megaraid mbox: Wait for %d commands to
complete:%d\n",
 				adapter->outstanding_cmds,
-				MBOX_RESET_WAIT - i));
+				(MBOX_RESET_WAIT + MBOX_RESET_EXT_WAIT)
- i));
 		}
=20
 		// bailout if no recovery happended in reset time
-		if ((i =3D=3D MBOX_RESET_WAIT) &&
-			(recovering =3D=3D adapter->outstanding_cmds)) {
+		if (adapter->outstanding_cmds =3D=3D 0) {
 			break;
 		}
=20
@@ -2918,12 +2933,12 @@
 	wmb();
 	WRINDOOR(raid_dev, raid_dev->mbox_dma | 0x1);
=20
-	for (i =3D 0; i < 0xFFFFF; i++) {
+	for (i =3D 0; i < 0xFFFFFF; i++) {
 		if (mbox->numstatus !=3D 0xFF) break;
 		rmb();
 	}
=20
-	if (i =3D=3D 0xFFFFF) {
+	if (i =3D=3D 0xFFFFFF) {
 		// We may need to re-calibrate the counter
 		con_log(CL_ANN, (KERN_CRIT
 			"megaraid: fast sync command timed out\n"));
@@ -3475,7 +3490,7 @@
 	adp.drvr_data		=3D (unsigned long)adapter;
 	adp.pdev		=3D adapter->pdev;
 	adp.issue_uioc		=3D megaraid_mbox_mm_handler;
-	adp.timeout		=3D 300;
+	adp.timeout		=3D MBOX_RESET_WAIT + MBOX_RESET_EXT_WAIT;
 	adp.max_kioc		=3D MBOX_MAX_USER_CMDS;
=20
 	if ((rval =3D mraid_mm_register_adp(&adp)) !=3D 0) {
diff -Naur old/drivers/scsi/megaraid/megaraid_mbox.h
new/drivers/scsi/megaraid/megaraid_mbox.h
--- old/drivers/scsi/megaraid/megaraid_mbox.h	2006-04-10
17:14:22.000000000 -0400
+++ new/drivers/scsi/megaraid/megaraid_mbox.h	2006-04-11
13:45:21.000000000 -0400
@@ -21,8 +21,8 @@
 #include "megaraid_ioctl.h"
=20
=20
-#define MEGARAID_VERSION	"2.20.4.7"
-#define MEGARAID_EXT_VERSION	"(Release Date: Mon Nov 14 12:27:22 EST
2005)"
+#define MEGARAID_VERSION	"2.20.4.8"
+#define MEGARAID_EXT_VERSION	"(Release Date: Mon Apr 11 12:27:22 EST
2006)"
=20
=20
 /*
---

------_=_NextPart_001_01C65E32.4B3B4CCA
Content-Type: application/octet-stream;
	name="megaraid_mm_mbox.patch"
Content-Transfer-Encoding: base64
Content-Description: megaraid_mm_mbox.patch
Content-Disposition: attachment;
	filename="megaraid_mm_mbox.patch"

ZGlmZiAtTmF1ciBvbGQvRG9jdW1lbnRhdGlvbi9zY3NpL0NoYW5nZUxvZy5tZWdhcmFpZCBuZXcv
RG9jdW1lbnRhdGlvbi9zY3NpL0NoYW5nZUxvZy5tZWdhcmFpZAotLS0gb2xkL0RvY3VtZW50YXRp
b24vc2NzaS9DaGFuZ2VMb2cubWVnYXJhaWQJMjAwNi0wNC0xMCAxODowNDowNC4wMDAwMDAwMDAg
LTA0MDAKKysrIG5ldy9Eb2N1bWVudGF0aW9uL3Njc2kvQ2hhbmdlTG9nLm1lZ2FyYWlkCTIwMDYt
MDQtMTIgMDk6MzU6MjAuOTM5Nzc4MzM2IC0wNDAwCkBAIC0xLDMgKzEsMjggQEAKK1JlbGVhc2Ug
RGF0ZQk6IE1vbiBBcHIgMTEgMTI6Mjc6MjIgRVNUIDIwMDYgLSBTZW9rbWFubiBKdSA8c2p1QGxz
aWwuY29tPgorQ3VycmVudCBWZXJzaW9uIDogMi4yMC40LjggKHNjc2kgbW9kdWxlKSwgMi4yMC4y
LjYgKGNtbSBtb2R1bGUpCitPbGRlciBWZXJzaW9uCTogMi4yMC40LjcgKHNjc2kgbW9kdWxlKSwg
Mi4yMC4yLjYgKGNtbSBtb2R1bGUpCisKKzEuCUZpeGVkIGEgYnVnIGluIG1lZ2FyYWlkX3Jlc2V0
X2hhbmRsZXIoKS4KKwlDdXN0b21lciByZXBvcnRlZCAiVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwg
TlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlCisJYXQgdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwIiB3
aGVuIHN5c3RlbSBnb2VzIHRvIHJlc2V0IGNvbmRpdGlvbgorCWZvciBzb21lIHJlYXNvbi4gSXQg
aGFwcGVuZWQgcmFuZG9tbHkuCisJUm9vdCBDYXVzZTogaW4gdGhlIG1lZ2FyYWlkX3Jlc2V0X2hh
bmRsZXIoKSwgdGhlcmUgaXMgcG9zc2liaWxpdHkgbm90IAorCXJldHVybmluZyBwZW5kaW5nIHBh
Y2tldHMgaW4gdGhlIHBlbmRfbGlzdCBpZiB0aGVyZSBhcmUgbXVsdGlwbGUKKwlwZW5kaW5nIHBh
Y2tldHMuIAorCUZpeDogTWFkZSB0aGUgY2hhbmdlIGluIHRoZSBkcml2ZXIgc28gdGhhdCBpdCB3
aWxsIHJldHVybiBhbGwgcGFja2V0cyAKKwlpbiB0aGUgcGVuZF9saXN0LgorCisyLglBZGRlZCBj
aGFuZ2UgcmVxdWVzdC4KKwlBcyBmb3VuZCBpbiB0aGUgZm9sbG93aW5nIFVSTCwgcm1iKCkgb25s
eSBkaWRuJ3QgaGVscCB0aGUKKwlwcm9ibGVtLiBJIGhhZCB0byBpbmNyZWFzZSB0aGUgbG9vcCBj
b3VudGVyIHRvIDB4RkZGRkZGLiAoNiBGJ3MpCisJaHR0cDovL21hcmMudGhlYWltc2dyb3VwLmNv
bS8/bD1saW51eC1zY3NpJm09MTEwOTcxMDYwNTAyNDk3Jnc9MgorIAorCUkgYXR0YWNoZWQgYSBw
YXRjaCBmb3IgeW91ciByZWZlcmVuY2UsIHRvby4KKwlDb3VsZCB5b3UgY2hlY2sgYW5kIGdldCB0
aGlzIGZpeCBpbiB5b3VyIGRyaXZlcj8KKyAKKwlCZXN0IFJlZ2FyZHMsCisJSnVuJ2ljaGkgTm9t
dXJhCisKIFJlbGVhc2UgRGF0ZQk6IEZyaSBOb3YgMTEgMTI6Mjc6MjIgRVNUIDIwMDUgLSBTZW9r
bWFubiBKdSA8c2p1QGxzaWwuY29tPgogQ3VycmVudCBWZXJzaW9uIDogMi4yMC40LjcgKHNjc2kg
bW9kdWxlKSwgMi4yMC4yLjYgKGNtbSBtb2R1bGUpCiBPbGRlciBWZXJzaW9uCTogMi4yMC40LjYg
KHNjc2kgbW9kdWxlKSwgMi4yMC4yLjYgKGNtbSBtb2R1bGUpCmRpZmYgLU5hdXIgb2xkL2RyaXZl
cnMvc2NzaS9tZWdhcmFpZC9tZWdhcmFpZF9tYm94LmMgbmV3L2RyaXZlcnMvc2NzaS9tZWdhcmFp
ZC9tZWdhcmFpZF9tYm94LmMKLS0tIG9sZC9kcml2ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRf
bWJveC5jCTIwMDYtMDQtMTAgMTc6MTQ6MjIuMDAwMDAwMDAwIC0wNDAwCisrKyBuZXcvZHJpdmVy
cy9zY3NpL21lZ2FyYWlkL21lZ2FyYWlkX21ib3guYwkyMDA2LTA0LTExIDE3OjMyOjEyLjAwMDAw
MDAwMCAtMDQwMApAQCAtMTAsNyArMTAsNyBAQAogICoJICAgMiBvZiB0aGUgTGljZW5zZSwgb3Ig
KGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4KICAqCiAgKiBGSUxFCQk6IG1lZ2Fy
YWlkX21ib3guYwotICogVmVyc2lvbgk6IHYyLjIwLjQuNyAoTm92IDE0IDIwMDUpCisgKiBWZXJz
aW9uCTogdjIuMjAuNC44IChBcHIgMTEgMjAwNikKICAqCiAgKiBBdXRob3JzOgogICogCUF0dWwg
TXVra2VyCQk8QXR1bC5NdWtrZXJAbHNpbC5jb20+CkBAIC0yNjU1LDMyICsyNjU1LDQ4IEBACiAJ
Ly8gQWxzbywgcmVzZXQgYWxsIHRoZSBjb21tYW5kcyBjdXJyZW50bHkgb3duZWQgYnkgdGhlIGRy
aXZlcgogCXNwaW5fbG9ja19pcnFzYXZlKFBFTkRJTkdfTElTVF9MT0NLKGFkYXB0ZXIpLCBmbGFn
cyk7CiAJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKHNjYiwgdG1wLCAmYWRhcHRlci0+cGVuZF9s
aXN0LCBsaXN0KSB7Ci0KIAkJbGlzdF9kZWxfaW5pdCgmc2NiLT5saXN0KTsJLy8gZnJvbSBwZW5k
aW5nIGxpc3QKIAotCQljb25fbG9nKENMX0FOTiwgKEtFUk5fV0FSTklORwotCQkJIm1lZ2FyYWlk
OiAlbGQ6JWRbJWQ6JWRdLCByZXNldCBmcm9tIHBlbmRpbmcgbGlzdFxuIiwKLQkJCQlzY3AtPnNl
cmlhbF9udW1iZXIsIHNjYi0+c25vLAotCQkJCXNjYi0+ZGV2X2NoYW5uZWwsIHNjYi0+ZGV2X3Rh
cmdldCkpOworCQlpZiAoc2NiLT5zbm8gPj0gTUJPWF9NQVhfU0NTSV9DTURTKSB7CisJCQljb25f
bG9nKENMX0FOTiwgKEtFUk5fV0FSTklORyAKKwkJCSJtZWdhcmFpZDogSU9DVEwgcGFja2V0IHdp
dGggJWRbJWQ6JWRdIGJlaW5nIHJlc2V0XG4iLAorCQkJc2NiLT5zbm8sIHNjYi0+ZGV2X2NoYW5u
ZWwsIHNjYi0+ZGV2X3RhcmdldCkpOwogCi0JCXNjcC0+cmVzdWx0ID0gKERJRF9SRVNFVCA8PCAx
Nik7Ci0JCXNjcC0+c2NzaV9kb25lKHNjcCk7CisJCQlzY2ItPnN0YXR1cyA9IC1FRkFVTFQ7CiAK
LQkJbWVnYXJhaWRfZGVhbGxvY19zY2IoYWRhcHRlciwgc2NiKTsKKwkJCW1lZ2FyYWlkX21ib3hf
bW1fZG9uZShhZGFwdGVyLCBzY2IpOworCQl9IGVsc2UgeworCQkJaWYgKHNjYi0+c2NwID09IHNj
cCkgewkvLyBGb3VuZCBjb21tYW5kCisJCQkJY29uX2xvZyhDTF9BTk4sIChLRVJOX1dBUk5JTkcK
KwkJCQkJIm1lZ2FyYWlkOiAlbGQ6JWRbJWQ6JWRdLCByZXNldCBmcm9tIHBlbmRpbmcgbGlzdFxu
IiwKKwkJCQkJc2NwLT5zZXJpYWxfbnVtYmVyLCBzY2ItPnNubywKKwkJCQkJc2NiLT5kZXZfY2hh
bm5lbCwgc2NiLT5kZXZfdGFyZ2V0KSk7CisJCQl9IGVsc2UgeworCQkJCWNvbl9sb2coQ0xfQU5O
LCAoS0VSTl9XQVJOSU5HIAorCQkJCSJtZWdhcmFpZDogSU8gcGFja2V0IHdpdGggJWRbJWQ6JWRd
IGJlaW5nIHJlc2V0XG4iLAorCQkJCXNjYi0+c25vLCBzY2ItPmRldl9jaGFubmVsLCBzY2ItPmRl
dl90YXJnZXQpKTsKKwkJCX0KKworCQkJc2NiLT5zY3AtPnJlc3VsdCA9IChESURfUkVTRVQgPDwg
MTYpOworCQkJc2NiLT5zY3AtPnNjc2lfZG9uZShzY2ItPnNjcCk7CisKKwkJCW1lZ2FyYWlkX2Rl
YWxsb2Nfc2NiKGFkYXB0ZXIsIHNjYik7CisJCX0KIAl9CiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZShQRU5ESU5HX0xJU1RfTE9DSyhhZGFwdGVyKSwgZmxhZ3MpOwogCiAJaWYgKGFkYXB0ZXItPm91
dHN0YW5kaW5nX2NtZHMpIHsKIAkJY29uX2xvZyhDTF9BTk4sIChLRVJOX05PVElDRQogCQkJIm1l
Z2FyYWlkOiAlZCBvdXRzdGFuZGluZyBjb21tYW5kcy4gTWF4IHdhaXQgJWQgc2VjXG4iLAotCQkJ
YWRhcHRlci0+b3V0c3RhbmRpbmdfY21kcywgTUJPWF9SRVNFVF9XQUlUKSk7CisJCQlhZGFwdGVy
LT5vdXRzdGFuZGluZ19jbWRzLCAKKwkJCShNQk9YX1JFU0VUX1dBSVQgKyBNQk9YX1JFU0VUX0VY
VF9XQUlUKSkpOwogCX0KIAogCXJlY292ZXJ5X3dpbmRvdyA9IE1CT1hfUkVTRVRfV0FJVCArIE1C
T1hfUkVTRVRfRVhUX1dBSVQ7CiAKIAlyZWNvdmVyaW5nID0gYWRhcHRlci0+b3V0c3RhbmRpbmdf
Y21kczsKIAotCWZvciAoaSA9IDA7IGkgPCByZWNvdmVyeV93aW5kb3cgJiYgYWRhcHRlci0+b3V0
c3RhbmRpbmdfY21kczsgaSsrKSB7CisJZm9yIChpID0gMDsgaSA8IHJlY292ZXJ5X3dpbmRvdzsg
aSsrKSB7CiAKIAkJbWVnYXJhaWRfYWNrX3NlcXVlbmNlKGFkYXB0ZXIpOwogCkBAIC0yNjg5LDEy
ICsyNzA1LDExIEBACiAJCQljb25fbG9nKENMX0FOTiwgKAogCQkJIm1lZ2FyYWlkIG1ib3g6IFdh
aXQgZm9yICVkIGNvbW1hbmRzIHRvIGNvbXBsZXRlOiVkXG4iLAogCQkJCWFkYXB0ZXItPm91dHN0
YW5kaW5nX2NtZHMsCi0JCQkJTUJPWF9SRVNFVF9XQUlUIC0gaSkpOworCQkJCShNQk9YX1JFU0VU
X1dBSVQgKyBNQk9YX1JFU0VUX0VYVF9XQUlUKSAtIGkpKTsKIAkJfQogCiAJCS8vIGJhaWxvdXQg
aWYgbm8gcmVjb3ZlcnkgaGFwcGVuZGVkIGluIHJlc2V0IHRpbWUKLQkJaWYgKChpID09IE1CT1hf
UkVTRVRfV0FJVCkgJiYKLQkJCShyZWNvdmVyaW5nID09IGFkYXB0ZXItPm91dHN0YW5kaW5nX2Nt
ZHMpKSB7CisJCWlmIChhZGFwdGVyLT5vdXRzdGFuZGluZ19jbWRzID09IDApIHsKIAkJCWJyZWFr
OwogCQl9CiAKQEAgLTI5MTgsMTIgKzI5MzMsMTIgQEAKIAl3bWIoKTsKIAlXUklORE9PUihyYWlk
X2RldiwgcmFpZF9kZXYtPm1ib3hfZG1hIHwgMHgxKTsKIAotCWZvciAoaSA9IDA7IGkgPCAweEZG
RkZGOyBpKyspIHsKKwlmb3IgKGkgPSAwOyBpIDwgMHhGRkZGRkY7IGkrKykgewogCQlpZiAobWJv
eC0+bnVtc3RhdHVzICE9IDB4RkYpIGJyZWFrOwogCQlybWIoKTsKIAl9CiAKLQlpZiAoaSA9PSAw
eEZGRkZGKSB7CisJaWYgKGkgPT0gMHhGRkZGRkYpIHsKIAkJLy8gV2UgbWF5IG5lZWQgdG8gcmUt
Y2FsaWJyYXRlIHRoZSBjb3VudGVyCiAJCWNvbl9sb2coQ0xfQU5OLCAoS0VSTl9DUklUCiAJCQki
bWVnYXJhaWQ6IGZhc3Qgc3luYyBjb21tYW5kIHRpbWVkIG91dFxuIikpOwpAQCAtMzQ3NSw3ICsz
NDkwLDcgQEAKIAlhZHAuZHJ2cl9kYXRhCQk9ICh1bnNpZ25lZCBsb25nKWFkYXB0ZXI7CiAJYWRw
LnBkZXYJCT0gYWRhcHRlci0+cGRldjsKIAlhZHAuaXNzdWVfdWlvYwkJPSBtZWdhcmFpZF9tYm94
X21tX2hhbmRsZXI7Ci0JYWRwLnRpbWVvdXQJCT0gMzAwOworCWFkcC50aW1lb3V0CQk9IE1CT1hf
UkVTRVRfV0FJVCArIE1CT1hfUkVTRVRfRVhUX1dBSVQ7CiAJYWRwLm1heF9raW9jCQk9IE1CT1hf
TUFYX1VTRVJfQ01EUzsKIAogCWlmICgocnZhbCA9IG1yYWlkX21tX3JlZ2lzdGVyX2FkcCgmYWRw
KSkgIT0gMCkgewpkaWZmIC1OYXVyIG9sZC9kcml2ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRf
bWJveC5oIG5ldy9kcml2ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRfbWJveC5oCi0tLSBvbGQv
ZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2FyYWlkX21ib3guaAkyMDA2LTA0LTEwIDE3OjE0OjIy
LjAwMDAwMDAwMCAtMDQwMAorKysgbmV3L2RyaXZlcnMvc2NzaS9tZWdhcmFpZC9tZWdhcmFpZF9t
Ym94LmgJMjAwNi0wNC0xMSAxMzo0NToyMS4wMDAwMDAwMDAgLTA0MDAKQEAgLTIxLDggKzIxLDgg
QEAKICNpbmNsdWRlICJtZWdhcmFpZF9pb2N0bC5oIgogCiAKLSNkZWZpbmUgTUVHQVJBSURfVkVS
U0lPTgkiMi4yMC40LjciCi0jZGVmaW5lIE1FR0FSQUlEX0VYVF9WRVJTSU9OCSIoUmVsZWFzZSBE
YXRlOiBNb24gTm92IDE0IDEyOjI3OjIyIEVTVCAyMDA1KSIKKyNkZWZpbmUgTUVHQVJBSURfVkVS
U0lPTgkiMi4yMC40LjgiCisjZGVmaW5lIE1FR0FSQUlEX0VYVF9WRVJTSU9OCSIoUmVsZWFzZSBE
YXRlOiBNb24gQXByIDExIDEyOjI3OjIyIEVTVCAyMDA2KSIKIAogCiAvKgo=

------_=_NextPart_001_01C65E32.4B3B4CCA--
