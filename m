Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265012AbSJPOg0>; Wed, 16 Oct 2002 10:36:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265009AbSJPOgZ>; Wed, 16 Oct 2002 10:36:25 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:62903 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S265008AbSJPOgR>; Wed, 16 Oct 2002 10:36:17 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [RFC] iovec in ->aio_read/->aio_write
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Christoph Hellwig <hch@sgi.com>,
       akpm@digeo.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-aio@kvack.org,
       janetinc@beaverton.ibm.com
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF6AD518E4.6C21EEA9-ON87256C54.004CFCB5@boulder.ibm.com>
From: "Helen Pang" <hpang@us.ibm.com>
Date: Wed, 16 Oct 2002 09:40:34 -0500
X-MIMETrack: Serialize by Router on D03NM691/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/16/2002 08:40:37 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Shailabh Nagar wrote:

> It would be interesting to see the performance boost when <iov length>
events
> are retrieved at once, using the min_nr parameter of io_getevents

My experience is that specified minimum number of events (min_nr) of
io_getevents is not quite working yet in kernel 2.4.19.
I haven't  started to exercise this in 2.5.42, but if it is working,
logically  it will help the performance indeed.

-Helen






Shailabh Nagar <nagar@watson.ibm.com>@kvack.org on 10/16/2002 08:41:03 AM

Sent by:    owner-linux-aio@kvack.org


To:    janetinc@beaverton.ibm.com
cc:    Benjamin LaHaise <bcrl@redhat.com>, Christoph Hellwig <hch@sgi.com>,
       akpm@digeo.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject:    Re: [RFC] iovec in ->aio_read/->aio_write



Janet Morgan wrote:

> Here's a patch for aio readv/writev support.  Basically it adds:
>
> - two new opcodes (IOCB_CMD_PREADV and IOCB_CMD_PWRITEV)
> - a field to the iocb for the user vector
> - aio_readv/writev methods to the file_operations structure

I presume f_op->aio_readv could point to __generic_file_aio_read for most
filesystems.

Would f_op->aio_writev need a new wrapper function for 2.5.42 ?
f_op->aio_write eventually calls generic_file_write which uses a different
inode
from generic_file_writev. So f_op->aio_writev might need to point to a
function
like generic_file_writev but using the same inode as generic_file_write.


> - routine aio.c/io_readv_writev, which borrows heavily from
do_readv_writev.
>
> I tested this using the aio dio patch that Badari submitted a while back.
> I compared:
>                 readv/writev io_submit for a vector of N iovecs
>                 vs read/write io_submit for N iocbs.
>
> My performance data is only preliminary at this point, but aio
readv/writev
> appears to outperform aio read/write -- twice as fast in some cases.  The
> results generally make sense to me:  while there is only one io_submit in
both
> cases, aio readv/writev shortens codepath (one instead of N calls to the
> underlying filesystem routine) and should normally result in fewer

Twice as fast looks good !

> bios/callbacks (at least for direct-io).  As importantly, aio
readv/writev
> in my testing also reduces the number of (system) calls to io_getevents.

It would be interesting to see the performance boost when <iov length>
events
are retrieved at once, using the min_nr parameter of io_getevents.


--Shailabh

--
To unsubscribe, send a message with 'unsubscribe linux-aio' in
the body to majordomo@kvack.org.  For more info on Linux AIO,
see: http://www.kvack.org/aio/




