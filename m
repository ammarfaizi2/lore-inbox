Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261764AbVBXCNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbVBXCNi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 21:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261759AbVBXCLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 21:11:04 -0500
Received: from waste.org ([216.27.176.166]:46489 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261690AbVBXCJH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 21:09:07 -0500
Date: Wed, 23 Feb 2005 18:08:49 -0800
From: Matt Mackall <mpm@selenic.com>
To: Benoit Boissinot <bboissin@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Steven Cole <elenstev@mesatop.com>,
       linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: 2.6.11-rc4-mm1 (VFS: Cannot open root device "301")
Message-ID: <20050224020849.GT3120@waste.org>
References: <20050223014233.6710fd73.akpm@osdl.org> <421CB161.7060900@mesatop.com> <20050223121759.5cb270ee.akpm@osdl.org> <421CFF5E.4030402@mesatop.com> <421D09AE.4090100@mesatop.com> <20050223161653.7cb966c3.akpm@osdl.org> <20050224004159.GH3163@waste.org> <40f323d005022318032d737779@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40f323d005022318032d737779@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2005 at 03:03:33AM +0100, Benoit Boissinot wrote:
> On Wed, 23 Feb 2005 16:41:59 -0800, Matt Mackall <mpm@selenic.com> wrote:
> > On Wed, Feb 23, 2005 at 04:16:53PM -0800, Andrew Morton wrote:
> > > Steven Cole <elenstev@mesatop.com> wrote:
> > > >
> > > > > Yes, that worked.  2.6.11-rc4-mm1 now boots OK, but hdb1 seems to be
> > > > > missing.
> > >
> > > Looking at the IDE update in rc4-mm1:
> > >
> > > +void ide_init_disk(struct gendisk *disk, ide_drive_t *drive)
> > > +{
> > > +     ide_hwif_t *hwif = drive->hwif;
> > > +     unsigned int unit = drive->select.all & (1 << 4);
> > > +
> 
> If i grep in the tree, for select.all, it looks like from the initialization
> that you can not recover the unit from select.all (ide.c line 235 and 1882)
> since the function used is not invertible.

They're fine, if a bit ugly. Unit is either 0 or 1. So:

  (unit<<4) | 0xa0

is equivalent to unit * 16 as the mask won't mask off any bits.
 
> > >
> > > Could someone try this?
> > >
> > > -     unsigned int unit = drive->select.all & (1 << 4);
> > > +     unsigned int unit = (drive->select.all >> 4) & 1;
> > 
> > Apparently there's already an 'hdb' sitting in drive->name, perhaps we
> > ought to do disk->disk_name = drive->name for the non-devfs case.
> >
> init_hwif_default initialized it right.
> 
> Could something like this work ?

No, because they're arrays and not pointers. I've booted with the
obvious strcpy, works fine.

-- 
Mathematics is the supreme nostalgia of our time.
