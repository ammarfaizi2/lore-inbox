Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265128AbUFWJzC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265128AbUFWJzC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 05:55:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265258AbUFWJzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 05:55:02 -0400
Received: from hermes.iil.intel.com ([192.198.152.99]:58282 "EHLO
	hermes.iil.intel.com") by vger.kernel.org with ESMTP
	id S265128AbUFWJyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 05:54:53 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C45908.1909127D"
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Subject: RE: [PATCH] Handle non-readable binfmt misc executables
Date: Wed, 23 Jun 2004 12:54:38 +0300
Message-ID: <2C83850C013A2540861D03054B478C06041D73D5@hasmsx403.ger.corp.intel.com>
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Handle non-readable binfmt misc executables
thread-index: AcRXmcJeZOZNdaqrR5GRUL8OPhBoTgBbItMg
From: "Zach, Yoav" <yoav.zach@intel.com>
To: "Albert Cahalan" <albert@users.sourceforge.net>
Cc: "linux-kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Zach, Yoav" <yoav.zach@intel.com>
X-OriginalArrivalTime: 23 Jun 2004 09:54:39.0353 (UTC) FILETIME=[195FB690:01C45908]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C45908.1909127D
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

=20

>-----Original Message-----
>From: Albert Cahalan [mailto:albert@users.sourceforge.net]=20
>Sent: Monday, June 21, 2004 14:50
>To: Zach, Yoav
>Cc: Albert Cahalan; linux-kernel mailing list
>Subject: RE: [PATCH] Handle non-readable binfmt misc executables
>

>> Right. It might happen once in a (long) while that
>> 'ps -f' doesn't show the correct command line.=20
>
>So this is a hole in the emulation.
>

You have a point here. The patch below fixes this problem
by passing the open fd via the aux-vector. Argv[1] will
be the full path to the binary regardless of whether the
kernel opened it or not. The patch is against recent mm tree,
thus it needs to be applied on top of two prev patches to
binfmt_misc that are part of this tree.
As my mailer tends to wrap up text, the patch is also attached.


Thanks,
Yoav.



=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 BEGIN PATCH =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=

diff -r -U 3 -p linux-2.6/fs/binfmt_elf.c linux/fs/binfmt_elf.c
--- linux-2.6/fs/binfmt_elf.c	2004-06-23 08:13:28.000000000 +0300
+++ linux/fs/binfmt_elf.c	2004-06-23 12:33:51.075747675 +0300
@@ -202,6 +202,9 @@ create_elf_tables(struct linux_binprm *b
 	if (k_platform) {
 		NEW_AUX_ENT(AT_PLATFORM, (elf_addr_t)(long)u_platform);
 	}
+	if (bprm->interp_flags & BINPRM_FLAGS_EXECFD) {
+		NEW_AUX_ENT(AT_EXECFD, (elf_addr_t) BINPRM_GET_EXECFD
(bprm->interp_flags));
+	}
 #undef NEW_AUX_ENT
 	/* AT_NULL is zero; clear the rest too */
 	memset(&elf_info[ei_index], 0,
diff -r -U 3 -p linux-2.6/fs/binfmt_misc.c linux/fs/binfmt_misc.c
--- linux-2.6/fs/binfmt_misc.c	2004-06-23 08:13:26.000000000 +0300
+++ linux/fs/binfmt_misc.c	2004-06-23 12:33:51.081607003 +0300
@@ -109,7 +109,6 @@ static int load_misc_binary(struct linux
 	char *iname_addr =3D iname;
 	int retval;
 	int fd_binary =3D -1;
-	char fd_str[12];
 	struct files_struct *files =3D NULL;
=20
 	retval =3D -ENOEXEC;
@@ -130,7 +129,6 @@ static int load_misc_binary(struct linux
 	}
=20
 	if (fmt->flags & MISC_FMT_OPEN_BINARY) {
-		char *fdsp =3D fd_str;
=20
 		files =3D current->files;
 		retval =3D unshare_files();
@@ -158,27 +156,27 @@ static int load_misc_binary(struct linux
 		allow_write_access(bprm->file);
 		bprm->file =3D NULL;
=20
-		/* make argv[1] be the file descriptor of the binary */
- 		snprintf(fd_str, sizeof(fd_str), "%d", fd_binary);
- 		retval =3D copy_strings_kernel(1, &fdsp, bprm);
-		if (retval < 0)
-			goto _error;
-		bprm->argc++;
+		/* mark the bprm that fd should be passed to interp */
+		bprm->interp_flags |=3D (BINPRM_FLAGS_EXECFD |=20
+					BINPRM_SET_EXECFD (fd_binary));
=20
  	} else {
  		allow_write_access(bprm->file);
  		fput(bprm->file);
  		bprm->file =3D NULL;
-		/* make argv[1] be the path to the binary */
- 		retval =3D copy_strings_kernel (1, &bprm->interp, bprm);
-		if (retval < 0)
-			goto _error;
-		bprm->argc++;
  	}
+	/* make argv[1] be the path to the binary */
+	retval =3D copy_strings_kernel (1, &bprm->interp, bprm);
+	if (retval < 0)
+		goto _error;
+	bprm->argc++;
+
+	/* add the interp as argv[0] */
 	retval =3D copy_strings_kernel (1, &iname_addr, bprm);
 	if (retval < 0)
 		goto _error;
 	bprm->argc ++;
+
 	bprm->interp =3D iname;	/* for binfmt_script */
=20
 	interp_file =3D open_exec (iname);
diff -r -U 3 -p linux-2.6/include/linux/binfmts.h
linux/include/linux/binfmts.h
--- linux-2.6/include/linux/binfmts.h	2004-06-23 08:14:39.000000000
+0300
+++ linux/include/linux/binfmts.h	2004-06-23 12:33:51.082583557
+0300
@@ -42,6 +42,14 @@ struct linux_binprm{
 #define BINPRM_FLAGS_ENFORCE_NONDUMP_BIT 0
 #define BINPRM_FLAGS_ENFORCE_NONDUMP (1 <<
BINPRM_FLAGS_ENFORCE_NONDUMP_BIT)
=20
+/* fd of the binary should be passed to the interpreter */
+#define BINPRM_FLAGS_EXECFD_BIT 1
+#define BINPRM_FLAGS_EXECFD (1 << BINPRM_FLAGS_ENFORCE_NONDUMP_BIT)
+/* the fd is kept in the high 32 bit of the flags */
+#define BINPRM_GET_EXECFD(flg) (((flg) >> 32) & 0xfffffffful)
+#define BINPRM_SET_EXECFD(fd) (((unsigned long)(fd) << 32) &
0xffffffff00000000ul)
+
+
 /*
  * This structure defines the functions that are used to load the
binary formats that
  * linux accepts.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
 END   PATCH =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=


------_=_NextPart_001_01C45908.1909127D
Content-Type: application/octet-stream;
	name="binfmt_misc-nonreadable-execfd.patch"
Content-Transfer-Encoding: base64
Content-Description: binfmt_misc-nonreadable-execfd.patch
Content-Disposition: attachment;
	filename="binfmt_misc-nonreadable-execfd.patch"

ZGlmZiAtciAtVSAzIC1wIGxpbnV4LTIuNi9mcy9iaW5mbXRfZWxmLmMgbGludXgvZnMvYmluZm10
X2VsZi5jCi0tLSBsaW51eC0yLjYvZnMvYmluZm10X2VsZi5jCTIwMDQtMDYtMjMgMDg6MTM6Mjgu
MDAwMDAwMDAwICswMzAwCisrKyBsaW51eC9mcy9iaW5mbXRfZWxmLmMJMjAwNC0wNi0yMyAxMjoz
Mzo1MS4wNzU3NDc2NzUgKzAzMDAKQEAgLTIwMiw2ICsyMDIsOSBAQCBjcmVhdGVfZWxmX3RhYmxl
cyhzdHJ1Y3QgbGludXhfYmlucHJtICpiCiAJaWYgKGtfcGxhdGZvcm0pIHsKIAkJTkVXX0FVWF9F
TlQoQVRfUExBVEZPUk0sIChlbGZfYWRkcl90KShsb25nKXVfcGxhdGZvcm0pOwogCX0KKwlpZiAo
YnBybS0+aW50ZXJwX2ZsYWdzICYgQklOUFJNX0ZMQUdTX0VYRUNGRCkgeworCQlORVdfQVVYX0VO
VChBVF9FWEVDRkQsIChlbGZfYWRkcl90KSBCSU5QUk1fR0VUX0VYRUNGRCAoYnBybS0+aW50ZXJw
X2ZsYWdzKSk7CisJfQogI3VuZGVmIE5FV19BVVhfRU5UCiAJLyogQVRfTlVMTCBpcyB6ZXJvOyBj
bGVhciB0aGUgcmVzdCB0b28gKi8KIAltZW1zZXQoJmVsZl9pbmZvW2VpX2luZGV4XSwgMCwKZGlm
ZiAtciAtVSAzIC1wIGxpbnV4LTIuNi9mcy9iaW5mbXRfbWlzYy5jIGxpbnV4L2ZzL2JpbmZtdF9t
aXNjLmMKLS0tIGxpbnV4LTIuNi9mcy9iaW5mbXRfbWlzYy5jCTIwMDQtMDYtMjMgMDg6MTM6MjYu
MDAwMDAwMDAwICswMzAwCisrKyBsaW51eC9mcy9iaW5mbXRfbWlzYy5jCTIwMDQtMDYtMjMgMTI6
MzM6NTEuMDgxNjA3MDAzICswMzAwCkBAIC0xMDksNyArMTA5LDYgQEAgc3RhdGljIGludCBsb2Fk
X21pc2NfYmluYXJ5KHN0cnVjdCBsaW51eAogCWNoYXIgKmluYW1lX2FkZHIgPSBpbmFtZTsKIAlp
bnQgcmV0dmFsOwogCWludCBmZF9iaW5hcnkgPSAtMTsKLQljaGFyIGZkX3N0clsxMl07CiAJc3Ry
dWN0IGZpbGVzX3N0cnVjdCAqZmlsZXMgPSBOVUxMOwogCiAJcmV0dmFsID0gLUVOT0VYRUM7CkBA
IC0xMzAsNyArMTI5LDYgQEAgc3RhdGljIGludCBsb2FkX21pc2NfYmluYXJ5KHN0cnVjdCBsaW51
eAogCX0KIAogCWlmIChmbXQtPmZsYWdzICYgTUlTQ19GTVRfT1BFTl9CSU5BUlkpIHsKLQkJY2hh
ciAqZmRzcCA9IGZkX3N0cjsKIAogCQlmaWxlcyA9IGN1cnJlbnQtPmZpbGVzOwogCQlyZXR2YWwg
PSB1bnNoYXJlX2ZpbGVzKCk7CkBAIC0xNTgsMjcgKzE1NiwyNyBAQCBzdGF0aWMgaW50IGxvYWRf
bWlzY19iaW5hcnkoc3RydWN0IGxpbnV4CiAJCWFsbG93X3dyaXRlX2FjY2VzcyhicHJtLT5maWxl
KTsKIAkJYnBybS0+ZmlsZSA9IE5VTEw7CiAKLQkJLyogbWFrZSBhcmd2WzFdIGJlIHRoZSBmaWxl
IGRlc2NyaXB0b3Igb2YgdGhlIGJpbmFyeSAqLwotIAkJc25wcmludGYoZmRfc3RyLCBzaXplb2Yo
ZmRfc3RyKSwgIiVkIiwgZmRfYmluYXJ5KTsKLSAJCXJldHZhbCA9IGNvcHlfc3RyaW5nc19rZXJu
ZWwoMSwgJmZkc3AsIGJwcm0pOwotCQlpZiAocmV0dmFsIDwgMCkKLQkJCWdvdG8gX2Vycm9yOwot
CQlicHJtLT5hcmdjKys7CisJCS8qIG1hcmsgdGhlIGJwcm0gdGhhdCBmZCBzaG91bGQgYmUgcGFz
c2VkIHRvIGludGVycCAqLworCQlicHJtLT5pbnRlcnBfZmxhZ3MgfD0gKEJJTlBSTV9GTEFHU19F
WEVDRkQgfCAKKwkJCQkJQklOUFJNX1NFVF9FWEVDRkQgKGZkX2JpbmFyeSkpOwogCiAgCX0gZWxz
ZSB7CiAgCQlhbGxvd193cml0ZV9hY2Nlc3MoYnBybS0+ZmlsZSk7CiAgCQlmcHV0KGJwcm0tPmZp
bGUpOwogIAkJYnBybS0+ZmlsZSA9IE5VTEw7Ci0JCS8qIG1ha2UgYXJndlsxXSBiZSB0aGUgcGF0
aCB0byB0aGUgYmluYXJ5ICovCi0gCQlyZXR2YWwgPSBjb3B5X3N0cmluZ3Nfa2VybmVsICgxLCAm
YnBybS0+aW50ZXJwLCBicHJtKTsKLQkJaWYgKHJldHZhbCA8IDApCi0JCQlnb3RvIF9lcnJvcjsK
LQkJYnBybS0+YXJnYysrOwogIAl9CisJLyogbWFrZSBhcmd2WzFdIGJlIHRoZSBwYXRoIHRvIHRo
ZSBiaW5hcnkgKi8KKwlyZXR2YWwgPSBjb3B5X3N0cmluZ3Nfa2VybmVsICgxLCAmYnBybS0+aW50
ZXJwLCBicHJtKTsKKwlpZiAocmV0dmFsIDwgMCkKKwkJZ290byBfZXJyb3I7CisJYnBybS0+YXJn
YysrOworCisJLyogYWRkIHRoZSBpbnRlcnAgYXMgYXJndlswXSAqLwogCXJldHZhbCA9IGNvcHlf
c3RyaW5nc19rZXJuZWwgKDEsICZpbmFtZV9hZGRyLCBicHJtKTsKIAlpZiAocmV0dmFsIDwgMCkK
IAkJZ290byBfZXJyb3I7CiAJYnBybS0+YXJnYyArKzsKKwogCWJwcm0tPmludGVycCA9IGluYW1l
OwkvKiBmb3IgYmluZm10X3NjcmlwdCAqLwogCiAJaW50ZXJwX2ZpbGUgPSBvcGVuX2V4ZWMgKGlu
YW1lKTsKZGlmZiAtciAtVSAzIC1wIGxpbnV4LTIuNi9pbmNsdWRlL2xpbnV4L2JpbmZtdHMuaCBs
aW51eC9pbmNsdWRlL2xpbnV4L2JpbmZtdHMuaAotLS0gbGludXgtMi42L2luY2x1ZGUvbGludXgv
YmluZm10cy5oCTIwMDQtMDYtMjMgMDg6MTQ6MzkuMDAwMDAwMDAwICswMzAwCisrKyBsaW51eC9p
bmNsdWRlL2xpbnV4L2JpbmZtdHMuaAkyMDA0LTA2LTIzIDEyOjMzOjUxLjA4MjU4MzU1NyArMDMw
MApAQCAtNDIsNiArNDIsMTQgQEAgc3RydWN0IGxpbnV4X2JpbnBybXsKICNkZWZpbmUgQklOUFJN
X0ZMQUdTX0VORk9SQ0VfTk9ORFVNUF9CSVQgMAogI2RlZmluZSBCSU5QUk1fRkxBR1NfRU5GT1JD
RV9OT05EVU1QICgxIDw8IEJJTlBSTV9GTEFHU19FTkZPUkNFX05PTkRVTVBfQklUKQogCisvKiBm
ZCBvZiB0aGUgYmluYXJ5IHNob3VsZCBiZSBwYXNzZWQgdG8gdGhlIGludGVycHJldGVyICovCisj
ZGVmaW5lIEJJTlBSTV9GTEFHU19FWEVDRkRfQklUIDEKKyNkZWZpbmUgQklOUFJNX0ZMQUdTX0VY
RUNGRCAoMSA8PCBCSU5QUk1fRkxBR1NfRU5GT1JDRV9OT05EVU1QX0JJVCkKKy8qIHRoZSBmZCBp
cyBrZXB0IGluIHRoZSBoaWdoIDMyIGJpdCBvZiB0aGUgZmxhZ3MgKi8KKyNkZWZpbmUgQklOUFJN
X0dFVF9FWEVDRkQoZmxnKSAoKChmbGcpID4+IDMyKSAmIDB4ZmZmZmZmZmZ1bCkKKyNkZWZpbmUg
QklOUFJNX1NFVF9FWEVDRkQoZmQpICgoKHVuc2lnbmVkIGxvbmcpKGZkKSA8PCAzMikgJiAweGZm
ZmZmZmZmMDAwMDAwMDB1bCkKKworCiAvKgogICogVGhpcyBzdHJ1Y3R1cmUgZGVmaW5lcyB0aGUg
ZnVuY3Rpb25zIHRoYXQgYXJlIHVzZWQgdG8gbG9hZCB0aGUgYmluYXJ5IGZvcm1hdHMgdGhhdAog
ICogbGludXggYWNjZXB0cy4K

------_=_NextPart_001_01C45908.1909127D--
