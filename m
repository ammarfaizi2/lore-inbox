Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267377AbUJWMHd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267377AbUJWMHd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 08:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267381AbUJWMHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 08:07:33 -0400
Received: from ctb-mesg2.saix.net ([196.25.240.74]:54188 "EHLO
	ctb-mesg2.saix.net") by vger.kernel.org with ESMTP id S267377AbUJWMG5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 08:06:57 -0400
Subject: [PATCH 2.6.9-bk7] Select cpio_list or source directory for
	initramfs image updates [u]
From: "Martin Schlemmer [c]" <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, Sam Ravnborg <sam@ravnborg.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <200410200849.i9K8n5921516@mail.osdl.org>
References: <200410200849.i9K8n5921516@mail.osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-RbJkIj8ulntF6MxfMIMl"
Date: Sat, 23 Oct 2004 14:06:28 +0200
Message-Id: <1098533188.668.9.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-RbJkIj8ulntF6MxfMIMl
Content-Type: multipart/mixed; boundary="=-1PQntixpF0vg9Jvr8ZO7"


--=-1PQntixpF0vg9Jvr8ZO7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Here is some updates after talking to Sam Ravnborg.  He did not yet come
back to me, I am not sure if I understood 100% what he meant, but hopefully
somebody else will be so kind as to comment.

Here is a shortish changelog:

- Fix an issue reported by Esben Nielsen <simlo@phys.au.dk> (with
suggestion from Sam Ravnborg).  Build failed if $O (output dir) was
set.  This is done by pre-pending $srctree if the shipped list is
referenced.

- Also fix calling of gen_initramfs_list.sh if $O (output dir) is set
by pre-pending $srctree.

- I also moved initramfs_list to initramfs_list.shipped, to make sure we
always have an 'fall back' list (say you unset CONFIG_INITRAMFS_SOURCE
and deleted your custom intramfs source directory, then building will not
fail).

- Kbuild style cleanups.

- Improved error checking.  For example gen_initramfs_list.sh will
output a simple list if the target directory is empty, and we verify
that the shipped initramfs_list is present before touching it.

- Only update the temp initramfs_list if the source list/directory have
changed.

- Cleanup temporary initramfs_list when 'make clean' or 'make mrproper'
is called.


This patch should apply to both 2.6.9-bk7 and 2.6.9-mm1.

(Note that evo does some tab/newline damage)

Signed-off-by: Martin Schlemmer <azarah@nosferatu.za.org>

diff -uprN -X dontdiff linux-2.6.9-bk7.orig/scripts/gen_initramfs_list.sh l=
inux-2.6.9-bk7/scripts/gen_initramfs_list.sh
--- linux-2.6.9-bk7.orig/scripts/gen_initramfs_list.sh	2004-10-23 11:23:49.=
000000000 +0200
+++ linux-2.6.9-bk7/scripts/gen_initramfs_list.sh	2004-10-23 11:26:52.00000=
0000 +0200
@@ -76,9 +76,23 @@ parse() {
 	return 0
 }
=20
-find "${srcdir}" -printf "%p %m %U %G\n" | \
-while read x; do
-	parse ${x}
-done
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
=20
 exit 0
diff -uprN -X dontdiff linux-2.6.9-bk7.orig/usr/Makefile linux-2.6.9-bk7/us=
r/Makefile
--- linux-2.6.9-bk7.orig/usr/Makefile	2004-10-23 11:23:54.000000000 +0200
+++ linux-2.6.9-bk7/usr/Makefile	2004-10-23 13:56:28.691508824 +0200
@@ -6,9 +6,11 @@ hostprogs-y  :=3D gen_init_cpio
 clean-files :=3D initramfs_data.cpio.gz
=20
 # If you want a different list of files in the initramfs_data.cpio
-# then you can either overwrite the cpio_list in this directory
-# or set INITRAMFS_LIST to another filename.
-INITRAMFS_LIST :=3D $(obj)/initramfs_list
+# then you can either overwrite initramfs_list.shipped in this directory
+# or set CONFIG_INITRAMFS_SOURCE to another filename or directory.
+initramfs_list :=3D initramfs_list
+
+clean-files +=3D $(initramfs_list)
=20
 # initramfs_data.o contains the initramfs_data.cpio.gz image.
 # The image is included using .incbin, a dependency which is not
@@ -23,28 +25,75 @@ $(obj)/initramfs_data.o: $(obj)/initramf
 # Commented out for now
 # initramfs-y :=3D $(obj)/root/hello
=20
-quiet_cmd_gen_list =3D GEN_INITRAMFS_LIST $@
+# Returns:
+#   valid command if everything should be fine
+#   'uptodate' if nothing needs to be done
+#   'missing' if $(srctree)/$(src)/$(initramfs_list).shipped is missing
+quiet_cmd_gen_list =3D GEN     $@
       cmd_gen_list =3D $(shell \
-        if test -f $(CONFIG_INITRAMFS_SOURCE); then \
-	  if [ $(CONFIG_INITRAMFS_SOURCE) !=3D $@ ]; then \
-	    echo 'cp -f $(CONFIG_INITRAMFS_SOURCE) $@'; \
+	if [ -d $(CONFIG_INITRAMFS_SOURCE) ]; \
+	then \
+	  if [ ! -f "$(obj)/$(initramfs_list)" -o \
+	       "x`find $(CONFIG_INITRAMFS_SOURCE) -newer "$(obj)/$(initramfs_list=
)" 2>/dev/null`" !=3D "x" ]; \
+	  then \
+	    echo '$(CONFIG_SHELL) $(srctree)/scripts/gen_initramfs_list.sh \
+	      $(CONFIG_INITRAMFS_SOURCE) > "$(obj)/$(initramfs_list)"'; \
 	  else \
-	    echo 'echo Using shipped $@'; \
-	  fi; \
-	elif test -d $(CONFIG_INITRAMFS_SOURCE); then \
-	  echo 'scripts/gen_initramfs_list.sh $(CONFIG_INITRAMFS_SOURCE) > $@'; \
+	    echo 'uptodate'; \
+	  fi \
 	else \
-	  echo 'echo Using shipped $@'; \
+	  if [ -f $(CONFIG_INITRAMFS_SOURCE) -a \
+	       $(CONFIG_INITRAMFS_SOURCE) !=3D "$(obj)/$(initramfs_list)" ]; \
+	  then \
+	    if [ ! -f "$(obj)/$(initramfs_list)" -o \
+	         $(CONFIG_INITRAMFS_SOURCE) -nt "$(obj)/$(initramfs_list)" ]; \
+	    then \
+	      echo 'cp -f $(CONFIG_INITRAMFS_SOURCE) "$(obj)/$(initramfs_list)"';=
 \
+	    else \
+	      echo 'uptodate'; \
+	    fi \
+	  else \
+	    if [ -f "$(srctree)/$(src)/$(initramfs_list).shipped" ]; \
+	    then \
+	      if [ ! -f "$(obj)/$(initramfs_list)" -o \
+	           "$(srctree)/$(src)/$(initramfs_list).shipped" -nt "$(obj)/$(in=
itramfs_list)" ]; \
+	      then \
+	        echo 'cp -f "$(srctree)/$(src)/$(initramfs_list).shipped" \
+	          "$(obj)/$(initramfs_list)"'; \
+	      else \
+	        echo 'uptodate'; \
+	      fi \
+	    else \
+	      echo 'missing'; \
+	    fi \
+	  fi \
 	fi)
=20
-
-$(INITRAMFS_LIST): FORCE
-	$(call cmd,gen_list)
+initramfs_list_state_uptodate :=3D
+initramfs_list_state_outofdate :=3D
+initramfs_list_state_missing :=3D
+
+ifeq ($(cmd_gen_list),uptodate)
+  initramfs_list_state_uptodate :=3D 1
+else
+  ifeq ($(cmd_gen_list),missing)
+    initramfs_list_state_missing :=3D 1
+  else
+    initramfs_list_state_outofdate :=3D 1
+  endif
+endif
+
+$(obj)/$(initramfs_list): FORCE
+	$(if $(nitramfs_list_state_uptodate),, \
+	  $(if $(initramfs_list_state_outofdate), $(call cmd,gen_list), \
+	    $(if $(initramfs_list_state_missing), \
+	      @echo 'File "$(src)/$(initramfs_list).shipped" does not exist'; \
+	      /bin/false)))
=20
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
diff -uprN -X dontdiff linux-2.6.9-bk7.orig/usr/initramfs_list linux-2.6.9-=
bk7/usr/initramfs_list
--- linux-2.6.9-bk7.orig/usr/initramfs_list	2004-10-23 11:23:54.000000000 +=
0200
+++ linux-2.6.9-bk7/usr/initramfs_list	1970-01-01 02:00:00.000000000 +0200
@@ -1,5 +0,0 @@
-# This is a very simple initramfs - mostly preliminary for future expansio=
n
-
-dir /dev 0755 0 0
-nod /dev/console 0600 0 0 c 5 1
-dir /root 0700 0 0
diff -uprN -X dontdiff linux-2.6.9-bk7.orig/usr/initramfs_list.shipped linu=
x-2.6.9-bk7/usr/initramfs_list.shipped
--- linux-2.6.9-bk7.orig/usr/initramfs_list.shipped	1970-01-01 02:00:00.000=
000000 +0200
+++ linux-2.6.9-bk7/usr/initramfs_list.shipped	2004-10-23 11:26:52.00000000=
0 +0200
@@ -0,0 +1,5 @@
+# This is a very simple initramfs - mostly preliminary for future expansio=
n
+
+dir /dev 0755 0 0
+nod /dev/console 0600 0 0 c 5 1
+dir /root 0700 0 0



--=20
Martin Schlemmer


--=-1PQntixpF0vg9Jvr8ZO7
Content-Disposition: attachment; filename*0=select-cpio_list-or-source-directory-for-initramfs-image-v5.p; filename*1=atch
Content-Type: text/x-patch; name=select-cpio_list-or-source-directory-for-initramfs-image-v5.patch; charset=ISO-8859-15
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


--=-1PQntixpF0vg9Jvr8ZO7
Content-Disposition: attachment;
	filename*0=select-cpio_list-or-source-directory-for-initramfs-image-v7.p;
	filename*1=atch
Content-Transfer-Encoding: base64
Content-Type: text/x-patch;
	name=select-cpio_list-or-source-directory-for-initramfs-image-v7.patch;
	charset=ISO-8859-15

ZGlmZiAtdXByTiAtWCBkb250ZGlmZiBsaW51eC0yLjYuOS1iazcub3JpZy9zY3JpcHRzL2dlbl9p
bml0cmFtZnNfbGlzdC5zaCBsaW51eC0yLjYuOS1iazcvc2NyaXB0cy9nZW5faW5pdHJhbWZzX2xp
c3Quc2gNCi0tLSBsaW51eC0yLjYuOS1iazcub3JpZy9zY3JpcHRzL2dlbl9pbml0cmFtZnNfbGlz
dC5zaAkyMDA0LTEwLTIzIDExOjIzOjQ5LjAwMDAwMDAwMCArMDIwMA0KKysrIGxpbnV4LTIuNi45
LWJrNy9zY3JpcHRzL2dlbl9pbml0cmFtZnNfbGlzdC5zaAkyMDA0LTEwLTIzIDExOjI2OjUyLjAw
MDAwMDAwMCArMDIwMA0KQEAgLTc2LDkgKzc2LDIzIEBAIHBhcnNlKCkgew0KIAlyZXR1cm4gMA0K
IH0NCiANCi1maW5kICIke3NyY2Rpcn0iIC1wcmludGYgIiVwICVtICVVICVHXG4iIHwgXA0KLXdo
aWxlIHJlYWQgeDsgZG8NCi0JcGFyc2UgJHt4fQ0KLWRvbmUNCitkaXJsaXN0PSQoZmluZCAiJHtz
cmNkaXJ9IiAtcHJpbnRmICIlcCAlbSAlVSAlR1xuIiAyPi9kZXYvbnVsbCkNCisNCisjIElmICRk
aXJsaXN0IGlzIG9ubHkgb25lIGxpbmUsIHRoZW4gdGhlIGRpcmVjdG9yeSBpcyBlbXB0eQ0KK2lm
IFsgICIkKGVjaG8gIiR7ZGlybGlzdH0iIHwgd2MgLWwpIiAtZ3QgMSBdOyB0aGVuDQorCWVjaG8g
IiR7ZGlybGlzdH0iIHwgXA0KKwl3aGlsZSByZWFkIHg7IGRvDQorCQlwYXJzZSAke3h9DQorCWRv
bmUNCitlbHNlDQorCSMgRmFpbHNhZmUgaW4gY2FzZSBkaXJlY3RvcnkgaXMgZW1wdHkNCisJY2F0
IDw8LUVPRg0KKwkJIyBUaGlzIGlzIGEgdmVyeSBzaW1wbGUgaW5pdHJhbWZzDQorDQorCQlkaXIg
L2RldiAwNzU1IDAgMA0KKwkJbm9kIC9kZXYvY29uc29sZSAwNjAwIDAgMCBjIDUgMQ0KKwkJZGly
IC9yb290IDA3MDAgMCAwDQorCUVPRg0KK2ZpDQogDQogZXhpdCAwDQpkaWZmIC11cHJOIC1YIGRv
bnRkaWZmIGxpbnV4LTIuNi45LWJrNy5vcmlnL3Vzci9NYWtlZmlsZSBsaW51eC0yLjYuOS1iazcv
dXNyL01ha2VmaWxlDQotLS0gbGludXgtMi42LjktYms3Lm9yaWcvdXNyL01ha2VmaWxlCTIwMDQt
MTAtMjMgMTE6MjM6NTQuMDAwMDAwMDAwICswMjAwDQorKysgbGludXgtMi42LjktYms3L3Vzci9N
YWtlZmlsZQkyMDA0LTEwLTIzIDEzOjU2OjI4LjY5MTUwODgyNCArMDIwMA0KQEAgLTYsOSArNiwx
MSBAQCBob3N0cHJvZ3MteSAgOj0gZ2VuX2luaXRfY3Bpbw0KIGNsZWFuLWZpbGVzIDo9IGluaXRy
YW1mc19kYXRhLmNwaW8uZ3oNCiANCiAjIElmIHlvdSB3YW50IGEgZGlmZmVyZW50IGxpc3Qgb2Yg
ZmlsZXMgaW4gdGhlIGluaXRyYW1mc19kYXRhLmNwaW8NCi0jIHRoZW4geW91IGNhbiBlaXRoZXIg
b3ZlcndyaXRlIHRoZSBjcGlvX2xpc3QgaW4gdGhpcyBkaXJlY3RvcnkNCi0jIG9yIHNldCBJTklU
UkFNRlNfTElTVCB0byBhbm90aGVyIGZpbGVuYW1lLg0KLUlOSVRSQU1GU19MSVNUIDo9ICQob2Jq
KS9pbml0cmFtZnNfbGlzdA0KKyMgdGhlbiB5b3UgY2FuIGVpdGhlciBvdmVyd3JpdGUgaW5pdHJh
bWZzX2xpc3Quc2hpcHBlZCBpbiB0aGlzIGRpcmVjdG9yeQ0KKyMgb3Igc2V0IENPTkZJR19JTklU
UkFNRlNfU09VUkNFIHRvIGFub3RoZXIgZmlsZW5hbWUgb3IgZGlyZWN0b3J5Lg0KK2luaXRyYW1m
c19saXN0IDo9IGluaXRyYW1mc19saXN0DQorDQorY2xlYW4tZmlsZXMgKz0gJChpbml0cmFtZnNf
bGlzdCkNCiANCiAjIGluaXRyYW1mc19kYXRhLm8gY29udGFpbnMgdGhlIGluaXRyYW1mc19kYXRh
LmNwaW8uZ3ogaW1hZ2UuDQogIyBUaGUgaW1hZ2UgaXMgaW5jbHVkZWQgdXNpbmcgLmluY2Jpbiwg
YSBkZXBlbmRlbmN5IHdoaWNoIGlzIG5vdA0KQEAgLTIzLDI4ICsyNSw3NSBAQCAkKG9iaikvaW5p
dHJhbWZzX2RhdGEubzogJChvYmopL2luaXRyYW1mDQogIyBDb21tZW50ZWQgb3V0IGZvciBub3cN
CiAjIGluaXRyYW1mcy15IDo9ICQob2JqKS9yb290L2hlbGxvDQogDQotcXVpZXRfY21kX2dlbl9s
aXN0ID0gR0VOX0lOSVRSQU1GU19MSVNUICRADQorIyBSZXR1cm5zOg0KKyMgICB2YWxpZCBjb21t
YW5kIGlmIGV2ZXJ5dGhpbmcgc2hvdWxkIGJlIGZpbmUNCisjICAgJ3VwdG9kYXRlJyBpZiBub3Ro
aW5nIG5lZWRzIHRvIGJlIGRvbmUNCisjICAgJ21pc3NpbmcnIGlmICQoc3JjdHJlZSkvJChzcmMp
LyQoaW5pdHJhbWZzX2xpc3QpLnNoaXBwZWQgaXMgbWlzc2luZw0KK3F1aWV0X2NtZF9nZW5fbGlz
dCA9IEdFTiAgICAgJEANCiAgICAgICBjbWRfZ2VuX2xpc3QgPSAkKHNoZWxsIFwNCi0gICAgICAg
IGlmIHRlc3QgLWYgJChDT05GSUdfSU5JVFJBTUZTX1NPVVJDRSk7IHRoZW4gXA0KLQkgIGlmIFsg
JChDT05GSUdfSU5JVFJBTUZTX1NPVVJDRSkgIT0gJEAgXTsgdGhlbiBcDQotCSAgICBlY2hvICdj
cCAtZiAkKENPTkZJR19JTklUUkFNRlNfU09VUkNFKSAkQCc7IFwNCisJaWYgWyAtZCAkKENPTkZJ
R19JTklUUkFNRlNfU09VUkNFKSBdOyBcDQorCXRoZW4gXA0KKwkgIGlmIFsgISAtZiAiJChvYmop
LyQoaW5pdHJhbWZzX2xpc3QpIiAtbyBcDQorCSAgICAgICAieGBmaW5kICQoQ09ORklHX0lOSVRS
QU1GU19TT1VSQ0UpIC1uZXdlciAiJChvYmopLyQoaW5pdHJhbWZzX2xpc3QpIiAyPi9kZXYvbnVs
bGAiICE9ICJ4IiBdOyBcDQorCSAgdGhlbiBcDQorCSAgICBlY2hvICckKENPTkZJR19TSEVMTCkg
JChzcmN0cmVlKS9zY3JpcHRzL2dlbl9pbml0cmFtZnNfbGlzdC5zaCBcDQorCSAgICAgICQoQ09O
RklHX0lOSVRSQU1GU19TT1VSQ0UpID4gIiQob2JqKS8kKGluaXRyYW1mc19saXN0KSInOyBcDQog
CSAgZWxzZSBcDQotCSAgICBlY2hvICdlY2hvIFVzaW5nIHNoaXBwZWQgJEAnOyBcDQotCSAgZmk7
IFwNCi0JZWxpZiB0ZXN0IC1kICQoQ09ORklHX0lOSVRSQU1GU19TT1VSQ0UpOyB0aGVuIFwNCi0J
ICBlY2hvICdzY3JpcHRzL2dlbl9pbml0cmFtZnNfbGlzdC5zaCAkKENPTkZJR19JTklUUkFNRlNf
U09VUkNFKSA+ICRAJzsgXA0KKwkgICAgZWNobyAndXB0b2RhdGUnOyBcDQorCSAgZmkgXA0KIAll
bHNlIFwNCi0JICBlY2hvICdlY2hvIFVzaW5nIHNoaXBwZWQgJEAnOyBcDQorCSAgaWYgWyAtZiAk
KENPTkZJR19JTklUUkFNRlNfU09VUkNFKSAtYSBcDQorCSAgICAgICAkKENPTkZJR19JTklUUkFN
RlNfU09VUkNFKSAhPSAiJChvYmopLyQoaW5pdHJhbWZzX2xpc3QpIiBdOyBcDQorCSAgdGhlbiBc
DQorCSAgICBpZiBbICEgLWYgIiQob2JqKS8kKGluaXRyYW1mc19saXN0KSIgLW8gXA0KKwkgICAg
ICAgICAkKENPTkZJR19JTklUUkFNRlNfU09VUkNFKSAtbnQgIiQob2JqKS8kKGluaXRyYW1mc19s
aXN0KSIgXTsgXA0KKwkgICAgdGhlbiBcDQorCSAgICAgIGVjaG8gJ2NwIC1mICQoQ09ORklHX0lO
SVRSQU1GU19TT1VSQ0UpICIkKG9iaikvJChpbml0cmFtZnNfbGlzdCkiJzsgXA0KKwkgICAgZWxz
ZSBcDQorCSAgICAgIGVjaG8gJ3VwdG9kYXRlJzsgXA0KKwkgICAgZmkgXA0KKwkgIGVsc2UgXA0K
KwkgICAgaWYgWyAtZiAiJChzcmN0cmVlKS8kKHNyYykvJChpbml0cmFtZnNfbGlzdCkuc2hpcHBl
ZCIgXTsgXA0KKwkgICAgdGhlbiBcDQorCSAgICAgIGlmIFsgISAtZiAiJChvYmopLyQoaW5pdHJh
bWZzX2xpc3QpIiAtbyBcDQorCSAgICAgICAgICAgIiQoc3JjdHJlZSkvJChzcmMpLyQoaW5pdHJh
bWZzX2xpc3QpLnNoaXBwZWQiIC1udCAiJChvYmopLyQoaW5pdHJhbWZzX2xpc3QpIiBdOyBcDQor
CSAgICAgIHRoZW4gXA0KKwkgICAgICAgIGVjaG8gJ2NwIC1mICIkKHNyY3RyZWUpLyQoc3JjKS8k
KGluaXRyYW1mc19saXN0KS5zaGlwcGVkIiBcDQorCSAgICAgICAgICAiJChvYmopLyQoaW5pdHJh
bWZzX2xpc3QpIic7IFwNCisJICAgICAgZWxzZSBcDQorCSAgICAgICAgZWNobyAndXB0b2RhdGUn
OyBcDQorCSAgICAgIGZpIFwNCisJICAgIGVsc2UgXA0KKwkgICAgICBlY2hvICdtaXNzaW5nJzsg
XA0KKwkgICAgZmkgXA0KKwkgIGZpIFwNCiAJZmkpDQogDQotDQotJChJTklUUkFNRlNfTElTVCk6
IEZPUkNFDQotCSQoY2FsbCBjbWQsZ2VuX2xpc3QpDQoraW5pdHJhbWZzX2xpc3Rfc3RhdGVfdXB0
b2RhdGUgOj0NCitpbml0cmFtZnNfbGlzdF9zdGF0ZV9vdXRvZmRhdGUgOj0NCitpbml0cmFtZnNf
bGlzdF9zdGF0ZV9taXNzaW5nIDo9DQorDQoraWZlcSAoJChjbWRfZ2VuX2xpc3QpLHVwdG9kYXRl
KQ0KKyAgaW5pdHJhbWZzX2xpc3Rfc3RhdGVfdXB0b2RhdGUgOj0gMQ0KK2Vsc2UNCisgIGlmZXEg
KCQoY21kX2dlbl9saXN0KSxtaXNzaW5nKQ0KKyAgICBpbml0cmFtZnNfbGlzdF9zdGF0ZV9taXNz
aW5nIDo9IDENCisgIGVsc2UNCisgICAgaW5pdHJhbWZzX2xpc3Rfc3RhdGVfb3V0b2ZkYXRlIDo9
IDENCisgIGVuZGlmDQorZW5kaWYNCisNCiskKG9iaikvJChpbml0cmFtZnNfbGlzdCk6IEZPUkNF
DQorCSQoaWYgJChuaXRyYW1mc19saXN0X3N0YXRlX3VwdG9kYXRlKSwsIFwNCisJICAkKGlmICQo
aW5pdHJhbWZzX2xpc3Rfc3RhdGVfb3V0b2ZkYXRlKSwgJChjYWxsIGNtZCxnZW5fbGlzdCksIFwN
CisJICAgICQoaWYgJChpbml0cmFtZnNfbGlzdF9zdGF0ZV9taXNzaW5nKSwgXA0KKwkgICAgICBA
ZWNobyAnRmlsZSAiJChzcmMpLyQoaW5pdHJhbWZzX2xpc3QpLnNoaXBwZWQiIGRvZXMgbm90IGV4
aXN0JzsgXA0KKwkgICAgICAvYmluL2ZhbHNlKSkpDQogDQogcXVpZXRfY21kX2NwaW8gPSBDUElP
ICAgICRADQotICAgICAgY21kX2NwaW8gPSAuLyQ8ICQoSU5JVFJBTUZTX0xJU1QpID4gJEANCisg
ICAgICBjbWRfY3BpbyA9IC4vJDwgJChvYmopLyQoaW5pdHJhbWZzX2xpc3QpID4gJEANCiANCi0k
KG9iaikvaW5pdHJhbWZzX2RhdGEuY3BpbzogJChvYmopL2dlbl9pbml0X2NwaW8gJChpbml0cmFt
ZnMteSkgJChJTklUUkFNRlNfTElTVCkgRk9SQ0UNCiskKG9iaikvaW5pdHJhbWZzX2RhdGEuY3Bp
bzogJChvYmopL2dlbl9pbml0X2NwaW8gJChpbml0cmFtZnMteSkgJChvYmopLyQoaW5pdHJhbWZz
X2xpc3QpIEZPUkNFDQogCSQoY2FsbCBpZl9jaGFuZ2VkLGNwaW8pDQogDQogdGFyZ2V0cyArPSBp
bml0cmFtZnNfZGF0YS5jcGlvDQpkaWZmIC11cHJOIC1YIGRvbnRkaWZmIGxpbnV4LTIuNi45LWJr
Ny5vcmlnL3Vzci9pbml0cmFtZnNfbGlzdCBsaW51eC0yLjYuOS1iazcvdXNyL2luaXRyYW1mc19s
aXN0DQotLS0gbGludXgtMi42LjktYms3Lm9yaWcvdXNyL2luaXRyYW1mc19saXN0CTIwMDQtMTAt
MjMgMTE6MjM6NTQuMDAwMDAwMDAwICswMjAwDQorKysgbGludXgtMi42LjktYms3L3Vzci9pbml0
cmFtZnNfbGlzdAkxOTcwLTAxLTAxIDAyOjAwOjAwLjAwMDAwMDAwMCArMDIwMA0KQEAgLTEsNSAr
MCwwIEBADQotIyBUaGlzIGlzIGEgdmVyeSBzaW1wbGUgaW5pdHJhbWZzIC0gbW9zdGx5IHByZWxp
bWluYXJ5IGZvciBmdXR1cmUgZXhwYW5zaW9uDQotDQotZGlyIC9kZXYgMDc1NSAwIDANCi1ub2Qg
L2Rldi9jb25zb2xlIDA2MDAgMCAwIGMgNSAxDQotZGlyIC9yb290IDA3MDAgMCAwDQpkaWZmIC11
cHJOIC1YIGRvbnRkaWZmIGxpbnV4LTIuNi45LWJrNy5vcmlnL3Vzci9pbml0cmFtZnNfbGlzdC5z
aGlwcGVkIGxpbnV4LTIuNi45LWJrNy91c3IvaW5pdHJhbWZzX2xpc3Quc2hpcHBlZA0KLS0tIGxp
bnV4LTIuNi45LWJrNy5vcmlnL3Vzci9pbml0cmFtZnNfbGlzdC5zaGlwcGVkCTE5NzAtMDEtMDEg
MDI6MDA6MDAuMDAwMDAwMDAwICswMjAwDQorKysgbGludXgtMi42LjktYms3L3Vzci9pbml0cmFt
ZnNfbGlzdC5zaGlwcGVkCTIwMDQtMTAtMjMgMTE6MjY6NTIuMDAwMDAwMDAwICswMjAwDQpAQCAt
MCwwICsxLDUgQEANCisjIFRoaXMgaXMgYSB2ZXJ5IHNpbXBsZSBpbml0cmFtZnMgLSBtb3N0bHkg
cHJlbGltaW5hcnkgZm9yIGZ1dHVyZSBleHBhbnNpb24NCisNCitkaXIgL2RldiAwNzU1IDAgMA0K
K25vZCAvZGV2L2NvbnNvbGUgMDYwMCAwIDAgYyA1IDENCitkaXIgL3Jvb3QgMDcwMCAwIDANCg==


--=-1PQntixpF0vg9Jvr8ZO7--

--=-RbJkIj8ulntF6MxfMIMl
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBeklEqburzKaJYLYRAmVTAKCRtt+OM1BaRbmLRPZcwUp5PpjXrQCcCYqf
Bd9ONyw9qHao8GZHm/nC37M=
=ECda
-----END PGP SIGNATURE-----

--=-RbJkIj8ulntF6MxfMIMl--

