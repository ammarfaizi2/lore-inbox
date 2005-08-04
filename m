Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261745AbVHDEod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261745AbVHDEod (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 00:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261793AbVHDEo1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 00:44:27 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:31911 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261745AbVHDEm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 00:42:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=uiiCpnB0CjrbOp2IViFvn9FjBQsgaJnJi1L4BKogIymV/+WoIEh0cTNQyV0XdFuGHDbwp+eRiRMZk2iKPnSNnjoFUyCDamY3ssEcOViDEy8LFQxCVr+mRwM2nFH+4sAk9GMmABcZfcARBQ6jKDsrqK/PdTm+Kp8YXTH/Wnh7rrE=
Message-ID: <8e6f9472050803214250821160@mail.gmail.com>
Date: Thu, 4 Aug 2005 00:42:54 -0400
From: Will Dyson <will.dyson@gmail.com>
Reply-To: Will Dyson <will.dyson@gmail.com>
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Obsolete files in 2.6 tree
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <42F145ED.2060008@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_786_28711948.1123130574769"
References: <42DED9F3.4040300@gmail.com> <42F145ED.2060008@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_786_28711948.1123130574769
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 8/3/05, Jiri Slaby <jirislaby@gmail.com> wrote:
> Jiri Slaby napsal(a):
>=20
> > fs/befs/attribute.c
>=20
> And what about entire befs? Is it used?
> Last change was made on 2002 and many features are still missing.

Well, don't know about anyone else, but I certainly don't use it
anymore. If anyone needs  a fully-functional befs driver, the easiest
route to that would probably be getting Haiku's befs driver to compile
in userland as a FUSE fs.

At any rate, attribute.c can go. It is easy enough to add back in if
anyone ever wants to do the (relativly minor) refactoring nessisary to
get it working.

Signed-off-by: Will Dyson <will.dyson@gmail.com>

diff -r 1e753e53161a fs/befs/attribute.c
--- a/fs/befs/attribute.c=09Tue Aug  2 13:00:13 2005
+++ /dev/null=09Thu Aug  4 00:31:20 2005
@@ -1,117 +0,0 @@
-/*
- * linux/fs/befs/attribute.c
- *
- * Copyright (C) 2002 Will Dyson <will_dyson@pobox.com>
- *
- * Many thanks to Dominic Giampaolo, author of "Practical File System
- * Design with the Be File System", for such a helpful book.
- *
- */
-
-#include <linux/fs.h>
-#include <linux/kernel.h>
-#include <linux/string.h>
-
-#include "befs.h"
-#include "endian.h"
-
-#define SD_DATA(sd)\
-=09(void*)((char*)sd + sizeof(*sd) + (sd->name_size - sizeof(sd->name)))
-
-#define SD_NEXT(sd)\
-=09(befs_small_data*)((char*)sd + sizeof(*sd) + (sd->name_size - \
-=09sizeof(sd->name) + sd->data_size))
-
-int
-list_small_data(struct super_block *sb, befs_inode * inode, filldir_t fill=
dir);
-
-befs_small_data *
-find_small_data(struct super_block *sb, befs_inode * inode,
-=09=09=09=09 const char *name);
-int
-read_small_data(struct super_block *sb, befs_inode * inode,
-=09=09 befs_small_data * sdata, void *buf, size_t bufsize);
-
-/**
- *
- *
- *
- *
- *
- */
-befs_small_data *
-find_small_data(struct super_block *sb, befs_inode * inode, const char *na=
me)
-{
-=09befs_small_data *sdata =3D inode->small_data;
-
-=09while (sdata->type !=3D 0) {
-=09=09if (strcmp(name, sdata->name) !=3D 0) {
-=09=09=09return sdata;
-=09=09}
-=09=09sdata =3D SD_NEXT(sdata);
-=09}
-=09return NULL;
-}
-
-/**
- *
- *
- *
- *
- *
- */
-int
-read_small_data(struct super_block *sb, befs_inode * inode,
-=09=09const char *name, void *buf, size_t bufsize)
-{
-=09befs_small_data *sdata;
-
-=09sdata =3D find_small_data(sb, inode, name);
-=09if (sdata =3D=3D NULL)
-=09=09return BEFS_ERR;
-=09else if (sdata->data_size > bufsize)
-=09=09return BEFS_ERR;
-
-=09memcpy(buf, SD_DATA(sdata), sdata->data_size);
-
-=09return BEFS_OK;
-}
-
-/**
- *
- *
- *
- *
- *
- */
-int
-list_small_data(struct super_block *sb, befs_inode * inode)
-{
-
-}
-
-/**
- *
- *
- *
- *
- *
- */
-int
-list_attr(struct super_block *sb, befs_inode * inode)
-{
-
-}
-
-/**
- *
- *
- *
- *
- *
- */
-int
-read_attr(struct super_block *sb, befs_inode * inode)
-{
-
-}


--=20
Will Dyson

------=_Part_786_28711948.1123130574769
Content-Type: text/x-patch; name="befs_attr_rm.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="befs_attr_rm.patch"

ZGlmZiAtciAxZTc1M2U1MzE2MWEgZnMvYmVmcy9hdHRyaWJ1dGUuYwotLS0gYS9mcy9iZWZzL2F0
dHJpYnV0ZS5jCVR1ZSBBdWcgIDIgMTM6MDA6MTMgMjAwNQorKysgL2Rldi9udWxsCVRodSBBdWcg
IDQgMDA6MzE6MjAgMjAwNQpAQCAtMSwxMTcgKzAsMCBAQAotLyoKLSAqIGxpbnV4L2ZzL2JlZnMv
YXR0cmlidXRlLmMKLSAqCi0gKiBDb3B5cmlnaHQgKEMpIDIwMDIgV2lsbCBEeXNvbiA8d2lsbF9k
eXNvbkBwb2JveC5jb20+Ci0gKgotICogTWFueSB0aGFua3MgdG8gRG9taW5pYyBHaWFtcGFvbG8s
IGF1dGhvciBvZiAiUHJhY3RpY2FsIEZpbGUgU3lzdGVtCi0gKiBEZXNpZ24gd2l0aCB0aGUgQmUg
RmlsZSBTeXN0ZW0iLCBmb3Igc3VjaCBhIGhlbHBmdWwgYm9vay4KLSAqCi0gKi8KLQotI2luY2x1
ZGUgPGxpbnV4L2ZzLmg+Ci0jaW5jbHVkZSA8bGludXgva2VybmVsLmg+Ci0jaW5jbHVkZSA8bGlu
dXgvc3RyaW5nLmg+Ci0KLSNpbmNsdWRlICJiZWZzLmgiCi0jaW5jbHVkZSAiZW5kaWFuLmgiCi0K
LSNkZWZpbmUgU0RfREFUQShzZClcCi0JKHZvaWQqKSgoY2hhciopc2QgKyBzaXplb2YoKnNkKSAr
IChzZC0+bmFtZV9zaXplIC0gc2l6ZW9mKHNkLT5uYW1lKSkpCi0KLSNkZWZpbmUgU0RfTkVYVChz
ZClcCi0JKGJlZnNfc21hbGxfZGF0YSopKChjaGFyKilzZCArIHNpemVvZigqc2QpICsgKHNkLT5u
YW1lX3NpemUgLSBcCi0Jc2l6ZW9mKHNkLT5uYW1lKSArIHNkLT5kYXRhX3NpemUpKQotCi1pbnQK
LWxpc3Rfc21hbGxfZGF0YShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBiZWZzX2lub2RlICogaW5v
ZGUsIGZpbGxkaXJfdCBmaWxsZGlyKTsKLQotYmVmc19zbWFsbF9kYXRhICoKLWZpbmRfc21hbGxf
ZGF0YShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBiZWZzX2lub2RlICogaW5vZGUsCi0JCQkJIGNv
bnN0IGNoYXIgKm5hbWUpOwotaW50Ci1yZWFkX3NtYWxsX2RhdGEoc3RydWN0IHN1cGVyX2Jsb2Nr
ICpzYiwgYmVmc19pbm9kZSAqIGlub2RlLAotCQkgYmVmc19zbWFsbF9kYXRhICogc2RhdGEsIHZv
aWQgKmJ1Ziwgc2l6ZV90IGJ1ZnNpemUpOwotCi0vKioKLSAqCi0gKgotICoKLSAqCi0gKgotICov
Ci1iZWZzX3NtYWxsX2RhdGEgKgotZmluZF9zbWFsbF9kYXRhKHN0cnVjdCBzdXBlcl9ibG9jayAq
c2IsIGJlZnNfaW5vZGUgKiBpbm9kZSwgY29uc3QgY2hhciAqbmFtZSkKLXsKLQliZWZzX3NtYWxs
X2RhdGEgKnNkYXRhID0gaW5vZGUtPnNtYWxsX2RhdGE7Ci0KLQl3aGlsZSAoc2RhdGEtPnR5cGUg
IT0gMCkgewotCQlpZiAoc3RyY21wKG5hbWUsIHNkYXRhLT5uYW1lKSAhPSAwKSB7Ci0JCQlyZXR1
cm4gc2RhdGE7Ci0JCX0KLQkJc2RhdGEgPSBTRF9ORVhUKHNkYXRhKTsKLQl9Ci0JcmV0dXJuIE5V
TEw7Ci19Ci0KLS8qKgotICoKLSAqCi0gKgotICoKLSAqCi0gKi8KLWludAotcmVhZF9zbWFsbF9k
YXRhKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIGJlZnNfaW5vZGUgKiBpbm9kZSwKLQkJY29uc3Qg
Y2hhciAqbmFtZSwgdm9pZCAqYnVmLCBzaXplX3QgYnVmc2l6ZSkKLXsKLQliZWZzX3NtYWxsX2Rh
dGEgKnNkYXRhOwotCi0Jc2RhdGEgPSBmaW5kX3NtYWxsX2RhdGEoc2IsIGlub2RlLCBuYW1lKTsK
LQlpZiAoc2RhdGEgPT0gTlVMTCkKLQkJcmV0dXJuIEJFRlNfRVJSOwotCWVsc2UgaWYgKHNkYXRh
LT5kYXRhX3NpemUgPiBidWZzaXplKQotCQlyZXR1cm4gQkVGU19FUlI7Ci0KLQltZW1jcHkoYnVm
LCBTRF9EQVRBKHNkYXRhKSwgc2RhdGEtPmRhdGFfc2l6ZSk7Ci0KLQlyZXR1cm4gQkVGU19PSzsK
LX0KLQotLyoqCi0gKgotICoKLSAqCi0gKgotICoKLSAqLwotaW50Ci1saXN0X3NtYWxsX2RhdGEo
c3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgYmVmc19pbm9kZSAqIGlub2RlKQotewotCi19Ci0KLS8q
KgotICoKLSAqCi0gKgotICoKLSAqCi0gKi8KLWludAotbGlzdF9hdHRyKHN0cnVjdCBzdXBlcl9i
bG9jayAqc2IsIGJlZnNfaW5vZGUgKiBpbm9kZSkKLXsKLQotfQotCi0vKioKLSAqCi0gKgotICoK
LSAqCi0gKgotICovCi1pbnQKLXJlYWRfYXR0cihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBiZWZz
X2lub2RlICogaW5vZGUpCi17Ci0KLX0K
------=_Part_786_28711948.1123130574769--
