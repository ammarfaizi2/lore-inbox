Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267841AbTCFGZ0>; Thu, 6 Mar 2003 01:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267843AbTCFGZ0>; Thu, 6 Mar 2003 01:25:26 -0500
Received: from packet.digeo.com ([12.110.80.53]:11741 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267841AbTCFGZZ>;
	Thu, 6 Mar 2003 01:25:25 -0500
Date: Wed, 5 Mar 2003 22:36:38 -0800
From: Andrew Morton <akpm@digeo.com>
To: J Sloan <joe@tmsusa.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.5.64
Message-Id: <20030305223638.77c22cb7.akpm@digeo.com>
In-Reply-To: <3E66E782.5010502@tmsusa.com>
References: <3E66E782.5010502@tmsusa.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 06 Mar 2003 06:35:51.0466 (UTC) FILETIME=[A19558A0:01C2E3AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan <joe@tmsusa.com> wrote:
>
> ...
> The console was frozen, with an oops -

This is odd.

> Mar  5 21:17:41 jyro init: Switching to runlevel: 3
> Mar  5 21:17:42 jyro kernel: mtrr: MTRR 2 not used
> Mar  5 21:17:43 jyro microcode_ctl: microcode_ctl startup succeeded
> Mar  5 21:17:44 jyro kernel: Unable to handle kernel paging request at virtual address d85b0000

hmm, looks like a module address.

> Mar  5 21:17:44 jyro kernel:  printing eip:
> Mar  5 21:17:44 jyro kernel: c013ce25
> Mar  5 21:17:44 jyro kernel: *pde = 185b1163
> Mar  5 21:17:44 jyro kernel: *pte = 6c69614d
> Mar  5 21:17:44 jyro kernel: Oops: 0003
> Mar  5 21:17:44 jyro kernel: CPU:    0
> Mar  5 21:17:44 jyro kernel: EIP:    0060:[<c013ce25>]    Not tainted
> Mar  5 21:17:44 jyro kernel: EFLAGS: 00010216
> Mar  5 21:17:44 jyro kernel: EIP is at __constant_c_and_count_memset+0x85/0xa0

Eh?  How come the compiler didn't inline __constant_c_and_count_memset?
What compiler version are you using?

> Mar  5 21:17:44 jyro kernel: eax: 00000000   ebx: 00000000   ecx: 00000400   edx: d85b0000
> Mar  5 21:17:44 jyro kernel: esi: d3520000   edi: d85b0000   ebp: d3521eb4   esp: d3521eac
> Mar  5 21:17:44 jyro kernel: ds: 007b   es: 007b   ss: 0068
> Mar  5 21:17:44 jyro kernel: Process spamd (pid: 10385, threadinfo=d3520000 task=d7c70760)
> Mar  5 21:17:44 jyro kernel: Stack: c042faf4 c13ce380 d3521ed8 c013c5b0 d85b0000 00000000 00001000 d4e21cc0 
> Mar  5 21:17:44 jyro kernel:        d40c3088 d6d8a1e0 089d702c d3521f04 c013cace d6d8a1e0 d9b8d560 d3dfd75c 
> Mar  5 21:17:44 jyro kernel:        d40c3088 00000001 089d702c d6d8a1e0 d6d8a200 d7c70760 d3521fb4 c0115096 

The stack trace seems to contain lots of moduleish addresses too.

> Mar  5 21:17:44 jyro kernel: Call Trace:
> Mar  5 21:17:44 jyro kernel:  [<c013c5b0>] do_anonymous_page+0xd0/0x280
> Mar  5 21:17:44 jyro kernel:  [<c013cace>] handle_mm_fault+0x6e/0xa0
> Mar  5 21:17:44 jyro kernel:  [<c0115096>] do_page_fault+0x286/0x4e4
> Mar  5 21:17:44 jyro kernel:  [<c013f11d>] do_brk+0x13d/0x210
> Mar  5 21:17:44 jyro kernel:  [<c013dbe7>] sys_brk+0x107/0x130
> Mar  5 21:17:44 jyro kernel:  [<c0114e10>] do_page_fault+0x0/0x4e4
> Mar  5 21:17:44 jyro kernel:  [<c01099dd>] error_code+0x2d/0x38

But they were skipped by kksymoops.

My guess would be that something has tried to reference a module which isn't
there any more.

Did you at any time unload a module?   If so, which one?

