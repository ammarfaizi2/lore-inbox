Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932074AbWAOP0Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932074AbWAOP0Y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 10:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932075AbWAOP0Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 10:26:24 -0500
Received: from rrcs-24-73-230-86.se.biz.rr.com ([24.73.230.86]:32478 "EHLO
	shaft.shaftnet.org") by vger.kernel.org with ESMTP id S932074AbWAOP0X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 10:26:23 -0500
Date: Sun, 15 Jan 2006 10:20:34 -0500
From: Stuffed Crust <pizza@shaftnet.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (configuration)
Message-ID: <20060115152034.GA1722@shaftnet.org>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com> <20060113213011.GE16166@tuxdriver.com> <20060113221935.GJ16166@tuxdriver.com> <1137191522.2520.63.camel@localhost> <20060114011726.GA19950@shaftnet.org> <43C97605.9030907@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Content-Disposition: inline
In-Reply-To: <43C97605.9030907@pobox.com>
User-Agent: Mutt/1.4.2.1i
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.0.2 (shaft.shaftnet.org [127.0.0.1]); Sun, 15 Jan 2006 10:20:51 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 14, 2006 at 05:07:01PM -0500, Jeff Garzik wrote:
> >This can be accomplished by passing a static table to the=20
> >register_wiphy_device() call (or perhaps via a struct wiphy_dev=20
> >parameter) or through a more explicit, dynamic interface like:
> >
> >  wiphy_register_supported_frequency(hw, 2412).=20
>=20
> For completely programmable hardware, the stack should interact with a=20
> module like ieee80211_geo, to help ensure the hardware stays within=20
> legal limits.

While there is much to debate about where to draw the functionality=20
line, completely programmable hardware is the norm these days.

=2E.. and said code would be responsible for driving the scanning state
machines, and also for more esoteric functions like handling RADAR
traps, automatic channel switching, etc.

Handling scans is quite interesting -- I've seen hardware which requires=20
manual channel changing (including full RF parameter specification),=20
host timing for the channel dwell time, and manual probe request=20
issuance.. and on the other end of the spectrum, a simple "issue scan"=20
command that takes few, if any, parameters.

And unfortunately, many things in between.

This leads me to belive that the internal scan workflow should work
something like this:

 * Userspace app issues scan request (aka "refresh AP list")

 * Knowing the hardware frequency capabilities, the 802.11 stack applies=20
   802.11d and regdomain rules to the available frequency set, and
   issues multiple internal "scan request" commands to the hardware=20
   driver.  (eg "perform an initial passive sweep across the entire=20
   2.4G band", "perform an active scan on frequencies 2412->2437=20
   looking for ssid "HandTossed", "perform an active scan on=20
   frequencies 5200-5400 looking for ssid "HandTossed", etc)

   (note that ideally, userspace apps/libs would be at least partially
    aware of 802.11d rules, but the kernel must do the RightThing if=20
    told to "scan all available channels for any access points")
 =20
 * The hardware driver takes this scan request, and maps it into the=20
   capabilities of the hardware:

   Hardware A: (very thin MAC)
    - Using library code, generates an appropriate probe request frame,=20
      translates it into a format the hardware expects/needs,=20
      and schedules it appropriately.
    - Loops through the frequency set specified, and for each:
	- Issues a channel change command
	- Immediately transmits the probe request (for active scans)
	- Dwells for an appropriate time
        - RX'ed beacon/probe response frames come down as regular 802.11=20
          frames into the stack
        - Moves to the next channel

   Hardware B: (thinner MAC)
    - Using library code, generates an appropriate probe request frame,=20
      and translate it into a format the hardware expects.
    - Program the probe request frame into the hardware as a probe=20
      template.
    - Loops through the frequency set specified, and for each:
	- Issues a channel change command
        - Wait for a scan complete signal
        - RX'ed beacon/probe response frames come down as regular 802.11=20
          frames into the stack
        - Moves to the next channel
   =20
   Hardware C: (thick MAC, ala prism2 or prism54)
     - Issues a hardware "scan request"
     - Waits for the hardware to signal "scan complete"
     - Requests hardware scan results
     - For each scan result, the hardware returns:
        - Translate result into an 802.11 probe response frame and
          pass down the regular RX path.

   So as you can see, I think the channel iteration, dwell, etc should=20
   be performed by the hardware driver itself, as the variation at the=20
   logical "tell the hardware perform a scan" step is so extreme.

 * Meanwhile, the 802.11 stack is receiving the beacons/probe responses=20
   from the hardware via the regular rx path.  It diverts these (and=20
   other 802.11 management/control) frames, decodes them, and then adds=20
   them to the stack's internal list of available stations, updating any=20
   internal states/counters as necessary.  (These frames could also be=20
   echoed to a special netdev interface if desired)

   (stuff like detecting an AP going away depends on us noticing a lack=20
    of beacons arriving, for example.  Most hardware does not=20
    notify us of this event.  Likewise, we should expire other=20
    APs from our list if they go away.. etc.  For AP operation we need=20
    to maintain this STA list, period -- so why not use it across the=20
    board?  But this is another discussion for another time..)

 * The 802.11 stack issues a MLME-Scan-Complete notification to=20
   userspace.

 * Interested userspace apps see this event, then query the=20
   scan results and presents them to the user in some pretty format, or=20
   alternatively perform automatic roaming based on scan results.

 - Solomon
--=20
Solomon Peachy        				 ICQ: 1318344
Melbourne, FL 					=20
Quidquid latine dictum sit, altum viditur.

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDymhCPuLgii2759ARAnnRAKDRNx4wXCkL1i2UKh3XlRKYHa4uvQCg95YI
mLiNAd7oaP32gotQ026Q/nE=
=T+Lg
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
