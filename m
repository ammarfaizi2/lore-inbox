Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261271AbTJ1VHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 16:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbTJ1VHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 16:07:42 -0500
Received: from 213-0-170-219.dialup.nuria.telefonica-data.net ([213.0.170.219]:1152
	"EHLO dardhal.mired.net") by vger.kernel.org with ESMTP
	id S261271AbTJ1VHU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 16:07:20 -0500
Date: Tue, 28 Oct 2003 22:06:58 +0100
From: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [2.6.0-test8-mm1]: trashing and oops() on OOM (WARNING: VMware modules loaded)
Message-ID: <20031028210657.GA2204@localhost>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

I am completely aware of the fact that binary modules loaded into the
current kernel can hide no end of things that could well explain the
problem that I am about to report, so if there is nothing useful that
can be learnt from this post, please stop reading now :-)

While doing some normal work on my PC (Linux Debian Sid, libc 2.3.2-2,
kernel version 2.6.0-test8-mm1 compiled with gcc 3.2.3, and mawk 1.3.3)
I tried to do a "make menuconfig" on a source tree I had laying around,
and have compiled flawlessly for weeks (kernel sources for 2.4.22).

I tried "make menuconfig" and when it was in the "Preparing scripts:
functions, parsing" part, it didn't showed the "progress bar" (dots),
and "awk" started to eat tons of memory, all available (no limits on RAM
used by processes set up here).

I was confident that the kernel would detect this runaway process eating
the RAM, and when OOM would kill it and I would notice very little the
problem. But it was not like that, and the box started trashing (heavy
disk activity, and no real work done), until X applications stop
responding any more.

Any attempt to switch back to console mode was unsuccessful, and the
disk kept on being heavily used, except for short periods of time where
the light went off, and then everything started again.

Out of desperation I pressed "SysRq+t", "SysRq+k" and some other
combinations trying to regain control of the box, and finally got it. I
was again at the console, but with the framebuffer shown in the screen,
and not updated. Blindly logged in again, started X, and tried again
"make menuconfig". This time "awk" creates some temporary files in the
sources directory, and fails with signal 139, but nothing else happens.

Everything reported until know happens with kernel version
2.6.0-test8-mm1 WITH BINARY VMware modules loaded.

I tried to reproduce the problem rebooting the machine _without_ loading
the propietary modules, but now everything works fine. So one can
(safely?) conclude there was something related to VMware.


In any case, I have appended to the end of this email a copy of the
messages I got in the logs, just in case it can show something in the
official kernel sources worth investigating. Hope it helps, and
apologize for the wasted bandwidth if not.

The messages include both kernel messages generated "on their own", as
well as the result of a "SysRq+t" y did just before losing any hope :)


