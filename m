Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277000AbRJCVrt>; Wed, 3 Oct 2001 17:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277002AbRJCVrd>; Wed, 3 Oct 2001 17:47:33 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:20495 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S277000AbRJCVrV>; Wed, 3 Oct 2001 17:47:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.4418.65
content-class: urn:content-classes:message
Subject: [PATCH] kiobuf_init optimization
Date: Wed, 3 Oct 2001 16:47:11 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E106410AA5A@cceexc18.americas.cpqcorp.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C14C54.F4D52C58"
Thread-Topic: [PATCH] kiobuf_init optimization
Thread-Index: AcFMUn3vt3Yw5kp4QuSlBhGrQkzZ7w==
From: "Bond, Andrew" <Andrew.Bond@COMPAQ.com>
To: <linux-kernel@vger.kernel.org>
Cc: "Nikolaiev, Mike" <Mike.Nikolaiev@COMPAQ.com>,
        "Jamshed Patel (E-mail)" <Jamshed.Patel@oracle.com>
X-OriginalArrivalTime: 03 Oct 2001 21:47:11.0976 (UTC) FILETIME=[F550C680:01C14C54]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C14C54.F4D52C58
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

	I have come up with a change to the kiobuf_init() routine that
drops the blind memset() to 0 of the entire kiobuf structure and zeros
out 3 specific fields instead.  Since this is done on every IO and the
kiobuf structure is over 8K in size (8756 bytes I believe) it becomes
quite costly from a cpu cycle perspective as well as a cache utilization
perspective.  The typical IO path uses a small subset of the
preallocated fields within the kiobuf structure.  Therefore, the IO path
pays a performance penalty for having to zero out many fields that it
typically doesn't use.

	The kiobuf_init() routine using a memset() of the entire kiobuf
structure is in the top 10 of cpu consuming kernel routines in Oracle 9i
testing using raw io.  Using the included kiobuf_init patch, our testing
has shown a 5% improvement in Oracle transactional performance in 4 and
8 processor configurations, and the kiobuf_init() routine became a
non-issue for performance.  The testing was performed with Oracle, but
this patch could provide performance improvements to any application
that uses raw IO or relies on kiobufs in the IO path.

	Obviously, since the structure is no longer set to zero, any
code that makes a zero assumption would break.  I haven't come across
code that makes this assumption yet for fields that I did not
specifically zero out in the patch, but I could very well be missing
something.  It appears that Alan has included this patch in his
2.4.10-ac4 tree.  So, let me know if you have any problems that you
think might be related to this patch.   Any input would be greatly
appreciated.

	The patch is against a 2.4.9 tree, but it is localized to just
the kiobuf_init() routine and should apply to any of the recent kernels.

	Run from the root level of your kernel tree: =20
		patch -p1 < kiobuf_init_speedup.patch=20

	I cannot currently receive the kernel mailing list at this email
address, so please cc: me on posts related to this patch.

Thanks,
Andrew Bond

 <<kiobuf_init_speedup.patch>>=20

------_=_NextPart_001_01C14C54.F4D52C58
Content-Type: application/octet-stream;
	name="kiobuf_init_speedup.patch"
Content-Transfer-Encoding: base64
Content-Description: kiobuf_init_speedup.patch
Content-Disposition: attachment;
	filename="kiobuf_init_speedup.patch"

LS0tIGxpbnV4LTIuNC45L2ZzL2lvYnVmLmMJRnJpIFNlcCAyOCAxMzo1NzoyMSAyMDAxCisrKyBs
aW51eC0yLjQuOV9wcm9mL2ZzL2lvYnVmLmMJV2VkIE9jdCAgMyAyMTowOTo1MSAyMDAxCkBAIC00
MywxMCArNDMsMTIgQEAKIAogc3RhdGljIHZvaWQga2lvYnVmX2luaXQoc3RydWN0IGtpb2J1ZiAq
aW9idWYpCiB7Ci0JbWVtc2V0KGlvYnVmLCAwLCBzaXplb2YoKmlvYnVmKSk7CiAJaW5pdF93YWl0
cXVldWVfaGVhZCgmaW9idWYtPndhaXRfcXVldWUpOwogCWlvYnVmLT5hcnJheV9sZW4gPSBLSU9f
U1RBVElDX1BBR0VTOwogCWlvYnVmLT5tYXBsaXN0ICAgPSBpb2J1Zi0+bWFwX2FycmF5OworCWlv
YnVmLT5ucl9wYWdlcyA9IDA7CisJaW9idWYtPmxvY2tlZCA9IDA7CisJaW9idWYtPmlvX2NvdW50
LmNvdW50ZXIgPSAwOwogfQogCiBpbnQgYWxsb2Nfa2lvYnVmX2JocyhzdHJ1Y3Qga2lvYnVmICog
a2lvYnVmKQo=

------_=_NextPart_001_01C14C54.F4D52C58--
