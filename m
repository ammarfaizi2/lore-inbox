Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSGILAp>; Tue, 9 Jul 2002 07:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313571AbSGILAo>; Tue, 9 Jul 2002 07:00:44 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:44444 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S313628AbSGILAj>;
	Tue, 9 Jul 2002 07:00:39 -0400
Date: Tue, 9 Jul 2002 13:03:18 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200207091103.NAA05525@harpo.it.uu.se>
To: johnstul@us.ibm.com
Subject: Re: [RFC] bt_ioremap question / cyclone-timer_A1 patch
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08 Jul 2002 19:36:23 -0700, john stultz wrote:
>	I've been working on improving performance of do_gettimeofday on
>certain NUMA hardware (see my earlier tsc-disable posts for why the TSCs
>cannot be used), and I wanted to run this by the list to make sure I'm
>not doing anything too daft. 
>
>Mainly I'm concerned about my usage of bt_ioremap. Early in the boot
>processes, I need to map in a couple of chipset registers and poke
>values into them.

How early? If this is just to get gettimeofday() working, can't it
wait until the regular initcalls are done?

> However one of the registers needs to be kept mapped
>for the life of the system (look for "cyclone_timer" below). I couldn't
>find any documentation on whether memory mapped with bt_ioremap can be
>held across mem_init(). It seems to "just work" but I wanted to find out
>if I really should be re-mapping the register w/ ioremap once it becomes
>available. 

If you look in include/asm-i386/fixmap.h you'll see that the BT ioremap
pages are temporary, and they do disappear once mem_init() [or whatever]
is done [pgtable.h sets VMALLOC_END to just below FIXADDR_START, which
protects the permanent fixmaps but intensionally not the temporary ones].
If it seemed to work for you then that's just luck, or perhaps it does
work in highmem kernels?

For things that must be mapped very early and continue to be mapped as
long as the kernel is up, you need a permanent fixmap. fixmap.h has a
number of permanent fixmaps defined #ifdef CONFIG_* and you can easily
add your own there, under #ifdef CONFIG_X86_IBMEXA.

/Mikael
