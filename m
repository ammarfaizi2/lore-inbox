Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317541AbSIIQw0>; Mon, 9 Sep 2002 12:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317540AbSIIQw0>; Mon, 9 Sep 2002 12:52:26 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:63902 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317521AbSIIQwX>;
	Mon, 9 Sep 2002 12:52:23 -0400
Date: Mon, 9 Sep 2002 09:56:52 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: James Bottomley <James.Bottomley@SteelEye.com>,
       Lars Marowsky-Bree <lmb@suse.de>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC] Multi-path IO in 2.5/2.6 ?
Message-ID: <20020909095652.A21245@eng2.beaverton.ibm.com>
References: <200209091458.g89Evv806056@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200209091458.g89Evv806056@localhost.localdomain>; from James.Bottomley@SteelEye.com on Mon, Sep 09, 2002 at 09:57:56AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 09, 2002 at 09:57:56AM -0500, James Bottomley wrote:
> Lars Marowsky-Bree <lmb@suse.de> said:
> > So, what is the take on "multi-path IO" (in particular, storage) in
> > 2.5/2.6?
> 
> I've already made my views on this fairly clear (at least from the SCSI stack 
> standpoint):
> 
> - multi-path inside the low level drivers (like qla2x00) is wrong

Agreed.

> - multi-path inside the SCSI mid-layer is probably wrong

Disagree

> - from the generic block layer on up, I hold no specific preferences

Using md or volume manager is wrong for non-failover usage, and somewhat
bad for failover models; generic block layer is OK but it is wasted code
for any lower layers that do not or cannot have multi-path IO (such as
IDE).

> 
> James

I have a newer version of SCSI multi-path in the mid layer that I hope to
post this week, the last version patched against 2.5.14 is here:

http://www-124.ibm.com/storageio/multipath/scsi-multipath

Some documentation is located here:

http://www-124.ibm.com/storageio/multipath/scsi-multipath/docs/index.html

I have a current patch against 2.5.33 that includes NUMA support (it
requires discontigmem support that I believe is in the current linus
bk tree, plus NUMA topology patches).

A major problem with multi-path in md or other volume manager is that we
use multiple (block layer) queues for a single device, when we should be
using a single queue. If we want to use all paths to a device (i.e. round
robin across paths or such, not a failover model) this means the elevator
code becomes inefficient, mabye even counterproductive. For disk arrays,
this might not be bad, but for actual drives or even plugging single
ported drives into a switch or bus with multiple initiators, this could
lead to slower disk performance.

If the volume manager implements only a failover model (use only a single
path until that path fails), besides performance issues in balancing IO
loads, we waste space allocating an extra Scsi_Device for each path.

In the current code, each path is allocated a Scsi_Device, including a
request_queue_t, and a set of Scsi_Cmnd structures. Not only do we
end up with a Scsi_Device for each path, we also have an upper level
(sd, sg, st, or sr) driver attached to each Scsi_Device.

For sd, this means if you have n paths to each SCSI device, you are
limited to whatever limit sd has divided by n, right now 128 / n.  Having
four paths to a device is very reasonable, limiting us to 32 devices, but
with the overhead of 128 devices.

Using a volume manager to implement multiple paths (again non-failover
model) means that the queue_depth might be too large if the queue_depth
(i.e.  number of outstanding commands sent to the drive) is set as a
per-device value - we can end sending n * queue_depth commands to a device.

multi-path in the scsi layer enables multi-path use for all upper level scsi
drivers, not just disks.

We could implement multi-path IO in the block layer, but if the only user
is SCSI, this gains nothing compared to putting multi-path in the scsi
layers. Creating block level interfaces that will work for future devices
and/or future code is hard without already having the devices or code in
place. Any block level interface still requires support in the the
underlying layers.

I'm not against a block level interface, but I don't have ideas or code
for such an implementation.

Generic device naming consistency is a problem if multiple devices show up
with the same id.

With the scsi layer multi-path, ide-scsi or usb-scsi could also do
multi-path IO.

-- Patrick Mansfield
