Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269227AbUJQRc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269227AbUJQRc2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 13:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269133AbUJQRc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 13:32:28 -0400
Received: from ctb-mesg5.saix.net ([196.25.240.77]:17053 "EHLO
	ctb-mesg5.saix.net") by vger.kernel.org with ESMTP id S269237AbUJQR3d
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 13:29:33 -0400
Subject: Re: 2.6.9-rc4-mm1: initramfs build fix [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Martin Waitz <tali@admingilde.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20041017161554.GD10532@admingilde.org>
References: <20041011032502.299dc88d.akpm@osdl.org>
	 <20041017161554.GD10532@admingilde.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-l1hxyU5QGzRGHATD7gI4"
Date: Sun, 17 Oct 2004 19:29:07 +0200
Message-Id: <1098034147.879.21.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-l1hxyU5QGzRGHATD7gI4
Content-Type: multipart/mixed; boundary="=-hqMzTNSCd0Ym/qs6hbbs"


--=-hqMzTNSCd0Ym/qs6hbbs
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-10-17 at 18:15 +0200, Martin Waitz wrote:
> hi :)
>=20
> CONFIG_INITRAMFS_SOURCE may be empty which confuses 'test'.
> So we have to quote it properly.
>=20
> Signed-off-by: Martin Waitz <tali@admingilde.org>
>=20
> Index: linux-2.6/usr/Makefile
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/usr/Makefile	2004-10-17 16:06:58.430886734 +0200
> +++ linux-2.6/usr/Makefile	2004-10-17 16:07:56.185444167 +0200
> @@ -25,14 +25,14 @@
> =20
>  quiet_cmd_gen_list =3D GEN_INITRAMFS_LIST $@
>        cmd_gen_list =3D $(shell \
> -        if test -f $(CONFIG_INITRAMFS_SOURCE); then \
> -	  if [ $(CONFIG_INITRAMFS_SOURCE) !=3D $@ ]; then \
> -	    echo 'cp -f $(CONFIG_INITRAMFS_SOURCE) $@'; \
> +        if test -f "$(CONFIG_INITRAMFS_SOURCE)"; then \
> +	  if [ "$(CONFIG_INITRAMFS_SOURCE)" !=3D $@ ]; then \
> +	    echo 'cp -f "$(CONFIG_INITRAMFS_SOURCE)" $@'; \
>  	  else \
>  	    echo 'echo Using shipped $@'; \
>  	  fi; \
> -	elif test -d $(CONFIG_INITRAMFS_SOURCE); then \
> -	  echo 'scripts/gen_initramfs_list.sh $(CONFIG_INITRAMFS_SOURCE) > $@';=
 \
> +	elif test -d "$(CONFIG_INITRAMFS_SOURCE)"; then \
> +	  echo 'scripts/gen_initramfs_list.sh "$(CONFIG_INITRAMFS_SOURCE)" > $@=
'; \
>  	else \
>  	  echo 'echo Using shipped $@'; \
>  	fi)
>=20

kbuild will always (exceptions?) set any string value to "" if empty, or
ask again for a value if just 'CONFIG_FOO=3D' is in .config, and as
'test -f ""' returns 1, this should not be an issue.

I can however see that it might be an good idea to do quoting there, so
here is an updated
select-cpio_list-or-source-directory-for-initramfs-image.patch (the
third one - and hopefully last - today, Andrew).


Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>

diff -urpN linux-2.6.9-rc4-mm1.orig/drivers/block/Kconfig linux-2.6.9-rc4-m=
m1/drivers/block/Kconfig
--- linux-2.6.9-rc4-mm1.orig/drivers/block/Kconfig	2004-10-17 17:00:13.4249=
34520 +0200
+++ linux-2.6.9-rc4-mm1/drivers/block/Kconfig	2004-10-17 16:58:35.451828696=
 +0200
@@ -348,6 +348,32 @@ config BLK_DEV_INITRD
 	  "real" root file system, etc. See <file:Documentation/initrd.txt>
 	  for details.
=20
+config INITRAMFS_SOURCE
+	string "Source directory of cpio_list"
+	default ""
+	help
+	  This can be set to either a directory containing files, etc to be
+	  included in the initramfs archive, or a file containing newline
+	  separated entries.
+
+	  If it is a file, it should be in the following format:
+	    # a comment
+	    file <name> <location> <mode> <uid> <gid>
+	    dir <name> <mode> <uid> <gid>
+	    nod <name> <mode> <uid> <gid> <dev_type> <maj> <min>
+
+	  Where:
+	    <name>      name of the file/dir/nod in the archive
+	    <location>  location of the file in the current filesystem
+	    <mode>      mode/permissions of the file
+	    <uid>       user id (0=3Droot)
+	    <gid>       group id (0=3Droot)
+	    <dev_type>  device type (b=3Dblock, c=3Dcharacter)
+	    <maj>       major number of nod
+	    <min>       minor number of nod
+
+	  If you are not sure, leave it blank.
+
 config LBD
 	bool "Support for Large Block Devices"
 	depends on X86 || MIPS32 || PPC32 || ARCH_S390_31 || SUPERH
diff -urpN linux-2.6.9-rc4-mm1.orig/scripts/gen_initramfs_list.sh linux-2.6=
.9-rc4-mm1/scripts/gen_initramfs_list.sh
--- linux-2.6.9-rc4-mm1.orig/scripts/gen_initramfs_list.sh	1970-01-01 02:00=
:00.000000000 +0200
+++ linux-2.6.9-rc4-mm1/scripts/gen_initramfs_list.sh	2004-10-17 16:58:28.9=
39818672 +0200
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
+	echo "Usage: $0 initramfs-source-dir"
+	exit 1
+}
+
+srcdir=3D$(echo "$1" | sed -e 's://*:/:g')
+
+if [ "$#" -gt 1 -o ! -d "${srcdir}" ]; then
+	usage
+fi
+
+filetype() {
+	local argv1=3D"$1"
+
+	if [ -f "${argv1}" ]; then
+		echo "file"
+	elif [ -d "${argv1}" ]; then
+		echo "dir"
+	elif [ -b "${argv1}" -o -c "${argv1}" ]; then
+		echo "nod"
+	else
+		echo "invalid"
+	fi
+	return 0
+}
+
+parse() {
+	local location=3D"$1"
+	local name=3D"${location/${srcdir}//}"
+	local mode=3D"$2"
+	local uid=3D"$3"
+	local gid=3D"$4"
+	local ftype=3D$(filetype "${location}")
+	local str=3D"${mode} ${uid} ${gid}"
+
+	[ "${ftype}" =3D=3D "invalid" ] && return 0
+	[ "${location}" =3D=3D "${srcdir}" ] && return 0
+
+	case "${ftype}" in
+		"file")
+			str=3D"${ftype} ${name} ${location} ${str}"
+			;;
+		"nod")
+			local dev_type=3D
+			local maj=3D$(LC_ALL=3DC ls -l "${location}" | \
+					gawk '{sub(/,/, "", $5); print $5}')
+			local min=3D$(LC_ALL=3DC ls -l "${location}" | \
+					gawk '{print $6}')
+
+			if [ -b "${location}" ]; then
+				dev_type=3D"b"
+			else
+				dev_type=3D"c"
+			fi
+			str=3D"${ftype} ${name} ${str} ${dev_type} ${maj} ${min}"
+			;;
+		*)
+			str=3D"${ftype} ${name} ${str}"
+			;;
+	esac
+
+	echo "${str}"
+
+	return 0
+}
+
+find "${srcdir}" -printf "%p %m %U %G\n" | \
+while read x; do
+	parse ${x}
+done
+
+exit 0
diff -urpN linux-2.6.9-rc4-mm1.orig/usr/Makefile linux-2.6.9-rc4-mm1/usr/Ma=
kefile
--- linux-2.6.9-rc4-mm1.orig/usr/Makefile	2004-10-17 17:00:13.433933152 +02=
00
+++ linux-2.6.9-rc4-mm1/usr/Makefile	2004-10-17 16:59:56.040577344 +0200
@@ -8,7 +8,7 @@ clean-files :=3D initramfs_data.cpio.gz
 # If you want a different list of files in the initramfs_data.cpio
 # then you can either overwrite the cpio_list in this directory
 # or set INITRAMFS_LIST to another filename.
