Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268240AbTALENh>; Sat, 11 Jan 2003 23:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268241AbTALENh>; Sat, 11 Jan 2003 23:13:37 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:17415 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268240AbTALENe>; Sat, 11 Jan 2003 23:13:34 -0500
Date: Sat, 11 Jan 2003 20:17:19 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.55/.56 instant reboot problem on 486
In-Reply-To: <200301120231.DAA14711@harpo.it.uu.se>
Message-ID: <Pine.LNX.4.44.0301112012040.1401-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 12 Jan 2003, Mikael Pettersson wrote:
>
> My '94 vintage 486 has problems booting 2.5.55 and 2.5.56.

Should I take it that 2.5.54 works? Or you haven't tested?

> After doing a binary search with "for(;;);" statements
> (printk doesn't work this early) I found that the reboot
> occurs in arch/i386/mm/init.c:kernel_physical_mapping_init():
> (start_kernel() -> setup_arch() -> paging_init() ->
> pagetable_init() -> kernel_physical_mapping_init())

Ho humm.. Sounds like the non-PSE case is broken. Which should probably
mean that even newer CPU's should show the same thing if we boot with
"mem=nopentium". Can you verify that with your other machine that
otherwise boots the same kernel fine?

> The problem is apparently related to the size of the kernel.
> With gcc-2.95.3 and my normal config for this machine,
> size vmlinux is
> 
>    text	   data	    bss	    dec	    hex	filename
> 1330953	 109008	 125656	1565617	 17e3b1	vmlinux
> 
> and the kernel reboots. If I alter the size by changing some
> irrelevant config option (like disabling INPUT_MOUSEDEV or
> enabling KALLSYMS), the reboot problem doesn't occur.

That's bizarre. Especially the fact that a _smaller_ kernel has problems, 
but a biger one does not. 
> 
> With gcc-3.2 the bug disappears, but only because gcc-3.2
> generates a much larger code segment. If I remove some
> driver & fs config options, the vmlinux size becomes almost
> the same as above, and the reboot bug appears again.
> 
> The same kernel that fails on the 486 boots Ok on my newer
> test boxes, so the problem is either 486-specific, related
> to the actual memory size, or the BIOS memory size reporting
> method (the 486 uses int 15 0x88); here's what 2.5.54 says:
> 
> BIOS-provided physical RAM map:
>  BIOS-88: 0000000000000000 - 000000000009f000 (usable)
>  BIOS-88: 0000000000100000 - 0000000001c00000 (usable)

That looks like a perfectly fine memory map, even if 28MB or memory sounds
a bit strange.

		Linus

