Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbTLVSiJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 13:38:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263060AbTLVSiD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 13:38:03 -0500
Received: from cpc3-hitc2-5-0-cust116.lutn.cable.ntl.com ([81.99.82.116]:40074
	"EHLO zog.reactivated.net") by vger.kernel.org with ESMTP
	id S262848AbTLVShI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 13:37:08 -0500
Message-ID: <3FE73CF6.4030207@reactivated.net>
Date: Mon, 22 Dec 2003 18:50:30 +0000
From: Daniel Drake <dan@reactivated.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ross@datscreative.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: Updated Lockup Patches, 2.6.0 Nforce2, apic timer ack delay,
 ioapic edge for NMI debug
References: <200312211917.05928.ross@datscreative.com.au>
In-Reply-To: <200312211917.05928.ross@datscreative.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I compiled 2.6.0-test11-mm1, with local APIC and IO-APIC (I hadn't used these 
options before) and I encountered a complete system freeze after about 10 mins 
of "basic" (mozilla, xmms) usage. Never had any stability problems on this 
system at all, before that freeze. I then recompiled the kernel with your 
patches and since then it's been fine.

Would your patches (by default) have influenced this? I have yet to play around 
with apic_tack - would me testing this be useful?

Hardware: AMD 2600+ throughbred, Abit NF7-S V2.0, DDR333 Corsair RAM.

-Daniel

