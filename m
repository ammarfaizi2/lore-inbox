Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261838AbSJIQoC>; Wed, 9 Oct 2002 12:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbSJIQoC>; Wed, 9 Oct 2002 12:44:02 -0400
Received: from ztxmail04.ztx.compaq.com ([161.114.1.208]:34827 "EHLO
	ztxmail04.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S261838AbSJIQoB> convert rfc822-to-8bit; Wed, 9 Oct 2002 12:44:01 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] 2.5.41, cciss, add rescan disk ioctl (6 of 5 :-)
Date: Wed, 9 Oct 2002 11:49:39 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167D05C@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.5.41, cciss, add rescan disk ioctl (6 of 5 :-)
Thread-Index: AcJvp5ISWFqMU4aGQUCtQ5QRyZeQFAAAnwjg
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       <axboe@suse.de>
X-OriginalArrivalTime: 09 Oct 2002 16:49:39.0474 (UTC) FILETIME=[DBA66720:01C26FB3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox wrote:
> 
> On Wed, 2002-10-09 at 15:46, Stephen Cameron wrote:
> > This patch adds the CCISS_RESCANDISK ioctl which is meant 
> to be used in a 
> > configuration like Steeleye's Lifekeeper.  Two hosts 
> connect to the storage, 
> > one reserves disks.  The 2nd will not be able to read the partition 
> > information because of the reservations.  In the event the 
> 1st system fails, 
> > the 2nd can detect this, (via special hardware + software 
> typically) and then 
> > take over the storage and rescan he disks via this ioctl.
> > Applies to 2.5.41 (after applying my prior 4 patches to 2.5.4[01] )
> 
> Why not use the existing rescanning ioctls like BLKRRPART - 
> what else is
> different to need a custom ioctl?
> 

if i understand correctly, the BLKRRPART just does a rescan_partitions()
and does not do any INQUIRY and READ_CAPACITY to get the 
capacity and geometry information again, as normally, this would
already be done. 

This ioctl is meant for a failover type configuration where two hosts
have access to the storage.  Host A does a scsi reservation of the storage,
preventing the Host B from being able to talk to it.  So Host B can't do
the READ_CAPACITY successfully.  (this is on purpose).

This ioctl is used upon failover.  When Host B detects that Host A is failed,
Host B would make sure host A is_really_ dead, for example
by depriving it of power, and break the scsi reservation.  Then it uses
this ioctl to get the geometry and capacity information and rescan
the partitions.

Maybe it should use 2 ioctls?  One special one to get the geometry
and capacity info, and then the BLKRRPART ioctl to rescan partitions?

Hope that makes sense.

-- steve
 
