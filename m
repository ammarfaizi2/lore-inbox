Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264436AbTIIUvL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 16:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbTIIUvL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 16:51:11 -0400
Received: from ida.rowland.org ([192.131.102.52]:5636 "HELO ida.rowland.org")
	by vger.kernel.org with SMTP id S264436AbTIIUvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 16:51:06 -0400
Date: Tue, 9 Sep 2003 16:51:06 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@ida.rowland.org
To: Georgi Chorbadzhiyski <gf@unixsol.org>
cc: Matthew Dharm <mdharm-usb@one-eyed-alien.net>,
       USB development list <linux-usb-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] [2.6-test] Bug in usb-storage or scsi?
In-Reply-To: <3F5E2EB8.909@unixsol.org>
Message-ID: <Pine.LNX.4.44L0.0309091639580.643-100000@ida.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Sep 2003, Georgi Chorbadzhiyski wrote:

> Hello,
> I was able to access my Music Pen mp3 player using usb-storage driver
> in 2.4 without any problems. After updating to 2.6 this was not possible
> anymore. It seems that usb-storage driver in 2.6 detect the device but
> I was unable to access /dev/sda1. "mount -t vfat /dev/sda1 /mnt" returns
> this error: "mount: /dev/sda1 is not a valid block device"
> 
> Under 2.4.21-ck3, sda1 is corectly registered.
> 
> Please see the attached files containing dmesg snippets from 2.4 and 2.6
> kerneles as well as 2.6 config. If you need more information I'll be glad
> to provide it.
> 
> The 2.4 kernel that I tested was 2.4.21-ck3
> The 2.6 kernel that I tested was 2.6.0-test5-mm1, 2.6.0-test4 and 2.6.0-test1

More problems with that stupid MODE-SENSE cache page!  There are so many 
USB storage devices that have problems with that -- I wonder if it's worth 
the effort to try to continue supporting it?

Georgi, the problem is with your mp3 player, not usb-storage or SCSI.  
It's crashing when given a perfectly legal SCSI command.  Linux 2.4
doesn't issue the command; that's why it works okay.

If you want a temporary fix for 2.6.0, you can do this:  Edit the 
routine sd_read_cache_type in the file drivers/scsi/sd.c (near line 1100).  
Get rid of (or #ifdef out) most of the function; just leave the last few 
lines where it does:

		printk(KERN_ERR "%s: assuming drive cache: write through\n",
		       diskname);
		sdkp->WCE = 0;
		sdkp->RCD = 0;

You might want to change the KERN_ERR to KERN_NOTICE.

However, you might also want to think twice before doing this if you have 
any other SCSI disks, because making this change will affect all of them.

Alan Stern

