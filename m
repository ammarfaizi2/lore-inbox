Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUIZWsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUIZWsu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 18:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264704AbUIZWsu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 18:48:50 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.77]:30895 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S264668AbUIZWse
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 18:48:34 -0400
Subject: [PATCH 2.6.9-rc2-mm2] Select cpio_list or source directory for
	initramfs image [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: azarah@nosferatu.za.org
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0U+NdQd8YaUJnjKRfa/X"
Date: Mon, 27 Sep 2004 00:47:46 +0200
Message-Id: <1096238866.11535.40.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-0U+NdQd8YaUJnjKRfa/X
Content-Type: multipart/mixed; boundary="=-hmjlkmA9r5TQI2bIU/mm"


--=-hmjlkmA9r5TQI2bIU/mm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Attached is a patch that adds CONFIG_INITRAMFS_SOURCE, enabling you to
either specify a file as cpio_list, or a directory to generate a list
from.  It depreciate the INITRAMFS_LIST environment variable introduced
not long ago.

There are some issues (suggestions/patches welcome) that I am not
sure about:
1) I put the menu entry under block devices, but I am not sure if
   this is the correct location?
2) There might be a better (or more correct) way to do this with
   kbuild?
3) Variable names and especially help text needs some love.
4) I am not sure if I am duplicating work in progress?

I did add an inline version of the patch, but the new evo 2.0 is
brain dead again concerning patches (yes, even with 'preformat'),
so I attached it as well.  Also, I have not signed it off, as this is
more for review/comments.

Comments will be appreciated.


-----
diff -urpN -X dontdiff linux-2.6.9-rc2-mm2/drivers/block/Kconfig linux-2.6.=
9-rc2-mm2.az/drivers/block/Kconfig
--- linux-2.6.9-rc2-mm2/drivers/block/Kconfig   2004-09-24 02:20:02.0000000=
00 +0200
+++ linux-2.6.9-rc2-mm2.az/drivers/block/Kconfig        2004-09-27 00:08:01=
.970645528 +0200
@@ -348,6 +348,32 @@ config BLK_DEV_INITRD
          "real" root file system, etc. See <file:Documentation/initrd.txt>
          for details.

+config INITRAMFS_SOURCE
+       string "Source directory of cpio_list"
+       default ""
+       help
+         This can be set to either a directory containing files, etc to be
+         included in the initramfs archive, or a file containing newline
+         separated entries.
+
+         If it is a file, it should be in the following format:
+           # a comment
+           file <name> <location> <mode> <uid> <gid>
+           dir <name> <mode> <uid> <gid>
+           nod <name> <mode> <uid> <gid> <dev_type> <maj> <min>
+
+         Where:
+           <name>      name of the file/dir/nod in the archive
+           <location>  location of the file in the current filesystem
+           <mode>      mode/permissions of the file
+           <uid>       user id (0=3Droot)
+           <gid>       group id (0=3Droot)
+           <dev_type>  device type (b=3Dblock, c=3Dcharacter)
+           <maj>       major number of nod
+           <min>       minor number of nod
+
+       If you are not sure, leave it blank.
+
 config LBD
        bool "Support for Large Block Devices"
        depends on X86 || MIPS32 || PPC32 || ARCH_S390_31 || SUPERH
