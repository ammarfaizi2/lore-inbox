Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263587AbUC3Jpt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 04:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263588AbUC3Jpt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 04:45:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:15048 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263587AbUC3Jpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 04:45:46 -0500
Date: Tue, 30 Mar 2004 01:45:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mingming Cao <cmm@us.ibm.com>
Cc: tytso@mit.edu, pbadari@us.ibm.com, ext2-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, cmm@us.ibm.com
Subject: Re: [RFC, PATCH] Reservation based ext3 preallocation
Message-Id: <20040330014523.6a368a69.akpm@osdl.org>
In-Reply-To: <1080636930.3548.4549.camel@localhost.localdomain>
References: <200403190846.56955.pbadari@us.ibm.com>
	<20040321015746.14b3c0dc.akpm@osdl.org>
	<1080636930.3548.4549.camel@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mingming Cao <cmm@us.ibm.com> wrote:
>
> Ext3 preallocation is currently missing.

I thing this is heading the right way.

- Please use u32 for block numbers everywhere.  In a number of places you
  are using int, and that may go wrong if the block numbers wrap negative
  (I'm not sure that ext3 supports 8TB, but it's the right thing to do).

- Using ext3_find_next_zero_bit(bitmap_bh->b_data in
  alloc_new_reservation() is risky.  There are some circumstances when you
  have a huge number of "free" blocks in ->b_data, but they are all unfree
  in ->b_committed_data.  You could end up with astronomical search
  complexity in there.  You should search both bitmaps to find a block
  which really is allocatable.  Otherwise you'll have
  ext3_try_to_allocate() failing 20,000 times in succession and much CPU
  will be burnt.

- I suspect ext3_try_to_allocate_with_rsv() could be reorganised a bit to
  reduce the goto spaghetti?

- Please provide a mount option which enables the feature, defaulting to
  "off".

- Make sure that you have a many-small-file test.  Say, untar a kernel
  tree onto a clean filesystem and make sure that reading all the files in
  the tree is nice and fast.

  This is to check that the reservation is being discarded appropriately
  on file close, and that those small files are contiguous on-disk.  If we
  accidentally leave gaps in between them the many-small-file bandwidth
  takes a dive.

- There's a little program called `bmap' in
  http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz which
  can be used to dump out a file's block allocation map, to check
  fragmentation.

Apart from that, looking good.  Where are the benchmarks? ;)
