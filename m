Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262908AbVD2Tmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262908AbVD2Tmx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 15:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbVD2Tmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 15:42:53 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:8182 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262905AbVD2Tmr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 15:42:47 -0400
Subject: Re: [Ext2-devel] [RFC] Adding multiple block allocation
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: suparna@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1114794608.10473.18.camel@localhost.localdomain>
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
Content-Type: text/plain
Organization: IBM LTC
Date: Fri, 29 Apr 2005 12:42:44 -0700
Message-Id: <1114803764.10473.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-29 at 10:10 -0700, Mingming Cao wrote:
> But if it try to allocating blocks in the hole (with direct IO), blocks
> are allocated one by one. I am looking at it right now.
> 
Hi Andrew, Badari,

If we do direct write(block allocation) to a hole, I found that the
"create" flag passed to ext3_direct_io_get_blocks() is 0 if we are
trying to _write_ to a file hole. Is this expected? 

This is what happened on mainline 2.6.12-rc2(and with my patch). To simplify, here is the problem description on mainline:

If we do 30 blocks write to a new file at offset 800k, fine, create flag is all 1. 
Then if seek back to offset 400k, write another 30 blocks, create flag is 0

-bash-2.05b# mount -t ext3 /dev/ubdc /mnt/ext3
-bash-2.05b# cd /mnt/ext3
-bash-2.05b# touch a
-bash-2.05b# /root/filetst -o 819200 -b 122880 -c 1 -w -d -f a
Calling ext3_get_block_handle from ext3_direct_io_get_blocks: maxblocks = 30, iblock = 200, create = 1
Calling ext3_get_block_handle from ext3_direct_io_get_blocks: maxblocks = 29, iblock = 201, create = 1
Calling ext3_get_block_handle from ext3_direct_io_get_blocks: maxblocks = 28, iblock = 202, create = 1
Calling ext3_get_block_handle from ext3_direct_io_get_blocks: maxblocks = 27, iblock = 203, create = 1
Calling ext3_get_block_handle from ext3_direct_io_get_blocks: maxblocks = 26, iblock = 204, create = 1
...................
Calling ext3_get_block_handle from ext3_direct_io_get_blocks: maxblocks = 5, iblock = 225, create = 1
Calling ext3_get_block_handle from ext3_direct_io_get_blocks: maxblocks = 4, iblock = 226, create = 1
Calling ext3_get_block_handle from ext3_direct_io_get_blocks: maxblocks = 3, iblock = 227, create = 1
Calling ext3_get_block_handle from ext3_direct_io_get_blocks: maxblocks = 2, iblock = 228, create = 1
Calling ext3_get_block_handle from ext3_direct_io_get_blocks: maxblocks = 1, iblock = 229, create = 1

-bash-2.05b# /root/filetst -o 409600 -b 122880 -c 1 -w -d -f a
Calling ext3_get_block_handle from ext3_direct_io_get_blocks: maxblocks = 30, iblock = 100, create = 0


Because of create flag is 0, ext3_get_block will not do block allocation
and return immediately after look up failed. Then ext3_get_block_handle
() is called from other path(I am not sure where) other than
ext3_direct_io_get_blocks to allocate the desired 30 blocks.(thus, when
apply ext3_get_blocks patch, ext3_get_blocks is not called)

Could you clarify?

Thanks,
Mingming

