Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269165AbUJQPSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269165AbUJQPSP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 11:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269164AbUJQPSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 11:18:15 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:911 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S269181AbUJQPOi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 11:14:38 -0400
Subject: Re: [PATCH 2.6.9-rc2-mm2] Select cpio_list or source directory for
	initramfs image [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <1096238866.11535.40.camel@nosferatu.lan>
References: <1096238866.11535.40.camel@nosferatu.lan>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Z1Pm7ioq23JmuB9S9MxE"
Date: Sun, 17 Oct 2004 17:14:09 +0200
Message-Id: <1098026049.879.8.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Z1Pm7ioq23JmuB9S9MxE
Content-Type: multipart/mixed; boundary="=-VpVZafLPFfV/KxD3zxHL"


--=-VpVZafLPFfV/KxD3zxHL
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-09-27 at 00:47 +0200, Martin Schlemmer wrote:

Hi,

> Attached is a patch that adds CONFIG_INITRAMFS_SOURCE, enabling you to
> either specify a file as cpio_list, or a directory to generate a list
> from.  It depreciate the INITRAMFS_LIST environment variable introduced
> not long ago.
>=20
> There are some issues (suggestions/patches welcome) that I am not
> sure about:
> 1) I put the menu entry under block devices, but I am not sure if
>    this is the correct location?
> 2) There might be a better (or more correct) way to do this with
>    kbuild?
> 3) Variable names and especially help text needs some love.
> 4) I am not sure if I am duplicating work in progress?
>=20
> I did add an inline version of the patch, but the new evo 2.0 is
> brain dead again concerning patches (yes, even with 'preformat'),
> so I attached it as well.  Also, I have not signed it off, as this is
> more for review/comments.
>=20
> Comments will be appreciated.
>=20

Attached is a patch (also inline, but evo 2.0 seems to not get
'preformat' right anymore) that replaces
select-cpio_list-or-source-directory-for-initramfs-image.patch in
2.6.9-rc4-mm1, including the indentation fix, as well as fix an issue
reported by Esben Nielsen <simlo@phys.au.dk> as proposed by Sam Ravnborg
(Should fix failing to build if $O is set).

I also moved initramfs_list to initramfs_list.shipped, to make sure we
always have an 'fall back' list (say you unset CONFIG_INITRAMFS_SOURCE
and deleted your custom list/directory, then building will not fail).


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
@@ -23,6 +23,25 @@ $(obj)/initramfs_data.o: $(obj)/initramf
 # Commented out for now
 # initramfs-y :=3D $(obj)/root/hello
