Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRAYDIU>; Wed, 24 Jan 2001 22:08:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135423AbRAYDIK>; Wed, 24 Jan 2001 22:08:10 -0500
Received: from goalkeeper.d2.com ([198.211.88.26]:32122 "HELO
	goalkeeper.d2.com") by vger.kernel.org with SMTP id <S129444AbRAYDIA>;
	Wed, 24 Jan 2001 22:08:00 -0500
Date: Wed, 24 Jan 2001 19:02:07 -0800
From: Greg from Systems <chandler@d2.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Peter Rival <frival@zk3.dec.com>, Richard Henderson <rth@twiddle.net>,
        linux-kernel@vger.kernel.org
Subject: Re: Big Bada Boom...
In-Reply-To: <20010124212104.A1294@jurassic.park.msu.ru>
Message-ID: <Pine.SGI.4.10.10101241900580.29904-100000@hell.d2.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry it took so long to get back to you on this:
I applied the patch and now am getting this:
alpha_ksyms.c: At top level:
alpha_ksyms.c:133: `sys_wait4' undeclared here (not in a function)
alpha_ksyms.c:133: initializer element for `__ksymtab_sys_wait4.value' is not constant
make[1]: *** [alpha_ksyms.o] Error 1
make[1]: Leaving directory `/usr/src/linux/arch/alpha/kernel'
make: *** [_dir_arch/alpha/kernel] Error 2


On Wed, 24 Jan 2001, Ivan Kokshaysky wrote:

> On Wed, Jan 24, 2001 at 08:23:13AM -0500, Peter Rival wrote:
> > Yeah, I've been bitten by this quite often.  Basically, just edit arch/alpha/kernel/Makefile and remove irq_pyxis.c from the obj-y
> > line.  I'm not positive what systems require it exactly, but rawhide isn't one of them.  I have a totally separate patch from Andrea
> > that suggests (to my mind) that it is required for: GENERIC, CIA, CABRIOLET, EV164, EB66P, LX164, PC164, MIATA, RUFFIAN and SX164.  Does
> > someone want to verify that and then a quickie patch can be whipped up and sent in.
> 
> irq_pyxis.c is needed only for generic, miata, ruffian and sx164.
> Here is also cabriolet IRQ fix and compile fix for 2.4.1-pre10.
> 
> Ivan.
> 
> --- 2.4.1p10/arch/alpha/kernel/Makefile	Sat Dec 30 01:07:19 2000
> +++ linux/arch/alpha/kernel/Makefile	Wed Jan 24 20:50:57 2001
> @@ -23,7 +23,7 @@ obj-y    := entry.o traps.o process.o os
>  # FIXME!
>  # These should be made conditional on the stuff that needs them!
>  #
> -obj-y	 += irq_i8259.o irq_srm.o irq_pyxis.o \
> +obj-y	 += irq_i8259.o irq_srm.o \
>  	    es1888.o smc37c669.o smc37c93x.o ns87312.o
>  
>  ifdef CONFIG_VGA_HOSE
> @@ -43,7 +43,7 @@ obj-y 	 += core_apecs.o core_cia.o core_
>  	    sys_jensen.o sys_miata.o sys_mikasa.o sys_nautilus.o sys_titan.o \
>  	    sys_noritake.o sys_rawhide.o sys_ruffian.o sys_rx164.o \
>  	    sys_sable.o sys_sio.o sys_sx164.o sys_takara.o sys_rx164.o \
> -	    sys_wildfire.o core_wildfire.o
> +	    sys_wildfire.o core_wildfire.o irq_pyxis.o
>  
>  else
>  
> @@ -93,6 +93,10 @@ endif
>  obj-$(CONFIG_ALPHA_SX164) += sys_sx164.o
>  obj-$(CONFIG_ALPHA_TAKARA) += sys_takara.o
>  obj-$(CONFIG_ALPHA_WILDFIRE) += sys_wildfire.o
> +
> +ifneq ($(CONFIG_ALPHA_MIATA)$(CONFIG_ALPHA_RUFFIAN)$(CONFIG_ALPHA_SX164),)
> +obj-y    += irq_pyxis.o
> +endif
>  
>  endif # GENERIC
>  
> --- 2.4.1p10/arch/alpha/kernel/sys_cabriolet.c	Fri Oct 27 21:55:01 2000
> +++ linux/arch/alpha/kernel/sys_cabriolet.c	Fri Dec 29 15:28:35 2000
> @@ -42,7 +42,7 @@ static inline void
>  cabriolet_update_irq_hw(unsigned int irq, unsigned long mask)
>  {
>  	int ofs = (irq - 16) / 8;
> -	outb(mask >> (16 + ofs*3), 0x804 + ofs);
> +	outb(mask >> (16 + ofs * 8), 0x804 + ofs);
>  }
>  
>  static inline void
> --- 2.4.1p10/arch/alpha/kernel/osf_sys.c	Mon Jan  8 18:05:38 2001
> +++ linux/arch/alpha/kernel/osf_sys.c	Wed Jan 24 16:03:18 2001
> @@ -906,7 +906,6 @@ extern int do_sys_settimeofday(struct ti
>  extern int do_getitimer(int which, struct itimerval *value);
>  extern int do_setitimer(int which, struct itimerval *, struct itimerval *);
>  asmlinkage int sys_utimes(char *, struct timeval *);
> -extern int sys_wait4(pid_t, int *, int, struct rusage *);
>  extern int do_adjtimex(struct timex *);
>  
>  struct timeval32
> --- 2.4.1p10/arch/alpha/kernel/signal.c	Sun Sep  3 22:48:33 2000
> +++ linux/arch/alpha/kernel/signal.c	Wed Jan 24 16:05:14 2001
> @@ -30,7 +30,6 @@
>  
>  #define _BLOCKABLE (~(sigmask(SIGKILL) | sigmask(SIGSTOP)))
>  
> -asmlinkage int sys_wait4(int, int *, int, struct rusage *);
>  asmlinkage void ret_from_sys_call(void);
>  asmlinkage int do_signal(sigset_t *, struct pt_regs *,
>  			 struct switch_stack *, unsigned long, unsigned long);
> --- 2.4.1p10/include/asm-alpha/unistd.h	Mon Jan 22 19:47:59 2001
> +++ linux/include/asm-alpha/unistd.h	Wed Jan 24 15:46:56 2001
> @@ -572,7 +572,6 @@ static inline long sync(void)
>  	return sys_sync();
>  }
>  
> -extern long sys_wait4(int, int *, int, struct rusage *);
>  static inline pid_t waitpid(int pid, int * wait_stat, int flags)
>  {
>  	return sys_wait4(pid, wait_stat, flags, NULL);
> 

----------------------------------------------------------------------------

IGNOTUM PER IGNOTIUS

"Grasshopper always wrong in argument with chicken"

The "socratic approach" is what you call starting an argument by
asking questions.

The human race will begin solving it's problems on the day that it 
ceases taking itself so seriously.

                                        PRINCIPIA DISCORDIA


                Published by POEE Head Temple - San Francisco
                      " On The Future Site of Beautiful
                             San Andreas Canyon"


                                                Please do not use this
                                                document as toilet tissue
Fnord


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