Oct 28 21:21:46 dardhal kernel: divide error: 0000 [#1]
Oct 28 21:21:53 dardhal kernel: CPU:    0
Oct 28 21:22:04 dardhal kernel: EIP:    0060:[<c012f573>]    Tainted: PF  VLI
Oct 28 21:22:09 dardhal kernel: EFLAGS: 00010246
Oct 28 21:22:29 dardhal kernel: EIP is at badness+0x5f/0xe4
Oct 28 21:22:32 dardhal kernel: eax: 00000158   ebx: 0053266b   ecx: 00000000   edx: 00000000
Oct 28 21:22:32 dardhal kernel: esi: 00000000   edi: 00000000   ebp: 00000158   esp: d6d9fd34
Oct 28 21:22:32 dardhal kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 21:22:32 dardhal kernel: Process top (pid: 9863, threadinfo=d6d9e000 task=cb29c040)
Oct 28 21:22:33 dardhal kernel: Stack: 00000000 c151d900 c151d900 00000000 00000000 c012f622 c151d900 004e9aa8 
Oct 28 21:22:33 dardhal kernel: 00000000 d6d9fe44 ffffffff c012f717 004e9aa8 00000000 d6d9fe44 ffffffff 
Oct 28 21:22:33 dardhal kernel: c012f809 d6d9fd8c c01358ce 00000001 00000000 00000a65 00000000 0000004d 
Oct 28 21:22:33 dardhal kernel: Call Trace:
Oct 28 21:22:33 dardhal kernel: [<c012f622>] select_bad_process+0x2a/0x62
Oct 28 21:22:33 dardhal kernel: [<c012f717>] oom_kill+0x9/0x9b
Oct 28 21:22:33 dardhal kernel: [<c012f809>] out_of_memory+0x60/0x7f
Oct 28 21:22:33 dardhal kernel: [<c01358ce>] try_to_free_pages+0x115/0x13e
Oct 28 21:22:33 dardhal kernel: [<c01302bf>] __alloc_pages+0x1a0/0x2c0
Oct 28 21:22:33 dardhal kernel: [<c0131f4c>] do_page_cache_readahead+0xc3/0xeb
Oct 28 21:22:33 dardhal kernel: [<c012d97b>] filemap_nopage+0xb3/0x276
Oct 28 21:22:33 dardhal kernel: [<c0137fe6>] do_no_page+0x7d/0x2d8
Oct 28 21:22:33 dardhal kernel: [<c0138393>] handle_mm_fault+0x9b/0xe6
Oct 28 21:22:33 dardhal kernel: [<c01157de>] do_page_fault+0x108/0x4a2
Oct 28 21:22:33 dardhal kernel: [<c0149f4e>] sys_stat64+0x25/0x29
Oct 28 21:22:33 dardhal kernel: [<c01156d6>] do_page_fault+0x0/0x4a2
Oct 28 21:22:33 dardhal kernel: [<c0262e2f>] error_code+0x2f/0x38
Oct 28 21:22:33 dardhal kernel: 
Oct 28 21:22:33 dardhal kernel: Code: 00 e8 d7 d5 fe ff 89 c3 89 d6 8b 44 24 14 c1 ef 0d 2b 98 d0 01 00 00 1b b0 d4 01 00 00 57 e8 15 1e 06 00 89 c2 89 e8 89 d1 31 d2 <f7> f1 0f ac f3 14 53 89 c5 e8 ff 1d 06 00 89 04 24 e8 f7 1d 06 
Oct 28 21:22:33 dardhal kernel: divide error: 0000 [#2]
Oct 28 21:22:33 dardhal kernel: CPU:    0
Oct 28 21:22:33 dardhal kernel: EIP:    0060:[<c012f573>]    Tainted: PF  VLI
Oct 28 21:22:33 dardhal kernel: EFLAGS: 00010246
Oct 28 21:22:33 dardhal kernel: EIP is at badness+0x5f/0xe4
Oct 28 21:22:33 dardhal kernel: eax: 00000158   ebx: 00533a2d   ecx: 00000000   edx: 00000000
Oct 28 21:22:33 dardhal kernel: esi: 00000000   edi: 00000000   ebp: 00000158   esp: d7171d34
Oct 28 21:22:33 dardhal kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 21:22:33 dardhal kernel: Process kdeinit (pid: 1502, threadinfo=d7170000 task=d903a040)
Oct 28 21:22:33 dardhal kernel: Stack: 00000000 c151d900 c151d900 00000000 00000000 c012f622 c151d900 004eae6a 
Oct 28 21:22:33 dardhal kernel: 00000000 d7171e44 ffffffff c012f717 004eae6a 00000000 d7171e44 ffffffff 
Oct 28 21:22:33 dardhal kernel: c012f809 d7171d8c c01358ce 00000000 00000000 00000be7 00000000 00000000 
Oct 28 21:22:33 dardhal kernel: Call Trace:
Oct 28 21:22:43 dardhal kernel: [<c012f622>] select_bade4
Oct 28 21:22:48 dardhal kernel: eax: 00000158   ebx: 00534dc5   ecx: 00000000   edx: 00000000
Oct 28 21:23:04 dardhal kernel: esi: 00000000   edi: 00000000   ebp: 00000158   esp: d66ddd34
Oct 28 21:23:09 dardhal kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 21:23:30 dardhal kernel: Process watch (pid: 1574, threadinfo=d66dc000 task=d6699350)
Oct 28 21:23:30 dardhal kernel: Stack: 00000000 c151d900 c151d900 00000000 00000000 c012f622 c151d900 004ec202 
Oct 28 21:23:30 dardhal kernel: 00000000 d66dde44 ffffffff c012f717 004ec202 00000000 d66dde44 ffffffff 
Oct 28 21:23:30 dardhal kernel: c012f809 d66ddd8c c01358ce 00000007 00000000 00000856 00000000 00000000 
Oct 28 21:23:30 dardhal kernel: Call Trace:
Oct 28 21:23:30 dardhal kernel: [<c012f622>] select_bad_process+0x2a/0x62
Oct 28 21:23:30 dardhal kernel: [<c012f717>] oom_kill+0x9/0x9b
Oct 28 21:23:30 dardhal kernel: [<c012f809>] out_of_memory+0x60/0x7f
Oct 28 21:23:30 dardhal kernel: [<c01358ce>] try_to_free_pages+0x115/0x13e
Oct 28 21:23:30 dardhal kernel: [<c01302bf>] __alloc_pages+0x1a0/0x2c0
Oct 28 21:23:30 dardhal kernel: [<c0131f4c>] do_page_cache_readahead+0xc3/0xeb
Oct 28 21:23:30 dardhal kernel: [<c012d97b>] filemap_nopage+0xb3/0x276
Oct 28 21:23:30 dardhal kernel: [<c0137fe6>] do_no_page+0x7d/0x2d8
Oct 28 21:23:30 dardhal kernel: [<c0138393>] handle_mm_fault+0x9b/0xe6
Oct 28 21:23:30 dardhal kernel: [<c01157de>] do_page_fault+0x108/0x4a2
Oct 28 21:23:30 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:23:30 dardhal kernel: [<c01167eb>] wake_up_forked_process+0xa3/0x119
Oct 28 21:23:30 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:23:30 dardhal kernel: [<c01197fa>] do_fork+0xe0/0x16d
Oct 28 21:23:30 dardhal kernel: [<c0127f59>] nanosleep_wake_up+0x0/0x9
Oct 28 21:23:30 dardhal kernel: [<c014233f>] filp_close+0x42/0x64
Oct 28 21:23:30 dardhal kernel: [<c01156d6>] do_page_fault+0x0/0x4a2
Oct 28 21:23:30 dardhal kernel: [<c0262e2f>] error_code+0x2f/0x38
Oct 28 21:23:30 dardhal kernel: 
Oct 28 21:23:30 dardhal kernel: Code: 00 e8 d7 d5 fe ff 89 c3 89 d6 8b 44 24 14 c1 ef 0d 2b 98 d0 01 00 00 1b b0 d4 01 00 00 57 e8 15 1e 06 00 89 c2 89 e8 89 d1 31 d2 <f7> f1 0f ac f3 14 53 89 c5 e8 ff 1d 06 00 89 04 24 e8 f7 1d 06 
Oct 28 21:23:30 dardhal kernel: <4>IN=ppp0 OUT= MAC= SRC=213.0.155.197 DST=213.0.150.151 LEN=48 TOS=0x00 PREC=0x00 TTL=118 ID=21159 DF PROTO=TCP SPT=1300 DPT=445 WINDOW=8760 RES=0x00 SYN URGP=63487 
Oct 28 21:23:30 dardhal kernel: divide error: 0000 [#4]
Oct 28 21:23:30 dardhal kernel: CPU:    0
Oct 28 21:23:30 dardhal kernel: EIP:    0060:[<c012f573>]    Tainted: PF  VLI
Oct 28 21:23:30 dardhal kernel: EFLAGS: 00010246
Oct 28 21:23:30 dardhal kernel: EIP is at badness+0x5f/0xe4
Oct 28 21:23:30 dardhal kernel: eax: 00000158   ebx: 00536250   ecx: 00000000   edx: 00000000
Oct 28 21:23:30 dardhal kernel: esi: 00000000   edi: 00000000   ebp: 00000158   esp: cfd95d34
Oct 28 21:23:30 dardhal kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 21:23:30 dardhal kernel: Process irssi (pid: 1774, threadinfo=cfd94000 task=cfd4ed20)
Oct 28 21:23:34 dardhal kernel: St14 53 89 c5 e8 ff 1d 06 00 89 04 24 e8 f7 1d 06 
Oct 28 21:23:43 dardhal kernel: divide error: 0000 [#12]
Oct 28 21:23:43 dardhal kernel: CPU:    0
Oct 28 21:23:43 dardhal kernel: EIP:    0060:[<c012f573>]    Tainted: PF  VLI
Oct 28 21:23:43 dardhal kernel: EFLAGS: 00010246
Oct 28 21:23:43 dardhal kernel: EIP is at badness+0x5f/0xe4
Oct 28 21:23:43 dardhal kernel: eax: 00000158   ebx: 00542b95   ecx: 00000000   edx: 00000000
Oct 28 21:23:44 dardhal kernel: esi: 00000000   edi: 00000000   ebp: 00000158   esp: d823bd34
Oct 28 21:23:44 dardhal kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 21:23:44 dardhal kernel: Process aterm (pid: 1532, threadinfo=d823a000 task=da769940)
Oct 28 21:23:44 dardhal kernel: Stack: 00000000 c151d900 c151d900 00000000 00000000 c012f622 c151d900 004f9fd2 
Oct 28 21:23:44 dardhal kernel: 00000000 d823be44 ffffffff c012f717 004f9fd2 00000000 d823be44 ffffffff 
Oct 28 21:23:44 dardhal kernel: c012f809 d823bd8c c01358ce 00000006 00000000 000007b2 00000000 00000004 
Oct 28 21:23:44 dardhal kernel: Call Trace:
Oct 28 21:23:44 dardhal kernel: [<c012f622>] select_bad_process+0x2a/0x62
Oct 28 21:23:44 dardhal kernel: [<c012f717>] oom_kill+0x9/0x9b
Oct 28 21:23:44 dardhal kernel: [<c012f809>] out_of_memory+0x60/0x7f
Oct 28 21:23:44 dardhal kernel: [<c01358ce>] try_to_free_pages+0x115/0x13e
Oct 28 21:23:44 dardhal kernel: [<c01302bf>] __alloc_pages+0x1a0/0x2c0
Oct 28 21:23:44 dardhal kernel: [<c0131f4c>] do_page_cache_readahead+0xc3/0xeb
Oct 28 21:23:44 dardhal kernel: [<c012d97b>] filemap_nopage+0xb3/0x276
Oct 28 21:23:44 dardhal kernel: [<c0137fe6>] do_no_page+0x7d/0x2d8
Oct 28 21:23:44 dardhal kernel: [<c0138393>] handle_mm_fault+0x9b/0xe6
Oct 28 21:23:44 dardhal kernel: [<c01157de>] do_page_fault+0x108/0x4a2
Oct 28 21:23:44 dardhal kernel: [<c011ffdf>] update_process_times+0x29/0x2f
Oct 28 21:23:44 dardhal kernel: [<c011fecf>] update_wall_time+0xb/0x33
Oct 28 21:23:44 dardhal kernel: [<c012022e>] do_timer+0xc2/0xc8
Oct 28 21:23:44 dardhal kernel: [<c010ed2c>] timer_interrupt+0x30/0xe9
Oct 28 21:23:44 dardhal kernel: [<c0117136>] schedule+0x2fd/0x501
Oct 28 21:23:44 dardhal kernel: [<c011cbd7>] do_softirq+0x8b/0x8e
Oct 28 21:23:44 dardhal kernel: [<c01156d6>] do_page_fault+0x0/0x4a2
Oct 28 21:23:44 dardhal kernel: [<c0262e2f>] error_code+0x2f/0x38
Oct 28 21:23:44 dardhal kernel: 
Oct 28 21:23:44 dardhal kernel: Code: 00 e8 d7 d5 fe ff 89 c3 89 d6 8b 44 24 14 c1 ef 0d 2b 98 d0 01 00 00 1b b0 d4 01 00 00 57 e8 15 1e 06 00 89 c2 89 e8 89 d1 31 d2 <f7> f1 0f ac f3 14 53 89 c5 e8 ff 1d 06 00 89 04 24 e8 f7 1d 06 
Oct 28 21:23:44 dardhal kernel: divide error: 0000 [#13]
Oct 28 21:23:44 dardhal kernel: CPU:    0
Oct 28 21:23:44 dardhal kernel: EIP:    0060:[<c012f573>]    Tainted: PF  VLI
Oct 28 21:23:44 dardhal kernel: EFLAGS: 00010246
Oct 28 21:23:44 dardhal kernel: EIP is at badness+0x5f/0xe4
Oct 28 21:23:44 dardhal kernel: eax: 00000158   ebx: 00543f6e   ecx: 00000000   edx: 00000000
Oct 28 21:23:44 dardhal kernel: esi: 00000000   edi: 00000000   ebp: 00000158   esp: d0971d34
Oct 28 21:23:44 dardhal kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 21:23:44 dardhal kernel: Process xawtv (pid: 1636, threadinfo=d0970000 task=d13d46f0)
Oct 28 21:23:47 dardhal kernel: Stack: 00000000 c151d90e8 15 1e 06 00 89 c2 89 e8 89 d1 31 d2 <f7> f1 0f ac f3 14 53 89 c5 e8 ff 1d 06 00 89 04 24 e8 f7 1d 06 
Oct 28 21:23:47 dardhal kernel: divide error: 0000 [#14]
Oct 28 21:23:47 dardhal kernel: CPU:    0
Oct 28 21:23:47 dardhal kernel: EIP:    0060:[<c012f573>]    Tainted: PF  VLI
Oct 28 21:23:47 dardhal kernel: EFLAGS: 00010246
Oct 28 21:23:47 dardhal kernel: EIP is at badness+0x5f/0xe4
Oct 28 21:23:47 dardhal kernel: eax: 00000158   ebx: 0054538e   ecx: 00000000   edx: 00000000
Oct 28 21:23:47 dardhal kernel: esi: 00000000   edi: 00000000   ebp: 00000158   esp: d4559d34
Oct 28 21:23:47 dardhal kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 21:23:47 dardhal kernel: Process MozillaFirebird (pid: 1662, threadinfo=d4558000 task=d455b980)
Oct 28 21:23:47 dardhal kernel: Stack: 00000000 c151d900 c151d900 00000000 00000000 c012f622 c151d900 004fc7cb 
Oct 28 21:23:47 dardhal kernel: 00000000 d4559e44 ffffffff c012f717 004fc7cb 00000000 d4559e44 ffffffff 
Oct 28 21:23:47 dardhal kernel: c012f809 d4559d8c c01358ce 0000000d 00000000 00000907 00000000 00000000 
Oct 28 21:23:47 dardhal kernel: Call Trace:
Oct 28 21:23:47 dardhal kernel: [<c012f622>] select_bad_process+0x2a/0x62
Oct 28 21:23:47 dardhal kernel: [<c012f717>] oom_kill+0x9/0x9b
Oct 28 21:23:47 dardhal kernel: [<c012f809>] out_of_memory+0x60/0x7f
Oct 28 21:23:47 dardhal kernel: [<c01358ce>] try_to_free_pages+0x115/0x13e
Oct 28 21:23:47 dardhal kernel: [<c01302bf>] __alloc_pages+0x1a0/0x2c0
Oct 28 21:23:47 dardhal kernel: [<c0131f4c>] do_page_cache_readahead+0xc3/0xeb
Oct 28 21:23:47 dardhal kernel: [<c012d97b>] filemap_nopage+0xb3/0x276
Oct 28 21:23:47 dardhal kernel: [<c0137fe6>] do_no_page+0x7d/0x2d8
Oct 28 21:23:47 dardhal kernel: [<c0138393>] handle_mm_fault+0x9b/0xe6
Oct 28 21:23:47 dardhal kernel: [<c01157de>] do_page_fault+0x108/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c0151342>] do_pollfd+0x7c/0x82
Oct 28 21:23:47 dardhal kernel: [<c0151311>] do_pollfd+0x4b/0x82
Oct 28 21:23:47 dardhal kernel: [<c0151397>] do_poll+0x4f/0xae
Oct 28 21:23:47 dardhal kernel: [<c0150a4c>] poll_freewait+0x37/0x3e
Oct 28 21:23:47 dardhal kernel: [<c0151617>] sys_poll+0x221/0x26a
Oct 28 21:23:47 dardhal kernel: [<c0150a53>] __pollwait+0x0/0x9a
Oct 28 21:23:47 dardhal kernel: [<c01156d6>] do_page_fault+0x0/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c0262e2f>] error_code+0x2f/0x38
Oct 28 21:23:47 dardhal kernel: 
Oct 28 21:23:47 dardhal kernel: Code: 00 e8 d7 d5 fe ff 89 c3 89 d6 8b 44 24 14 c1 ef 0d 2b 98 d0 01 00 00 1b b0 d4 01 00 00 57 e8 15 1e 06 00 89 c2 89 e8 89 d1 31 d2 <f7> f1 0f ac f3 14 53 89 c5 e8 ff 1d 06 00 89 04 24 e8 f7 1d 06 
Oct 28 21:23:47 dardhal kernel: divide error: 0000 [#15]
Oct 28 21:23:47 dardhal kernel: CPU:    0
Oct 28 21:23:47 dardhal kernel: EIP:    0060:[<c012f573>]    Tainted: PF  VLI
Oct 28 21:23:47 dardhal kernel: EFLAGS: 00210246
Oct 28 21:23:47 dardhal kernel: EIP is at badness+0x5f/0xe4
Oct 28 21:23:47 dardhal kernel: eax: 00000158   ebx: 0054674e   ecx: 00000000   edx: 00000000
Oct 28 21:23:47 dardhal kernel: esi: 00000000   edi: 00000000   ebp: 00000158   esp: dc3e3d34
Oct 28 21:23:47 dardhal kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 21:23:47 dardhal kernel: Process kdeinit (pid: 1552, threadinfo=dc3e2000 task=df38e6f0)
Oct 28 21:23:47 dardhal kernel: Stack: 00000000 c151d900 c151d900 00000000 00000000 c012f622 c151d900 004fdb8b 
Oct 28 21:23:47 dardhal kernel: 00000000 dc3e3e44 ffffffff c012f717 004fdb8b 00000000 dc3e3e44 ffffffff 
Oct 28 21:23:47 dardhal kernel: c012f809 dc3e3d8c c01358ce 00000000 00000000 000010a1 00000000 00000000 
Oct 28 21:23:47 dardhal kernel: Call Trace:
Oct 28 21:23:47 dardhal kernel: [<c012f622>] select_bad_process+0x2a/0x62
Oct 28 21:23:47 dardhal kernel: [<c012f717>] oom_kill+0x9/0x9b
Oct 28 21:23:47 dardhal kernel: [<c012f809>] out_of_memory+0x60/0x7f
Oct 28 21:23:47 dardhal kernel: [<c01358ce>] try_to_free_pages+0x115/0x13e
Oct 28 21:23:47 dardhal kernel: [<c01302bf>] __alloc_pages+0x1a0/0x2c0
Oct 28 21:23:47 dardhal kernel: [<c0131f4c>] do_page_cache_readahead+0xc3/0xeb
Oct 28 21:23:47 dardhal kernel: [<c012d97b>] filemap_nopage+0xb3/0x276
Oct 28 21:23:47 dardhal kernel: [<c0137fe6>] do_no_page+0x7d/0x2d8
Oct 28 21:23:47 dardhal kernel: [<c0138393>] handle_mm_fault+0x9b/0xe6
Oct 28 21:23:47 dardhal kernel: [<c01157de>] do_page_fault+0x108/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c0149f77>] sys_lstat64+0x25/0x29
Oct 28 21:23:47 dardhal kernel: [<c01156d6>] do_page_fault+0x0/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c0262e2f>] error_code+0x2f/0x38
Oct 28 21:23:47 dardhal kernel: 
Oct 28 21:23:47 dardhal kernel: Code: 00 e8 d7 d5 fe ff 89 c3 89 d6 8b 44 24 14 c1 ef 0d 2b 98 d0 01 00 00 1b b0 d4 01 00 00 57 e8 15 1e 06 00 89 c2 89 e8 89 d1 31 d2 <f7> f1 0f ac f3 14 53 89 c5 e8 ff 1d 06 00 89 04 24 e8 f7 1d 06 
Oct 28 21:23:47 dardhal kernel: divide error: 0000 [#16]
Oct 28 21:23:47 dardhal kernel: CPU:    0
Oct 28 21:23:47 dardhal kernel: EIP:    0060:[<c012f573>]    Tainted: PF  VLI
Oct 28 21:23:47 dardhal kernel: EFLAGS: 00010246
Oct 28 21:23:47 dardhal kernel: EIP is at badness+0x5f/0xe4
Oct 28 21:23:47 dardhal kernel: eax: 00000158   ebx: 00547ae7   ecx: 00000000   edx: 00000000
Oct 28 21:23:47 dardhal kernel: esi: 00000000   edi: 00000000   ebp: 00000158   esp: dab21d34
Oct 28 21:23:47 dardhal kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 21:23:47 dardhal kernel: Process kde3 (pid: 1482, threadinfo=dab20000 task=dd40f940)
Oct 28 21:23:47 dardhal kernel: Stack: 00000000 c151d900 c151d900 00000000 00000000 c012f622 c151d900 004fef24 
Oct 28 21:23:47 dardhal kernel: 00000000 dab21e44 ffffffff c012f717 004fef24 00000000 dab21e44 ffffffff 
Oct 28 21:23:47 dardhal kernel: c012f809 dab21d8c c01358ce 00000006 00000000 000003b3 00000000 00000000 
Oct 28 21:23:47 dardhal kernel: Call Trace:
Oct 28 21:23:47 dardhal kernel: [<c012f622>] select_bad_process+0x2a/0x62
Oct 28 21:23:47 dardhal kernel: [<c012f717>] oom_kill+0x9/0x9b
Oct 28 21:23:47 dardhal kernel: [<c012f809>] out_of_memory+0x60/0x7f
Oct 28 21:23:47 dardhal kernel: [<c01358ce>] try_to_free_pages+0x115/0x13e
Oct 28 21:23:47 dardhal kernel: [<c01302bf>] __alloc_pages+0x1a0/0x2c0
Oct 28 21:23:47 dardhal kernel: [<c0131f4c>] do_page_cache_readahead+0xc3/0xeb
Oct 28 21:23:47 dardhal kernel: [<c012d97b>] filemap_nopage+0xb3/0x276
Oct 28 21:23:47 dardhal kernel: [<c0137fe6>] do_no_page+0x7d/0x2d8
Oct 28 21:23:47 dardhal kernel: [<c0138393>] handle_mm_fault+0x9b/0xe6
Oct 28 21:23:47 dardhal kernel: [<c01157de>] do_page_fault+0x108/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c011bb2b>] wait_task_zombie+0xf9/0x156
Oct 28 21:23:47 dardhal kernel: [<c011651d>] recalc_task_prio+0x7a/0x149
Oct 28 21:23:47 dardhal kernel: [<c0117136>] schedule+0x2fd/0x501
Oct 28 21:23:47 dardhal kernel: [<c01156d6>] do_page_fault+0x0/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c0262e2f>] error_code+0x2f/0x38
Oct 28 21:23:47 dardhal kernel: 
Oct 28 21:23:47 dardhal kernel: Code: 00 e8 d7 d5 fe ff 89 c3 89 d6 8b 44 24 14 c1 ef 0d 2b 98 d0 01 00 00 1b b0 d4 01 00 00 57 e8 15 1e 06 00 89 c2 89 e8 89 d1 31 d2 <f7> f1 0f ac f3 14 53 89 c5 e8 ff 1d 06 00 89 04 24 e8 f7 1d 06 
Oct 28 21:23:47 dardhal kernel: divide error: 0000 [#17]
Oct 28 21:23:47 dardhal kernel: CPU:    0
Oct 28 21:23:47 dardhal kernel: EIP:    0060:[<c012f573>]    Tainted: PF  VLI
Oct 28 21:23:47 dardhal kernel: EFLAGS: 00010246
Oct 28 21:23:47 dardhal kernel: EIP is at badness+0x5f/0xe4
Oct 28 21:23:47 dardhal kernel: eax: 00000158   ebx: 00549574   ecx: 00000000   edx: 00000000
Oct 28 21:23:47 dardhal kernel: esi: 00000000   edi: 00000000   ebp: 00000158   esp: d165dd34
Oct 28 21:23:47 dardhal kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 21:23:47 dardhal kernel: Process kdesud (pid: 1610, threadinfo=d165c000 task=d2925310)
Oct 28 21:23:47 dardhal kernel: Stack: 00000000 c151d900 c151d900 00000000 00000000 c012f622 c151d900 005009b1 
Oct 28 21:23:47 dardhal kernel: 00000000 d165de44 ffffffff c012f717 005009b1 00000000 d165de44 ffffffff 
Oct 28 21:23:47 dardhal kernel: c012f809 d165dd8c c01358ce 00000014 00000000 000001d3 00000000 00000002 
Oct 28 21:23:47 dardhal kernel: Call Trace:
Oct 28 21:23:47 dardhal kernel: [<c012f622>] select_bad_process+0x2a/0x62
Oct 28 21:23:47 dardhal kernel: [<c012f717>] oom_kill+0x9/0x9b
Oct 28 21:23:47 dardhal kernel: [<c012f809>] out_of_memory+0x60/0x7f
Oct 28 21:23:47 dardhal kernel: [<c01358ce>] try_to_free_pages+0x115/0x13e
Oct 28 21:23:47 dardhal kernel: [<c01302bf>] __alloc_pages+0x1a0/0x2c0
Oct 28 21:23:47 dardhal kernel: [<c0131f4c>] do_page_cache_readahead+0xc3/0xeb
Oct 28 21:23:47 dardhal kernel: [<c012d97b>] filemap_nopage+0xb3/0x276
Oct 28 21:23:47 dardhal kernel: [<c0137fe6>] do_no_page+0x7d/0x2d8
Oct 28 21:23:47 dardhal kernel: [<c0138393>] handle_mm_fault+0x9b/0xe6
Oct 28 21:23:47 dardhal kernel: [<c01157de>] do_page_fault+0x108/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c0150a53>] __pollwait+0x0/0x9a
Oct 28 21:23:47 dardhal kernel: [<c011651d>] recalc_task_prio+0x7a/0x149
Oct 28 21:23:47 dardhal kernel: [<c015107a>] sys_select+0x22d/0x479
Oct 28 21:23:47 dardhal kernel: [<c0117136>] schedule+0x2fd/0x501
Oct 28 21:23:47 dardhal kernel: [<c01156d6>] do_page_fault+0x0/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c0262e2f>] error_code+0x2f/0x38
Oct 28 21:23:47 dardhal kernel: 
Oct 28 21:23:47 dardhal kernel: Code: 00 e8 d7 d5 fe ff 89 c3 89 d6 8b 44 24 14 c1 ef 0d 2b 98 d0 01 00 00 1b b0 d4 01 00 00 57 e8 15 1e 06 00 89 c2 89 e8 89 d1 31 d2 <f7> f1 0f ac f3 14 53 89 c5 e8 ff 1d 06 00 89 04 24 e8 f7 1d 06 
Oct 28 21:23:47 dardhal kernel: divide error: 0000 [#18]
Oct 28 21:23:47 dardhal kernel: CPU:    0
Oct 28 21:23:47 dardhal kernel: EIP:    0060:[<c012f573>]    Tainted: PF  VLI
Oct 28 21:23:47 dardhal kernel: EFLAGS: 00010246
Oct 28 21:23:47 dardhal kernel: EIP is at badness+0x5f/0xe4
Oct 28 21:23:47 dardhal kernel: eax: 00000158   ebx: 0054aa44   ecx: 00000000   edx: 00000000
Oct 28 21:23:47 dardhal kernel: esi: 00000000   edi: 00000000   ebp: 00000158   esp: db97fd34
Oct 28 21:23:47 dardhal kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 21:23:47 dardhal kernel: Process qmgr (pid: 1412, threadinfo=db97e000 task=df38ed20)
Oct 28 21:23:47 dardhal kernel: Stack: 00000000 c151d900 c151d900 00000000 00000000 c012f622 c151d900 00501e81 
Oct 28 21:23:47 dardhal kernel: 00000000 db97fe44 ffffffff c012f717 00501e81 00000000 db97fe44 ffffffff 
Oct 28 21:23:47 dardhal kernel: c012f809 db97fd8c c01358ce 00000008 00000000 0000077a 00000000 00000000 
Oct 28 21:23:47 dardhal kernel: Call Trace:
Oct 28 21:23:47 dardhal kernel: [<c012f622>] select_bad_process+0x2a/0x62
Oct 28 21:23:47 dardhal kernel: [<c012f717>] oom_kill+0x9/0x9b
Oct 28 21:23:47 dardhal kernel: [<c012f809>] out_of_memory+0x60/0x7f
Oct 28 21:23:47 dardhal kernel: [<c01358ce>] try_to_free_pages+0x115/0x13e
Oct 28 21:23:47 dardhal kernel: [<c01302bf>] __alloc_pages+0x1a0/0x2c0
Oct 28 21:23:47 dardhal kernel: [<c0131f4c>] do_page_cache_readahead+0xc3/0xeb
Oct 28 21:23:47 dardhal kernel: [<c012d97b>] filemap_nopage+0xb3/0x276
Oct 28 21:23:47 dardhal kernel: [<c0137fe6>] do_no_page+0x7d/0x2d8
Oct 28 21:23:47 dardhal kernel: [<c0138393>] handle_mm_fault+0x9b/0xe6
Oct 28 21:23:47 dardhal kernel: [<c01157de>] do_page_fault+0x108/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c016e42c>] free_rb_tree_fname+0x43/0x75
Oct 28 21:23:47 dardhal kernel: [<c014366e>] __fput+0x91/0xdf
Oct 28 21:23:47 dardhal kernel: [<c014233f>] filp_close+0x42/0x64
Oct 28 21:23:47 dardhal kernel: [<c01156d6>] do_page_fault+0x0/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c0262e2f>] error_code+0x2f/0x38
Oct 28 21:23:47 dardhal kernel: 
Oct 28 21:23:47 dardhal kernel: Code: 00 e8 d7 d5 fe ff 89 c3 89 d6 8b 44 24 14 c1 ef 0d 2b 98 d0 01 00 00 1b b0 d4 01 00 00 57 e8 15 1e 06 00 89 c2 89 e8 89 d1 31 d2 <f7> f1 0f ac f3 14 53 89 c5 e8 ff 1d 06 00 89 04 24 e8 f7 1d 06 
Oct 28 21:23:47 dardhal kernel: divide error: 0000 [#19]
Oct 28 21:23:47 dardhal kernel: CPU:    0
Oct 28 21:23:47 dardhal kernel: EIP:    0060:[<c012f573>]    Tainted: PF  VLI
Oct 28 21:23:47 dardhal kernel: EFLAGS: 00010246
Oct 28 21:23:47 dardhal kernel: EIP is at badness+0x5f/0xe4
Oct 28 21:23:47 dardhal kernel: eax: 00000158   ebx: 0054bdfd   ecx: 00000000   edx: 00000000
Oct 28 21:23:47 dardhal kernel: esi: 00000000   edi: 00000000   ebp: 00000158   esp: d13d3d90
Oct 28 21:23:47 dardhal kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 21:23:47 dardhal kernel: Process xmms (pid: 1627, threadinfo=d13d2000 task=d13d5980)
Oct 28 21:23:47 dardhal kernel: Stack: 00000000 c151d900 c151d900 00000000 00000000 c012f622 c151d900 0050323a 
Oct 28 21:23:47 dardhal kernel: 00000000 d13d3ea0 ffffffff c012f717 0050323a 00000000 d13d3ea0 ffffffff 
Oct 28 21:23:47 dardhal kernel: c012f809 d13d3de8 c01358ce 00000000 00000000 0000098d 00000000 00000000 
Oct 28 21:23:47 dardhal kernel: Call Trace:
Oct 28 21:23:47 dardhal kernel: [<c012f622>] select_bad_process+0x2a/0x62
Oct 28 21:23:47 dardhal kernel: [<c012f717>] oom_kill+0x9/0x9b
Oct 28 21:23:47 dardhal kernel: [<c012f809>] out_of_memory+0x60/0x7f
Oct 28 21:23:47 dardhal kernel: [<c01358ce>] try_to_free_pages+0x115/0x13e
Oct 28 21:23:47 dardhal kernel: [<c01302bf>] __alloc_pages+0x1a0/0x2c0
Oct 28 21:23:47 dardhal kernel: [<c01303fe>] __get_free_pages+0x1f/0x41
Oct 28 21:23:47 dardhal kernel: [<c0150a86>] __pollwait+0x33/0x9a
Oct 28 21:23:47 dardhal kernel: [<c025f470>] unix_poll+0x1f/0x8b
Oct 28 21:23:47 dardhal kernel: [<c0213c41>] sock_poll+0x19/0x1d
Oct 28 21:23:47 dardhal kernel: [<c0150e2f>] do_select+0x27a/0x280
Oct 28 21:23:47 dardhal kernel: [<c0150a53>] __pollwait+0x0/0x9a
Oct 28 21:23:47 dardhal kernel: [<c01510f0>] sys_select+0x2a3/0x479
Oct 28 21:23:47 dardhal kernel: [<c010b7ea>] handle_IRQ_event+0x27/0x4c
Oct 28 21:23:47 dardhal kernel: [<c010ba64>] do_IRQ+0x86/0xd0
Oct 28 21:23:47 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:23:47 dardhal kernel: 
Oct 28 21:23:47 dardhal kernel: Code: 00 e8 d7 d5 fe ff 89 c3 89 d6 8b 44 24 14 c1 ef 0d 2b 98 d0 01 00 00 1b b0 d4 01 00 00 57 e8 15 1e 06 00 89 c2 89 e8 89 d1 31 d2 <f7> f1 0f ac f3 14 53 89 c5 e8 ff 1d 06 00 89 04 24 e8 f7 1d 06 
Oct 28 21:23:47 dardhal kernel: divide error: 0000 [#20]
Oct 28 21:23:47 dardhal kernel: CPU:    0
Oct 28 21:23:47 dardhal kernel: EIP:    0060:[<c012f573>]    Tainted: PF  VLI
Oct 28 21:23:47 dardhal kernel: EFLAGS: 00010246
Oct 28 21:23:47 dardhal kernel: EIP is at badness+0x5f/0xe4
Oct 28 21:23:47 dardhal kernel: eax: 00000158   ebx: 0054d1c5   ecx: 00000000   edx: 00000000
Oct 28 21:23:47 dardhal kernel: esi: 00000000   edi: 00000000   ebp: 00000158   esp: d9a35d34
Oct 28 21:23:47 dardhal kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 21:23:47 dardhal kernel: Process aterm (pid: 1535, threadinfo=d9a34000 task=dd40e6b0)
Oct 28 21:23:47 dardhal kernel: Stack: 00000000 c151d900 c151d900 00000000 00000000 c012f622 c151d900 00504602 
Oct 28 21:23:47 dardhal kernel: 00000000 d9a35e44 ffffffff c012f717 00504602 00000000 d9a35e44 ffffffff 
Oct 28 21:23:47 dardhal kernel: c012f809 d9a35d8c c01358ce 00000000 00000000 000005b7 00000000 00000000 
Oct 28 21:23:47 dardhal kernel: Call Trace:
Oct 28 21:23:47 dardhal kernel: [<c012f622>] select_bad_process+0x2a/0x62
Oct 28 21:23:47 dardhal kernel: [<c012f717>] oom_kill+0x9/0x9b
Oct 28 21:23:47 dardhal kernel: [<c012f809>] out_of_memory+0x60/0x7f
Oct 28 21:23:47 dardhal kernel: [<c01358ce>] try_to_free_pages+0x115/0x13e
Oct 28 21:23:47 dardhal kernel: [<c01302bf>] __alloc_pages+0x1a0/0x2c0
Oct 28 21:23:47 dardhal kernel: [<c0131f4c>] do_page_cache_readahead+0xc3/0xeb
Oct 28 21:23:47 dardhal kernel: [<c012d97b>] filemap_nopage+0xb3/0x276
Oct 28 21:23:47 dardhal kernel: [<c0137fe6>] do_no_page+0x7d/0x2d8
Oct 28 21:23:47 dardhal kernel: [<c0138393>] handle_mm_fault+0x9b/0xe6
Oct 28 21:23:47 dardhal kernel: [<c01157de>] do_page_fault+0x108/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c011ffdf>] update_process_times+0x29/0x2f
Oct 28 21:23:47 dardhal kernel: [<c011651d>] recalc_task_prio+0x7a/0x149
Oct 28 21:23:47 dardhal kernel: [<c0117136>] schedule+0x2fd/0x501
Oct 28 21:23:47 dardhal kernel: [<c01156d6>] do_page_fault+0x0/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c0262e2f>] error_code+0x2f/0x38
Oct 28 21:23:47 dardhal kernel: 
Oct 28 21:23:47 dardhal kernel: Code: 00 e8 d7 d5 fe ff 89 c3 89 d6 8b 44 24 14 c1 ef 0d 2b 98 d0 01 00 00 1b b0 d4 01 00 00 57 e8 15 1e 06 00 89 c2 89 e8 89 d1 31 d2 <f7> f1 0f ac f3 14 53 89 c5 e8 ff 1d 06 00 89 04 24 e8 f7 1d 06 
Oct 28 21:23:47 dardhal kernel: divide error: 0000 [#21]
Oct 28 21:23:47 dardhal kernel: CPU:    0
Oct 28 21:23:47 dardhal kernel: EIP:    0060:[<c012f573>]    Tainted: PF  VLI
Oct 28 21:23:47 dardhal kernel: EFLAGS: 00010246
Oct 28 21:23:47 dardhal kernel: EIP is at badness+0x5f/0xe4
Oct 28 21:23:47 dardhal kernel: eax: 00000158   ebx: 0054e58a   ecx: 00000000   edx: 00000000
Oct 28 21:23:47 dardhal kernel: esi: 00000000   edi: 00000000   ebp: 00000158   esp: dd189d34
Oct 28 21:23:47 dardhal kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 21:23:47 dardhal kernel: Process bash (pid: 1545, threadinfo=dd188000 task=db992670)
Oct 28 21:23:47 dardhal kernel: Stack: 00000000 c151d900 c151d900 00000000 00000000 c012f622 c151d900 005059c7 
Oct 28 21:23:47 dardhal kernel: 00000000 dd189e44 ffffffff c012f717 005059c7 00000000 dd189e44 ffffffff 
Oct 28 21:23:47 dardhal kernel: c012f809 dd189d8c c01358ce 00000010 00000000 0000064b 00000000 00000001 
Oct 28 21:23:47 dardhal kernel: Call Trace:
Oct 28 21:23:47 dardhal kernel: [<c012f622>] select_bad_process+0x2a/0x62
Oct 28 21:23:47 dardhal kernel: [<c012f717>] oom_kill+0x9/0x9b
Oct 28 21:23:47 dardhal kernel: [<c012f809>] out_of_memory+0x60/0x7f
Oct 28 21:23:47 dardhal kernel: [<c01358ce>] try_to_free_pages+0x115/0x13e
Oct 28 21:23:47 dardhal kernel: [<c01302bf>] __alloc_pages+0x1a0/0x2c0
Oct 28 21:23:47 dardhal kernel: [<c0131f4c>] do_page_cache_readahead+0xc3/0xeb
Oct 28 21:23:47 dardhal kernel: [<c012d97b>] filemap_nopage+0xb3/0x276
Oct 28 21:23:47 dardhal kernel: [<c0137fe6>] do_no_page+0x7d/0x2d8
Oct 28 21:23:47 dardhal kernel: [<c0138393>] handle_mm_fault+0x9b/0xe6
Oct 28 21:23:47 dardhal kernel: [<c01157de>] do_page_fault+0x108/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c01cfc74>] tty_read+0xb7/0xe0
Oct 28 21:23:47 dardhal kernel: [<c014297c>] vfs_read+0x89/0xc7
Oct 28 21:23:47 dardhal kernel: [<c0142b80>] sys_read+0x2b/0x45
Oct 28 21:23:47 dardhal kernel: [<c01156d6>] do_page_fault+0x0/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c0262e2f>] error_code+0x2f/0x38
Oct 28 21:23:47 dardhal kernel: 
Oct 28 21:23:47 dardhal kernel: Code: 00 e8 d7 d5 fe ff 89 c3 89 d6 8b 44 24 14 c1 ef 0d 2b 98 d0 01 00 00 1b b0 d4 01 00 00 57 e8 15 1e 06 00 89 c2 89 e8 89 d1 31 d2 <f7> f1 0f ac f3 14 53 89 c5 e8 ff 1d 06 00 89 04 24 e8 f7 1d 06 
Oct 28 21:23:47 dardhal kernel: divide error: 0000 [#22]
Oct 28 21:23:47 dardhal kernel: CPU:    0
Oct 28 21:23:47 dardhal kernel: EIP:    0060:[<c012f573>]    Tainted: PF  VLI
Oct 28 21:23:47 dardhal kernel: EFLAGS: 00010246
Oct 28 21:23:47 dardhal kernel: EIP is at badness+0x5f/0xe4
Oct 28 21:23:47 dardhal kernel: eax: 00000158   ebx: 0054fa96   ecx: 00000000   edx: 00000000
Oct 28 21:23:47 dardhal kernel: esi: 00000000   edi: 00000000   ebp: 00000158   esp: dea45d34
Oct 28 21:23:47 dardhal kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 21:23:47 dardhal kernel: Process master (pid: 448, threadinfo=dea44000 task=df38e0c0)
Oct 28 21:23:47 dardhal kernel: Stack: 00000000 c151d900 c151d900 00000000 00000000 c012f622 c151d900 00506ed3 
Oct 28 21:23:47 dardhal kernel: 00000000 dea45e44 ffffffff c012f717 00506ed3 00000000 dea45e44 ffffffff 
Oct 28 21:23:47 dardhal kernel: c012f809 dea45d8c c01358ce 0000001a 00000000 0000018e 00000000 0000000a 
Oct 28 21:23:47 dardhal kernel: Call Trace:
Oct 28 21:23:47 dardhal kernel: [<c012f622>] select_bad_process+0x2a/0x62
Oct 28 21:23:47 dardhal kernel: [<c012f717>] oom_kill+0x9/0x9b
Oct 28 21:23:47 dardhal kernel: [<c012f809>] out_of_memory+0x60/0x7f
Oct 28 21:23:47 dardhal kernel: [<c01358ce>] try_to_free_pages+0x115/0x13e
Oct 28 21:23:47 dardhal kernel: [<c01302bf>] __alloc_pages+0x1a0/0x2c0
Oct 28 21:23:47 dardhal kernel: [<c0131f4c>] do_page_cache_readahead+0xc3/0xeb
Oct 28 21:23:47 dardhal kernel: [<c012d97b>] filemap_nopage+0xb3/0x276
Oct 28 21:23:47 dardhal kernel: [<c0137fe6>] do_no_page+0x7d/0x2d8
Oct 28 21:23:47 dardhal kernel: [<c0138393>] handle_mm_fault+0x9b/0xe6
Oct 28 21:23:47 dardhal kernel: [<c01157de>] do_page_fault+0x108/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c011be5b>] sys_wait4+0x1a2/0x213
Oct 28 21:23:47 dardhal kernel: [<c011651d>] recalc_task_prio+0x7a/0x149
Oct 28 21:23:47 dardhal kernel: [<c0117136>] schedule+0x2fd/0x501
Oct 28 21:23:47 dardhal kernel: [<c01156d6>] do_page_fault+0x0/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c0262e2f>] error_code+0x2f/0x38
Oct 28 21:23:47 dardhal kernel: 
Oct 28 21:23:47 dardhal kernel: Code: 00 e8 d7 d5 fe ff 89 c3 89 d6 8b 44 24 14 c1 ef 0d 2b 98 d0 01 00 00 1b b0 d4 01 00 00 57 e8 15 1e 06 00 89 c2 89 e8 89 d1 31 d2 <f7> f1 0f ac f3 14 53 89 c5 e8 ff 1d 06 00 89 04 24 e8 f7 1d 06 
Oct 28 21:23:47 dardhal kernel: divide error: 0000 [#23]
Oct 28 21:23:47 dardhal kernel: CPU:    0
Oct 28 21:23:47 dardhal kernel: EIP:    0060:[<c012f573>]    Tainted: PF  VLI
Oct 28 21:23:47 dardhal kernel: EFLAGS: 00010246
Oct 28 21:23:47 dardhal kernel: EIP is at badness+0x5f/0xe4
Oct 28 21:23:47 dardhal kernel: eax: 00000158   ebx: 00550e58   ecx: 00000000   edx: 00000000
Oct 28 21:23:47 dardhal kernel: esi: 00000000   edi: 00000000   ebp: 00000158   esp: d94bbd34
Oct 28 21:23:47 dardhal kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 21:23:47 dardhal kernel: Process kdeinit (pid: 1517, threadinfo=d94ba000 task=d903b900)
Oct 28 21:23:47 dardhal kernel: Stack: 00000000 c151d900 c151d900 00000000 00000000 c012f622 c151d900 00508295 
Oct 28 21:23:47 dardhal kernel: 00000000 d94bbe44 ffffffff c012f717 00508295 00000000 d94bbe44 ffffffff 
Oct 28 21:23:47 dardhal kernel: c012f809 d94bbd8c c01358ce 00000001 00000000 00000e08 00000000 00000000 
Oct 28 21:23:47 dardhal kernel: Call Trace:
Oct 28 21:23:47 dardhal kernel: [<c012f622>] select_bad_process+0x2a/0x62
Oct 28 21:23:47 dardhal kernel: [<c012f717>] oom_kill+0x9/0x9b
Oct 28 21:23:47 dardhal kernel: [<c012f809>] out_of_memory+0x60/0x7f
Oct 28 21:23:47 dardhal kernel: [<c01358ce>] try_to_free_pages+0x115/0x13e
Oct 28 21:23:47 dardhal kernel: [<c01302bf>] __alloc_pages+0x1a0/0x2c0
Oct 28 21:23:47 dardhal kernel: [<c0131f4c>] do_page_cache_readahead+0xc3/0xeb
Oct 28 21:23:47 dardhal kernel: [<c012d97b>] filemap_nopage+0xb3/0x276
Oct 28 21:23:47 dardhal kernel: [<c0137fe6>] do_no_page+0x7d/0x2d8
Oct 28 21:23:47 dardhal kernel: [<c0138393>] handle_mm_fault+0x9b/0xe6
Oct 28 21:23:47 dardhal kernel: [<c01157de>] do_page_fault+0x108/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c01f346d>] ide_do_request+0x17d/0x2a9
Oct 28 21:23:47 dardhal kernel: [<c01f3940>] ide_intr+0xbe/0xf3
Oct 28 21:23:47 dardhal kernel: [<c01fe752>] ide_dma_intr+0x0/0x7f
Oct 28 21:23:47 dardhal kernel: [<c010b7ea>] handle_IRQ_event+0x27/0x4c
Oct 28 21:23:47 dardhal kernel: [<c010baa9>] do_IRQ+0xcb/0xd0
Oct 28 21:23:47 dardhal kernel: [<c01156d6>] do_page_fault+0x0/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c0262e2f>] error_code+0x2f/0x38
Oct 28 21:23:47 dardhal kernel: 
Oct 28 21:23:47 dardhal kernel: Code: 00 e8 d7 d5 fe ff 89 c3 89 d6 8b 44 24 14 c1 ef 0d 2b 98 d0 01 00 00 1b b0 d4 01 00 00 57 e8 15 1e 06 00 89 c2 89 e8 89 d1 31 d2 <f7> f1 0f ac f3 14 53 89 c5 e8 ff 1d 06 00 89 04 24 e8 f7 1d 06 
Oct 28 21:23:47 dardhal kernel: divide error: 0000 [#24]
Oct 28 21:23:47 dardhal kernel: CPU:    0
Oct 28 21:23:47 dardhal kernel: EIP:    0060:[<c012f573>]    Tainted: PF  VLI
Oct 28 21:23:47 dardhal kernel: EFLAGS: 00010246
Oct 28 21:23:47 dardhal kernel: EIP is at badness+0x5f/0xe4
Oct 28 21:23:47 dardhal kernel: eax: 00000158   ebx: 00552529   ecx: 00000000   edx: 00000000
Oct 28 21:23:47 dardhal kernel: esi: 00000000   edi: 00000000   ebp: 00000158   esp: c22b1d34
Oct 28 21:23:47 dardhal kernel: ds: 007b   es: 007b   ss: 0068
Oct 28 21:23:47 dardhal kernel: Process awk (pid: 9848, threadinfo=c22b0000 task=cb29c670)
Oct 28 21:23:47 dardhal kernel: Stack: 00000000 c151d900 c151d900 00000000 00000000 c012f622 c151d900 00509966 
Oct 28 21:23:47 dardhal kernel: 00000000 c22b1e44 ffffffff c012f717 00509966 00000000 c22b1e44 ffffffff 
Oct 28 21:23:47 dardhal kernel: c012f809 c22b1d8c c01358ce 00000015 00000000 0000082a 00000000 00000005 
Oct 28 21:23:47 dardhal kernel: Call Trace:
Oct 28 21:23:47 dardhal kernel: [<c012f622>] select_bad_process+0x2a/0x62
Oct 28 21:23:47 dardhal kernel: [<c012f717>] oom_kill+0x9/0x9b
Oct 28 21:23:47 dardhal kernel: [<c012f809>] out_of_memory+0x60/0x7f
Oct 28 21:23:47 dardhal kernel: [<c01358ce>] try_to_free_pages+0x115/0x13e
Oct 28 21:23:47 dardhal kernel: [<c01302bf>] __alloc_pages+0x1a0/0x2c0
Oct 28 21:23:47 dardhal kernel: [<c0131f4c>] do_page_cache_readahead+0xc3/0xeb
Oct 28 21:23:47 dardhal kernel: [<c012d97b>] filemap_nopage+0xb3/0x276
Oct 28 21:23:47 dardhal kernel: [<c0137fe6>] do_no_page+0x7d/0x2d8
Oct 28 21:23:47 dardhal kernel: [<c0138393>] handle_mm_fault+0x9b/0xe6
Oct 28 21:23:47 dardhal kernel: [<c01157de>] do_page_fault+0x108/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c014db01>] open_namei+0x8c/0x39c
Oct 28 21:23:47 dardhal kernel: [<c0141f13>] filp_open+0x31/0x50
Oct 28 21:23:47 dardhal kernel: [<c01156d6>] do_page_fault+0x0/0x4a2
Oct 28 21:23:47 dardhal kernel: [<c0262e2f>] error_code+0x2f/0x38
Oct 28 21:23:47 dardhal kernel: 
Oct 28 21:23:47 dardhal kernel: Code: 00 e8 d7 d5 fe ff 89 c3 89 d6 8b 44 24 14 c1 ef 0d 2b 98 d0 01 00 00 1b b0 d4 01 00 00 57 e8 15 1e 06 00 89 c2 89 e8 89 d1 31 d2 <f7> f1 0f ac f3 14 53 89 c5 e8 ff 1d 06 00 89 04 24 e8 f7 1d 06 
Oct 28 21:24:26 dardhal kernel: <4>IN=ppp0 OUT= MAC= SRC=213.0.153.172 DST=213.0.150.151 LEN=48 TOS=0x00 PREC=0x00 TTL=121 ID=5575 DF PROTO=TCP SPT=3458 DPT=135 WINDOW=8760 RES=0x00 SYN URGP=0 
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c012379f>] sys_rt_sigaction+0xb9/0xd9
Oct 28 21:24:32 dardhal kernel: [<c0127f59>] nanosleep_wake_up+0x0/0x9
Oct 28 21:24:32 dardhal kernel: [<c0127fdb>] sys_nanosleep+0x68/0xcb
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: racoon        S DD411ED4   532      1           587   470 (NOTLB)
Oct 28 21:24:32 dardhal kernel: dd411ecc 00000082 df1fbad8 dd411ed4 00000246 00001257 a4d9750c 0000051a 
Oct 28 21:24:32 dardhal kernel: dec0a040 00518336 dd411ed4 00004000 00000000 c0120346 d4547f38 c02b6bd8 
Oct 28 21:24:32 dardhal kernel: 00518336 4b87ad6e c01202e5 dec0a040 c02b61a0 dd411f48 dada5c80 00000000 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c0120346>] schedule_timeout+0x58/0x9f
Oct 28 21:24:32 dardhal kernel: [<c01202e5>] process_timeout+0x0/0x9
Oct 28 21:24:32 dardhal kernel: [<c0150d1b>] do_select+0x166/0x280
Oct 28 21:24:32 dardhal kernel: [<c0150a53>] __pollwait+0x0/0x9a
Oct 28 21:24:32 dardhal kernel: [<c01510f0>] sys_select+0x2a3/0x479
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: vmnet-bridge  S DC8D5C00   587      1           607   532 (NOTLB)
Oct 28 21:24:32 dardhal kernel: dd50ffb8 00000086 c014233f dc8d5c00 dd40e6b0 0001543b efe42d9e 0000000b 
Oct 28 21:24:32 dardhal kernel: dd5b3350 40136020 40135ec0 40135ec0 dd50e000 c012384a c0262423 40136020 
Oct 28 21:24:32 dardhal kernel: 401395d0 00000000 40135ec0 40135ec0 bffffd78 0000001d 0000007b 0000007b 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c014233f>] filp_close+0x42/0x64
Oct 28 21:24:32 dardhal kernel: [<c012384a>] sys_pause+0x14/0x1a
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: vmnet-netifup S DC8D59C0   607      1           623   587 (NOTLB)
Oct 28 21:24:32 dardhal kernel: db9b5fb8 00000086 c014233f dc8d59c0 dd40e6b0 00014de9 f4d7b7b7 0000000b 
Oct 28 21:24:32 dardhal kernel: dd5b20c0 40136020 40135ec0 40135ec0 db9b4000 c012384a c0262423 40136020 
Oct 28 21:24:32 dardhal kernel: 401395d0 00000000 40135ec0 40135ec0 bffffd78 0000001d 0000007b 0000007b 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c014233f>] filp_close+0x42/0x64
Oct 28 21:24:32 dardhal kernel: [<c012384a>] sys_pause+0x14/0x1a
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: vmnet-natd    S 00000145   623      1           744   607 (NOTLB)
Oct 28 21:24:32 dardhal kernel: db97bf30 00000082 ded6b800 00000145 d6568670 000011c4 b169b60a 000003e9 
Oct 28 21:24:32 dardhal kernel: db9932d0 00000000 7fffffff db97bfa0 dea93be0 c012038b db9a2f00 c0151311 
Oct 28 21:24:32 dardhal kernel: dea93be0 7fffffff db97bfa0 dea93be0 c0151397 00000003 00000000 7fffffff 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c012038b>] schedule_timeout+0x9d/0x9f
Oct 28 21:24:32 dardhal kernel: [<c0151311>] do_pollfd+0x4b/0x82
Oct 28 21:24:32 dardhal kernel: [<c0151397>] do_poll+0x4f/0xae
Oct 28 21:24:32 dardhal kernel: [<c01513d8>] do_poll+0x90/0xae
Oct 28 21:24:32 dardhal kernel: [<c015156d>] sys_poll+0x177/0x26a
Oct 28 21:24:32 dardhal kernel: [<c0150a53>] __pollwait+0x0/0x9a
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: vmnet-dhcpd   S 00000246   744      1           962   623 (NOTLB)
Oct 28 21:24:32 dardhal kernel: db9dbecc 00000086 df08c3c0 00000246 dd40e6b0 0002bb12 02229674 0000000c 
Oct 28 21:24:32 dardhal kernel: dd5b26f0 db9a29c0 7fffffff 00000080 00000000 c012038b e0a77440 df08c3c0 
Oct 28 21:24:32 dardhal kernel: db9a29c0 db9dbf48 00000001 00000000 dea939d8 fffffff2 db9a29c0 00000000 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c012038b>] schedule_timeout+0x9d/0x9f
Oct 28 21:24:32 dardhal kernel: [<e0a77440>] VNetFileOpPoll+0x3c/0x44 [vmnet]
Oct 28 21:24:32 dardhal kernel: [<c0150d1b>] do_select+0x166/0x280
Oct 28 21:24:32 dardhal kernel: [<c0150a53>] __pollwait+0x0/0x9a
Oct 28 21:24:32 dardhal kernel: [<c01510f0>] sys_select+0x2a3/0x479
Oct 28 21:24:32 dardhal kernel: [<c014366e>] __fput+0x91/0xdf
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: bash          S C140E9D0   962      1           963   744 (NOTLB)
Oct 28 21:24:32 dardhal kernel: db9fdea8 00000082 c012d93e c140e9d0 c012da78 00002c52 acb67781 0000051a 
Oct 28 21:24:32 dardhal kernel: dd5b2d20 00000008 7fffffff db9fdf38 dfde0000 c012038b c01380c5 daa5d540 
Oct 28 21:24:32 dardhal kernel: 00000000 c16168ac dd5db080 00000000 000002b0 00000246 00000008 00000001 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c012d93e>] filemap_nopage+0x76/0x276
Oct 28 21:24:32 dardhal kernel: [<c012da78>] filemap_nopage+0x1b0/0x276
Oct 28 21:24:32 dardhal kernel: [<c012038b>] schedule_timeout+0x9d/0x9f
Oct 28 21:24:32 dardhal kernel: [<c01380c5>] do_no_page+0x15c/0x2d8
Oct 28 21:24:32 dardhal kernel: [<c01d3c48>] read_chan+0x24f/0x7b4
Oct 28 21:24:32 dardhal kernel: [<c0138393>] handle_mm_fault+0x9b/0xe6
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c01cfc74>] tty_read+0xb7/0xe0
Oct 28 21:24:32 dardhal kernel: [<c014297c>] vfs_read+0x89/0xc7
Oct 28 21:24:32 dardhal kernel: [<c0142b80>] sys_read+0x2b/0x45
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: getty         S DB98B1FC   963      1           964   962 (NOTLB)
Oct 28 21:24:32 dardhal kernel: dd5b1ea8 00000082 00000001 db98b1fc dea3e080 00018d1d 5f9560c5 0000000c 
Oct 28 21:24:32 dardhal kernel: dd5b3980 00000008 7fffffff dd5b1f38 dd5be000 c012038b dd5be000 00000246 
Oct 28 21:24:32 dardhal kernel: 00000008 dd5be000 c01df2bb dd5be000 dd5be000 00000246 00000008 00000001 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c012038b>] schedule_timeout+0x9d/0x9f
Oct 28 21:24:32 dardhal kernel: [<c01df2bb>] con_write+0x20/0x28
Oct 28 21:24:32 dardhal kernel: [<c01d3c48>] read_chan+0x24f/0x7b4
Oct 28 21:24:32 dardhal kernel: [<c01d4376>] write_chan+0x1c9/0x1ed
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c01cfc74>] tty_read+0xb7/0xe0
Oct 28 21:24:32 dardhal kernel: [<c014297c>] vfs_read+0x89/0xc7
Oct 28 21:24:32 dardhal kernel: [<c0142b80>] sys_read+0x2b/0x45
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: getty         S DD4021FC   964      1          1210   963 (NOTLB)
Oct 28 21:24:32 dardhal kernel: dc9e5ea8 00000082 00000001 dd4021fc dd5b2d20 000108eb 5f9669b0 0000000c 
Oct 28 21:24:32 dardhal kernel: dea3e080 00000008 7fffffff dc9e5f38 dd55d000 c012038b dd55d000 00000246 
Oct 28 21:24:32 dardhal kernel: 00000008 dd55d000 c01df2bb dd55d000 dd55d000 00000246 00000008 00000001 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c012038b>] schedule_timeout+0x9d/0x9f
Oct 28 21:24:32 dardhal kernel: [<c01df2bb>] con_write+0x20/0x28
Oct 28 21:24:32 dardhal kernel: [<c01d3c48>] read_chan+0x24f/0x7b4
Oct 28 21:24:32 dardhal kernel: [<c01d4376>] write_chan+0x1c9/0x1ed
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c01cfc74>] tty_read+0xb7/0xe0
Oct 28 21:24:32 dardhal kernel: [<c014297c>] vfs_read+0x89/0xc7
Oct 28 21:24:32 dardhal kernel: [<c0142b80>] sys_read+0x2b/0x45
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: pppd          S D9EA7ED4  1210      1          1496   964 (NOTLB)
Oct 28 21:24:32 dardhal kernel: d9ea7ecc 00000082 00000010 d9ea7ed4 00000246 00000474 b0a41609 00000522 
Oct 28 21:24:32 dardhal kernel: d9ea9940 0051bbc2 d9ea7ed4 00000020 00000000 c0120346 c02b6bd8 e08f1ae8 
Oct 28 21:24:32 dardhal kernel: 0051bbc2 4b87ad6e c01202e5 d9ea9940 c02b61a0 dcd13380 dcd13380 00000000 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c0120346>] schedule_timeout+0x58/0x9f
Oct 28 21:24:32 dardhal kernel: [<c01202e5>] process_timeout+0x0/0x9
Oct 28 21:24:32 dardhal kernel: [<c0150d1b>] do_select+0x166/0x280
Oct 28 21:24:32 dardhal kernel: [<c0150a53>] __pollwait+0x0/0x9a
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c01510f0>] sys_select+0x2a3/0x479
Oct 28 21:24:32 dardhal kernel: [<c0122a73>] sigprocmask+0x3d/0x96
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: kdeinit       S 0000051A  1493      1          1666  1500 (NOTLB)
Oct 28 21:24:32 dardhal kernel: d7173ecc 00000086 d4bc0cee 0000051a da769310 000010e7 e4190fb1 0000051a 
Oct 28 21:24:32 dardhal kernel: da768ce0 def27ec0 7fffffff 00000100 00000000 c012038b def27ec0 db631998 
Oct 28 21:24:32 dardhal kernel: d7173f48 def27ec0 c0213c41 def27ec0 db631980 00000000 def27ec0 00000000 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c012038b>] schedule_timeout+0x9d/0x9f
Oct 28 21:24:32 dardhal kernel: [<c0213c41>] sock_poll+0x19/0x1d
Oct 28 21:24:32 dardhal kernel: [<c0150d1b>] do_select+0x166/0x280
Oct 28 21:24:32 dardhal kernel: [<c0150a53>] __pollwait+0x0/0x9a
Oct 28 21:24:32 dardhal kernel: [<c01510f0>] sys_select+0x2a3/0x479
Oct 28 21:24:32 dardhal kernel: [<c011bedf>] sys_waitpid+0x13/0x17
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: kdeinit       S 0000051B  1496      1          1500  1210 (NOTLB)
Oct 28 21:24:32 dardhal kernel: d717fecc 00000082 0002f4bc 0000051b c151d900 000000d2 0008e418 0000051b 
Oct 28 21:24:32 dardhal kernel: d9ea8ce0 def27380 7fffffff 00000040 00000000 c012038b da003240 def27380 
Oct 28 21:24:32 dardhal kernel: c014bf98 def27200 c0213c41 def27200 def27380 00000000 def27380 00000000 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c012038b>] schedule_timeout+0x9d/0x9f
Oct 28 21:24:32 dardhal kernel: [<c014bf98>] pipe_poll+0x23/0x62
Oct 28 21:24:32 dardhal kernel: [<c0213c41>] sock_poll+0x19/0x1d
Oct 28 21:24:32 dardhal kernel: [<c0150d1b>] do_select+0x166/0x280
Oct 28 21:24:32 dardhal kernel: [<c0150a53>] __pollwait+0x0/0x9a
Oct 28 21:24:32 dardhal kernel: [<c01510f0>] sys_select+0x2a3/0x479
Oct 28 21:24:32 dardhal kernel: [<c014366e>] __fput+0x91/0xdf
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: kdeinit       S 0000051B  1500      1          1493  1496 (NOTLB)
Oct 28 21:24:32 dardhal kernel: d7177ecc 00000082 00085444 0000051b d9ea8ce0 000028f0 0008dbe2 0000051b 
Oct 28 21:24:32 dardhal kernel: da769310 dc5602c0 7fffffff 00000800 00000000 c012038b dc5602c0 da03d7d8 
Oct 28 21:24:32 dardhal kernel: d7177f48 dc5602c0 c0213c41 dc5602c0 da03d7c0 d7177f48 dc5602c0 00000000 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c012038b>] schedule_timeout+0x9d/0x9f
Oct 28 21:24:32 dardhal kernel: [<c0213c41>] sock_poll+0x19/0x1d
Oct 28 21:24:32 dardhal kernel: [<c0150d1b>] do_select+0x166/0x280
Oct 28 21:24:32 dardhal kernel: [<c0150a53>] __pollwait+0x0/0x9a
Oct 28 21:24:32 dardhal kernel: [<c01510f0>] sys_select+0x2a3/0x479
Oct 28 21:24:32 dardhal kernel: [<c01429a4>] vfs_read+0xb1/0xc7
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: kdesu_stub    S D2922000  1621      1  1624    1650  1630 (NOTLB)
Oct 28 21:24:32 dardhal kernel: d2923f4c 00000086 0804ac10 d2922000 d2924ce0 00004ae9 b751399c 0000003c 
Oct 28 21:24:32 dardhal kernel: d2925940 d2925940 d29259e8 fffffe00 00000000 c011be37 00000001 d2922000 
Oct 28 21:24:32 dardhal kernel: 00000000 d2925940 c011733a 00000000 00000000 d2922000 e90b9b8d d2fbe4c0 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c011be37>] sys_wait4+0x17e/0x213
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c011bedf>] sys_waitpid+0x13/0x17
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: sh            S D162BF70  1624   1621  1625               (NOTLB)
Oct 28 21:24:32 dardhal kernel: d162bf60 00000086 000003fc d162bf70 d2925940 00003bc4 b750eeb3 0000003c 
Oct 28 21:24:32 dardhal kernel: d2924ce0 d2924ce0 d2924d88 fffffe00 00000000 c011be37 00000001 00000659 
Oct 28 21:24:32 dardhal kernel: 00000000 d2924ce0 c011733a 00000000 00000000 d14c9be0 c0117136 d162bfbc 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c011be37>] sys_wait4+0x17e/0x213
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c0117136>] schedule+0x2fd/0x501
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: xmms          S C034D81C  1625   1624  1626               (NOTLB)
Oct 28 21:24:32 dardhal kernel: d14c9f98 00000082 00000000 c034d81c d2fbe940 00000214 1647fa8e 00000515 
Oct 28 21:24:32 dardhal kernel: d29246b0 00000000 d14c9fc4 d14c9fa8 00000000 c0109be0 80000400 00000000 
Oct 28 21:24:32 dardhal kernel: 00000400 00000000 bfffe970 401d7054 bfffe970 d14c8000 c0262423 bfffe970 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c0109be0>] sys_rt_sigsuspend+0xc2/0xe5
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: xmms          Z C011B1A9  1626   1625                     (L-TLB)
Oct 28 21:24:32 dardhal kernel: d13d7f98 00000046 d2924080 c011b1a9 d2924080 000005ad 0b7b7e13 00000515 
Oct 28 21:24:32 dardhal kernel: d2924080 dfd8d2a0 d2924080 d2924080 00000000 c011b82f 00000000 d13d6000 
Oct 28 21:24:32 dardhal kernel: 00000005 d13d6000 c011b939 00000000 00000000 08173390 c0262423 00000000 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c011b1a9>] exit_notify+0x214/0x670
Oct 28 21:24:32 dardhal kernel: [<c011b82f>] do_exit+0x22a/0x2ad
Oct 28 21:24:32 dardhal kernel: [<c011b939>] do_group_exit+0x45/0x63
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: xmms          S D13A1FC4  1630      1          1621  9145 (NOTLB)
Oct 28 21:24:32 dardhal kernel: d13a1f98 00000082 c010ed2c d13a1fc4 c02b4cf0 000004d4 220bca45 00000515 
Oct 28 21:24:32 dardhal kernel: d13d5350 00000000 d13a1fc4 d13a1fa8 00000000 c0109be0 80000400 00000000 
Oct 28 21:24:32 dardhal kernel: 00000400 00000000 bf5ff400 401d7054 bf5ff400 d13a0000 c0262423 bf5ff400 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c010ed2c>] timer_interrupt+0x30/0xe9
Oct 28 21:24:32 dardhal kernel: [<c0109be0>] sys_rt_sigsuspend+0xc2/0xe5
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: kdesu_stub    S 00000000  1650      1  1653          1621 (NOTLB)
Oct 28 21:24:32 dardhal kernel: d3771f4c 00000082 0804ac10 00000000 d375f2d0 000031f6 d9f816fb 0000003f 
Oct 28 21:24:32 dardhal kernel: d455a0c0 d455a0c0 d455a168 fffffe00 00000000 c011be37 00000001 d3770000 
Oct 28 21:24:32 dardhal kernel: 00000000 d455a0c0 c011733a 00000000 00000000 d3770000 b09a022a d4551280 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c011be37>] sys_wait4+0x17e/0x213
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c011bedf>] sys_waitpid+0x13/0x17
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: sh            S 0000003F  1653   1650  1654               (NOTLB)
Oct 28 21:24:32 dardhal kernel: d375df60 00000082 d9eff700 0000003f c151d2d0 00005e1e d9f922c6 0000003f 
Oct 28 21:24:32 dardhal kernel: d375f900 d375f900 d375f9a8 fffffe00 00000000 c011be37 00000001 00000676 
Oct 28 21:24:32 dardhal kernel: 00000000 d375f900 c011733a 00000000 00000000 d373bfbc c0117136 d375dfbc 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c011be37>] sys_wait4+0x17e/0x213
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c0117136>] schedule+0x2fd/0x501
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: run-mozilla.s S D373BF70  1654   1653  1659               (NOTLB)
Oct 28 21:24:32 dardhal kernel: d373bf60 00000082 000003fc d373bf70 c01167eb 00001298 e036bde4 0000003f 
Oct 28 21:24:32 dardhal kernel: d375f2d0 d375f2d0 d375f378 fffffe00 00000000 c011be37 00000001 0000067b 
Oct 28 21:24:32 dardhal kernel: 00000000 d375f2d0 c011733a 00000000 00000000 d3739be0 c0117136 d373bfbc 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c01167eb>] wake_up_forked_process+0xa3/0x119
Oct 28 21:24:32 dardhal kernel: [<c011be37>] sys_wait4+0x17e/0x213
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c0117136>] schedule+0x2fd/0x501
Oct 28 21:24:32 dardhal kernel: [<c011733a>] default_wake_function+0x0/0x18
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: MozillaFirebi S D26079C0  1659   1654  1662               (NOTLB)
Oct 28 21:24:32 dardhal kernel: d3739f98 00000082 00000000 d26079c0 d26079e0 00000e25 c4b24339 0000051b 
Oct 28 21:24:32 dardhal kernel: d375eca0 00000000 d3739fc4 d3739fa8 00000000 c0109be0 80000000 00000000 
Oct 28 21:24:32 dardhal kernel: 00000000 00000000 bfffea60 401b7054 bfffea60 d3738000 c0262423 bfffea60 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c0109be0>] sys_rt_sigsuspend+0xc2/0xe5
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: MozillaFirebi Z C011B1A9  1662   1659                     (L-TLB)
Oct 28 21:24:32 dardhal kernel: d4559c34 00000046 d455b980 c011b1a9 d2924080 000ad9c8 db8b39e2 0000050b 
Oct 28 21:24:32 dardhal kernel: d455b980 dfd8daa0 d455b980 d455b980 0000000b c011b82f d4558000 00000000 
Oct 28 21:24:32 dardhal kernel: d4559c68 00000158 c010ab34 0000000b d4559d00 c010abc7 c0279eb7 d4559d00 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c011b1a9>] exit_notify+0x214/0x670
Oct 28 21:24:32 dardhal kernel: [<c011b82f>] do_exit+0x22a/0x2ad
Oct 28 21:24:32 dardhal kernel: [<c010ab34>] do_divide_error+0x0/0xa7
Oct 28 21:24:32 dardhal kernel: [<c010abc7>] do_divide_error+0x93/0xa7
Oct 28 21:24:32 dardhal kernel: [<c012f573>] badness+0x5f/0xe4
Oct 28 21:24:32 dardhal kernel: [<c013418f>] __pagevec_release+0x18/0x23
Oct 28 21:24:32 dardhal kernel: [<c0117136>] schedule+0x2fd/0x501
Oct 28 21:24:32 dardhal kernel: [<c012034e>] schedule_timeout+0x60/0x9f
Oct 28 21:24:32 dardhal kernel: [<c01202e5>] process_timeout+0x0/0x9
Oct 28 21:24:32 dardhal kernel: [<c010ab34>] do_divide_error+0x0/0xa7
Oct 28 21:24:32 dardhal kernel: [<c0262e2f>] error_code+0x2f/0x38
Oct 28 21:24:32 dardhal kernel: [<c012f573>] badness+0x5f/0xe4
Oct 28 21:24:32 dardhal kernel: [<c012f622>] select_bad_process+0x2a/0x62
Oct 28 21:24:32 dardhal kernel: [<c012f717>] oom_kill+0x9/0x9b
Oct 28 21:24:32 dardhal kernel: [<c012f809>] out_of_memory+0x60/0x7f
Oct 28 21:24:32 dardhal kernel: [<c01358ce>] try_to_free_pages+0x115/0x13e
Oct 28 21:24:32 dardhal kernel: [<c01302bf>] __alloc_pages+0x1a0/0x2c0
Oct 28 21:24:32 dardhal kernel: [<c0131f4c>] do_page_cache_readahead+0xc3/0xeb
Oct 28 21:24:32 dardhal kernel: [<c012d97b>] filemap_nopage+0xb3/0x276
Oct 28 21:24:32 dardhal kernel: [<c0137fe6>] do_no_page+0x7d/0x2d8
Oct 28 21:24:32 dardhal kernel: [<c0138393>] handle_mm_fault+0x9b/0xe6
Oct 28 21:24:32 dardhal kernel: [<c01157de>] do_page_fault+0x108/0x4a2
Oct 28 21:24:32 dardhal kernel: [<c0151342>] do_pollfd+0x7c/0x82
Oct 28 21:24:32 dardhal kernel: [<c0151311>] do_pollfd+0x4b/0x82
Oct 28 21:24:32 dardhal kernel: [<c0151397>] do_poll+0x4f/0xae
Oct 28 21:24:32 dardhal kernel: [<c0150a4c>] poll_freewait+0x37/0x3e
Oct 28 21:24:32 dardhal kernel: [<c0151617>] sys_poll+0x221/0x26a
Oct 28 21:24:32 dardhal kernel: [<c0150a53>] __pollwait+0x0/0x9a
Oct 28 21:24:32 dardhal kernel: [<c01156d6>] do_page_fault+0x0/0x4a2
Oct 28 21:24:32 dardhal kernel: [<c0262e2f>] error_code+0x2f/0x38
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: MozillaFirebi S D45A5540  1663      1          1664   286 (NOTLB)
Oct 28 21:24:32 dardhal kernel: d0237f30 00000082 c0150a86 d45a5540 cb29c670 000009da 7c439231 000004f5 
Oct 28 21:24:32 dardhal kernel: d455b350 00000000 7fffffff d0237fa0 dcb15ce0 c012038b d2607d80 c0151311 
Oct 28 21:24:32 dardhal kernel: dcb15ce0 7fffffff d0237fa0 dcb15ce0 c0151397 00000001 00000000 7fffffff 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c0150a86>] __pollwait+0x33/0x9a
Oct 28 21:24:32 dardhal kernel: [<c012038b>] schedule_timeout+0x9d/0x9f
Oct 28 21:24:32 dardhal kernel: [<c0151311>] do_pollfd+0x4b/0x82
Oct 28 21:24:32 dardhal kernel: [<c0151397>] do_poll+0x4f/0xae
Oct 28 21:24:32 dardhal kernel: [<c01513d8>] do_poll+0x90/0xae
Oct 28 21:24:32 dardhal kernel: [<c015156d>] sys_poll+0x177/0x26a
Oct 28 21:24:32 dardhal kernel: [<c0150a53>] __pollwait+0x0/0x9a
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: MozillaFirebi S 000002AD  1664      1          1669  1663 (NOTLB)
Oct 28 21:24:32 dardhal kernel: d02fbf98 00000082 d1408774 000002ad d455b350 00003baa d140a686 000002ad 
Oct 28 21:24:32 dardhal kernel: d455ad20 00000000 d02fbfc4 d02fbfa8 00000000 c0109be0 80000000 00000000 
Oct 28 21:24:32 dardhal kernel: 00000000 00000000 bf5ff91c 401b7054 bf5ff91c d02fa000 c0262423 bf5ff91c 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c0109be0>] sys_rt_sigsuspend+0xc2/0xe5
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: gconfd-2      S D4547F38  1666      1           284  1493 (NOTLB)
Oct 28 21:24:32 dardhal kernel: d4547f30 00000086 d3815c40 d4547f38 00000246 0000bd67 774a5b3f 0000051b 
Oct 28 21:24:32 dardhal kernel: d0239900 0051bcee d4547f38 d4547fa0 ddb3cde0 c0120346 c1761f68 dd411ed4 
Oct 28 21:24:32 dardhal kernel: 0051bcee 4b87ad6e c01202e5 d0239900 c02b61a0 00000001 00000000 0000ef3e 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c0120346>] schedule_timeout+0x58/0x9f
Oct 28 21:24:32 dardhal kernel: [<c01202e5>] process_timeout+0x0/0x9
Oct 28 21:24:32 dardhal kernel: [<c01513d8>] do_poll+0x90/0xae
Oct 28 21:24:32 dardhal kernel: [<c015156d>] sys_poll+0x177/0x26a
Oct 28 21:24:32 dardhal kernel: [<c0150a53>] __pollwait+0x0/0x9a
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: MozillaFirebi S D4535FC4  1669      1          9145  1664 (NOTLB)
Oct 28 21:24:32 dardhal kernel: d4535f98 00000082 c010ed2c d4535fc4 c02b4cf0 000002d7 9e1d97d3 00000502 
Oct 28 21:24:32 dardhal kernel: d13d40c0 00000000 d4535fc4 d4535fa8 00000000 c0109be0 80000000 00000000 
Oct 28 21:24:32 dardhal kernel: 00000000 00000000 bf3ff93c 401b7054 bf3ff93c d4534000 c0262423 bf3ff93c 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c010ed2c>] timer_interrupt+0x30/0xe9
Oct 28 21:24:32 dardhal kernel: [<c0109be0>] sys_rt_sigsuspend+0xc2/0xe5
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:32 dardhal kernel: MozillaFirebi S 0000045F  9145      1          1630  1669 (NOTLB)
Oct 28 21:24:32 dardhal kernel: c836ff98 00000082 b278ebf0 0000045f d9ea8080 00032750 b2abd73f 0000045f 
Oct 28 21:24:32 dardhal kernel: d6569900 00000000 c836ffc4 c836ffa8 00000000 c0109be0 80000000 00000000 
Oct 28 21:24:32 dardhal kernel: 00000000 00000000 bf1ff8ac 401b7054 bf1ff8ac c836e000 c0262423 bf1ff8ac 
Oct 28 21:24:32 dardhal kernel: Call Trace:
Oct 28 21:24:32 dardhal kernel: [<c0109be0>] sys_rt_sigsuspend+0xc2/0xe5
Oct 28 21:24:32 dardhal kernel: [<c0262423>] syscall_call+0x7/0xb
Oct 28 21:24:32 dardhal kernel: 
Oct 28 21:24:40 dardhal kernel: IN=ppp0 OUT= MAC= SRC=213.0.153.172 DST=213.0.150.151 LEN=40 TOS=0x00 PREC=0x00 TTL=126 ID=29702 DF PROTO=TCP SPT=3458 DPT=135 WINDOW=0 RES=0x00 RST URGP=0 

-- 
Jose Luis Domingo Lopez
Linux Registered User #189436     Debian Linux Sid (Linux 2.6.0-test8-mm1)
