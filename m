Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265356AbTLHJbg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 04:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265357AbTLHJbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 04:31:33 -0500
Received: from bunyip.cc.uq.edu.au ([130.102.2.1]:50959 "EHLO
	bunyip.cc.uq.edu.au") by vger.kernel.org with ESMTP id S265356AbTLHJba
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 04:31:30 -0500
Message-ID: <3FD444DD.4080206@torque.net>
Date: Mon, 08 Dec 2003 19:31:09 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, es-es, es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: cdrecord hangs my computer
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
 > On Sat, 6 Dec 2003, Wakko Warner wrote:
 > > >
 > > > One is just plain confusion - anybody who uses cdrecord has
 > > > either been
 > > > confused by the silly SCSI numbering (while "dev=/dev/hdc" is not
 > > > confusing at all, and uses the same device you use for
 > > > mounting the thing etc).
 > >
 > > Actually, it would be nice if I could use dev=/dev/scd0.  I
 > > do have a scsi burner (and an ide one too)
 >
 > It _should_ just work these days. Anything that uses "cdrom_ioctl()"
 > should automatically get the SCSI command translation code (which
 > isn't part of the scsi driver).

Yes dev=/dev/scd0 should work for "real" SCSI (and USB, IEEE1394
and sATA [via libata] attached) cd/dvd players in lk 2.6.
Copying the SG_IO ioctl and friends into the block
layer isn't exactly pretty in lk 2.6. No doubt I'll be hearing from
the author of cdrecord about some of the rough edges. Basically
cdrecord is tricked into believing it is talking to an sg device.

One rough edge is cdrecord's use of the SCSI_IOCTL_GET_IDLUN ioctl
which encodes bus/channel/target/lun into an integer. cdrecord
uses this for its dev=<n,m,q> notation. The drivers/block/scsi_ioctl.c
implementation returns 0 in all cases. So if you have 2 or more
ATAPI cd/dvd burners cdrecord's dev=<n,m,q> usage won't be able
to differentiate.

ide-scsi has always had problems (I spent about a week on it
and gave up with only a few minor fixes to report) but it
may be a useful "insurance" driver to keep around in lk 2.6 .
[It is also needed for ATAPI tapes so its deprecatation
warning might like to take into account the peripheral device
type.]

Yes the bus/channel/target/lun notation is dated but it has been
in place for around 15 years (in the Sun's bus/target/lun form).
These days the "bus/channel" component is defined by the host OS,
the "target" by the transport (see "object identifiers" in SAM-3
Annex A). Only the "lun" is defined within the SCSI^H^H^Htorage
Architecture Model (SAM-3 section 4.9 in the latest draft).

 > But hey, the scsi layer confuses me. Less than it used to, but still.

Well making the scsi layer handle some of the the most
sophisticated storage devices and some of the most brain
damaged at the same time is proving quite a challenge.
With libata (and later SAS) sATA disks will be getting to
the application space via the sd driver. And how will
object storage devices fit into Linux's block-centric I/O
architecture?

Doug Gilbert


