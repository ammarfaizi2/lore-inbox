Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312972AbSC0C2C>; Tue, 26 Mar 2002 21:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312971AbSC0C1x>; Tue, 26 Mar 2002 21:27:53 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:8239 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S312970AbSC0C1j>; Tue, 26 Mar 2002 21:27:39 -0500
Date: Wed, 27 Mar 2002 03:27:37 +0100
From: Kurt Garloff <garloff@suse.de>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: linux-2.4.18-rpc_tweaks.dif
Message-ID: <20020327032736.G15481@gum01m.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="N8NGGaQn1mzfvaPg"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16-schedJ2 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--N8NGGaQn1mzfvaPg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Trond,

http://www.fys.uio.no/~trondmy/src/2.4.18/linux-2.4.18-rpc_tweaks.dif
contains a change that causes devastating NFS client performance: My NFS
read performance on a switched 100BaseT went down from >9MB/s to 500kB/s.
(NFSv3, rsize=3D8192, 2.4.16 AXP kernel nfsd server)

The reason is that
xprt_adjust_cwnd()
does no longer do what the comment above says it should do:
_slowly_ increase cwnd until we start to hit the limit (which we see from
timed out requests). Instead cwnd gets bumped very fast resulting in lots of
timed out requests. This way you get fast oscillations in cwnd.

Putting the old code back for xprt_adjust_cwnd() gave me back the old
performance.

Except for the missing damping, comparing the functionality with the old
code, e.g. this snippet
+	if (xprt->cong > cwnd)
+		goto out;
also makes me wonder whether it could be correct.=20
Please have a look at it again!

Regards,
--=20
Kurt Garloff                   <kurt@garloff.de>         [Eindhoven, NL]
Physics: Plasma simulations  <K.Garloff@Phys.TUE.NL>  [TU Eindhoven, NL]
Linux: SCSI, Security          <garloff@suse.de>    [SuSE Nuernberg, DE]
 (See mail header or public key servers for PGP2 and GPG public keys.)

--N8NGGaQn1mzfvaPg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8oS4YxmLh6hyYd04RAoc8AKDO9xdbWIu4sHcH/VuLz7OCUDOgAACgqtqg
0vLVr/V058f/ObbzypqXsNU=
=7J7i
-----END PGP SIGNATURE-----

--N8NGGaQn1mzfvaPg--
