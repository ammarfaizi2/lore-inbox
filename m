Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129414AbQK1Vze>; Tue, 28 Nov 2000 16:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129925AbQK1VzY>; Tue, 28 Nov 2000 16:55:24 -0500
Received: from etpmod.phys.tue.nl ([131.155.111.35]:32014 "EHLO
        etpmod.phys.tue.nl") by vger.kernel.org with ESMTP
        id <S129414AbQK1VzX>; Tue, 28 Nov 2000 16:55:23 -0500
Date: Tue, 28 Nov 2000 22:24:48 +0100
From: Kurt Garloff <garloff@suse.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: modutils-2.3.21: modprobe looping
Message-ID: <20001128222448.H27219@garloff.etpnet.phys.tue.nl>
Mail-Followup-To: Kurt Garloff <garloff@suse.de>,
        Keith Owens <kaos@ocs.com.au>,
        Linux kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20001128202259.E27219@garloff.etpnet.phys.tue.nl> <3301.975443633@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
        protocol="application/pgp-signature"; boundary="7faAIFVyKtREcqXC"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3301.975443633@ocs3.ocs-net>; from kaos@ocs.com.au on Wed, Nov 29, 2000 at 07:33:53AM +1100
X-Operating-System: Linux 2.2.16 i686
X-PGP-Info: on http://www.garloff.de/kurt/mykeys.pgp
X-PGP-Key: 1024D/1C98774E, 1024R/CEFC9215
Organization: TUE/NL, SuSE/FRG
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--7faAIFVyKtREcqXC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2000 at 07:33:53AM +1100, Keith Owens wrote:
> On Tue, 28 Nov 2000 20:22:59 +0100,=20
> Kurt Garloff <garloff@suse.de> wrote:
> >Find attached the modules.dep that caused this: There is a circular
> >dependency of pppoe on pppox on pppoe on ....
>=20
> The kernel code is broken.  Circular dependencies make no sense, the
> pppoe maintainer agrees and I thought that bug was fixed.

No question that circular dependencies are a bug in the kernel/modules.=20
I just thought, that it would be nice if modprobe would not run crazy and
end up in an endless loop, possible risking the machine to run out of mem
with all the nice side effects this has on Linux. This is especially bad,
because modprobe is called invisibly by kmod.
Here's what happened on the test machine (2.4.0-test9 on Dual Power3):
Swapping like crazy; getting unresponsive; ...
Here's the last output top was able to produce:
 10:12pm  up  5:56,  3 users,  load average: 1.57, 0.41, 0.16
65 processes: 63 sleeping, 2 running, 0 zombie, 0 stopped
CPU states: 36.9% user, 19.0% system,  0.0% nice, 44.0% idle
Mem:   509320K av,  508272K used,    1048K free,   28172K shrd,      76K bu=
ff
Swap:  131064K av,  107388K used,   23676K free                    7048K ca=
ched

  PID USER     PRI  NI  SIZE  RSS SHARE STAT  LIB %CPU %MEM   TIME COMMAND
23543 root      15   0  574M 472M   328 R       0 85.8 95.0   0:55 modprobe
    2 root      11   0     0    0     0 DW      0 26.3  0.0   0:06 kswapd
23544 root      14   0   568  428   328 R       0  2.1  0.0   0:01 top
[...]
(10 mins later)
I'm afraid I can't wait until the machine recovers, if it ever will.
[2.2 with AA VM would have started to kill processes (which is bad)=20
 till it would have finally killed modprobe (which is good);
 but I'm afraid that 2.4 will just not survive at all :-(           ]

> Circular dependencies are not supported, nor are they correrctly
> detected.  The existing code to walk the inter module relationships,
> including dependencies, alias, probe, probeall, before and after
> statements is a mess.  It just grew over the years with special cases
> being added and is not robust.

This is a pity, because I think the current behaviour is not acceptable,
as it can kill the machine by just being invoked by kmod.
I will try to make sense out of the code and make sure that modprobe
will not go crazy, by either detecting loops (if I can do that in a way
wihtout breaking things) or by limiting the recursion depth. I'll send
you a patch.

> In modutils 2.5 the entire code will be discarded and replaced with a
> standard graph walking algorithm with loop detection and back tracking
> instead of special case code.  That might change some modutils
> behaviour in rare cases and I do not want to change its behaviour just
> before kernel 2.4 is released.  I have a list of changes that might
> break backwards compatibility waiting for modutils 2.5, this is just
> one of them.

Looking forward to it.

Regards,
--=20
Kurt Garloff  <garloff@suse.de>                          Eindhoven, NL
GPG key: See mail header, key servers         Linux kernel development
SuSE GmbH, Nuernberg, FRG                               SCSI, Security

--7faAIFVyKtREcqXC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6JCKfxmLh6hyYd04RAptSAKCzMEgsjTE7Eg/XAp4O8GB40dnwawCgwPHa
UKYB5f9+xy8qn9WmpBDwyiQ=
=ITdf
-----END PGP SIGNATURE-----

--7faAIFVyKtREcqXC--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
