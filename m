Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266544AbUHBN5R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266544AbUHBN5R (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 09:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266549AbUHBN5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 09:57:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:17883 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S266544AbUHBN4Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 09:56:25 -0400
Date: Mon, 2 Aug 2004 15:56:16 +0200
From: Jens Axboe <axboe@suse.de>
To: tabris <tabris@tabris.net>
Cc: linux-kernel@vger.kernel.org,
       "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: ide-cd problems
Message-ID: <20040802135615.GX10496@suse.de>
References: <20040730193651.GA25616@bliss> <cehqak$1pq$1@sea.gmane.org> <20040801155753.GA13702@suse.de> <200408020945.05297.tabris@tabris.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408020945.05297.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02 2004, tabris wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On Sunday 01 August 2004 11:57 am, Jens Axboe wrote:
> > On Sun, Aug 01 2004, Alexander E. Patrakov wrote:
> > > Zinx Verituse wrote:
> > > >I don't believe command filtering is neccessary, since all of the
> > > >ide-cd ioctls are still there (ioctls that allow playing, reading,
> > > > etc) Only the SG_IO ioctl itself would have to be checked (i.e.,
> > > > not each individual command available with SG_IO, just the
> > > > overall ioctl itself, categorizing all of SG_IO more or less as
> > > > raw IO.  If this isn't doable with the current design, then the
> > > > ide-cd interface should at least be very conspicuously documented
> > > > as being extremely insecure as far as "read" access is concerned,
> > > > as I know I wouldn't expect users to be able to overwrite my
> > > > drive's firmware simply by granting the read access.
> > >
> > > Remember that it is still possible to write CDs through ide-cd in
> > > 2.4.x using some pre-alpha code in cdrecord:
> > >
> > > cdrecord dev=ATAPI:1,1,0 image.iso
> >
> > (don't trim cc lists on linux-kernel!)
> >
> > Don't ever use that interface, period. It's not just the cdrecord
> > code that may be alpha (I doubt it matters, it's easy to use), the
> > interface it uses is not worth the lines of code it occupies.
> 	Then we have a severe disagreement between the cdrecord code (or at 
> least the runtime warnings) and the Linux-Kernel IDE folks. 
> specifically, these lines, while running with cdrecord dev=/dev/cdrom
> 
> scsidev: '/dev/cdrom'
> devname: '/dev/cdrom'
> scsibus: -2 target: -2 lun: -2
> Warning: Open by 'devname' is unintentional and not supported.

Kernel and cdrecord disagreement, news at 11.

> 	I've attached two logs, one using the ATAPI interface, one using
> 	your suggested interface. Frankly, both have rather nasty
> 	warnings on them, and one gets to wondering what the cdrecord
> 	authors want...
> 
> 	Maybe we should be cc:ing the authors of cdrecord as well?

I appreciate the good intentions, but perhaps you should research a bit
of background on this before going over board here. Don't think it
hasn't been suggested to Joerg before to kill that message.

Look at the errors as well - one is about the transport used:

> devname: 'ATAPI'
> scsibus: 0 target: 0 lun: 0
> Warning: Using ATA Packet interface.
> Warning: The related libscg interface code is in pre alpha.
> Warning: There may be fatal problems.
> SCSI buffer size: 64512

The other (for SG_IO)

> scsidev: '/dev/cdrom'
> devname: '/dev/cdrom'
> scsibus: -2 target: -2 lun: -2
> Warning: Open by 'devname' is unintentional and not supported.

just says that open-by-device name is unintentional, it doesn't give you
warnings on the transport.

So in short (and repeating): don't use ATAPI (CDROM_SEND_PACKET), it
sucks. Use SG_IO (which means using open-by-device, which works at least
as well as the stupid faked ATAPI bus/id/lun crap and has the much
better transport). Don't compare apples and oranges.

-- 
Jens Axboe

