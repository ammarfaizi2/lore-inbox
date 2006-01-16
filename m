Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWAPTlA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWAPTlA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 14:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWAPTlA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 14:41:00 -0500
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]:5585 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S1751156AbWAPTk6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 14:40:58 -0500
Date: Mon, 16 Jan 2006 14:40:13 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: Sam Leffler <sam@errno.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Johannes Berg <johannes@sipsolutions.net>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
Message-ID: <20060116194013.GA12748@shaftnet.org>
Mail-Followup-To: Sam Leffler <sam@errno.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060113212605.GD16166@tuxdriver.com> <20060113213011.GE16166@tuxdriver.com> <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost> <20060114011726.GA19950@shaftnet.org> <43C97605.9030907@pobox.com> <20060115152034.GA1722@shaftnet.org> <43CAA853.8020409@errno.com> <20060116172817.GB8596@shaftnet.org> <43CBDDC7.9060504@errno.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
In-Reply-To: <43CBDDC7.9060504@errno.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.2 (shaft.shaftnet.org [127.0.0.1]); Mon, 16 Jan 2006 14:40:14 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 16, 2006 at 09:54:15AM -0800, Sam Leffler wrote:
> The way you implement bg scanning is to notify the ap you are going into=
=20
> power save mode before you leave the channel (in sta mode).  Hence bg=20
> scanning and power save operation interact.

That is not "powersave operation" -- that is telling the AP we are going
into powersave, but not actually going into powersave -- Actual
powersave operation would need to be disabled if we go into a scan, as
we need to have the rx path powered up and ready to hear anything out
there for the full channel dwell time.

> See above.  Doing bg scanning well is a balancing act and restoring=20
> hardware state is the least of your worries (hopefully); e.g. what's the=
=20
> right thing to do when you get a frame to transmit while off-channel=20
> scanning, how often should you return to the bss channel?

Disallow all other transmits (either by failing them altogether, or by=20
buffering them up, which I think is better) while performing the scan.

If we are (continually) scanning because we don't have an association,=20
then we shouldn't be allowing any traffic through the stack anyway.

At the end of each scan pass, you return to the original channel, then=20
return "scan complete" to the stack/userspace.  at this point any=20
pending transmits can go out, and if another scan pass is desired, it=20
will happen then.

> Er, you need to listen to at least beacons from other ap's if you're in=
=20
> 11g so you can detect overlapping bss and enable protection.  There are=
=20
> other ways to handle this but that's one.

If you can't hear the traffic, then it doesn't count for purposes of ER
protection -- but that said, this only matters for AP operation, so APs
shouldn't filter out anyone else's becacons.  STAs should respect the
"use ER Protection" bit in the AP's beacon, so can filter out traffic=20
that doesn't match the configured BSSID.

> >Oh, I know.  I've burned out many brain cells trying to build=20
> >supportable solutions for our customers.  =20
>=20
> I don't recall seeing well-developed scanning code in either of the=20
> proposed stacks.

I've only looked into the pre-2.6-merged HostAP stack, so I can't=20
comment on what's publically available.  I'll have a look at the GPL'ed=20
DeviceScape stack when I have more time.

Most of what I've going on about is derived from my experience from
commercial 802.11 work I've done over the past few years.

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL 					=20
Quidquid latine dictum sit, altum viditur.

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDy/adPuLgii2759ARAi3wAJ9AD+C3ZD6QlrR8sHP9BibXd1M+VACfSkL4
M7kxlHCbVDBUJnf7wjgSgns=
=wL7f
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
