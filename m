Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262402AbTCVMCP>; Sat, 22 Mar 2003 07:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262409AbTCVMCO>; Sat, 22 Mar 2003 07:02:14 -0500
Received: from packet.digeo.com ([12.110.80.53]:48356 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262402AbTCVMCN>;
	Sat, 22 Mar 2003 07:02:13 -0500
Date: Sat, 22 Mar 2003 04:12:51 -0800
From: Andrew Morton <akpm@digeo.com>
To: Dawson Engler <engler@csl.stanford.edu>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [CHECKER] races in 2.5.65/mm/swapfile.c?
Message-Id: <20030322041251.7720e42f.akpm@digeo.com>
In-Reply-To: <200303221145.h2MBjAW09391@csl.stanford.edu>
References: <200303221145.h2MBjAW09391@csl.stanford.edu>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Mar 2003 12:12:47.0302 (UTC) FILETIME=[59C51E60:01C2F06C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dawson Engler <engler@csl.stanford.edu> wrote:
>
> Hi All,
> 
> mm/swapfile.c seems to have three potential races.
> 
> The first two are in 
>         linux-2.5.62/mm/swap_state.c:87:add_to_swap_cache
> 
> which seems reachable without a lock from the callchain:
> 
>         mm/swapfile.c:sys_swapoff:998->
>               sys_swapoff:1026->
>                 try_to_unuse:591->
>                         mm/swap_state.c:read_swap_cache_async:377->
>                             add_to_swap_cache
> 
> add_to_swap_cache increments two global variables without a lock:
>         INC_CACHE_INFO(add_total);
> and
>         INC_CACHE_INFO(exist_race);

These are just instrumentation.  If they're a bit inaccurate nobody cares,
and they're not worth locking.

So yes, that is a positive.

> The final one is in
>         linux-2.5.62/mm/swapfile.c:213:swap_entry_free
> which seems to increment
>         nr_swap_pages++;
> without a lock.

swap_entry_free() is called after swap_info_get(), which locks the swap
device list and the particular swap device.

