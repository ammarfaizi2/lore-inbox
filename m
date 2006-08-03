Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932440AbWHCTXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932440AbWHCTXI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 15:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932466AbWHCTXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 15:23:08 -0400
Received: from natblert.rzone.de ([81.169.145.181]:27133 "EHLO
	natblert.rzone.de") by vger.kernel.org with ESMTP id S932440AbWHCTXH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 15:23:07 -0400
Date: Thu, 3 Aug 2006 21:23:02 +0200
From: Olaf Hering <olaf@aepfle.de>
To: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: softlockup during glibc tst-robust in 2.6.18-rc3
Message-ID: <20060803192302.GA6049@aepfle.de>
References: <20060802053821.GA24356@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060802053821.GA24356@aepfle.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2006 at 07:38:21AM +0200, Olaf Hering wrote:
> 
> A 'make check' in glibc mainline triggers this lockup in current Linus tree on a
> 4cpu p630. All I can do at this point is a reboot via sysrq b.
> 
> According to the glibc build log, tst-robust1 and tst-robust2 timed out, tst-robust3
> is still running.
> I'm using pseries_defconfig with HZ=100.

> BUG: soft lockup detected on CPU#1!
> Call Trace:
> [C000000087713610] [C00000000000EBDC] .show_stack+0x68/0x1b0 (unreliable)
> [C0000000877136B0] [C000000000081230] .softlockup_tick+0xf0/0x128
> [C000000087713760] [C00000000005961C] .run_local_timers+0x1c/0x30
> [C0000000877137E0] [C0000000000202BC] .timer_interrupt+0xa8/0x474
> [C0000000877138C0] [C0000000000034DC] decrementer_common+0xdc/0x100
> --- Exception: 901 at .handle_futex_death+0x28/0x98
>     LR = .compat_exit_robust_list+0x108/0x1ac
> [C000000087713BB0] [C0000000FAB61810] 0xc0000000fab61810 (unreliable)
> [C000000087713C30] [C00000000006DA60] .compat_exit_robust_list+0x108/0x1ac
> [C000000087713D00] [C000000000050C6C] .do_exit+0x1f8/0x980
> [C000000087713DB0] [C0000000000514C0] .complete_and_exit+0x0/0x2c
> [C000000087713E30] [C00000000000861C] syscall_exit+0x0/0x40

0f0410823792ae0ecb45f2578598b115835ffdbb is first bad commit
diff-tree 0f0410823792ae0ecb45f2578598b115835ffdbb (from b471f55427ee94d6de2b33b88a7409f8cbc6b5dc)
Author: David Woodhouse <dwmw2@infradead.org>
Date:   Tue May 23 07:46:40 2006 -0700

    [PATCH] powerpc: wire up sys_[gs]et_robust_list
    
    Signed-off-by: David Woodhouse <dwmw2@infradead.org>
    Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Acked-by: Paul Mackerras <paulus@samba.org>
    Cc: Arnd Bergmann <arnd@arndb.de>
    Signed-off-by: Andrew Morton <akpm@osdl.org>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:040000 040000 3baf7e58d2e81265b7918fd43c2f8fe8a2a622fd 5d7ac9147e4de3de41fe8be28753024bf5be2149 M      arch
:040000 040000 9c7655ffb8bd4927585604d3c9da723f56d2cbc0 2221102e21e320dfdad18fb822bf97675e9c8353 M      include

However, I guess the real culprit is e9056f13bfcdd054a0c3d730e4e096748d8a363a
[PATCH] lightweight robust futexes: arch defaults

