Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422885AbWJFT1J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422885AbWJFT1J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422651AbWJFT1I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 15:27:08 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:14827 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1422885AbWJFT1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 15:27:06 -0400
Date: Fri, 6 Oct 2006 14:26:57 -0500 (CDT)
From: Brent Casavant <bcasavan@sgi.com>
Reply-To: Brent Casavant <bcasavan@sgi.com>
To: linux-ide@vger.kernel.org
cc: linux-kernel@vger.kernel.org, B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: 2.6.19-rc1: Oops in probe_hwif
In-Reply-To: <20061006135449.R49475@pkunk.americas.sgi.com>
Message-ID: <20061006142615.L49475@pkunk.americas.sgi.com>
References: <20061006135449.R49475@pkunk.americas.sgi.com>
Organization: Silicon Graphics, Inc.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ignore this whole message, I was chasing down the wrong path, and
now realize that I was looking at a field named "hwif" that wasn't
the "hwif" I was looking for.

Still investigating...

Brent

On Fri, 6 Oct 2006, Brent Casavant wrote:

> While working on a patch to remove the SN dependencies from the
> ioc4 driver, I ran across the included oops in the IDE code.
> 
> I believe the problem is that HWIF(drive) is NULL in SELECT_DRIVE.
> This seems to be confirmed by the value of r10 in the oops output,
> which contains &(HWIF(drive)->intrproc) at the moment of the oops.
> 
> If my reading of the IDE code is correct (I'm no expert, to be sure),
> the "hwif" field of an ide_drive_t is initialized in init_irq() in
> ide-probe.c.  However, this code has not been called yet.  The structure
> of function calls as-coded is:
> 
> 	probe_hwif_init_with_fixup
> 		probe_hwif
> 			wait_hwif_ready
> 				SELECT_DRIVE
> 		hwif_init
> 			init_irq
> 
> So, unless I'm missing something, there seems to be a use of an
> (ide_drive_t*)->hwif field (in SELECT_DRIVE()) before it is initialized
> (in init_irq()).
> 
> Thanks,
> Brent Casavant
> 
> Unable to handle kernel NULL pointer dereference (address 0000000000000840)
> swapper[1]: Oops 8813272891392 [1]
> Modules linked in:
> 
> Pid: 1, CPU 0, comm:              swapper
> psr : 00001010085a6010 ifs : 8000000000000287 ip  : [<a0000001005262d0>]    Not tainted
> ip is at SELECT_DRIVE+0x30/0xe0
> unat: 0000000000000000 pfs : 000000000000040a rsc : 0000000000000003
> rnat: 9ffffffff6000000 bsps: 000000000000fffe pr  : 000000000000a581
> ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70433f
> csd : 0000000000000000 ssd : 0000000000000000
> b0  : a00000010052c670 b6  : a00000010051bec0 b7  : a0000001004cbe40
> f6  : 1003e0000000138800000 f7  : 1003e431bde82d7b634db
> f8  : 1003e0000000001312d00 f9  : 1003e00000004a817c800
> f10 : 1003e00000000000003e8 f11 : 1003e0000000000000000
> r1  : a000000100eb6ef0 r2  : a000000100ccfae8 r3  : a000000100ccfae8
> r8  : 0000000000000000 r9  : 0000000000000000 r10 : 0000000000000840
> r11 : 0000000000000000 r12 : e00000307a6c7d20 r13 : e00000307a6c0000
> r14 : 00000000000000ff r15 : 0000000000000050 r16 : 0000000000000000
> r17 : e00000307a279398 r18 : 0000000000000000 r19 : 0000000000000020
> r20 : e000003003110000 r21 : 0000000000000000 r22 : 0000000000000000
> r23 : 000000000000000f r24 : e00000307a3da480 r25 : ffffffffffff4230
> r26 : e0000030030a4000 r27 : 0000000000000000 r28 : e00000307a279390
> r29 : e00000307a279380 r30 : 0000000000000000 r31 : e000003003105238
> 
> Call Trace:
>  [<a0000001000129c0>] show_stack+0x40/0xa0
>                                 sp=e00000307a6c78d0 bsp=e00000307a6c0fe0
>  [<a0000001000132c0>] show_regs+0x840/0x880
>                                 sp=e00000307a6c7aa0 bsp=e00000307a6c0f88
>  [<a000000100034c90>] die+0x250/0x320
>                                 sp=e00000307a6c7aa0 bsp=e00000307a6c0f40
>  [<a000000100058990>] ia64_do_page_fault+0x930/0xa60
>                                 sp=e00000307a6c7ac0 bsp=e00000307a6c0ef0
>  [<a00000010000bb40>] ia64_leave_kernel+0x0/0x290
>                                 sp=e00000307a6c7b50 bsp=e00000307a6c0ef0
>  [<a0000001005262d0>] SELECT_DRIVE+0x30/0xe0
>                                 sp=e00000307a6c7d20 bsp=e00000307a6c0eb8
>  [<a00000010052c670>] wait_hwif_ready+0x90/0x1a0
>                                 sp=e00000307a6c7d20 bsp=e00000307a6c0e78
>  [<a00000010052e130>] probe_hwif+0x1f0/0x1020
>                                 sp=e00000307a6c7d20 bsp=e00000307a6c0e08
>  [<a000000100530830>] probe_hwif_init_with_fixup+0x30/0x1a0
>                                 sp=e00000307a6c7d20 bsp=e00000307a6c0dd8
>  [<a0000001005309d0>] probe_hwif_init+0x30/0x60
>                                 sp=e00000307a6c7d20 bsp=e00000307a6c0db8
>  [<a00000010051be50>] ioc4_ide_attach_one+0x570/0x5e0
>                                 sp=e00000307a6c7d20 bsp=e00000307a6c0d58
>  [<a0000001004ef990>] ioc4_register_submodule+0xd0/0x200
>                                 sp=e00000307a6c7d30 bsp=e00000307a6c0d30
>  [<a00000010051a580>] ioc4_ide_init+0x20/0x40
>                                 sp=e00000307a6c7d30 bsp=e00000307a6c0d18
>  [<a000000100009720>] init+0x420/0x840
>                                 sp=e00000307a6c7d30 bsp=e00000307a6c0ce8
>  [<a000000100010f70>] kernel_thread_helper+0xd0/0x100
>                                 sp=e00000307a6c7e30 bsp=e00000307a6c0cc0
>  [<a000000100009140>] start_kernel_thread+0x20/0x40
>                                 sp=e00000307a6c7e30 bsp=e00000307a6c0cc0
>  <0>Kernel panic - not syncing: Attempted to kill init!
> 
> 
> -- 
> Brent Casavant                          All music is folk music.  I ain't
> bcasavan@sgi.com                        never heard a horse sing a song.
> Silicon Graphics, Inc.                    -- Louis Armstrong
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
Brent Casavant                          All music is folk music.  I ain't
bcasavan@sgi.com                        never heard a horse sing a song.
Silicon Graphics, Inc.                    -- Louis Armstrong