=20
+quiet_cmd_gen_list =3D GEN_INITRAMFS_LIST $@
+      cmd_gen_list =3D $(shell \
+        if test -f $(CONFIG_INITRAMFS_SOURCE); then \
+	  if [ $(CONFIG_INITRAMFS_SOURCE) !=3D $@ ]; then \
+	    echo 'cp -f $(CONFIG_INITRAMFS_SOURCE) $@'; \
+	  else \
+	    echo 'echo Using shipped $@'; \
+	    echo 'cp -f $(srctree)/$(CONFIG_INITRAMFS_SOURCE).shipped $@'; \
+	  fi; \
+	elif test -d $(CONFIG_INITRAMFS_SOURCE); then \
+	  echo 'scripts/gen_initramfs_list.sh $(CONFIG_INITRAMFS_SOURCE) > $@'; \
+	else \
+	  echo 'echo Using shipped $@'; \
+	  echo 'cp -f $(srctree)/$(CONFIG_INITRAMFS_SOURCE).shipped $@'; \
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




Thanks,

--=20
Martin Schlemmer


--=-VpVZafLPFfV/KxD3zxHL
Content-Disposition: attachment;
	filename*0=select-cpio_list-or-source-directory-for-initramfs-image.patc;
	filename*1=h
Content-Type: text/x-patch;
	name=select-cpio_list-or-source-directory-for-initramfs-image.patch;
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
LDYgKzIzLDI1IEBAICQob2JqKS9pbml0cmFtZnNfZGF0YS5vOiAkKG9iaikvaW5pdHJhbWYNCiAj
IENvbW1lbnRlZCBvdXQgZm9yIG5vdw0KICMgaW5pdHJhbWZzLXkgOj0gJChvYmopL3Jvb3QvaGVs
bG8NCiANCitxdWlldF9jbWRfZ2VuX2xpc3QgPSBHRU5fSU5JVFJBTUZTX0xJU1QgJEANCisgICAg
ICBjbWRfZ2VuX2xpc3QgPSAkKHNoZWxsIFwNCisgICAgICAgIGlmIHRlc3QgLWYgJChDT05GSUdf
SU5JVFJBTUZTX1NPVVJDRSk7IHRoZW4gXA0KKwkgIGlmIFsgJChDT05GSUdfSU5JVFJBTUZTX1NP
VVJDRSkgIT0gJEAgXTsgdGhlbiBcDQorCSAgICBlY2hvICdjcCAtZiAkKENPTkZJR19JTklUUkFN
RlNfU09VUkNFKSAkQCc7IFwNCisJICBlbHNlIFwNCisJICAgIGVjaG8gJ2VjaG8gVXNpbmcgc2hp
cHBlZCAkQCc7IFwNCisJICAgIGVjaG8gJ2NwIC1mICQoc3JjdHJlZSkvJChDT05GSUdfSU5JVFJB
TUZTX1NPVVJDRSkuc2hpcHBlZCAkQCc7IFwNCisJICBmaTsgXA0KKwllbGlmIHRlc3QgLWQgJChD
T05GSUdfSU5JVFJBTUZTX1NPVVJDRSk7IHRoZW4gXA0KKwkgIGVjaG8gJ3NjcmlwdHMvZ2VuX2lu
aXRyYW1mc19saXN0LnNoICQoQ09ORklHX0lOSVRSQU1GU19TT1VSQ0UpID4gJEAnOyBcDQorCWVs
c2UgXA0KKwkgIGVjaG8gJ2VjaG8gVXNpbmcgc2hpcHBlZCAkQCc7IFwNCisJICBlY2hvICdjcCAt
ZiAkKHNyY3RyZWUpLyQoQ09ORklHX0lOSVRSQU1GU19TT1VSQ0UpLnNoaXBwZWQgJEAnOyBcDQor
CWZpKQ0KKw0KKyQoSU5JVFJBTUZTX0xJU1QpOiBGT1JDRQ0KKwkkKGNhbGwgY21kLGdlbl9saXN0
KQ0KKw0KIHF1aWV0X2NtZF9jcGlvID0gQ1BJTyAgICAkQA0KICAgICAgIGNtZF9jcGlvID0gLi8k
PCAkKElOSVRSQU1GU19MSVNUKSA+ICRADQogDQpkaWZmIC11cnBOIGxpbnV4LTIuNi45LXJjNC1t
bTEub3JpZy91c3IvaW5pdHJhbWZzX2xpc3QgbGludXgtMi42LjktcmM0LW1tMS91c3IvaW5pdHJh
bWZzX2xpc3QNCi0tLSBsaW51eC0yLjYuOS1yYzQtbW0xLm9yaWcvdXNyL2luaXRyYW1mc19saXN0
CTIwMDQtMTAtMTcgMTY6NDg6MTQuMjYyMjYzODY0ICswMjAwDQorKysgbGludXgtMi42LjktcmM0
LW1tMS91c3IvaW5pdHJhbWZzX2xpc3QJMTk3MC0wMS0wMSAwMjowMDowMC4wMDAwMDAwMDAgKzAy
MDANCkBAIC0xLDUgKzAsMCBAQA0KLSMgVGhpcyBpcyBhIHZlcnkgc2ltcGxlIGluaXRyYW1mcyAt
IG1vc3RseSBwcmVsaW1pbmFyeSBmb3IgZnV0dXJlIGV4cGFuc2lvbg0KLQ0KLWRpciAvZGV2IDA3
NTUgMCAwDQotbm9kIC9kZXYvY29uc29sZSAwNjAwIDAgMCBjIDUgMQ0KLWRpciAvcm9vdCAwNzAw
IDAgMA0KZGlmZiAtdXJwTiBsaW51eC0yLjYuOS1yYzQtbW0xLm9yaWcvdXNyL2luaXRyYW1mc19s
aXN0LnNoaXBwZWQgbGludXgtMi42LjktcmM0LW1tMS91c3IvaW5pdHJhbWZzX2xpc3Quc2hpcHBl
ZA0KLS0tIGxpbnV4LTIuNi45LXJjNC1tbTEub3JpZy91c3IvaW5pdHJhbWZzX2xpc3Quc2hpcHBl
ZAkxOTcwLTAxLTAxIDAyOjAwOjAwLjAwMDAwMDAwMCArMDIwMA0KKysrIGxpbnV4LTIuNi45LXJj
NC1tbTEvdXNyL2luaXRyYW1mc19saXN0LnNoaXBwZWQJMjAwNC0xMC0xNyAxNjoyODo1Ny42Njcw
OTMwNTYgKzAyMDANCkBAIC0wLDAgKzEsNSBAQA0KKyMgVGhpcyBpcyBhIHZlcnkgc2ltcGxlIGlu
aXRyYW1mcyAtIG1vc3RseSBwcmVsaW1pbmFyeSBmb3IgZnV0dXJlIGV4cGFuc2lvbg0KKw0KK2Rp
ciAvZGV2IDA3NTUgMCAwDQorbm9kIC9kZXYvY29uc29sZSAwNjAwIDAgMCBjIDUgMQ0KK2RpciAv
cm9vdCAwNzAwIDAgMA0K


--=-VpVZafLPFfV/KxD3zxHL--

--=-Z1Pm7ioq23JmuB9S9MxE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBcoxBqburzKaJYLYRApQeAJ9dv24r5m92VU6I19yCs4w0CCeq4wCgjCy4
qrs5khYlCTAXbFEK+/V9H2I=
=0pgy
-----END PGP SIGNATURE-----

--=-Z1Pm7ioq23JmuB9S9MxE--

