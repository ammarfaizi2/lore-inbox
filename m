Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314354AbSDRN6h>; Thu, 18 Apr 2002 09:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314357AbSDRN6g>; Thu, 18 Apr 2002 09:58:36 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:37324 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S314354AbSDRN6g>;
	Thu, 18 Apr 2002 09:58:36 -0400
Importance: Normal
Sensitivity: 
Subject: Bio pool & scsi scatter gather pool usage
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OFCEC9D152.09A1A6B2-ON85256B9F.0047D732@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Thu, 18 Apr 2002 08:58:41 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.9a |January 28, 2002) at
 04/18/2002 09:58:29 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm experiencing a problem using the bio pool created in
2.5.7 and I'm not quite able to put my finger on the cause
and hoped somone might have the knowledge and insight to
understand this problem.

In EVMS, we are adding code to deal with BIO splitting, to
enable our feature modules, such as DriveLinking, LVM, & MD
Linear, etc to break large BIOs up on chunk size or lower
level device boundaries.

In the first implementation of this, EVMS created it own
private pool of BIOs to use both for internally generated
synchronous IOs as well as for the source of BIOs used to
create the resulting split BIOs. In this implementation,
everything worked well, even under heavy loads.

However, after some thought, I concluded it was redundant
of EVMS to create its own pool of BIOs, when 2.5 had already
created a pool along with several support routines for
appropriately dealing with them.

So I made the changes to EVMS to use the 2.5 BIO pool. I
started testing a volume using linear concatination and BIO
splitting. In the test, I have an ext2 filesystem formatted
with a block size of 4096. The BIO split function was
tweaked to maximize the stress by splitting all BIOs into
512 byte pieces. So this test is generating 8 additional
BIOs for each one coming down for this volume.

The allocation and initialization of the resulting split
BIOs seems to be correct and works in light loads. However,
under heavier loads, the assert in scsi_merge.c:82
{BUG_ON(!sgpnt)} fires, due to the fact that scatter gather
pool for MAX_PHYS_SEGMENTS (128) is empty. This is occurring
at interrupt time when __scsi_end_request is attempting to
queue the next request.

Its not perfectly clear to me how switching from a private
BIO pool to the 2.5 BIO pool should affect the usage of the
scsi driver's scatter gather pools.

Rather than simply increasing the size of scatter gather
pools I hope to understand how these changes resulted in
this behaviour so the proper solution can be determined.

Another data point: I have observed that the BIO pool does
get depleted below the 50% point of its mininum value, and
in such cases mempool_alloc (the internal worker for
bio_alloc) tries to free up more memory (I assume to grow
the pool) by waking bdflush. As a result, even more
pressure is put on the BIO pool when the dirty buffers
are being flushed.

</speculation on>

BIO splitting does increase the pressure on the BIO pool.
mempool_alloc increases pressure on all IO pools when it
wakes bdflush. BIOs splitting alone (when from a private
pool) didn't create sufficient IO pressure to deplete the
currently sized pools in the IO path. Can the behaviour
of mempool_alloc, triggering bdflush, in addition to BIO
splitting adequately explain why the scsi scatter gather
pool would become depleted?

</speculation off>

Have I caused a problem by unrealistically increasing
pressure on the BIO pool by a factor of 8? Or have I
discovered a problem that can occur on very heavy loads?
What are your thoughts on a recommended solution?

Thanks.
Mark

