Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262062AbSJZKdR>; Sat, 26 Oct 2002 06:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262154AbSJZKdC>; Sat, 26 Oct 2002 06:33:02 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:32780 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262062AbSJZKYV>; Sat, 26 Oct 2002 06:24:21 -0400
X-Envelope-From: pavel@bug.ucw.cz
Date: Mon, 21 Oct 2002 11:08:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Hiroshi Miura <miura@da-cha.org>
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org
Subject: Re: APM work around for bad bios.
Message-ID: <20021021090819.GA2876@elf.ucw.cz>
References: <20021017172155.BCA3F11782A@triton2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021017172155.BCA3F11782A@triton2>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I use CASIO CASSIOPEIA FIVA 101 and 103. (http://www.da-cha.org/fiva/fiva.html)
> this use Cyrix MediaGX and Award BIOS.
> This APM BIOS report broken value for dseg_len.
> it asumes granularity is 1.
> 
> I made a work around for this situation.
> 
>   *  if (cseg_len < bios.offset) BIOS report BAD len value.
>      -- segment length must be always larger than code offset
> 
>   *  if (dseg_len <= 0x40 ) BIOS asumes granularity =1.
>      -- 0x40 * 4kB = 64kB, my pc reports 0x40.
> 
> 
> diff -urB -x .config -x '*.[oasS]' -x '*.in' -x '*.rej' -x '*.orig' linux-2.5.43-orig/arch/i386/kernel/apm.c linux-2.5.43/arch/i386/kernel/apm.c
> --- linux-2.5.43-orig/arch/i386/kernel/apm.c	2002-10-12 13:21:05.000000000 +0900
> +++ linux-2.5.43/arch/i386/kernel/apm.c	2002-10-14 21:36:14.000000000 +0900
> @@ -1980,6 +2141,14 @@
>  				(apm_info.bios.cseg_16_len - 1) & 0xffff);
>  			_set_limit((char *)&cpu_gdt_table[i][APM_DS >> 3],
>  				(apm_info.bios.dseg_len - 1) & 0xffff);
> +		      /* workaround for broken BIOSes */
> +	                if (apm_info.bios.cseg_len <= apm_info.bios.offset)
> +        	                _set_limit((char *)&cpu_gdt_table[i][APM_CS >> 3], 64 * 1024 -1);

Maybe add printk KERN_WARNING "apm: broken bios -- code segment too
short, assuming 64k"

> +                       if (apm_info.bios.dseg_len <= 0x40) { /* 0x40 * 4kB == 64kB */
> +                        	/* for the BIOS that assumes granularity = 1 */
> +                        	cpu_gdt_table[i][APM_DS >> 3].b |= 0x800000;
> +                        	printk(KERN_NOTICE "apm: we set the
> granularity of dseg.\n");

Maybe better KERN_WARNING "apm: broken bios -- assuming granularity 1
on dseg"
										Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
