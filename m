Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWAFLBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWAFLBU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 06:01:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWAFLBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 06:01:20 -0500
Received: from mout1.freenet.de ([194.97.50.132]:38583 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id S932413AbWAFLBT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 06:01:19 -0500
From: Michael Buesch <mbuesch@freenet.de>
To: jgarzik@pobox.com
Subject: Re: [Bcm43xx-dev] [Fwd: State of the Union: Wireless]
Date: Fri, 6 Jan 2006 12:00:59 +0100
User-Agent: KMail/1.8.3
References: <1136541243.4037.18.camel@localhost>
In-Reply-To: <1136541243.4037.18.camel@localhost>
Cc: bcm43xx-dev@lists.berlios.de, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200601061200.59376.mbuesch@freenet.de>
Content-Type: multipart/signed;
  boundary="nextPart3368479.LLDLk1xIID";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3368479.LLDLk1xIID
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

> > * We really have no wireless maintainer.  I'm just the defacto guy,
> >   with no interest in the job.  The ideal maintainer knows 802.11 well,
> >   uses git, and isn't an asshole with no taste.  I'm just the guy who
> >   wants to make sure the net driver portion doesn't turn out to be a
> >   stinker (read: review and pass up the chain).

That problem is easiest to solve. ;)

> > * Wireless management, in particular the wireless kernel<->user
> >   interface, needs some thinking.  Wireless Extensions (WE) isn't
> >   cutting it, but I haven't seen any netlink work yet (or some
> >   other interface).  Whatever the userspace interface is, it will be
> >   basically carved in stone for years (unlike kernel APIs), so this
> >   needs a lot more thought than people have been giving it.

We did some brainstorming about this yesterday evening on the bcm
irc channel. I think we all agreed on dropping WE.
So, now we asked: How would a sane UI look like. We had a few points:
* The interface needs to support some kind of "master" interface to
configure the hardware, 80211 parameters and
to actually configure and setup the
* Virtual interfaces.
Data is transferred only though the virtual interfaces, which could
be an AP interface, a STA interface in INFRA or Ad-Hoc mode, etc... .
Configuration is done though the master interface.

How would the virtual interfaces look like? That is quite easy to answer.
They are net_devices, as they transfer data.
They should probaly _not_ be on top of the ethernet, as 80211 does not
have very much in common with ethernet. Basically they share the same
MAC address format. Does someone have another thing, which he thinks
is shared?
How would the master interface look like? A somewhat unusual idea came
up. Using a device node in /dev. So every wireless card in the system
would have a node in /dev associated (/dev/wlan0 for example).
A node for the master device would be ok, because no data is transferred
through it. It is only a configuration interface.
So you would tell the, yet-to-be-written userspace tool wconfig (or somethi=
ng
like that) "I need a STA in INFRA mode and want to drive it on the
wlan0 card". So wconfig goes and write()s some data to /dev/wlan0
telling the 80211 code to setup a virtual net_device for the driver
associated to /dev/wlan0.
The virtual interface is then configured though /dev/wlan0 using write()
(no ugly ioctl anymore, you see...). Config data like TX rate,
current essid,.... basically everything + xyz which is done by WE today,
is written to /dev/wlan0.
This config data is entirely cached in the 80211 code for the /dev/wlan0
instance. This is important, to have the data persistent throughout
suspend/resume cycles, if up/down cycles.
After configuring, a virtual net_device (let's call it wlan0) exists,
which can be brought up by ifconfig and data can be transferred though
it as usual.

This whole concept is derived from how dscape does the stuff.
With a major exception, that a device node instead of a net_device
is used for the master device. With the effect of getting rid of the
ugly WE ioctl stuff.

> > * Long term, wireless should go from being a library of common code to a
> >   "real" wireless stack, as shown in the template developed by David Mi=
ller:
> >   http://kernel.org/pub/linux/kernel/people/jgarzik/patchkits/2.6/davem=
=2Dp80211.tar.bz2
> >   Zhu Yi @ Intel and Vladmir @ somewhere both independently did some
> >   work in this area.

This looks very interresting and in fact is part of our thoughts I
explained above.

> > * I prefer GPL-only code.  Dual licensing has proven in practice to
> >   be a logistical nightmare that concentrates power in the hands of
> >   a few.  Dual licensing, BSD licensing works for some, but GPL-only
> >   code is quite simply the least amount of flamewars, headaches
> >   and worry.  IOW, the P.I.T.A. level of GPL-only code is lowest.

I personally prefer EXPORT_SYMBOL_GPL().
But that's only my opinion and that does not really matter. ;)

> > Dual licensed code gives kernel hackers yet more legal crapola to
> > worry about, which is never a good thing.

I don't see a point in dual licensing it.
The only benefit would be to allow BSD people to take the code.
Honestly, I really don't see this happening, anyway. ;)
They have net80211.

> > Patches welcome from all motivated, clueful parties.  Jiri Benc has a
> > long series of patches that looks nice.  Johannes Berg has done some
> > work on the ieee80211 softmac stuff and hw WEP.  But maybe DeviceScape
> > is what people like now.

Well, "like" is a strong word. I personally would say "It is better than
all currently existing solutions, if some final polishing is done to dscape=
=2E"

=2D-=20
Greetings Michael.

--nextPart3368479.LLDLk1xIID
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDvk3rlb09HEdWDKgRAkUwAJ4r+QXvwfav9RE9stu6s8aVvbUTgQCgvZTZ
JvBoYSEIIAlBuBrujDKND+o=
=8g+0
-----END PGP SIGNATURE-----

--nextPart3368479.LLDLk1xIID--
