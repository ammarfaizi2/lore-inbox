Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030326AbWD1IWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030326AbWD1IWS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 04:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030327AbWD1IWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 04:22:18 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50307 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030326AbWD1IWR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 04:22:17 -0400
Date: Fri, 28 Apr 2006 01:20:22 -0700
From: Andrew Morton <akpm@osdl.org>
To: Martin Bligh <mbligh@google.com>
Cc: apw@shadowen.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-rc2-mm1
Message-Id: <20060428012022.7b73c77b.akpm@osdl.org>
In-Reply-To: <4450F5AD.9030200@google.com>
References: <4450F5AD.9030200@google.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(I did s/linux-kernel@google.com/linux-kernel@vger.kernel.org/)

Martin Bligh <mbligh@google.com> wrote:
>
> Still crashes in LTP on x86_64:
> (introduced in previous release)
> 
> http://test.kernel.org/abat/29674/debug/console.log

What a mess.  A doublefault inside an NMI watchdog timeout.  I think.  It's
hard to see.  Some CPUs are stuck on a CPU scheduler lock, others seem to
be stuck in flush_tlb_others.  One of these could be a consequence of the
other, or both could be a consequence of something else.

> Different panic on 2-way ppp64  blade, again during LTP.
> 
> http://test.kernel.org/abat/29675/debug/console.log
> 
>   Oops: Kernel access of bad area, sig: 11 [#1]
> SMP NR_CPUS=128 NUMA
> Modules linked in: evdev joydev st sr_mod ipv6 usbcore sg dm_mod
> NIP: C000000000048F0C LR: C0000000000AF854 CTR: 800000000000A984
> REGS: c0000000074af560 TRAP: 0300   Not tainted  (2.6.17-rc2-mm1-autokern1)
> MSR: 8000000000001032 <ME,IR,DR>  CR: 24002024  XER: 00000010
> DAR: C00001800056B0B0, DSISR: 0000000040010000
> TASK = c000000007460800[84] 'kswapd0' THREAD: c0000000074ac000 CPU: 1
> GPR00: 8000000000001032 C0000000074AF7E0 C000000000691420 C0000000007586A8
> GPR04: 000000000000000F 0000000000000000 0000000000000000 0000000000000000
> GPR08: C0000000FE80AAD8 C00001800056B080 0000000000000001 C0000000007586A8
> GPR12: 0000000024002024 C00000000056B280 0000000000000020 0000000000000020
> GPR16: 0000000000000020 0000000000000000 0000000000000000 000000000000000F
> GPR20: C0000000074AF860 0000000000000000 C0000000FFFF3098 0000000000000001
> GPR24: C0000000074AFE00 C00000000059FCC0 0000000000000001 C0000000007586A8
> GPR28: C000000000545680 0000000000000022 C0000000005A4DA8 C00000000056B080
> NIP [C000000000048F0C] .try_to_wake_up+0x98/0x598
> LR [C0000000000AF854] .add_to_swapped_list+0x23c/0x264
> Call Trace:
> [C0000000074AF7E0] [C0000000005A4DA8] 0xc0000000005a4da8 (unreliable)
> [C0000000074AF8F0] [C0000000000AF854] .add_to_swapped_list+0x23c/0x264
> [C0000000074AF990] [C000000000098290] .remove_mapping+0x88/0x174
> [C0000000074AFA20] [C000000000099340] .shrink_zone+0xc74/0xf9c
> [C0000000074AFD30] [C00000000009A008] .kswapd+0x3e4/0x54c
> [C0000000074AFED0] [C0000000000705C8] .kthread+0x174/0x1c4
> [C0000000074AFF90] [C000000000024AB0] .kernel_thread+0x4c/0x68
> Instruction dump:
> 3a810080 7d2000a6 79208042 f9340000 78008000 7c010164 e97b0008 ebfe8008
> eb9e8000 812b0010 79294da4 7d29fa14 <e8090030> 7fbc0214 7fa3eb78 4841f615
> -- 0:conmux-control -- time-stamp -- Apr/27/06  5:10:48 --

Well that's silly.  kswapd died trying to wake up kprefetchd.  That code's
bog-simple, so I'd assume something's gone wrong with a CPU scheduler data
structure.  So if there's a common strand here, it's breakage of sched data
structures by mtest01.   Let me see if I can provoke it here.
