Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267693AbUBTCOe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 21:14:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267691AbUBTCO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 21:14:26 -0500
Received: from smtp-out4.xs4all.nl ([194.109.24.5]:16915 "EHLO
	smtp-out4.xs4all.nl") by vger.kernel.org with ESMTP id S267693AbUBTCLV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 21:11:21 -0500
Subject: [PATCH][RFC] : Megaraid patch for 2.6 5/5
From: Paul Wagland <paul@wagland.net>
To: Linux SCSI mailing list <linux-scsi@vger.kernel.org>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Cc: James.Bottomley@HansenPartnership.com, atulm@lsil.com
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZXSwVOHW/kVi6dLzsKdg"
Message-Id: <1077242971.12565.93.camel@morsel.kungfoocoder.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 20 Feb 2004 03:09:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZXSwVOHW/kVi6dLzsKdg
Content-Type: multipart/mixed; boundary="=-Ha19QIvACt7trcxScj3R"


--=-Ha19QIvACt7trcxScj3R
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi all,

This is the last patch in the current series. This is my initial attempt
at adding better sysfs support to the megaraid driver. Please note that
this is not yet complete, but it is a start, and is how I want to export
the rest of the /proc card state.

patch attached and below

diff --recursive --ignore-all-space --unified linux-2.6.2.o/drivers/scsi/me=
garaid.c linux-2.6.2.megaraid/drivers/scsi/megaraid.c
--- linux-2.6.2.o/drivers/scsi/megaraid.c	2004-02-20 01:32:34.000000000 +01=
00
+++ linux-2.6.2.megaraid/drivers/scsi/megaraid.c	2004-02-20 01:32:39.000000=
000 +0100
@@ -46,6 +46,8 @@
 #include <linux/interrupt.h>
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
 #include <scsi/scsicam.h>
=20
 #include "scsi.h"
@@ -2333,46 +2335,15 @@
 		void *data)
 {
 	adapter_t	*adapter =3D (adapter_t *)data;
-	dma_addr_t	dma_handle;
-	caddr_t		inquiry;
-	struct pci_dev	*pdev;
-	int	len =3D 0;
-
-	pdev =3D adapter->dev;
-
-	if( (inquiry =3D mega_allocate_inquiry(&dma_handle, pdev)) =3D=3D NULL ) =
{
-		*eof =3D 1;
-		return len;
-	}
-
-	if( mega_adapinq(adapter, dma_handle) !=3D 0 ) {
-
+	int len;
+	int rate =3D mega_get_rebuild_percentage (adapter);
+	if (rate < 0 ) {
 		len =3D sprintf(page, "Adapter inquiry failed.\n");
-
 		printk(KERN_WARNING "megaraid: inquiry failed.\n");
-
-		mega_free_inquiry(inquiry, dma_handle, pdev);
-
-		*eof =3D 1;
-
-		return len;
-	}
-
-	if( adapter->flag & BOARD_40LD ) {
-		len =3D sprintf(page, "Rebuild Rate: [%d%%]\n",
-			((mega_inquiry3 *)inquiry)->rebuild_rate);
-	}
-	else {
-		len =3D sprintf(page, "Rebuild Rate: [%d%%]\n",
-			((mraid_ext_inquiry *)
-			inquiry)->raid_inq.adapter_info.rebuild_rate);
-	}
-
-
-	mega_free_inquiry(inquiry, dma_handle, pdev);
+	} else
+		len =3D snprintf(page, 22, "Rebuild Rate: [%d%%]\n", rate);
=20
 	*eof =3D 1;
-
 	return len;
 }
=20
@@ -4533,6 +4504,55 @@
=20
 }
