Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266433AbSLTWy7>; Fri, 20 Dec 2002 17:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266435AbSLTWy7>; Fri, 20 Dec 2002 17:54:59 -0500
Received: from mail.scram.de ([195.226.127.117]:31682 "EHLO mail.scram.de")
	by vger.kernel.org with ESMTP id <S266433AbSLTWy4>;
	Fri, 20 Dec 2002 17:54:56 -0500
Date: Fri, 20 Dec 2002 23:54:43 +0100 (CET)
From: Jochen Friedrich <jochen@scram.de>
X-X-Sender: jochen@gfrw1044.bocc.de
To: Hannes Reinecke <mail@hannes-reinecke.de>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.52: compilation fixes for alpha
In-Reply-To: <3E032D25.6050900@hannes-reinecke.de>
Message-ID: <Pine.LNX.4.44.0212202311290.13197-100000@gfrw1044.bocc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hannes,

On Fri, 20 Dec 2002, Hannes Reinecke wrote:

> Shit. I forgot that one (I knew there was something missing).
> Try the attached patch instead; it's identical to the previous one, I
> just appended the patch for arch/alpha/mm/extable.c
>
> Let me know whether it works.

That one compiled OK, now.

> Note: Module loading is still likely to be buggered, since it
> appearantly relies on newer modutils (I'm a bit out of touch with
> current events). But at least it compiles and runs, even with modules
> enabled. I see what I can dig out re. modules.

I currently have module-init-tools 0.9.4 installed, but module loading
complains about an invalid relocation type 6. Using objdump on a module
shows that the module is not linked as a dynamic object file (objdump -R
complains), but still contains static relocation entries (objdump -r is
not empty). On the other hand the arch/alpha/kernel/module.c code looks
almost the same as the 2.5.50 code + rth patch which required dynamic
objects for modules. So either there still is a problem with the Makefiles
or module.c fails to handle all required relocation types for the Alpha
platform.

I have a working 2.5.50 with module-init-tools 0.9.1 + rth patches with
modules working and here objdump -R shows dynamic relocation entries for
the modules and objdump -r is empty.

modprobe tmsisa

module tmsisa: Unknown relocation: 6

objdump -R /lib/modules/2.5.52bk4/kernel/drivers/net/tokenring/tmsisa.ko

/lib/modules/2.5.52bk4/kernel/drivers/net/tokenring/tmsisa.ko:     file
format elf64-alpha

objdump: /lib/modules/2.5.52bk4/kernel/drivers/net/tokenring/tmsisa.ko:
not a dynamic object
objdump: /lib/modules/2.5.52bk4/kernel/drivers/net/tokenring/tmsisa.ko:
Invalid operation

objdump -r /lib/modules/2.5.52bk4/kernel/drivers/net/tokenring/tmsisa.ko

/lib/modules/2.5.52bk4/kernel/drivers/net/tokenring/tmsisa.ko:     file
format elf64-alpha

RELOCATION RECORDS FOR [.text]:
OFFSET           TYPE              VALUE
0000000000000000 GPDISP            .text+0x0000000000000004
000000000000000c ELF_LITERAL       alpha_mv
...
000000000000089c LITUSE            .init.text+0x0000000000000003
000000000000089c HINT              printk
00000000000008a0 GPDISP            .init.text+0x0000000000000004
...

GPDISP seems the one the kernel complains about...

#define R_ALPHA_GPDISP          6       /* Add displacement to GP */

objdump -R /lib/modules/2.5.50/kernel/tmsisa.klm

/lib/modules/2.5.50/kernel/tmsisa.klm:     file format elf64-alpha

DYNAMIC RELOCATION RECORDS
OFFSET           TYPE              VALUE
0000000000012330 RELATIVE          *ABS*+0x0000000000000fe0
0000000000012338 RELATIVE          *ABS*+0x0000000000000ec0
...
0000000000012290 GLOB_DAT          __this_module
00000000000122d0 GLOB_DAT          tms380tr_interrupt
00000000000122e8 GLOB_DAT          ioport_resource
00000000000122f0 GLOB_DAT          alpha_mv
0000000000012288 JMP_SLOT          free_irq
0000000000012298 JMP_SLOT          unregister_trdev
...

Thanks,
--jochen

