Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbSJPNov>; Wed, 16 Oct 2002 09:44:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264922AbSJPNov>; Wed, 16 Oct 2002 09:44:51 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:58080 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S262859AbSJPNot>; Wed, 16 Oct 2002 09:44:49 -0400
Message-ID: <3DAD6C6F.2080908@watson.ibm.com>
Date: Wed, 16 Oct 2002 09:41:03 -0400
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Janet Morgan <janetmor@us.ibm.com>
Cc: Benjamin LaHaise <bcrl@redhat.com>, Christoph Hellwig <hch@sgi.com>,
       akpm@digeo.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: [RFC] iovec in ->aio_read/->aio_write
References: <20021015153427.A16156@redhat.com> <200210160651.g9G6pMm17385@eng4.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Janet Morgan wrote:

> Here's a patch for aio readv/writev support.  Basically it adds:
> 
> - two new opcodes (IOCB_CMD_PREADV and IOCB_CMD_PWRITEV)
> - a field to the iocb for the user vector
> - aio_readv/writev methods to the file_operations structure

I presume f_op->aio_readv could point to __generic_file_aio_read for most
filesystems.

Would f_op->aio_writev need a new wrapper function for 2.5.42 ?
f_op->aio_write eventually calls generic_file_write which uses a different inode
from generic_file_writev. So f_op->aio_writev might need to point to a function
like generic_file_writev but using the same inode as generic_file_write.


> - routine aio.c/io_readv_writev, which borrows heavily from do_readv_writev. 
> 
> I tested this using the aio dio patch that Badari submitted a while back. 
> I compared:
>                 readv/writev io_submit for a vector of N iovecs 
>                 vs read/write io_submit for N iocbs.
> 
> My performance data is only preliminary at this point, but aio readv/writev 
> appears to outperform aio read/write -- twice as fast in some cases.  The 
> results generally make sense to me:  while there is only one io_submit in both 
> cases, aio readv/writev shortens codepath (one instead of N calls to the 
> underlying filesystem routine) and should normally result in fewer 

Twice as fast looks good !

> bios/callbacks (at least for direct-io).  As importantly, aio readv/writev 
> in my testing also reduces the number of (system) calls to io_getevents.

It would be interesting to see the performance boost when <iov length> events
are retrieved at once, using the min_nr parameter of io_getevents.


--Shailabh

