Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266042AbUBCRsF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 12:48:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266049AbUBCRsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 12:48:05 -0500
Received: from wblv-254-118.telkomadsl.co.za ([165.165.254.118]:8584 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S266042AbUBCRrt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 12:47:49 -0500
Subject: Re: module-init-tools/udev and module auto-loading
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Greg KH <greg@kroah.com>, viro@parcelfarce.linux.theplanet.co.uk,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>
In-Reply-To: <20040203010224.4CF742C261@lists.samba.org>
References: <20040203010224.4CF742C261@lists.samba.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-hkUO1UieWn2T3HiDPFzR"
Message-Id: <1075830486.7473.32.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 03 Feb 2004 19:48:06 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-hkUO1UieWn2T3HiDPFzR
Content-Type: multipart/mixed; boundary="=-a7/mUINF4NA+/HxosZqZ"


--=-a7/mUINF4NA+/HxosZqZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-02-03 at 02:55, Rusty Russell wrote:
> In message <1075748550.6931.10.camel@nosferatu.lan> you write:
> > > This does not cover the class of things which are entirely created by
> > > the driver (eg. dummy devices, socket families), so cannot be
> > > "detected".  Many of these (eg. socket families) can be handled by
> > > explicit request_module() in the core and MODULE_ALIAS in the driver.
> > > Some of them cannot at the moment: the first the kernel knows of them
> > > is an attempt to open the device.  Some variant of devfs would solve
> > > this.
> > >=20
> >=20
> > I guess there will be cries of murder if 'somebody' suggested that if
> > a node in /dev is opened, but not there, the kernel can call
> > 'modprobe -q /dev/foo' to load whatever alias there might have been?
>=20
> I think it's an excellent idea, although ideally we would have this
> mechanism in userspace as much as possible.  Anything from some
> special hack to block -ENOENT on directory lookups and notify an fd,
> to some exotic overlay filesystem.
>=20

Something like attached.  Besides me not knowing if there is a better
place for it, it have the following issues:

1) Its a bit racy - iow, I get this (but only for urandom):

  request_module: runaway loop modprobe /dev/urandom

I am not sure if its the kthread patches with the one for
kthread use in modules that contributes to this (have not
checked yet).

2) Although it does work (load the right module), it seems to do it
too late.  I have removed the sleep in udev, so it cannot be this.
I do not know if this might be another kthread contribution (if I
understand the module/kthread patches correctly).  It does seem from
the request_module code though that it 'should' wait for modprobe to
complete ...  Maybe add some sort of locking (this be efficient?)?

3) Might be nice to keep track of "/dev/foo" 'aliases' that modprobe
fails for, and not try them again.

4) It only works if the whatever opened's name start with "/dev/", but
I do not think that is an issue, as it should (?) be how most things
access nodes, and should minimise complexity.

I know its very basic, I just thought to get something out of the
door for discussion and to give direction (or what direction not to
take ...).


Thanks,

--=20
Martin Schlemmer

--=-a7/mUINF4NA+/HxosZqZ
Content-Disposition: attachment; filename=mod-autoload.patch
Content-Type: text/x-patch; name=mod-autoload.patch; charset=UTF-8
Content-Transfer-Encoding: base64

