Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264024AbTCUUbA>; Fri, 21 Mar 2003 15:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264026AbTCUU3v>; Fri, 21 Mar 2003 15:29:51 -0500
Received: from packet.digeo.com ([12.110.80.53]:39632 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S264024AbTCUU3P>;
	Fri, 21 Mar 2003 15:29:15 -0500
Date: Fri, 21 Mar 2003 12:39:19 -0800
From: Andrew Morton <akpm@digeo.com>
To: Alexander Hoogerhuis <alexh@ihatent.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [BUG] 2.5.65-mm3 kernel BUG at fs/ext3/super.c:1795!
Message-Id: <20030321123919.0b8b1b86.akpm@digeo.com>
In-Reply-To: <8765qchhgo.fsf@lapper.ihatent.com>
References: <20030320235821.1e4ff308.akpm@digeo.com>
	<8765qchhgo.fsf@lapper.ihatent.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Mar 2003 20:39:15.0590 (UTC) FILETIME=[F0302260:01C2EFE9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Hoogerhuis <alexh@ihatent.com> wrote:
>
> Andrew Morton <akpm@digeo.com> writes:
> >
> > [SNIP]
> >
> 
> Disk I/O on my machine froze up during very light work after a few
> hours, luckily I had a window open on another machine so I could do a
> simple capture and save the info:
> 
> kernel BUG at fs/ext3/super.c:1795!
> invalid operand: 0000 [#1]
> CPU:    0
> EIP:    0060:[<c018b522>]    Not tainted VLI
> EFLAGS: 00010246
> EIP is at ext3_write_super+0x36/0x94
> eax: 00000000   ebx: c8834000   ecx: efb5904c   edx: efb59000
> esi: efb59000   edi: c8834000   ebp: c8835ecc   esp: c8835ec0
> ds: 007b   es: 007b   ss: 0068
> Process pdflush (pid: 7853, threadinfo=c8834000 task=ed0a5880)
> Stack: c8835ee4 00000287 efb5904c c8835ee4 c0153148 efb59000 00000077 51eb851f
>        c8835fcc c8835fa4 c0137fd0 c03892fc 007b9f47 007b168f 00000000 00000000
>        c8835ef4 00000000 00000001 00000000 00000001 00000000 00000053 00000000
> Call Trace:
>  [<c0153148>] sync_supers+0xde/0xea
>  [<c0137fd0>] wb_kupdate+0x68/0x161
>  [<c0118985>] schedule+0x1a4/0x3ac
>  [<c01386e8>] __pdflush+0xdc/0x1d8
>  [<c01387e4>] pdflush+0x0/0x15
>  [<c01387f5>] pdflush+0x11/0x15
>  [<c0137f68>] wb_kupdate+0x0/0x161
>  [<c0108e69>] kernel_thread_helper+0x5/0xb

How on earth did you do that?

sync_supers() does lock_super, then calls ext3_write_super.

ext3_write_super() does a down_trylock() on sb->s_lock and goes BUG
if it acquired the lock.

So you've effectively done this:

	down(&sem);
	if (down_trylock(&sem))
		BUG();

This can only be a random memory scribble, a hardware bug or a
preempt-related bug in down_trylock().

