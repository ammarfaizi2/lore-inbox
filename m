Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWJEFem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWJEFem (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 01:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWJEFem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 01:34:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:45025 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751485AbWJEFel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 01:34:41 -0400
Subject: Re: [PATCH] powerpc: Enable DEEPNAP power savings mode on 970MP
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
Cc: paulus@samba.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20061004234141.749b13fb@localhost.localdomain>
References: <20061004234141.749b13fb@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 05 Oct 2006 15:34:24 +1000
Message-Id: <1160026464.22232.16.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-10-04 at 23:41 -0500, Olof Johansson wrote:
> Hi,
> 
> Without this patch, on an idle system I get:
> 
> cpu-power-0:21.638
> cpu-power-1:27.102
> cpu-power-2:29.343
> cpu-power-3:25.784
> Total: 103.8W
> 
> With this patch:
> 
> cpu-power-0:11.730
> cpu-power-1:17.185
> cpu-power-2:18.547
> cpu-power-3:17.528
> Total: 65.0W
> 
> If I lower HZ to 100, I can get it as low as:
> 
> cpu-power-0:10.938
> cpu-power-1:16.021
> cpu-power-2:17.245
> cpu-power-3:16.145
> Total: 60.2W
> 
> Another (older) Quad G5 went from 54W to 39W at HZ=250.
> 
> Coming back out of Deep Nap takes 40-70 cycles longer than coming back
> from just Nap (which already takes quite a while). I don't think it'll
> be a performance issue (interrupt latency on an idle system), but in
> case someone does measurements feel free to report them.

Isn't deep nap supposed to only get entered from F/4 which we never
use ?

Ben confused...


> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> 
> 
> 
> Index: linux-2.6/arch/powerpc/kernel/cpu_setup_ppc970.S
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/kernel/cpu_setup_ppc970.S
> +++ linux-2.6/arch/powerpc/kernel/cpu_setup_ppc970.S
> @@ -83,6 +83,22 @@ _GLOBAL(__setup_cpu_ppc970)
>  	rldimi	r0,r11,52,8		/* set NAP and DPM */
>  	li	r11,0
>  	rldimi	r0,r11,32,31		/* clear EN_ATTN */
> +	b	load_hids		/* Jump to shared code */
> +
> +
> +_GLOBAL(__setup_cpu_ppc970MP)
> +	/* Do nothing if not running in HV mode */
> +	mfmsr	r0
> +	rldicl.	r0,r0,4,63
> +	beqlr
> +
> +	mfspr	r0,SPRN_HID0
> +	li	r11,0x15		/* clear DOZE and SLEEP */
> +	rldimi	r0,r11,52,6		/* set DEEPNAP, NAP and DPM */
> +	li	r11,0
> +	rldimi	r0,r11,32,31		/* clear EN_ATTN */
> +
> +load_hids:
>  	mtspr	SPRN_HID0,r0
>  	mfspr	r0,SPRN_HID0
>  	mfspr	r0,SPRN_HID0
> Index: linux-2.6/arch/powerpc/kernel/cputable.c
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/kernel/cputable.c
> +++ linux-2.6/arch/powerpc/kernel/cputable.c
> @@ -41,6 +41,7 @@ extern void __setup_cpu_745x(unsigned lo
>  #endif /* CONFIG_PPC32 */
>  #ifdef CONFIG_PPC64
>  extern void __setup_cpu_ppc970(unsigned long offset, struct cpu_spec* spec);
> +extern void __setup_cpu_ppc970MP(unsigned long offset, struct cpu_spec* spec);
>  extern void __restore_cpu_ppc970(void);
>  #endif /* CONFIG_PPC64 */
>  
> @@ -221,7 +222,7 @@ struct cpu_spec	cpu_specs[] = {
>  		.icache_bsize		= 128,
>  		.dcache_bsize		= 128,
>  		.num_pmcs		= 8,
> -		.cpu_setup		= __setup_cpu_ppc970,
> +		.cpu_setup		= __setup_cpu_ppc970MP,
>  		.cpu_restore		= __restore_cpu_ppc970,
>  		.oprofile_cpu_type	= "ppc64/970",
>  		.oprofile_type		= PPC_OPROFILE_POWER4,
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

