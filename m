Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266546AbUBLS7Z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 13:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUBLS7Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 13:59:25 -0500
Received: from hermes.iil.intel.com ([192.198.152.99]:16090 "EHLO
	hermes.iil.intel.com") by vger.kernel.org with ESMTP
	id S266546AbUBLS65 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 13:58:57 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3F19A.3C48678B"
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: [PATCH] calculating interpreter's credentials - binfmt_misc 2.6.3-rc1-mm1
Date: Thu, 12 Feb 2004 20:58:43 +0200
Message-ID: <2C83850C013A2540861D03054B478C0601CF69BD@hasmsx403.iil.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] calculating interpreter's credentials - binfmt_misc 2.6.3-rc1-mm1
Thread-Index: AcPxmjq7FVhKWVpRSQepMjF1P7pgsQ==
From: "Zach, Yoav" <yoav.zach@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: "Sharma, Arun" <arun.sharma@intel.com>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 12 Feb 2004 18:58:44.0026 (UTC) FILETIME=[3C9681A0:01C3F19A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3F19A.3C48678B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

This patch allows for misc binaries to run with credentials and security
token that are calculated according to the binaries, and not according
to
the interpreter, which is the legacy behavior of binfmt_misc. The way it
is done is by calling prepare_binprm, which is where these attributes
are
calculated, before switching the 'file' field in the bprm from the
binary
to the interpreter. This feature should be used with care, since the=20
interpreter will have root permissions when running a setuid binary
owned
by root. Please note -=20
*) Only root can register an interpreter with binfmt_misc
*) The feature is documented and the administrator is advised to handle
it
   with care
*) The new feature is enabled only with a special flag in the
registration
   string. When this flag is not specified the current behavior of
binfmt_misc
   is kept
*) The use of this feature implies the use of the 'open-binary' feature
   (see '[PATCH]: non-readable binaries - binfmt_misc 2.6.0' from Jan.
15),
   so that the binary cannot be replaced 'underneath the feet' of the=20
   interpreter
*) This is the only 'right' way for an interpreter to know the correct
   AT_SECURE value for the interpreted binary

The patch is against 2.6.3-rc1-mm1 (it's also attached in case the lines
get broken) :

----------------- BEGIN PATCH -----------------------
diff -rupN linux-2.6.3-rc1-mm1/Documentation/binfmt_misc.txt
linux/Documentation/binfmt_misc.txt
--- linux-2.6.3-rc1-mm1/Documentation/binfmt_misc.txt	2004-02-05
13:41:26.000000000 +0200
+++ linux/Documentation/binfmt_misc.txt	2004-02-10 12:24:16.169483921
+0200
@@ -46,8 +46,15 @@ Here is what the fields mean:
             included, binfmt_misc will open the file for reading and
pass its
             descriptor as an argument, instead of the full path, thus
allowing
             the interpreter to execute non-readable binaries. This
feature should
-	     be used with care - the interpreter has to be trusted not
to emit
-	     the contents of the non-readable binary.
+            be used with care - the interpreter has to be trusted not
to emit
+            the contents of the non-readable binary.
=09
=20
=20
 There are some restrictions:
diff -rupN linux-2.6.3-rc1-mm1/fs/binfmt_misc.c linux/fs/binfmt_misc.c
--- linux-2.6.3-rc1-mm1/fs/binfmt_misc.c	2004-02-05
13:41:06.000000000 +0200
+++ linux/fs/binfmt_misc.c	2004-02-10 12:23:58.174611486 +0200
@@ -39,6 +39,7 @@ static int enabled =3D 1;
 enum {Enabled, Magic};
 #define MISC_FMT_PRESERVE_ARGV0 (1<<31)
 #define MISC_FMT_OPEN_BINARY (1<<30)
