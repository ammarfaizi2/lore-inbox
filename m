Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261544AbVDNTG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261544AbVDNTG4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 15:06:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVDNTG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 15:06:56 -0400
Received: from mail.murom.net ([213.177.124.17]:63964 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S261544AbVDNTGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 15:06:50 -0400
Date: Thu, 14 Apr 2005 23:06:21 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Grzegorz Piotr Jaskiewicz <gj@pointblue.com.pl>
Cc: JustMan <justman@e1.bmstu.ru>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] on usb removal, and minicom closing 2.6.11.7
Message-Id: <20050414230621.49663f75.vsu@altlinux.ru>
In-Reply-To: <425E64C4.5020704@pointblue.com.pl>
References: <425E5682.6060606@pointblue.com.pl>
	<200504141614.03459.justman@e1.bmstu.ru>
	<425E64C4.5020704@pointblue.com.pl>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__14_Apr_2005_23_06_21_+0400_BB+niam9DJ/Jl2=R"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__14_Apr_2005_23_06_21_+0400_BB+niam9DJ/Jl2=R
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 14 Apr 2005 14:40:36 +0200 Grzegorz Piotr Jaskiewicz wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Works great, I would like to ask everyone here on lkml to consider
> adding this patch to mainline.
> This ain't naughty solution, checking for object/pointer/whatever if
> exists before doing anything with it, is good.

No, this patch is broken.  It just avoids the problem in 99% of cases,
but it is not reliable.  The real problem is that refcounting in cdc-acm
is broken, and the kernel is accessing freed memory.

The patches which really seem to fix the underlying problem can be found
in this thread:

http://thread.gmane.org/gmane.linux.usb.devel/32977

(see "[PATCH] N/3 cdc acm errors").

You also need this driver core fix:

http://thread.gmane.org/gmane.linux.usb.devel/33132


> Anyone?
> 
> Buy the way, I am also looking for usblan for 2.6, can I use usbnet
> instead ? Anyone ported usblan to 2.6 (it's on GPL).
> 
> JustMan wrote:
> >>So,
> >>
> >>I plugged in e680 motorola phone, played a bit with minicom on
> >>/dev/ttyACM0, and when I closed minicom, got this oops. USB is useless,
> >>got to reboot computer to use it again!
> >>it's vanilla 2.6.11.7
> >>
> >>oops attached.
> >>
> > 
> > 
> > Try attached patch... (nasty solution, but it work for my C350  motorola phone)
> > 
> > 
> >>
> > 
> > 
> > ------------------------------------------------------------------------
> > 
> > diff -uNrp linux/drivers/base/class.orig.c  linux/drivers/base/class.c
> > --- linux/drivers/base/class.orig.c	2005-03-10 12:19:00.000000000 +0300
> > +++ linux/drivers/base/class.c	2005-03-10 13:59:27.000000000 +0300
> > @@ -307,12 +307,14 @@ static int class_hotplug(struct kset *ks
> >  	if (class_dev->dev) {
> >  		/* add physical device, backing this device  */
> >  		struct device *dev = class_dev->dev;
> > -		char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
> >  
> > -		add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
> > -				    &length, "PHYSDEVPATH=%s", path);
> > -		kfree(path);
> > +		if(kobject_name(&dev->kobj)) {
> > +			char *path = kobject_get_path(&dev->kobj, GFP_KERNEL);
> >  
> > +			add_hotplug_env_var(envp, num_envp, &i, buffer, buffer_size,
> > +				    &length, "PHYSDEVPATH=%s", path);
> > +			kfree(path);
> > +		}
> >  		/* add bus name of physical device */
> >  		if (dev->bus)
> >  			add_hotplug_env_var(envp, num_envp, &i,
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.0 (GNU/Linux)
> 
> iD8DBQFCXmTEi0HtPCVkDAURAvIMAJ4+8tKj6jt/ErTtCrsmNYtM2aDfNACgigLA
> 4GbLbHStQJBq+Ez1lFe+lPo=
> =UWvD
> -----END PGP SIGNATURE-----

--Signature=_Thu__14_Apr_2005_23_06_21_+0400_BB+niam9DJ/Jl2=R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCXr8wW82GfkQfsqIRAsrFAJ9WdiNtKCEm29CjGkWIwYvKxKj8ggCcCavT
yjK5x/5MyHPGEJh3Mv3nAcc=
=1lNz
-----END PGP SIGNATURE-----

--Signature=_Thu__14_Apr_2005_23_06_21_+0400_BB+niam9DJ/Jl2=R--
