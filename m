Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268184AbUIGPxV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268184AbUIGPxV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 11:53:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268474AbUIGPuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 11:50:54 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:38832 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S268342AbUIGPtS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 11:49:18 -0400
Date: Tue, 7 Sep 2004 17:49:14 +0200 (CEST)
From: Michal Ludvig <michal@logix.cz>
To: Andreas Happe <crow@old-fsckful.ath.cx>
Cc: Andreas Happe <andreashappe@flatline.ath.cx>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, James Morris <jmorris@redhat.com>
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
In-Reply-To: <20040907143509.GA30920@old-fsckful.ath.cx>
Message-ID: <Pine.LNX.4.53.0409071659070.19015@maxipes.logix.cz>
References: <20040831175449.GA2946@final-judgement.ath.cx>
 <Xine.LNX.4.44.0409010043020.30561-100000@thoron.boston.redhat.com>
 <20040901082819.GA2489@final-judgement.ath.cx> <Pine.LNX.4.53.0409061847000.25698@maxipes.logix.cz>
 <20040907143509.GA30920@old-fsckful.ath.cx>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="5333482-453639431-1094572154=:19015"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--5333482-453639431-1094572154=:19015
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 7 Sep 2004, Andreas Happe wrote:

> On Mon, Sep 06, 2004 at 08:49:30PM +0200, Michal Ludvig wrote:
> > On Wed, 1 Sep 2004, Andreas Happe wrote:
> > > the attached patch creates a /sys/cryptoapi/<cipher-name>/ hierarchie
>
> BTW: the latest incarnation of the patch uses /sys/class/crypto/<cipher-n=
ame>.

Where can I get the updated version?

> > I'd prefer to have the algorithms grouped by "type" ("cipher", "digest"=
,
> > "compress")? Then the apps could easily see only the algos that thay ar=
e
> > interested in...
>
> jup, but the seqfile code in proc.c would get a lot more uglier. If we co=
uld
> drop proc.c this wouldn=B4t be a problem.

Hopefully we can ;-) Or does anyone use it? There are not that much
userspace programs in any way interacting with the kernel cryptoapi...

> > Few notes:
> > - - some algorithms allow only discrete set of keysizes (e.g. AES can d=
o
> > 128b, 192b and 256b). Can we instead of min/max have a file 'keysize' w=
ith
> > either:
> > =09minsize-maxsize
> > or
> > =09size1,size2,size3
> > ?
> >
> > - - ditto for blocksize?
>
> how would you implement this in the crypto_alg struture? The sysfs/procfs
> integration isn't that problem.

This is a compile time thing, e.g. something like:
=09.cia_min_keysize =3D 1,
=09.cia_max_keysize =3D 128
for variable keysizes, and
=09.cia_keysizes =3D { 128, 192, 256, -1 }
for discrete keysizes.
typeof(cia_keysizes) would be "int[]".

> > - - With the future support for hardware crypto accelerators it
> > might be possible to have more modules loaded providing the same
> > algorithm. They may have different priorities and one would be treated =
as
> > "default". Then I expect the syntax of 'module' file to change from a
> > simple module name to something like:
> > =09# modname:prio:type:whatever
> > =09aes:0:generic:
> > =09aes_i586:1:optimized:
> > =09padlock:2:hardware:default
>
> Isn't this against the "one value per file" - sysfs rule.

I didn't know about such a rule. If it is that strict we could have a
subdir modules with a node for each module (aes, aes_i586, padlock, ...)
and a symlink (are symlinks allowed in sysfs?) default pointing to the one
with highest preference.

Attached is my patch introducing preferences for current cryptoapi. How
can this be done with the kobject model?

- During registration the kobject for a given algo should be looked up. If
found (i.e. there already is a module loaded) the new module would be
somehow "attached" to it. If not found a new kobject for the algo would be
created and then the first module attached to it.

- During lookup the kobject for a requested algo will be further examined
and the "struct crypto_alg" of the most preferenced module will be
returned.

