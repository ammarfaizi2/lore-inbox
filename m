Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932268AbWHGSKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932268AbWHGSKt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 14:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbWHGSKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 14:10:48 -0400
Received: from spock.bluecherry.net ([66.138.159.248]:60340 "EHLO
	spock.bluecherry.net") by vger.kernel.org with ESMTP
	id S932268AbWHGSKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 14:10:47 -0400
Date: Mon, 7 Aug 2006 14:10:43 -0400
From: "Zephaniah E. Hull" <warp@aehallh.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] Crash on evdev disconnect.
Message-ID: <20060807181043.GA5476@aehallh.com>
Mail-Followup-To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <20060807155916.GE5472@aehallh.com> <d120d5000608071035k2ec5b4ffu949a99ad4a8c3d66@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
In-Reply-To: <d120d5000608071035k2ec5b4ffu949a99ad4a8c3d66@mail.gmail.com>
X-Notice-1: Unsolicited Commercial Email (Aka SPAM) to ANY systems under
X-Notice-2: our control constitutes a $US500 Administrative Fee, payable
X-Notice-3: immediately.  By sending us mail, you hereby acknowledge that
X-Notice-4: policy and agree to the fee.
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 07, 2006 at 01:35:50PM -0400, Dmitry Torokhov wrote:
> Hi,
> 
> On 8/7/06, Zephaniah E. Hull <warp@aehallh.com> wrote:
> >       if (evdev->open) {
> >               input_close_device(handle);
> >               wake_up_interruptible(&evdev->wait);
> >-               list_for_each_entry(list, &evdev->list, node)
> >+               list_for_each_entry_safe(list, next, &evdev->list, node)
> >                       kill_fasync(&list->fasync, SIGIO, POLL_HUP);
> 
> NAK. kill_fasync does not affect the list state so using _safe does
> not buy us anything.

Sorry, but you're wrong.

Immediately before the kill_fasync call list->node.next is a valid
pointer, immediately afterwords it is 0x100100, which happens to be
list_poison.  kill_fasync is triggering a close somehow, evdev_close
deletes that element of the list, which poisons the next value, which
can make us crash and burn.

I have a 100% reproducible crash case, which is fixed by the change.

If kill_fasync shouldn't be making it close that's another issue, but at
the moment it is and this is a fairly non-invasive change which fixes
it.

> 
> BTW, dtor_core@ameritech.net address is dead, please use
> dmitry.torokhov@gmail.com or dtor@mail.ru or dtor@isightbb.com.

Noted, recommend updating the entry in MAINTAINERS. :)

Zephaniah E. Hull.

-- 
	  1024D/E65A7801 Zephaniah E. Hull <warp@aehallh.com>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

> Is there an API or other means to determine what video
> card, namely the chipset, that the user has installed
> on his machine?

On a modern X86 machine use the PCI/AGP bus data. On a PS/2 use the MCA bus
data. On nubus use the nubus probe data. On old style ISA bus PCs done a large
pointy hat and spend several years reading arcane and forbidden scrolls

 -- Alan Cox

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFE14IjRFMAi+ZaeAERAmEnAKDTPIuBmf8JsLFEqBrZQ7CP2Yq/rACgkL5Z
piTlm1s3hipheQuTLStpQgQ=
=zCxH
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--
