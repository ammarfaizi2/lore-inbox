Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261164AbVBGPlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261164AbVBGPlz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 10:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261161AbVBGPle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 10:41:34 -0500
Received: from [195.23.16.24] ([195.23.16.24]:1676 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261157AbVBGPjd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 10:39:33 -0500
Message-ID: <42078B97.6030300@grupopie.com>
Date: Mon, 07 Feb 2005 15:39:03 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Adam Sulmicki <adam@cfar.umd.edu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Machek <pavel@ucw.cz>, Jon Smirl <jonsmirl@gmail.com>,
       ncunningham@linuxmail.org, ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Li-Ta Lo <ollie@lanl.gov>
Subject: Re: [RFC] Reliable video POSTing on resume
References: <e796392205020221387d4d8562@mail.gmail.com>  <420217DB.709@gmx.net> <4202A972.1070003@gmx.net>  <20050203225410.GB1110@elf.ucw.cz>  <1107474198.5727.9.camel@desktop.cunninghams> <4202DF7B.2000506@gmx.net>  <1107485504.5727.35.camel@desktop.cunninghams>  <9e4733910502032318460f2c0c@mail.gmail.com>  <20050204074454.GB1086@elf.ucw.cz>  <9e473391050204093837bc50d3@mail.gmail.com>  <20050205093550.GC1158@elf.ucw.cz> <1107695583.14847.167.camel@localhost.localdomain> <Pine.BSF.4.62.0502062107000.26868@www.missl.cs.umd.edu> <42077AC4.5030103@grupopie.com> <42077CFD.7030607@gmx.net>
In-Reply-To: <42077CFD.7030607@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Carl-Daniel Hailfinger wrote:
> Paulo Marques schrieb:
>[...]
>>It seems to me that x86 emulation in the kernel is the way to go because:
>>
>>[...]
>>
>>3 - it's always there and can be executed at *any* time: booting,
>>returning from suspend, etc. Also it would allow the VESA framebuffer
>>driver to change graphics mode at any time (for instance).
> 
> 
> OK, and what would force you to do the above in the kernel? If the code
> lives in initramfs, it can be called very early, too.

Not as early, anyway, and it would make the setup for the initramfs (at 
boot) and the resume much more complex.

The line line between what should go in the kernel and what should live 
in user space as always been a fuzzy one, and it's been moving in a 
dangerous direction lately, IMHO.

In my opinion there are 3 major factors for something to go into the kernel:

1 - resource management between user space processes (this includes 
locking, etc.)

2 - performance

3 - hardware abstraction

This latest point is being more and more ignored by kernel developers.

In a previous thread about using the frame buffer accelerated operations 
from user space, Jammes Simmons wrote:

"You can mmap the mmio address space and program the registers yourself."

and just 3 minutes later, Geert Uytterhoeven wrote too:

"mmap() the MMIO registers to userspace, and program the acceleration 
engine from userspace, like DirectFB (and XF*_FBDev 3.x for Matrox and 
Mach64) does."

This is a even more horrid example, because the drivers in the kernel 
already have the code to do the accelerated functions, and we just don't 
have the interface for them to be called from user space.

It is another example of "this can be done from user space, so why put 
it in the kernel". To have a consistent interface for similar operations 
without having to know the underlying hardware, perhaps?

At least Helge Hafting wrote on the same thread:

"I believe you also can write a small driver that connects to the
framebuffer the same way the fbconsole does.  It could then
export all the operations so userspace actually can call them."

Which seemed a much better solution to me.

> And how many competing implementations of video helpers/emulation code
> do we have now?
> 
> - scitechsoft emu
> - linuxbios emu

I think these two are the same (or at least that is what Li-Ta Lo is 
working on)

> - etc. (I surely forgot some)

This one I've never heard of :)

Anyway, as it happens with anything in the kernel, several different 
solutions for the same problem get selected by "natural" selection, and 
evolve "genetically" into the final version.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
