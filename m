Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261289AbSJHRRU>; Tue, 8 Oct 2002 13:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261208AbSJHRRT>; Tue, 8 Oct 2002 13:17:19 -0400
Received: from packet.digeo.com ([12.110.80.53]:21729 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261301AbSJHRRP>;
	Tue, 8 Oct 2002 13:17:15 -0400
Message-ID: <3DA31468.E0E4F711@digeo.com>
Date: Tue, 08 Oct 2002 10:22:48 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.40 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: might_sleep warning in both 41 and 41-mm1
References: <1455194388.1034066565@[10.10.2.3]>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2002 17:22:48.0930 (UTC) FILETIME=[530B8C20:01C26EEF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" wrote:
> 
> This one still happens in both 41 and 41-mm1. I'd mentioned
> it before, and was told it was fixed in a later kernel, but
> still seems to be there.
> 
> Debug: sleeping function called from illegal context at mm/page_alloc.c:512
> Call Trace:
>  [<c0115fb3>] __might_sleep+0x43/0x47
>  [<c0134efc>] __alloc_pages+0x24/0x260
>  [<c0112638>] pte_alloc_one+0x38/0xfc
>  [<c01279cd>] pte_alloc_map+0x2d/0x1b0
>  [<c012f6cc>] move_one_page+0x11c/0x2d8
>  [<c012f794>] move_one_page+0x1e4/0x2d8
>  [<c012f8b7>] move_page_tables+0x2f/0x74
>  [<c012fe4d>] do_mremap+0x551/0x6dc
>  [<c013002b>] sys_mremap+0x53/0x74
>  [<c0106ff7>] syscall_call+0x7/0xb
> 

Oh.  It seems that the pte mapping functions will run inc_preempt_count()
via kmap_atomic() even if CONFIG_HIGHPTE=n.  So the ifdef around
page_table_present() needs to be CONFIG_HIGHMEM.  Or we don't use
kmap_atomic() at all in the pte mapping functions.

Please tell me that you had CONFIG_HIGHPTE=n?
