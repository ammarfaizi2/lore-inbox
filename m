Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262671AbTJTPie (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 11:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262672AbTJTPie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 11:38:34 -0400
Received: from rtlab.med.cornell.edu ([140.251.145.175]:46266 "EHLO
	openlab.rtlab.org") by vger.kernel.org with ESMTP id S262671AbTJTPic
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 11:38:32 -0400
Date: Mon, 20 Oct 2003 11:38:17 -0400 (EDT)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Rereading the Partition Table (ioctl BLKRRPART)
Message-ID: <Pine.LNX.4.33L2.0310201121350.17966-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I was adminning one of my IDE hard drives the other day, taking an
existing partition and slicing and dicing it a bit to break it out into a
few partitions, and was slightly annoyed by something that has always been
true in Linux (and in any OS really):  the need to completely unmount all
partitions on a drive (getting the usecount for the entire device to 0) in
order to successfully re-read the partition table.  In many cases if the
drive also has the rootfs on it, this effectively means rebooting.

Anyhow, in my quest to keep my uptime as high as possible, I was wondering
how feasible it would be to make the BLKRRPART ioctl a little more
flexible, so that in some cases a reboot wouldn't be required.

Of course, if you modify a parition that is currently in use (ie: has a
mounted fs), then a reboot would be necessary.  Also, if you insert new
partitions in such a way that existing partitions would be 'renumbered',
perhaps a reboot would still be necessary.

However, consider the following case:

1. You have a disk with some unused space at the end, say hda5.  Your
    Rootfs is hda1, and your swapfs is hda2. (hda5 is not mounted.)

2. You repartition hda5 into hda5 and hda6 (by splitting it in two).

3. You would like the changes to take effect (meaning hda6 now points to a
   real block device, and hda5 is now resized) immediately, without a
   reboot.

4. You issue the BLKRRPART ioctl. (well, not you, but, say, cfdisk or
   fdisk does)

5. The linux kernel groks the partition table, realizes that even though
   hda has a usecount > 0, the partition table changes are ok, since
   they don't cause any insanity.. so the kernel resizes hda5 in its data
   structures, and registers hda6.  It returns 0 for success.

6. Your uptime is not affected since you don't have to reboot.

7. PROFIT!!!! :)


Well, what do you guys think?  I am tempted to just hack the sources now
to get this working for myself, but before I start I am afraid maybe the
situation isn't quite so simple... or there might be something I am
overlooking.  Can someone with more experience in the kernel share their
thoughts on this?

Thanks!

-Calin




