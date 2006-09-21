Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWIUSix@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWIUSix (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 14:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWIUSix
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 14:38:53 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:35462 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751444AbWIUSiv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 14:38:51 -0400
Message-ID: <4512DC15.8050101@oracle.com>
Date: Thu, 21 Sep 2006 11:38:13 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Veerendra Chandrappa <veerendra.chandrappa@in.ibm.com>
CC: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, suparna@in.ibm.com, xfs@oss.sgi.com
Subject: Re: [RFC 0/5] dio: clean up completion phase of direct_io_worker()
References: <OFBE544A3C.7C1B2C64-ON652571F0.003C21B6-652571F0.003C2DF3@in.ibm.com>
In-Reply-To: <OFBE544A3C.7C1B2C64-ON652571F0.003C21B6-652571F0.003C2DF3@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> on EXT2, EXT3 and XFS filesystems. For the EXT2 and EXT3 filesystems the
> tests went okay. But I got stack trace on XFS filesystem and the machine
> went down.

Fantastic, thanks for running these tests.

> kernel BUG at kernel/workqueue.c:113!

> EIP is at queue_work+0x86/0x90

We were able to set the pending bit but then found that list_empty()
failed on the work queue's entry list_head.  Let's call this memory
corruption of some kind.

>  [<c02b43a2>] xfs_finish_ioend+0x20/0x22
>  [<c02b5e2f>] xfs_end_io_direct+0x3c/0x68
>  [<c018e77a>] dio_complete+0xe3/0xfe
>  [<c018e82d>] dio_bio_end_aio+0x98/0xb1
>  [<c016e889>] bio_endio+0x4e/0x78
>  [<c02cdc89>] __end_that_request_first+0xcd/0x416

It was completing an AIO request.

        ret = blockdev_direct_IO_own_locking(rw, iocb, inode,
                iomap.iomap_target->bt_bdev,
                iov, offset, nr_segs,
                xfs_get_blocks_direct,
                xfs_end_io_direct);

        if (unlikely(ret <= 0 && iocb->private))
                xfs_destroy_ioend(iocb->private);

It looks like xfs_vm_direct_io() is destroying the ioend in the case
where direct IO is returning -EIOCBQUEUED.  Later the AIO will complete
and try to call queue_work on the freed ioend.  This wasn't a problem
before when blkdev_direct_IO_*() would just return the number of bytes
in the op that was in flight.  That test should be

        if (unlikely(ret != -EIOCBQUEUED && iocb->private))

I'll update the patch set and send it out.

This makes me worry that XFS might have other paths that need to know
about the magical -EIOCBQUEUED case which actually means that a AIO DIO
is in flight.

Could I coerce some XFS guys into investigating if we might have other
problems with trying to bubble -EIOCBQUEUED up from
blockdev_direct_IO_own_locking() up through to xfs_file_aio_write()'s
caller before calling xfs_end_io_direct()?

- z
