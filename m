Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269463AbRHCQWa>; Fri, 3 Aug 2001 12:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269465AbRHCQWU>; Fri, 3 Aug 2001 12:22:20 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:50816 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269463AbRHCQWR>; Fri, 3 Aug 2001 12:22:17 -0400
Date: Fri, 3 Aug 2001 10:20:20 -0600
Message-Id: <200108031620.f73GKKg06102@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: "Kevin P. Fleming" <kevin@labsysgrp.com>
Cc: <linux-kernel@vger.kernel.org>, <torvalds@transmeta.com>
Subject: Re: [PATCH] keep devfs partition nodes in sync with block device drivers
In-Reply-To: <00e701c11c26$af0463c0$6baaa8c0@kevin>
In-Reply-To: <00e701c11c26$af0463c0$6baaa8c0@kevin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin P. Fleming writes:
> (I'm resending this due to lack of any response on the first
> attempt... and since I didn't see this patch appear in
> 2.4.8-pre(2/3))

Sorry, I haven't had time to respond until now. I'm afraid I don't
like this patch. Parts should be unnecessary, and it introduces a
race.

> The attached patch (which touches nearly every block device driver that
> supports partitioned media) fixes a couple of problems when devfs is in use:
> 
> - when a block device's media is "revalidated", the partition table
> is re-read and /dev nodes are created for those partitions, but the
> previously existing entries are not removed first. this can easily
> lead to "left over" entries when the partition table is changed
> (either by partition table editing or replacement of removable
> media)

This should be done already. devfs_register_partitions() has the
following code:
		if ( unregister || (dev->part[part + minor].nr_sects < 1) ) {
			devfs_unregister (dev->part[part + minor].de);
			dev->part[part + minor].de = NULL;
			continue;
		}

That should unregister "empty" partitions. Before emplying a
sledgehammer approach of killing everything, let's try to figure out
why the above code isn't dong what I intended. When I first put that
code in, I tested that revalidating the partition table worked OK. It
did.

> - if media is ejected from a removable media device (normally done
> using an ioctl), the /dev entries for that media do not get removed

Again, they should. And reports I got back originally said it was
working OK.

Furthermore, your patch introduces a race: by unregistering
everything, the unique number (for /dev/discs/disc%d) is freed, and
then later allocated. Hopefully for the same device. But maybe not:
another driver could be loaded and grab the number. And that is
definately wrong.

> - if a block device driver has sub-drivers (specifically the IDE
> layer) loaded as modules, and one of those sub-drivers is unloaded,
> the /dev nodes it was responsible for do not get removed. this
> problem will not occur if the main block driver (at the major number
> level) is unloaded, only for sub-drivers

Specifically which entries do not get removed (and you think should
be)?

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
