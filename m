Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbWFVGcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbWFVGcO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 02:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932277AbWFVGcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 02:32:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:55020 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932267AbWFVGcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 02:32:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TsRICdt6aW11nehVwZDiKItzwX4/4u/X+DfepS4vb24QXuIeXgTHINkApt8g4npwEXviHR6yoP7XU/WB10GflUd6G/RFLo//C21jLBFKbb+iXr0dTfYFnfUzCBk9/nVwQl2XeQ0gD2wqtlS6r4WxfzFBAkTiB/T6UGaf455EMrE=
Message-ID: <69304d110606212332t3781bbf6g28ce33cca79a8bb0@mail.gmail.com>
Date: Thu, 22 Jun 2006 08:32:12 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: CONFIG_VGACON_SOFT_SCROLLBACK crashes 2.6.17
Cc: "Al Boldi" <a1426z@gawab.com>, linux-kernel@vger.kernel.org
In-Reply-To: <4499E89F.6030509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200606211715.58773.a1426z@gawab.com> <44996332.5090408@gmail.com>
	 <200606220005.32446.a1426z@gawab.com> <4499E89F.6030509@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/22/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Al Boldi wrote:
> > Antonino A. Daplas wrote:
> >> Al Boldi wrote:
> >>> Enabling CONFIG_VGACON_SOFT_SCROLLBACK causes random fatal system
> >>> freezes.
> >>>
> >>> Especially, ping 10.1 -A easily causes a complete system hang during
> >>> scroll.
> >>>
> >>> Is there an easy way to fix this, other than disabling the option?
> >> I can't duplicate your problem. Did it ever work before?
> >
> > This option did not exist before 2.6.17.
>
> I meant if you tried any of the -rc kernels.
>
> Anyway, can you try the patch below.  It's a debugging patch and
> it will slow down the console.
>
> If the system hang disappears, remove the line
>
>     while (i--);
>
> in include/linux/vt_buffer.h.  This line is introduced by
> the patch below.
>
> Let me know at what point it worked, or whether it worked at all.
>
> >
> >> Can you send me you kernel config?
> >
> > Attached below.
> >
> > BTW, is there any chance to patch your savagefb to support VIA/S3 UniChrome?
> >
>
> If someone posts a patch to lkml or fbdev-devel, why not?  But a separate
> driver is probably better as the 2 are very different.
>
> Tony
>
> diff --git a/include/linux/vt_buffer.h b/include/linux/vt_buffer.h
> index 057db7d..e9b6064 100644
> --- a/include/linux/vt_buffer.h
> +++ b/include/linux/vt_buffer.h
> @@ -20,11 +20,21 @@ #endif
>
>  #ifndef VT_BUF_HAVE_RW
>  #define scr_writew(val, addr) (*(addr) = (val))
> -#define scr_readw(addr) (*(addr))
> -#define scr_memcpyw(d, s, c) memcpy(d, s, c)
> -#define scr_memmovew(d, s, c) memmove(d, s, c)
> -#define VT_BUF_HAVE_MEMCPYW
> -#define VT_BUF_HAVE_MEMMOVEW
> +//#define scr_readw(addr) (*(addr))
> +
> +static inline u16 scr_readw(volatile const u16 *addr)
> +{
> +    int i = 10000;
> +    u16 val = *addr;
> +
> +    while (i--);
> +    return val;
> +}
> +
> +//#define scr_memcpyw(d, s, c) memcpy(d, s, c)
> +//#define scr_memmovew(d, s, c) memmove(d, s, c)
> +#undef VT_BUF_HAVE_MEMCPYW
> +#undef VT_BUF_HAVE_MEMMOVEW
>  #endif
>
>  #ifndef VT_BUF_HAVE_MEMSETW

Antonino, is this while(i--) a cpu busy-wait loop??? This would have
different timings on different cpu kinds... maybe a short usleep()?
