Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318785AbSIISfa>; Mon, 9 Sep 2002 14:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318784AbSIISfa>; Mon, 9 Sep 2002 14:35:30 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:22927 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318769AbSIISfZ>;
	Mon, 9 Sep 2002 14:35:25 -0400
Date: Mon, 9 Sep 2002 11:40:26 -0700
From: Mike Anderson <andmike@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Patrick Mansfield <patmans@us.ibm.com>, Lars Marowsky-Bree <lmb@suse.de>,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
Message-ID: <20020909184026.GD1334@beaverton.ibm.com>
Mail-Followup-To: James Bottomley <James.Bottomley@SteelEye.com>,
	Patrick Mansfield <patmans@us.ibm.com>,
	Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20020909095652.A21245@eng2.beaverton.ibm.com> <200209091734.g89HY5p11796@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200209091734.g89HY5p11796@localhost.localdomain>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley [James.Bottomley@SteelEye.com] wrote:
> patmans@us.ibm.com said:
> > Using md or volume manager is wrong for non-failover usage, and
> > somewhat bad for failover models; generic block layer is OK but it is
> > wasted code for any lower layers that do not or cannot have multi-path
> > IO (such as IDE). 
> 
> What about block devices that could usefully use multi-path to achieve network 
> redundancy, like nbd? If it's in the block layer or above, they can be made to 
> work with minimal effort.

When you get into networking I believe we may get into path failover
capability that is already implemented by the network stack. So the
paths may not be visible to the block layer.

> 
> My basic point is that the utility of the feature transcends SCSI, so SCSI is 
> too low a layer for it.
> 
> I wouldn't be too sure even of the IDE case: IDE has a habit of copying SCSI 
> features when they become more main-stream (and thus cheaper).  It wouldn't 
> suprise me to see multi-path as an adjunct to the IDE serial stuff.
> 

The utility does transcend SCSI, but transport / device specific
characteristics may make "true" generic implementations difficult.

To add functionality beyond failover multi-path you will need to get into
transport and device specific data gathering.

> > A major problem with multi-path in md or other volume manager is that
> > we use multiple (block layer) queues for a single device, when we
> > should be using a single queue. If we want to use all paths to a
> > device (i.e. round robin across paths or such, not a failover model)
> > this means the elevator code becomes inefficient, mabye even
> > counterproductive. For disk arrays, this might not be bad, but for
> > actual drives or even plugging single ported drives into a switch or
> > bus with multiple initiators, this could lead to slower disk
> > performance. 
> 
> That's true today, but may not be true in 2.6.  Suparna's bio splitting code 
> is aimed precisely at this and other software RAID cases.

I have not looked at Suparna's patch but it would seem that device
knowledge would be helpful for knowing when to split.

> > In the current code, each path is allocated a Scsi_Device, including a
> > request_queue_t, and a set of Scsi_Cmnd structures. Not only do we end
> > up with a Scsi_Device for each path, we also have an upper level (sd,
> > sg, st, or sr) driver attached to each Scsi_Device. 
> 
> You can't really get away from this.  Transfer parameters are negotiated at 
> the Scsi_Device level (i.e. per device path from HBA to controller), and LLDs 
> accept I/O's for Scsi_Devices.  Whatever you do, you still need an entity that 
> performs most of the same functions as the Scsi_Device, so you might as well 
> keep Scsi_Device itself, since it works.

James have you looked at the documentation / patch previously pointed to
by Patrick? There is still a Scsi_device.

> 
> > For sd, this means if you have n paths to each SCSI device, you are
> > limited to whatever limit sd has divided by n, right now 128 / n.
> > Having four paths to a device is very reasonable, limiting us to 32
> > devices, but with the overhead of 128 devices. 
> 
> I really don't expect this to be true in 2.6.
> 

While the device space may be increased in 2.6 you are still consuming
extra resources, but we do this in other places also.

> > We could implement multi-path IO in the block layer, but if the only
> > user is SCSI, this gains nothing compared to putting multi-path in the
> > scsi layers. Creating block level interfaces that will work for future
> > devices and/or future code is hard without already having the devices
> > or code in place. Any block level interface still requires support in
> > the the underlying layers.
> 
> > I'm not against a block level interface, but I don't have ideas or
> > code for such an implementation.
> 
> SCSI got into a lot of trouble by going down the "kernel doesn't have X 
> feature I need, so I'll just code it into the SCSI mid-layer instead", I'm 
> loth to accept something into SCSI that I don't think belongs there in the 
> long term.
> 
> Answer me this question:
> 
> - In the forseeable future does multi-path have uses other than SCSI?
> 

See top comment.

> The "scsi is everything" approach got its wings shot off at the kernel summit, 
> and subsequently confirmed its death in a protracted wrangle on lkml (I can't 
> remember the reference off the top of my head, but I'm sure others can).

Could you point this out so I can understand the context.

-Mike
-- 
Michael Anderson
andmike@us.ibm.com

