Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269770AbRIGAcm>; Thu, 6 Sep 2001 20:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270009AbRIGAcb>; Thu, 6 Sep 2001 20:32:31 -0400
Received: from etpmod.phys.tue.nl ([131.155.111.35]:42608 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S269770AbRIGAcT>; Thu, 6 Sep 2001 20:32:19 -0400
Date: Fri, 7 Sep 2001 02:32:38 +0200
From: Kurt Garloff <garloff@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: Daniel Phillips <phillips@bonn-fries.net>,
        Jan Harkes <jaharkes@cs.cmu.edu>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: page_launder() on 2.4.9/10 issue
Message-ID: <20010907023238.A16091@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Rik van Riel <riel@conectiva.com.br>,
	Daniel Phillips <phillips@bonn-fries.net>,
	Jan Harkes <jaharkes@cs.cmu.edu>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010906193836Z16130-26183+40@humbolt.nl.linux.org> <Pine.LNX.4.33L.0109061650250.8103-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0109061650250.8103-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.20i
X-Operating-System: Linux 2.4.7 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2001 at 04:52:05PM -0300, Rik van Riel wrote:
> On Thu, 6 Sep 2001, Daniel Phillips wrote:
> > Again, I have to ask, which reads are you interfering with?  Ones that
> > haven't happened yet?  Remember, the disk is idle.  So *at worst* you a=
re
> > going to get one extra seek before getting hit with the tidal wave of r=
eads
> > you seem to be worried about.  This simply isn't significant.
> >
> > I've tested this, I know early writeout under light load is a win.
>=20
> Other people have tested this too, and light writeout of
> small blocks destroys the performance of a heavy read
> load.

Then just don't take two hard limits, but make an easy mathematical function
of time and blocks to write (monotonic and with positive slope in both) and
start to write all blocks once we execced a certain limit.
So, if you produce very few dirty inactive pages, it'll only happen every
thirty seconds, e.g., at moderate loads, it may happen every 4 seconds and
at higher loads it may even happen a couple of times per second.
Think of a function like t + t*b + b, with appropriate scaling, so we reach
the threshold either after a long time alone, because of many dirty inactive
pages alone or because a combination of both. Tuning should be such that
under normal workloads, the combination of time times pages should be the
most significant term.

(The chance that you run into memory pressure because of too many dirty
pages this way is lower than before, but if it happens, you can adjust your
function or the threshold too flush more pages.)

If you are very concerned about read performance suffering from this, you
may even monitor reads and adjust the threshold according to read load.
(Or just make your function include this variable with a negative slope.)
I believe it won't be necessary though.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7mBWmxmLh6hyYd04RAtThAKDCwU4A4mQFVJqX99Vo+BSKYW6dyACfZXi8
6Ha2Ls1+P7f7xbue5pP0VsM=
=aw4I
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
