Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261615AbTAPGuj>; Thu, 16 Jan 2003 01:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261799AbTAPGuj>; Thu, 16 Jan 2003 01:50:39 -0500
Received: from [194.165.160.81] ([194.165.160.81]:24591 "EHLO sulaco.com")
	by vger.kernel.org with ESMTP id <S261615AbTAPGui>;
	Thu, 16 Jan 2003 01:50:38 -0500
Message-ID: <3E265855.4020706@sulaco.com>
Date: Thu, 16 Jan 2003 06:59:33 +0000
From: Brian Kelly <bkelly@sulaco.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: How to setup a buffer_head in a driver
References: <200301142235.RAA23806@temetra.com> <200301141514.35825.akpm@digeo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I wrote:
 > I'm writing a device driver that among other things needs to write data,
 > manufactured by the driver itself, to a block device.
 >
 > I have this data in block sized kmalloc()'d chunks. So what I'm doing is
 > allocating a struct buffer_head, initialising it, fill out it's various
 > fields and send it to generic_make_request().

Andrew Morton wrote:
 >It's probably better to use submit_bh().  Set the BH_Lock and BH_Mapped bits,
 >also set up b_end_io.  Then do a wait_on_buffer(), wait for the IO to
 >complete.  There's some similar code in
 >fs/jbd/journal.c:journal_write_metadata_buffer().

Thanks, that's exactly the sort of thing I was looking for.

 >However, what you're doing is an odd thing.  If there is already pagecache
 >against that block device then the kernel doesn't know that you've changed
 >the bytes on-disk and will cheerfully proceed to use (and write out) the
 >cached data.  You'll lose your modifications..
 >
 >It would be better to use sb_getblk() or bread(), to lock the returned
 >buffer_head, then copy your data into it and to then write it back with
 >submit_bh() or ll_rw_block().  Or just leave it dirty and let the kernel
 >write it out in due course.

Fair enough, that seems like the right thing to do so I'll look into it.

Thanks,

Brian
-- 
bkelly@sulaco.com

