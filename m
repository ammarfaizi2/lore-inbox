Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317627AbSGXWk0>; Wed, 24 Jul 2002 18:40:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317616AbSGXWk0>; Wed, 24 Jul 2002 18:40:26 -0400
Received: from hera.cwi.nl ([192.16.191.8]:43421 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S317627AbSGXWkY>;
	Wed, 24 Jul 2002 18:40:24 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 25 Jul 2002 00:42:47 +0200 (MEST)
Message-Id: <UTC200207242242.g6OMglA23855.aeb@smtp.cwi.nl>
To: torvalds@transmeta.com, viro@math.psu.edu
Subject: 2.5.28 and partitions
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just saw some new partition code in 2.5.28. Good!
I like almost all I see, except for one thing:

When I did precisely these same things, long ago, I used

struct blkpg_partition {
        long long start;                /* starting offset in bytes */
        long long length;               /* length in bytes */
        int pno;                        /* partition number */
        char devname[BLKPG_DEVNAMELTH]; /* partition name, like sda5 or c0d1p2,
                                           to be used in kernel messages */
        char volname[BLKPG_VOLNAMELTH]; /* volume label */
};

still visible in blkpg.h.

Now I read in 2.5.28:

+struct parsed_partitions {
+       char name[40];
+       struct {
+               unsigned long from;
+               unsigned long size;
+               int flags;
+       } parts[MAX_PART];
+       int next;
+       int limit;
+};

and I object to the long instead of u64 or so.

With 2^32 sectors one can handle up to 2^41 bytes, 2 TiB.
Already today people want RAIDs that are larger, and
few years from now we'll have single disks that are larger.

The fields from and size really need more bits than 32.
And when they become u64, it is a good idea to measure bytes
instead of 512-byte sectors.

(In the design where all partition reading code is removed
from the kernel, and user space tells the kernel what the
partitions on its disks are, it is also natural that user
space is able to provide names for the partitions.
Both names for the kernel to use in its messages, and names
to be used in mount-by-label. Of course I would like to
remove all mount-by-label code from mount(8).)

Andries


