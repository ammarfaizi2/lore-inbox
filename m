Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272285AbRH3PqJ>; Thu, 30 Aug 2001 11:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272287AbRH3PqA>; Thu, 30 Aug 2001 11:46:00 -0400
Received: from [193.113.209.32] ([193.113.209.32]:53431 "HELO
	c2bapps8.btconnect.com") by vger.kernel.org with SMTP
	id <S272285AbRH3Ppp>; Thu, 30 Aug 2001 11:45:45 -0400
Date: Thu, 30 Aug 2001 16:45:47 +0100
To: linux-kernel@vger.kernel.org
Subject: A possible direction for the next LVM driver
Message-ID: <20010830164547.A807@btconnect.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: Joe Thornber <thornber@btconnect.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm working on the next iteration of the LVM driver, specifically
trying to address the critism directed at the rather ugly ioctl
interface.  The code has reached the stage where it works and it's
possible to see what I'm aiming for.  I would appreciate it if people
could spare the time to review this and give me feedback.  If there is
general agreement that this is moving in the right direction then the
next major version of LVM may be based around a future version of this
driver.  Please CC me in replies.  The code can be found at:

ftp://ftp.sistina.com/pub/LVM2/device-mapper/device-mapper.tar.bz2


The main goal of this driver is to support volume management in
general, not just for LVM.  The kernel should provide general
services, not support specific applications.  eg, The driver has no
concept of volume groups.

The driver does this by mapping sector ranges for the logical device
onto 'targets'.

When the logical device is accessed, the make_request function looks
up the correct target for the given sector, and then asks this target
to do the remapping.

A btree structure is used to hold the sector range -> target mapping.
Since we know all the entries in the btree in advance we can make a
very compact tree, omitting pointers to child nodes, (child nodes
locations can be calculated).  Typical users would find they only have
a handful of targets for each logical volume LV.

Benchmarking with bonnie++ suggests that this is certainly no slower
than current LVM.


Target types are not hard coded, instead the register_mapping_type
function should be called.  A target type is specified using three
functions (see the header):

dm_ctr_fn - takes a string and contructs a target specific piece of
            context data.
dm_dtr_fn - destroy contexts.
dm_map_fn - function that takes a buffer_head and some previously
            constructed context and performs the remapping.

Currently there are two two trivial mappers, which are automatically
registered: 'linear', and 'io_error'.  Linear alone is enough to
implement most of LVM.


I do not like ioctl interfaces so this driver is currently controlled
through a /proc interface.  /proc/device-mapper/control allows you to
create and remove devices by 'cat'ing a line of the following format:

create <device name> [minor no]
remove <device name>

If you're not using devfs you'll have to do the mknod'ing yourself,
otherwise the device will appear in /dev/device-mapper automatically.

/proc/device-mapper/<device name> accepts the mapping table:

begin
<sector start> <length> <target name> <target args>...
...
end

where <target args> are specific to the target type, eg. for a linear
mapping:

<sector start> <length> linear <major> <minor> <start>

and the io-err mapping:

<sector start> <length> io-err

The begin/end lines around the table are nasty, they should be handled
by open/close of the file.

The interface is far from complete, currently loading a table either
succeeds or fails, you have no way of knowing which line of the
mapping table was erroneous.  Also there is no way to get status
information out, though this should be easy to add, either as another
/proc file, or just by reading the same /proc/device-mapper/<device>
file.  I will be seperating the loading and validation of a table from
the binding of a valid table to a device.

It has been suggested that I should implement a little custom
filesystem rather than labouring with /proc.  For example doing a
mkdir foo in /wherever/device-mapper would create a new device. People
waiting for a status change (eg, a mirror operation to complete) could
poll a file.  Does the community find this an acceptable way to go ?


At the moment the table assumes 32 bit keys (sectors), the move to 64
bits will involve no interface changes, since the tables will be read
in as ascii data.  A different table implementation can therefor be
provided at another time.  Either just by changing offset_t to 64
bits, or maybe implementing a structure which looks up the keys in
stages (ie, 32 bits at a time).

More interesting targets:

striped mapping; given a stripe size and a number of device regions
this would stripe data across the regions.  Especially useful, since
we could limit each striped region to a 32 bit area and then avoid
nasty 64 bit %'s.

mirror mapping; would set off a kernel thread slowly copying data from
one region to another, ensuring that any new writes got copied to both
destinations correctly.  Enabling us to implement a live pvmove
correctly.

- Joe
