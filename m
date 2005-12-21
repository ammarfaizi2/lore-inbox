Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932496AbVLUTyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbVLUTyf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 14:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932499AbVLUTyf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 14:54:35 -0500
Received: from mail0.lsil.com ([147.145.40.20]:40163 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932496AbVLUTyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 14:54:33 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C60668.564A3D0D"
Subject: [PATCH 1/1] megaraid_sas: cleanup up queuecommand path
Date: Wed, 21 Dec 2005 12:54:21 -0700
Message-ID: <0631C836DBF79F42B5A60C8C8D4E8229136529@NAMAIL2.ad.lsil.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] megaraid_sas: cleanup up queuecommand path
Thread-Index: AcYB34f2WcZ68GGdSLGqKup2RcukTgCZmqKQADA/icAAJqbJYAAxBkOA
From: "Patro, Sumant" <Sumant.Patro@lsil.com>
To: "Bagalkote, Sreenivas" <Sreenivas.Bagalkote@engenio.com>, <hch@lst.de>,
       <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
       <James.Bottomley@SteelEye.com>
Cc: "Kolli, Neela" <Neela.Kolli@engenio.com>,
       "Doelfel, Hardy" <Hardy.Doelfel@engenio.com>,
       "Yang, Bo" <Bo.Yang@engenio.com>
X-OriginalArrivalTime: 21 Dec 2005 19:54:22.0155 (UTC) FILETIME=[565711B0:01C60668]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C60668.564A3D0D
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

Hello All,

This patch (originally submitted by Christoph Hellwig) removes code
duplication in megasas_build_cmd.
It also defines MEGASAS_IOC_FIRMWARE32 to allow 64 bit compiled
applications to work. Patch is made against the latest git snapshot of
scsi-misc-2.6 tree.

Thanks,
Sumant Patro
 =09


Signed-off-by: Sumant Patro <Sumant.Patro@lsil.com>

diff -Naur linux2.6.orig/Documentation/scsi/ChangeLog.megaraid_sas
linux2.6/Documentation/scsi/ChangeLog.megaraid_sas
--- linux2.6.orig/Documentation/scsi/ChangeLog.megaraid_sas
1969-12-31 16:00:00.000000000 -0800
+++ linux2.6/Documentation/scsi/ChangeLog.megaraid_sas	2005-12-19
14:37:33.000000000 -0800
@@ -0,0 +1,15 @@
+1 Release Date    : Mon Dec 19 14:36:26 PST 2005 - Sumant Patro
<Sumant.Patro@lsil.com>
+2 Current Version : 00.00.02.00-rc4=20
+3 Older Version   : 00.00.02.01=20
+
+i.	Code reorganized to remove code duplication in
megasas_build_cmd.=20
+
+	"There's a lot of duplicate code megasas_build_cmd.  Move that
out of the different codepathes and merge the reminder of
megasas_build_cmd into megasas_queue_command"
+
+		- Christoph Hellwig <hch@lst.de>
+
+ii.	Defined MEGASAS_IOC_FIRMWARE32 for code paths that handles 32
bit applications in 64 bit systems.
+
+	"MEGASAS_IOC_FIRMWARE can't be redefined if CONFIG_COMPAT is
set, we need to define a MEGASAS_IOC_FIRMWARE32 define so native
binaries continue to work"
+
+		- Christoph Hellwig <hch@lst.de>
diff -Naur linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.c
linux2.6/drivers/scsi/megaraid/megaraid_sas.c
--- linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.c	2005-12-15
14:08:21.000000000 -0800
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.c	2005-12-19
14:36:16.000000000 -0800
@@ -10,7 +10,7 @@
  *	   2 of the License, or (at your option) any later version.
  *
  * FILE		: megaraid_sas.c
- * Version	: v00.00.02.00-rc4
+ * Version	: v00.00.02.01
  *
  * Authors:
  * 	Sreenivas Bagalkote	<Sreenivas.Bagalkote@lsil.com>
@@ -557,112 +557,29 @@
 }
