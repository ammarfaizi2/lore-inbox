Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266925AbRGMDAL>; Thu, 12 Jul 2001 23:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266926AbRGMDAB>; Thu, 12 Jul 2001 23:00:01 -0400
Received: from horus.its.uow.edu.au ([130.130.68.25]:19923 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S266925AbRGMC7y>; Thu, 12 Jul 2001 22:59:54 -0400
Message-ID: <3B4E6468.414EF6B5@uow.edu.au>
Date: Fri, 13 Jul 2001 13:00:56 +1000
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lance Larsh <llarsh@oracle.com>
CC: Brian Strand <bstrand@switchmanagement.com>,
        Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2x Oracle slowdown from 2.2.16 to 2.4.4
In-Reply-To: <3B4CE556.9000608@switchmanagement.com> <Pine.LNX.4.31.0107120749520.21040-100000@llarsh-pc2.us.oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lance Larsh wrote:
> 
> And while we're talking about comparing configurations, I'll mention that
> I'm currently trying to compare raw and ext2 (no lvm in either case).

It would be interesting to see some numbers for ext3 with full
data journalling.

Some preliminary testing by Neil Brown shows that ext3 is 1.5x faster
than ext2 when used with knfsd, mounted synchronously.  (This uses
O_SYNC internally).

The reason is that all the data and metadata are written to a
contiguous area of the disk: no seeks apart from the seek to the
journal are needed.  Once the metadata and data are committed to
the journal, the O_SYNC (or fsync()) caller is allowed to continue.
Checkpointing of the data and metadata into the main fileystem is
allowed to proceed via normal writeback.

Make sure that you're using a *big* journal though.   Use the
`-J size=400' option with tune2fs or mke2fs.

-
