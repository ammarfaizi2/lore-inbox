Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263931AbTE3TNk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 15:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263943AbTE3TNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 15:13:40 -0400
Received: from starcraft.mweb.co.za ([196.2.45.78]:12767 "EHLO
	starcraft.mweb.co.za") by vger.kernel.org with ESMTP
	id S263931AbTE3TNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 15:13:37 -0400
Date: Fri, 30 May 2003 21:25:59 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Andrew Morton <akpm@digeo.com>
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, manfred@colorfullife.com
Subject: Re: 2.5.70-mm1 Strangeness
Message-Id: <20030530212559.76f0d1ea.bonganilinux@mweb.co.za>
In-Reply-To: <20030529175135.7b204aaf.akpm@digeo.com>
References: <20030529221622.542a6df5.bonganilinux@mweb.co.za>
	<20030529135541.7c926896.akpm@digeo.com>
	<20030529.171114.34756018.davem@redhat.com>
	<20030529175135.7b204aaf.akpm@digeo.com>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.MSVMDmyz_26Qq8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.MSVMDmyz_26Qq8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 May 2003 17:51:35 -0700
Andrew Morton <akpm@digeo.com> wrote:

> "David S. Miller" <davem@redhat.com> wrote:
> >
> >    From: Andrew Morton <akpm@digeo.com>
> >    Date: Thu, 29 May 2003 13:55:41 -0700
> > 
> >    The ip_dst_cache seems unreasonably large.  Unless your desktop is a
> >    backbone router or something.
> > 
> > Lots of DST entries can result on any machine actually.  We create one
> > per source address, not just per destination address.  So if you talk
> > to a lot of sites, or lots of sites talk to you, you'll get a lot of
> > DST entries.
> > 
> > Regardless, 80MB _IS_ excessive.  That's nearly 400,000 entries.
> > It definitely indicates there is a leak somewhere.
> > 
> > Although it say:
> > 
> > ip_dst_cache       19470  19470   4096    1    1
> > 
> > Which is 19470 active objects right?
> 
> Yes, 19470 entries.  But note that each entry is 4096 bytes.
> 
> Something seems to have gone and bumped the object size from 240 bytes up
> to 4096.  This is actually what I want CONFIG_DEBUG_PAGEALLOC to do, but I
> don't think it does it yet.  
> 
> Bongani, if you have CONFIG_DEBUG_PAGEALLOC enabled then please try turning
> it off.  And maybe Manfred can throw some light on what slab has done
> there.
> 

Turning off CONFIG_DEBUG_PAGEALLOC helped, everything is running smoothly
cat /proc/sys/net/ipv4/route/max_size gave me 65536

The slabs were reclaimed before the PC died. I had a script that checked /proc/slabinfo
every 10 seconds and dup it to a file. The last output was: (for the slabs you asked me to watch)

ip_dst_cache          61     61   4096    1    1
! tunables            24   12    0
! slabdata            61     61      0
! globalstat      342536  53783 340902 2351    0   25   25
! cpustat   0       2231 406871 314930  28356

ext3_inode_cache    4331   4331   4096    1    1
! tunables            24   12    0
! slabdata          4331   4331      0
! globalstat       34388  26451 33205  580    0   25   25
! cpustat   0       2459  33332  28998   2462


dentry_cache       11016  11016   4096    1    1
! tunables            24   12    0
! slabdata         11016  11016      0
! globalstat      109937  29529 94505  418    0   25   25
! cpustat   0     568369  96256 645381   8243

So it seems like CONFIG_DEBUG_PAGEALLOC was causing the problem.

--=.MSVMDmyz_26Qq8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+17Bc+pvEqv8+FEMRApySAJ9H49Xv2oa0A1s+Aw4999CLIvD9zACeNsyo
JA3pzu2AG5548hGQQyKmrTA=
=F9qa
-----END PGP SIGNATURE-----

--=.MSVMDmyz_26Qq8--