diff -urpN -X dontdiff linux-2.6.9-rc2-mm2/scripts/gen_initramfs_list.sh li=
nux-2.6.9-rc2-mm2.az/scripts/gen_initramfs_list.sh
--- linux-2.6.9-rc2-mm2/scripts/gen_initramfs_list.sh   1970-01-01 02:00:00=
.000000000 +0200
+++ linux-2.6.9-rc2-mm2.az/scripts/gen_initramfs_list.sh        2004-09-26 =
22:56:09.881182768 +0200
@@ -0,0 +1,84 @@
+#!/bin/bash
+# Copyright (C) Martin Schlemmer <azarah@nosferatu.za.org>
+# Released under the terms of the GNU GPL
+#
+# A script to generate newline separated entries (to stdout) from a direct=
ory's
+# contents suitable for use as a cpio_list for gen_init_cpio.
+#
+# Arguements: $1 -- the source directory
+#
+# TODO:  Add support for symlinks, sockets and pipes when gen_init_cpio
+#        supports them.
+
+usage() {
+       echo "Usage: $0 initramfs-source-dir"
+       exit 1
+}
+
+srcdir=3D$(echo "$1" | sed -e 's://*:/:g')
+
+if [ "$#" -gt 1 -o ! -d "${srcdir}" ]; then
+       usage
+fi
+
+filetype() {
+       local argv1=3D"$1"
+
+       if [ -f "${argv1}" ]; then
+               echo "file"
+       elif [ -d "${argv1}" ]; then
+               echo "dir"
+       elif [ -b "${argv1}" -o -c "${argv1}" ]; then
+               echo "nod"
+       else
+               echo "invalid"
+       fi
+       return 0
+}
+
+parse() {
+       local location=3D"$1"
+       local name=3D"${location/${srcdir}//}"
+       local mode=3D"$2"
+       local uid=3D"$3"
+       local gid=3D"$4"
+       local ftype=3D$(filetype "${location}")
+       local str=3D"${mode} ${uid} ${gid}"
+
+       [ "${ftype}" =3D=3D "invalid" ] && return 0
+       [ "${location}" =3D=3D "${srcdir}" ] && return 0
+
+       case "${ftype}" in
+               "file")
+                       str=3D"${ftype} ${name} ${location} ${str}"
+                       ;;
+               "nod")
+                       local dev_type=3D
+                       local maj=3D$(LC_ALL=3DC ls -l "${location}" | \
+                                       gawk '{sub(/,/, "", $5); print $5}'=
)
+                       local min=3D$(LC_ALL=3DC ls -l "${location}" | \
+                                       gawk '{print $6}')
+
+                       if [ -b "${location}" ]; then
+                               dev_type=3D"b"
+                       else
+                               dev_type=3D"c"
+                       fi
+                       str=3D"${ftype} ${name} ${str} ${dev_type} ${maj} $=
{min}"
+                       ;;
+               *)
+                       str=3D"${ftype} ${name} ${str}"
+                       ;;
+       esac
+
+       echo "${str}"
+
+       return 0
+}
+
+find "${srcdir}" -printf "%p %m %U %G\n" | \
+while read x; do
+       parse ${x}
+done
+
+exit 0
diff -urpN -X dontdiff linux-2.6.9-rc2-mm2/usr/Makefile linux-2.6.9-rc2-mm2=
.az/usr/Makefile
--- linux-2.6.9-rc2-mm2/usr/Makefile    2004-09-26 23:04:47.648470176 +0200
+++ linux-2.6.9-rc2-mm2.az/usr/Makefile 2004-09-27 00:00:54.733595432 +0200
@@ -8,7 +8,7 @@ clean-files :=3D initramfs_data.cpio.gz
 # If you want a different list of files in the initramfs_data.cpio
 # then you can either overwrite the cpio_list in this directory
 # or set INITRAMFS_LIST to another filename.
-INITRAMFS_LIST ?=3D $(obj)/initramfs_list
+INITRAMFS_LIST :=3D $(obj)/initramfs_list

 # initramfs_data.o contains the initramfs_data.cpio.gz image.
 # The image is included using .incbin, a dependency which is not
@@ -23,6 +23,24 @@ $(obj)/initramfs_data.o: $(obj)/initramf
 # Commented out for now
 # initramfs-y :=3D $(obj)/root/hello

