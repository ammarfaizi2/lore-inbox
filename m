Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWDRUwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWDRUwk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 16:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbWDRUwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 16:52:40 -0400
Received: from mail0.lsil.com ([147.145.40.20]:24031 "EHLO mail0.lsil.com")
	by vger.kernel.org with ESMTP id S932337AbWDRUwj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 16:52:39 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6632A.00540E7A"
Subject: [PATCH 1/1] megaraid_{mm,mbox}: updated fix-a-bug-in-reset-handler
Date: Tue, 18 Apr 2006 14:52:27 -0600
Message-ID: <890BF3111FB9484E9526987D912B261901BCE0@NAMAIL3.ad.lsil.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 1/1] megaraid_{mm,mbox}: updated fix-a-bug-in-reset-handler
Thread-Index: AcZjKf/e2rtA90KyRxG/d2S7Jbpwsw==
From: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
To: "Andrew Morton" <akpm@osdl.org>, <andre@linux-ide.org>,
       <James.Bottomley@SteelEye.com>
Cc: "Ju, Seokmann" <Seokmann.Ju@engenio.com>, <linux-kernel@vger.kernel.org>,
       <linux-scsi@vger.kernel.org>
X-OriginalArrivalTime: 18 Apr 2006 20:52:27.0645 (UTC) FILETIME=[009922D0:01C6632A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6632A.00540E7A
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,

This patch has created against 2.6.17-rc1-mm3.

The patch contains changes addressing following concerns brought by
previous megaraid_mmmbox-fix-a-bug-in-reset-handler.patch.

1.Andrew Morton:
	> +			scb->status =3D -EFAULT;

	What is the significance of -EFAULT here?  Seems inappropriate?
2. Andrew Morton:
	And if that mbox is in main memory, the duration of this spin
will vary by
	a factor of many tens across all the different machines on which
this
	driver must operate.

	Careful use of ndelay() or udelay() would fix that.

Thank you,

Seokmann

Signed-Off By: Seokmann Ju <seokmann.ju@lsil.com>
---
diff -Naur old/drivers/scsi/megaraid/megaraid_mbox.c
new/drivers/scsi/megaraid/megaraid_mbox.c
--- old/drivers/scsi/megaraid/megaraid_mbox.c	2006-04-18
17:17:06.288025720 -0400
+++ new/drivers/scsi/megaraid/megaraid_mbox.c	2006-04-13
16:46:53.000000000 -0400
@@ -2278,6 +2278,7 @@
 	unsigned long		flags;
 	uint8_t			c;
 	int			status;
+	uioc_t			*kioc;
=20
=20
 	if (!adapter) return;
@@ -2320,6 +2321,9 @@
 			// remove from local clist
 			list_del_init(&scb->list);
=20
+			kioc			=3D (uioc_t *)scb->gp;
+			kioc->status		=3D 0;
+
 			megaraid_mbox_mm_done(adapter, scb);
=20
 			continue;
@@ -2636,6 +2640,7 @@
 	int		recovery_window;
 	int		recovering;
 	int		i;
+	uioc_t		*kioc;
=20
 	adapter		=3D SCP2ADAPTER(scp);
 	raid_dev	=3D ADAP2RAIDDEV(adapter);
@@ -2662,7 +2667,10 @@
 			"megaraid: IOCTL packet with %d[%d:%d] being
reset\n",
 			scb->sno, scb->dev_channel, scb->dev_target));
