Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319447AbSILGMV>; Thu, 12 Sep 2002 02:12:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319448AbSILGMV>; Thu, 12 Sep 2002 02:12:21 -0400
Received: from dp.samba.org ([66.70.73.150]:54953 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319447AbSILGMU>;
	Thu, 12 Sep 2002 02:12:20 -0400
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15744.12392.868240.502920@argo.ozlabs.ibm.com>
Date: Thu, 12 Sep 2002 16:12:56 +1000 (EST)
To: Jens Axboe <axboe@suse.de>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] highmem I/O for ide-pmac.c
In-Reply-To: <20020911130209.GL1089@suse.de>
References: <15743.15275.412038.388540@argo.ozlabs.ibm.com>
	<20020911130209.GL1089@suse.de>
X-Mailer: VM 6.75 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe writes:

> Doesn't look like it's needed at all, at least you never turn on highmem
> I/O with ide_toggle_bounce() :-)

Foo, neither I do. :(

> BTW, it would be ok to export that from ide-dma.c instead of duplicating
> it in ide-pmac.

Looking at it again, both ide_build_sglist and ide_raw_build_sglist do
*almost* what we want.  If ide-pmac used hwif->sg_table instead of
pmif->sg_table, and if ide_[raw_]build_sglist were exported and took
the maximum number of entries as a parameter instead of using the
PRD_ENTRIES constant, then ide-pmac wouldn't need to have its own
versions of those routines.  Would those changes be OK?

Ben, any reason why we have to use pmif->sg_table rather than
hwif->sg_table?

> Also, can you grow sg segments indefinitely?

Each DBDMA (descriptor-based DMA) command has a 16-byte length field,
so is limited to 65535 bytes.  There is code in pmac_ide_build_dmatable
to create multiple DBDMA commands from a single scatterlist element if
necessary.  We should limit the lengths of the segments instead, then
we could have a 1-1 correspondence of scatterlist elements to DBDMA
command blocks.

Paul.