LS0tIDEvZnMvbmFtZWkuYwkyMDA0LTAyLTAzIDE0OjM1OjE2LjAwMDAwMDAwMCArMDIwMA0KKysr
IDIvZnMvbmFtZWkuYwkyMDA0LTAyLTAzIDE3OjIwOjIxLjAwMDAwMDAwMCArMDIwMA0KQEAgLTEy
NDAsNyArMTI0MCw3IEBAIGludCBvcGVuX25hbWVpKGNvbnN0IGNoYXIgKiBwYXRobmFtZSwgaW4N
CiAJaW50IGFjY19tb2RlLCBlcnJvciA9IDA7DQogCXN0cnVjdCBkZW50cnkgKmRlbnRyeTsNCiAJ
c3RydWN0IGRlbnRyeSAqZGlyOw0KLQlpbnQgY291bnQgPSAwOw0KKwlpbnQgY291bnQgPSAwLCBy
ZXRyeSA9IDA7DQogDQogCWFjY19tb2RlID0gQUNDX01PREUoZmxhZyk7DQogDQpAQCAtMTI1Mywx
MyArMTI1MywxNCBAQCBpbnQgb3Blbl9uYW1laShjb25zdCBjaGFyICogcGF0aG5hbWUsIGluDQog
CW5kLT5pbnRlbnQub3Blbi5mbGFncyA9IGZsYWc7DQogCW5kLT5pbnRlbnQub3Blbi5jcmVhdGVf
bW9kZSA9IG1vZGU7DQogDQorcmV0cnlfb3BlbjoNCiAJLyoNCiAJICogVGhlIHNpbXBsZXN0IGNh
c2UgLSBqdXN0IGEgcGxhaW4gbG9va3VwLg0KIAkgKi8NCiAJaWYgKCEoZmxhZyAmIE9fQ1JFQVQp
KSB7DQogCQllcnJvciA9IHBhdGhfbG9va3VwKHBhdGhuYW1lLCBsb29rdXBfZmxhZ3MoZmxhZyl8
TE9PS1VQX09QRU4sIG5kKTsNCiAJCWlmIChlcnJvcikNCi0JCQlyZXR1cm4gZXJyb3I7DQorCQkJ
Z290byBlcnJvcjsNCiAJCWRlbnRyeSA9IG5kLT5kZW50cnk7DQogCQlnb3RvIG9rOw0KIAl9DQpA
QCAtMTI2OSw3ICsxMjcwLDcgQEAgaW50IG9wZW5fbmFtZWkoY29uc3QgY2hhciAqIHBhdGhuYW1l
LCBpbg0KIAkgKi8NCiAJZXJyb3IgPSBwYXRoX2xvb2t1cChwYXRobmFtZSwgTE9PS1VQX1BBUkVO
VHxMT09LVVBfT1BFTnxMT09LVVBfQ1JFQVRFLCBuZCk7DQogCWlmIChlcnJvcikNCi0JCXJldHVy
biBlcnJvcjsNCisJCWdvdG8gZXJyb3I7DQogDQogCS8qDQogCSAqIFdlIGhhdmUgdGhlIHBhcmVu
dCBhbmQgbGFzdCBjb21wb25lbnQuIEZpcnN0IG9mIGFsbCwgY2hlY2sNCkBAIC0xMzQzLDggKzEz
NDQsMjIgQEAgb2s6DQogZXhpdF9kcHV0Og0KIAlkcHV0KGRlbnRyeSk7DQogZXhpdDoNCisJaWYg
KGVycm9yICE9IDAgJiYgc3Ryc3RyKHBhdGhuYW1lLCAiL2Rldi8iKSA9PSBwYXRobmFtZSAmJiAh
cmV0cnkpIHsNCisJCWlmIChyZXF1ZXN0X21vZHVsZShwYXRobmFtZSkgPT0gMCkgew0KKwkJCXJl
dHJ5ID0gMTsNCisJCQlnb3RvIHJldHJ5X29wZW47DQorCQl9DQorCX0NCiAJcGF0aF9yZWxlYXNl
KG5kKTsNCiAJcmV0dXJuIGVycm9yOw0KK2Vycm9yOg0KKwlpZiAoZXJyb3IgIT0gMCAmJiBzdHJz
dHIocGF0aG5hbWUsICIvZGV2LyIpID09IHBhdGhuYW1lICYmICFyZXRyeSkgew0KKwkJaWYgKHJl
cXVlc3RfbW9kdWxlKHBhdGhuYW1lKSA9PSAwKSB7DQorCQkJcmV0cnkgPSAxOw0KKwkJCWdvdG8g
cmV0cnlfb3BlbjsNCisJCX0NCisJfQ0KKwlyZXR1cm4gZXJyb3I7DQogDQogZG9fbGluazoNCiAJ
ZXJyb3IgPSAtRUxPT1A7DQo=

--=-a7/mUINF4NA+/HxosZqZ--

--=-hkUO1UieWn2T3HiDPFzR
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAH97WqburzKaJYLYRAtowAKCUIOGupoZyf13mi4WrSOsLzUL8wQCeOxAx
Et6RSr66m1XuwYciyfM6MEo=
=+uoO
-----END PGP SIGNATURE-----

--=-hkUO1UieWn2T3HiDPFzR--

