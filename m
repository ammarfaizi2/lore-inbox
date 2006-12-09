Return-Path: <linux-kernel-owner+w=401wt.eu-S1759743AbWLIXQI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759743AbWLIXQI (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 18:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759747AbWLIXQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 18:16:08 -0500
Received: from py-out-1112.google.com ([64.233.166.176]:47059 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759675AbWLIXQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 18:16:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=lm5O0svpAxlIijre5IlQIak8k7KtW4jdAhr730zPYaKbaCeNkUt1QPCxf6H7QTAflFnc40XTm0e1yBN/q7rnPLhxUeKak8+wgMDNiFLiawyoUEABcgOBC6JcOkoqMbEkOiwCcov+qPtc1MbaCZNAgfSC7VA31IRHfG93N6wRV1A=
Message-ID: <b0943d9e0612091516s600d2c5bp327ce5008a57381e@mail.gmail.com>
Date: Sat, 9 Dec 2006 23:16:04 +0000
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Possible memory leak in block/ll_rw_blk.c
Cc: "Mike Christie" <michaelc@cs.wisc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After 2.6.19, kmemleak reports several (few tens) orphan blocks
allocated in bio_alloc_bioset() via __blk_rq_map_user() in
block/ll_rq_blk.c. I think these came with commit
0e75f9063f5c55fb0b0b546a7c356f8ec186825e (support larger block pc
requests). The allocation backtrace for the "bio" structure is:

unreferenced object 0xdd9162b0 (size 64):
  [<c018d46f>] kmem_cache_alloc
  [<c0170b2e>] mempool_alloc_slab
  [<c01709cb>] mempool_alloc
  [<c01b7baa>] bio_alloc_bioset
  [<c01b7d0e>] bio_alloc
  [<c01b83f8>] bio_copy_user
  [<c021a380>] __blk_rq_map_user
  [<c021a4ff>] blk_rq_map_user
  [<c021e687>] sg_io
  [<c021ed3e>] scsi_cmd_ioctl
  [<c02bcc13>] sd_ioctl
  [<c021ca65>] blkdev_driver_ioctl
  [<c021cc27>] blkdev_ioctl
  [<c01ba72b>] block_ioctl
  [<c019ea36>] do_ioctl

Because the above objects cannot be tracked, kmemleak also reports the
bio_map_data structures allocated in bio_alloc_map_data (called from
bio_copy_user via the above backtrace).

Thanks.

-- 
Catalin
