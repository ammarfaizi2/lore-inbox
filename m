Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbTJZIse (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 03:48:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbTJZIse
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 03:48:34 -0500
Received: from [217.73.128.98] ([217.73.128.98]:51328 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S262932AbTJZIsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 03:48:32 -0500
Date: Sun, 26 Oct 2003 10:47:52 +0200
Message-Id: <200310260847.h9Q8lqJF018523@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: ReiserFS, two oddities
To: ndiamond@wta.att.ne.jp, linux-kernel@vger.kernel.org
References: <334201c39b94$286e7ae0$24ee4ca5@DIAMONDLX60>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

"Norman Diamond" <ndiamond@wta.att.ne.jp> wrote:

ND> The sector is readable if I ignore partitions:
ND>   # dd if=/dev/hda of=/dev/null bs=512 skip=29431074 count=1
ND>   1+0 records in
ND>   1+0 records out
ND> but not if I address it from inside the partition:
ND>   # dd if=/dev/hda8 of=/dev/null bs=512 skip=11261496 count=1
ND>   dd: reading `/dev/hda8': Input/output error
ND>   0+0 records in
ND>   0+0 records out
ND> LBA sector number 29431074 is inside the partition.  18169578 + 11261496 =
ND> 29431074, verified several times.  11261496 / 2 = 5630748, verified only
ND> twice, but it is within the quantity of 1K Linux blocks that the partition
ND> has.  Why is the sector unreadable when read from inside the partition?

This is known problem that nobody wants to deal with.
When you mount some fs, it sets device's blocksize to fs' blocksize
(e.g.) 4k for reiserfs, if the size of the device was not multiple of
4k, everything that forms last partial block gets sort of stripped and you
cannot access it anymore. Even if you decrease blocksize of the block device
later, you still won't get that missing data back until reboot.
This is even more unfortunate on architectures with big pagesize where
block devices are often assigned blocksizes equal to PAGE_SIZE.
This behavior was observed on linux v2.4, not sure about 2.6

ND> The second strange observation is that reiserfsck with no options, applied
ND> to a non-mounted partition, seems to write to the partition while replaying
ND> journaled transactions.  When repeated, the number of replayed transactions

Yes, replaying journal obviously requires writes ;)

ND> is 0, so I think the first execution wrote to the partition.  (If the
ND> partition had been mounted then of course ordinary operations would get get
ND> journaled transactions merged into the file system, but I guarantee that
ND> this observation occured on a non-mounted partition.)  reiserfsck 3.6.4
ND> starts by saying that it will read-only check consistency, but the fact
ND> seems to be read-mostly.

Well, checking is checking and journal replaying is a different matter,
that is even done before starting checks.

Bye,
    Oleg
