Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267588AbUJRTfe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267588AbUJRTfe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbUJRT3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:29:31 -0400
Received: from ctb-mesg6.saix.net ([196.25.240.78]:32901 "EHLO
	ctb-mesg6.saix.net") by vger.kernel.org with ESMTP id S266511AbUJRT0x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:26:53 -0400
Subject: Re: 2.6.9-rc4-mm1: initramfs build fix [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Martin Waitz <tali@admingilde.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1098043929.15115.24.camel@nosferatu.lan>
References: <20041011032502.299dc88d.akpm@osdl.org>
	 <20041017161554.GD10532@admingilde.org>
	 <1098034147.879.21.camel@nosferatu.lan>
	 <20041017213334.GA8214@mars.ravnborg.org>
	 <1098043929.15115.24.camel@nosferatu.lan>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fpxdOoXfcDItz5vPTyUr"
Date: Mon, 18 Oct 2004 21:26:18 +0200
Message-Id: <1098127578.15115.33.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fpxdOoXfcDItz5vPTyUr
Content-Type: multipart/mixed; boundary="=-WtebKmNKCGDLG74UuTOG"


--=-WtebKmNKCGDLG74UuTOG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2004-10-17 at 22:12 +0200, Martin Schlemmer wrote:
> On Sun, 2004-10-17 at 23:33 +0200, Sam Ravnborg wrote:
>=20
> Hiya,
>=20
> >=20
> > Can you submit a new version based on Linus' tree with the following mo=
difications:
>=20
> It depends on gen_init_cpio-uses-external-file-list.patch from -mm, so
> cannot until that is merged.
>=20
> > 1) Propoer changelog
>=20
> Should be with the other thread I guess.
>=20
> > 2) Document use of .shipped somewhere
> >=20
>=20
> If I remember correctly, Andrew asked Thayne Harbaugh to add docs for
> the list format, etc.  I will thus have to wait for those to do changes
> brought by my patch.
>=20
> > And the following small comments.
> >=20
> >=20
> > >  # or set INITRAMFS_LIST to another filename.
> > > -INITRAMFS_LIST ?=3D $(obj)/initramfs_list
> > > +INITRAMFS_LIST :=3D $(obj)/initramfs_list
> >=20
> > Kbuild style is to reser all-uppercase to external visible variables.
> >=20
>=20
> Ok, so we need that in smaller caps.
>=20
> > >  # initramfs_data.o contains the initramfs_data.cpio.gz image.
> > >  # The image is included using .incbin, a dependency which is not
> > > @@ -23,6 +23,23 @@ $(obj)/initramfs_data.o: $(obj)/initramf
> > >  # Commented out for now
> > >  # initramfs-y :=3D $(obj)/root/hello
> > > =20
> > > +quiet_cmd_gen_list =3D GEN_INITRAMFS_LIST $@
> > Please aling output properly with rest of kbuild output.
> > > +quiet_cmd_gen_list =3D GEN     $@
> > Should be enough - the filename give some context as well
> >=20
>=20
> Right, thanks.  I did change it at some time (second only being GEN),
> but I guess I missed the first.
>=20
> > > +      cmd_gen_list =3D $(shell \
> > > +        if test -f "$(CONFIG_INITRAMFS_SOURCE)"; then \
> > > +	  if [ "$(CONFIG_INITRAMFS_SOURCE)" !=3D $@ ]; then \
> > > +	    echo 'cp -f "$(CONFIG_INITRAMFS_SOURCE)" $@'; \
> > > +	  else \
> > > +	    echo 'cp -f "$(srctree)/$(INITRAMFS_LIST).shipped" $@'; \
> > Test for .shipped to be present first?
> >=20
>=20
> This needed even though its supposed to be there?  How should one handle
> the event that its not .. just 'exit 1' ?
>=20
> >=20
> > > +	  fi; \
> > > +	elif test -d "$(CONFIG_INITRAMFS_SOURCE)"; then \
> > > +	  echo 'scripts/gen_initramfs_list.sh "$(CONFIG_INITRAMFS_SOURCE)" =
> $@'; \
> > > +	else \
> > > +	  echo 'cp -f "$(srctree)/$(INITRAMFS_LIST).shipped" $@'; \
> > Same here.
> >=20
> > > +	fi)
> > > +
> > > +$(INITRAMFS_LIST): FORCE
> > > +	$(call cmd,gen_list)
> >=20
> > How do you secure that the list gets updated when some of the above log=
ic changes?
>=20
> Currently it will error if one of the commands called fails - is there a
> more preferred error handling method?
>=20
> > Likewise avoid the list to be generated unles required.
> >=20
>=20
> Simply checking mtime should do?
>=20
>=20