-INITRAMFS_LIST ?=3D $(obj)/initramfs_list
+INITRAMFS_LIST :=3D $(obj)/initramfs_list
=20
 # initramfs_data.o contains the initramfs_data.cpio.gz image.
 # The image is included using .incbin, a dependency which is not
@@ -23,6 +23,23 @@ $(obj)/initramfs_data.o: $(obj)/initramf
 # Commented out for now
 # initramfs-y :=3D $(obj)/root/hello
=20
+quiet_cmd_gen_list =3D GEN_INITRAMFS_LIST $@
+      cmd_gen_list =3D $(shell \
+        if test -f "$(CONFIG_INITRAMFS_SOURCE)"; then \
+	  if [ "$(CONFIG_INITRAMFS_SOURCE)" !=3D $@ ]; then \
+	    echo 'cp -f "$(CONFIG_INITRAMFS_SOURCE)" $@'; \
+	  else \
+	    echo 'cp -f "$(srctree)/$(INITRAMFS_LIST).shipped" $@'; \
+	  fi; \
+	elif test -d "$(CONFIG_INITRAMFS_SOURCE)"; then \
+	  echo 'scripts/gen_initramfs_list.sh "$(CONFIG_INITRAMFS_SOURCE)" > $@';=
 \
+	else \
+	  echo 'cp -f "$(srctree)/$(INITRAMFS_LIST).shipped" $@'; \
+	fi)
+
+$(INITRAMFS_LIST): FORCE
+	$(call cmd,gen_list)
+
 quiet_cmd_cpio =3D CPIO    $@
       cmd_cpio =3D ./$< $(INITRAMFS_LIST) > $@
