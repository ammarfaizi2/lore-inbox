Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262348AbTESKZk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 06:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262341AbTESKZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 06:25:40 -0400
Received: from holomorphy.com ([66.224.33.161]:8677 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262348AbTESKZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 06:25:37 -0400
Date: Mon, 19 May 2003 03:38:26 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.5.69-mm7
Message-ID: <20030519103826.GC8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rudmer van Dijk <rudmer@legolas.dynup.net>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
References: <20030519012336.44d0083a.akpm@digeo.com> <200305191230.06092.rudmer@legolas.dynup.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305191230.06092.rudmer@legolas.dynup.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 May 2003 10:23, Andrew Morton wrote:
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.69/2.5.69
>>-mm7/
>> . Included most of the new AIO code which has been floating about.  This
>>   all still needs considerable thought and review, but we may as well get
>> it under test immediately.
>> . Lots of little fixes, as usual.

On Mon, May 19, 2003 at 12:30:05PM +0200, Rudmer van Dijk wrote:
> and this became broken:
> if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.69-mm7; fi
> WARNING: /lib/modules/2.5.69-mm7/kernel/fs/ext2/ext2.ko needs unknown symbol 
> __bread_wq
> __bread_wq is introduced in -mm7, someone forgot to export it?

Try this patch please.

-- wli


diff -prauN mm7-2.5.69-1/fs/buffer.c mm7-2.5.69-2A/fs/buffer.c
--- mm7-2.5.69-1/fs/buffer.c	2003-05-19 01:18:03.000000000 -0700
+++ mm7-2.5.69-2A/fs/buffer.c	2003-05-19 03:14:27.000000000 -0700
@@ -1490,6 +1490,7 @@ __bread(struct block_device *bdev, secto
 		bh = __bread_slow(bh);
 	return bh;
 }
+EXPORT_SYMBOL(__bread);
 
 
 struct buffer_head *
@@ -1502,7 +1503,7 @@ __bread_wq(struct block_device *bdev, se
 		bh = __bread_slow_wq(bh, wait);
 	return bh;
 }
-EXPORT_SYMBOL(__bread);
+EXPORT_SYMBOL(__bread_wq);
 
 /*
  * invalidate_bh_lrus() is called rarely - at unmount.  Because it is only for
diff -prauN mm7-2.5.69-1/kernel/ksyms.c mm7-2.5.69-2A/kernel/ksyms.c
--- mm7-2.5.69-1/kernel/ksyms.c	2003-05-19 01:18:08.000000000 -0700
+++ mm7-2.5.69-2A/kernel/ksyms.c	2003-05-19 03:17:20.000000000 -0700
@@ -123,6 +123,7 @@ EXPORT_SYMBOL(get_unmapped_area);
 EXPORT_SYMBOL(init_mm);
 EXPORT_SYMBOL(blk_queue_bounce);
 EXPORT_SYMBOL(blk_congestion_wait);
+EXPORT_SYMBOL(blk_congestion_wait_wq);
 #ifdef CONFIG_HIGHMEM
 EXPORT_SYMBOL(kmap_high);
 EXPORT_SYMBOL(kunmap_high);
@@ -216,6 +217,7 @@ EXPORT_SYMBOL(sync_dirty_buffer);
 EXPORT_SYMBOL(submit_bh);
 EXPORT_SYMBOL(unlock_buffer);
 EXPORT_SYMBOL(__wait_on_buffer);
+EXPORT_SYMBOL(__wait_on_buffer_wq);
 EXPORT_SYMBOL(blockdev_direct_IO);
 EXPORT_SYMBOL(block_write_full_page);
 EXPORT_SYMBOL(block_read_full_page);