=20
 /**
- * megasas_build_cmd -	Prepares a command packet
- * @instance:		Adapter soft state
- * @scp:		SCSI command
- * @frame_count:	[OUT] Number of frames used to prepare this
command
+ * megasas_is_ldio -		Checks if the cmd is for logical drive
+ * @scmd:			SCSI command
+ *=09
+ * Called by megasas_queue_command to find out if the command to be
queued
+ * is a logical drive command=09
  */
-static inline struct megasas_cmd *megasas_build_cmd(struct
megasas_instance
-						    *instance,
-						    struct scsi_cmnd
*scp,
-						    int *frame_count)
+static inline int megasas_is_ldio(struct scsi_cmnd *cmd)
 {
-	u32 logical_cmd;
-	struct megasas_cmd *cmd;
-
-	/*
-	 * Find out if this is logical or physical drive command.
-	 */
-	logical_cmd =3D MEGASAS_IS_LOGICAL(scp);
-
-	/*
-	 * Logical drive command
-	 */
-	if (logical_cmd) {
-
-		if (scp->device->id >=3D MEGASAS_MAX_LD) {
-			scp->result =3D DID_BAD_TARGET << 16;
-			return NULL;
-		}
-
-		switch (scp->cmnd[0]) {
-
-		case READ_10:
-		case WRITE_10:
-		case READ_12:
-		case WRITE_12:
-		case READ_6:
-		case WRITE_6:
-		case READ_16:
-		case WRITE_16:
-			/*
-			 * Fail for LUN > 0
-			 */
-			if (scp->device->lun) {
-				scp->result =3D DID_BAD_TARGET << 16;
-				return NULL;
-			}
-
-			cmd =3D megasas_get_cmd(instance);
-
-			if (!cmd) {
-				scp->result =3D DID_IMM_RETRY << 16;
-				return NULL;
-			}
-
-			*frame_count =3D megasas_build_ldio(instance, scp,
cmd);
-
-			if (!(*frame_count)) {
-				megasas_return_cmd(instance, cmd);
-				return NULL;
-			}
-
-			return cmd;
-
-		default:
-			/*
-			 * Fail for LUN > 0
-			 */
-			if (scp->device->lun) {
-				scp->result =3D DID_BAD_TARGET << 16;
-				return NULL;
-			}
-
-			cmd =3D megasas_get_cmd(instance);
-
-			if (!cmd) {
-				scp->result =3D DID_IMM_RETRY << 16;
-				return NULL;
-			}
-
-			*frame_count =3D megasas_build_dcdb(instance, scp,
cmd);
-
-			if (!(*frame_count)) {
-				megasas_return_cmd(instance, cmd);
-				return NULL;
-			}
-
-			return cmd;
-		}
-	} else {
-		cmd =3D megasas_get_cmd(instance);
-
-		if (!cmd) {
-			scp->result =3D DID_IMM_RETRY << 16;
-			return NULL;
-		}
-
-		*frame_count =3D megasas_build_dcdb(instance, scp, cmd);
-
-		if (!(*frame_count)) {
-			megasas_return_cmd(instance, cmd);
-			return NULL;
-		}
-
-		return cmd;
+	if (!MEGASAS_IS_LOGICAL(cmd))
+		return 0;
+	switch (cmd->cmnd[0]) {
+	case READ_10:
+	case WRITE_10:
+	case READ_12:
+	case WRITE_12:
+	case READ_6:
+	case WRITE_6:
+	case READ_16:
+	case WRITE_16:
+		return 1;
+	default:
+		return 0;
 	}
-
-	return NULL;
 }
=20
 /**
@@ -683,13 +600,27 @@
 	scmd->scsi_done =3D done;
 	scmd->result =3D 0;
=20
-	cmd =3D megasas_build_cmd(instance, scmd, &frame_count);
-
-	if (!cmd) {
-		done(scmd);
-		return 0;
+	if (MEGASAS_IS_LOGICAL(scmd) &&
+	    (scmd->device->id >=3D MEGASAS_MAX_LD || scmd->device->lun)) {
+		scmd->result =3D DID_BAD_TARGET << 16;
+		goto out_done;
 	}
=20
+	cmd =3D megasas_get_cmd(instance);
+	if (!cmd)
+		return SCSI_MLQUEUE_HOST_BUSY;
+
+	/*
+	 * Logical drive command
+	 */
+	if (megasas_is_ldio(scmd))
+		frame_count =3D megasas_build_ldio(instance, scmd, cmd);
+	else
+		frame_count =3D megasas_build_dcdb(instance, scmd, cmd);
+
+	if (!frame_count)
+		goto out_return_cmd;
+
 	cmd->scmd =3D scmd;
 	scmd->SCp.ptr =3D (char *)cmd;
 	scmd->SCp.sent_command =3D jiffies;
@@ -705,6 +636,12 @@
 	       &instance->reg_set->inbound_queue_port);
