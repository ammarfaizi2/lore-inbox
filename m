Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbUBJWlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 17:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbUBJWly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 17:41:54 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:34285 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S261368AbUBJWlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 17:41:50 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Thomas Horsten <thomas@horsten.com>
Date: Wed, 11 Feb 2004 09:41:41 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16425.24101.755694.738298@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, <linux-raid@vger.kernel.org>
Subject: Re: ATARAID userspace configuration tool
In-Reply-To: message from Thomas Horsten on Tuesday February 10
References: <Pine.LNX.4.40.0402101405190.25784-100000@jehova.dsm.dk>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday February 10, thomas@horsten.com wrote:
> Hi,
> 
> I'm writing a userspace utility to detect/configure Medley (and later
> other) ataraid devices in 2.6.
...
> 
> On top of this it would be useful to make the underlying devices
> inaccessible after the mapped device is created (to prevent people from
> doing things like fdisk /dev/hda, when what they really wanted was
> something like fdisk /dev/ataraid/disc).

The best way to avoid this sort of problem is to change "fdisk" (and
mkfs and fsck and ...) to (optionally) open the device with O_EXCL.

In 2.6, a device that is "claimed" by a kernel subsystem - ie is
mounted, or is part of an MD or DM array, or has a partition which is
claimed in one of these ways, cannot be opened O_EXCL.

So these tools that operate on block devices and expect exclusive
access should ask for it.
They probably should have a way to not use O_EXCL if the admin
promises they know what they are doing, as fsck does need to run on a
mounted partition some times, and fdisk can reasonably be used on
devices with mounted partitions.  But the default should be O_EXCL.

NeilBrown

> 
> Detecting the partition table in userspace would fix this, but it's not
> planned before 2.7 and I don't think it is safe to leave the false
> partitions exposed.
> 
> - Some RAID types will need (I think) to use the MD framework as well as
> DM (e.g. RAID0+1), so the device the users would be the md device which
> would be composed of two dm devices. Is there a way to hide the underlying
> dm devices from the user so he they only see the ones they should use (or
> prevent these from being used directly some other way)?
> 
> // Thomas
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
