Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751919AbWCNMaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751919AbWCNMaF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 07:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbWCNMaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 07:30:05 -0500
Received: from mivlgu.ru ([81.18.140.87]:41931 "EHLO mail.mivlgu.ru")
	by vger.kernel.org with ESMTP id S1751895AbWCNMaB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 07:30:01 -0500
Date: Tue, 14 Mar 2006 15:29:44 +0300
From: Sergey Vlasov <vsu@altlinux.ru>
To: Bill Nottingham <notting@redhat.com>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Pierre Ossman <drzeus-list@drzeus.cx>,
       Andrew Morton <akpm@osdl.org>, ambx1@neo.rr.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Message-Id: <20060314152944.797390cd.vsu@altlinux.ru>
In-Reply-To: <20060313222644.GD1311@devserv.devel.redhat.com>
References: <20060301194532.GB25907@vrfy.org>
	<4406AF27.9040700@drzeus.cx>
	<20060302165816.GA13127@vrfy.org>
	<44082E14.5010201@drzeus.cx>
	<4412F53B.5010309@drzeus.cx>
	<20060311173847.23838981.akpm@osdl.org>
	<4414033F.2000205@drzeus.cx>
	<20060312172332.GA10278@vrfy.org>
	<20060313165719.GB4147@devserv.devel.redhat.com>
	<20060313192411.GA23380@vrfy.org>
	<20060313222644.GD1311@devserv.devel.redhat.com>
X-Mailer: Sylpheed version 1.0.0beta4 (GTK+ 1.2.10; i586-alt-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__14_Mar_2006_15_29_44_+0300_b2FO_9qvq+B4SAjW"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__14_Mar_2006_15_29_44_+0300_b2FO_9qvq+B4SAjW
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Mon, 13 Mar 2006 17:26:44 -0500 Bill Nottingham wrote:

> Kay Sievers (kay.sievers@vrfy.org) said: 
> > > See:
> > >   https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=178998

I have written a comment in that bugzilla entry, but it is probably too
terse, so I'll try to explain the problem and my proposed solution
better.

> > > This doesn't work for everything.
> > 
> > Sure not, and I don't think "everything" in PnP will ever work. :) But
> > it does the same as the modalias patch to the kernel we are talking about.
> > There are device table entries completely missing and some other don't
> > match. Some of them can be fixed by adding the aliases as modprobe.conf
> > entries.
> 
> Well, it's just that if this is the solution proposed, I'd like it if
> it worked for any of the people who are seeing problems - in our bugs,
> it hasn't helped any of them yet.

There are two kinds of PNP drivers:

1) PNP device drivers, which use struct pnp_driver.  These drivers use
   struct pnp_device_id in id_table entries; struct pnp_device_id
   contains a single device ID field which is used for matching.
   Aliases for these drivers have the form:

	pnp:dXXXYYYY*

   where XXXYYYY is the PNP ID which is matched.

2) PNP card drivers, which use struct pnp_card_driver.  These drivers
   use struct pnp_card_device_id in id_table entries; struct
   pnp_card_device_id contains ID for the card itself and a variable
   number of logical device IDs.  drivers/pnp/card.c:match_card() uses
   these rules for matching struct pnp_card_device_id to a device:

    a) the card IDs must match;
    b) all device IDs mentioned in struct pnp_card_device_id must be
       present in the card, but can be in any order (and there may be
       more devices than listed in the ID table).

   Aliases for card drivers currently have the form:

	pnp:cXXXYYYYdXXXYYYYdXXXYYYY*

   The first "cXXXYYYY" part is the card ID, and "dXXXYYYY" parts are
   device IDs (there may be up to PNP_MAX_DEVICES == 8 of them).

Now, for the drivers of the first type the only problem is that the
devices can have several compatible IDs in addition to the primary ID,
and this requires either a multiline "modalias" attribute, or a helper
script to call modprobe multiple times with the pnp:dXXXYYYY alias for
all available IDs.  

Drivers of the second type - PNP card drivers - are only used for isapnp
(pnpbios and pnpacpi have only plain devices).  Cards itself have only a
single ID (there are no compatible IDs for cards), but every logical
device on a card can have up to DEVICE_COUNT_COMPATIBLE == 4 compatible
IDs in addition to the primary ID.

(BTW, #define DEVICE_COUNT_COMPATIBLE 4 is duplicated in <linux/pci.h>
and <linux/isapnp.h> - if these values were different, it would be a
nasty bug.)

For the card drivers, in addition to the problem with compatible IDs, we
have another problem - the alias format for them is wrong!  The problem
is that if device IDs in the alias happen to be in a different order
than the same IDs in the actual device (or even in the same order, but
some devices are not mentioned in the ID table), fnmatch() used by
modprobe will not match this alias.

To solve this problem, I suggest to do this:

1) Change the alias format for PNP card drivers to require logical
   device IDs to be sorted, and add an "*" before every device ID part.
   The alias format becomes:

	pnp:cXXXYYYY*dXXXYYYY*dXXXYYYY*

2) Update scripts/mod/file2alias.c:do_pnp_card_entry() to write the new
   alias format (it should sort device IDs - no need to change all
   drivers to list device IDs in sorted order and create potential for
   bugs when someone adds a non-sorted entry).

3) Update /etc/udev/isapnp script mentioned in bugzilla entry to sort
   device ID values before concatenating them.

After dust settles, we can then add "modalias" attribute generation for
PNP card devices to the kernel - note that this attribute would have
only a single value which would list the card ID and all (primary and
compatible) IDs of all logical devices in sorted order.

BTW, we can change the alias format for PNP device drivers to

	pnp:*dXXXYYYY*

(note the additional "*" before the device ID).  This would allow us to
have a single-value "modalias" attribute for PNP logical devices too -
it would have the form

	pnp:dXXXYYYYdXXXYYYYdXXXYYYY

(listing all IDs, in this case sorting is not required, because each
driver will match at most only a single dXXXYYYY entry).

--Signature=_Tue__14_Mar_2006_15_29_44_+0300_b2FO_9qvq+B4SAjW
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFEFrc7W82GfkQfsqIRAl5iAJ9XA9rXbsRzeuTXhKaIXLcOOQyXCQCfciZq
nNqbfd33W56QDtMpnT6BWOo=
=M9Lt
-----END PGP SIGNATURE-----

--Signature=_Tue__14_Mar_2006_15_29_44_+0300_b2FO_9qvq+B4SAjW--
