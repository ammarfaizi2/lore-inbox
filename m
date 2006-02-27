Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWB0BB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWB0BB5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 20:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWB0BB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 20:01:56 -0500
Received: from xproxy.gmail.com ([66.249.82.196]:45196 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750701AbWB0BB4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 20:01:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=iOvK+ZyRemPFBiuasdUSieaQo08nQ7Ijq/yIKCffFIBKTMl747yXzicLX3qjg+vd/MSqHvSCAYT78yYj1UpHr6rHJuzo44m+RtoykNtyAVkS4pHiTCmK71SV5a9MbOHsLNgd7hoP3Pwtbg3njMLO5NWMyvGolE7kkEgnNxJrQMY=
Subject: Re: OOM-killer too aggressive?
From: Chris Largret <largret@gmail.com>
Reply-To: largret@gmail.com
To: Andrew Morton <akpm@osdl.org>
Cc: 76306.1226@compuserve.com, linux-kernel@vger.kernel.org, axboe@suse.de,
       ak@muc.de
In-Reply-To: <20060226162040.cb72bc31.akpm@osdl.org>
References: <200602260938_MC3-1-B94B-EE2B@compuserve.com>
	 <20060226102152.69728696.akpm@osdl.org>
	 <1140988015.5178.15.camel@shogun.daga.dyndns.org>
	 <20060226133140.4cf05ea5.akpm@osdl.org>
	 <1140994821.5522.9.camel@shogun.daga.dyndns.org>
	 <20060226162040.cb72bc31.akpm@osdl.org>
Content-Type: text/plain
Date: Sun, 26 Feb 2006 17:01:52 -0800
Message-Id: <1141002112.17427.4.camel@shogun.daga.dyndns.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 Dropline GNOME 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-26 at 16:20 -0800, Andrew Morton wrote:

> Sigh.  The floppy driver's just a jpke.  Looks like the failed allocation
> fell back to vmalloc then screwed it up.

> You could try this one instead, although I guess I'll need to fire up the
> test box for this bug.

> --- devel/include/asm-x86_64/floppy.h~b	2006-02-26 16:15:44.000000000 -0800
> +++ devel-akpm/include/asm-x86_64/floppy.h	2006-02-26 16:16:21.000000000 -0800
> @@ -40,7 +40,7 @@
>  #define fd_disable_irq()        disable_irq(FLOPPY_IRQ)
>  #define fd_free_irq()		free_irq(FLOPPY_IRQ, NULL)
>  #define fd_get_dma_residue()    SW._get_dma_residue(FLOPPY_DMA)
> -#define fd_dma_mem_alloc(size)	SW._dma_mem_alloc(size)
> +#define fd_dma_mem_alloc(size)	__alloc_pages(GFP_KERNEL|__GFP_DMA32, get_order(size))
>  #define fd_dma_setup(addr, size, mode, io) SW._dma_setup(addr, size, mode, io)
>  
>  #define FLOPPY_CAN_FALLBACK_ON_NODMA

CC      drivers/block/floppy.o
drivers/block/floppy.c: In function `raw_cmd_copyin':
drivers/block/floppy.c:3245: error: too few arguments to function
`__alloc_pages'
drivers/block/floppy.c: In function `floppy_open':
drivers/block/floppy.c:3738: error: too few arguments to function
`__alloc_pages'
drivers/block/floppy.c:3742: error: too few arguments to function
`__alloc_pages'
make[2]: *** [drivers/block/floppy.o] Error 1
make[1]: *** [drivers/block] Error 2
make: *** [drivers] Error 2


I'm sorry, but I'm not sure where to start for looking up the definition
for __alloc_pages().

--
Chris Largret <http://daga.dyndns.org>

