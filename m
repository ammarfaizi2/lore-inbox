Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262108AbVAEAX3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262108AbVAEAX3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 19:23:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVAEAUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 19:20:47 -0500
Received: from natpreptil.rzone.de ([81.169.145.163]:63114 "EHLO
	natpreptil.rzone.de") by vger.kernel.org with ESMTP id S261869AbVAEATm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 19:19:42 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Mark Williamson <maw48@cl.cam.ac.uk>
Subject: Re: [Xen-devel] Re: [XEN] using shmfs for swapspace
Date: Wed, 5 Jan 2005 01:11:54 +0100
User-Agent: KMail/1.6.2
Cc: xen-devel@lists.sourceforge.net, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Luke Kenneth Casson Leighton <lkcl@lkcl.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050102162652.GA12268@lkcl.net> <1104785749.13302.26.camel@localhost.localdomain> <200501040304.10128.maw48@cl.cam.ac.uk>
In-Reply-To: <200501040304.10128.maw48@cl.cam.ac.uk>
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-02=_ODz2BcJHSHjhPM7";
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200501050111.59072.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-02=_ODz2BcJHSHjhPM7
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Dinsdag 04 Januar 2005 04:04, Mark Williamson wrote:
> > for doing opportunistic page recycling ("I dont need this page but when
> > I ask for it back please tell me if you trashed the content")
>=20
> We've talked about doing this but AFAIK nobody has gotten round to it yet=
=20
> because there hasn't been a pressing need (IIRC, it was on the todo list =
when=20
> Xen 1.0 came out).
>=20
> IMHO, it doesn't look terribly difficult but would require (hopefully sma=
ll)=20
> modifications to the architecture independent code, plus a little bit of=
=20
> support code in Xen.
>=20
> I'd quite like to look at this one fine day but I suspect there are more=
=20
> useful things I should do first...

There are two other alternatives that are already used on s390 for making
multi-level paging a little more pleasant:

=2D Pseudo faults: When Linux accesses a page that it believes to be present
  but is actually swapped out in z/VM, the VM hypervisor causes a special
  PFAULT exception. Linux can then choose to either ignore this exception
  and continue, which will force VM to swap the page back in. Or it can
  do a task switch and wait for the page to come back. At the point where
  VM has read the page back from its swap device, it causes another
  exception, after which Linux wakes up the sleeping process.
  see arch/s390/mm/fault.c

=2D Ballooning:=20
  z/VM has an interface (DIAG 10) for the OS to tell it about a page that
  is currently unused. The kernel uses get_free_page to reserve a number
  of pages, then calls DIAG10 to give it to z/VM. The amount of pages to
  give back to the hypervisor is determined by a system wide workload
  manager.
  see arch/s390/mm/cmm.c

When you want to introduce some interface in Xen, you probably want
something more powerful than these, but it probably makes sense to
see them as a base line of what can be done with practically no
common code changes (if you don't do similar stuff already).

	Arnd <><

--Boundary-02=_ODz2BcJHSHjhPM7
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBB2zDO5t5GS2LDRf4RAuZLAJ40ZmXuYmHUA45RzjT/ykwcJCkuAgCgggtY
KE4Qu15FknpsI11MLjIDbVc=
=SCle
-----END PGP SIGNATURE-----

--Boundary-02=_ODz2BcJHSHjhPM7--
