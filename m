Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261797AbUB0L6P (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 06:58:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261802AbUB0L6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 06:58:15 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:40953 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S261797AbUB0L6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 06:58:05 -0500
Date: Fri, 27 Feb 2004 22:57:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christoph Hellwig <hch@infradead.org>
Cc: hch@lst.de, akpm@osdl.org, linus@osdl.org, anton@samba.org,
       paulus@samba.org, axboe@suse.de, piggin@cyberone.com.au,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iSeries virtual disk
Message-Id: <20040227225716.5b29c690.sfr@canb.auug.org.au>
In-Reply-To: <20040227113202.A31176@infradead.org>
References: <20040123163504.36582570.sfr@canb.auug.org.au>
	<20040122221136.174550c3.akpm@osdl.org>
	<20040226172325.3a139f73.sfr@canb.auug.org.au>
	<20040226095156.GA25423@lst.de>
	<20040227120451.0e3c43bd.sfr@canb.auug.org.au>
	<20040227113202.A31176@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Fri__27_Feb_2004_22_57_16_+1100_1NhB16vbSR8=4GR/"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Fri__27_Feb_2004_22_57_16_+1100_1NhB16vbSR8=4GR/
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Christoph,

On Fri, 27 Feb 2004 11:32:02 +0000 Christoph Hellwig <hch@infradead.org> wrote:
>
> > > it to the maximum value and then reset it in a magic even handler?
> > > I think that logic needs some clarification.
> > 
> > The "magic event handler" is synchronous with the probe_disk routine.  I
> > agree it is a bit confusing, but, at least I have the comment there about
> > the side effects of the probe_disk routine.  Changed slightly.
> 
> The code that is in Linus' tree is still b0rked:
> 
>  - you set viodasd_max_disk in viodasd_open which looks completely bogus:
>     o the value is never used after module_init, and as long as module_init
>       and blkdev ->open under BKL they are serialized.
>     o even if they weren't you wouldn't ever get an open call for a device
>       > viodasd_max_disk
>     o that means if you actually got there it would either be the same or
>       decreased
>     o if it was decreased in parallel to module_init your loop in
>       module_init would be totally screwed.
>   - now to that loop in module_init:
>     o they only thing that it actually archives is that it breaks out of
>       the loop if a probe_disk fails - but you could archive that much
>       more easier by just returning an error from the probe_disk and
>       use a break out of the loop.  The >= MAX_DISKNO check could then
>       easily happen on the i used as loop counter.

In theory you can hot add virtual disks to an iSeries partition (up to 64
disks per partition).  We used to support that by registering all 32 disks
with Linux and then probing the hypervisor when any disk was opened at
which point the hypervisor lets us know that the value of viod_max_disk
should be increased.  I took that code out in the name of simplicity and
in the hope of getting the driver accepted.  (In fact it was your comments
that made me do it.)  I will investigate your suggestion of using
blk_register_region for the disks that don't exist yet over the next while
at which point (assuming I can figure out how to do it) the value of
viodasd_max_disk may again rise over time.

viodasd_max_disk will never decrease, because you cannot remove a virtual
disk from a partition while it is running.

It doesn't break out of the loop when probe_disk fails because it is
possible to have gaps in the list if disks (e.g. I have have disks 1 2 4 7
and viodasd_max_disk will be 7 but probe_disk will "fail" for the other
disks).

In fact, the admin could add a disk while that loop is running so that
viodasd_max_disk could change even then. They would have to be quick
though :-)

Any clearer?

> 
> > > for lowend configurations (remember we have a 32bit dev_t now)
> > 
> > Can I leave this for now?
> 
> It's really awkwards.  And IBM will most likely want lots of disks soon
> anyway :)

The viodasd driver (as used in distros for a couple of years) has never
supported more than 32 disks ...  If you want lots of disks on an iSeries
partition you would used real direct attached SCSI controllers with real
disks.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__27_Feb_2004_22_57_16_+1100_1NhB16vbSR8=4GR/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAPzCiFG47PeJeR58RAu+DAKCfozk3IQlMZPiobtAOJvsSHJ/78wCgpwJZ
tnagIXGduVGCnN2vZvTroGU=
=r6x7
-----END PGP SIGNATURE-----

--Signature=_Fri__27_Feb_2004_22_57_16_+1100_1NhB16vbSR8=4GR/--
