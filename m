Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSF3UdF>; Sun, 30 Jun 2002 16:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313202AbSF3UdE>; Sun, 30 Jun 2002 16:33:04 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:31933 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP
	id <S313190AbSF3UdB>; Sun, 30 Jun 2002 16:33:01 -0400
Date: Sun, 30 Jun 2002 22:35:00 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
       Martin Dalecki <dalecki@evision-ventures.com>, <alex@ssi.bg>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: HDIO_GETGEO accessibility (was Re: [PATCH] 2.5.24 IDE 95 (fwd))
In-Reply-To: <20020630194920.GC3778@ppc.vc.cvut.cz>
Message-ID: <Pine.SOL.4.30.0206302201040.4857-200000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1804928587-1025469300=:4857"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1804928587-1025469300=:4857
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Sun, 30 Jun 2002, Petr Vandrovec wrote:

> On Sun, Jun 30, 2002 at 06:52:58PM +0200, Bartlomiej Zolnierkiewicz wrote:
> >
> > I hope you dont mind Petr.
>
> No problem.
>
> But I have one, unrelated... Today I found that VMware does not run
> on 2.5.24 with rawdisks for non-root users because of ioctl(hdd, HDIO_GETGEO, ...)
> is guarded by "if (!capable(CAP_SYS_ADMIN)) return -EACCES;". And so it
> fails although user has read-write access to /dev/hdX.
>
> Is this change really intentional? It is GET, not SET operation, and user has

It changed in IDE-60, comment in ioctl.c says that:

/* Contrary to popular beleve we disallow even the reading of the ioctl
 * values for users which don't have permission too. We do this becouse
 * such information could be used by an attacker to deply a simple-user
 * attack, which triggers bugs present only on a particular
 * configuration.
 */

But I dont think HDIO_GET_* can disclose any meaningful information
to attacker and attacker doesnt have direct access to hardware,
and if he has we have more serious problems to worry about.

[ There is more risk that application programmers will screw
  privilidged access, then attacker will get useful info :-) ]

So ata_ioctl() in ioctl.c needs trivial fix, untested one attached :).
It removes checks for CAP_SYS_ADMIN from HDIO_GET_* ioctls and adds
missing one to BLKRRPART ioctl (re-read partition table).

> access to /dev/hdX. If this change is intentional, I'll recommend VMware
> to gain priviledges around disk geometry accesses, but I do not think that
> user should need SYS_ADMIN for retrieving disk geometry.
> 					Thanks,
> 						Petr Vandrovec
> 						vandrove@vc.cvut.cz

Greets.
--
Bartlomiej

---559023410-1804928587-1025469300=:4857
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="ioctls-fix.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.SOL.4.30.0206302235000.4857@mion.elka.pw.edu.pl>
Content-Description: 
Content-Disposition: attachment; filename="ioctls-fix.diff"

