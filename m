Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275093AbTHGCSO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 22:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275094AbTHGCSO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 22:18:14 -0400
Received: from imf17aec.mail.bellsouth.net ([205.152.59.65]:26011 "EHLO
	imf17aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S275093AbTHGCSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 22:18:10 -0400
From: "J.C. Wren" <jcwren@jcwren.com>
Reply-To: jcwren@jcwren.com
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test2, compact flash, IDE, and kobject errors
Date: Wed, 6 Aug 2003 22:18:06 -0400
User-Agent: KMail/1.5.3
References: <3F30CFC1.1090205@toxyn.org> <1060209414.1903.7.camel@ibm-c.pdx.osdl.net> <3F31B1A1.7070402@toxyn.org>
In-Reply-To: <3F31B1A1.7070402@toxyn.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308062218.06159.jcwren@jcwren.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As I've mentioned before, I have an embedded Linux system that has been 
running 2.2.12, and I'm looking at bringing it up to a modern kernel for some 
features that we're looking at implementing.  It's a 386EX system, 2MB flash 
(for BIOS and kernel), 8MB RAM, and a 32MB compact flash card.

WIth both 2.5.69 (last version I attempted), and 2.6.0-test2, when the CF is 
probed, I would get a message indicating kobject had failed with an EEXISTS 
error code.  After the the kernel spits out the message about the HD size, 
I'd get:

	hda: hda1
	hda: hda1
	(then the kobject failure and stack trace)

After a lot of printk's, I determine that the kernel is attempting to register 
the partition or drive twice.  This happens because in fs/partions/check.c, 
register_disk() calls blkdev_get().  If blkdev_get() sees the media change 
flag set, he calls rescan_partitions(), which causes the partition to be 
registered.  After it returns, register_disk() calls add_partition(), which 
results in the kernel throwing a kobject error that it's already registered.

The solution that I think is correct (the audience LAUGH sign is now lit) is 
to add a 'hdx=removable' and 'hdx=notremovable' config parameter.  If you are 
booting from a removable media device, such as a CF card (and certain items 
like floppies seems to be special cased out, which I'm guessing is why you 
don't see this on certain media types), this flag would override the 
removable flag determined by the probe.  And for whatever reason someone 
might want to, a non-removable device could be marked as removable.

I need to clean out a bunch of printks, but if this isn't the totally wrong 
approach, I'll submit a patch for it.  So far, this patch seems to have fixed 
my problem.

One question I do have is that e2fsck seems phenominally slower under 
2.6.0-test2 than 2.2.12.  It's the same version of e2fsck, so I'm guessing 
the disk throughput is slower (it's all PIO), but I'm not sure what in the 
IDE driver could have halfed or one-thirded the disk throughput.  Any 
thoughts on that would be greatly appreciated.

	--John