Could this be done? (I don't know too much about sysfs and kobjects).

Michal Ludvig
--=20
* A mouse is a device used to point at the xterm you want to type in.
* Personal homepage - http://www.logix.cz/michal
--5333482-453639431-1094572154=:19015
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="crypto-api-pref.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.53.0409071749140.19015@maxipes.logix.cz>
Content-Description: 
Content-Disposition: attachment; filename="crypto-api-pref.diff"

SW5kZXg6IGxpbnV4LTIuNi43L2NyeXB0by9hcGkuYw0KPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PQ0KLS0tIGxpbnV4LTIuNi43Lm9yaWcvY3J5cHRvL2FwaS5j
DQorKysgbGludXgtMi42LjcvY3J5cHRvL2FwaS5jDQpAQCAtNDMsMTQgKzQz
LDE2IEBADQogCWRvd25fcmVhZCgmY3J5cHRvX2FsZ19zZW0pOw0KIAkNCiAJ
bGlzdF9mb3JfZWFjaF9lbnRyeShxLCAmY3J5cHRvX2FsZ19saXN0LCBjcmFf
bGlzdCkgew0KLQkJaWYgKCEoc3RyY21wKHEtPmNyYV9uYW1lLCBuYW1lKSkp
IHsNCi0JCQlpZiAoY3J5cHRvX2FsZ19nZXQocSkpDQotCQkJCWFsZyA9IHE7
DQotCQkJYnJlYWs7DQotCQl9DQorCQlpZiAoIShzdHJjbXAocS0+Y3JhX25h
bWUsIG5hbWUpKQ0KKwkJICAgICYmICghYWxnIHx8IGFsZy0+Y3JhX3ByZWZl
cmVuY2UgPCBxLT5jcmFfcHJlZmVyZW5jZSkpDQorCQkJYWxnID0gcTsNCiAJ
fQ0KIAkNCisJaWYgKGFsZyAmJiAhY3J5cHRvX2FsZ19nZXQoYWxnKSkNCisJ
CWFsZyA9IE5VTEw7DQorDQogCXVwX3JlYWQoJmNyeXB0b19hbGdfc2VtKTsN
CisNCiAJcmV0dXJuIGFsZzsNCiB9DQogDQpAQCAtMTYzLDIwICsxNjUsMTEg
QEANCiBpbnQgY3J5cHRvX3JlZ2lzdGVyX2FsZyhzdHJ1Y3QgY3J5cHRvX2Fs
ZyAqYWxnKQ0KIHsNCiAJaW50IHJldCA9IDA7DQotCXN0cnVjdCBjcnlwdG9f
YWxnICpxOw0KIAkNCiAJZG93bl93cml0ZSgmY3J5cHRvX2FsZ19zZW0pOw0K
LQkNCi0JbGlzdF9mb3JfZWFjaF9lbnRyeShxLCAmY3J5cHRvX2FsZ19saXN0
LCBjcmFfbGlzdCkgew0KLQkJaWYgKCEoc3RyY21wKHEtPmNyYV9uYW1lLCBh
bGctPmNyYV9uYW1lKSkpIHsNCi0JCQlyZXQgPSAtRUVYSVNUOw0KLQkJCWdv
dG8gb3V0Ow0KLQkJfQ0KLQl9DQotCQ0KIAlsaXN0X2FkZF90YWlsKCZhbGct
PmNyYV9saXN0LCAmY3J5cHRvX2FsZ19saXN0KTsNCi1vdXQ6CQ0KIAl1cF93
cml0ZSgmY3J5cHRvX2FsZ19zZW0pOw0KKw0KIAlyZXR1cm4gcmV0Ow0KIH0N
CiANCkluZGV4OiBsaW51eC0yLjYuNy9pbmNsdWRlL2xpbnV4L2NyeXB0by5o
DQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09DQotLS0gbGludXgtMi42Ljcub3Jp
Zy9pbmNsdWRlL2xpbnV4L2NyeXB0by5oDQorKysgbGludXgtMi42LjcvaW5j
bHVkZS9saW51eC9jcnlwdG8uaA0KQEAgLTU2LDYgKzU3LDEwIEBADQogI2Rl
ZmluZSBDUllQVE9fVU5TUEVDCQkJMA0KICNkZWZpbmUgQ1JZUFRPX01BWF9B
TEdfTkFNRQkJNjQNCiANCisjZGVmaW5lIENSWVBUT19QUkVGX0dFTkVSSUMJ
CTANCisjZGVmaW5lIENSWVBUT19QUkVGX09QVElNSVpFRAkJMTANCisjZGVm
aW5lIENSWVBUT19QUkVGX0hBUkRBV1JFCQkyMA0KKw0KIHN0cnVjdCBzY2F0
dGVybGlzdDsNCiANCiAvKg0KQEAgLTk5LDYgKzExOCw3IEBADQogCXVuc2ln
bmVkIGludCBjcmFfYmxvY2tzaXplOw0KIAl1bnNpZ25lZCBpbnQgY3JhX2N0
eHNpemU7DQogCWNvbnN0IGNoYXIgY3JhX25hbWVbQ1JZUFRPX01BWF9BTEdf
TkFNRV07DQorCXVuc2lnbmVkIGludCBjcmFfcHJlZmVyZW5jZTsNCiANCiAJ
dW5pb24gew0KIAkJc3RydWN0IGNpcGhlcl9hbGcgY2lwaGVyOw0K

--5333482-453639431-1094572154=:19015--
