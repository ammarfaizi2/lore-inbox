Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTL2M4e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 07:56:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263478AbTL2M4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 07:56:33 -0500
Received: from 10fwd.cistron-office.nl ([62.216.29.197]:13216 "EHLO
	smtp.cistron-office.nl") by vger.kernel.org with ESMTP
	id S263463AbTL2MyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 07:54:15 -0500
Date: Mon, 29 Dec 2003 13:54:14 +0100
From: Miquel van Smoorenburg <miquels@cistron.nl>
To: linux-kernel@vger.kernel.org
Subject: Speed drop /dev/sda -> /dev/sda1 -> /dev/vg0/test (3ware/LVM)
Message-ID: <20031229125412.GA28262@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-NCC-RegID: nl.cistron
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	I'm running Linux 2.6.0 with a 3ware 8506 controller in
hardware RAID5 mode. The RAID5 array is built of 7+1 200 MB SATA
disks.

Now it appears that more "mappings" on the array have a bad
influence on speed. /dev/sda is the fastest, /dev/sda1 is quite
a bit slower, LVM on /dev/sda is slower yet and LVM on /dev/sda1
is the slowest.

Results of a dd write directly on the RAID5 whole device:

time -p sh -c "dd if=/dev/zero of=/dev/sda bs=4k count=100000; sync"
100000+0 records in
100000+0 records out
409600000 bytes transferred in 5.120484 seconds (79992437 bytes/sec)
real 5.23
user 0.03
sys 0.98

Results on the first partition:

time -p sh -c "dd if=/dev/zero of=/dev/sda1 bs=4k count=100000; sync"
100000+0 records in
100000+0 records out
409600000 bytes transferred in 6.141125 seconds (66697878 bytes/sec)
real 6.24
user 0.04
sys 2.06

LVM is created on /dev/sda or /dev/sda1 using the following commands:
pvcreate $DEVICE
vgcreate vg0 $DEVICE
lvcreate -L 100G -n test vg0

Results for a logical volume on /dev/sda:

time -p sh -c "dd if=/dev/zero of=/dev/vg0/test bs=4k count=100000; sync"
100000+0 records in
100000+0 records out
409600000 bytes transferred in 8.624306 seconds (47493676 bytes/sec)
real 8.65
user 0.05
sys 1.03

time -p sh -c "dd if=/dev/zero of=/dev/vg0/test bs=4k count=100000; sync"
Results for a logical volume on /dev/sda1:
100000+0 records in
100000+0 records out
409600000 bytes transferred in 9.223930 seconds (44406234 bytes/sec)
real 9.27
user 0.07
sys 0.97

This is reproducable. I also tested this on a software RAID5
array, but with SW RAID5 it doesn't matter if I use the whole
disk, a partition, or a logical volume; performance is always
the same (slightly faster than HW RAID5; 100 MB/sec).

Any idea how to get the performance back ? How can I go about
debugging this ?

Mike.
