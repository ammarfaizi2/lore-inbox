Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262312AbSKHTyx>; Fri, 8 Nov 2002 14:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262317AbSKHTyw>; Fri, 8 Nov 2002 14:54:52 -0500
Received: from packet.digeo.com ([12.110.80.53]:52370 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262312AbSKHTyw>;
	Fri, 8 Nov 2002 14:54:52 -0500
Message-ID: <3DCC1817.3DBBAFED@digeo.com>
Date: Fri, 08 Nov 2002 12:01:27 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Burton Windle <bwindle@fint.org>,
       Arnaldo Carvalho de Melo <acme@conectiva.com.br>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.5.46-bk3: BUG in skbuff.c:178
References: <Pine.LNX.4.43.0211081440130.317-100000@morpheus>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2002 20:01:28.0064 (UTC) FILETIME=[9FB26000:01C28761]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burton Windle wrote:
> 
> Single-CPU system, running 2.5.46-bk3. Whiling compiling bk4, and running
> a script that was pinging every host on my subnet (I was running arp -a
> to see what was in the arp table at the time), I hit this BUG.
> 
> Debug: sleeping function called from illegal context at mm/slab.c:1305
> Call Trace:
>  [<c011247c>] __might_sleep+0x54/0x58
>  [<c012a3e2>] kmem_flagcheck+0x1e/0x50
>  [<c012ab6a>] kmem_cache_alloc+0x12/0xc8
>  [<c0226e0c>] sock_alloc_inode+0x10/0x68
>  [<c014cb65>] alloc_inode+0x15/0x180
>  [<c014d397>] new_inode+0xb/0x78
>  [<c0227093>] sock_alloc+0xf/0x68
>  [<c0227d65>] sock_create+0x8d/0xe4
>  [<c0227dd9>] sys_socket+0x1d/0x58
>  [<c0228a13>] sys_socketcall+0x5f/0x1f4
>  [<c0108903>] syscall_call+0x7/0xb
> 
> bad: scheduling while atomic!

Something somewhere has caused a preempt_count imbalance.  What
you're seeing here are the downstream effects of an earlier bug.

I'd be suspecting the seq_file conversion in arp.c.  The read_lock_bh()
stuff in there looks, umm, unclear ;)

(Could we pleeeeze nuke the __inline__'s in there too?)
