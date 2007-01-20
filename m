Return-Path: <linux-kernel-owner+w=401wt.eu-S965299AbXATQLO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965299AbXATQLO (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 11:11:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965301AbXATQLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 11:11:14 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:37976 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965299AbXATQLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 11:11:13 -0500
From: Mike Frysinger <vapier@gentoo.org>
Organization: wh0rd.org
To: a.zummo@towertech.it
Subject: [patch] remove __devinit markings from rtc_sysfs_add_device()
Date: Sat, 20 Jan 2007 11:11:02 -0500
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_X8jsFj9GU9qjdjO"
Message-Id: <200701201111.03507.vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_X8jsFj9GU9qjdjO
Content-Type: multipart/signed;
  boundary="nextPart4779593.GnDYT6AVux";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart4779593.GnDYT6AVux
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

the sysfs interface from the rtc framework seems to incorrectly label the a=
dd=20
function with __devinit ... the proc and dev interfaces do not have this=20
label on their add functions

ive been trying to develop a rtc module and it kept crashing ... after=20
debugging it, i'm pretty sure ive traced it back to the devinit markings ..=
=2E=20
dropping this lets my module load nicely :)

the crash would happen after my rtc called rtc_device_register ... down in=
=20
class_device_add in drivers/base/class.c, the active class interface list i=
s=20
walked and the add function is checked ... if it's non-null (aka in some=20
interface would like to be notified of additions), then it's called with th=
e=20
new device information

on my board, this add pointer would seemingly point into garbage because th=
e=20
memory it refers to was freed by the kernel :(
=2Dmike

--nextPart4779593.GnDYT6AVux
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.1 (GNU/Linux)

iQIVAwUARbI/F0FjO5/oN/WBAQJ3IQ/7BHMjo6pKe3X/6e3GgKJm7jae0Q6sOV4W
uIIPvLBEgYnuL6Oky0JiyoDDJ4qKqlxbwWoJ6rk8+RHMAE3w7/Sk4EfXQ9q5Vubx
7oQqph31kQ2iDF7kZc0VQ5wmiJGRydx44MwuyOWs7tFfyUf/jPpoY33ZodqVticU
cyNMZHoKcGqkrvfpFXBvGTslH8kS0FZToYiJeOdf7GkZJuSqeq9Mi3kBL1e/rHof
a0kGGc6k0bWZTeGoxH2lkyBY8AZbJ7tbOKNYNZUIPCB5ZJZiN9rHtIM8ZbA+QYe4
/cJ/F4g9tDFirNmLMbB68WANGTfo8QWmgcZXEML70bCQYdNDvHbmuo5yhTug5Aae
IE4PTGJ1yyDC1aV88TbYaOvEv+lWLG9e5b0r43HiXzh7XEY+rSjQl0uGWQl2MGp4
1lYaojPrsj6JMLvVos09B5ZhMNQ7YBAt8dIPfjQdwIcGyjHr/jMhs1OC8+4Qd8Bk
RdmOo9kyCmACgZMqEyYiCPsH5spAVSONKfIZtKCAJPlrgZN/KE9vMVyTE3nfasxq
ViH8gH867YRH41ymgb6/cvDTvbQF4iavzUwCTJtzbpZSBJXOIFpDc6faVoZGX5fA
alvXx0d8jYC0YyFTYEPmneOJQMbvqONfyNQkvq+/kDn8ugIELJ68edtcbEZ3Gyyy
qzoyNhGVCh0=
=kX4s
-----END PGP SIGNATURE-----

--nextPart4779593.GnDYT6AVux--

--Boundary-00=_X8jsFj9GU9qjdjO
Content-Type: text/x-diff;
  charset="us-ascii";
  name="linux-rtc-sysfs-no-devinit-add.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="linux-rtc-sysfs-no-devinit-add.patch"

rtc_sysfs_add_device is needed even after dev initialization, so drop __devinit.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>

diff --git a/drivers/rtc/rtc-sysfs.c b/drivers/rtc/rtc-sysfs.c
index 9418a59..2ddd0cf 100644
--- a/drivers/rtc/rtc-sysfs.c
+++ b/drivers/rtc/rtc-sysfs.c
@@ -78,7 +78,7 @@ static struct attribute_group rtc_attr_group = {
 	.attrs = rtc_attrs,
 };
 
-static int __devinit rtc_sysfs_add_device(struct class_device *class_dev,
+static int rtc_sysfs_add_device(struct class_device *class_dev,
 					struct class_interface *class_intf)
 {
 	int err;

--Boundary-00=_X8jsFj9GU9qjdjO--
