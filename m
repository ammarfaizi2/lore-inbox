Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286825AbSBCLi7>; Sun, 3 Feb 2002 06:38:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286871AbSBCLit>; Sun, 3 Feb 2002 06:38:49 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:47086 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S286825AbSBCLig>; Sun, 3 Feb 2002 06:38:36 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20020202135749.B4934@suse.de> 
In-Reply-To: <20020202135749.B4934@suse.de>  <20020131.145904.41634460.davem@redhat.com> <E16WQYs-0003Ux-00@the-village.bc.nu> <20020131232119.GN10772@conectiva.com.br> <200202021232.g12CWat01313@Port.imtp.ilyichevsk.odessa.ua> 
To: Jens Axboe <axboe@suse.de>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: crc32 and lib.a (was Re: [PATCH] nbd in 2.5.3 does 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 03 Feb 2002 11:37:59 +0000
Message-ID: <11994.1012736279@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


axboe@suse.de said:
>  You can do even more than this -- I dunno what I/O interface these
> embedded system generally uses (the mtd stuff?). Provided you provide
> a direct make_request_fn entry into these instead of using the queue,
> you can basically cut all of ll_rw_blk.c and elevator.c. 

We don't even do that - look at jffs2_read_super(). The only reason it even 
_looks_ like we're using a block device is because it was the easiest way 
to arrange mounting. We only allow you to mount the 'mtdblock' device, 
which isn't actually used - all we do is use the minor number to look up 
the real underlying MTD device. The dependency on _any_ of the block code 
isn't real - I can fix it as soon as there's an incentive to do so (like 
CONFIG_BLK_DEV).

> ll_rw_block, submit_bh, and generic_make_request would be all that is left. 

Those can go too. Likewise page->buffers.

>  That should reclaim quite a lot of space. If there's any interest in
> this (has it already been done?), I can help out getting it done.

I had a go once. Long enough ago that it's probably not worth trying to find
it again. I'd suggest a boolean like CONFIG_BUFFER_CACHE which does the
really intrusive stuff like removing page->buffers, and CONFIG_BLK_DEV which
can be modular (if CONFIG_BUFFER_CACHE is on), and which controls
compilation of everything in drivers/block/ and fs/block_dev.c

--
dwmw2


