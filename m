Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131732AbRALTMc>; Fri, 12 Jan 2001 14:12:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131879AbRALTMW>; Fri, 12 Jan 2001 14:12:22 -0500
Received: from moutvdom01.kundenserver.de ([195.20.224.200]:38215 "EHLO
	moutvdom01.kundenserver.de") by vger.kernel.org with ESMTP
	id <S131732AbRALTMC>; Fri, 12 Jan 2001 14:12:02 -0500
Date: Fri, 12 Jan 2001 20:11:30 +0100
From: Christian Zander <phoenix@minion.de>
To: linux-kernel@vger.kernel.org
Cc: Keith Owens <kaos@ocs.com.au>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go?
Message-ID: <20010112201130.A710@chronos>
Reply-To: Christian Zander <phoenix@minion.de>
In-Reply-To: <3A5EFC56.F1A5BCE0@mira.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5EFC56.F1A5BCE0@mira.net>; from antony@mira.net on Fri, Jan 12, 2001 at 11:45:10PM +1100
X-Accept-Language: de, en, fr
X-Operating-System: Gnu/Linux [2.4.0][i686]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >> I ran into this while hacking the Nvidia kernel driver to work with
> >> 2.4.0.  I got the driver working but it's not 100%
> >>=20
> >> Also where did get_module_symbol() and put_module_symbol() go?
> >
> >Patches for the NVIDIA binary X drivers following all these kernel
> >changes can be gotten from IRC server irc.openprojects.net, channel
> >#nvidia. Or from http://ex.shafted.com.au/nvidia/
>=20
> And what a pile of crud those patches are!!  Instead of using the clean
> replacement interface for get_module_symbol, nvidia/patch-2.4.0-PR hard
> codes the old get_module_symbol algorithm as inline code.
>=20
> This patch violates the modules interface by accessing modules.c
> internal data.  It still suffers from all the problems that
> get_module_symbol had.  Because it is hard coded as inline code instead
> of a common function, will be much harder to fix when it breaks.
>=20

The way I understand the inter_module mechanism, module A registers one
or several of its symbols using inter_module_register to make it or them=20
available to other modules. Module B can then request any of the symbols
with inter_module_request and get a pointer. The inter_module mechanism=20
guarantees that the symbol will be available until module B decides that=20
the symbol is no longer needed and releases it by calling inter_module_put.

Saying that I should have made use of this mechanism for the specific
code in the Nvidia driver that we are talking about clearly shows that
you didn't look at it. The module used get_module_symbol to search its
own symbol table for parameters that may have been passed to it at load
time. Arguably, this is bad practise, but it is also the reason why using
your mechanism doesn't make any sense. Obviously, the module wouldn't
want to register private data to request it later on; the information
that would have to be passed to inter_module_register is the same that
the code in question intends to retrieve in the first place.

Contrary to what you're saying, the patch does not just inline the old
get_module_symbol algorithm nor does it access any of module.c's internal
data. What is does is to browse the list of the modules's _own_ symbols=20
looking for a match. If it finds one, it returns the desired data.

> Whoever coded that patch should be taken out and shot, hung, drawn and
> quartered then forced to write COBOL for the rest of their natural
> life.

Excellent comment - it is just as appropriate as it is helpful.

--
----------------------------------------------------------------------
 christian zander              we come to bury dos, not to praise it.
 zander@hdz.uni-dortmund.de    -- paul vojta
----------------------------------------------------------------------

--mYCpIKhGyMATD0i+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6X1biY28vJpqNKtcRAi05AJ9ASxjv4kxoqPXTfX2hNQSYr1TQnACfbjOc
YuTNcsFbsxqrIgkm4Sqau20=
=3Gmv
-----END PGP SIGNATURE-----

--mYCpIKhGyMATD0i+--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
