Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265604AbSKFC23>; Tue, 5 Nov 2002 21:28:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265599AbSKFC2Y>; Tue, 5 Nov 2002 21:28:24 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:4030 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265540AbSKFC1D>;
	Tue, 5 Nov 2002 21:27:03 -0500
Subject: Re: Voyager subarchitecture for 2.5.46
From: john stultz <johnstul@us.ibm.com>
To: "J.E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200211052045.gA5KjCW04537@localhost.localdomain>
References: <200211052045.gA5KjCW04537@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 05 Nov 2002 18:31:04 -0800
Message-Id: <1036549864.6098.76.camel@cog>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-05 at 16:35, J.E.J. Bottomley wrote:
> It includes the boot GDT stuff, added configuration options for the 
> kernel/timers directory so that things which can't maintain a TSC can turn it 
> off at compile time.

Just a few comments on the CONFIG_X86_TSC changes:

> diff -Nru a/arch/i386/Kconfig b/arch/i386/Kconfig
> --- a/arch/i386/Kconfig	Tue Nov  5 15:35:01 2002
> +++ b/arch/i386/Kconfig	Tue Nov  5 15:35:01 2002
> @@ -1636,17 +1649,32 @@
>  
>  source "lib/Kconfig"
>  
> +config X86_TSC
> +	bool
> +	depends on  !VOYAGER && (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || M686 || M586MMX || M586TSC)
> +	default y
> +
> +config X86_PIT
> +	bool
> +	depends on M386 || M486 || M586 || M586TSC || VOYAGER
> +	default y
> +

I'm fine w/ the X86_TSC change, but I'd drop the X86_PIT for now. 

Then make the arch/i386/timers/Makefile change to be something like:

obj-y := timer.o timer_tsc.o timer_pit.o
obj-$(CONFIG_X86_TSC)		-= timer_pit.o #does this(-=) work?
obj-$(CONFIG_X86_CYCYLONE)	+= timer_cyclone.o


Then when you boot, boot w/ notsc and you should be fine. 

I do want to add some sort of TSC blacklisting so one doesn't always
have to boot w/ notsc if your machine is
detectable/compiled-exclusively= for. But I've got a few other issues in
the queue first. 

thanks
-john

