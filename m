Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030383AbWGJONT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030383AbWGJONT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 10:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbWGJONS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 10:13:18 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:21436 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1030383AbWGJONS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 10:13:18 -0400
Date: Mon, 10 Jul 2006 16:13:15 +0200
From: Jan Kasprzak <kas@fi.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: 3ware disk latency?
Message-ID: <20060710141315.GA5753@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Envelope-From: kas@fi.muni.cz
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

I have upgraded my machine from 3ware 7508 with 8x 250GB ATA drives
to 3ware 9550SX-8LP with 8x 500GB SATA-II drives, and I have found that
while the overall throughput of the disks is higher than before,
the latency - measured as the number of messages per time unit Qmail can
deliver - is far worse than before[1]. I have tried to use deadline
and cfq schedulers, but it made no visible speedup.

	I have found the following two years old mail by Jens Axboe:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0409.0/1330.html
- the problem at that time was that the device had its internal
command queue deeper than the nr_requests of the block device layer,
so the I/O scheduler couldn't do anything.  I was surprised
that the situation is still the same: I have

/sys/block/sd[a-h]/queue/nr_requests == 128, and
/sys/devices/pci0000:00/0000:00:0b.0/0000:01:03.0/host0/target*/*/queue_depth == 254

I have verified that even on older 3ware drivers (7508) the situation
is the same. On the newer hardware it is probably more visible, because
the controller actually has bigger on-board cache (128MB vs. 32MB, I think).

	I have tried to lower the /sys/devices/.../queue_depth to 4
and disable the NCQ, and the latency got a bit better. But it is still
nowhere near to where it was on the older HW.

	Does anybody experience the similar latency problems with
3ware 95xx controllers? Thanks,

-Yenya

[1] the old configuration peaked at ~2k-4k messages per 5 minutes,
	with 1k-2k messages/5min being pretty normal, while the new one
	has maximum throughput of 1k messages per 5 minutes, but the normal
	speed is much lower - some low hundreds messages per 5 minutes.
	The new system runs about the same load as the previous one,
	and the layout of disks is also the same (just the newer drives
	are bigger, of course).


-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/    Journal: http://www.fi.muni.cz/~kas/blog/ |
> I will never go to meetings again because I think  face to face meetings <
> are the biggest waste of time you can ever have.        --Linus Torvalds <
