Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270387AbRHWVMR>; Thu, 23 Aug 2001 17:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270373AbRHWVL6>; Thu, 23 Aug 2001 17:11:58 -0400
Received: from ns.suse.de ([213.95.15.193]:14350 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S270359AbRHWVL2>;
	Thu, 23 Aug 2001 17:11:28 -0400
Date: Thu, 23 Aug 2001 23:11:43 +0200
From: Olaf Hering <olh@suse.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
        Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
        Hollis Blanchard <hollis@austin.ibm.com>
Subject: Re: scr_*() audit
Message-ID: <20010823231143.A22014@suse.de>
In-Reply-To: <Pine.LNX.4.05.10108221846140.6842-100000@callisto.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.LNX.4.05.10108221846140.6842-100000@callisto.of.borg>; from geert@linux-m68k.org on Wed, Aug 22, 2001 at 07:06:12PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, Geert Uytterhoeven wrote:

> +				q++

typo :)

> diff -ur linux-2.4.8-ac9/drivers/video/hgafb.c scr-audit-2.4.8-ac9/drivers/video/hgafb.c
> --- linux-2.4.8-ac9/drivers/video/hgafb.c	Mon May 28 11:07:02 2001
> +++ scr-audit-2.4.8-ac9/drivers/video/hgafb.c	Wed Aug 22 18:48:32 2001
> @@ -203,7 +203,7 @@
>  		fillchar = 0x00;
>  	spin_unlock_irqrestore(&hga_reg_lock, flags);
>  	if (fillchar != 0xbf)
> -		memset((char *)hga_vram_base, fillchar, hga_vram_len);
> +		isa_memset_io((char *)hga_vram_base, fillchar, hga_vram_len);
>  }
>  
>  
> @@ -279,7 +279,8 @@
>  	char *logo = linux_logo_bw;
>  	for (y = 134; y < 134 + 80 ; y++) /* this needs some cleanup */
>  		for (x = 0; x < 10 ; x++)
> -			*(dest + (y%4)*8192 + (y>>2)*90 + x + 40) = ~*(logo++);
> +			isa_writeb(~*(logo++),
> +				   (dest + (y%4)*8192 + (y>>2)*90 + x + 40));
>  }

That expands to

static void hga_show_logo(void)
{
        int x, y;
        char *dest = (char *)hga_vram_base;
        char *logo = linux_logo_bw;
        for (y = 134; y < 134 + 80 ; y++)
                for (x = 0; x < 10 ; x++)
                        (*(volatile unsigned char *) ((void *)(  ((char
*)(((unsigned long)(0xC0000000) ) ))  + (
                                   (dest + (y%4)*8192 + (y>>2)*90 + x +
40) )  ))  = (  ~*(logo++)  ))  ;
}

drivers/video/hgafb.c: In function `hga_show_logo':
drivers/video/hgafb.c:297: invalid operands to binary +


I have no idea how to fix that...
its a 2.4.9 tree, but I think that makes no difference.


Gruss Olaf

-- 
 $ man clone

BUGS
       Main feature not yet implemented...
