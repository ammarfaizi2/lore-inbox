Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269500AbUJLHjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269500AbUJLHjM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 03:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269501AbUJLHjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 03:39:12 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:24369
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S269500AbUJLHjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 03:39:06 -0400
Message-Id: <s16b9829.049@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 6.5.2 Beta
Date: Tue, 12 Oct 2004 09:39:10 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <lizzi@cnam.fr>
Cc: <linux-kernel@vger.kernel.org>
Subject: linux build problem with
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__PartC6E6E10E.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__PartC6E6E10E.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Christophe,

building a kernel with distinct source and object trees I noted that
there is a consistent (but ignored) failure in generating the fore200e
firmware images. The problem is that in such a configuration there
simply is no include/asm link in the source tree. Consequently, a change
similar to the one below is necessary (this one's against a SuSE
derivate of 2.6.5, but checking with the 2.6.8.1 sources shows that the
relevant code doesn't seem to have changed).

Regards, Jan

--- drivers/atm/Makefile.0	2004-04-04 05:36:15.000000000 +0200
+++ drivers/atm/Makefile	2004-10-12 09:22:04.569674328 +0200
@@ -39,7 +39,8 @@ ifeq ($(CONFIG_ATM_FORE200E_PCA),y)
   fore_200e-objs		+= fore200e_pca_fw.o
   # guess the target endianess to choose the right PCA-200E firmware
image
   ifeq ($(CONFIG_ATM_FORE200E_PCA_DEFAULT_FW),y)
-    CONFIG_ATM_FORE200E_PCA_FW = $(shell if test -n "`$(CC) -E -dM
$(src)/../../include/asm/byteorder.h | grep ' __LITTLE_ENDIAN '`"; then
echo $(obj)/pca200e.bin; else echo $(obj)/pca200e_ecd.bin2; fi)
+    byteorder.h                 := include$(if $(patsubst
$(srctree),,$(objtree)),2)/asm/byteorder.h
+    CONFIG_ATM_FORE200E_PCA_FW  := $(obj)/pca200e$(if $(shell $(CC) -E
-dM $(byteorder.h) | grep ' __LITTLE_ENDIAN '),.bin,_ecd.bin2)
   endif
 endif
 


--=__PartC6E6E10E.1__=
Content-Type: application/octet-stream; name="fore200e.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="fore200e.patch"

LS0tIGRyaXZlcnMvYXRtL01ha2VmaWxlLjAJMjAwNC0wNC0wNCAwNTozNjoxNS4wMDAwMDAwMDAg
KzAyMDAKKysrIGRyaXZlcnMvYXRtL01ha2VmaWxlCTIwMDQtMTAtMTIgMDk6MjI6MDQuNTY5Njc0
MzI4ICswMjAwCkBAIC0zOSw3ICszOSw4IEBAIGlmZXEgKCQoQ09ORklHX0FUTV9GT1JFMjAwRV9Q
Q0EpLHkpCiAgIGZvcmVfMjAwZS1vYmpzCQkrPSBmb3JlMjAwZV9wY2FfZncubwogICAjIGd1ZXNz
IHRoZSB0YXJnZXQgZW5kaWFuZXNzIHRvIGNob29zZSB0aGUgcmlnaHQgUENBLTIwMEUgZmlybXdh
cmUgaW1hZ2UKICAgaWZlcSAoJChDT05GSUdfQVRNX0ZPUkUyMDBFX1BDQV9ERUZBVUxUX0ZXKSx5
KQotICAgIENPTkZJR19BVE1fRk9SRTIwMEVfUENBX0ZXID0gJChzaGVsbCBpZiB0ZXN0IC1uICJg
JChDQykgLUUgLWRNICQoc3JjKS8uLi8uLi9pbmNsdWRlL2FzbS9ieXRlb3JkZXIuaCB8IGdyZXAg
JyBfX0xJVFRMRV9FTkRJQU4gJ2AiOyB0aGVuIGVjaG8gJChvYmopL3BjYTIwMGUuYmluOyBlbHNl
IGVjaG8gJChvYmopL3BjYTIwMGVfZWNkLmJpbjI7IGZpKQorICAgIGJ5dGVvcmRlci5oICAgICAg
ICAgICAgICAgICA6PSBpbmNsdWRlJChpZiAkKHBhdHN1YnN0ICQoc3JjdHJlZSksLCQob2JqdHJl
ZSkpLDIpL2FzbS9ieXRlb3JkZXIuaAorICAgIENPTkZJR19BVE1fRk9SRTIwMEVfUENBX0ZXICA6
PSAkKG9iaikvcGNhMjAwZSQoaWYgJChzaGVsbCAkKENDKSAtRSAtZE0gJChieXRlb3JkZXIuaCkg
fCBncmVwICcgX19MSVRUTEVfRU5ESUFOICcpLC5iaW4sX2VjZC5iaW4yKQogICBlbmRpZgogZW5k
aWYKIAo=

--=__PartC6E6E10E.1__=--
