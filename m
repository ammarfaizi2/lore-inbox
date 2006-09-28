Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbWI1Ug6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWI1Ug6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 16:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750764AbWI1Ug6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 16:36:58 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:43155 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1750758AbWI1Ug5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 16:36:57 -0400
Date: Thu, 28 Sep 2006 14:36:56 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Douglas Gilbert <dougg@torque.net>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] async scsi scanning, version 12
Message-ID: <20060928203656.GG5017@parisc-linux.org>
References: <20060928182438.GC5017@parisc-linux.org> <451C2D49.7040403@torque.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <451C2D49.7040403@torque.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2006 at 04:15:05PM -0400, Douglas Gilbert wrote:
> > +	scsi_mod.scan=	[SCSI] sync (default) scans SCSI busses as they are
> > +			discovered.  async scans them in kernel threads,
> > +			allowing boot to proceed.  none ignores them, expecting
> > +			user space to do the scan.
> 
> Matthew,
> I like the "none" which is no doubt a place holder at
> the moment.

I wouldn't say it was extensively tested, but no, there's checks for the
value "none" and it does indeed fail to discover any devices ;-)

> For the user space to do discovery, it either needs an out
> of band mechanism (e.g. IP) or the ability to talk to a
> host in the absence of any "devices" (targets or logical units).
> That requires a device node (e.g. /dev/mptctl) or something
> equivalent in sysfs (yuk).

I must confess to having not thought about how userspace probes a
scsi host to find out what devices are behind it.  This was a feature
that James asked for and it was easy to add.

> Your "none" explanation could be slightly extended to say
> that the LLD (and/or its firmware) might do the discovery.

Note that by specifying "none", not even the FC/SAS/etc drivers can
register targets as they find them -- it really is up to userspace to
echo scsi-add-single-device H C T L >/proc/scsi/scsi

I'm a little uncomfortable with that, and I'd be open to adding another
word that means "no scanning, but if the driver's been told about the
device by a switch, add it automatically, don't wait for userspace".
I do think that none needs to mean none though.

> As an
> example the SAS-2 draft now has self-configuring expanders
> (the terms "edge" and "fanout" have been dropped) which
> effectively discover the topology and track changes, configuring
> themselves and dumber expanders as required. Then host discovery
> becomes importing the topology from an external device. However
> not all devices may be visible to self-configuring expanders
> (e.g. a SATA disk could be directly attached to a SAS HBA). So
> some extra work may be required.

That would be up to userspace in the "none" view of the world.  I could
see people wanting to ignore the self-configuring expander and impose
a new (incorrect) topology on the system.

BTW, there'll be a lucky version 13 in a few minutes ...
shost_for_each_device_safe isn't.