+quiet_cmd_gen_list =3D GEN_INITRAMFS_LIST $@
+      cmd_gen_list =3D $(shell \
+        if test -f $(CONFIG_INITRAMFS_SOURCE); then \
+         if [ $(CONFIG_INITRAMFS_SOURCE) !=3D $@ ]; then \
+           echo 'cp -f $(CONFIG_INITRAMFS_SOURCE) $@'; \
+         else \
+           echo 'echo Using shipped $@'; \
+         fi; \
+       elif test -d $(CONFIG_INITRAMFS_SOURCE); then \
+         echo 'scripts/gen_initramfs_list.sh $(CONFIG_INITRAMFS_SOURCE) > =
$@'; \
+       else \
+         echo 'echo Using shipped $@'; \
+       fi)
+
+
+$(INITRAMFS_LIST): FORCE
+       $(call cmd,gen_list)
+
 quiet_cmd_cpio =3D CPIO    $@
       cmd_cpio =3D ./$< $(INITRAMFS_LIST) > $@



Regards,

--=20
Martin Schlemmer

--=-hmjlkmA9r5TQI2bIU/mm
Content-Disposition: attachment; filename=initramfs-source.patch
Content-Type: text/x-patch; name=initramfs-source.patch; charset=ISO-8859-15
Content-Transfer-Encoding: base64

ZGlmZiAtdXJwTiAtWCBkb250ZGlmZiBsaW51eC0yLjYuOS1yYzItbW0yL2RyaXZlcnMvYmxvY2sv
S2NvbmZpZyBsaW51eC0yLjYuOS1yYzItbW0yLmF6L2RyaXZlcnMvYmxvY2svS2NvbmZpZw0KLS0t
IGxpbnV4LTIuNi45LXJjMi1tbTIvZHJpdmVycy9ibG9jay9LY29uZmlnCTIwMDQtMDktMjQgMDI6
MjA6MDIuMDAwMDAwMDAwICswMjAwDQorKysgbGludXgtMi42LjktcmMyLW1tMi5hei9kcml2ZXJz
L2Jsb2NrL0tjb25maWcJMjAwNC0wOS0yNyAwMDowODowMS45NzA2NDU1MjggKzAyMDANCkBAIC0z
NDgsNiArMzQ4LDMyIEBAIGNvbmZpZyBCTEtfREVWX0lOSVRSRA0KIAkgICJyZWFsIiByb290IGZp
bGUgc3lzdGVtLCBldGMuIFNlZSA8ZmlsZTpEb2N1bWVudGF0aW9uL2luaXRyZC50eHQ+DQogCSAg
Zm9yIGRldGFpbHMuDQogDQorY29uZmlnIElOSVRSQU1GU19TT1VSQ0UNCisJc3RyaW5nICJTb3Vy
Y2UgZGlyZWN0b3J5IG9mIGNwaW9fbGlzdCINCisJZGVmYXVsdCAiIg0KKwloZWxwDQorCSAgVGhp
cyBjYW4gYmUgc2V0IHRvIGVpdGhlciBhIGRpcmVjdG9yeSBjb250YWluaW5nIGZpbGVzLCBldGMg
dG8gYmUNCisJICBpbmNsdWRlZCBpbiB0aGUgaW5pdHJhbWZzIGFyY2hpdmUsIG9yIGEgZmlsZSBj
b250YWluaW5nIG5ld2xpbmUNCisJICBzZXBhcmF0ZWQgZW50cmllcy4NCisNCisJICBJZiBpdCBp
cyBhIGZpbGUsIGl0IHNob3VsZCBiZSBpbiB0aGUgZm9sbG93aW5nIGZvcm1hdDoNCisJICAgICMg
YSBjb21tZW50DQorCSAgICBmaWxlIDxuYW1lPiA8bG9jYXRpb24+IDxtb2RlPiA8dWlkPiA8Z2lk
Pg0KKwkgICAgZGlyIDxuYW1lPiA8bW9kZT4gPHVpZD4gPGdpZD4NCisJICAgIG5vZCA8bmFtZT4g
PG1vZGU+IDx1aWQ+IDxnaWQ+IDxkZXZfdHlwZT4gPG1haj4gPG1pbj4NCisNCisJICBXaGVyZToN
CisJICAgIDxuYW1lPiAgICAgIG5hbWUgb2YgdGhlIGZpbGUvZGlyL25vZCBpbiB0aGUgYXJjaGl2
ZQ0KKwkgICAgPGxvY2F0aW9uPiAgbG9jYXRpb24gb2YgdGhlIGZpbGUgaW4gdGhlIGN1cnJlbnQg
ZmlsZXN5c3RlbQ0KKwkgICAgPG1vZGU+ICAgICAgbW9kZS9wZXJtaXNzaW9ucyBvZiB0aGUgZmls
ZQ0KKwkgICAgPHVpZD4gICAgICAgdXNlciBpZCAoMD1yb290KQ0KKwkgICAgPGdpZD4gICAgICAg
Z3JvdXAgaWQgKDA9cm9vdCkNCisJICAgIDxkZXZfdHlwZT4gIGRldmljZSB0eXBlIChiPWJsb2Nr
LCBjPWNoYXJhY3RlcikNCisJICAgIDxtYWo+ICAgICAgIG1ham9yIG51bWJlciBvZiBub2QNCisJ
ICAgIDxtaW4+ICAgICAgIG1pbm9yIG51bWJlciBvZiBub2QNCisNCisJSWYgeW91IGFyZSBub3Qg
c3VyZSwgbGVhdmUgaXQgYmxhbmsuDQorDQogY29uZmlnIExCRA0KIAlib29sICJTdXBwb3J0IGZv
ciBMYXJnZSBCbG9jayBEZXZpY2VzIg0KIAlkZXBlbmRzIG9uIFg4NiB8fCBNSVBTMzIgfHwgUFBD
MzIgfHwgQVJDSF9TMzkwXzMxIHx8IFNVUEVSSA0KZGlmZiAtdXJwTiAtWCBkb250ZGlmZiBsaW51
eC0yLjYuOS1yYzItbW0yL3NjcmlwdHMvZ2VuX2luaXRyYW1mc19saXN0LnNoIGxpbnV4LTIuNi45
LXJjMi1tbTIuYXovc2NyaXB0cy9nZW5faW5pdHJhbWZzX2xpc3Quc2gNCi0tLSBsaW51eC0yLjYu
OS1yYzItbW0yL3NjcmlwdHMvZ2VuX2luaXRyYW1mc19saXN0LnNoCTE5NzAtMDEtMDEgMDI6MDA6
MDAuMDAwMDAwMDAwICswMjAwDQorKysgbGludXgtMi42LjktcmMyLW1tMi5hei9zY3JpcHRzL2dl
bl9pbml0cmFtZnNfbGlzdC5zaAkyMDA0LTA5LTI2IDIyOjU2OjA5Ljg4MTE4Mjc2OCArMDIwMA0K
QEAgLTAsMCArMSw4NCBAQA0KKyMhL2Jpbi9iYXNoDQorIyBDb3B5cmlnaHQgKEMpIE1hcnRpbiBT
Y2hsZW1tZXIgPGF6YXJhaEBub3NmZXJhdHUuemEub3JnPg0KKyMgUmVsZWFzZWQgdW5kZXIgdGhl
IHRlcm1zIG9mIHRoZSBHTlUgR1BMDQorIw0KKyMgQSBzY3JpcHQgdG8gZ2VuZXJhdGUgbmV3bGlu
ZSBzZXBhcmF0ZWQgZW50cmllcyAodG8gc3Rkb3V0KSBmcm9tIGEgZGlyZWN0b3J5J3MNCisjIGNv
bnRlbnRzIHN1aXRhYmxlIGZvciB1c2UgYXMgYSBjcGlvX2xpc3QgZm9yIGdlbl9pbml0X2NwaW8u
DQorIw0KKyMgQXJndWVtZW50czogJDEgLS0gdGhlIHNvdXJjZSBkaXJlY3RvcnkNCisjDQorIyBU
T0RPOiAgQWRkIHN1cHBvcnQgZm9yIHN5bWxpbmtzLCBzb2NrZXRzIGFuZCBwaXBlcyB3aGVuIGdl
bl9pbml0X2NwaW8NCisjICAgICAgICBzdXBwb3J0cyB0aGVtLg0KKw0KK3VzYWdlKCkgew0KKwll
Y2hvICJVc2FnZTogJDAgaW5pdHJhbWZzLXNvdXJjZS1kaXIiDQorCWV4aXQgMQ0KK30NCisNCitz
cmNkaXI9JChlY2hvICIkMSIgfCBzZWQgLWUgJ3M6Ly8qOi86ZycpDQorDQoraWYgWyAiJCMiIC1n
dCAxIC1vICEgLWQgIiR7c3JjZGlyfSIgXTsgdGhlbg0KKwl1c2FnZQ0KK2ZpDQorDQorZmlsZXR5
cGUoKSB7DQorCWxvY2FsIGFyZ3YxPSIkMSINCisNCisJaWYgWyAtZiAiJHthcmd2MX0iIF07IHRo
ZW4NCisJCWVjaG8gImZpbGUiDQorCWVsaWYgWyAtZCAiJHthcmd2MX0iIF07IHRoZW4NCisJCWVj
aG8gImRpciINCisJZWxpZiBbIC1iICIke2FyZ3YxfSIgLW8gLWMgIiR7YXJndjF9IiBdOyB0aGVu
DQorCQllY2hvICJub2QiDQorCWVsc2UNCisJCWVjaG8gImludmFsaWQiDQorCWZpDQorCXJldHVy
biAwDQorfQ0KKw0KK3BhcnNlKCkgew0KKwlsb2NhbCBsb2NhdGlvbj0iJDEiDQorCWxvY2FsIG5h
bWU9IiR7bG9jYXRpb24vJHtzcmNkaXJ9Ly99Ig0KKwlsb2NhbCBtb2RlPSIkMiINCisJbG9jYWwg
dWlkPSIkMyINCisJbG9jYWwgZ2lkPSIkNCINCisJbG9jYWwgZnR5cGU9JChmaWxldHlwZSAiJHts
b2NhdGlvbn0iKQ0KKwlsb2NhbCBzdHI9IiR7bW9kZX0gJHt1aWR9ICR7Z2lkfSINCisNCisJWyAi
JHtmdHlwZX0iID09ICJpbnZhbGlkIiBdICYmIHJldHVybiAwDQorCVsgIiR7bG9jYXRpb259IiA9
PSAiJHtzcmNkaXJ9IiBdICYmIHJldHVybiAwDQorDQorCWNhc2UgIiR7ZnR5cGV9IiBpbg0KKwkJ
ImZpbGUiKQ0KKwkJCXN0cj0iJHtmdHlwZX0gJHtuYW1lfSAke2xvY2F0aW9ufSAke3N0cn0iDQor
CQkJOzsNCisJCSJub2QiKQ0KKwkJCWxvY2FsIGRldl90eXBlPQ0KKwkJCWxvY2FsIG1haj0kKExD
X0FMTD1DIGxzIC1sICIke2xvY2F0aW9ufSIgfCBcDQorCQkJCQlnYXdrICd7c3ViKC8sLywgIiIs
ICQ1KTsgcHJpbnQgJDV9JykNCisJCQlsb2NhbCBtaW49JChMQ19BTEw9QyBscyAtbCAiJHtsb2Nh
dGlvbn0iIHwgXA0KKwkJCQkJZ2F3ayAne3ByaW50ICQ2fScpDQorCQkJDQorCQkJaWYgWyAtYiAi
JHtsb2NhdGlvbn0iIF07IHRoZW4NCisJCQkJZGV2X3R5cGU9ImIiDQorCQkJZWxzZQ0KKwkJCQlk
ZXZfdHlwZT0iYyINCisJCQlmaQ0KKwkJCXN0cj0iJHtmdHlwZX0gJHtuYW1lfSAke3N0cn0gJHtk
ZXZfdHlwZX0gJHttYWp9ICR7bWlufSINCisJCQk7Ow0KKwkJKikNCisJCQlzdHI9IiR7ZnR5cGV9
ICR7bmFtZX0gJHtzdHJ9Ig0KKwkJCTs7DQorCWVzYWMNCisNCisJZWNobyAiJHtzdHJ9Ig0KKw0K
KwlyZXR1cm4gMA0KK30NCisNCitmaW5kICIke3NyY2Rpcn0iIC1wcmludGYgIiVwICVtICVVICVH
XG4iIHwgXA0KK3doaWxlIHJlYWQgeDsgZG8NCisJcGFyc2UgJHt4fQ0KK2RvbmUNCisNCitleGl0
IDANCmRpZmYgLXVycE4gLVggZG9udGRpZmYgbGludXgtMi42LjktcmMyLW1tMi91c3IvTWFrZWZp
bGUgbGludXgtMi42LjktcmMyLW1tMi5hei91c3IvTWFrZWZpbGUNCi0tLSBsaW51eC0yLjYuOS1y
YzItbW0yL3Vzci9NYWtlZmlsZQkyMDA0LTA5LTI2IDIzOjA0OjQ3LjY0ODQ3MDE3NiArMDIwMA0K
KysrIGxpbnV4LTIuNi45LXJjMi1tbTIuYXovdXNyL01ha2VmaWxlCTIwMDQtMDktMjcgMDA6MDA6
NTQuNzMzNTk1NDMyICswMjAwDQpAQCAtOCw3ICs4LDcgQEAgY2xlYW4tZmlsZXMgOj0gaW5pdHJh
bWZzX2RhdGEuY3Bpby5neg0KICMgSWYgeW91IHdhbnQgYSBkaWZmZXJlbnQgbGlzdCBvZiBmaWxl
cyBpbiB0aGUgaW5pdHJhbWZzX2RhdGEuY3Bpbw0KICMgdGhlbiB5b3UgY2FuIGVpdGhlciBvdmVy
d3JpdGUgdGhlIGNwaW9fbGlzdCBpbiB0aGlzIGRpcmVjdG9yeQ0KICMgb3Igc2V0IElOSVRSQU1G
U19MSVNUIHRvIGFub3RoZXIgZmlsZW5hbWUuDQotSU5JVFJBTUZTX0xJU1QgPz0gJChvYmopL2lu
aXRyYW1mc19saXN0DQorSU5JVFJBTUZTX0xJU1QgOj0gJChvYmopL2luaXRyYW1mc19saXN0DQog
DQogIyBpbml0cmFtZnNfZGF0YS5vIGNvbnRhaW5zIHRoZSBpbml0cmFtZnNfZGF0YS5jcGlvLmd6
IGltYWdlLg0KICMgVGhlIGltYWdlIGlzIGluY2x1ZGVkIHVzaW5nIC5pbmNiaW4sIGEgZGVwZW5k
ZW5jeSB3aGljaCBpcyBub3QNCkBAIC0yMyw2ICsyMywyNCBAQCAkKG9iaikvaW5pdHJhbWZzX2Rh
dGEubzogJChvYmopL2luaXRyYW1mDQogIyBDb21tZW50ZWQgb3V0IGZvciBub3cNCiAjIGluaXRy
YW1mcy15IDo9ICQob2JqKS9yb290L2hlbGxvDQogDQorcXVpZXRfY21kX2dlbl9saXN0ID0gR0VO
X0lOSVRSQU1GU19MSVNUICRADQorICAgICAgY21kX2dlbl9saXN0ID0gJChzaGVsbCBcDQorICAg
ICAgICBpZiB0ZXN0IC1mICQoQ09ORklHX0lOSVRSQU1GU19TT1VSQ0UpOyB0aGVuIFwNCisJICBp
ZiBbICQoQ09ORklHX0lOSVRSQU1GU19TT1VSQ0UpICE9ICRAIF07IHRoZW4gXA0KKwkgICAgZWNo
byAnY3AgLWYgJChDT05GSUdfSU5JVFJBTUZTX1NPVVJDRSkgJEAnOyBcDQorCSAgZWxzZSBcDQor
CSAgICBlY2hvICdlY2hvIFVzaW5nIHNoaXBwZWQgJEAnOyBcDQorCSAgZmk7IFwNCisJZWxpZiB0
ZXN0IC1kICQoQ09ORklHX0lOSVRSQU1GU19TT1VSQ0UpOyB0aGVuIFwNCisJICBlY2hvICdzY3Jp
cHRzL2dlbl9pbml0cmFtZnNfbGlzdC5zaCAkKENPTkZJR19JTklUUkFNRlNfU09VUkNFKSA+ICRA
JzsgXA0KKwllbHNlIFwNCisJICBlY2hvICdlY2hvIFVzaW5nIHNoaXBwZWQgJEAnOyBcDQorCWZp
KQ0KKwkNCisNCiskKElOSVRSQU1GU19MSVNUKTogRk9SQ0UNCisJJChjYWxsIGNtZCxnZW5fbGlz
dCkNCisNCiBxdWlldF9jbWRfY3BpbyA9IENQSU8gICAgJEANCiAgICAgICBjbWRfY3BpbyA9IC4v
JDwgJChJTklUUkFNRlNfTElTVCkgPiAkQA0KIA0K


--=-hmjlkmA9r5TQI2bIU/mm--

--=-0U+NdQd8YaUJnjKRfa/X
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBV0cSqburzKaJYLYRAg/ZAKCBE94YyYgP8WtuhRQSXquqjD55VwCfcEWN
unDh/tBlG8hvWK9JfF6qjVc=
=ZIsz
-----END PGP SIGNATURE-----

--=-0U+NdQd8YaUJnjKRfa/X--

