Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268081AbUHFEzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268081AbUHFEzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 00:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268084AbUHFEzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 00:55:22 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:53404 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S268081AbUHFEzL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 00:55:11 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: <linux-kernel@vger.kernel.org>
Subject: EXT intent logging
Date: Thu, 5 Aug 2004 21:55:28 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcR7cXUCwtwUW/XVQGKIlrrS2Kd7NQ==
Message-Id: <S268081AbUHFEzL/20040806045511Z+197@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I recently moved from a Sun/Solaris environment to a mostly linux
environment .

A large NFS server went down recently and as it rebooted, fsck ran for a
while before 
the data volumes could be mounted. I noticed the filesystem was ext3 and
asked, is 
journaling disabled? Why on earth is fsck running at all? The admin assured
me this
 is quite normal for ext3 and after a few minutes, the system was brought
back online.

I looked at the configuration and it turns out the system was mounted
DATA=ORDERED. 
That name ordered sounded to me like it should do the kind of intent logging
that I am
 accustomed to on UFS and VXFS. I was very surprised to read that ext3
updates the 
standard data/metadata blocks prior to updating the journal. While im sure
this achieves 
what the snippet from the ext3 faq says below: "this mode guarantees that
after a crash, 
files will never contain stale data blocks from old files", I don't see how
fsck time can be 
reduced entirely with this journal method.

To eliminate fsck on large filesystems, wouldn't you have to update the
journal first, then 
update the data blocks? This way in the event of a crash, the last entries
in the log would 
represent the last I/O operations that were "intended" and those blocks
could be inspected
 for consistency.

This of course is my non-kernel hacker understanding of how this works, but
I can say 
one thing. With UFS mounted with -o logging, I can start a ton of reads and
writes and
 just kill the power on a system and not expect to see any delay when the
system comes 
back up.

Of course, UFS logging does not log data, only metadata (as data=ordered or
 data=writeback options do).

Also, vxfs, which behaves more like data=journal I believe, also spends very
little
 time replaying the journal after a nasty crash.

We wanted the journal to be updated first, but we couldn't understand why we
had to opt for data 
journaling to accomplish this. The unfortunate thing is, we have seen
corruption as a result 
of the data=journal option.

Could someone explain why there isn't an option in ext3 to only log
metadata, but completely 
avoid fsck by updating the log before the data blocks?

And im sure I don't need to ask anyone to correct me if I am misguided in my
thinking. I have found 
on lkml that kind of guidance usually comes for free m

--Buddy


---------------------
    "mount -o data=ordered"
        Only journals metadata changes, but data updates are flushed to
        disk before any transactions commit. Data writes are not atomic
        but this mode still guarantees that after a crash, files will
        never contain stale data blocks from old files.


