Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262365AbSI2B0u>; Sat, 28 Sep 2002 21:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262366AbSI2B0u>; Sat, 28 Sep 2002 21:26:50 -0400
Received: from packet.digeo.com ([12.110.80.53]:28831 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262365AbSI2B0t>;
	Sat, 28 Sep 2002 21:26:49 -0400
Message-ID: <3D96580D.A0F803BC@digeo.com>
Date: Sat, 28 Sep 2002 18:31:57 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.38 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Zach Brown <zab@zabbo.net>
CC: lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: suspect list_empty( {NULL, NULL} )
References: <20020928205836.C13817@bitchcake.off.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 29 Sep 2002 01:32:01.0384 (UTC) FILETIME=[02571680:01C26758]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zach Brown wrote:
> 
> A cute list_head debugging patch seems to have found strange list_entry
> use in vmscan.c in stock 2.5.39.
> 
> page_mapping_inuse:
> 
>         if (!list_empty(&mapping->i_mmap) || !list_empty(&mapping->i_mmap_shared))
> 
> ...
> (gdb) print *mapping
> $22 = {host = 0xc03b6e00

That's swapper_space.


--- 2.5.39/mm/swap_state.c~swapper_space-state	Sat Sep 28 18:30:45 2002
+++ 2.5.39-akpm/mm/swap_state.c	Sat Sep 28 18:31:26 2002
@@ -43,6 +43,8 @@ struct address_space swapper_space = {
 	.a_ops			= &swap_aops,
 	.backing_dev_info	= &swap_backing_dev_info,
 	.i_shared_lock		= SPIN_LOCK_UNLOCKED,
+	.i_mmap			= LIST_HEAD_INIT(swapper_space.i_mmap),
+	.i_mmap_shared		= LIST_HEAD_INIT(swapper_space.i_mmap_shared),
 	.private_lock		= SPIN_LOCK_UNLOCKED,
 	.private_list		= LIST_HEAD_INIT(swapper_space.private_list),
 };

.