=20
diff -urpN linux-2.6.9-rc4-mm1.orig/usr/initramfs_list linux-2.6.9-rc4-mm1/=
usr/initramfs_list
--- linux-2.6.9-rc4-mm1.orig/usr/initramfs_list	2004-10-17 16:48:14.2622638=
64 +0200
+++ linux-2.6.9-rc4-mm1/usr/initramfs_list	1970-01-01 02:00:00.000000000 +0=
200
@@ -1,5 +0,0 @@
-# This is a very simple initramfs - mostly preliminary for future expansio=
n
-
-dir /dev 0755 0 0
-nod /dev/console 0600 0 0 c 5 1
-dir /root 0700 0 0
diff -urpN linux-2.6.9-rc4-mm1.orig/usr/initramfs_list.shipped linux-2.6.9-=
rc4-mm1/usr/initramfs_list.shipped
--- linux-2.6.9-rc4-mm1.orig/usr/initramfs_list.shipped	1970-01-01 02:00:00=
.000000000 +0200
+++ linux-2.6.9-rc4-mm1/usr/initramfs_list.shipped	2004-10-17 16:28:57.6670=
93056 +0200
@@ -0,0 +1,5 @@
+# This is a very simple initramfs - mostly preliminary for future expansio=
n
+
+dir /dev 0755 0 0
+nod /dev/console 0600 0 0 c 5 1
+dir /root 0700 0 0


--=20
Martin Schlemmer


--=-hqMzTNSCd0Ym/qs6hbbs
Content-Disposition: attachment;
	filename*0=select-cpio_list-or-source-directory-for-initramfs-image-v3.p;
	filename*1=atch
Content-Type: text/x-patch;
	name=select-cpio_list-or-source-directory-for-initramfs-image-v3.patch;
	charset=ISO-8859-15
Content-Transfer-Encoding: base64