LS0tIGxpbnV4LTIuNS4yNC9kcml2ZXJzL2lkZS9pb2N0bC5jCVdlZCBKdW4g
MjYgMDA6MDI6NTMgMjAwMg0KKysrIGxpbnV4L2RyaXZlcnMvaWRlL2lvY3Rs
LmMJU3VuIEp1biAzMCAyMjoxNjo1MCAyMDAyDQpAQCAtMTIyLDkgKzEyMiw2
IEBADQogCQljYXNlIEhESU9fR0VUXzMyQklUOiB7DQogCQkJdW5zaWduZWQg
bG9uZyB2YWwgPSBkcml2ZS0+Y2hhbm5lbC0+aW9fMzJiaXQ7DQogDQotCQkJ
aWYgKCFjYXBhYmxlKENBUF9TWVNfQURNSU4pKQ0KLQkJCQlyZXR1cm4gLUVB
Q0NFUzsNCi0NCiAJCQlpZiAocHV0X3VzZXIodmFsLCAodW5zaWduZWQgbG9u
ZyAqKSBhcmcpKQ0KIAkJCQlyZXR1cm4gLUVGQVVMVDsNCiAJCQlyZXR1cm4g
MDsNCkBAIC0xNzIsOSArMTY5LDYgQEANCiAJCWNhc2UgSERJT19HRVRfVU5N
QVNLSU5UUjogew0KIAkJCXVuc2lnbmVkIGxvbmcgdmFsID0gZHJpdmUtPmNo
YW5uZWwtPnVubWFzazsNCiANCi0JCQlpZiAoIWNhcGFibGUoQ0FQX1NZU19B
RE1JTikpDQotCQkJCXJldHVybiAtRUFDQ0VTOw0KLQ0KIAkJCWlmIChwdXRf
dXNlcih2YWwsICh1bnNpZ25lZCBsb25nICopIGFyZykpDQogCQkJCXJldHVy
biAtRUZBVUxUOw0KIA0KQEAgLTIwMiw5ICsxOTYsNiBAQA0KIAkJY2FzZSBI
RElPX0dFVF9ETUE6IHsNCiAJCQl1bnNpZ25lZCBsb25nIHZhbCA9IGRyaXZl
LT51c2luZ19kbWE7DQogDQotCQkJaWYgKCFjYXBhYmxlKENBUF9TWVNfQURN
SU4pKQ0KLQkJCQlyZXR1cm4gLUVBQ0NFUzsNCi0NCiAJCQlpZiAocHV0X3Vz
ZXIodmFsLCAodW5zaWduZWQgbG9uZyAqKSBhcmcpKQ0KIAkJCQlyZXR1cm4g
LUVGQVVMVDsNCiANCkBAIC0yMzYsOSArMjI3LDYgQEANCiAJCQlzdHJ1Y3Qg
aGRfZ2VvbWV0cnkgKmxvYyA9IChzdHJ1Y3QgaGRfZ2VvbWV0cnkgKikgYXJn
Ow0KIAkJCXVuc2lnbmVkIHNob3J0IGJpb3NfY3lsID0gZHJpdmUtPmJpb3Nf
Y3lsOyAvKiB0cnVuY2F0ZSAqLw0KIA0KLQkJCWlmICghY2FwYWJsZShDQVBf
U1lTX0FETUlOKSkNCi0JCQkJcmV0dXJuIC1FQUNDRVM7DQotDQogCQkJaWYg
KCFsb2MgfHwgKGRyaXZlLT50eXBlICE9IEFUQV9ESVNLICYmIGRyaXZlLT50
eXBlICE9IEFUQV9GTE9QUFkpKQ0KIAkJCQlyZXR1cm4gLUVJTlZBTDsNCiAN
CkBAIC0yNjEsOSArMjQ5LDYgQEANCiAJCWNhc2UgSERJT19HRVRHRU9fQklH
X1JBVzogew0KIAkJCXN0cnVjdCBoZF9iaWdfZ2VvbWV0cnkgKmxvYyA9IChz
dHJ1Y3QgaGRfYmlnX2dlb21ldHJ5ICopIGFyZzsNCiANCi0JCQlpZiAoIWNh
cGFibGUoQ0FQX1NZU19BRE1JTikpDQotCQkJCXJldHVybiAtRUFDQ0VTOw0K
LQ0KIAkJCWlmICghbG9jIHx8IChkcml2ZS0+dHlwZSAhPSBBVEFfRElTSyAm
JiBkcml2ZS0+dHlwZSAhPSBBVEFfRkxPUFBZKSkNCiAJCQkJcmV0dXJuIC1F
SU5WQUw7DQogDQpAQCAtMjg0LDggKzI2OSw2IEBADQogCQl9DQogDQogCQlj
YXNlIEhESU9fR0VUX0lERU5USVRZOg0KLQkJCWlmICghY2FwYWJsZShDQVBf
U1lTX0FETUlOKSkNCi0JCQkJcmV0dXJuIC1FQUNDRVM7DQogDQogCQkJaWYg
KG1pbm9yKGlub2RlLT5pX3JkZXYpICYgUEFSVE5fTUFTSykNCiAJCQkJcmV0
dXJuIC1FSU5WQUw7DQpAQCAtMjk5LDggKzI4Miw2IEBADQogCQkJcmV0dXJu
IDA7DQogDQogCQljYXNlIEhESU9fR0VUX05JQ0U6DQotCQkJaWYgKCFjYXBh
YmxlKENBUF9TWVNfQURNSU4pKQ0KLQkJCQlyZXR1cm4gLUVBQ0NFUzsNCiAN
CiAJCQlyZXR1cm4gcHV0X3VzZXIoZHJpdmUtPmRzY19vdmVybGFwIDw8IElE
RV9OSUNFX0RTQ19PVkVSTEFQIHwNCiAJCQkJCWRyaXZlLT5hdGFwaV9vdmVy
bGFwIDw8IElERV9OSUNFX0FUQVBJX09WRVJMQVAsDQpAQCAtMzIzLDggKzMw
NCw2IEBADQogCQkJcmV0dXJuIDA7DQogDQogCQljYXNlIEhESU9fR0VUX0JV
U1NUQVRFOg0KLQkJCWlmICghY2FwYWJsZShDQVBfU1lTX0FETUlOKSkNCi0J
CQkJcmV0dXJuIC1FQUNDRVM7DQogDQogCQkJaWYgKHB1dF91c2VyKGRyaXZl
LT5jaGFubmVsLT5idXNfc3RhdGUsIChsb25nICopYXJnKSkNCiAJCQkJcmV0
dXJuIC1FRkFVTFQ7DQpAQCAtMzYyLDYgKzM0MSw5IEBADQogCQkJcmV0dXJu
IGJsb2NrX2lvY3RsKGlub2RlLT5pX2JkZXYsIGNtZCwgYXJnKTsNCiANCiAJ
CWNhc2UgQkxLUlJQQVJUOiAvKiBSZS1yZWFkIHBhcnRpdGlvbiB0YWJsZXMg
Ki8NCisJCQlpZiAoIWNhcGFibGUoQ0FQX1NZU19BRE1JTikpDQorCQkJCXJl
dHVybiAtRUFDQ0VTOw0KKw0KIAkJCXJldHVybiBhdGFfcmV2YWxpZGF0ZShp
bm9kZS0+aV9yZGV2KTsNCiANCiAJCWNhc2UgQkxLR0VUU0laRToNCg==
---559023410-1804928587-1025469300=:4857--