=20
+/*
+ * This is where we have all of the sysfs related code
+ */
+static ssize_t
+sysfs_show_rebuild_percentage(struct class_device *class_dev, char *buf)
+{
+	struct Scsi_Host *shost =3D class_to_shost(class_dev);
+	adapter_t *adapter =3D (adapter_t *)shost->hostdata;
+
+	return snprintf(buf, 20, "%d\n", mega_get_rebuild_percentage(adapter));
+}
+static CLASS_DEVICE_ATTR(rebuild_percentage, S_IRUGO, sysfs_show_rebuild_p=
ercentage, NULL)
+
+static struct class_device_attribute *megaraid_dev_attrs[] =3D {
+	&class_device_attr_rebuild_percentage,
+	NULL,
+};
+
+
+static int
+mega_get_rebuild_percentage(adapter_t *adapter) {
+	dma_addr_t	dma_handle;
+	caddr_t		inquiry;
+	struct pci_dev	*pdev;
+	int rate;
+
+	pdev =3D adapter->dev;
+
+	if( (inquiry =3D mega_allocate_inquiry(&dma_handle, pdev)) =3D=3D NULL ) =
{
+		return -1;
+	}
+
+	if( mega_adapinq(adapter, dma_handle) !=3D 0 ) {
+		mega_free_inquiry(inquiry, dma_handle, pdev);
+		return -1;
+}
+
+	if( adapter->flag & BOARD_40LD ) {
+		rate =3D ((mega_inquiry3 *)inquiry)->rebuild_rate;
+}
+	else {
+		rate =3D ((mraid_ext_inquiry *)
+			inquiry)->raid_inq.adapter_info.rebuild_rate;
+	}
+
+	mega_free_inquiry(inquiry, dma_handle, pdev);
+	return rate;
+}
+
=20
 static struct scsi_host_template megaraid_template =3D {
 	.module				=3D THIS_MODULE,
@@ -4551,6 +4571,7 @@
 	.eh_device_reset_handler	=3D megaraid_reset,
 	.eh_bus_reset_handler		=3D megaraid_reset,
 	.eh_host_reset_handler		=3D megaraid_reset,
+	.shost_attrs			=3D megaraid_dev_attrs,
 };
=20
 static int __devinit
diff --recursive --ignore-all-space --unified linux-2.6.2.o/drivers/scsi/me=
garaid.h linux-2.6.2.megaraid/drivers/scsi/megaraid.h
--- linux-2.6.2.o/drivers/scsi/megaraid.h	2004-02-20 01:32:30.000000000 +01=
00
+++ linux-2.6.2.megaraid/drivers/scsi/megaraid.h	2004-02-20 01:32:39.000000=
000 +0100
@@ -1051,6 +1051,12 @@
 static int proc_rdrv(adapter_t *, char *, int, int);
 #endif
=20
+/* sysfs routines */
+static ssize_t sysfs_show_rebuild_percentage(struct class_device *, char *=
);
+
+/* common data collection routines */
+static int mega_get_rebuild_percentage(adapter_t *);
+
 static int mega_adapinq(adapter_t *, dma_addr_t);
 static int mega_internal_dev_inquiry(adapter_t *, u8, u8, dma_addr_t);
 static inline caddr_t mega_allocate_inquiry(dma_addr_t *, struct pci_dev *=
);


--=-Ha19QIvACt7trcxScj3R
Content-Disposition: attachment; filename=5-megaraid.proto-sysfs.patch
Content-Type: text/x-patch; name=5-megaraid.proto-sysfs.patch; charset=UTF-8
Content-Transfer-Encoding: base64

