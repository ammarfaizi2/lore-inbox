Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314258AbSDRQRq>; Thu, 18 Apr 2002 12:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314390AbSDRQRp>; Thu, 18 Apr 2002 12:17:45 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4366 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S314258AbSDRQRo>;
	Thu, 18 Apr 2002 12:17:44 -0400
Message-ID: <3CBEF18D.F18BAA76@zip.com.au>
Date: Thu, 18 Apr 2002 09:17:17 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mark Peloquin <peloquin@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bio pool & scsi scatter gather pool usage
In-Reply-To: <OFCEC9D152.09A1A6B2-ON85256B9F.0047D732@pok.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Peloquin wrote:
> 
> I'm experiencing a problem using the bio pool created in
> 2.5.7 and I'm not quite able to put my finger on the cause
> and hoped somone might have the knowledge and insight to
> understand this problem.
> 
> In EVMS, we are adding code to deal with BIO splitting, to
> enable our feature modules, such as DriveLinking, LVM, & MD
> Linear, etc to break large BIOs up on chunk size or lower
> level device boundaries.

Could I suggest that this code not be part of EVMS, but that
you implement it as a library within the core kernel?  Lots of
stuff is going to need BIO splitting - software RAID, ataraid,
XFS, etc.  May as well talk with Jens, Martin Petersen, Arjan,
Neil Brown.  Do it once, do it right...

> ...
> 
> The allocation and initialization of the resulting split
> BIOs seems to be correct and works in light loads. However,
> under heavier loads, the assert in scsi_merge.c:82
> {BUG_ON(!sgpnt)} fires, due to the fact that scatter gather
> pool for MAX_PHYS_SEGMENTS (128) is empty. This is occurring
> at interrupt time when __scsi_end_request is attempting to
> queue the next request.

You're not the only one...  That is placeholder code which
Jens plans to complete at a later time.
 
> Its not perfectly clear to me how switching from a private
> BIO pool to the 2.5 BIO pool should affect the usage of the
> scsi driver's scatter gather pools.
> 
> Rather than simply increasing the size of scatter gather
> pools I hope to understand how these changes resulted in
> this behaviour so the proper solution can be determined.
> 
> Another data point: I have observed that the BIO pool does
> get depleted below the 50% point of its mininum value, and
> in such cases mempool_alloc (the internal worker for
> bio_alloc) tries to free up more memory (I assume to grow
> the pool) by waking bdflush. As a result, even more
> pressure is put on the BIO pool when the dirty buffers
> are being flushed.

Makes sense.

> ...
> 
> Have I caused a problem by unrealistically increasing
> pressure on the BIO pool by a factor of 8? Or have I
> discovered a problem that can occur on very heavy loads?
> What are your thoughts on a recommended solution?

Hopefully, once scsi_merge is able to handle the allocation
failure correctly, we won't have a problem any more.

As a temp thing I guess you could increase the size of that
mempool.

-
