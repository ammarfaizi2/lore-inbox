Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262910AbTJZHjR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 02:39:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbTJZHjR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 02:39:17 -0500
Received: from smtp3.att.ne.jp ([165.76.15.139]:34995 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S262910AbTJZHjP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 02:39:15 -0500
Message-ID: <334201c39b94$286e7ae0$24ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Hans Reiser" <reiser@namesys.com>, <linux-kernel@vger.kernel.org>
Subject: ReiserFS, two oddities
Date: Sun, 26 Oct 2003 16:37:26 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is tangential to my observations about bad blocks (which the disk's
firmware refused to reallocate during reads, writes, and S.M.A.R.T. long
self-tests).  I have had two odd observations which seem related to ReiserFS
on perfectly good blocks.

Here is partial output from fdisk's p command, copied by hand:
  /dev/hda8   18169578  29431079   5630751   83  Linux
The first two numbers are the partition's starting and ending LBA sector
numbers.  fdisk's u command kindly toggles these between cylinder numbers
and LBA sector numbers.  The third number is the quantity of 1K Linux blocks
in the file system, and does not get toggled by fdisk's u command.

The sector is readable if I ignore partitions:
  # dd if=/dev/hda of=/dev/null bs=512 skip=29431074 count=1
  1+0 records in
  1+0 records out
but not if I address it from inside the partition:
  # dd if=/dev/hda8 of=/dev/null bs=512 skip=11261496 count=1
  dd: reading `/dev/hda8': Input/output error
  0+0 records in
  0+0 records out

LBA sector number 29431074 is inside the partition.  18169578 + 11261496 =
29431074, verified several times.  11261496 / 2 = 5630748, verified only
twice, but it is within the quantity of 1K Linux blocks that the partition
has.  Why is the sector unreadable when read from inside the partition?

Let's try a minimal, shouldn't-be-helpful sanity test.
  # dd if=/dev/hda8 of=/dev/null bs=512 skip=11261495 count=1
  1+0 records in
  1+0 records out
Yup, it succeeded, and doesn't help explain the problem 1 sector later.

The second strange observation is that reiserfsck with no options, applied
to a non-mounted partition, seems to write to the partition while replaying
journaled transactions.  When repeated, the number of replayed transactions
is 0, so I think the first execution wrote to the partition.  (If the
partition had been mounted then of course ordinary operations would get get
journaled transactions merged into the file system, but I guarantee that
this observation occured on a non-mounted partition.)  reiserfsck 3.6.4
starts by saying that it will read-only check consistency, but the fact
seems to be read-mostly.

