Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbTJ1VvR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 16:51:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTJ1VvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 16:51:17 -0500
Received: from vana.vc.cvut.cz ([147.32.240.58]:39040 "EHLO vana.vc.cvut.cz")
	by vger.kernel.org with ESMTP id S261763AbTJ1VvP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 16:51:15 -0500
Date: Tue, 28 Oct 2003 22:51:05 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Cc: linux-kernel@24x7linux.com, akpm@digeo.com
Subject: Re: [2.6.0-test8-mm1]: trashing and oops() on OOM (WARNING: VMware modules loaded)
Message-ID: <20031028215105.GB7156@vana.vc.cvut.cz>
References: <20031028210657.GA2204@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031028210657.GA2204@localhost>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 28, 2003 at 10:06:58PM +0100, Jose Luis Domingo Lopez wrote:
> 
> Everything reported until know happens with kernel version
> 2.6.0-test8-mm1 WITH BINARY VMware modules loaded.
> 
> I tried to reproduce the problem rebooting the machine _without_ loading
> the propietary modules, but now everything works fine. So one can
> (safely?) conclude there was something related to VMware.
> 
> Oct 28 21:21:46 dardhal kernel: divide error: 0000 [#1]
> Oct 28 21:21:53 dardhal kernel: CPU:    0
> Oct 28 21:22:04 dardhal kernel: EIP:    0060:[<c012f573>]    Tainted: PF  VLI
> Oct 28 21:22:09 dardhal kernel: EFLAGS: 00010246
> Oct 28 21:22:29 dardhal kernel: EIP is at badness+0x5f/0xe4
> Oct 28 21:22:32 dardhal kernel: eax: 00000158   ebx: 0053266b   ecx: 00000000   edx: 00000000
> Oct 28 21:22:32 dardhal kernel: esi: 00000000   edi: 00000000   ebp: 00000158   esp: d6d9fd34
> Oct 28 21:22:32 dardhal kernel: ds: 007b   es: 007b   ss: 0068
> Oct 28 21:22:32 dardhal kernel: Process top (pid: 9863, threadinfo=d6d9e000 task=cb29c040)
> Oct 28 21:22:33 dardhal kernel: Stack: 00000000 c151d900 c151d900 00000000 00000000 c012f622 c151d900 004e9aa8 
> Oct 28 21:22:33 dardhal kernel: 00000000 d6d9fe44 ffffffff c012f717 004e9aa8 00000000 d6d9fe44 ffffffff 
> Oct 28 21:22:33 dardhal kernel: c012f809 d6d9fd8c c01358ce 00000001 00000000 00000a65 00000000 0000004d 
> Oct 28 21:22:33 dardhal kernel: Call Trace:
> Oct 28 21:22:33 dardhal kernel: [<c012f622>] select_bad_process+0x2a/0x62
> Oct 28 21:22:33 dardhal kernel: [<c012f717>] oom_kill+0x9/0x9b
> Oct 28 21:22:33 dardhal kernel: [<c012f809>] out_of_memory+0x60/0x7f
> Oct 28 21:22:33 dardhal kernel: [<c01358ce>] try_to_free_pages+0x115/0x13e
> Oct 28 21:22:33 dardhal kernel: [<c01302bf>] __alloc_pages+0x1a0/0x2c0
> Oct 28 21:22:33 dardhal kernel: [<c0131f4c>] do_page_cache_readahead+0xc3/0xeb
> Oct 28 21:22:33 dardhal kernel: [<c012d97b>] filemap_nopage+0xb3/0x276
> Oct 28 21:22:33 dardhal kernel: [<c0137fe6>] do_no_page+0x7d/0x2d8
> Oct 28 21:22:33 dardhal kernel: [<c0138393>] handle_mm_fault+0x9b/0xe6
> Oct 28 21:22:33 dardhal kernel: [<c01157de>] do_page_fault+0x108/0x4a2
> Oct 28 21:22:33 dardhal kernel: [<c0149f4e>] sys_stat64+0x25/0x29
> Oct 28 21:22:33 dardhal kernel: [<c01156d6>] do_page_fault+0x0/0x4a2
> Oct 28 21:22:33 dardhal kernel: [<c0262e2f>] error_code+0x2f/0x38
> Oct 28 21:22:33 dardhal kernel: 
> Oct 28 21:22:33 dardhal kernel: Code: 00 e8 d7 d5 fe ff 89 c3 89 d6 8b 44 24 14 c1 ef 0d 2b 98 d0 01 00 00 1b b0 d4 01 00 00 57 e8 15 1e 06 00 89 c2 89 e8 89 d1 31 d2 <f7> f1 0f ac f3 14 53 89 c5 e8 ff 1d 06 00 89 04 24 e8 f7 1d 06 

No big surprise. -mm contains special "int_sqrt", which is broken. oom_killer requires
sqrt() which never returns 0. Originally int_sqrt() does

    return (out ? out : 1);

while int_sqrt() present in -mm can happily return 0.

So if you have in system process which never run (utime == stime == 0), then whenever
you'll run out of memory you'll get this division by zero.

And yes, you'll get division by zero even without VMware.
							Petr Vandrovec
							vandrove@vc.cvut.cz