+#define MISC_FMT_CREDENTIALS (1<<29)
=20
 typedef struct {
 	struct list_head list;
@@ -171,8 +172,20 @@ static int load_misc_binary(struct linux
=20
=20
 	binary_file =3D bprm->file;
-	bprm->file =3D interp_file;
-	retval =3D prepare_binprm (bprm);
+	if (fmt->flags & MISC_FMT_CREDENTIALS) {
+		/* call prepare_binprm before switching to interpreter's
file
+		 * so that all security calculation will be done
according to
+		 * binary and not interpreter */
+		retval =3D prepare_binprm (bprm);
+		if (retval < 0)=20
+			goto _error;
+		bprm->file =3D interp_file;
+		memset (bprm->buf, 0, BINPRM_BUF_SIZE);
+		retval =3D kernel_read (bprm->file, 0, bprm->buf,
BINPRM_BUF_SIZE);
+	} else {
+		bprm->file =3D interp_file;
+		retval =3D prepare_binprm (bprm);
+	}
=20
 	if (retval < 0)
 		goto _error;
@@ -270,6 +283,13 @@ static inline char * check_special_flags
 				p++;
 				e->flags |=3D MISC_FMT_OPEN_BINARY;
 				break;
+			case 'C':
+				p++;
+				/* this flags also implies the=20
+				   open-binary flag */
+				e->flags |=3D (MISC_FMT_CREDENTIALS |
+						MISC_FMT_OPEN_BINARY);
+				break;
 			default:
 				cont =3D 0;
 		}
@@ -452,6 +472,9 @@ static void entry_status(Node *e, char *
 	if (e->flags & MISC_FMT_OPEN_BINARY) {
 		*dp ++ =3D 'O';
 	}
+	if (e->flags & MISC_FMT_CREDENTIALS) {
+		*dp ++ =3D 'C';
+	}
 	*dp ++ =3D '\n';

=20
----------------- END PATCH -----------------------

Yoav Zach
IA-32 Execution Layer
Performance Tools Lab
Intel Corp.


------_=_NextPart_001_01C3F19A.3C48678B
Content-Type: application/octet-stream;
	name="linux-2.6.3-rc1-mm1-binfmt_misc-credentials.patch"
Content-Transfer-Encoding: base64
Content-Description: linux-2.6.3-rc1-mm1-binfmt_misc-credentials.patch
Content-Disposition: attachment;
	filename="linux-2.6.3-rc1-mm1-binfmt_misc-credentials.patch"

ZGlmZiAtcnVwTiBsaW51eC0yLjYuMy1yYzEtbW0xL0RvY3VtZW50YXRpb24vYmluZm10X21pc2Mu
dHh0IGxpbnV4L0RvY3VtZW50YXRpb24vYmluZm10X21pc2MudHh0DQotLS0gbGludXgtMi42LjMt
cmMxLW1tMS9Eb2N1bWVudGF0aW9uL2JpbmZtdF9taXNjLnR4dAkyMDA0LTAyLTA1IDEzOjQxOjI2
LjAwMDAwMDAwMCArMDIwMA0KKysrIGxpbnV4L0RvY3VtZW50YXRpb24vYmluZm10X21pc2MudHh0
CTIwMDQtMDItMTAgMTI6MjQ6MTYuMTY5NDgzOTIxICswMjAwDQpAQCAtNDYsOCArNDYsMTUgQEAg
SGVyZSBpcyB3aGF0IHRoZSBmaWVsZHMgbWVhbjoNCiAgICAgICAgICAgICBpbmNsdWRlZCwgYmlu
Zm10X21pc2Mgd2lsbCBvcGVuIHRoZSBmaWxlIGZvciByZWFkaW5nIGFuZCBwYXNzIGl0cw0KICAg
ICAgICAgICAgIGRlc2NyaXB0b3IgYXMgYW4gYXJndW1lbnQsIGluc3RlYWQgb2YgdGhlIGZ1bGwg
cGF0aCwgdGh1cyBhbGxvd2luZw0KICAgICAgICAgICAgIHRoZSBpbnRlcnByZXRlciB0byBleGVj
dXRlIG5vbi1yZWFkYWJsZSBiaW5hcmllcy4gVGhpcyBmZWF0dXJlIHNob3VsZA0KLQkgICAgIGJl
IHVzZWQgd2l0aCBjYXJlIC0gdGhlIGludGVycHJldGVyIGhhcyB0byBiZSB0cnVzdGVkIG5vdCB0
byBlbWl0DQotCSAgICAgdGhlIGNvbnRlbnRzIG9mIHRoZSBub24tcmVhZGFibGUgYmluYXJ5Lg0K
KyAgICAgICAgICAgIGJlIHVzZWQgd2l0aCBjYXJlIC0gdGhlIGludGVycHJldGVyIGhhcyB0byBi
ZSB0cnVzdGVkIG5vdCB0byBlbWl0DQorICAgICAgICAgICAgdGhlIGNvbnRlbnRzIG9mIHRoZSBu
b24tcmVhZGFibGUgYmluYXJ5Lg0KKyAgICAgICdDJyAtIGNyZWRlbnRpYWxzLiBDdXJyZW50bHks
IHRoZSBiZWhhdmlvciBvZiBiaW5mbXRfbWlzYyBpcyB0byBjYWxjdWxhdGUNCisgICAgICAgICAg
ICB0aGUgY3JlZGVudGlhbHMgYW5kIHNlY3VyaXR5IHRva2VuIG9mIHRoZSBuZXcgcHJvY2VzcyBh
Y2NvcmRpbmcgdG8NCisgICAgICAgICAgICB0aGUgaW50ZXJwcmV0ZXIuIFdoZW4gdGhpcyBmbGFn
IGlzIGluY2x1ZGVkLCB0aGVzZSBhdHRyaWJ1dGVzIGFyZQ0KKyAgICAgICAgICAgIGNhbGN1bGF0
ZWQgYWNjb3JkaW5nIHRvIHRoZSBiaW5hcnkuIEl0IGFsc28gaW1wbGllcyB0aGUgJ08nIGZsYWcu
ICANCisgICAgICAgICAgICBUaGlzIGZlYXR1cmUgc2hvdWxkIGJlIHVzZWQgd2l0aCBjYXJlIGFz
IHRoZSBpbnRlcnByZXRlcg0KKyAgICAgICAgICAgIHdpbGwgcnVuIHdpdGggcm9vdCBwZXJtaXNz
aW9ucyB3aGVuIGEgc2V0dWlkIGJpbmFyeSBvd25lZCBieSByb290DQorICAgICAgICAgICAgaXMg
cnVuIHdpdGggYmluZm10X21pc2MuDQogDQogDQogVGhlcmUgYXJlIHNvbWUgcmVzdHJpY3Rpb25z
Og0KZGlmZiAtcnVwTiBsaW51eC0yLjYuMy1yYzEtbW0xL2ZzL2JpbmZtdF9taXNjLmMgbGludXgv
ZnMvYmluZm10X21pc2MuYw0KLS0tIGxpbnV4LTIuNi4zLXJjMS1tbTEvZnMvYmluZm10X21pc2Mu
YwkyMDA0LTAyLTA1IDEzOjQxOjA2LjAwMDAwMDAwMCArMDIwMA0KKysrIGxpbnV4L2ZzL2JpbmZt
dF9taXNjLmMJMjAwNC0wMi0xMCAxMjoyMzo1OC4xNzQ2MTE0ODYgKzAyMDANCkBAIC0zOSw2ICsz
OSw3IEBAIHN0YXRpYyBpbnQgZW5hYmxlZCA9IDE7DQogZW51bSB7RW5hYmxlZCwgTWFnaWN9Ow0K
ICNkZWZpbmUgTUlTQ19GTVRfUFJFU0VSVkVfQVJHVjAgKDE8PDMxKQ0KICNkZWZpbmUgTUlTQ19G
TVRfT1BFTl9CSU5BUlkgKDE8PDMwKQ0KKyNkZWZpbmUgTUlTQ19GTVRfQ1JFREVOVElBTFMgKDE8
PDI5KQ0KIA0KIHR5cGVkZWYgc3RydWN0IHsNCiAJc3RydWN0IGxpc3RfaGVhZCBsaXN0Ow0KQEAg
LTE3MSw4ICsxNzIsMjAgQEAgc3RhdGljIGludCBsb2FkX21pc2NfYmluYXJ5KHN0cnVjdCBsaW51
eA0KIA0KIA0KIAliaW5hcnlfZmlsZSA9IGJwcm0tPmZpbGU7DQotCWJwcm0tPmZpbGUgPSBpbnRl
cnBfZmlsZTsNCi0JcmV0dmFsID0gcHJlcGFyZV9iaW5wcm0gKGJwcm0pOw0KKwlpZiAoZm10LT5m
bGFncyAmIE1JU0NfRk1UX0NSRURFTlRJQUxTKSB7DQorCQkvKiBjYWxsIHByZXBhcmVfYmlucHJt
IGJlZm9yZSBzd2l0Y2hpbmcgdG8gaW50ZXJwcmV0ZXIncyBmaWxlDQorCQkgKiBzbyB0aGF0IGFs
bCBzZWN1cml0eSBjYWxjdWxhdGlvbiB3aWxsIGJlIGRvbmUgYWNjb3JkaW5nIHRvDQorCQkgKiBi
aW5hcnkgYW5kIG5vdCBpbnRlcnByZXRlciAqLw0KKwkJcmV0dmFsID0gcHJlcGFyZV9iaW5wcm0g
KGJwcm0pOw0KKwkJaWYgKHJldHZhbCA8IDApIA0KKwkJCWdvdG8gX2Vycm9yOw0KKwkJYnBybS0+
ZmlsZSA9IGludGVycF9maWxlOw0KKwkJbWVtc2V0IChicHJtLT5idWYsIDAsIEJJTlBSTV9CVUZf
U0laRSk7DQorCQlyZXR2YWwgPSBrZXJuZWxfcmVhZCAoYnBybS0+ZmlsZSwgMCwgYnBybS0+YnVm
LCBCSU5QUk1fQlVGX1NJWkUpOw0KKwl9IGVsc2Ugew0KKwkJYnBybS0+ZmlsZSA9IGludGVycF9m
aWxlOw0KKwkJcmV0dmFsID0gcHJlcGFyZV9iaW5wcm0gKGJwcm0pOw0KKwl9DQogDQogCWlmIChy
ZXR2YWwgPCAwKQ0KIAkJZ290byBfZXJyb3I7DQpAQCAtMjcwLDYgKzI4MywxMyBAQCBzdGF0aWMg
aW5saW5lIGNoYXIgKiBjaGVja19zcGVjaWFsX2ZsYWdzDQogCQkJCXArKzsNCiAJCQkJZS0+Zmxh
Z3MgfD0gTUlTQ19GTVRfT1BFTl9CSU5BUlk7DQogCQkJCWJyZWFrOw0KKwkJCWNhc2UgJ0MnOg0K
KwkJCQlwKys7DQorCQkJCS8qIHRoaXMgZmxhZ3MgYWxzbyBpbXBsaWVzIHRoZSANCisJCQkJICAg
b3Blbi1iaW5hcnkgZmxhZyAqLw0KKwkJCQllLT5mbGFncyB8PSAoTUlTQ19GTVRfQ1JFREVOVElB
TFMgfA0KKwkJCQkJCU1JU0NfRk1UX09QRU5fQklOQVJZKTsNCisJCQkJYnJlYWs7DQogCQkJZGVm
YXVsdDoNCiAJCQkJY29udCA9IDA7DQogCQl9DQpAQCAtNDUyLDYgKzQ3Miw5IEBAIHN0YXRpYyB2
b2lkIGVudHJ5X3N0YXR1cyhOb2RlICplLCBjaGFyICoNCiAJaWYgKGUtPmZsYWdzICYgTUlTQ19G
TVRfT1BFTl9CSU5BUlkpIHsNCiAJCSpkcCArKyA9ICdPJzsNCiAJfQ0KKwlpZiAoZS0+ZmxhZ3Mg
JiBNSVNDX0ZNVF9DUkVERU5USUFMUykgew0KKwkJKmRwICsrID0gJ0MnOw0KKwl9DQogCSpkcCAr
KyA9ICdcbic7DQogDQogDQo=

------_=_NextPart_001_01C3F19A.3C48678B--