How about this one:

diff -uprN -X dontdiff linux-2.6.9-rc4-mm1.orig/drivers/block/Kconfig linux=
-2.6.9-rc4-mm1/drivers/block/Kconfig
--- linux-2.6.9-rc4-mm1.orig/drivers/block/Kconfig	2004-10-18 21:20:06.8855=
71688 +0200
+++ linux-2.6.9-rc4-mm1/drivers/block/Kconfig	2004-10-17 16:58:35.000000000=
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
diff -uprN -X dontdiff linux-2.6.9-rc4-mm1.orig/scripts/gen_initramfs_list.=
sh linux-2.6.9-rc4-mm1/scripts/gen_initramfs_list.sh
--- linux-2.6.9-rc4-mm1.orig/scripts/gen_initramfs_list.sh	1970-01-01 02:00=
:00.000000000 +0200
+++ linux-2.6.9-rc4-mm1/scripts/gen_initramfs_list.sh	2004-10-18 20:02:09.0=
00000000 +0200
@@ -0,0 +1,98 @@
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
+dirlist=3D$(find "${srcdir}" -printf "%p %m %U %G\n" 2>/dev/null)
+
+# If $dirlist is only one line, then the directory is empty
+if [  "$(echo "${dirlist}" | wc -l)" -gt 1 ]; then
+	echo "${dirlist}" | \
+	while read x; do
+		parse ${x}
+	done
+else
+	# Failsafe in case directory is empty
+	cat <<-EOF
+		# This is a very simple initramfs
+
+		dir /dev 0755 0 0
+		nod /dev/console 0600 0 0 c 5 1
+		dir /root 0700 0 0
+	EOF
+fi
+
+exit 0
diff -uprN -X dontdiff linux-2.6.9-rc4-mm1.orig/usr/Makefile linux-2.6.9-rc=
4-mm1/usr/Makefile
--- linux-2.6.9-rc4-mm1.orig/usr/Makefile	2004-10-18 21:20:06.886571536 +02=
00
+++ linux-2.6.9-rc4-mm1/usr/Makefile	2004-10-18 21:02:35.722372784 +0200
@@ -6,9 +6,11 @@ hostprogs-y  :=3D gen_init_cpio
 clean-files :=3D initramfs_data.cpio.gz
=20
 # If you want a different list of files in the initramfs_data.cpio
-# then you can either overwrite the cpio_list in this directory
-# or set INITRAMFS_LIST to another filename.
-INITRAMFS_LIST ?=3D $(obj)/initramfs_list
+# then you can either overwrite initramfs_list.shipped in this directory
+# or set CONFIG_INITRAMFS_SOURCE to another filename or directory.
+initramfs_list :=3D initramfs_list
+
+clean-files +=3D $(initramfs_list)
=20
 # initramfs_data.o contains the initramfs_data.cpio.gz image.
 # The image is included using .incbin, a dependency which is not
@@ -23,10 +25,43 @@ $(obj)/initramfs_data.o: $(obj)/initramf
 # Commented out for now
 # initramfs-y :=3D $(obj)/root/hello
=20
+# This should only return a command if there was no error
+quiet_cmd_gen_list =3D GEN     $@
+      cmd_gen_list =3D $(shell \
+	if [ -d $(CONFIG_INITRAMFS_SOURCE) ]; then \
+	  tmplist=3D"`find $(CONFIG_INITRAMFS_SOURCE) -newer $@ 2>/dev/null`"; \
+	  if [ ! -f $@ -o "x${tmplist}" !=3D x ]; then \
+	    echo '$(CONFIG_SHELL) scripts/gen_initramfs_list.sh \
+	    			$(CONFIG_INITRAMFS_SOURCE) > $@'; \
+	  else \
+	    echo '/bin/true'; \
+	  fi \
+	else \
+	  if [ -f $(CONFIG_INITRAMFS_SOURCE) -a $(CONFIG_INITRAMFS_SOURCE) !=3D $=
@ ]; then \
+	    if [ ! -f $@ -o $(CONFIG_INITRAMFS_SOURCE) -nt $@ ]; then \
+	      echo 'cp -f $(CONFIG_INITRAMFS_SOURCE) $@'; \
+	    else \
+	      echo '/bin/true'; \
+	    fi \
+	  else \
+	    if [ -f $(srctree)/$(src)/$(initramfs_list).shipped ]; then \
+	      if [ ! -f $@ -o $(srctree)/$(src)/$(initramfs_list).shipped -nt $@ =
]; then \
+	        echo 'cp -f $(srctree)/$(src)/$(initramfs_list).shipped $@'; \
+	      else \
+	        echo '/bin/true'; \
+	      fi \
+	    fi \
+	  fi \
+	fi)
+
+$(obj)/$(initramfs_list): FORCE
+	$(if $(cmd_gen_list), $(call cmd,gen_list), \
+	  error file "$(src)/$(initramfs_list).shipped" does not exist)
+
 quiet_cmd_cpio =3D CPIO    $@