ZGlmZiAtLXJlY3Vyc2l2ZSAtLWlnbm9yZS1hbGwtc3BhY2UgLS11bmlmaWVkIGxpbnV4LTIuNi4y
Lm8vZHJpdmVycy9zY3NpL21lZ2FyYWlkLmMgbGludXgtMi42LjIubWVnYXJhaWQvZHJpdmVycy9z
Y3NpL21lZ2FyYWlkLmMNCi0tLSBsaW51eC0yLjYuMi5vL2RyaXZlcnMvc2NzaS9tZWdhcmFpZC5j
CTIwMDQtMDItMjAgMDE6MzI6MzQuMDAwMDAwMDAwICswMTAwDQorKysgbGludXgtMi42LjIubWVn
YXJhaWQvZHJpdmVycy9zY3NpL21lZ2FyYWlkLmMJMjAwNC0wMi0yMCAwMTozMjozOS4wMDAwMDAw
MDAgKzAxMDANCkBAIC00Niw2ICs0Niw4IEBADQogI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5o
Pg0KICNpbmNsdWRlIDxsaW51eC9wY2kuaD4NCiAjaW5jbHVkZSA8bGludXgvaW5pdC5oPg0KKyNp
bmNsdWRlIDxsaW51eC9rb2JqZWN0Lmg+DQorI2luY2x1ZGUgPGxpbnV4L3N5c2ZzLmg+DQogI2lu
Y2x1ZGUgPHNjc2kvc2NzaWNhbS5oPg0KIA0KICNpbmNsdWRlICJzY3NpLmgiDQpAQCAtMjMzMyw0
NiArMjMzNSwxNSBAQA0KIAkJdm9pZCAqZGF0YSkNCiB7DQogCWFkYXB0ZXJfdAkqYWRhcHRlciA9
IChhZGFwdGVyX3QgKilkYXRhOw0KLQlkbWFfYWRkcl90CWRtYV9oYW5kbGU7DQotCWNhZGRyX3QJ
CWlucXVpcnk7DQotCXN0cnVjdCBwY2lfZGV2CSpwZGV2Ow0KLQlpbnQJbGVuID0gMDsNCi0NCi0J
cGRldiA9IGFkYXB0ZXItPmRldjsNCi0NCi0JaWYoIChpbnF1aXJ5ID0gbWVnYV9hbGxvY2F0ZV9p
bnF1aXJ5KCZkbWFfaGFuZGxlLCBwZGV2KSkgPT0gTlVMTCApIHsNCi0JCSplb2YgPSAxOw0KLQkJ
cmV0dXJuIGxlbjsNCi0JfQ0KLQ0KLQlpZiggbWVnYV9hZGFwaW5xKGFkYXB0ZXIsIGRtYV9oYW5k
bGUpICE9IDAgKSB7DQotDQorCWludCBsZW47DQorCWludCByYXRlID0gbWVnYV9nZXRfcmVidWls
ZF9wZXJjZW50YWdlIChhZGFwdGVyKTsNCisJaWYgKHJhdGUgPCAwICkgew0KIAkJbGVuID0gc3By
aW50ZihwYWdlLCAiQWRhcHRlciBpbnF1aXJ5IGZhaWxlZC5cbiIpOw0KLQ0KIAkJcHJpbnRrKEtF
Uk5fV0FSTklORyAibWVnYXJhaWQ6IGlucXVpcnkgZmFpbGVkLlxuIik7DQotDQotCQltZWdhX2Zy
ZWVfaW5xdWlyeShpbnF1aXJ5LCBkbWFfaGFuZGxlLCBwZGV2KTsNCi0NCi0JCSplb2YgPSAxOw0K
LQ0KLQkJcmV0dXJuIGxlbjsNCi0JfQ0KLQ0KLQlpZiggYWRhcHRlci0+ZmxhZyAmIEJPQVJEXzQw
TEQgKSB7DQotCQlsZW4gPSBzcHJpbnRmKHBhZ2UsICJSZWJ1aWxkIFJhdGU6IFslZCUlXVxuIiwN
Ci0JCQkoKG1lZ2FfaW5xdWlyeTMgKilpbnF1aXJ5KS0+cmVidWlsZF9yYXRlKTsNCi0JfQ0KLQll
bHNlIHsNCi0JCWxlbiA9IHNwcmludGYocGFnZSwgIlJlYnVpbGQgUmF0ZTogWyVkJSVdXG4iLA0K
LQkJCSgobXJhaWRfZXh0X2lucXVpcnkgKikNCi0JCQlpbnF1aXJ5KS0+cmFpZF9pbnEuYWRhcHRl
cl9pbmZvLnJlYnVpbGRfcmF0ZSk7DQotCX0NCi0NCi0NCi0JbWVnYV9mcmVlX2lucXVpcnkoaW5x
dWlyeSwgZG1hX2hhbmRsZSwgcGRldik7DQorCX0gZWxzZQ0KKwkJbGVuID0gc25wcmludGYocGFn
ZSwgMjIsICJSZWJ1aWxkIFJhdGU6IFslZCUlXVxuIiwgcmF0ZSk7DQogDQogCSplb2YgPSAxOw0K
LQ0KIAlyZXR1cm4gbGVuOw0KIH0NCiANCkBAIC00NTMzLDYgKzQ1MDQsNTUgQEANCiANCiB9DQog
DQorLyoNCisgKiBUaGlzIGlzIHdoZXJlIHdlIGhhdmUgYWxsIG9mIHRoZSBzeXNmcyByZWxhdGVk
IGNvZGUNCisgKi8NCitzdGF0aWMgc3NpemVfdA0KK3N5c2ZzX3Nob3dfcmVidWlsZF9wZXJjZW50
YWdlKHN0cnVjdCBjbGFzc19kZXZpY2UgKmNsYXNzX2RldiwgY2hhciAqYnVmKQ0KK3sNCisJc3Ry
dWN0IFNjc2lfSG9zdCAqc2hvc3QgPSBjbGFzc190b19zaG9zdChjbGFzc19kZXYpOw0KKwlhZGFw
dGVyX3QgKmFkYXB0ZXIgPSAoYWRhcHRlcl90ICopc2hvc3QtPmhvc3RkYXRhOw0KKw0KKwlyZXR1
cm4gc25wcmludGYoYnVmLCAyMCwgIiVkXG4iLCBtZWdhX2dldF9yZWJ1aWxkX3BlcmNlbnRhZ2Uo
YWRhcHRlcikpOw0KK30NCitzdGF0aWMgQ0xBU1NfREVWSUNFX0FUVFIocmVidWlsZF9wZXJjZW50
YWdlLCBTX0lSVUdPLCBzeXNmc19zaG93X3JlYnVpbGRfcGVyY2VudGFnZSwgTlVMTCkNCisNCitz
dGF0aWMgc3RydWN0IGNsYXNzX2RldmljZV9hdHRyaWJ1dGUgKm1lZ2FyYWlkX2Rldl9hdHRyc1td
ID0gew0KKwkmY2xhc3NfZGV2aWNlX2F0dHJfcmVidWlsZF9wZXJjZW50YWdlLA0KKwlOVUxMLA0K
K307DQorDQorDQorc3RhdGljIGludA0KK21lZ2FfZ2V0X3JlYnVpbGRfcGVyY2VudGFnZShhZGFw
dGVyX3QgKmFkYXB0ZXIpIHsNCisJZG1hX2FkZHJfdAlkbWFfaGFuZGxlOw0KKwljYWRkcl90CQlp
bnF1aXJ5Ow0KKwlzdHJ1Y3QgcGNpX2RldgkqcGRldjsNCisJaW50IHJhdGU7DQorDQorCXBkZXYg
PSBhZGFwdGVyLT5kZXY7DQorDQorCWlmKCAoaW5xdWlyeSA9IG1lZ2FfYWxsb2NhdGVfaW5xdWly
eSgmZG1hX2hhbmRsZSwgcGRldikpID09IE5VTEwgKSB7DQorCQlyZXR1cm4gLTE7DQorCX0NCisN
CisJaWYoIG1lZ2FfYWRhcGlucShhZGFwdGVyLCBkbWFfaGFuZGxlKSAhPSAwICkgew0KKwkJbWVn
YV9mcmVlX2lucXVpcnkoaW5xdWlyeSwgZG1hX2hhbmRsZSwgcGRldik7DQorCQlyZXR1cm4gLTE7
DQorfQ0KKw0KKwlpZiggYWRhcHRlci0+ZmxhZyAmIEJPQVJEXzQwTEQgKSB7DQorCQlyYXRlID0g
KChtZWdhX2lucXVpcnkzICopaW5xdWlyeSktPnJlYnVpbGRfcmF0ZTsNCit9DQorCWVsc2Ugew0K
KwkJcmF0ZSA9ICgobXJhaWRfZXh0X2lucXVpcnkgKikNCisJCQlpbnF1aXJ5KS0+cmFpZF9pbnEu
YWRhcHRlcl9pbmZvLnJlYnVpbGRfcmF0ZTsNCisJfQ0KKw0KKwltZWdhX2ZyZWVfaW5xdWlyeShp
bnF1aXJ5LCBkbWFfaGFuZGxlLCBwZGV2KTsNCisJcmV0dXJuIHJhdGU7DQorfQ0KKw0KIA0KIHN0
YXRpYyBzdHJ1Y3Qgc2NzaV9ob3N0X3RlbXBsYXRlIG1lZ2FyYWlkX3RlbXBsYXRlID0gew0KIAku
bW9kdWxlCQkJCT0gVEhJU19NT0RVTEUsDQpAQCAtNDU1MSw2ICs0NTcxLDcgQEANCiAJLmVoX2Rl
dmljZV9yZXNldF9oYW5kbGVyCT0gbWVnYXJhaWRfcmVzZXQsDQogCS5laF9idXNfcmVzZXRfaGFu
ZGxlcgkJPSBtZWdhcmFpZF9yZXNldCwNCiAJLmVoX2hvc3RfcmVzZXRfaGFuZGxlcgkJPSBtZWdh
cmFpZF9yZXNldCwNCisJLnNob3N0X2F0dHJzCQkJPSBtZWdhcmFpZF9kZXZfYXR0cnMsDQogfTsN
CiANCiBzdGF0aWMgaW50IF9fZGV2aW5pdA0KZGlmZiAtLXJlY3Vyc2l2ZSAtLWlnbm9yZS1hbGwt
c3BhY2UgLS11bmlmaWVkIGxpbnV4LTIuNi4yLm8vZHJpdmVycy9zY3NpL21lZ2FyYWlkLmggbGlu
dXgtMi42LjIubWVnYXJhaWQvZHJpdmVycy9zY3NpL21lZ2FyYWlkLmgNCi0tLSBsaW51eC0yLjYu
Mi5vL2RyaXZlcnMvc2NzaS9tZWdhcmFpZC5oCTIwMDQtMDItMjAgMDE6MzI6MzAuMDAwMDAwMDAw
ICswMTAwDQorKysgbGludXgtMi42LjIubWVnYXJhaWQvZHJpdmVycy9zY3NpL21lZ2FyYWlkLmgJ
MjAwNC0wMi0yMCAwMTozMjozOS4wMDAwMDAwMDAgKzAxMDANCkBAIC0xMDUxLDYgKzEwNTEsMTIg
QEANCiBzdGF0aWMgaW50IHByb2NfcmRydihhZGFwdGVyX3QgKiwgY2hhciAqLCBpbnQsIGludCk7
DQogI2VuZGlmDQogDQorLyogc3lzZnMgcm91dGluZXMgKi8NCitzdGF0aWMgc3NpemVfdCBzeXNm
c19zaG93X3JlYnVpbGRfcGVyY2VudGFnZShzdHJ1Y3QgY2xhc3NfZGV2aWNlICosIGNoYXIgKik7
DQorDQorLyogY29tbW9uIGRhdGEgY29sbGVjdGlvbiByb3V0aW5lcyAqLw0KK3N0YXRpYyBpbnQg
bWVnYV9nZXRfcmVidWlsZF9wZXJjZW50YWdlKGFkYXB0ZXJfdCAqKTsNCisNCiBzdGF0aWMgaW50
IG1lZ2FfYWRhcGlucShhZGFwdGVyX3QgKiwgZG1hX2FkZHJfdCk7DQogc3RhdGljIGludCBtZWdh
X2ludGVybmFsX2Rldl9pbnF1aXJ5KGFkYXB0ZXJfdCAqLCB1OCwgdTgsIGRtYV9hZGRyX3QpOw0K
IHN0YXRpYyBpbmxpbmUgY2FkZHJfdCBtZWdhX2FsbG9jYXRlX2lucXVpcnkoZG1hX2FkZHJfdCAq
LCBzdHJ1Y3QgcGNpX2RldiAqKTsNCg==

--=-Ha19QIvACt7trcxScj3R--

--=-ZXSwVOHW/kVi6dLzsKdg
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBANWxbtch0EvEFvxURAsUmAJ40RL+FqTK8WgGzsXuKCDDpkDuC7wCgrDS1
x/ANJ9nMImibWpZ6CGf9MP0=
=Hm3C
-----END PGP SIGNATURE-----

--=-ZXSwVOHW/kVi6dLzsKdg--

