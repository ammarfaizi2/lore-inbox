Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUBJO67 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 09:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265924AbUBJO65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 09:58:57 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:7639 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S265910AbUBJO6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 09:58:49 -0500
Subject: Re: ATARAID userspace configuration tool
From: Christophe Saout <christophe@saout.de>
To: Thomas Horsten <thomas@horsten.com>
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
In-Reply-To: <Pine.LNX.4.40.0402101405190.25784-100000@jehova.dsm.dk>
References: <Pine.LNX.4.40.0402101405190.25784-100000@jehova.dsm.dk>
Content-Type: text/plain
Message-Id: <1076425115.23946.18.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 10 Feb 2004 15:58:35 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Di, den 10.02.2004 schrieb Thomas Horsten um 15:18:

> - Is there a "recommended" way to enumerate all block devices (not
> partitions) from userside? Since this is ATA RAID, I could of course just
> read the ideX majors from /proc/devices and try all the minors, but I
> would prefer to get a list of all detected block devices in a portable
> way.

You could go through the block devices in /sys and check if it is
attached to a pci card from one of the ataraid vendors...?

> - After I have used the DM (and possible MD for some RAID types) to map
> the ataraid devices, is there a way to remove the partitions from the
> underlying disks from the kernel?

Nope.

> This was my main reason for wanting to
> do kernel-level autodetection of these arrays, so I could prevent add_disk
> from being called and analysing the partition table (on these BIOS RAIDs,
> in striped mode the first disk contains the partition table for the entire
> array in sector 0, and if the user (or a script) tries to mount the
> partitions (or even read the extended partition table) it may try to read
> after the end of the disk and will in any case use wrong sector numbers -
> leading to possible disk corruption.

Well, if the device is used by DM at least you cannot mount it anymore
(because it is bd_claimed), but still see and access it via open and
read.

> On top of this it would be useful to make the underlying devices
> inaccessible after the mapped device is created (to prevent people from
> doing things like fdisk /dev/hda, when what they really wanted was
> something like fdisk /dev/ataraid/disc).

I have a really bad idea :)

Try to combine it with udev. udev calls the ide script, the ide script
then calls the ataraid detector. If the device is non-ataraid, go on as
usual. If it is, build the device-mapper device and symlink (if it
doesn't already exist) and tell udev to not create anything.


