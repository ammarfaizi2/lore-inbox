Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262055AbSJZK0Z>; Sat, 26 Oct 2002 06:26:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262076AbSJZKYw>; Sat, 26 Oct 2002 06:24:52 -0400
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:27404 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S262055AbSJZKYD>; Sat, 26 Oct 2002 06:24:03 -0400
X-Envelope-From: pavel@bug.ucw.cz
Date: Sun, 20 Oct 2002 21:09:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: linux-kernel@vger.kernel.org, Suparna Bhattacharya <suparna@in.ibm.com>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>, fastboot@osdl.org,
       Werner Almesberger <wa@almesberger.net>
Subject: Re: kexec for 2.5.44 (Who do I send this to?)
Message-ID: <20021020190939.GA913@elf.ucw.cz>
References: <m1y98uyc1a.fsf@frodo.biederman.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1y98uyc1a.fsf@frodo.biederman.org>
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The kexec code has gone through a fairly decent review, and all known bugs
> are resolved.  There are still BIOS's that don't work after you have
> run a kernel but that is an entirely different problem.  

Looks good... Few comments follow.

> @@ -1128,6 +1159,26 @@
>  	printk (KERN_INFO "APIC error on CPU%d: %02lx(%02lx)\n",
>  	        smp_processor_id(), v , v1);
>  	irq_exit();
> +}
> +
> +void stop_apics(void)
> +{
> +	/* By resetting the APIC's we disable the nmi watchdog */
> +#if CONFIG_SMP
> +	/*
> +	 * Stop all CPUs and turn off local APICs and the IO-APIC, so
> +	 * other OSs see a clean IRQ state.
> +	 */
> +	smp_send_stop();
> +#else
> +	disable_local_APIC();
> +#endif
> +#if defined(CONFIG_X86_IO_APIC)
> +	if (smp_found_config) {
> +		disable_IO_APIC();
> +	}
> +#endif
> +	disconnect_bsp_APIC();
>  }
>  

Perhaps this should be done using driverfs callbacks?

> --- linux-2.5.44/arch/i386/kernel/i8259.c	Fri Oct 11 22:22:19 2002
> +++ linux-2.5.44.x86kexec/arch/i386/kernel/i8259.c	Sat Oct 19 01:04:36 2002
> @@ -246,10 +246,34 @@
>  	return 0;
>  }
>  
> +static void i8259A_remove(struct device *dev)
> +{   
> +	/* Restore the i8259A to it's legacy dos setup.
> +	 * The kernel won't be using it any more, and it
> +	 * just might make reboots, and kexec type applications
> +	 * more stable.
> +	 */
> +	outb(0xff, 0x21);	/* mask all of 8259A-1 */
> +	outb(0xff, 0xA1);	/* mask all of 8259A-1 */
> +
> +	outb_p(0x11, 0x20);	/* ICW1: select 8259A-1 init */
> +	outb_p(0x08, 0x21);	/* ICW2: 8259A-1 IR0-7 mappend to 0x8-0xf */
> +	outb_p(0x01, 0x21);	/* Normal 8086 auto EOI mode */
> +
> +	outb_p(0x11, 0xA0);	/* ICW1: select 8259A-2 init */
> +	outb_p(0x08, 0xA1);	/* ICW2: 8259A-2 IR0-7 mappend to 0x70-0x77 */
> +	outb_p(0x01, 0xA1);	/* Normal 8086 auto EOI mode */
> +
> +	udelay(100);		/* wait for 8259A to initialize */
> +
> +	/* Should I unmask interrupts here?  */
> +}
> +
>  static struct device_driver i8259A_driver = {
>  	.name		= "pic",
>  	.bus		= &system_bus_type,
>  	.resume		= i8259A_resume,
> +	.remove		= i8259A_remove,
>  };
>  

Here you did it right.
								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