-      cmd_cpio =3D ./$< $(INITRAMFS_LIST) > $@
+      cmd_cpio =3D ./$< $(obj)/$(initramfs_list) > $@
=20
-$(obj)/initramfs_data.cpio: $(obj)/gen_init_cpio $(initramfs-y) $(INITRAMF=
S_LIST) FORCE
+$(obj)/initramfs_data.cpio: $(obj)/gen_init_cpio $(initramfs-y) $(obj)/$(i=
nitramfs_list) FORCE
 	$(call if_changed,cpio)
=20
 targets +=3D initramfs_data.cpio
diff -uprN -X dontdiff linux-2.6.9-rc4-mm1.orig/usr/initramfs_list linux-2.=
6.9-rc4-mm1/usr/initramfs_list
--- linux-2.6.9-rc4-mm1.orig/usr/initramfs_list	2004-10-18 21:20:06.9745581=
60 +0200
+++ linux-2.6.9-rc4-mm1/usr/initramfs_list	1970-01-01 02:00:00.000000000 +0=
200
@@ -1,5 +0,0 @@
-# This is a very simple initramfs - mostly preliminary for future expansio=
n
-
-dir /dev 0755 0 0
-nod /dev/console 0600 0 0 c 5 1
-dir /root 0700 0 0
diff -uprN -X dontdiff linux-2.6.9-rc4-mm1.orig/usr/initramfs_list.shipped =
linux-2.6.9-rc4-mm1/usr/initramfs_list.shipped
--- linux-2.6.9-rc4-mm1.orig/usr/initramfs_list.shipped	1970-01-01 02:00:00=
.000000000 +0200
+++ linux-2.6.9-rc4-mm1/usr/initramfs_list.shipped	2004-10-18 21:20:50.8668=
85512 +0200
@@ -0,0 +1,5 @@
+# This is a very simple initramfs - mostly preliminary for future expansio=
n
+
+dir /dev 0755 0 0
+nod /dev/console 0600 0 0 c 5 1
+dir /root 0700 0 0

--=20
Martin Schlemmer


--=-WtebKmNKCGDLG74UuTOG
Content-Disposition: attachment;
	filename*0=select-cpio_list-or-source-directory-for-initramfs-image-v5.p;
	filename*1=atch
Content-Type: text/x-patch;
	name=select-cpio_list-or-source-directory-for-initramfs-image-v5.patch;
	charset=ISO-8859-15
Content-Transfer-Encoding: base64