Ross Dickson wrote:
> Firstly I thought a summary overdue so here goes.
> 
> My speculations as to why Nforce2 systems lock up are as follows:
> 
> a) The Nforce2 DASP speculates and gets it right, pre-fetching the code for the
>  local apic timer interrupt, so the interrupt code executes sooner after
>  activation than it does with other chipsets for AMD. 
> 
> b) The AMD cpu may not be over its timing and stability issues when coming
>  out of C1 disconnect. Plenty stable soon enough for other chipsets and other
>  codepaths in linux which pull the cpu out of C1 disconnect, but not quite soon
>  enough for the "cached" short code path to the local apic timer ack. So most
>  of the time any latent lockup potential is not realised, but on occasion 
>  we hit it.
> 
> Disclaimer: I can think of so many ways I could be way off so I have a support
> request in with AMD on the topic which I am told is progressing. I do not have
> the resources to be able to confirm or deny the above theory. Patches are 
> GPL'ed as per the licenses of the files they go into.
> 
> 
>   Are my patches the only way to workaround lockups?
> NO Firstly I think the manufacturers will fix the problem so I will not have to
> use any workarounds one day. There are early reports that recent Award bios's
> are fixing the lockup issue but not the nmi_watchdog problem.
> 
> Others advise you can successfully use the C1 disconnect patch for the kernel,
> also Athcool. Some bios also have options to alter the C1 Disconnect
> state and some early bios are preset with it to always off. If the lockups would
> only occur with disconnect on (yet to be confirmed or denied by manufacturers)
> then this would be one sure way to stop them.
> 
>   Why don't you just disable the C1 disconnect?
> I don't think it would be wise for me to frob with it for many reasons. Nvidia
> has some seriously patented smarts in their ram controllers, and the ambient
> temperature today, where I am, rose to 30C or about 85F and it gets hotter. I 
> also have a system in the north of Western Australia where 40C+ summer is 
> normal. The AMD processor data sheet says that the CPU only enters low power
> state if it can disconnect. Web postings indicate 8C to 10C temperature increase
> with disconnect disabled.
> 
>   Do my patches Fix all of it?
> No they are just workarounds. How well they work around may depend upon your
> system configuration, and how well the delay times chosen suit it.
> 
>   Any evil side effects?
> Maybe, but I don't know of any yet. Any slowing from the delay is so far 
> not noticeable.
> 
>   Why 2 patches?
> The apic timer ack delay patch is for the hard lockups.
> The io-apic edge patch is for lost interrupts and also gives nmi_watchdog=1
> functionality.
> 
>   Should I install any or both?
> Depends, you get to decide until the manufacturers fix it.
> 
> The io-apic edge seems beneficial to all Nforce2 so far as the bios reports the
> 8254 timer connected to INTIN2. I found it connected directly to INTIN0.
> The patch forces connection to INTIN0 to see if it works only after the existing 
> code has tried to connect it to where the bios said it was. The io-apic patch
> compiles in only with acpi on and uniprocessor x86 io-apic on in kern config. 
> The acpi config is essential as we use part of it, the uniprocessor x86 io-apic
> is there as a precaution and if the patch is more widely tested it may not be
> required. Remove it if you want the patch in smp mode.
> 
> The apic timer ack is not needed if you do not have hard lockups and you can
> solve the hard lockups by other means if you want to. I do not recommend kern
> config of apic without io-apic for nforce2. The two work best together and if 
> you use my apic timer ack delay patch then use my io-apic edge patch with it
> for best results.
> 
> This version of the apic timer ack delay patch is not on by default. You need
> to use a kernel argument at boot time to invoke it and there are two forms.
> 
> apic_tack=1
> 
> puts a small delay inline with the code. It is the reliable fallback mode.
> 
> apic_tack=2
> 
> reads the apic timer count and only delays if needed to prevent a lockup. This
> mode assumes it is always safe to read the apic timer count register but 
> unsafe at times to ack it. This assumption could be wrong.
> 
> I find apic_tack=1 better at stopping hard lockups on my T/bred XP2200 
> (266fsb DDR400 ram) system with my patched 2.4.23 kern but apic_tack=2 ok
> with 2.6.0 on same machine? I also note 2.4.23 gives me 53Mb/s and 2.6.0 only
> 47Mb/s with hdparm -t /dev/hda testing.
> 
>  Other kernel versions?
> It should work fine with 2.4.22 and 2.4.23 although you will probably have to hand
> patch them for now.
> 
>  Historical postings on the topic?
> Heaps, many thanks to those who have tested and contributed so far.
> Primary thread on this topic for my patches
>  Fixes for nforce2 hard lockup, apic, io-apic, udma133 covered
> and another useful discussion
>  Catching NForce2 lockup with NMI watchdog
> 
>  Debugging output?
> Ioapic patch always reports success or otherwise as part of check_timer if
> it is needed such as:
> ..TIMER: vector=0x31 pin1=2 pin2=-1
> ..MP-BIOS bug: 8254 timer not connected to IO-APIC INTIN2
> ..TIMER: Is timer irq0 connected to IO-APIC INTIN0? ...
> IOAPIC[0]: Set PCI routing entry (2-0 -> 0x31 -> IRQ 0 Mode:0 Active:0)
> ..TIMER: works OK on IO-APIC INTIN0 irq0
> 
> None for apic ackdelay apic_tack=0 or apic_tack=1
>  
> apic_tack=2 always reports:
> ..APIC TIMER ack delay, reload:16701, safe:16691
> 
> but numbers vary with your fsb.
> reload is your existing local timer 1ms reload count.
> safe is the down count at which about 800ns has expired since reload. Patch
> considers it safe to ack after that time.
> 
> More can be had if 
> #define APIC_DEBUG 0 
> is set to 1 in 
> /usr/src/linux-2.4.23-rd2/include/asm-i386/apic.h 
> 
> The io-apic patch will also display the 8259a xtpic interrupt mask.
> I get hex fb and hex ff indicating that the only int enabled on the 8259A xtpic
> which handles irq 0-7 is the cascade irq 2 which is OK because on the other
> 8259A irq 8-15 are masked. This masked xtpic should always be the case. 
> We want the 8259A off during our test to see if the 8254 timer is connected
> directly to pin 0 of the ioapic. 
> 
> The apic ack delay patch will report at boot ten pre delay apic timer times to
> get a feel as to whether the delay had to kick in or not. Note that this is a 
> very small sample size but it does give an idea of the timing numbers. 
> 
> Following are my apic and ioapic patches for 2.6.0.
> bzip also attached.
> 
> Regards
> Ross Dickson.
> 
> local apic timer ack delay:
> 
> --- CUT HERE ---
> --- linux-2.6.0/arch/i386/kernel/apic.c	2003-12-18 12:59:58.000000000 +1000
> +++ linux-2.6.0-rd/arch/i386/kernel/apic.c	2003-12-21 12:39:28.000000000 +1000
> @@ -1070,10 +1070,17 @@ inline void smp_local_timer_interrupt(st
>  	 * we can take more than 100K local irqs per second on a 100 MHz P5.
>  	 */
>  }
>  
>  /*
> + * Athlon nforce2 R.D.
> + * preset timer ack mode if desired
> + * e.g. static int apic_timerack = 2;
> +*/
> +static int apic_timerack;
> +
> +/*
>   * Local APIC timer interrupt. This is the most natural way for doing
>   * local interrupts, but local timer interrupts can be emulated by
>   * broadcast interrupts too. [in case the hw doesn't support APIC timers]
>   *
>   * [ if a single-CPU system runs an SMP kernel then we call the local
> @@ -1088,10 +1095,54 @@ void smp_apic_timer_interrupt(struct pt_
>  	 * the NMI deadlock-detector uses this.
>  	 */
>  	irq_stat[cpu].apic_timer_irqs++;
>  
>  	/*
> +	* Athlon nforce2 timer ack delay.  Ross Dickson.
> +	* works around issue of hard lockups in code location
> +	* where linux exposes underlying system timing fault?
> +	* hopefully manufacturers will fix it soon.
> +	* We leave C1 disconnect bit alone as bios/SMM wants?
> +	*/
> +	if(apic_timerack) {
> +		if(apic_timerack==1) {
> +			/* v1 timer ack delay, inline delay version
> +	 		* on AMDXP & nforce2 chipset we use at least 500ns
> +			* try to scale delay time with cpu speed.
> +			* safe all cpu cores?
> +	 		*/
> +			ndelay((cpu_khz >> 12)+200); /* don't ack too soon or hard lockup */
> +		} else {
> +			static unsigned int passno, safecnt;
> +			/* v2 timer ack delay, timeout version, more efficient
> +	 		* on AMDXP & nforce2 chipset we need 800ns?
> +	 		* from timer irq start to apic irq ack, read apic timer,
> +			* may be unsafe for thoroughbred cores?
> +	 		*/
> +			if(!passno) { /* calculate timing */
> +				safecnt = apic_read(APIC_TMICT) -
> +					( (800UL * apic_read(APIC_TMICT) ) /
> +					(1000000000UL/HZ) );
> +				printk("..APIC TIMER ack delay, reload:%lu, safe:%u\n",
> +					apic_read(APIC_TMICT), safecnt);
> +				passno++;
> +			}
> +#if APIC_DEBUG
> +			if(passno<12) {
> +				unsigned int at1 = apic_read(APIC_TMCCT);
> +				if( passno > 1 )
> +					Dprintk("..APIC TIMER ack delay, predelay count:%u \n", at1 );
> +				passno++;
> +			}
> +# endif
> +			/* delay only if required */
> +			while( apic_read(APIC_TMCCT) > safecnt )
> +				ndelay(100);
> +		}
> +	}
> +
> +	/*
>  	 * NOTE! We'd better ACK the irq immediately,
>  	 * because timer handling can be slow.
>  	 */
>  	ack_APIC_irq();
>  	/*
> @@ -1157,10 +1208,28 @@ asmlinkage void smp_error_interrupt(void
>  	        smp_processor_id(), v , v1);
>  	irq_exit();
>  }
>  
>  /*
> +* Athlon nforce2 timer ack delay. R.D.
> +* kernel arg apic_tack=[012]
> +* 0 off, 1 always delay, 2 timeout
> +*/
> +static int __init setup_apic_timerack(char *str)
> +{
> +	int tack;
> +
> +	get_option(&str, &tack);
> +
> +	if ( tack < 0 || tack > 2 )
> +		return 0;
> +	apic_timerack = tack;
> +	return 1;
> +}
> +__setup("apic_tack=", setup_apic_timerack);
> +
> +/*
>   * This initializes the IO-APIC and APIC hardware if this is
>   * a UP kernel.
>   */
>  int __init APIC_init_uniprocessor (void)
>  {
> --- CUT HERE --- 
> 
> io-apic edge:
> --- CUT HERE ---
> --- linux-2.6.0/arch/i386/kernel/io_apic.c	2003-12-18 12:58:39.000000000 +1000
> +++ linux-2.6.0-rd/arch/i386/kernel/io_apic.c	2003-12-20 21:41:52.000000000 +1000
> @@ -2123,12 +2123,56 @@ static inline void check_timer(void)
>  				check_nmi_watchdog();
>  			}
>  			return;
>  		}
>  		clear_IO_APIC_pin(0, pin1);
> -		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC\n");
> +		printk(KERN_ERR "..MP-BIOS bug: 8254 timer not connected to IO-APIC INTIN%d\n",pin1);
> +	}
> +
> +#if defined(CONFIG_ACPI_BOOT) && defined(CONFIG_X86_UP_IOAPIC)
> +	/* for nforce2 try vector 0 on pin0
> +	 * Note 8259a is already masked, also by default
> +	 * the io_apic_set_pci_routing call disables the 8259 irq 0
> +	 * so we must be connected directly to the 8254 timer if this works
> +	 * Note2: this violates the above comment re Subtle but works!
> +	 */
> +	printk(KERN_INFO "..TIMER: Is timer irq0 connected to IO-APIC INTIN0? ...\n");
> +	if (pin1 != -1) {
> +		extern spinlock_t i8259A_lock;
> +		unsigned long flags;
> +		int tok, saved_timer_ack = timer_ack;
> +		/*
> +		 * Ok, does IRQ0 through the IOAPIC work?
> +		 */
> +		io_apic_set_pci_routing ( 0, 0, 0, 0, 0); /* connect pin */
> +		unmask_IO_APIC_irq(0);
> +		timer_ack = 0;
> +
> +		/*
> +		 * Ok, does IRQ0 through the IOAPIC work?
> +		 */
> +		spin_lock_irqsave(&i8259A_lock, flags);
> +		Dprintk("..TIMER 8259A ints disabled?, imr1:%02x, imr2:%02x\n", inb(0x21), inb(0xA1));
> +		tok = timer_irq_works();
> +		spin_unlock_irqrestore(&i8259A_lock, flags);
> +		if (tok) {
> +			if (nmi_watchdog == NMI_IO_APIC) {
> +				disable_8259A_irq(0);
> +				setup_nmi();
> +				enable_8259A_irq(0);
> +				check_nmi_watchdog();
> +			}
> +			printk(KERN_INFO "..TIMER: works OK on IO-APIC INTIN0 irq0\n" );
> +			return;
> +		}
> +		/* failed */
> +		timer_ack = saved_timer_ack;
> +		clear_IO_APIC_pin(0, 0);
> +		io_apic_set_pci_routing ( 0, pin1, 0, 0, 0);
> +		printk(KERN_ERR "..MP-BIOS: 8254 timer not connected to IO-APIC INTIN0\n");
>  	}
> +#endif
>  
>  	printk(KERN_INFO "...trying to set up timer (IRQ0) through the 8259A ... ");
>  	if (pin2 != -1) {
>  		printk("\n..... (found pin %d) ...", pin2);
>  		/*
> --- CUT HERE ---
> 
> 
