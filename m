Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263357AbTLUQac (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Dec 2003 11:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbTLUQac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Dec 2003 11:30:32 -0500
Received: from legolas.restena.lu ([158.64.1.34]:4246 "EHLO smtp.restena.lu")
	by vger.kernel.org with ESMTP id S263357AbTLUQaE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Dec 2003 11:30:04 -0500
Subject: Re: Updated Lockup Patches, 2.6.0 Nforce2, apic timer ack delay,
	ioapic edge for NMI debug
From: Craig Bradney <cbradney@zip.com.au>
To: ross@datscreative.com.au
Cc: linux-kernel@vger.kernel.org, Ian Kumlien <pomac@vapor.com>,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, forming@charter.net,
       Jesse Allen <the3dfxdude@hotmail.com>
In-Reply-To: <200312211917.05928.ross@datscreative.com.au>
References: <200312211917.05928.ross@datscreative.com.au>
Content-Type: multipart/mixed; boundary="=-SpzKmscDNlVFjsUADyV1"
Message-Id: <1072024198.4191.6.camel@athlonxp.bradney.info>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 21 Dec 2003 17:29:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-SpzKmscDNlVFjsUADyV1
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi Ross

Ok, I have now started testing with apic_tack=2 with the 2.60 kernel
from Gentoo. Before this voluntary reboot I was at 8d 20h+ with old
patches.

I have attached dmesg and /proc/interrupts from a boot to prompt for
both apic_tack=1 and 2, both with nmi 1.

Relevant information would seem to be as follows:
..
..
ENABLING IO-APIC IRQs
init IO_APIC IRQs
 IO-APIC (apicid-pin) 2-0, 2-16, 2-17, 2-18, 2-19, 2-20, 2-21, 2-22, 2-23 not connected.
..TIMER: vector=0x31 pin1=2 pin2=-1
..MP-BIOS bug: 8254 timer not connected to IO-APIC INTIN2
..TIMER: Is timer irq0 connected to IO-APIC INTIN0? ...
IOAPIC[0]: Set PCI routing entry (2-0 -> 0x31 -> IRQ 0 Mode:0 Active:0)
activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
..TIMER: works OK on IO-APIC INTIN0 irq0
..
..
..APIC TIMER ack delay, reload:20792, safe:20776
..
..

and CPU disconnect is enabled (as reported by athcool stat)

Thanks for your continuing work!

Craig
ASUS A7N8X Deluxe V2.0 BIOS 1007, Athlon 2600+

On Sun, 2003-12-21 at 10:17, Ross Dickson wrote:
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

--=-SpzKmscDNlVFjsUADyV1
Content-Disposition: attachment; filename=260-gentoo-latestpatches-output.tar.gz
Content-Type: application/x-compressed-tar; name=260-gentoo-latestpatches-output.tar.gz
Content-Transfer-Encoding: base64

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

--=-SpzKmscDNlVFjsUADyV1--