ZGlmZiAtdXByTiAtWCBkb250ZGlmZiBsaW51eC0yLjYuOS1yYzQtbW0xLm9yaWcvZHJpdmVycy9i
bG9jay9LY29uZmlnIGxpbnV4LTIuNi45LXJjNC1tbTEvZHJpdmVycy9ibG9jay9LY29uZmlnDQot
LS0gbGludXgtMi42LjktcmM0LW1tMS5vcmlnL2RyaXZlcnMvYmxvY2svS2NvbmZpZwkyMDA0LTEw
LTE4IDIxOjIwOjA2Ljg4NTU3MTY4OCArMDIwMA0KKysrIGxpbnV4LTIuNi45LXJjNC1tbTEvZHJp
dmVycy9ibG9jay9LY29uZmlnCTIwMDQtMTAtMTcgMTY6NTg6MzUuMDAwMDAwMDAwICswMjAwDQpA
QCAtMzQ4LDYgKzM0OCwzMiBAQCBjb25maWcgQkxLX0RFVl9JTklUUkQNCiAJICAicmVhbCIgcm9v
dCBmaWxlIHN5c3RlbSwgZXRjLiBTZWUgPGZpbGU6RG9jdW1lbnRhdGlvbi9pbml0cmQudHh0Pg0K
IAkgIGZvciBkZXRhaWxzLg0KIA0KK2NvbmZpZyBJTklUUkFNRlNfU09VUkNFDQorCXN0cmluZyAi
U291cmNlIGRpcmVjdG9yeSBvZiBjcGlvX2xpc3QiDQorCWRlZmF1bHQgIiINCisJaGVscA0KKwkg
IFRoaXMgY2FuIGJlIHNldCB0byBlaXRoZXIgYSBkaXJlY3RvcnkgY29udGFpbmluZyBmaWxlcywg
ZXRjIHRvIGJlDQorCSAgaW5jbHVkZWQgaW4gdGhlIGluaXRyYW1mcyBhcmNoaXZlLCBvciBhIGZp
bGUgY29udGFpbmluZyBuZXdsaW5lDQorCSAgc2VwYXJhdGVkIGVudHJpZXMuDQorDQorCSAgSWYg
aXQgaXMgYSBmaWxlLCBpdCBzaG91bGQgYmUgaW4gdGhlIGZvbGxvd2luZyBmb3JtYXQ6DQorCSAg
ICAjIGEgY29tbWVudA0KKwkgICAgZmlsZSA8bmFtZT4gPGxvY2F0aW9uPiA8bW9kZT4gPHVpZD4g
PGdpZD4NCisJICAgIGRpciA8bmFtZT4gPG1vZGU+IDx1aWQ+IDxnaWQ+DQorCSAgICBub2QgPG5h
bWU+IDxtb2RlPiA8dWlkPiA8Z2lkPiA8ZGV2X3R5cGU+IDxtYWo+IDxtaW4+DQorDQorCSAgV2hl
cmU6DQorCSAgICA8bmFtZT4gICAgICBuYW1lIG9mIHRoZSBmaWxlL2Rpci9ub2QgaW4gdGhlIGFy
Y2hpdmUNCisJICAgIDxsb2NhdGlvbj4gIGxvY2F0aW9uIG9mIHRoZSBmaWxlIGluIHRoZSBjdXJy
ZW50IGZpbGVzeXN0ZW0NCisJICAgIDxtb2RlPiAgICAgIG1vZGUvcGVybWlzc2lvbnMgb2YgdGhl
IGZpbGUNCisJICAgIDx1aWQ+ICAgICAgIHVzZXIgaWQgKDA9cm9vdCkNCisJICAgIDxnaWQ+ICAg
ICAgIGdyb3VwIGlkICgwPXJvb3QpDQorCSAgICA8ZGV2X3R5cGU+ICBkZXZpY2UgdHlwZSAoYj1i
bG9jaywgYz1jaGFyYWN0ZXIpDQorCSAgICA8bWFqPiAgICAgICBtYWpvciBudW1iZXIgb2Ygbm9k
DQorCSAgICA8bWluPiAgICAgICBtaW5vciBudW1iZXIgb2Ygbm9kDQorDQorCSAgSWYgeW91IGFy
ZSBub3Qgc3VyZSwgbGVhdmUgaXQgYmxhbmsuDQorDQogY29uZmlnIExCRA0KIAlib29sICJTdXBw
b3J0IGZvciBMYXJnZSBCbG9jayBEZXZpY2VzIg0KIAlkZXBlbmRzIG9uIFg4NiB8fCBNSVBTMzIg
fHwgUFBDMzIgfHwgQVJDSF9TMzkwXzMxIHx8IFNVUEVSSA0KZGlmZiAtdXByTiAtWCBkb250ZGlm
ZiBsaW51eC0yLjYuOS1yYzQtbW0xLm9yaWcvc2NyaXB0cy9nZW5faW5pdHJhbWZzX2xpc3Quc2gg
bGludXgtMi42LjktcmM0LW1tMS9zY3JpcHRzL2dlbl9pbml0cmFtZnNfbGlzdC5zaA0KLS0tIGxp
bnV4LTIuNi45LXJjNC1tbTEub3JpZy9zY3JpcHRzL2dlbl9pbml0cmFtZnNfbGlzdC5zaAkxOTcw
LTAxLTAxIDAyOjAwOjAwLjAwMDAwMDAwMCArMDIwMA0KKysrIGxpbnV4LTIuNi45LXJjNC1tbTEv
c2NyaXB0cy9nZW5faW5pdHJhbWZzX2xpc3Quc2gJMjAwNC0xMC0xOCAyMDowMjowOS4wMDAwMDAw
MDAgKzAyMDANCkBAIC0wLDAgKzEsOTggQEANCisjIS9iaW4vYmFzaA0KKyMgQ29weXJpZ2h0IChD
KSBNYXJ0aW4gU2NobGVtbWVyIDxhemFyYWhAbm9zZmVyYXR1LnphLm9yZz4NCisjIFJlbGVhc2Vk
IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdQTA0KKyMNCisjIEEgc2NyaXB0IHRvIGdlbmVy
YXRlIG5ld2xpbmUgc2VwYXJhdGVkIGVudHJpZXMgKHRvIHN0ZG91dCkgZnJvbSBhIGRpcmVjdG9y
eSdzDQorIyBjb250ZW50cyBzdWl0YWJsZSBmb3IgdXNlIGFzIGEgY3Bpb19saXN0IGZvciBnZW5f
aW5pdF9jcGlvLg0KKyMNCisjIEFyZ3VlbWVudHM6ICQxIC0tIHRoZSBzb3VyY2UgZGlyZWN0b3J5
DQorIw0KKyMgVE9ETzogIEFkZCBzdXBwb3J0IGZvciBzeW1saW5rcywgc29ja2V0cyBhbmQgcGlw
ZXMgd2hlbiBnZW5faW5pdF9jcGlvDQorIyAgICAgICAgc3VwcG9ydHMgdGhlbS4NCisNCit1c2Fn
ZSgpIHsNCisJZWNobyAiVXNhZ2U6ICQwIGluaXRyYW1mcy1zb3VyY2UtZGlyIg0KKwlleGl0IDEN
Cit9DQorDQorc3JjZGlyPSQoZWNobyAiJDEiIHwgc2VkIC1lICdzOi8vKjovOmcnKQ0KKw0KK2lm
IFsgIiQjIiAtZ3QgMSAtbyAhIC1kICIke3NyY2Rpcn0iIF07IHRoZW4NCisJdXNhZ2UNCitmaQ0K
Kw0KK2ZpbGV0eXBlKCkgew0KKwlsb2NhbCBhcmd2MT0iJDEiDQorDQorCWlmIFsgLWYgIiR7YXJn
djF9IiBdOyB0aGVuDQorCQllY2hvICJmaWxlIg0KKwllbGlmIFsgLWQgIiR7YXJndjF9IiBdOyB0
aGVuDQorCQllY2hvICJkaXIiDQorCWVsaWYgWyAtYiAiJHthcmd2MX0iIC1vIC1jICIke2FyZ3Yx
fSIgXTsgdGhlbg0KKwkJZWNobyAibm9kIg0KKwllbHNlDQorCQllY2hvICJpbnZhbGlkIg0KKwlm
aQ0KKwlyZXR1cm4gMA0KK30NCisNCitwYXJzZSgpIHsNCisJbG9jYWwgbG9jYXRpb249IiQxIg0K
Kwlsb2NhbCBuYW1lPSIke2xvY2F0aW9uLyR7c3JjZGlyfS8vfSINCisJbG9jYWwgbW9kZT0iJDIi
DQorCWxvY2FsIHVpZD0iJDMiDQorCWxvY2FsIGdpZD0iJDQiDQorCWxvY2FsIGZ0eXBlPSQoZmls
ZXR5cGUgIiR7bG9jYXRpb259IikNCisJbG9jYWwgc3RyPSIke21vZGV9ICR7dWlkfSAke2dpZH0i
DQorDQorCVsgIiR7ZnR5cGV9IiA9PSAiaW52YWxpZCIgXSAmJiByZXR1cm4gMA0KKwlbICIke2xv
Y2F0aW9ufSIgPT0gIiR7c3JjZGlyfSIgXSAmJiByZXR1cm4gMA0KKw0KKwljYXNlICIke2Z0eXBl
fSIgaW4NCisJCSJmaWxlIikNCisJCQlzdHI9IiR7ZnR5cGV9ICR7bmFtZX0gJHtsb2NhdGlvbn0g
JHtzdHJ9Ig0KKwkJCTs7DQorCQkibm9kIikNCisJCQlsb2NhbCBkZXZfdHlwZT0NCisJCQlsb2Nh
bCBtYWo9JChMQ19BTEw9QyBscyAtbCAiJHtsb2NhdGlvbn0iIHwgXA0KKwkJCQkJZ2F3ayAne3N1
YigvLC8sICIiLCAkNSk7IHByaW50ICQ1fScpDQorCQkJbG9jYWwgbWluPSQoTENfQUxMPUMgbHMg
LWwgIiR7bG9jYXRpb259IiB8IFwNCisJCQkJCWdhd2sgJ3twcmludCAkNn0nKQ0KKw0KKwkJCWlm
IFsgLWIgIiR7bG9jYXRpb259IiBdOyB0aGVuDQorCQkJCWRldl90eXBlPSJiIg0KKwkJCWVsc2UN
CisJCQkJZGV2X3R5cGU9ImMiDQorCQkJZmkNCisJCQlzdHI9IiR7ZnR5cGV9ICR7bmFtZX0gJHtz
dHJ9ICR7ZGV2X3R5cGV9ICR7bWFqfSAke21pbn0iDQorCQkJOzsNCisJCSopDQorCQkJc3RyPSIk
e2Z0eXBlfSAke25hbWV9ICR7c3RyfSINCisJCQk7Ow0KKwllc2FjDQorDQorCWVjaG8gIiR7c3Ry
fSINCisNCisJcmV0dXJuIDANCit9DQorDQorZGlybGlzdD0kKGZpbmQgIiR7c3JjZGlyfSIgLXBy
aW50ZiAiJXAgJW0gJVUgJUdcbiIgMj4vZGV2L251bGwpDQorDQorIyBJZiAkZGlybGlzdCBpcyBv
bmx5IG9uZSBsaW5lLCB0aGVuIHRoZSBkaXJlY3RvcnkgaXMgZW1wdHkNCitpZiBbICAiJChlY2hv
ICIke2Rpcmxpc3R9IiB8IHdjIC1sKSIgLWd0IDEgXTsgdGhlbg0KKwllY2hvICIke2Rpcmxpc3R9
IiB8IFwNCisJd2hpbGUgcmVhZCB4OyBkbw0KKwkJcGFyc2UgJHt4fQ0KKwlkb25lDQorZWxzZQ0K
KwkjIEZhaWxzYWZlIGluIGNhc2UgZGlyZWN0b3J5IGlzIGVtcHR5DQorCWNhdCA8PC1FT0YNCisJ
CSMgVGhpcyBpcyBhIHZlcnkgc2ltcGxlIGluaXRyYW1mcw0KKw0KKwkJZGlyIC9kZXYgMDc1NSAw
IDANCisJCW5vZCAvZGV2L2NvbnNvbGUgMDYwMCAwIDAgYyA1IDENCisJCWRpciAvcm9vdCAwNzAw
IDAgMA0KKwlFT0YNCitmaQ0KKw0KK2V4aXQgMA0KZGlmZiAtdXByTiAtWCBkb250ZGlmZiBsaW51
eC0yLjYuOS1yYzQtbW0xLm9yaWcvdXNyL01ha2VmaWxlIGxpbnV4LTIuNi45LXJjNC1tbTEvdXNy
L01ha2VmaWxlDQotLS0gbGludXgtMi42LjktcmM0LW1tMS5vcmlnL3Vzci9NYWtlZmlsZQkyMDA0
LTEwLTE4IDIxOjIwOjA2Ljg4NjU3MTUzNiArMDIwMA0KKysrIGxpbnV4LTIuNi45LXJjNC1tbTEv
dXNyL01ha2VmaWxlCTIwMDQtMTAtMTggMjE6MDI6MzUuNzIyMzcyNzg0ICswMjAwDQpAQCAtNiw5
ICs2LDExIEBAIGhvc3Rwcm9ncy15ICA6PSBnZW5faW5pdF9jcGlvDQogY2xlYW4tZmlsZXMgOj0g
aW5pdHJhbWZzX2RhdGEuY3Bpby5neg0KIA0KICMgSWYgeW91IHdhbnQgYSBkaWZmZXJlbnQgbGlz
dCBvZiBmaWxlcyBpbiB0aGUgaW5pdHJhbWZzX2RhdGEuY3Bpbw0KLSMgdGhlbiB5b3UgY2FuIGVp
dGhlciBvdmVyd3JpdGUgdGhlIGNwaW9fbGlzdCBpbiB0aGlzIGRpcmVjdG9yeQ0KLSMgb3Igc2V0
IElOSVRSQU1GU19MSVNUIHRvIGFub3RoZXIgZmlsZW5hbWUuDQotSU5JVFJBTUZTX0xJU1QgPz0g
JChvYmopL2luaXRyYW1mc19saXN0DQorIyB0aGVuIHlvdSBjYW4gZWl0aGVyIG92ZXJ3cml0ZSBp
bml0cmFtZnNfbGlzdC5zaGlwcGVkIGluIHRoaXMgZGlyZWN0b3J5DQorIyBvciBzZXQgQ09ORklH
X0lOSVRSQU1GU19TT1VSQ0UgdG8gYW5vdGhlciBmaWxlbmFtZSBvciBkaXJlY3RvcnkuDQoraW5p
dHJhbWZzX2xpc3QgOj0gaW5pdHJhbWZzX2xpc3QNCisNCitjbGVhbi1maWxlcyArPSAkKGluaXRy
YW1mc19saXN0KQ0KIA0KICMgaW5pdHJhbWZzX2RhdGEubyBjb250YWlucyB0aGUgaW5pdHJhbWZz
X2RhdGEuY3Bpby5neiBpbWFnZS4NCiAjIFRoZSBpbWFnZSBpcyBpbmNsdWRlZCB1c2luZyAuaW5j
YmluLCBhIGRlcGVuZGVuY3kgd2hpY2ggaXMgbm90DQpAQCAtMjMsMTAgKzI1LDQzIEBAICQob2Jq
KS9pbml0cmFtZnNfZGF0YS5vOiAkKG9iaikvaW5pdHJhbWYNCiAjIENvbW1lbnRlZCBvdXQgZm9y
IG5vdw0KICMgaW5pdHJhbWZzLXkgOj0gJChvYmopL3Jvb3QvaGVsbG8NCiANCisjIFRoaXMgc2hv
dWxkIG9ubHkgcmV0dXJuIGEgY29tbWFuZCBpZiB0aGVyZSB3YXMgbm8gZXJyb3INCitxdWlldF9j
bWRfZ2VuX2xpc3QgPSBHRU4gICAgICRADQorICAgICAgY21kX2dlbl9saXN0ID0gJChzaGVsbCBc
DQorCWlmIFsgLWQgJChDT05GSUdfSU5JVFJBTUZTX1NPVVJDRSkgXTsgdGhlbiBcDQorCSAgdG1w
bGlzdD0iYGZpbmQgJChDT05GSUdfSU5JVFJBTUZTX1NPVVJDRSkgLW5ld2VyICRAIDI+L2Rldi9u
dWxsYCI7IFwNCisJICBpZiBbICEgLWYgJEAgLW8gIngke3RtcGxpc3R9IiAhPSB4IF07IHRoZW4g
XA0KKwkgICAgZWNobyAnJChDT05GSUdfU0hFTEwpIHNjcmlwdHMvZ2VuX2luaXRyYW1mc19saXN0
LnNoIFwNCisJICAgIAkJCSQoQ09ORklHX0lOSVRSQU1GU19TT1VSQ0UpID4gJEAnOyBcDQorCSAg
ZWxzZSBcDQorCSAgICBlY2hvICcvYmluL3RydWUnOyBcDQorCSAgZmkgXA0KKwllbHNlIFwNCisJ
ICBpZiBbIC1mICQoQ09ORklHX0lOSVRSQU1GU19TT1VSQ0UpIC1hICQoQ09ORklHX0lOSVRSQU1G
U19TT1VSQ0UpICE9ICRAIF07IHRoZW4gXA0KKwkgICAgaWYgWyAhIC1mICRAIC1vICQoQ09ORklH
X0lOSVRSQU1GU19TT1VSQ0UpIC1udCAkQCBdOyB0aGVuIFwNCisJICAgICAgZWNobyAnY3AgLWYg
JChDT05GSUdfSU5JVFJBTUZTX1NPVVJDRSkgJEAnOyBcDQorCSAgICBlbHNlIFwNCisJICAgICAg
ZWNobyAnL2Jpbi90cnVlJzsgXA0KKwkgICAgZmkgXA0KKwkgIGVsc2UgXA0KKwkgICAgaWYgWyAt
ZiAkKHNyY3RyZWUpLyQoc3JjKS8kKGluaXRyYW1mc19saXN0KS5zaGlwcGVkIF07IHRoZW4gXA0K
KwkgICAgICBpZiBbICEgLWYgJEAgLW8gJChzcmN0cmVlKS8kKHNyYykvJChpbml0cmFtZnNfbGlz
dCkuc2hpcHBlZCAtbnQgJEAgXTsgdGhlbiBcDQorCSAgICAgICAgZWNobyAnY3AgLWYgJChzcmN0
cmVlKS8kKHNyYykvJChpbml0cmFtZnNfbGlzdCkuc2hpcHBlZCAkQCc7IFwNCisJICAgICAgZWxz
ZSBcDQorCSAgICAgICAgZWNobyAnL2Jpbi90cnVlJzsgXA0KKwkgICAgICBmaSBcDQorCSAgICBm
aSBcDQorCSAgZmkgXA0KKwlmaSkNCisNCiskKG9iaikvJChpbml0cmFtZnNfbGlzdCk6IEZPUkNF
DQorCSQoaWYgJChjbWRfZ2VuX2xpc3QpLCAkKGNhbGwgY21kLGdlbl9saXN0KSwgXA0KKwkgIGVy
cm9yIGZpbGUgIiQoc3JjKS8kKGluaXRyYW1mc19saXN0KS5zaGlwcGVkIiBkb2VzIG5vdCBleGlz
dCkNCisNCiBxdWlldF9jbWRfY3BpbyA9IENQSU8gICAgJEANCi0gICAgICBjbWRfY3BpbyA9IC4v
JDwgJChJTklUUkFNRlNfTElTVCkgPiAkQA0KKyAgICAgIGNtZF9jcGlvID0gLi8kPCAkKG9iaikv
JChpbml0cmFtZnNfbGlzdCkgPiAkQA0KIA0KLSQob2JqKS9pbml0cmFtZnNfZGF0YS5jcGlvOiAk
KG9iaikvZ2VuX2luaXRfY3BpbyAkKGluaXRyYW1mcy15KSAkKElOSVRSQU1GU19MSVNUKSBGT1JD
RQ0KKyQob2JqKS9pbml0cmFtZnNfZGF0YS5jcGlvOiAkKG9iaikvZ2VuX2luaXRfY3BpbyAkKGlu
aXRyYW1mcy15KSAkKG9iaikvJChpbml0cmFtZnNfbGlzdCkgRk9SQ0UNCiAJJChjYWxsIGlmX2No
YW5nZWQsY3BpbykNCiANCiB0YXJnZXRzICs9IGluaXRyYW1mc19kYXRhLmNwaW8NCmRpZmYgLXVw
ck4gLVggZG9udGRpZmYgbGludXgtMi42LjktcmM0LW1tMS5vcmlnL3Vzci9pbml0cmFtZnNfbGlz
dCBsaW51eC0yLjYuOS1yYzQtbW0xL3Vzci9pbml0cmFtZnNfbGlzdA0KLS0tIGxpbnV4LTIuNi45
LXJjNC1tbTEub3JpZy91c3IvaW5pdHJhbWZzX2xpc3QJMjAwNC0xMC0xOCAyMToyMDowNi45NzQ1
NTgxNjAgKzAyMDANCisrKyBsaW51eC0yLjYuOS1yYzQtbW0xL3Vzci9pbml0cmFtZnNfbGlzdAkx
OTcwLTAxLTAxIDAyOjAwOjAwLjAwMDAwMDAwMCArMDIwMA0KQEAgLTEsNSArMCwwIEBADQotIyBU
aGlzIGlzIGEgdmVyeSBzaW1wbGUgaW5pdHJhbWZzIC0gbW9zdGx5IHByZWxpbWluYXJ5IGZvciBm
dXR1cmUgZXhwYW5zaW9uDQotDQotZGlyIC9kZXYgMDc1NSAwIDANCi1ub2QgL2Rldi9jb25zb2xl
IDA2MDAgMCAwIGMgNSAxDQotZGlyIC9yb290IDA3MDAgMCAwDQpkaWZmIC11cHJOIC1YIGRvbnRk
aWZmIGxpbnV4LTIuNi45LXJjNC1tbTEub3JpZy91c3IvaW5pdHJhbWZzX2xpc3Quc2hpcHBlZCBs
aW51eC0yLjYuOS1yYzQtbW0xL3Vzci9pbml0cmFtZnNfbGlzdC5zaGlwcGVkDQotLS0gbGludXgt
Mi42LjktcmM0LW1tMS5vcmlnL3Vzci9pbml0cmFtZnNfbGlzdC5zaGlwcGVkCTE5NzAtMDEtMDEg
MDI6MDA6MDAuMDAwMDAwMDAwICswMjAwDQorKysgbGludXgtMi42LjktcmM0LW1tMS91c3IvaW5p
dHJhbWZzX2xpc3Quc2hpcHBlZAkyMDA0LTEwLTE4IDIxOjIwOjUwLjg2Njg4NTUxMiArMDIwMA0K
QEAgLTAsMCArMSw1IEBADQorIyBUaGlzIGlzIGEgdmVyeSBzaW1wbGUgaW5pdHJhbWZzIC0gbW9z
dGx5IHByZWxpbWluYXJ5IGZvciBmdXR1cmUgZXhwYW5zaW9uDQorDQorZGlyIC9kZXYgMDc1NSAw
IDANCitub2QgL2Rldi9jb25zb2xlIDA2MDAgMCAwIGMgNSAxDQorZGlyIC9yb290IDA3MDAgMCAw
DQo=


--=-WtebKmNKCGDLG74UuTOG--

--=-fpxdOoXfcDItz5vPTyUr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBdBjZqburzKaJYLYRAgn4AJ9ZH9ZFqY3xtPRXH1/SqkKhADaO6ACginBO
bi32zajIYKqPdmuJYQ5LfWc=
=r/aM
-----END PGP SIGNATURE-----

--=-fpxdOoXfcDItz5vPTyUr--

