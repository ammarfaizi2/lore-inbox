Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265113AbTFMD1j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 23:27:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265116AbTFMD1j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 23:27:39 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:37021 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265113AbTFMD1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 23:27:36 -0400
Date: Thu, 12 Jun 2003 22:40:44 -0400
From: Ben Collins <bcollins@debian.org>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: linux-scsi@vger.kernel.org,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: scsi_add_device() broken? (was Re: SBP2 hotplug doesn't update /proc/partitions)
Message-ID: <20030613024044.GA499@hopper.phunnypharm.org>
References: <1054770509.1198.79.camel@torrey.et.myrio.com> <3EDE870C.1EFA566C@digeo.com> <1054838369.1737.11.camel@torrey.et.myrio.com> <20030605175412.GF625@phunnypharm.org> <1054858724.3519.19.camel@torrey.et.myrio.com> <20030606025721.GJ625@phunnypharm.org> <1055446080.3480.291.camel@torrey.et.myrio.com> <20030612195243.GV4695@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612195243.GV4695@phunnypharm.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 03:52:43PM -0400, Ben Collins wrote:
> On Thu, Jun 12, 2003 at 12:28:00PM -0700, Torrey Hoffman wrote:
> > I am now running 2.5.70-bk15, and with slab debugging turned off SBP2
> > mostly works.  However, I just had an interesting glitch show up.
> > 
> > I plugged in a 120 GB drive which had two VFAT partitions, mounted them,
> > copied some data to them, unmounted them, and unplugged the drive.  
> > That worked perfectly. (This was the first use of SBP2 after booting.)
> > 
> > Then I plugged in a 250 GB drive with a single reiserfs partition.  The
> > SBP2 driver detected the drive correctly, but the kernel's idea of what
> > partitions are available was not updated.  
> > 
> > /proc/partitions still has the old, stale data from the 120 GB drive and
> > looks like this: (skipping my hda partitions)
> 
> Sounds like the scsi layer is keeping stale info. I'd say this is
> suspiciously similar to what's causing your oops in your later email.
> Track down where the stale info comes from, and I think you'll find the
> cause of both your problems.

scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Query logins to SBP-2 device successful
ieee1394: sbp2: Maximum concurrent logins supported: 1
ieee1394: sbp2: Number of active logins: 0
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: sbp2: Node[02:1023]: Max speed [S400] - Max payload [2048]
  Vendor: FireWire  Model:  1394 Disk Drive  Rev: G603
  Type:   Direct-Access                      ANSI SCSI revision: 02
SCSI device sda: 240121728 512-byte hdwr sectors (122942 MB)
sda: cache data unavailable
sda: assuming drive cache: write through
 sda: unknown partition table
devfs_mk_dir: invalid argument.<5>Attached scsi disk sda at scsi0, channel 0, id 0, lun 0


Note, the "unknown partition table" is ok for me, because I am using a
whole-disk filesystem. However, the devfs_mk_dir() error is suspicious.
Note, I use devfs. 2.5.69+bk (just before 2.6.70) things worked fine.
Now, /dev/sda is not being created. Nothing in /dev/scsi/ either, but:

hopper:~# cat /proc/scsi/sbp2/0
Host scsi0             : SBP-2 IEEE-1394 (ohci1394)
Driver version         : $Rev: 942 $ Ben Collins <bcollins@debian.org>

Module options         :
  max_speed            : S400
  max_sectors          : 255
  serialize_io         : no
  exclusive_login      : no

Attached devices       :
  [Channel: 00, Id: 00, Lun: 00]  Direct-Access     FireWire  1394 Disk Drive


Also, /sys/bus/scsi/devices/0:0:0:0 exists, with a block link to sda.

I suspect this is a problem where scsi_add_device() is not doing all the
stuff it needs to (does anything besides ieee1394 use scsi_add_device
and scsi_remove_device?).


-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
