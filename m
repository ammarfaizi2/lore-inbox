Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265201AbUAJO4P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 09:56:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265203AbUAJO4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 09:56:15 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:65472 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S265201AbUAJO4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 09:56:05 -0500
Subject: Re: 2.4.24 eth0: TX underrun, threshold adjusted.
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: "Gabor Z. Papp" <gzp@papp.hu>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com, Feldman@tux.rsn.bth.se,
       Scott <scott.feldman@intel.com>
In-Reply-To: <x665fkb59o@gzp>
References: <x665fkb59o@gzp>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VMta6VoKtw3n3wcoTs0f"
Message-Id: <1073746559.752.44.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 10 Jan 2004 15:56:00 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VMta6VoKtw3n3wcoTs0f
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-01-10 at 09:02, Gabor Z. Papp wrote:
> Replacing 2.4.23 with 2.4.24 went without any error I noticed.
>=20
> After 8h uptime I have connected the first nfsroot client.
>=20
> In the server host klog got 12 "eth0: TX underrun, threshold adjusted."
> messages while the client started to mount the dirs.

> eth0: TX underrun, threshold adjusted.
> [10 times]
> eth0: TX underrun, threshold adjusted.

> eth0 intel eepro100

I think you ran the eepro100 driver in 2.4.23 and now in 2.4.24 you are
using the e100 driver, am I correct?

This isn't really an error, it's an indicator that the pci-bus doesn't
really keep up, then the NIC has to increase the threshold (it tries to
start sending the packet out before it's fully transferred from main
memory to the NIC, it hopes the rest of the packet will have been
transferred in time, this message indicates that it wasn't so the NIC
had to increase the threshold of how much of the packet has to have been
transferred before it starts sending it out)

This happens with the eepro100 driver as well but it doesn't tell you
about it, it just increases the threshold and goes on.
The e100 driver tells you about it _and_ it actually decreases the
threshold if there hasn't been any underruns for a while, and when it is
decreased, the threshold gets too small and you get an underrun
again....

I hope this helps to explain this message.

Scott (cc'd), do you know why the e100 driver insists on decreasing the
threshold all the time? It's decreased when there havn't been any
underruns for a while (and there havn't been any underruns for a while
just because we increased the threshold). This _will_ give lots and lots
of these messages on machines where the pci is a bit too slow. How about
not decreasing it at all? Or only telling the user about the situation
until we have decreased it for the first time, then it shuts up as this
message gets quite annoying.

I can see that we might want to decrease the threshold if the reason for
it was temporary high load on the pci-bus, but that we will never know.
Or maybe increase the limit of which the decreasing is based, iirc it
only decreases if the threshold is above some value. I see the
decrease/increase "loop" here quite a bit on amd768 (mpx) chipsets.

--=20
/Martin

--=-VMta6VoKtw3n3wcoTs0f
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAABJ+Wm2vlfa207ERAkItAJ4gw6co0x5mlubEmHJ+ferXjS8iiwCgrYJA
d6oPW+tvcbdLNYNyLv4TBgk=
=+ruC
-----END PGP SIGNATURE-----

--=-VMta6VoKtw3n3wcoTs0f--