=20
-			scb->status =3D -EFAULT;
+			scb->status =3D -1;
+
+			kioc			=3D (uioc_t *)scb->gp;
+			kioc->status		=3D -EFAULT;
=20
 			megaraid_mbox_mm_done(adapter, scb);
 		} else {
@@ -2933,12 +2941,13 @@
 	wmb();
 	WRINDOOR(raid_dev, raid_dev->mbox_dma | 0x1);
=20
-	for (i =3D 0; i < 0xFFFFFF; i++) {
+	for (i =3D 0; i < MBOX_SYNC_WAIT_CNT; i++) {
 		if (mbox->numstatus !=3D 0xFF) break;
 		rmb();
+		udelay(MBOX_SYNC_DELAY_200);
 	}
=20
-	if (i =3D=3D 0xFFFFFF) {
+	if (i =3D=3D MBOX_SYNC_WAIT_CNT) {
 		// We may need to re-calibrate the counter
 		con_log(CL_ANN, (KERN_CRIT
 			"megaraid: fast sync command timed out\n"));
@@ -3717,7 +3726,6 @@
 	unsigned long		flags;
=20
 	kioc			=3D (uioc_t *)scb->gp;
-	kioc->status		=3D 0;
 	mbox64			=3D (mbox64_t *)(unsigned
long)kioc->cmdbuf;
 	mbox64->mbox32.status	=3D scb->status;
 	raw_mbox		=3D (uint8_t *)&mbox64->mbox32;
diff -Naur old/drivers/scsi/megaraid/megaraid_mbox.h
new/drivers/scsi/megaraid/megaraid_mbox.h
--- old/drivers/scsi/megaraid/megaraid_mbox.h	2006-04-18
17:17:06.289025568 -0400
+++ new/drivers/scsi/megaraid/megaraid_mbox.h	2006-04-13
16:05:30.000000000 -0400
@@ -100,6 +100,9 @@
 #define MBOX_BUSY_WAIT		10	// max usec to wait for busy
mailbox
 #define MBOX_RESET_WAIT		180	// wait these many
seconds in reset
 #define MBOX_RESET_EXT_WAIT	120	// extended wait reset
+#define MBOX_SYNC_WAIT_CNT	0xFFFF	// wait loop index for
synchronous mode
+
+#define MBOX_SYNC_DELAY_200	200	// 200 micro-seconds
=20
 /*
  * maximum transfer that can happen through the firmware commands
issued
---

------_=_NextPart_001_01C6632A.00540E7A
Content-Type: application/octet-stream;
	name="megaraid_mm_mbox_II.patch"
Content-Transfer-Encoding: base64
Content-Description: megaraid_mm_mbox_II.patch
Content-Disposition: attachment;
	filename="megaraid_mm_mbox_II.patch"

ZGlmZiAtTmF1ciBvbGQvZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2FyYWlkX21ib3guYyBuZXcv
ZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2FyYWlkX21ib3guYwotLS0gb2xkL2RyaXZlcnMvc2Nz
aS9tZWdhcmFpZC9tZWdhcmFpZF9tYm94LmMJMjAwNi0wNC0xOCAxNzoxNzowNi4yODgwMjU3MjAg
LTA0MDAKKysrIG5ldy9kcml2ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRfbWJveC5jCTIwMDYt
MDQtMTMgMTY6NDY6NTMuMDAwMDAwMDAwIC0wNDAwCkBAIC0yMjc4LDYgKzIyNzgsNyBAQAogCXVu
c2lnbmVkIGxvbmcJCWZsYWdzOwogCXVpbnQ4X3QJCQljOwogCWludAkJCXN0YXR1czsKKwl1aW9j
X3QJCQkqa2lvYzsKIAogCiAJaWYgKCFhZGFwdGVyKSByZXR1cm47CkBAIC0yMzIwLDYgKzIzMjEs
OSBAQAogCQkJLy8gcmVtb3ZlIGZyb20gbG9jYWwgY2xpc3QKIAkJCWxpc3RfZGVsX2luaXQoJnNj
Yi0+bGlzdCk7CiAKKwkJCWtpb2MJCQk9ICh1aW9jX3QgKilzY2ItPmdwOworCQkJa2lvYy0+c3Rh
dHVzCQk9IDA7CisKIAkJCW1lZ2FyYWlkX21ib3hfbW1fZG9uZShhZGFwdGVyLCBzY2IpOwogCiAJ
CQljb250aW51ZTsKQEAgLTI2MzYsNiArMjY0MCw3IEBACiAJaW50CQlyZWNvdmVyeV93aW5kb3c7
CiAJaW50CQlyZWNvdmVyaW5nOwogCWludAkJaTsKKwl1aW9jX3QJCSpraW9jOwogCiAJYWRhcHRl
cgkJPSBTQ1AyQURBUFRFUihzY3ApOwogCXJhaWRfZGV2CT0gQURBUDJSQUlEREVWKGFkYXB0ZXIp
OwpAQCAtMjY2Miw3ICsyNjY3LDEwIEBACiAJCQkibWVnYXJhaWQ6IElPQ1RMIHBhY2tldCB3aXRo
ICVkWyVkOiVkXSBiZWluZyByZXNldFxuIiwKIAkJCXNjYi0+c25vLCBzY2ItPmRldl9jaGFubmVs
LCBzY2ItPmRldl90YXJnZXQpKTsKIAotCQkJc2NiLT5zdGF0dXMgPSAtRUZBVUxUOworCQkJc2Ni
LT5zdGF0dXMgPSAtMTsKKworCQkJa2lvYwkJCT0gKHVpb2NfdCAqKXNjYi0+Z3A7CisJCQlraW9j
LT5zdGF0dXMJCT0gLUVGQVVMVDsKIAogCQkJbWVnYXJhaWRfbWJveF9tbV9kb25lKGFkYXB0ZXIs
IHNjYik7CiAJCX0gZWxzZSB7CkBAIC0yOTMzLDEyICsyOTQxLDEzIEBACiAJd21iKCk7CiAJV1JJ
TkRPT1IocmFpZF9kZXYsIHJhaWRfZGV2LT5tYm94X2RtYSB8IDB4MSk7CiAKLQlmb3IgKGkgPSAw
OyBpIDwgMHhGRkZGRkY7IGkrKykgeworCWZvciAoaSA9IDA7IGkgPCBNQk9YX1NZTkNfV0FJVF9D
TlQ7IGkrKykgewogCQlpZiAobWJveC0+bnVtc3RhdHVzICE9IDB4RkYpIGJyZWFrOwogCQlybWIo
KTsKKwkJdWRlbGF5KE1CT1hfU1lOQ19ERUxBWV8yMDApOwogCX0KIAotCWlmIChpID09IDB4RkZG
RkZGKSB7CisJaWYgKGkgPT0gTUJPWF9TWU5DX1dBSVRfQ05UKSB7CiAJCS8vIFdlIG1heSBuZWVk
IHRvIHJlLWNhbGlicmF0ZSB0aGUgY291bnRlcgogCQljb25fbG9nKENMX0FOTiwgKEtFUk5fQ1JJ
VAogCQkJIm1lZ2FyYWlkOiBmYXN0IHN5bmMgY29tbWFuZCB0aW1lZCBvdXRcbiIpKTsKQEAgLTM3
MTcsNyArMzcyNiw2IEBACiAJdW5zaWduZWQgbG9uZwkJZmxhZ3M7CiAKIAlraW9jCQkJPSAodWlv
Y190ICopc2NiLT5ncDsKLQlraW9jLT5zdGF0dXMJCT0gMDsKIAltYm94NjQJCQk9IChtYm94NjRf
dCAqKSh1bnNpZ25lZCBsb25nKWtpb2MtPmNtZGJ1ZjsKIAltYm94NjQtPm1ib3gzMi5zdGF0dXMJ
PSBzY2ItPnN0YXR1czsKIAlyYXdfbWJveAkJPSAodWludDhfdCAqKSZtYm94NjQtPm1ib3gzMjsK
ZGlmZiAtTmF1ciBvbGQvZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2FyYWlkX21ib3guaCBuZXcv
ZHJpdmVycy9zY3NpL21lZ2FyYWlkL21lZ2FyYWlkX21ib3guaAotLS0gb2xkL2RyaXZlcnMvc2Nz
aS9tZWdhcmFpZC9tZWdhcmFpZF9tYm94LmgJMjAwNi0wNC0xOCAxNzoxNzowNi4yODkwMjU1Njgg
LTA0MDAKKysrIG5ldy9kcml2ZXJzL3Njc2kvbWVnYXJhaWQvbWVnYXJhaWRfbWJveC5oCTIwMDYt
MDQtMTMgMTY6MDU6MzAuMDAwMDAwMDAwIC0wNDAwCkBAIC0xMDAsNiArMTAwLDkgQEAKICNkZWZp
bmUgTUJPWF9CVVNZX1dBSVQJCTEwCS8vIG1heCB1c2VjIHRvIHdhaXQgZm9yIGJ1c3kgbWFpbGJv
eAogI2RlZmluZSBNQk9YX1JFU0VUX1dBSVQJCTE4MAkvLyB3YWl0IHRoZXNlIG1hbnkgc2Vjb25k
cyBpbiByZXNldAogI2RlZmluZSBNQk9YX1JFU0VUX0VYVF9XQUlUCTEyMAkvLyBleHRlbmRlZCB3
YWl0IHJlc2V0CisjZGVmaW5lIE1CT1hfU1lOQ19XQUlUX0NOVAkweEZGRkYJLy8gd2FpdCBsb29w
IGluZGV4IGZvciBzeW5jaHJvbm91cyBtb2RlCisKKyNkZWZpbmUgTUJPWF9TWU5DX0RFTEFZXzIw
MAkyMDAJLy8gMjAwIG1pY3JvLXNlY29uZHMKIAogLyoKICAqIG1heGltdW0gdHJhbnNmZXIgdGhh
dCBjYW4gaGFwcGVuIHRocm91Z2ggdGhlIGZpcm13YXJlIGNvbW1hbmRzIGlzc3VlZAo=

------_=_NextPart_001_01C6632A.00540E7A--
