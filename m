Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750889AbVHWH4F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750889AbVHWH4F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 03:56:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750910AbVHWH4F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 03:56:05 -0400
Received: from nproxy.gmail.com ([64.233.182.198]:47246 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750889AbVHWH4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 03:56:04 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:references;
        b=st8SK9JPSEY+6X5m7H0xnwvp/wbd5yiKDC+lnSNpDIArXSNiCiB50/uy3Qld3PDdwXaNSLgjifnK42IgpbwkT1cSJxpZkKG2bpiT6wVsGKAjwfcrFd32BWpvVca5CDWSrDUs7P1cd2t2lfCq9O8+ixnn5G+w66FKh9fNKae2EVA=
Message-ID: <84144f02050823005573569fcb@mail.gmail.com>
Date: Tue, 23 Aug 2005 10:55:58 +0300
From: Pekka Enberg <penberg@gmail.com>
To: Nathan Scott <nathans@sgi.com>
Subject: Re: sysfs: write returns ENOMEM?
Cc: Dmitry Torokhov <dtor_core@ameritech.net>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Christoph Hellwig <hch@infradead.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <20050823073258.GE743@frodo>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_1202_17087218.1124783758930"
References: <11394.1124781401@kao2.melbourne.sgi.com>
	 <200508190055.25747.dtor_core@ameritech.net>
	 <20050823073258.GE743@frodo>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_1202_17087218.1124783758930
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On 8/23/05, Nathan Scott <nathans@sgi.com> wrote:
> FWIW, all filesystems using the generic page cache routines are able
> to return this - see mm/filemap.c -> generic_file_buffered_write...

I don't think it makes much sense to fix this in individual
filesystems as many functions returning -NOMEM can be used in other
paths as well where they're ok.

Andrew, please consider picking this up for -mm. (I've included it as
an attachment as well as gmail will surely mess up the patch. Sorry.)

                               Pekka

[PATCH] VFS: return ENOBUFS instead of ENOMEM for vfs_write()

As noticed by Dmitry Torokhov, write() can not return ENOMEM:

http://www.opengroup.org/onlinepubs/000095399/functions/write.html

Currently almost all filesystems can return -ENOMEM due to
generic_file_buffered_write() in mm/filemap.c so filter out the invalid
error code in vfs_write().

Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>
---

 read_write.c |    2 ++
 1 files changed, 2 insertions(+)

Index: 2.6-mm/fs/read_write.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 2.6-mm.orig/fs/read_write.c
+++ 2.6-mm/fs/read_write.c
@@ -310,6 +310,8 @@ ssize_t vfs_write(struct file *file, con
                }
        }

+       if (ret =3D=3D -ENOMEM)
+               ret =3D -ENOBUFS;
        return ret;
 }

------=_Part_1202_17087218.1124783758930
Content-Type: text/x-patch; name="vfs-vfs_write-return-ENOBUFS-instead-ENOMEM.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="vfs-vfs_write-return-ENOBUFS-instead-ENOMEM.patch"

W1BBVENIXSBWRlM6IHJldHVybiBFTk9CVUZTIGluc3RlYWQgb2YgRU5PTUVNIGZvciB2ZnNfd3Jp
dGUoKQoKQXMgbm90aWNlZCBieSBEbWl0cnkgVG9yb2tob3YsIHdyaXRlKCkgY2FuIG5vdCByZXR1
cm4gRU5PTUVNOgoKaHR0cDovL3d3dy5vcGVuZ3JvdXAub3JnL29ubGluZXB1YnMvMDAwMDk1Mzk5
L2Z1bmN0aW9ucy93cml0ZS5odG1sCgpDdXJyZW50bHkgYWxtb3N0IGFsbCBmaWxlc3lzdGVtcyBj
YW4gcmV0dXJuIC1FTk9NRU0gZHVlIHRvCmdlbmVyaWNfZmlsZV9idWZmZXJlZF93cml0ZSgpIGlu
IG1tL2ZpbGVtYXAuYyBzbyBmaWx0ZXIgb3V0IHRoZSBpbnZhbGlkCmVycm9yIGNvZGUgaW4gdmZz
X3dyaXRlKCkuCgpTaWduZWQtb2ZmLWJ5OiBQZWtrYSBFbmJlcmcgPHBlbmJlcmdAY3MuaGVsc2lu
a2kuZmk+Ci0tLQoKIHJlYWRfd3JpdGUuYyB8ICAgIDIgKysKIDEgZmlsZXMgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspCgpJbmRleDogMi42LW1tL2ZzL3JlYWRfd3JpdGUuYwo9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0t
LSAyLjYtbW0ub3JpZy9mcy9yZWFkX3dyaXRlLmMKKysrIDIuNi1tbS9mcy9yZWFkX3dyaXRlLmMK
QEAgLTMxMCw2ICszMTAsOCBAQCBzc2l6ZV90IHZmc193cml0ZShzdHJ1Y3QgZmlsZSAqZmlsZSwg
Y29uCiAJCX0KIAl9CiAKKwlpZiAocmV0ID09IC1FTk9NRU0pCisJCXJldCA9IC1FTk9CVUZTOwog
CXJldHVybiByZXQ7CiB9CiAK
------=_Part_1202_17087218.1124783758930--
