Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315595AbSFOVKH>; Sat, 15 Jun 2002 17:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315547AbSFOVKG>; Sat, 15 Jun 2002 17:10:06 -0400
Received: from ns3.maptuit.com ([204.138.244.3]:16132 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S315546AbSFOVKE>;
	Sat, 15 Jun 2002 17:10:04 -0400
Message-ID: <3D0BACBC.414B729@torque.net>
Date: Sat, 15 Jun 2002 17:08:13 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.21 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kurt Garloff <garloff@suse.de>
Subject: Re: /proc/scsi/map
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:

> > How can one assign stable device names to SCSI devices in
> > case there are devices that may or may not be switched on or connected.
> 
> An interesting unsolved problem.
> [Your discussion confuses a few things, especially in the context
> of removable devices: a uuid lives on the disk, the C,B,T,U tends
> to identify the drive rather than the disk.]

In the lsml "[RFC] Persistent naming of scsi devices" thread
Martin K. Petersen <mkp@mkp.net> summarized scsi addressing issues
thus:
#
# What we want is (at least) three ways of addressing a device:
#
# 1. By content.  This is the persistent naming.  Think
#    filesystem/MD/LVM UUID.  This is what you put in /etc/fstab and
#    what metadisk systems use to assemble logical volumes.
#
#    Content referencing is used for accessing data.
#
# 2. By physical path.  This naming is not persistent.  Not even runtime
#    because hotplug, iSCSI and whatnot may mess things up.
#
#    Path naming is for discovery and recovery.  When you add an
#    unlabeled disk you want to reference it by path to give it a name.
#    When you have a failed disk on your system you want to know which
#    physical device to pull from the array.
#
# 3. By enumeration.  This is what the kernel happens to be using to
#    reference the device.  diskN.  Certainly not persistent.
#
#    Enumeration is for the kernel.

The /proc/scsi/map facility proposed by Kurt does a very
good job at tying together points 2) and 3) . As a bonus
it also shows the sg device to primary device mapping
(which is a major headache for me as the sg maintainer).

As for the physical path getting fooled by a re-plug, I would 
like to present the idea of a "device attach event number" 
which would be uniquely issued (ascending order) to each newly 
attached scsi device [an attach timestamp could be useful as well].
This is easy to implement, has a many-to-one
relationship with the physical path (i.e. C,B,T,U) but, at
any instant, has a one-to-one relationship. So the attach
event number can be used as an alias for C,B,T,U** and makes
no pretensions to be persistent from one kernel lifetime
to the next (on the same machine). The scsimon driver supports
a device "attach event number". If the idea is workable the
number should probably be put in the scsi mid-level (i.e.
Scsi_Device structure).

** The C,B,T,U tuple (or nexus) is already a handful and
will probably get uglier with 8-byte luns and iSCSI extensions.
The SCSI_IOCTL_GET_IDLUN tries to pack C,B,T,U into one integer
and obviously won't scale to an 8 byte lun. A new ioctl such as
SCSI_IOCTL_GET_PHYSICAL_PATH (for example) could fix "GET_IDLUN"'s
shortcomings and yield the device attach event number. 


Mike Sullivan (who started the above-mentioned "[RFC] Persistent 
naming of scsi devices" thread) recently presented patches on
lsml for a devnaming (and scsiname) utility. These patches  
address Martin's point 1) [content addressing].


There remains the issue of removable media (i.e. device stays
put but the media is changed). In the absence of asynchronous
event notification, the next (normal) scsi command receives a
"unit attention" to alert the kernel. I'm not sure if Mike's
patch addresses this issue.

> > Life would be easier if the scsi subsystem would just report which
> > SCSI device (uniquely identified by the controller,bus,target,unit tuple)
> > belongs to which high-level device.
> 
> Yes. I took your patch, ported it to 2.5, and tried it out.
> 
> # cat /proc/scsi/map
> # C,B,T,U       Type    onl     sg_nm   sg_dev  nm      dev(hex)
> 1,0,06,00       0x00    1       sg0     c:15:00 sda     b:08:00
> 2,0,00,00       0x00    1       sg1     c:15:01 sdb     b:08:10
> 2,0,00,01       0x00    1       sg2     c:15:02 sdc     b:08:20
> 3,0,00,00       0x00    1       sg3     c:15:03 sdd     b:08:30
> 3,0,00,01       0x00    1       sg4     c:15:04 sde     b:08:40
> 
> Very good - in combination with /proc/scsi/scsi this gives
> good information. I like it.

Adding INQUIRY strings would make it harder to parse and more
cluttered for humans to read.

> But just "cat /proc/scsi/map" is not good enough.
> From the above output alone one cannot easily guess which is which.
> One would need a small utility that reads /proc/scsi/map and
> /proc/scsi/scsi and produces something readable.

Note the possible race condition: reading /proc/scsi/scsi
then /proc/scsi/map (or vice versa) when a hotplug is
occurring...

BTW In lk 2.5 we store the whole INQUIRY response in the
Scsi_Device structure. Currently we have no ioctl to yield
this information to the user space :-(

> Will add sth to util-linux in case this gets accepted.

IMO as soon as lk 2.4.19 comes out, this patch should
be presented to Marcelo (for inclusion in lk 2.4.20). The 
sooner we get it into the lk 2.5 series the better. Could you 
forward your lk 2.5 version of Kurt's patch to Linus (and the
linux-scsi list)?

Doug Gilbert