=20
 	return 0;
+
+ out_return_cmd:
+	megasas_return_cmd(instance, cmd);
+ out_done:
+	done(scmd);
+	return 0;
 }
=20
 /**
@@ -2680,9 +2617,8 @@
 			  unsigned long arg)
 {
 	switch (cmd) {
-	case MEGASAS_IOC_FIRMWARE:{
-			return megasas_mgmt_compat_ioctl_fw(file, arg);
-		}
+	case MEGASAS_IOC_FIRMWARE32:
+		return megasas_mgmt_compat_ioctl_fw(file, arg);
 	case MEGASAS_IOC_GET_AEN:
 		return megasas_mgmt_ioctl_aen(file, arg);
 	}
diff -Naur linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.h
linux2.6/drivers/scsi/megaraid/megaraid_sas.h
--- linux2.6.orig/drivers/scsi/megaraid/megaraid_sas.h	2005-12-15
14:08:21.000000000 -0800
+++ linux2.6/drivers/scsi/megaraid/megaraid_sas.h	2005-12-19
14:29:32.000000000 -0800
@@ -18,10 +18,9 @@
 /**
  * MegaRAID SAS Driver meta data
  */
-#define MEGASAS_VERSION
"00.00.02.00-rc4"
-#define MEGASAS_RELDATE				"Sep 16, 2005"
-#define MEGASAS_EXT_VERSION			"Fri Sep 16 12:37:08 EDT
2005"
-
+#define MEGASAS_VERSION				"00.00.02.01"
+#define MEGASAS_RELDATE				"Dec 19, 2005"
+#define MEGASAS_EXT_VERSION			"Mon Dec 19 14:36:26 PST
2005"
 /*
  * =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  * MegaRAID SAS MFI firmware definitions @@ -1125,11 +1124,10 @@
 	struct compat_iovec sgl[MAX_IOCTL_SGE];  } __attribute__
((packed));
=20
-#define MEGASAS_IOC_FIRMWARE	_IOWR('M', 1, struct
compat_megasas_iocpacket)
-#else
-#define MEGASAS_IOC_FIRMWARE	_IOWR('M', 1, struct megasas_iocpacket)
 #endif
=20
+#define MEGASAS_IOC_FIRMWARE	_IOWR('M', 1, struct megasas_iocpacket)
+#define MEGASAS_IOC_FIRMWARE32	_IOWR('M', 1, struct
compat_megasas_iocpacket)
 #define MEGASAS_IOC_GET_AEN	_IOW('M', 3, struct megasas_aen)
=20
 struct megasas_mgmt_info {

------_=_NextPart_001_01C60668.564A3D0D
Content-Type: application/octet-stream;
	name="patchmega.patch"
Content-Transfer-Encoding: base64
Content-Description: patchmega.patch
Content-Disposition: attachment;
	filename="patchmega.patch"

ZGlmZiAtTmF1ciBsaW51eDIuNi5vcmlnL0RvY3VtZW50YXRpb24vc2NzaS9DaGFuZ2VMb2cubWVn
YXJhaWRfc2FzIGxpbnV4Mi42L0RvY3VtZW50YXRpb24vc2NzaS9DaGFuZ2VMb2cubWVnYXJhaWRf
c2FzCi0tLSBsaW51eDIuNi5vcmlnL0RvY3VtZW50YXRpb24vc2NzaS9DaGFuZ2VMb2cubWVnYXJh
aWRfc2FzCTE5NjktMTItMzEgMTY6MDA6MDAuMDAwMDAwMDAwIC0wODAwCisrKyBsaW51eDIuNi9E
b2N1bWVudGF0aW9uL3Njc2kvQ2hhbmdlTG9nLm1lZ2FyYWlkX3NhcwkyMDA1LTEyLTE5IDE0OjM3
OjMzLjAwMDAwMDAwMCAtMDgwMApAQCAtMCwwICsxLDE1IEBACisxIFJlbGVhc2UgRGF0ZSAgICA6
IE1vbiBEZWMgMTkgMTQ6MzY6MjYgUFNUIDIwMDUgLSBTdW1hbnQgUGF0cm8gPFN1bWFudC5QYXRy
b0Bsc2lsLmNvbT4KKzIgQ3VycmVudCBWZXJzaW9uIDogMDAuMDAuMDIuMDAtcmM0IAorMyBPbGRl
ciBWZXJzaW9uICAgOiAwMC4wMC4wMi4wMSAKKworaS4JQ29kZSByZW9yZ2FuaXplZCB0byByZW1v
dmUgY29kZSBkdXBsaWNhdGlvbiBpbiBtZWdhc2FzX2J1aWxkX2NtZC4gCisKKwkiVGhlcmUncyBh
IGxvdCBvZiBkdXBsaWNhdGUgY29kZSBtZWdhc2FzX2J1aWxkX2NtZC4gIE1vdmUgdGhhdCBvdXQg
b2YgdGhlIGRpZmZlcmVudCBjb2RlcGF0aGVzIGFuZCBtZXJnZSB0aGUgcmVtaW5kZXIgb2YgbWVn
YXNhc19idWlsZF9jbWQgaW50byBtZWdhc2FzX3F1ZXVlX2NvbW1hbmQiCisKKwkJLSBDaHJpc3Rv
cGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KKworaWkuCURlZmluZWQgTUVHQVNBU19JT0NfRklSTVdB
UkUzMiBmb3IgY29kZSBwYXRocyB0aGF0IGhhbmRsZXMgMzIgYml0IGFwcGxpY2F0aW9ucyBpbiA2
NCBiaXQgc3lzdGVtcy4KKworCSJNRUdBU0FTX0lPQ19GSVJNV0FSRSBjYW4ndCBiZSByZWRlZmlu
ZWQgaWYgQ09ORklHX0NPTVBBVCBpcyBzZXQsIHdlIG5lZWQgdG8gZGVmaW5lIGEgTUVHQVNBU19J
T0NfRklSTVdBUkUzMiBkZWZpbmUgc28gbmF0aXZlIGJpbmFyaWVzIGNvbnRpbnVlIHRvIHdvcmsi
CisKKwkJLSBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4KZGlmZiAtTmF1ciBsaW51eDIu
Ni5vcmlnL2RyaXZlcnMvc2NzaS9tZWdhcmFpZC9tZWdhcmFpZF9zYXMuYyBsaW51eDIuNi9kcml2
ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRfc2FzLmMKLS0tIGxpbnV4Mi42Lm9yaWcvZHJpdmVy
cy9zY3NpL21lZ2FyYWlkL21lZ2FyYWlkX3Nhcy5jCTIwMDUtMTItMTUgMTQ6MDg6MjEuMDAwMDAw
MDAwIC0wODAwCisrKyBsaW51eDIuNi9kcml2ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRfc2Fz
LmMJMjAwNS0xMi0xOSAxNDozNjoxNi4wMDAwMDAwMDAgLTA4MDAKQEAgLTEwLDcgKzEwLDcgQEAK
ICAqCSAgIDIgb2YgdGhlIExpY2Vuc2UsIG9yIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZl
cnNpb24uCiAgKgogICogRklMRQkJOiBtZWdhcmFpZF9zYXMuYwotICogVmVyc2lvbgk6IHYwMC4w
MC4wMi4wMC1yYzQKKyAqIFZlcnNpb24JOiB2MDAuMDAuMDIuMDEKICAqCiAgKiBBdXRob3JzOgog
ICogCVNyZWVuaXZhcyBCYWdhbGtvdGUJPFNyZWVuaXZhcy5CYWdhbGtvdGVAbHNpbC5jb20+CkBA
IC01NTcsMTEyICs1NTcsMjkgQEAKIH0KIAogLyoqCi0gKiBtZWdhc2FzX2J1aWxkX2NtZCAtCVBy
ZXBhcmVzIGEgY29tbWFuZCBwYWNrZXQKLSAqIEBpbnN0YW5jZToJCUFkYXB0ZXIgc29mdCBzdGF0
ZQotICogQHNjcDoJCVNDU0kgY29tbWFuZAotICogQGZyYW1lX2NvdW50OglbT1VUXSBOdW1iZXIg
b2YgZnJhbWVzIHVzZWQgdG8gcHJlcGFyZSB0aGlzIGNvbW1hbmQKKyAqIG1lZ2FzYXNfaXNfbGRp
byAtCQlDaGVja3MgaWYgdGhlIGNtZCBpcyBmb3IgbG9naWNhbCBkcml2ZQorICogQHNjbWQ6CQkJ
U0NTSSBjb21tYW5kCisgKgkKKyAqIENhbGxlZCBieSBtZWdhc2FzX3F1ZXVlX2NvbW1hbmQgdG8g
ZmluZCBvdXQgaWYgdGhlIGNvbW1hbmQgdG8gYmUgcXVldWVkCisgKiBpcyBhIGxvZ2ljYWwgZHJp
dmUgY29tbWFuZAkKICAqLwotc3RhdGljIGlubGluZSBzdHJ1Y3QgbWVnYXNhc19jbWQgKm1lZ2Fz
YXNfYnVpbGRfY21kKHN0cnVjdCBtZWdhc2FzX2luc3RhbmNlCi0JCQkJCQkgICAgKmluc3RhbmNl
LAotCQkJCQkJICAgIHN0cnVjdCBzY3NpX2NtbmQgKnNjcCwKLQkJCQkJCSAgICBpbnQgKmZyYW1l
X2NvdW50KQorc3RhdGljIGlubGluZSBpbnQgbWVnYXNhc19pc19sZGlvKHN0cnVjdCBzY3NpX2Nt
bmQgKmNtZCkKIHsKLQl1MzIgbG9naWNhbF9jbWQ7Ci0Jc3RydWN0IG1lZ2FzYXNfY21kICpjbWQ7
Ci0KLQkvKgotCSAqIEZpbmQgb3V0IGlmIHRoaXMgaXMgbG9naWNhbCBvciBwaHlzaWNhbCBkcml2
ZSBjb21tYW5kLgotCSAqLwotCWxvZ2ljYWxfY21kID0gTUVHQVNBU19JU19MT0dJQ0FMKHNjcCk7
Ci0KLQkvKgotCSAqIExvZ2ljYWwgZHJpdmUgY29tbWFuZAotCSAqLwotCWlmIChsb2dpY2FsX2Nt
ZCkgewotCi0JCWlmIChzY3AtPmRldmljZS0+aWQgPj0gTUVHQVNBU19NQVhfTEQpIHsKLQkJCXNj
cC0+cmVzdWx0ID0gRElEX0JBRF9UQVJHRVQgPDwgMTY7Ci0JCQlyZXR1cm4gTlVMTDsKLQkJfQot
Ci0JCXN3aXRjaCAoc2NwLT5jbW5kWzBdKSB7Ci0KLQkJY2FzZSBSRUFEXzEwOgotCQljYXNlIFdS
SVRFXzEwOgotCQljYXNlIFJFQURfMTI6Ci0JCWNhc2UgV1JJVEVfMTI6Ci0JCWNhc2UgUkVBRF82
OgotCQljYXNlIFdSSVRFXzY6Ci0JCWNhc2UgUkVBRF8xNjoKLQkJY2FzZSBXUklURV8xNjoKLQkJ
CS8qCi0JCQkgKiBGYWlsIGZvciBMVU4gPiAwCi0JCQkgKi8KLQkJCWlmIChzY3AtPmRldmljZS0+
bHVuKSB7Ci0JCQkJc2NwLT5yZXN1bHQgPSBESURfQkFEX1RBUkdFVCA8PCAxNjsKLQkJCQlyZXR1
cm4gTlVMTDsKLQkJCX0KLQotCQkJY21kID0gbWVnYXNhc19nZXRfY21kKGluc3RhbmNlKTsKLQot
CQkJaWYgKCFjbWQpIHsKLQkJCQlzY3AtPnJlc3VsdCA9IERJRF9JTU1fUkVUUlkgPDwgMTY7Ci0J
CQkJcmV0dXJuIE5VTEw7Ci0JCQl9Ci0KLQkJCSpmcmFtZV9jb3VudCA9IG1lZ2FzYXNfYnVpbGRf
bGRpbyhpbnN0YW5jZSwgc2NwLCBjbWQpOwotCi0JCQlpZiAoISgqZnJhbWVfY291bnQpKSB7Ci0J
CQkJbWVnYXNhc19yZXR1cm5fY21kKGluc3RhbmNlLCBjbWQpOwotCQkJCXJldHVybiBOVUxMOwot
CQkJfQotCi0JCQlyZXR1cm4gY21kOwotCi0JCWRlZmF1bHQ6Ci0JCQkvKgotCQkJICogRmFpbCBm
b3IgTFVOID4gMAotCQkJICovCi0JCQlpZiAoc2NwLT5kZXZpY2UtPmx1bikgewotCQkJCXNjcC0+
cmVzdWx0ID0gRElEX0JBRF9UQVJHRVQgPDwgMTY7Ci0JCQkJcmV0dXJuIE5VTEw7Ci0JCQl9Ci0K
LQkJCWNtZCA9IG1lZ2FzYXNfZ2V0X2NtZChpbnN0YW5jZSk7Ci0KLQkJCWlmICghY21kKSB7Ci0J
CQkJc2NwLT5yZXN1bHQgPSBESURfSU1NX1JFVFJZIDw8IDE2OwotCQkJCXJldHVybiBOVUxMOwot
CQkJfQotCi0JCQkqZnJhbWVfY291bnQgPSBtZWdhc2FzX2J1aWxkX2RjZGIoaW5zdGFuY2UsIHNj
cCwgY21kKTsKLQotCQkJaWYgKCEoKmZyYW1lX2NvdW50KSkgewotCQkJCW1lZ2FzYXNfcmV0dXJu
X2NtZChpbnN0YW5jZSwgY21kKTsKLQkJCQlyZXR1cm4gTlVMTDsKLQkJCX0KLQotCQkJcmV0dXJu
IGNtZDsKLQkJfQotCX0gZWxzZSB7Ci0JCWNtZCA9IG1lZ2FzYXNfZ2V0X2NtZChpbnN0YW5jZSk7
Ci0KLQkJaWYgKCFjbWQpIHsKLQkJCXNjcC0+cmVzdWx0ID0gRElEX0lNTV9SRVRSWSA8PCAxNjsK
LQkJCXJldHVybiBOVUxMOwotCQl9Ci0KLQkJKmZyYW1lX2NvdW50ID0gbWVnYXNhc19idWlsZF9k
Y2RiKGluc3RhbmNlLCBzY3AsIGNtZCk7Ci0KLQkJaWYgKCEoKmZyYW1lX2NvdW50KSkgewotCQkJ
bWVnYXNhc19yZXR1cm5fY21kKGluc3RhbmNlLCBjbWQpOwotCQkJcmV0dXJuIE5VTEw7Ci0JCX0K
LQotCQlyZXR1cm4gY21kOworCWlmICghTUVHQVNBU19JU19MT0dJQ0FMKGNtZCkpCisJCXJldHVy
biAwOworCXN3aXRjaCAoY21kLT5jbW5kWzBdKSB7CisJY2FzZSBSRUFEXzEwOgorCWNhc2UgV1JJ
VEVfMTA6CisJY2FzZSBSRUFEXzEyOgorCWNhc2UgV1JJVEVfMTI6CisJY2FzZSBSRUFEXzY6CisJ
Y2FzZSBXUklURV82OgorCWNhc2UgUkVBRF8xNjoKKwljYXNlIFdSSVRFXzE2OgorCQlyZXR1cm4g
MTsKKwlkZWZhdWx0OgorCQlyZXR1cm4gMDsKIAl9Ci0KLQlyZXR1cm4gTlVMTDsKIH0KIAogLyoq
CkBAIC02ODMsMTMgKzYwMCwyNyBAQAogCXNjbWQtPnNjc2lfZG9uZSA9IGRvbmU7CiAJc2NtZC0+
cmVzdWx0ID0gMDsKIAotCWNtZCA9IG1lZ2FzYXNfYnVpbGRfY21kKGluc3RhbmNlLCBzY21kLCAm
ZnJhbWVfY291bnQpOwotCi0JaWYgKCFjbWQpIHsKLQkJZG9uZShzY21kKTsKLQkJcmV0dXJuIDA7
CisJaWYgKE1FR0FTQVNfSVNfTE9HSUNBTChzY21kKSAmJgorCSAgICAoc2NtZC0+ZGV2aWNlLT5p
ZCA+PSBNRUdBU0FTX01BWF9MRCB8fCBzY21kLT5kZXZpY2UtPmx1bikpIHsKKwkJc2NtZC0+cmVz
dWx0ID0gRElEX0JBRF9UQVJHRVQgPDwgMTY7CisJCWdvdG8gb3V0X2RvbmU7CiAJfQogCisJY21k
ID0gbWVnYXNhc19nZXRfY21kKGluc3RhbmNlKTsKKwlpZiAoIWNtZCkKKwkJcmV0dXJuIFNDU0lf
TUxRVUVVRV9IT1NUX0JVU1k7CisKKwkvKgorCSAqIExvZ2ljYWwgZHJpdmUgY29tbWFuZAorCSAq
LworCWlmIChtZWdhc2FzX2lzX2xkaW8oc2NtZCkpCisJCWZyYW1lX2NvdW50ID0gbWVnYXNhc19i
dWlsZF9sZGlvKGluc3RhbmNlLCBzY21kLCBjbWQpOworCWVsc2UKKwkJZnJhbWVfY291bnQgPSBt
ZWdhc2FzX2J1aWxkX2RjZGIoaW5zdGFuY2UsIHNjbWQsIGNtZCk7CisKKwlpZiAoIWZyYW1lX2Nv
dW50KQorCQlnb3RvIG91dF9yZXR1cm5fY21kOworCiAJY21kLT5zY21kID0gc2NtZDsKIAlzY21k
LT5TQ3AucHRyID0gKGNoYXIgKiljbWQ7CiAJc2NtZC0+U0NwLnNlbnRfY29tbWFuZCA9IGppZmZp
ZXM7CkBAIC03MDUsNiArNjM2LDEyIEBACiAJICAgICAgICZpbnN0YW5jZS0+cmVnX3NldC0+aW5i
b3VuZF9xdWV1ZV9wb3J0KTsKIAogCXJldHVybiAwOworCisgb3V0X3JldHVybl9jbWQ6CisJbWVn
YXNhc19yZXR1cm5fY21kKGluc3RhbmNlLCBjbWQpOworIG91dF9kb25lOgorCWRvbmUoc2NtZCk7
CisJcmV0dXJuIDA7CiB9CiAKIC8qKgpAQCAtMjY4MCw5ICsyNjE3LDggQEAKIAkJCSAgdW5zaWdu
ZWQgbG9uZyBhcmcpCiB7CiAJc3dpdGNoIChjbWQpIHsKLQljYXNlIE1FR0FTQVNfSU9DX0ZJUk1X
QVJFOnsKLQkJCXJldHVybiBtZWdhc2FzX21nbXRfY29tcGF0X2lvY3RsX2Z3KGZpbGUsIGFyZyk7
Ci0JCX0KKwljYXNlIE1FR0FTQVNfSU9DX0ZJUk1XQVJFMzI6CisJCXJldHVybiBtZWdhc2FzX21n
bXRfY29tcGF0X2lvY3RsX2Z3KGZpbGUsIGFyZyk7CiAJY2FzZSBNRUdBU0FTX0lPQ19HRVRfQUVO
OgogCQlyZXR1cm4gbWVnYXNhc19tZ210X2lvY3RsX2FlbihmaWxlLCBhcmcpOwogCX0KZGlmZiAt
TmF1ciBsaW51eDIuNi5vcmlnL2RyaXZlcnMvc2NzaS9tZWdhcmFpZC9tZWdhcmFpZF9zYXMuaCBs
aW51eDIuNi9kcml2ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRfc2FzLmgKLS0tIGxpbnV4Mi42
Lm9yaWcvZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2FyYWlkX3Nhcy5oCTIwMDUtMTItMTUgMTQ6
MDg6MjEuMDAwMDAwMDAwIC0wODAwCisrKyBsaW51eDIuNi9kcml2ZXJzL3Njc2kvbWVnYXJhaWQv
bWVnYXJhaWRfc2FzLmgJMjAwNS0xMi0xOSAxNDoyOTozMi4wMDAwMDAwMDAgLTA4MDAKQEAgLTE4
LDEwICsxOCw5IEBACiAvKioKICAqIE1lZ2FSQUlEIFNBUyBEcml2ZXIgbWV0YSBkYXRhCiAgKi8K
LSNkZWZpbmUgTUVHQVNBU19WRVJTSU9OCQkJCSIwMC4wMC4wMi4wMC1yYzQiCi0jZGVmaW5lIE1F
R0FTQVNfUkVMREFURQkJCQkiU2VwIDE2LCAyMDA1IgotI2RlZmluZSBNRUdBU0FTX0VYVF9WRVJT
SU9OCQkJIkZyaSBTZXAgMTYgMTI6Mzc6MDggRURUIDIwMDUiCi0KKyNkZWZpbmUgTUVHQVNBU19W
RVJTSU9OCQkJCSIwMC4wMC4wMi4wMSIKKyNkZWZpbmUgTUVHQVNBU19SRUxEQVRFCQkJCSJEZWMg
MTksIDIwMDUiCisjZGVmaW5lIE1FR0FTQVNfRVhUX1ZFUlNJT04JCQkiTW9uIERlYyAxOSAxNDoz
NjoyNiBQU1QgMjAwNSIKIC8qCiAgKiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09CiAgKiBNZWdhUkFJRCBTQVMgTUZJIGZpcm13YXJlIGRlZmluaXRpb25zCkBAIC0xMTI1LDEx
ICsxMTI0LDEwIEBACiAJc3RydWN0IGNvbXBhdF9pb3ZlYyBzZ2xbTUFYX0lPQ1RMX1NHRV07CiB9
IF9fYXR0cmlidXRlX18gKChwYWNrZWQpKTsKIAotI2RlZmluZSBNRUdBU0FTX0lPQ19GSVJNV0FS
RQlfSU9XUignTScsIDEsIHN0cnVjdCBjb21wYXRfbWVnYXNhc19pb2NwYWNrZXQpCi0jZWxzZQot
I2RlZmluZSBNRUdBU0FTX0lPQ19GSVJNV0FSRQlfSU9XUignTScsIDEsIHN0cnVjdCBtZWdhc2Fz
X2lvY3BhY2tldCkKICNlbmRpZgogCisjZGVmaW5lIE1FR0FTQVNfSU9DX0ZJUk1XQVJFCV9JT1dS
KCdNJywgMSwgc3RydWN0IG1lZ2FzYXNfaW9jcGFja2V0KQorI2RlZmluZSBNRUdBU0FTX0lPQ19G
SVJNV0FSRTMyCV9JT1dSKCdNJywgMSwgc3RydWN0IGNvbXBhdF9tZWdhc2FzX2lvY3BhY2tldCkK
ICNkZWZpbmUgTUVHQVNBU19JT0NfR0VUX0FFTglfSU9XKCdNJywgMywgc3RydWN0IG1lZ2FzYXNf
YWVuKQogCiBzdHJ1Y3QgbWVnYXNhc19tZ210X2luZm8gewo=

------_=_NextPart_001_01C60668.564A3D0D--
