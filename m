Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUCCWKH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 17:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbUCCWKG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 17:10:06 -0500
Received: from potato.cts.ucla.edu ([149.142.36.49]:48571 "EHLO
	potato.cts.ucla.edu") by vger.kernel.org with ESMTP id S261181AbUCCWJ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 17:09:27 -0500
Date: Wed, 3 Mar 2004 14:09:20 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: linux-kernel@vger.kernel.org
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: 2.4.23: brief lockup and __alloc_pages: 0-order allocation failed
 (gfp=0x1f0/0)
Message-ID: <Pine.LNX.4.58.0403031335050.19647@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This morning several minutes into the daily cron run, I logged two
instances of the message:

Mar  3 06:41:37 foxglove kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Mar  3 06:41:39 foxglove kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d0/0)

Based on a google search of similar reports, I'm guessing that they
happened some time while updatedb was running.  From roughly the time that
updatedb would have started and the next 30 minutes or so, the machine
would lock up for several minutes at a time.  It was still pingable, but
would not accept incoming network connections.

The machine has 4Gb of ram with 9Gb of swap.  512Mb of the ram is being
used as a ramdisk using the rd module.  The rd driver is being loaded as
"rd rd_size=524288".  The ram drive is being created using the commands:

/bin/dd if=/dev/null of=/dev/ram0 bs=1024 count=512
/sbin/mke2fs /dev/ram0
/bin/mount -t ext2 /dev/ram0 /var/spool/ram

The machine usually runs with a load between 2 and 3.  It's part of a pool
running virus scanning software, with an active quarantine.  The OS is
installed on /dev/sda, all partitions formatted ext2.  The quarantine
partition is an md RAID5 over sdb1, sdc1, and sdd1, and is JFS formatted.

Looking at memory stats, it looksl ike most of memory is eaten by cache.
Right now, free reports:

cbs@foxglove:/etc/modutils > free
             total       used       free     shared    buffers     cached
Mem:       4077448    4012536      64912          0      78080    3347292
-/+ buffers/cache:     587164    3490284
Swap:      9381784      32380    9349404
cbs@foxglove:/etc/modutils >

As far as I'm aware, the hanging just started happening this morning.
It's the first time that I've seen the __alloc_pages failure. The machine
has an uptime of 94 days and is going to be bumped to 2.4.25 in the near
future.

I was able to replicate the hanging by doing a "tar -zxf" of a built
2.4.25 tree into a partition on sda.  It did not log anything to the
kernel buffer, so the hanging may be separate from the __alloc_pages
problem.

Is this a bug, or expected behavior for my setup?  If it's expected
behavior, is there anything particular I should look at tuning?  If it's a
bug, is there any other information that would be helpful?


Chris Stromsoe
