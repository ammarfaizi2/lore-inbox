Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWIUI3t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWIUI3t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 04:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750729AbWIUI3t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 04:29:49 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:18624 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1750725AbWIUI3s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 04:29:48 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [RTC] Remove superfluous call to call to cdev_del()
Date: Thu, 21 Sep 2006 10:30:02 +0200
User-Agent: KMail/1.9.4
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Jonathan Corbet <corbet@lwn.net>
References: <200609210946.06924.eike-kernel@sf-tec.de> <20060921095619.0b2f1774@inspiron>
In-Reply-To: <20060921095619.0b2f1774@inspiron>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1945516.VxISLb3JJF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200609211030.07944.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1945516.VxISLb3JJF
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Alessandro Zummo wrote:
> On Thu, 21 Sep 2006 09:46:06 +0200
>
> Rolf Eike Beer <eike-kernel@sf-tec.de> wrote:
> > If cdev_add() fails there is no good reason to call cdev_del().
> >
> > Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
> >
> >  	rtc->char_dev.owner =3D rtc->owner;
> >
> >  	if (cdev_add(&rtc->char_dev, MKDEV(MAJOR(rtc_devt), rtc->id), 1)) {
> > -		cdev_del(&rtc->char_dev);
> >  		dev_err(class_dev->dev,
> >  			"failed to add char device %d:%d\n",
> >  			MAJOR(rtc_devt), rtc->id);
>
>  I'm not sure.. this is drivers/char/raw.c:
>
>
>  cdev_init(&raw_cdev, &raw_fops);
>         if (cdev_add(&raw_cdev, dev, MAX_RAW_MINORS)) {
>                 kobject_put(&raw_cdev.kobj);
>                 unregister_chrdev_region(dev, MAX_RAW_MINORS);
>                 goto error;
>         }
>
>  in case of failure, it does a kobject_put.
>  tha same call is done by cdev_del.

This is unneeded here as it's embedded into struct rtc_device. Jonathan?

>  other drivers have implemented different error paths.
>  which one is correct?

Probably half of them are wrong, ugly or both. I think this interface is no=
t=20
very intuitive at all. This two calls needed to set up an embedded cdev are=
=20
IMHO the best way to keep people confused. At least the (possible) need to=
=20
call cdev_del() on failed cdev_add() is just weird.

Eike

--nextPart1945516.VxISLb3JJF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFEk2PXKSJPmm5/E4RAkwSAJ9+dGlg/sG9EnVtN+zNEjlZWJGxjwCgqBmV
tE2FwI1u0uGbYCMgoYWjy0c=
=TY1Z
-----END PGP SIGNATURE-----

--nextPart1945516.VxISLb3JJF--
