Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262995AbVD2VNu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262995AbVD2VNu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:13:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262992AbVD2VNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:13:14 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60550 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S262982AbVD2VMZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:12:25 -0400
Subject: Re: [Ext2-devel] [RFC] Adding multiple block allocation
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Andrew Morton <akpm@osdl.org>, pbadari@us.ibm.com
Cc: suparna@in.ibm.com, sct@redhat.com, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
In-Reply-To: <20050429135705.3f4831bd.akpm@osdl.org>
References: <1113220089.2164.52.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113244710.4413.38.camel@localhost.localdomain>
	 <1113249435.2164.198.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113288087.4319.49.camel@localhost.localdomain>
	 <1113304715.2404.39.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1113348434.4125.54.camel@dyn318043bld.beaverton.ibm.com>
	 <1113388142.3019.12.camel@sisko.sctweedie.blueyonder.co.uk>
	 <1114207837.7339.50.camel@localhost.localdomain>
	 <1114659912.16933.5.camel@mindpipe>
	 <1114715665.18996.29.camel@localhost.localdomain>
	 <20050429135211.GA4539@in.ibm.com>
	 <1114794608.10473.18.camel@localhost.localdomain>
	 <1114803764.10473.46.camel@localhost.localdomain>
	 <20050429135705.3f4831bd.akpm@osdl.org>
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 29 Apr 2005 14:12:19 -0700
Message-Id: <1114809139.10473.70.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-29 at 13:57 -0700, Andrew Morton wrote:
> Mingming Cao <cmm@us.ibm.com> wrote:
> >
> > If we do direct write(block allocation) to a hole, I found that the
> >  "create" flag passed to ext3_direct_io_get_blocks() is 0 if we are
> >  trying to _write_ to a file hole. Is this expected? 
> 
> Nope.  The code in get_more_blocks() is pretty explicit.
> 
> > But if it try to allocating blocks in the hole (with direct IO), blocks
> > are allocated one by one. I am looking at it right now.
> > 
> 
> Please see the comment over get_more_blocks().
> 

I went to look at get_more_blocks, the create flag is cleared if the
file offset is less than the i_size. (see code below). 

static int get_more_blocks(struct dio *dio)
{
	..........
	.........
             create = dio->rw == WRITE;
             if (dio->lock_type == DIO_LOCKING) {
                  if (dio->block_in_file < (i_size_read(dio->inode) >>
                                                       dio->blkbits))
                         create = 0;
             } else if (dio->lock_type == DIO_NO_LOCKING) {
                    create = 0;

	     ret = (*dio->get_blocks)(dio->inode, fs_startblk, fs_count,
                                                map_bh, create);

}

When it is trying to direct writing to a hole, the create flag is
cleared so that the underlying filesystem get_blocks() function will
only do a block look up(look up will be failed and no block allocation).

do_direct_IO -> get_more_blocks -> ext3_direct_io_get_blocks. In
get_more_blocks(),  do_direct_IO() handles the write to hole situation
by simply return an error of ENOTBLK. In direct_io_worker() it detects
this error then just simply return the size of written byte to 0. The
real write is handled by the buffered I/O. In
__generic_file_aio_write_nolock(), generic_file_buffered_write() will be
called if written by generic_file_direct_write() is 0.

Could you confirm my observation above?  Hope I understand this right:
right now direct io write to a hole is actually handled by buffered IO.
If so, there must be some valid reason that I could not see now.


Thanks,
Mingming

