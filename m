Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268133AbRGWDhc>; Sun, 22 Jul 2001 23:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268134AbRGWDhX>; Sun, 22 Jul 2001 23:37:23 -0400
Received: from h-216-81-19-022.fast.escape.ca ([216.81.19.22]:1540 "EHLO
	black.pepper") by vger.kernel.org with ESMTP id <S268132AbRGWDhH>;
	Sun, 22 Jul 2001 23:37:07 -0400
Date: Sun, 22 Jul 2001 22:38:35 -0500 (CST)
From: Daryl F <wyatt@escape.ca>
To: Keith Owens <kaos@ocs.com.au>
cc: Daryl F <wyatt@escape.ca>, <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.4.6/2.4.7 won't boot ASUS P2-99B 
In-Reply-To: <5924.995808798@ocs3.ocs-net>
Message-ID: <Pine.LNX.4.32.0107222230330.5430-100000@black.pepper>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Well the patch made my day. I was able to locate the source of my problem.
I had copied a stanza from my /etc/lilo.conf for 2.4.5 kernel that
contained this append statement:

append="devfs=dmod,dreg,dunreg,dchange,dimknod,mount,show idebus=66"

Trouble was I didn't define the devfs debug option when I configured the
kernel. It wasn't defined in 2.4.5 either but did not cause the problem.
I removed all the devfs options except mount and show and the kernel
booted up fine. I verified the inverse by recompiling the kernel with the
devfs debug option configured. The above append= worked fine then and that
kernel booted fine too.

I have to do some more studying to figure out why the kernel just
rebooted instead of ignoring the irrelevant options, but it will make for
a nice learning exercies.

Nice piece of work that patch you made. Thanks for your help.

Daryl.

On Sun, 22 Jul 2001, Keith Owens wrote:

> On Sat, 21 Jul 2001 23:39:51 -0500 (CST),
> Daryl F <wyatt@escape.ca> wrote:
> >I am at an impasse. I can't get kernel 2.4.6 or 2.4.7 to boot on my ASUS
> >P2-99B. 2.4.5 works fine.
> >I've run out of things to check. Any ideas how to get some kind of
> >diagnostic info or anything else I should check?
>
> Time for another version of my VIDEO_CHAR patch.
>
> If a kernel hangs early in the boot process (before the console has
> been initialized) then printk is no use because you never see the
> output.  There is a technique for using the video display to indicate
> boot progress so you can localize the problem.  Reporting "my kernel
> hangs during boot at line nnn in routine xyz" is a lot better than "my
> kernel hangs during boot".
>
> The idea is to write characters direct to the video screen during
> booting using a macro called VIDEO_CHAR.  This macro takes a character
> position and a single character value to be displayed.  Use different
> positions on the screen for different levels of code and use different
> characters in one position to indicate which stage that level is up to.
> For example, with the patch below, the string EAC at hang indicates
> parse_options(), checksetup().
>
> The patch below is generic, except for the definition of VIDEO_CHAR
> which is ix86 specific.  If this patch ever becomes part of the main
> kernel then VIDEO_CHAR needs to be moved to an arch specific header.
> If any arch other than ix86 uses this technique, please mail
> kaos@ocs.com.au with your definition of VIDEO_CHAR.
>
> You can plant VIDEO_CHAR calls anywhere you like, up to the call to
> mem_init().  After mem_init has done its work and memory has been
> remapped, VIDEO_CHAR cannot write to video memory, it will oops.
> However by then the console has been initialized so you can use printk.
>
> Demonstration patch against 2.4.7.  This only uses screen positions 0,
> 1, 2.  If you want to drill down into lower level routines, just use
> screen positions 3 onwards.  To activate the debugging, add
>   #define DEBUG_VIDEO_CHAR
> to the start of init/main.c.  If the machine is hanging then a zero
> delay is fine, if it is rebooting then you need a delay to note the
> characters in the top left hand corner of the screen before it reboots.
>   #define VIDEO_CHAR_DELAY_COUNT 100000000
> A value around your clock speed gives a delay of approx. 1 second.
>
> Index: 7.9/init/main.c
> --- 7.9/init/main.c Fri, 06 Jul 2001 09:49:24 +1000 kaos (linux-2.4/k/11_main.c 1.1.5.1.1.8.1.3 644)
> +++ 7.9(w)/init/main.c Sun, 22 Jul 2001 23:27:38 +1000 kaos (linux-2.4/k/11_main.c 1.1.5.1.1.8.1.3 644)
> @@ -80,6 +80,16 @@ extern int irda_device_init(void);
>  #error Sorry, your GCC is too old. It builds incorrect kernels.
>  #endif
>
> +#ifdef DEBUG_VIDEO_CHAR
> +#ifndef VIDEO_CHAR_DELAY_COUNT
> +#define VIDEO_CHAR_DELAY_COUNT 0
> +#endif
> +/* ix86 specific */
> +#define VIDEO_CHAR(c, v) { int i; *((volatile char *)(0xb8000 + 2*(c))) = (v); for (i = 0; i < VIDEO_CHAR_DELAY_COUNT; ++i) ; }
> +#else
> +#define VIDEO_CHAR(c, v)
> +#endif
> +
>  extern char _stext, _etext;
>  extern char *linux_banner;
>
> @@ -421,12 +431,14 @@ static void __init parse_options(char *l
>  	char *next,*quote;
>  	int args, envs;
>
> +	VIDEO_CHAR(1, 'A');
>  	if (!*line)
>  		return;
>  	args = 0;
>  	envs = 1;	/* TERM is set to 'linux' by default */
>  	next = line;
>  	while ((line = next) != NULL) {
> +		VIDEO_CHAR(2, 'A');
>                  quote = strchr(line,'"');
>                  next = strchr(line, ' ');
>                  while (next != NULL && quote != NULL && quote < next) {
> @@ -439,9 +451,11 @@ static void __init parse_options(char *l
>                                  next = strchr(next+1, ' ');
>                          }
>                  }
> +		VIDEO_CHAR(2, 'B');
>                  if (next != NULL)
>                          *next++ = 0;
>  		if (!strncmp(line,"init=",5)) {
> +			VIDEO_CHAR(3, 'A');
>  			line += 5;
>  			execute_command = line;
>  			/* In case LILO is going to boot us with default command line,
> @@ -452,8 +466,10 @@ static void __init parse_options(char *l
>  			args = 0;
>  			continue;
>  		}
> +		VIDEO_CHAR(2, 'C');
>  		if (checksetup(line))
>  			continue;
> +		VIDEO_CHAR(2, 'D');
>
>  		/*
>  		 * Then check if it's an environment variable or
> @@ -469,9 +485,12 @@ static void __init parse_options(char *l
>  			if (*line)
>  				argv_init[++args] = line;
>  		}
> +		VIDEO_CHAR(2, 'E');
>  	}
> +	VIDEO_CHAR(1, 'B');
>  	argv_init[args+1] = NULL;
>  	envp_init[envs+1] = NULL;
> +	VIDEO_CHAR(1, 'C');
>  }
>
>
> @@ -530,16 +549,27 @@ asmlinkage void __init start_kernel(void
>   * Interrupts are still disabled. Do necessary setups, then
>   * enable them
>   */
> +	VIDEO_CHAR(0, 'A');
>  	lock_kernel();
> +	VIDEO_CHAR(0, 'B');
>  	printk(linux_banner);
> +	VIDEO_CHAR(0, 'C');
>  	setup_arch(&command_line);
> +	VIDEO_CHAR(0, 'D');
>  	printk("Kernel command line: %s\n", saved_command_line);
> +	VIDEO_CHAR(0, 'E');
>  	parse_options(command_line);
> +	VIDEO_CHAR(0, 'F');
>  	trap_init();
> +	VIDEO_CHAR(0, 'G');
>  	init_IRQ();
> +	VIDEO_CHAR(0, 'H');
>  	sched_init();
> +	VIDEO_CHAR(0, 'I');
>  	softirq_init();
> +	VIDEO_CHAR(0, 'J');
>  	time_init();
> +	VIDEO_CHAR(0, 'K');
>
>  	/*
>  	 * HACK ALERT! This is early. We're enabling the console before
> @@ -547,8 +577,10 @@ asmlinkage void __init start_kernel(void
>  	 * this. But we do want output early, in case something goes wrong.
>  	 */
>  	console_init();
> +	VIDEO_CHAR(0, 'L');
>  #ifdef CONFIG_MODULES
>  	init_modules();
> +	VIDEO_CHAR(0, 'M');
>  #endif
>  	if (prof_shift) {
>  		unsigned int size;
> @@ -559,10 +591,14 @@ asmlinkage void __init start_kernel(void
>  		size = prof_len * sizeof(unsigned int) + PAGE_SIZE-1;
>  		prof_buffer = (unsigned int *) alloc_bootmem(size);
>  	}
> +	VIDEO_CHAR(0, 'N');
>
>  	kmem_cache_init();
> +	VIDEO_CHAR(0, 'O');
>  	sti();
> +	VIDEO_CHAR(0, 'P');
>  	calibrate_delay();
> +	VIDEO_CHAR(0, 'Q');
>  #ifdef CONFIG_BLK_DEV_INITRD
>  	if (initrd_start && !initrd_below_start_ok &&
>  			initrd_start < min_low_pfn << PAGE_SHIFT) {
> @@ -570,6 +606,7 @@ asmlinkage void __init start_kernel(void
>  		    "disabling it.\n",initrd_start,min_low_pfn << PAGE_SHIFT);
>  		initrd_start = 0;
>  	}
> +	VIDEO_CHAR(0, 'R');
>  #endif
>  	mem_init();
>  	kmem_cache_sizes_init();
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>


