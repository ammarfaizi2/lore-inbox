Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWAOVfH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWAOVfH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 16:35:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750775AbWAOVfH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 16:35:07 -0500
Received: from pne-smtpout2-sn1.fre.skanova.net ([81.228.11.159]:13050 "EHLO
	pne-smtpout2-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1750767AbWAOVfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 16:35:05 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Damian Pietras <daper@daper.net>, Phillip Susi <psusi@cfl.rr.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Problems with eject and pktcdvd
References: <20060115123546.GA21609@daper.net> <43CA8C15.8010402@cfl.rr.com>
	<20060115185025.GA15782@daper.net> <43CA9FC7.9000802@cfl.rr.com>
	<m3ek39z09f.fsf@telia.com> <20060115210443.GA6096@daper.net>
	<Pine.LNX.4.61.0601152216220.9875@yvahk01.tjqt.qr>
From: Peter Osterlund <petero2@telia.com>
Date: 15 Jan 2006 22:34:59 +0100
In-Reply-To: <Pine.LNX.4.61.0601152216220.9875@yvahk01.tjqt.qr>
Message-ID: <m37j91yy2k.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

> >> 	pktsetup 0 /dev/hdc
> >> 	mount /dev/pktcdvd/0 /mnt/tmp
> >> 	umount /mnt/tmp
> 
> A question BTW; I do not seem to need pktcdvd for DVD+RWs,
> I can just mount them after mkfs'ing /dev/hdc - what's up with that?

Basically, if you don't use the packet writing driver, the DVD drive
firmware will do similar work on its own, because the hardware can
only write 32KB blocks. The firmware is often slower than the pktcdvd
driver, because the firmware doesn't have as much memory available as
the kernel to reorder I/O operations for improved throughput.

See also Documentation/cdrom/packet-writing.txt:

Packet writing for DVD+RW media
-------------------------------

According to the DVD+RW specification, a drive supporting DVD+RW discs
shall implement "true random writes with 2KB granularity", which means
that it should be possible to put any filesystem with a block size >=
2KB on such a disc. For example, it should be possible to do:

	# dvd+rw-format /dev/hdc   (only needed if the disc has never
	                            been formatted)
	# mkudffs /dev/hdc
	# mount /dev/hdc /cdrom -t udf -o rw,noatime

However, some drives don't follow the specification and expect the
host to perform aligned writes at 32KB boundaries. Other drives do
follow the specification, but suffer bad performance problems if the
writes are not 32KB aligned.

Both problems can be solved by using the pktcdvd driver, which always
generates aligned writes.

	# dvd+rw-format /dev/hdc
	# pktsetup dev_name /dev/hdc
	# mkudffs /dev/pktcdvd/dev_name
	# mount /dev/pktcdvd/dev_name /cdrom -t udf -o rw,noatime

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
