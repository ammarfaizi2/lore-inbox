Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262493AbULOVcW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262493AbULOVcW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 16:32:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbULOVcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 16:32:21 -0500
Received: from linux.us.dell.com ([143.166.224.162]:28504 "EHLO
	lists.us.dell.com") by vger.kernel.org with ESMTP id S262493AbULOVb0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 16:31:26 -0500
Date: Wed, 15 Dec 2004 15:30:01 -0600
From: Matt Domsch <Matt_Domsch@dell.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>,
       "Bagalkote, Sreenivas" <sreenib@lsil.com>, brking@us.ibm.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>, bunk@fs.tum.de,
       Andrew Morton <akpm@osdl.org>, "Ju, Seokmann" <sju@lsil.com>,
       "Doelfel, Hardy" <hdoelfel@lsil.com>, "Mukker, Atul" <Atulm@lsil.com>
Subject: Re: How to add/drop SCSI drives from within the driver?
Message-ID: <20041215213001.GA9284@lists.us.dell.com>
References: <60807403EABEB443939A5A7AA8A7458B7F5071@otce2k01.adaptec.com> <1102536081.4218.0.camel@localhost.localdomain> <20041215072453.GB17274@lists.us.dell.com> <1103136559.5232.1.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103136559.5232.1.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 01:49:18PM -0500, James Bottomley wrote:
> On Wed, 2004-12-15 at 01:24 -0600, Matt Domsch wrote:
> > James, I've been thinking about this a little more, and you may be on
> > to something here. Let each driver add files as such:
> > 
> > /sys/class/scsi_host
> >  |-- host0
> >  |   |-- add_logical_drive
> >  |   |-- remove_logical_drive
> >  |   `-- rescan_logical_drive
> > 
> > Then we can go 2 ways with this.
> > 1) driver functions directly call scsi_add_device(),
> > scsi_remove_device(), and something for rescan (option 2 handles this
> > one cleanly for us).  ATM, megaraid_mbox doesn't implement a rescan
> > function, so this point may be moot. 
> > 
> > 2) driver functions call a midlayer library function, which invokes
> >    /sbin/hotplug with appropriate data, and add a new /etc/hotplug.d
> >    helper app which would then write to these files:
> > to do likewise.
> 
> I'll buy this (option 2).. it seems like a good way to export the
> megaraid specific information and at the same time integrate it more
> fully into the evolving hotplug infrastructure.

Great, I think that's the right long-term solution.  Can we consider
other paths for the short term, while we evolve the hotplug
infrastructure?  I don't know all the details involved in jumping
straight to option 2 today.

Do you plan to apply LSI's driver patch which adds the driver-private
ioctl to provide the mapping from logical drive address to HCTL value?
Both Dell and LSI have products which are lined up to use this new
ioctl because it's the most expedient thing to do, maintains internal
project schedules, etc, which delaying until this sysfs mechanism hits
will greatly impact those schedules. (I know, many folks on this list
don't care about business-side impacts of choices made on-list.)

If you were to apply LSI's ioctl patch, then that patch becomes stage
0.

Stage 1 is what I posted last night, once tested, and the mgmt apps
convert to use that.

The above can happen pretty quickly I think, i.e. before the holidays.

Stage 2 is option 2 above, which removes the driver calling
scsi_add_device() and friends directly.  Userspace apps converted for
stage 1 are none-the-wiser, as their interface hasn't changed.

This is a Jan-Feb kind of thing, to give proper time for all concerns
to be voiced and included in the kernel-internal APIs, /sbin/hotplug
environment, and userspace helper.

Stage 3, convert all other drivers who need a similar mechanism over
to the new helper functions added in stage 2.

This would be ongoing.


Thoughts?

Thanks,
Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
