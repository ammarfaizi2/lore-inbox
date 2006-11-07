Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754151AbWKGPzH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754151AbWKGPzH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Nov 2006 10:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754146AbWKGPzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Nov 2006 10:55:07 -0500
Received: from mtagate5.de.ibm.com ([195.212.29.154]:22583 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1754151AbWKGPzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Nov 2006 10:55:04 -0500
Date: Tue, 7 Nov 2006 16:55:33 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [RFC/Patch 0/5] Improve handling of changes in device tree.
Message-ID: <20061107165533.037d6ea2@gondolin.boeblingen.de.ibm.com>
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

for quite a while, we've been trying to make block devices on s390
channel attached devices (aka ccw devices) more resilent against
outages of storage servers.

The main problem is that the kernel doesn't take well to having a
mounted device removed (and that might happen if, for instance, there
is an intermittant outage at the switch connecting the storage server
and we get machine checks indicating the dasd devices are no longer
there).

To work around this, we introduced a "disconnected" status for ccw
devices which are in use ("online") but currently not there (or without
a path). The dasd driver will plug its queue when it is notified that
the device is gone, and unplug it when notified that the device is
there again. We have a rather complex logic in the s390 common I/O
layer (see drivers/s390/cio/) in order to get disconnected devices
operational again without introducing lockups with other non-functional
devices coming or going or allocating memory (our swap device may just
be disconnected...)

Currently, our logic works well with most real-world scenarios. Except
one: Re-attaching devices under z/VM.

ccw devices are addressed via io subchannels residing on the css bus:
css0 -> 0.0.0000 -> 0.0.0815
     -> 0.0.0001 -> 0.0.4711
     ...
(There also may be non-io subchannels with no attached ccw device,
although we currently don't support them).

On LPAR, the subchannel<->device relationship is defined in the IOCDS
(which requires manual intervention to change), but z/VM will assign
the first free subchannel to a device when it is attached (and attach
is done by specifying the device number of the ccw device (like 0815
and 4711 in the example above), the subchannel number is completely
uninteresting to z/VM). This may lead to the following:

- z/VM recognizes it can no longer access devices 0815 and 4711 and
  detaches them from the guest.
- Linux gets machine checks indicating devices 0815 and 4711 are gone.
  Since they are currently in use, they are put into "disconnected"
  state.
- Access to devices 0815 and 4711 is reestablished. However, z/VM won't
  automatically reattach them.
- The operator manually reattaches 0815 and 4711. However, since he has
  no way of knowing in which order they were originally attached, he
  first attaches 4711 and then 0815. The layout z/VM presents to Linux
  is now the following:
	subchannel 0 -> device 4711
	subchannel 1 -> device 0815
  So we've now got different devices than before on the same
  subchannel. Currently, we have to deregister the old (disconnected)
  device and register the new one, which leads to all the problems we
  wanted to avoid with the "disconnected" state in the first place.

(There are more ways you can mix up your devices, like "DEFINE xxxx AS
yyyy" under z/VM (which changes the device number from xxxx to yyyy),
but I consider those "shoot yourself in the foot" unlike the above,
which is a real world recovery scenario.)

[Still reading? Here comes the fun part.]

What we really want to do is to switch the devices around, i. e. move
ccw device 0.0.4711 to subchannel 0.0.0000 and ccw device 0.0.0815 to
subchannel 0.0.0001. That is what the following patchset implements:
- Ability to move devices to a new parent in the device tree, keeping
  established relationships intact.
- Using this to move ccw devices appearing on a different subchannel to
  their new parent. There also is a "pseudo subchannel" per channel
  subsystem which servers as a temporary parent for ccw devices which
  have been displaced by a new ccw device on their old subchannel.

This patchset works well for me when detaching several used ccw devices
and reattaching them in random order. It should make us survive storage
server outages in nearly all cases (except when we need to move devices
and we have no chance of getting some memory).

The first two patches are against the driver core:
[1/5] Introduce device_find_child().
[2/5] Introduce device_move(): move a device to a new parent.
(I'd like to ask for a thorough review of that one.)

The next three patches affect the s390 common I/O layer:
[3/5] Prepatory cleanup in common I/O layer.
[4/5] Make the per-subchannel lock dynamic.
[5/5] Dynamic subchannel mapping of ccw devices.

Patches are against 2.6.19-rc4-mm2.

Feedback welcome!

-- 
Cornelia Huck
Linux for zSeries Developer
Tel.: +49-7031-16-4837, Mail: cornelia.huck@de.ibm.com
