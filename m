Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276950AbRJDTwe>; Thu, 4 Oct 2001 15:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276984AbRJDTw0>; Thu, 4 Oct 2001 15:52:26 -0400
Received: from mailf.telia.com ([194.22.194.25]:5063 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S276950AbRJDTwP>;
	Thu, 4 Oct 2001 15:52:15 -0400
Message-Id: <200110041952.f94JqSv14951@mailf.telia.com>
From: Roger Larsson <roger.larsson@norran.net>
To: andre@linux-ide.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scaling of 'max_readahead' in /proc/ide/hda/settings
Date: Thu, 4 Oct 2001 21:47:26 +0200
X-Mailer: KMail [version 1.3.1]
Cc: Robert Cohen <robert.cohen@anu.edu.au>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_2N5P3662PWBNKBQYESB4"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_2N5P3662PWBNKBQYESB4
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit

I put the note first since it is important:
-----------------------------------------------
NOTE: this scaling problem might be in several drivers and possibly
also in several places in this driver. Most likely in -ac too when
enabling dynamic readahead for SCSI
-----------------------------------------------

In an earlier message I reported that dynamically changing readahead
for ide disk produced unexpected results.

I have now found the reason!

If you did cat the /proc/ide/hda/settings you would have noticed that
max_readahead was zero. But reading the code you would see that
is initialized with MAX_READAHEAD (defined to 31)

I tried to modify this and got strange results when diffing two files bigger
than RAM. Sinusoidal between very good and very poor...
But modifying the MAX_READAHEAD and recompiling worked!

Both of these are due to the same problem with scaling in ide-disk.c

mul_factor = 1
div_factor = 1024

But max_readahead is measured in pages.

When reading the file max_readahead is divided by 1024, resulting
in zero.

A value written to it is on the other hand multiplied by 1024...

So when I tried to set 511 pages readahead (2MB) it was interpreted
as 511*1024 pages (2GB !) So it tried to read ahead all of one file
before trying to read the other (but one file is bigger than my memory)

With the included patch I measure in kB and limit it at 16MB.

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden

--------------Boundary-00=_2N5P3662PWBNKBQYESB4
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="patch-2.4.11-pre2-ide_settings"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="patch-2.4.11-pre2-ide_settings"

KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKgpQYXRjaCBwcmVwYXJl
ZCBieTogcm9nZXIubGFyc3NvbkBub3JyYW4ubmV0Ck5hbWUgb2YgZmlsZTogL2hvbWUvcm9nZXIv
cGF0Y2hlcy9wYXRjaC0yLjQuMTEtcHJlMi1pZGVfc2V0dGluZ3MKCi0tLSBsaW51eC9kcml2ZXJz
L2lkZS9pZGUtZGlzay5jLm9yaWcJVHVlIE9jdCAgMiAwMTowNTo0MSAyMDAxCisrKyBsaW51eC9k
cml2ZXJzL2lkZS9pZGUtZGlzay5jCVRodSBPY3QgIDQgMjE6MTU6MzYgMjAwMQpAQCAtNjkwLDcg
KzY5MCw3IEBACiAJaWRlX2FkZF9zZXR0aW5nKGRyaXZlLAkibXVsdGNvdW50IiwJCWlkID8gU0VU
VElOR19SVyA6IFNFVFRJTkdfUkVBRCwJCQlIRElPX0dFVF9NVUxUQ09VTlQsCUhESU9fU0VUX01V
TFRDT1VOVCwJVFlQRV9CWVRFLAkwLAlpZCA/IGlkLT5tYXhfbXVsdHNlY3QgOiAwLAkxLAkyLAkm
ZHJpdmUtPm11bHRfY291bnQsCQlzZXRfbXVsdGNvdW50KTsKIAlpZGVfYWRkX3NldHRpbmcoZHJp
dmUsCSJub3dlcnIiLAkJU0VUVElOR19SVywJCQkJCUhESU9fR0VUX05PV0VSUiwJSERJT19TRVRf
Tk9XRVJSLAlUWVBFX0JZVEUsCTAsCTEsCQkJCTEsCTEsCSZkcml2ZS0+bm93ZXJyLAkJCXNldF9u
b3dlcnIpOwogCWlkZV9hZGRfc2V0dGluZyhkcml2ZSwJImJyZWFkYV9yZWFkYWhlYWQiLAlTRVRU
SU5HX1JXLAkJCQkJQkxLUkFHRVQsCQlCTEtSQVNFVCwJCVRZUEVfSU5ULAkwLAkyNTUsCQkJCTEs
CTIsCSZyZWFkX2FoZWFkW21ham9yXSwJCU5VTEwpOwotCWlkZV9hZGRfc2V0dGluZyhkcml2ZSwJ
ImZpbGVfcmVhZGFoZWFkIiwJU0VUVElOR19SVywJCQkJCUJMS0ZSQUdFVCwJCUJMS0ZSQVNFVCwJ
CVRZUEVfSU5UQSwJMCwJSU5UX01BWCwJCQkxLAkxMDI0LAkmbWF4X3JlYWRhaGVhZFttYWpvcl1b
bWlub3JdLAlOVUxMKTsKKwlpZGVfYWRkX3NldHRpbmcoZHJpdmUsCSJmaWxlX3JlYWRhaGVhZCIs
CVNFVFRJTkdfUlcsCQkJCQlCTEtGUkFHRVQsCQlCTEtGUkFTRVQsCQlUWVBFX0lOVEEsCTAsCTQw
OTYsCQkJUEFHRV9TSVpFLAkxMDI0LAkmbWF4X3JlYWRhaGVhZFttYWpvcl1bbWlub3JdLAlOVUxM
KTsKIAlpZGVfYWRkX3NldHRpbmcoZHJpdmUsCSJtYXhfa2JfcGVyX3JlcXVlc3QiLAlTRVRUSU5H
X1JXLAkJCQkJQkxLU0VDVEdFVCwJCUJMS1NFQ1RTRVQsCQlUWVBFX0lOVEEsCTEsCTI1NSwJCQkJ
MSwJMiwJJm1heF9zZWN0b3JzW21ham9yXVttaW5vcl0sCU5VTEwpOwogCWlkZV9hZGRfc2V0dGlu
Zyhkcml2ZSwJImx1biIsCQkJU0VUVElOR19SVywJCQkJCS0xLAkJCS0xLAkJCVRZUEVfSU5ULAkw
LAk3LAkJCQkxLAkxLAkmZHJpdmUtPmx1biwJCQlOVUxMKTsKIAlpZGVfYWRkX3NldHRpbmcoZHJp
dmUsCSJmYWlsdXJlcyIsCQlTRVRUSU5HX1JXLAkJCQkJLTEsCQkJLTEsCQkJVFlQRV9JTlQsCTAs
CTY1NTM1LAkJCQkxLAkxLAkmZHJpdmUtPmZhaWx1cmVzLAkJTlVMTCk7Cg==

--------------Boundary-00=_2N5P3662PWBNKBQYESB4--
