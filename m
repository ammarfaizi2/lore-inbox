Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318121AbSIIR3k>; Mon, 9 Sep 2002 13:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318139AbSIIR3j>; Mon, 9 Sep 2002 13:29:39 -0400
Received: from host194.steeleye.com ([216.33.1.194]:31247 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S318121AbSIIR3f>; Mon, 9 Sep 2002 13:29:35 -0400
Message-Id: <200209091734.g89HY5p11796@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Patrick Mansfield <patmans@us.ibm.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ? 
In-Reply-To: Message from Patrick Mansfield <patmans@us.ibm.com> 
   of "Mon, 09 Sep 2002 09:56:52 PDT." <20020909095652.A21245@eng2.beaverton.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 09 Sep 2002 12:34:05 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

patmans@us.ibm.com said:
> Using md or volume manager is wrong for non-failover usage, and
> somewhat bad for failover models; generic block layer is OK but it is
> wasted code for any lower layers that do not or cannot have multi-path
> IO (such as IDE). 

What about block devices that could usefully use multi-path to achieve network 
redundancy, like nbd? If it's in the block layer or above, they can be made to 
work with minimal effort.

My basic point is that the utility of the feature transcends SCSI, so SCSI is 
too low a layer for it.

I wouldn't be too sure even of the IDE case: IDE has a habit of copying SCSI 
features when they become more main-stream (and thus cheaper).  It wouldn't 
suprise me to see multi-path as an adjunct to the IDE serial stuff.

> A major problem with multi-path in md or other volume manager is that
> we use multiple (block layer) queues for a single device, when we
> should be using a single queue. If we want to use all paths to a
> device (i.e. round robin across paths or such, not a failover model)
> this means the elevator code becomes inefficient, mabye even
> counterproductive. For disk arrays, this might not be bad, but for
> actual drives or even plugging single ported drives into a switch or
> bus with multiple initiators, this could lead to slower disk
> performance. 

That's true today, but may not be true in 2.6.  Suparna's bio splitting code 
is aimed precisely at this and other software RAID cases.

> In the current code, each path is allocated a Scsi_Device, including a
> request_queue_t, and a set of Scsi_Cmnd structures. Not only do we end
> up with a Scsi_Device for each path, we also have an upper level (sd,
> sg, st, or sr) driver attached to each Scsi_Device. 

You can't really get away from this.  Transfer parameters are negotiated at 
the Scsi_Device level (i.e. per device path from HBA to controller), and LLDs 
accept I/O's for Scsi_Devices.  Whatever you do, you still need an entity that 
performs most of the same functions as the Scsi_Device, so you might as well 
keep Scsi_Device itself, since it works.

> For sd, this means if you have n paths to each SCSI device, you are
> limited to whatever limit sd has divided by n, right now 128 / n.
> Having four paths to a device is very reasonable, limiting us to 32
> devices, but with the overhead of 128 devices. 

I really don't expect this to be true in 2.6.

> Using a volume manager to implement multiple paths (again non-failover
> model) means that the queue_depth might be too large if the
> queue_depth (i.e.  number of outstanding commands sent to the drive)
> is set as a per-device value - we can end sending n * queue_depth
> commands to a device.

The queues tend to be in the controllers, not in the RAID devices, thus for a 
dual path RAID device you usually have two caching controllers and thus twice 
the queue depth (I know this isn't always the case, but it certainly is enough 
of the time for me to argue that you should have the flexibility to queue per 
path).

> We could implement multi-path IO in the block layer, but if the only
> user is SCSI, this gains nothing compared to putting multi-path in the
> scsi layers. Creating block level interfaces that will work for future
> devices and/or future code is hard without already having the devices
> or code in place. Any block level interface still requires support in
> the the underlying layers.

> I'm not against a block level interface, but I don't have ideas or
> code for such an implementation.

SCSI got into a lot of trouble by going down the "kernel doesn't have X 
feature I need, so I'll just code it into the SCSI mid-layer instead", I'm 
loth to accept something into SCSI that I don't think belongs there in the 
long term.

Answer me this question:

- In the forseeable future does multi-path have uses other than SCSI?

I've got to say, I can't see a "no" to that one, so it fails the high level 
bar to getting into the scsi subsystem.  However, the kernel, as has been said 
before, isn't a theoretical excercise in design, so is there a good expediency 
argument (like "it will take one year to get all the features of the block 
layer to arrive and I have a customer now").  Also, to go in under expediency, 
the code must be readily removable against the day it can be redone correctly.

> Generic device naming consistency is a problem if multiple devices
> show up with the same id.

Patrick Mochel has an open task to come up with a solution to this.

> With the scsi layer multi-path, ide-scsi or usb-scsi could also do
> multi-path IO. 

The "scsi is everything" approach got its wings shot off at the kernel summit, 
and subsequently confirmed its death in a protracted wrangle on lkml (I can't 
remember the reference off the top of my head, but I'm sure others can).

James


