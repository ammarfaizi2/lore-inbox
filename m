Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261742AbUJYKJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261742AbUJYKJj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 06:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261743AbUJYKJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 06:09:39 -0400
Received: from postfix4-1.free.fr ([213.228.0.62]:20404 "EHLO
	postfix4-1.free.fr") by vger.kernel.org with ESMTP id S261742AbUJYKJd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 06:09:33 -0400
Message-ID: <1098698969.417cd0d96dbde@imp2-q.free.fr>
Date: Mon, 25 Oct 2004 12:09:29 +0200
From: remi.colinet@free.fr
To: john cooper <john.cooper@timesys.com>
Cc: Ingo Molnar <mingo@elte.hu>, Lee Revell <rlrevell@joe-job.com>,
       gene.heskett@verizon.net, linux-kernel@vger.kernel.org,
       Rui Nuno Capela <rncbc@rncbc.org>, Mark_H_Johnson@raytheon.com,
       "K.R. Foley" <kr@cybsft.com>, Bill Huey <bhuey@lnxw.com>,
       Adam Heath <doogie@debian.org>, Florian Schmidt <mista.tapas@gmx.net>,
       Thomas Gleixner <tglx@linutronix.de>,
       Michal Schmidt <xschmi00@stud.feec.vutbr.cz>,
       Fernando Pablo Lopez-Lezcano <nando@ccrma.stanford.edu>,
       Alexander Batyrshin <abatyrshin@ru.mvista.com>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-U10.2
References: <20041014234202.GA26207@elte.hu> <20041022155048.GA16240@elte.hu> <20041022175633.GA1864@elte.hu> <200410221749.35306.gene.heskett@verizon.net> <1098482764.20495.2.camel@krustophenia.net> <20041023103620.GG30270@elte.hu> <417C49C6.1090300@timesys.com>
In-Reply-To: <417C49C6.1090300@timesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.5
X-Originating-IP: 192.85.50.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> I'm seeing an odd build error in the -U10.3 patch to 2.6.9-mm1:
>
>     <snip>
>
>   AS      arch/i386/boot/compressed/head.o
>   CC      arch/i386/boot/compressed/misc.o
>   OBJCOPY arch/i386/boot/compressed/vmlinux.bin
> BFD: Warning: Writing section `.bss' to huge (ie negative) file offset
> 0xc03ac000.
> objcopy: arch/i386/boot/compressed/vmlinux.bin: File truncated
> make[2]: *** [arch/i386/boot/compressed/vmlinux.bin] Error 1
> make[1]: *** [arch/i386/boot/compressed/vmlinux] Error 2
> make: *** [bzImage] Error 2
>
> [root@otaku linux-2.6.9]# objdump -f vmlinux
>
> vmlinux:     file format elf32-i386
> architecture: i386, flags 0x00000112:
> EXEC_P, HAS_SYMS, D_PAGED
> start address 0x00100000
>
> This appears a result of changes in:
>
>    arch/i386/kernel/vmlinux.lds.S
>
> apparently for support of CONFIG_KERN_PHYS_OFFSET.
> This causes the kernel LMA start address to
> change from 0xc0100000 to 0x100000 and objcopy to
> gag.  I rolled back to a 2.6.9-mm1 version of the
> above linker map file and did get the kernel to
> build and boot.
>
> Anyone else seeing this?  .config attached.

Yes.

You probably need to upgrade your binutil package. The .bss LMA start address
section is not dealt the way it should by ld.

An other (bad) way to work around this compile problem is to force the .bss LMA
start address with the following OBJCOPYFLAGS at objcopy time.

OBJCOPYFLAGS := -O binary --change-section-lma .bss-0xc0000000 -R .note -R
.comment -S

Hope this help,
Remi



