Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284987AbRLFFR1>; Thu, 6 Dec 2001 00:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284986AbRLFFRI>; Thu, 6 Dec 2001 00:17:08 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:27193 "EHLO
	etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
	id <S284987AbRLFFQ4>; Thu, 6 Dec 2001 00:16:56 -0500
Date: Thu, 6 Dec 2001 06:13:15 +0100
From: Kurt Garloff <garloff@suse.de>
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: IDE DMA on AXP & barriers
Message-ID: <20011206061315.J13427@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HSQ3hISbU3Um6hch"
Content-Disposition: inline
User-Agent: Mutt/1.3.22.1i
X-Operating-System: Linux 2.4.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TU/e(NL), SuSE(DE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HSQ3hISbU3Um6hch
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

trying to find out, why the CMD646 (rev 01) IDE controller does corrupt my
file system on my PWS (Alpha) when writing in DMA mode, I started to wonder
about a number of things.

The pattern of the corruption is characteristic:
root@pws:/media/test/Dio/Diamonds # cmp -l copy original
  8193 377  70
  8194 373  71
  8195 220  40
  8196 144  50
 16385  70  47
 16386  71 367
 16387  40 152
 16388  50 341
 24577  47  20
 24578 367 342
 24579 152 136
 24580 341 202

always the first 4 bytes of a page still showing the old contents.=20
To me this looks like either a some very weird bug in the chipset or more
likely like races between BM DMA and the CPU write buffers/caches. The
latter can easily be the case on Alpha, as there is _no_ implicit ordering
on any operation on the Alpha, not even interrupts, PAL calls, ...

Following the latter somewhat more, I found that the pcilogicisp driver
which works well, does have a number of mb() commands; the whole IDE code
does not have any of those.
I would imagine that the following barriers are nacessary:
* After setting up the IDE DMA tables (PRD) and having the data there,
  we need to have a barrier before telling the controller to do DMA.
* After the controller is done with it, we need to make sure the
  data is in mem before we use it (i.e. we need some mb() equiv on the
  controller)
* Some more less obvious ones probably ...

The Alpha Architecture manual sec. 5.6.4 gives some more info on how to
insure ordering of concurrent data access on shared memory.

Anyone familiar with IDE able to identify the necessary places in ide-dma
and/or cmd64x ?

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, DE                                SCSI, Security

--HSQ3hISbU3Um6hch
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8Dv5rxmLh6hyYd04RAgR6AJwKsz1t6uO8OuOvjQx4nt62K2JGvQCfaWEz
hJeqDu/vu6pzGHZVdTefVeI=
=vbKD
-----END PGP SIGNATURE-----

--HSQ3hISbU3Um6hch--
