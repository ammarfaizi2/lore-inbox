Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263709AbUERWhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUERWhk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 18:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUERWhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 18:37:40 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:33284 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263709AbUERWgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 18:36:45 -0400
Date: Tue, 18 May 2004 23:36:39 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Andrew Morton <akpm@osdl.org>
cc: VANDROVE@vc.cvut.cz, Vincent Sanders <vince@kyllikki.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: vga16fb broke
In-Reply-To: <20040514145559.55202998.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0405142314060.25927-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Guys, can you help with http://bugme.osdl.org/show_bug.cgi?id=2711 ?
> 
> The recent change broke it on x86 becuase we're now doing ioremap()
> of a kernel-virtual address, but the oriiginal version doesn't work on ARM.
> 
> Should it just be:
> 
> 	vga16fb.screen_base = VGA_MAP_MEM(VGA_FB_PHYS);

I went looking at the various platforms to see what exactly was going on.
We have:

Useage

./drivers/video/console/mdacon.c: mda_vram_base = VGA_MAP_MEM(0xb0000);
./drivers/video/console/vgacon.c: vga_vram_base = VGA_MAP_MEM(vga_vram_base);
./drivers/video/console/vgacon.c: vga_vram_end = VGA_MAP_MEM(vga_vram_end);
./drivers/video/console/vgacon.c: charmap = (char *) VGA_MAP_MEM(colourmap);
./drivers/video/console/vgacon.c: charmap = (char *) VGA_MAP_MEM(blackwmap);
./drivers/video/hgafb.c:	hga_fix.smem_start = VGA_MAP_MEM(hga_vram_base);
./drivers/video/vga16fb.c:	vga16fb.screen_base = ioremap(VGA_MAP_MEM(VGA_FB_PHYS), VGA_FB_PHYS_LEN);
./drivers/video/vga16fb.c:	vga16fb.fix.smem_start	= VGA_MAP_MEM(vga16fb.fix.smem_start);

ioremap happy

./include/asm-alpha/vga.h:#define VGA_MAP_MEM(x) ((unsigned long) ioremap((x), 0))
./include/asm-ia64/vga.h:#define VGA_MAP_MEM(x)	((unsigned long) ioremap((x), 0))
./include/asm-ppc64/vga.h:#define VGA_MAP_MEM(x) ((unsigned long) ioremap((x), 0))

can be ioremap happy because ioremap in io.h matches below definetions. 

./include/asm-i386/vga.h:#define VGA_MAP_MEM(x) (unsigned long)phys_to_virt(x)
./include/asm-sparc64/vga.h:#define VGA_MAP_MEM(x) (x)
./include/asm-x86_64/vga.h:#define VGA_MAP_MEM(x) (unsigned long)phys_to_virt(x)

Not happy.

./include/asm-arm/vga.h:#define VGA_MAP_MEM(x)	(PCIMEM_BASE + (x))
./include/asm-mips/vga.h:#define VGA_MAP_MEM(x)	(0xb0000000L + (unsigned long)(x))
./include/asm-ppc/vga.h:#define VGA_MAP_MEM(x) (x + vgacon_remap_base)


So you can see that VGA_MAP_MEM is already ioremapping which is causing 
the problem. Personally I like to see the lose ends fixed on ARM, MIPS, 
and PPC so we can use just ioremap.



