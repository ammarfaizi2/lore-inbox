Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319025AbSIJAEL>; Mon, 9 Sep 2002 20:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319023AbSIJAEL>; Mon, 9 Sep 2002 20:04:11 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:10720 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S319021AbSIJAEG>; Mon, 9 Sep 2002 20:04:06 -0400
Date: Mon, 9 Sep 2002 17:08:47 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
Message-ID: <20020909170847.A24352@eng2.beaverton.ibm.com>
References: <patmans@us.ibm.com> <200209091734.g89HY5p11796@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200209091734.g89HY5p11796@localhost.localdomain>; from James.Bottomley@steeleye.com on Mon, Sep 09, 2002 at 12:34:05PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James -

On Mon, Sep 09, 2002 at 12:34:05PM -0500, James Bottomley wrote:

> What about block devices that could usefully use multi-path to achieve network 
> redundancy, like nbd? If it's in the block layer or above, they can be made to 
> work with minimal effort.
> 
> My basic point is that the utility of the feature transcends SCSI, so SCSI is 
> too low a layer for it.

I agree it has potential uses outside of SCSI, this does not directly
imply that we need to create a generic implementation. I have found no
code to reference in other block drivers or in the block layer. I've
looked some at the dasd code but can't figure out if or where there is any
multi-path code.

Putting multi-path into the block layer means it would have to acquire and
maintain a handle (i.e.  path) for each device it knows about, and then
eventually pass this handle down to the lower level. I don't see this
happening in 2.5/2.6, unless someone is coding it right now.

It makes sense to at least expose the topology of the IO storage, whether
or not the block or other layers can figure out what to do with the
information.  That is, ideally for SCSI we should have a representation of
the target - like struct scsi_target - and then the target is multi-pathed,
not the devices (LUNs, block or character devices) attached to the target.
We should also have a bus or fabric representation, showing multi-path from
the adapters view (multiple initiators on the fabric or bus).

Whether or not the fabric or target information is used to route IO, they
are useful for hardware removal/replacement. Imagine replacing a fibre
switch, or replacing a failed controller on a raid array.

If all this information was in the device model (driver?), with some sort
of function or data pointers, perhaps (in 2.7.x timeframe) we could route
IO and call appropriate drivers based on that information.

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

Yes, but then we need some sort of md/RAID/volume manager aware eleavator
code + bio splitting, and perhaps avoid calling elevator code normally called
for a Scsi_Device. Though I can imagine splitting the bio in md and then
still merging and sorting requests for SCSI.

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

Yes negotiation is at the adapter level, but that does not have to be tied
to a Scsi_Device. I need to search for Scsi_Device::hostdata usage to
figure out details, and to figure out if anything is broken in the current
scsi multi-path code - right now it requires the same adapter drivers be
used and that certain Scsi_Host parameters are equal if multiple paths
to a Scsi_Device are found.

> > For sd, this means if you have n paths to each SCSI device, you are
> > limited to whatever limit sd has divided by n, right now 128 / n.
> > Having four paths to a device is very reasonable, limiting us to 32
> > devices, but with the overhead of 128 devices. 
> 
> I really don't expect this to be true in 2.6.

If we use a Scsi_Device for each path, we always have the overhead of the
number of paths times the number of devices - upping the limits of sd
certainly helps, but we are then increasing the possibly large amount
of memory that we can waste. And, other devices besides disks can be
multi-pathed.

> > Using a volume manager to implement multiple paths (again non-failover
> > model) means that the queue_depth might be too large if the
> > queue_depth (i.e.  number of outstanding commands sent to the drive)
> > is set as a per-device value - we can end sending n * queue_depth
> > commands to a device.
> 
> The queues tend to be in the controllers, not in the RAID devices, thus for a 
> dual path RAID device you usually have two caching controllers and thus twice 
> the queue depth (I know this isn't always the case, but it certainly is enough 
> of the time for me to argue that you should have the flexibility to queue per 
> path).

You can have multiple initiators on FCP or SPI, without dual controllers
involved at all. Most of my multi-path testing has been with dual
ported FCP disk drives, with multiple FCP adapters connected to a
switch, not with disk arrays (I don't have any non-failover multi-ported
disk arrays available, I'm using a fastt 200 disk array); I don't know the
details of the drive controllers for my disks, but putting multiple
controllers in a disk drive certainly would increase the cost.

Yes, per path queues and per device queues are reasonable; per path queues
requires knowledge of actual device ports not in the current scsi multi-path
patch. The code I have now uses the Scsi_Host::can_queue to limit the number
of commands sent to a host. I really need slave_attach() support in the host
adapter (like Doug L's patch a while back), plus maybe a slave_attach_path(),
and/or queue limit per path.

Per path queues are not required, as long as any queue limits do not
hinder the performance.

> SCSI got into a lot of trouble by going down the "kernel doesn't have X 
> feature I need, so I'll just code it into the SCSI mid-layer instead", I'm 
> loth to accept something into SCSI that I don't think belongs there in the 
> long term.
> 
> Answer me this question:
> 
> - In the forseeable future does multi-path have uses other than SCSI?
> 
> I've got to say, I can't see a "no" to that one, so it fails the high level 
> bar to getting into the scsi subsystem.  However, the kernel, as has been said 
> before, isn't a theoretical excercise in design, so is there a good expediency 
> argument (like "it will take one year to get all the features of the block 
> layer to arrive and I have a customer now").  Also, to go in under expediency, 
> the code must be readily removable against the day it can be redone correctly.

Yes, there could be future multi-path users, or maybe with DASD. If we take
SCSI and DASD as existing usage, they could be a basis for a block layer
(or generic) set of multi-path interfaces.

There is code available for scsi multi-path, this is not a design in theory.
Anyone can take the code and fold it into a block layer implementation or
other approach. I would be willing to work on scsi usage or such for any
new block level or other such code for generic multi-path use. At this
time I wouldn't feel comfortable adding to or modifying block layer
interfaces and code, nor do I think it is possible to come up with the
best interface given only one block driver implementation, nor do I think
there is enough time to get this into 2.5.x.

IMO, there is demand for scsi multi-path support now, as users move to 
large databases requiring higher availabitity. md or volume manager
for failover is adequate in some of these cases.

I see other issues as being more important to scsi - like cleaning it up
or rewriting portions of the code, but we still need to add new features
as we move forward.

Even with generic block layer multi-path support, we still need block
driver (scsi, ide, etc.) code for multi-path.

> > Generic device naming consistency is a problem if multiple devices
> > show up with the same id.
> 
> Patrick Mochel has an open task to come up with a solution to this.

I don't think this can be solved if multiple devices show up with the same
id. If I have five disks that all say I'm disk X, how can there be one
name or handle for it from user level?

> > With the scsi layer multi-path, ide-scsi or usb-scsi could also do
> > multi-path IO. 
> 
> The "scsi is everything" approach got its wings shot off at the kernel summit, 
> and subsequently confirmed its death in a protracted wrangle on lkml (I can't 
> remember the reference off the top of my head, but I'm sure others can).

Agreed, but having the block layer be everything is also wrong.

My view is that md/volume manager multi-pathing is useful with 2.4.x, scsi
layer multi-path for 2.5.x, and this (perhaps with DASD) could then evolve
into generic block level (or perhaps integrated with the device model)
multi-pathing support for use in 2.7.x. Do you agree or disagree with this
approach?

-- Patrick Mansfield
