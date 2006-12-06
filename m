Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936962AbWLFSHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936962AbWLFSHP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936971AbWLFSHO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:07:14 -0500
Received: from mail4.kite.se ([212.214.165.225]:44533 "EHLO mail4.kite.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936962AbWLFSHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:07:12 -0500
Message-ID: <457706CB.20802@kite.se>
Date: Wed, 06 Dec 2006 19:07:07 +0100
From: "Magnus Naeslund(k)" <mag@kite.se>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6 tmpfs/swap performance oddity
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have this Ubuntu Edgy (HP Proliant DL380 intel x86-64 w/ 4 cores), kernel: 2.6.17-10-server) system with a raid controller (p600 + bbu, cciss) and 8gb memory. The raid disks are setup as one raid1+0 logical device, the swap and filesystem are partitions on this device.
I've created a ext3 file system with standard parameters from the ubuntu installer.

When doing a simple test with this ext3 fs I can write (dd bs=1M if=/dev/zero of=file (20gb file)) about 180-200 mb/s. If I read the same file I get about 280mb/s throughput.

We have a 60gb tmpfs that we're going to use for volatile but large data-sets.
We were thinking that using tmpfs this way it would be faster to just let it swap out stuff that aren't frequently used, and that the current working set is swaps in automagically.

But tmpfs seems to get really slow when it has to swap out stuff from tmp to a 80 gb swap partition, much slower than just writing a file to the ext3 fs. Maybe this is a known thing, and easily tuned, but I've not seen any solutions when googling around.

If i dd a file that fits in memory to the tmpfs mount I get around 1.5gb/s, ~8 times faster than the RAID card write performance. This isn't bad but not anywhere near the "cached" speed that I get from hdparm -T: ~6720mb/s, I don't know if they're even related, also I get two of these "HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for device" when issuing the hdparm command (since it's a raid disk?).

If the file size is > the physical memory (20gb, same test) I get a radically worsened total performance, on the write test it gets a throughput of 124mb/s. One would hope that it was faster than the ext3 test. One could guess that after the first 8gb it no longer fits into memory and the throughput gets many times slower.
And all hell breaks loose when I try to dd that tmpfs file to /dev/null (bs=1M), it can only read at about ~20mb/s.

What is happening here? Check out the vmstat 1:
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa
 1  1 14757524  45036    924 6439068 27168 25160 27168 25160 2449 1725  0  2 75 23
 0  1 14739836  47484    924 6457600 18976 25004 18976 25004 1769 1207  0  1 75 24

It seems to do IO madly to be able to page in the pages of the file.
One would hope to have faster or equal performance compared to the ext3 test.

Somehow I think I'm missing something here, maybe we're not supposed to use tmpfs in this way at all?
What more information can I supply to narrow down the problem?
Is there any secret knobs that I can use to tune swap performance?

Regards,
Magnus