ZGlmZiAtdXJwTiBsaW51eC0yLjYuOS1yYzQtbW0xLm9yaWcvZHJpdmVycy9ibG9jay9LY29uZmln
IGxpbnV4LTIuNi45LXJjNC1tbTEvZHJpdmVycy9ibG9jay9LY29uZmlnDQotLS0gbGludXgtMi42
LjktcmM0LW1tMS5vcmlnL2RyaXZlcnMvYmxvY2svS2NvbmZpZwkyMDA0LTEwLTE3IDE3OjAwOjEz
LjQyNDkzNDUyMCArMDIwMA0KKysrIGxpbnV4LTIuNi45LXJjNC1tbTEvZHJpdmVycy9ibG9jay9L
Y29uZmlnCTIwMDQtMTAtMTcgMTY6NTg6MzUuNDUxODI4Njk2ICswMjAwDQpAQCAtMzQ4LDYgKzM0
OCwzMiBAQCBjb25maWcgQkxLX0RFVl9JTklUUkQNCiAJICAicmVhbCIgcm9vdCBmaWxlIHN5c3Rl
bSwgZXRjLiBTZWUgPGZpbGU6RG9jdW1lbnRhdGlvbi9pbml0cmQudHh0Pg0KIAkgIGZvciBkZXRh
aWxzLg0KIA0KK2NvbmZpZyBJTklUUkFNRlNfU09VUkNFDQorCXN0cmluZyAiU291cmNlIGRpcmVj
dG9yeSBvZiBjcGlvX2xpc3QiDQorCWRlZmF1bHQgIiINCisJaGVscA0KKwkgIFRoaXMgY2FuIGJl
IHNldCB0byBlaXRoZXIgYSBkaXJlY3RvcnkgY29udGFpbmluZyBmaWxlcywgZXRjIHRvIGJlDQor
CSAgaW5jbHVkZWQgaW4gdGhlIGluaXRyYW1mcyBhcmNoaXZlLCBvciBhIGZpbGUgY29udGFpbmlu
ZyBuZXdsaW5lDQorCSAgc2VwYXJhdGVkIGVudHJpZXMuDQorDQorCSAgSWYgaXQgaXMgYSBmaWxl
LCBpdCBzaG91bGQgYmUgaW4gdGhlIGZvbGxvd2luZyBmb3JtYXQ6DQorCSAgICAjIGEgY29tbWVu
dA0KKwkgICAgZmlsZSA8bmFtZT4gPGxvY2F0aW9uPiA8bW9kZT4gPHVpZD4gPGdpZD4NCisJICAg
IGRpciA8bmFtZT4gPG1vZGU+IDx1aWQ+IDxnaWQ+DQorCSAgICBub2QgPG5hbWU+IDxtb2RlPiA8
dWlkPiA8Z2lkPiA8ZGV2X3R5cGU+IDxtYWo+IDxtaW4+DQorDQorCSAgV2hlcmU6DQorCSAgICA8
bmFtZT4gICAgICBuYW1lIG9mIHRoZSBmaWxlL2Rpci9ub2QgaW4gdGhlIGFyY2hpdmUNCisJICAg
IDxsb2NhdGlvbj4gIGxvY2F0aW9uIG9mIHRoZSBmaWxlIGluIHRoZSBjdXJyZW50IGZpbGVzeXN0
ZW0NCisJICAgIDxtb2RlPiAgICAgIG1vZGUvcGVybWlzc2lvbnMgb2YgdGhlIGZpbGUNCisJICAg
IDx1aWQ+ICAgICAgIHVzZXIgaWQgKDA9cm9vdCkNCisJICAgIDxnaWQ+ICAgICAgIGdyb3VwIGlk
ICgwPXJvb3QpDQorCSAgICA8ZGV2X3R5cGU+ICBkZXZpY2UgdHlwZSAoYj1ibG9jaywgYz1jaGFy
YWN0ZXIpDQorCSAgICA8bWFqPiAgICAgICBtYWpvciBudW1iZXIgb2Ygbm9kDQorCSAgICA8bWlu
PiAgICAgICBtaW5vciBudW1iZXIgb2Ygbm9kDQorDQorCSAgSWYgeW91IGFyZSBub3Qgc3VyZSwg
bGVhdmUgaXQgYmxhbmsuDQorDQogY29uZmlnIExCRA0KIAlib29sICJTdXBwb3J0IGZvciBMYXJn
ZSBCbG9jayBEZXZpY2VzIg0KIAlkZXBlbmRzIG9uIFg4NiB8fCBNSVBTMzIgfHwgUFBDMzIgfHwg
QVJDSF9TMzkwXzMxIHx8IFNVUEVSSA0KZGlmZiAtdXJwTiBsaW51eC0yLjYuOS1yYzQtbW0xLm9y
aWcvc2NyaXB0cy9nZW5faW5pdHJhbWZzX2xpc3Quc2ggbGludXgtMi42LjktcmM0LW1tMS9zY3Jp
cHRzL2dlbl9pbml0cmFtZnNfbGlzdC5zaA0KLS0tIGxpbnV4LTIuNi45LXJjNC1tbTEub3JpZy9z
Y3JpcHRzL2dlbl9pbml0cmFtZnNfbGlzdC5zaAkxOTcwLTAxLTAxIDAyOjAwOjAwLjAwMDAwMDAw
MCArMDIwMA0KKysrIGxpbnV4LTIuNi45LXJjNC1tbTEvc2NyaXB0cy9nZW5faW5pdHJhbWZzX2xp
c3Quc2gJMjAwNC0xMC0xNyAxNjo1ODoyOC45Mzk4MTg2NzIgKzAyMDANCkBAIC0wLDAgKzEsODQg
QEANCisjIS9iaW4vYmFzaA0KKyMgQ29weXJpZ2h0IChDKSBNYXJ0aW4gU2NobGVtbWVyIDxhemFy
YWhAbm9zZmVyYXR1LnphLm9yZz4NCisjIFJlbGVhc2VkIHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUg
R05VIEdQTA0KKyMNCisjIEEgc2NyaXB0IHRvIGdlbmVyYXRlIG5ld2xpbmUgc2VwYXJhdGVkIGVu
dHJpZXMgKHRvIHN0ZG91dCkgZnJvbSBhIGRpcmVjdG9yeSdzDQorIyBjb250ZW50cyBzdWl0YWJs
ZSBmb3IgdXNlIGFzIGEgY3Bpb19saXN0IGZvciBnZW5faW5pdF9jcGlvLg0KKyMNCisjIEFyZ3Vl
bWVudHM6ICQxIC0tIHRoZSBzb3VyY2UgZGlyZWN0b3J5DQorIw0KKyMgVE9ETzogIEFkZCBzdXBw
b3J0IGZvciBzeW1saW5rcywgc29ja2V0cyBhbmQgcGlwZXMgd2hlbiBnZW5faW5pdF9jcGlvDQor
IyAgICAgICAgc3VwcG9ydHMgdGhlbS4NCisNCit1c2FnZSgpIHsNCisJZWNobyAiVXNhZ2U6ICQw
IGluaXRyYW1mcy1zb3VyY2UtZGlyIg0KKwlleGl0IDENCit9DQorDQorc3JjZGlyPSQoZWNobyAi
JDEiIHwgc2VkIC1lICdzOi8vKjovOmcnKQ0KKw0KK2lmIFsgIiQjIiAtZ3QgMSAtbyAhIC1kICIk
e3NyY2Rpcn0iIF07IHRoZW4NCisJdXNhZ2UNCitmaQ0KKw0KK2ZpbGV0eXBlKCkgew0KKwlsb2Nh
bCBhcmd2MT0iJDEiDQorDQorCWlmIFsgLWYgIiR7YXJndjF9IiBdOyB0aGVuDQorCQllY2hvICJm
aWxlIg0KKwllbGlmIFsgLWQgIiR7YXJndjF9IiBdOyB0aGVuDQorCQllY2hvICJkaXIiDQorCWVs
aWYgWyAtYiAiJHthcmd2MX0iIC1vIC1jICIke2FyZ3YxfSIgXTsgdGhlbg0KKwkJZWNobyAibm9k
Ig0KKwllbHNlDQorCQllY2hvICJpbnZhbGlkIg0KKwlmaQ0KKwlyZXR1cm4gMA0KK30NCisNCitw
YXJzZSgpIHsNCisJbG9jYWwgbG9jYXRpb249IiQxIg0KKwlsb2NhbCBuYW1lPSIke2xvY2F0aW9u
LyR7c3JjZGlyfS8vfSINCisJbG9jYWwgbW9kZT0iJDIiDQorCWxvY2FsIHVpZD0iJDMiDQorCWxv
Y2FsIGdpZD0iJDQiDQorCWxvY2FsIGZ0eXBlPSQoZmlsZXR5cGUgIiR7bG9jYXRpb259IikNCisJ
bG9jYWwgc3RyPSIke21vZGV9ICR7dWlkfSAke2dpZH0iDQorDQorCVsgIiR7ZnR5cGV9IiA9PSAi
aW52YWxpZCIgXSAmJiByZXR1cm4gMA0KKwlbICIke2xvY2F0aW9ufSIgPT0gIiR7c3JjZGlyfSIg
XSAmJiByZXR1cm4gMA0KKw0KKwljYXNlICIke2Z0eXBlfSIgaW4NCisJCSJmaWxlIikNCisJCQlz
dHI9IiR7ZnR5cGV9ICR7bmFtZX0gJHtsb2NhdGlvbn0gJHtzdHJ9Ig0KKwkJCTs7DQorCQkibm9k
IikNCisJCQlsb2NhbCBkZXZfdHlwZT0NCisJCQlsb2NhbCBtYWo9JChMQ19BTEw9QyBscyAtbCAi
JHtsb2NhdGlvbn0iIHwgXA0KKwkJCQkJZ2F3ayAne3N1YigvLC8sICIiLCAkNSk7IHByaW50ICQ1
fScpDQorCQkJbG9jYWwgbWluPSQoTENfQUxMPUMgbHMgLWwgIiR7bG9jYXRpb259IiB8IFwNCisJ
CQkJCWdhd2sgJ3twcmludCAkNn0nKQ0KKw0KKwkJCWlmIFsgLWIgIiR7bG9jYXRpb259IiBdOyB0
aGVuDQorCQkJCWRldl90eXBlPSJiIg0KKwkJCWVsc2UNCisJCQkJZGV2X3R5cGU9ImMiDQorCQkJ
ZmkNCisJCQlzdHI9IiR7ZnR5cGV9ICR7bmFtZX0gJHtzdHJ9ICR7ZGV2X3R5cGV9ICR7bWFqfSAk
e21pbn0iDQorCQkJOzsNCisJCSopDQorCQkJc3RyPSIke2Z0eXBlfSAke25hbWV9ICR7c3RyfSIN
CisJCQk7Ow0KKwllc2FjDQorDQorCWVjaG8gIiR7c3RyfSINCisNCisJcmV0dXJuIDANCit9DQor
DQorZmluZCAiJHtzcmNkaXJ9IiAtcHJpbnRmICIlcCAlbSAlVSAlR1xuIiB8IFwNCit3aGlsZSBy
ZWFkIHg7IGRvDQorCXBhcnNlICR7eH0NCitkb25lDQorDQorZXhpdCAwDQpkaWZmIC11cnBOIGxp
bnV4LTIuNi45LXJjNC1tbTEub3JpZy91c3IvTWFrZWZpbGUgbGludXgtMi42LjktcmM0LW1tMS91
c3IvTWFrZWZpbGUNCi0tLSBsaW51eC0yLjYuOS1yYzQtbW0xLm9yaWcvdXNyL01ha2VmaWxlCTIw
MDQtMTAtMTcgMTc6MDA6MTMuNDMzOTMzMTUyICswMjAwDQorKysgbGludXgtMi42LjktcmM0LW1t
MS91c3IvTWFrZWZpbGUJMjAwNC0xMC0xNyAxNjo1OTo1Ni4wNDA1NzczNDQgKzAyMDANCkBAIC04
LDcgKzgsNyBAQCBjbGVhbi1maWxlcyA6PSBpbml0cmFtZnNfZGF0YS5jcGlvLmd6DQogIyBJZiB5
b3Ugd2FudCBhIGRpZmZlcmVudCBsaXN0IG9mIGZpbGVzIGluIHRoZSBpbml0cmFtZnNfZGF0YS5j
cGlvDQogIyB0aGVuIHlvdSBjYW4gZWl0aGVyIG92ZXJ3cml0ZSB0aGUgY3Bpb19saXN0IGluIHRo
aXMgZGlyZWN0b3J5DQogIyBvciBzZXQgSU5JVFJBTUZTX0xJU1QgdG8gYW5vdGhlciBmaWxlbmFt
ZS4NCi1JTklUUkFNRlNfTElTVCA/PSAkKG9iaikvaW5pdHJhbWZzX2xpc3QNCitJTklUUkFNRlNf
TElTVCA6PSAkKG9iaikvaW5pdHJhbWZzX2xpc3QNCiANCiAjIGluaXRyYW1mc19kYXRhLm8gY29u
dGFpbnMgdGhlIGluaXRyYW1mc19kYXRhLmNwaW8uZ3ogaW1hZ2UuDQogIyBUaGUgaW1hZ2UgaXMg
aW5jbHVkZWQgdXNpbmcgLmluY2JpbiwgYSBkZXBlbmRlbmN5IHdoaWNoIGlzIG5vdA0KQEAgLTIz
LDYgKzIzLDIzIEBAICQob2JqKS9pbml0cmFtZnNfZGF0YS5vOiAkKG9iaikvaW5pdHJhbWYNCiAj
IENvbW1lbnRlZCBvdXQgZm9yIG5vdw0KICMgaW5pdHJhbWZzLXkgOj0gJChvYmopL3Jvb3QvaGVs
bG8NCiANCitxdWlldF9jbWRfZ2VuX2xpc3QgPSBHRU5fSU5JVFJBTUZTX0xJU1QgJEANCisgICAg
ICBjbWRfZ2VuX2xpc3QgPSAkKHNoZWxsIFwNCisgICAgICAgIGlmIHRlc3QgLWYgIiQoQ09ORklH
X0lOSVRSQU1GU19TT1VSQ0UpIjsgdGhlbiBcDQorCSAgaWYgWyAiJChDT05GSUdfSU5JVFJBTUZT
X1NPVVJDRSkiICE9ICRAIF07IHRoZW4gXA0KKwkgICAgZWNobyAnY3AgLWYgIiQoQ09ORklHX0lO
SVRSQU1GU19TT1VSQ0UpIiAkQCc7IFwNCisJICBlbHNlIFwNCisJICAgIGVjaG8gJ2NwIC1mICIk
KHNyY3RyZWUpLyQoSU5JVFJBTUZTX0xJU1QpLnNoaXBwZWQiICRAJzsgXA0KKwkgIGZpOyBcDQor
CWVsaWYgdGVzdCAtZCAiJChDT05GSUdfSU5JVFJBTUZTX1NPVVJDRSkiOyB0aGVuIFwNCisJICBl
Y2hvICdzY3JpcHRzL2dlbl9pbml0cmFtZnNfbGlzdC5zaCAiJChDT05GSUdfSU5JVFJBTUZTX1NP
VVJDRSkiID4gJEAnOyBcDQorCWVsc2UgXA0KKwkgIGVjaG8gJ2NwIC1mICIkKHNyY3RyZWUpLyQo
SU5JVFJBTUZTX0xJU1QpLnNoaXBwZWQiICRAJzsgXA0KKwlmaSkNCisNCiskKElOSVRSQU1GU19M
SVNUKTogRk9SQ0UNCisJJChjYWxsIGNtZCxnZW5fbGlzdCkNCisNCiBxdWlldF9jbWRfY3BpbyA9
IENQSU8gICAgJEANCiAgICAgICBjbWRfY3BpbyA9IC4vJDwgJChJTklUUkFNRlNfTElTVCkgPiAk
QA0KIA0KZGlmZiAtdXJwTiBsaW51eC0yLjYuOS1yYzQtbW0xLm9yaWcvdXNyL2luaXRyYW1mc19s
aXN0IGxpbnV4LTIuNi45LXJjNC1tbTEvdXNyL2luaXRyYW1mc19saXN0DQotLS0gbGludXgtMi42
LjktcmM0LW1tMS5vcmlnL3Vzci9pbml0cmFtZnNfbGlzdAkyMDA0LTEwLTE3IDE2OjQ4OjE0LjI2
MjI2Mzg2NCArMDIwMA0KKysrIGxpbnV4LTIuNi45LXJjNC1tbTEvdXNyL2luaXRyYW1mc19saXN0
CTE5NzAtMDEtMDEgMDI6MDA6MDAuMDAwMDAwMDAwICswMjAwDQpAQCAtMSw1ICswLDAgQEANCi0j
IFRoaXMgaXMgYSB2ZXJ5IHNpbXBsZSBpbml0cmFtZnMgLSBtb3N0bHkgcHJlbGltaW5hcnkgZm9y
IGZ1dHVyZSBleHBhbnNpb24NCi0NCi1kaXIgL2RldiAwNzU1IDAgMA0KLW5vZCAvZGV2L2NvbnNv
bGUgMDYwMCAwIDAgYyA1IDENCi1kaXIgL3Jvb3QgMDcwMCAwIDANCmRpZmYgLXVycE4gbGludXgt
Mi42LjktcmM0LW1tMS5vcmlnL3Vzci9pbml0cmFtZnNfbGlzdC5zaGlwcGVkIGxpbnV4LTIuNi45
LXJjNC1tbTEvdXNyL2luaXRyYW1mc19saXN0LnNoaXBwZWQNCi0tLSBsaW51eC0yLjYuOS1yYzQt
bW0xLm9yaWcvdXNyL2luaXRyYW1mc19saXN0LnNoaXBwZWQJMTk3MC0wMS0wMSAwMjowMDowMC4w
MDAwMDAwMDAgKzAyMDANCisrKyBsaW51eC0yLjYuOS1yYzQtbW0xL3Vzci9pbml0cmFtZnNfbGlz
dC5zaGlwcGVkCTIwMDQtMTAtMTcgMTY6Mjg6NTcuNjY3MDkzMDU2ICswMjAwDQpAQCAtMCwwICsx
LDUgQEANCisjIFRoaXMgaXMgYSB2ZXJ5IHNpbXBsZSBpbml0cmFtZnMgLSBtb3N0bHkgcHJlbGlt
aW5hcnkgZm9yIGZ1dHVyZSBleHBhbnNpb24NCisNCitkaXIgL2RldiAwNzU1IDAgMA0KK25vZCAv
ZGV2L2NvbnNvbGUgMDYwMCAwIDAgYyA1IDENCitkaXIgL3Jvb3QgMDcwMCAwIDANCg==


--=-hqMzTNSCd0Ym/qs6hbbs--

--=-l1hxyU5QGzRGHATD7gI4
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBcqvjqburzKaJYLYRAl9cAJ91xgTCn3i0l1JGfVAzlt03bPtGBgCeOZzt
oW5Yun0gzrIf4O6Dkss/0Z0=
=8Btp
-----END PGP SIGNATURE-----

--=-l1hxyU5QGzRGHATD7gI4--

