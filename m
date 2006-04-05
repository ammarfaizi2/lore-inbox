Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWDEViq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWDEViq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 17:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbWDEViq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 17:38:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:47252 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751081AbWDEVip (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 17:38:45 -0400
Date: Wed, 5 Apr 2006 14:37:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Luck, Tony" <tony.luck@intel.com>
Cc: bjorn.helgaas@hp.com, nanhai.zou@intel.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, "Antonino A. Daplas" <adaplas@pol.net>
Subject: Re: 2.6.17-rc1-mm1
Message-Id: <20060405143727.2b2fde15.akpm@osdl.org>
In-Reply-To: <20060405211757.GA8536@agluck-lia64.sc.intel.com>
References: <20060404014504.564bf45a.akpm@osdl.org>
	<20060404233851.GA6411@agluck-lia64.sc.intel.com>
	<1144202706.3197.11.camel@linux-znh>
	<200604051015.34217.bjorn.helgaas@hp.com>
	<20060405211757.GA8536@agluck-lia64.sc.intel.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> wrote:
>
> On Wed, Apr 05, 2006 at 10:15:34AM -0600, Bjorn Helgaas wrote:
> > Huh.  Intel firmware used to just not mention the VGA framebuffer
> > (0xa0000-0xc0000) at all in the EFI memory map.  I think that was
> > clearly a bug.  So maybe they fixed that by marking it WB (and
> > hopefully UC as well).
> 
> Nope ... not fixed (at least not in the f/w that I'm running). The
> VGA buffer is still simply not mentioned in the EFI memory map.
> 
> The problem looks to come from this code in vgacon.c:
> 
> 	vga_vram_base = VGA_MAP_MEM(vga_vram_base);
> 	vga_vram_end = VGA_MAP_MEM(vga_vram_end);
> 	vga_vram_size = vga_vram_end - vga_vram_base;
> 
> vga_vram_base is 0xb8000, and this call gets a UC return of
> c0000000000b8000.  But vga_vram_end is 0xc0000 ... which is
> the address of the start of a block of memory that is both
> WB and UC capable.

OK, so it's really an off-by-one error.

>  So ioremap() gives us e0000000000c0000
> (which means that vga_vram_size is 2000000000008000, surely
> the biggest, baddest video card in the history of the world!).
> 
> Perhaps the right fix is to subtract 1 from vga_vram_end and pass
> that into VGA_MAP_MEM(), and then add the 1 byte back when computing
> the size?  But I don't know whether that might do something bad on
> some other architecture that uses vgacon.c.  If this is not
> acceptable, then we can fall back and use the Nanhai/Bjorn fix
> of using ioremap_nocache().
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> 
> ---
> 
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
> index d5a04b6..4ca9877 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -484,8 +484,8 @@ #endif
>  	}
>  
>  	vga_vram_base = VGA_MAP_MEM(vga_vram_base);
> -	vga_vram_end = VGA_MAP_MEM(vga_vram_end);
> -	vga_vram_size = vga_vram_end - vga_vram_base;
> +	vga_vram_end = VGA_MAP_MEM(vga_vram_end - 1);
> +	vga_vram_size = vga_vram_end - vga_vram_base + 1;
>  
>  	/*
>  	 *      Find out if there is a graphics card present.

Looks like the correct fix to me.

Tony (D), can you think of any problems with that approach?
