Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317054AbSHAUtC>; Thu, 1 Aug 2002 16:49:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317063AbSHAUtC>; Thu, 1 Aug 2002 16:49:02 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:13713 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S317054AbSHAUtB>; Thu, 1 Aug 2002 16:49:01 -0400
Date: Thu, 1 Aug 2002 14:52:16 -0600
Message-Id: <200208012052.g71KqG311998@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Willy TARREAU <willy@w.ods.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] solved APM bug with -rc5
In-Reply-To: <20020801203520.GA244@pcw.home.local>
References: <Pine.LNX.4.44.0208010336330.1728-100000@freak.distro.conectiva>
	<20020801121205.GA168@pcw.home.local>
	<20020801133202.GA200@pcw.home.local>
	<1028213732.14865.50.camel@irongate.swansea.linux.org.uk>
	<20020801135623.GA19879@alpha.home.local>
	<20020801152459.GA19989@alpha.home.local>
	<1028220826.14865.69.camel@irongate.swansea.linux.org.uk>
	<20020801203520.GA244@pcw.home.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy TARREAU writes:
> I finally got rid of it ! I now understand why it hanged randomly, and
> why I spent lots of time adding/removing unrelated patches. It's because
> in apm=power-off mode (SMP), a kernel thread is started for the apm()
> function, which does bios calls. And sometimes, the bios is called from
> CPU >0, which my bios doesn't like at all, thus explaining why the oopses
> were corrupted.
[...]
> diff -urN linux-2.4.19-rc5/arch/i386/kernel/apm.c linux-2.4.19-rc5-fix/arch/i386/kernel/apm.c
> --- linux-2.4.19-rc5/arch/i386/kernel/apm.c	Thu Aug  1 22:07:39 2002
> +++ linux-2.4.19-rc5-fix/arch/i386/kernel/apm.c	Thu Aug  1 22:26:56 2002
> @@ -1661,6 +1661,17 @@
>  	strcpy(current->comm, "kapmd");
>  	sigfillset(&current->blocked);
>  
> +#ifdef CONFIG_SMP
> +	/* 2002/08/01 - WT
> +	 * This is to avoid random crashes at boot time during initialization
> +	 * on SMP systems in case of "apm=power-off" mode. Seen on ASUS A7M266D.
> +	 * Some bioses don't like being called from CPU != 0.
> +	 */
> +	while (cpu_number_map(smp_processor_id()) != 0) {
> +		schedule();
> +	}
> +#endif
> +	

Hm. I bet you didn't try this with CONFIG_PREEMPT=y, right? IIRC, the
wonderful world of preemption means that you can get rescheduled on
another CPU without warning, unless you take a lock or explicitely
disable preemption.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
