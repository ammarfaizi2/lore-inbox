Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269570AbRHCUDg>; Fri, 3 Aug 2001 16:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269583AbRHCUDQ>; Fri, 3 Aug 2001 16:03:16 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53143 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S269570AbRHCUDN>;
	Fri, 3 Aug 2001 16:03:13 -0400
Date: Fri, 3 Aug 2001 16:03:22 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Andrew Morton <akpm@zip.com.au>
cc: Greg Louis <glouis@dynamicro.on.ca>, ext3-users <ext3-users@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: ac4 ext3 recovery failure
In-Reply-To: <3B6B026A.C2D741B2@zip.com.au>
Message-ID: <Pine.GSO.4.21.0108031554010.3272-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 3 Aug 2001, Andrew Morton wrote:

> Ah.  Thanks.  Linus doesn't seem to have fsync_no_super(), so some
> compatibility hacks will be needed there.

Merge with fs/super.c fixes (happens in -ac)

> Why does fsync_no_super() exist?  I assume some locking changes
> somewhere?

It's fsync_dev() without touching fs structures.

fsync_super() - we hold a superblock, sync its in-core structures and
sync the device
fsync_dev() - we have a device, find superblock, grab it and sync (see above).
We need exclusion against read_super() and umount here - code in Linus'
tree is oopsable exactly because it lacks that.
fsync_no_super() - we have a device, sync it without even looking for fs
in-core stuff.

Notice that fsync_dev() in the wrong moment can seriously screw vanilla
2.4. In -ac4 it got the required exclusion, but that means the need to
use the fsync_super() or fsync_no_super() if you are in the exclusion
area. That had been done to the stuff common with Linus' tree, so there's
not much to fix. AFAICS jbd/recovery.c is the only place not covered.

