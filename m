Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266216AbUHGEuT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266216AbUHGEuT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 00:50:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266224AbUHGEuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 00:50:19 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:24293 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266216AbUHGEuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 00:50:06 -0400
From: "Buddy Lumpkin" <b.lumpkin@comcast.net>
To: "'Theodore Ts'o'" <tytso@mit.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: EXT intent logging
Date: Fri, 6 Aug 2004 21:50:42 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <20040806195615.GA14163@thunk.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Thread-Index: AcR78rrUX/UD15I8SvG2mZPQHucuawARyQXg
Message-Id: <S266216AbUHGEuG/20040807045006Z+106@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Ted,

This clears up a lot of bad assumptions I made while reading vague
descriptions about the different ext3 journal options in miscellaneous
places.

--Buddy

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Theodore Ts'o
Sent: Friday, August 06, 2004 12:56 PM
To: Buddy Lumpkin
Cc: linux-kernel@vger.kernel.org
Subject: Re: EXT intent logging

On Thu, Aug 05, 2004 at 09:55:28PM -0700, Buddy Lumpkin wrote:
> A large NFS server went down recently and as it rebooted, fsck ran
> for a while before the data volumes could be mounted. I noticed the
> filesystem was ext3 and asked, is journaling disabled? Why on earth
> is fsck running at all? The admin assured me this is quite normal
> for ext3 and after a few minutes, the system was brought back
> online.

Fsck replays the journal for ext3 filesystems that were not cleanly
unmounted.  That is, the metadata (and possibly data) blocks in the
journal are written to the correct location on disk in order to make
the filesystem consistent.

> I looked at the configuration and it turns out the system was
> mounted DATA=ORDERED.  That name ordered sounded to me like it
> should do the kind of intent logging that I am accustomed to on UFS
> and VXFS. I was very surprised to read that ext3 updates the
> standard data/metadata blocks prior to updating the journal. 

Incorrect.  Only data blocks are forced out to disk before metadata
blocks (which are written to the journal first) changes are committed.
The changes to the metadata blocks are not written to disk (outside of
the journal) until after the transaction is committed.

> To eliminate fsck on large filesystems, wouldn't you have to update
> the journal first, then update the data blocks? This way in the
> event of a crash, the last entries in the log would represent the
> last I/O operations that were "intended" and those blocks could be
> inspected for consistency.

See above.  The metadata changes are written out to the journal first,
but we want to make sure that before those changes are committed, that
the data blocks pointed to by the metadata blocks are valid.  If you
mount -o data=writeback, then data blocks constraint is not
enforced.  This still eliminates the need for a full fsck, but even
though the filesystem is consistent after the journal is replayed, the
metadata blocks may be pointing at unwritten data blocks which only
contain garbage.

> Could someone explain why there isn't an option in ext3 to only log
> metadata, but completely avoid fsck by updating the log before the
> data blocks?

"mount -o data=writeback" only logs metadata.  This seems to be what
you are requesting.

"mount -o data=journal" logs metadata blocks and data blocks into
journal first, and then after the transaction commits, the metadata
and data blocks are written to their final location on disk.  The
problem with this is that all your write bandwidth is cut in half
since all block writes get written twice to disk --- once to the
journal, and once to the final location on disk.

"mount -o data=ordered" simply defers the transaction commit until the
data blocks are written to their final location on disk.  If the data
writes do not make it onto the disk, before the system crashes, the
transaction never commits and the metadata changes won't get replayed
on filesystem recovery.

In all cases, however, the need for a full fsck is not needed.  The
reason why it is useful to have e2fsck do the journal replay, as
opposed to letting the kernel do it when you try to mount the
filesystem, is that if you have multiple disk drives, replaying
journal in userspace allows multiple filesystems to be recovered in
parallel, instead of one filesystem at a time.  Linux's fsck is
intellignent and will spawn off multiple copies of e2fsck, one for
each filesystem, so long as they are on separate disk spindles.
(Running two cpoies of e2fsck on different partitions on the same disk
drive is pointless, since the two e2fsck processes simply thrashes the
disk heads and get in the way of each other.)

Hope this helps,

						- Ted
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

