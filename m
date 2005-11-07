Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbVKGQDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbVKGQDu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 11:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbVKGQDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 11:03:49 -0500
Received: from wombat.indigo.net.au ([202.0.185.19]:61444 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S964832AbVKGQDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 11:03:49 -0500
Date: Tue, 8 Nov 2005 00:02:50 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Arnd Bergmann <arnd@arndb.de>
cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
       hpa@zytor.com, autofs@linux.kernel.org
Subject: Re: [PATCH 15/25] autofs: move ioctl32 to autofs{,4}/root.c
In-Reply-To: <200511071136.19087.arnd@arndb.de>
Message-ID: <Pine.LNX.4.63.0511072355560.2069@donald.themaw.net>
References: <20051105162650.620266000@b551138y.boeblingen.de.ibm.com>
 <20051105162716.551500000@b551138y.boeblingen.de.ibm.com>
 <Pine.LNX.4.63.0511061407160.2621@donald.themaw.net> <200511071136.19087.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1629620785-821618815-1131379370=:2069"
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-1.896,
	required 5, autolearn=not spam, BAYES_00 -2.60,
	DATE_IN_PAST_12_24 0.70)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1629620785-821618815-1131379370=:2069
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 7 Nov 2005, Arnd Bergmann wrote:

> On S=FCnndag 06 November 2005 07:22, Ian Kent wrote:
> > On Sat, 5 Nov 2005, Arnd Bergmann wrote:
> >
> > I'm not sure if I like conditional compilation in the code proper but I=
'll=20
> > leave it to you to make the final decision since your running with the=
=20
> > change. Is there a reason the definitions can't simply be left in place=
?
>=20
> I think the compat_ptr() macro is not defined on architectures that don't
> have 32 bit compat code, but we could change that.
> =20
> > Its been a while since I trawled through the compat ioctl code (please=
=20
> > point me to the right place) but with this change I think that the=20
> > AUTOFS_IOC_SETTIMEOUT32 is redundant. Consider a conditional define for=
=20
> > AUTOFS_IOC_SETTIMEOUT in include/linux/auto_fs.h instead. Both autofs a=
nd=20
> > autofs4 use that definition.
>=20
> The point here is that the two are different on 64 bit platforms, since
> sizeof (int) !=3D sizeof (long). You also can't do
>=20
> switch (cmd) {
> case AUTOFS_IOC_SETTIMEOUT32:
> case AUTOFS_IOC_SETTIMEOUT:
> =09return do_stuff();
> }
>=20
> because then gcc would complain about duplicate case targets on 32 bit
> targets.

I was thinking that if the module was compiled for 64bit then the 64bit=20
definition would prevail and visa versa.

eg. In the include file.

#ifdef COMPAT_IOCTL
#define AUTOFS_IOC_SETTIMEOUT(..., unsigned int)
#else
#define AUTOFS_IOC_SETTIMEOUT(...,unsigned long)
#endif

I think I'm going to have to investigate further following the=20
implementation.

> =20
> > The lock_kernel()/unlock_kernel() in the autofs4 patch is ineffective a=
s=20
> > the BKL is not used for syncronisation anywhere else in autofs4. If=20
> > removing it causes problems I need to know about'em so I can fix'em=20
> > (hopefully).
>=20
> I used the BKL here in order to maintain the current semantics, because
> ioctl is always called with BKL held, and compat_ioctl is called without
> it.

Of course a sensible approach.

>=20
> If you are sure you don't need the BKL, then you should also replace
> ".ioctl =3D ..." with ".unlocked_ioctl =3D ...".

Yep. I'll check and amend it later.
After all it will be part of the module then.

Thanks
Ian

--1629620785-821618815-1131379370=:2069--
