Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264474AbRFISvD>; Sat, 9 Jun 2001 14:51:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264475AbRFISux>; Sat, 9 Jun 2001 14:50:53 -0400
Received: from erasmus.off.net ([64.39.30.25]:19984 "HELO erasmus.off.net")
	by vger.kernel.org with SMTP id <S264474AbRFISum>;
	Sat, 9 Jun 2001 14:50:42 -0400
Date: Sat, 9 Jun 2001 14:50:43 -0400
From: Zach Brown <zab@zabbo.net>
To: Lukas Schroeder <lukas@edeal.de>
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: [patch] ess maestro, support for hardware volume control
Message-ID: <20010609145043.D20514@erasmus.off.net>
In-Reply-To: <20010609190917.A10629@kosmo.edeal.de> <20010609132501.C20514@erasmus.off.net> <20010609201605.A11800@kosmo.edeal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <20010609201605.A11800@kosmo.edeal.de>; from lukas@edeal.de on Sat, Jun 09, 2001 at 08:16:05PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> below is the version with the suggested fixes, and with s/hwv/hwvol/ for
> hwv_input also.

fantastic, thanks lukas.

alan, can you throw this in -ac?  I don't think it will cause problems
for people with nonstandard wiring on the hw vol pins (read: dell
lattitudes), but if it does we can blacklist the lattitudes (later turning
into enabling support code for their custom hw vol wiring.. its on the
todo list :/).  This should work on inspirons.

- z

> --- linux-2.4.6-pre2/drivers/sound/maestro.c	Sat Jun  9 16:55:22 2001
> +++ linux/drivers/sound/maestro.c	Sat Jun  9 19:48:34 2001
> @@ -115,6 +115,10 @@
>   *	themselves, but we'll see.  
>   *	
>   * History
> + *  v0.15 - Jun 09 2001 - Lukas Schroeder <lukas@edeal.de>
> + *	enable hardware volume control (by default)
> + *	add hwvol_enable= to allow disabling of HWV (values are 0 or 1)
> + *	add hwvol_input= to allow selecting the HWV input pins (values are 0 or 1)
>   *  (still kind of v0.14) Nov 23 - Alan Cox <alan@redhat.com>
>   *	Add clocking= for people with seriously warped hardware
>   *  (still v0.14) Nov 10 2000 - Bartlomiej Zolnierkiewicz <bkz@linux-ide.org>
> @@ -269,8 +273,13 @@
>  	
>  static int clocking=48000;
>  
> +/* enable hardware volume control? */
> +static int hwvol_enable = 1;
> +/* hardware volume input pin selection */
> +static int hwvol_input = 0;
> +
>  /* --------------------------------------------------------------------- */
> -#define DRIVER_VERSION "0.14"
> +#define DRIVER_VERSION "0.15"
>  
>  #ifndef PCI_VENDOR_ESS
>  #define PCI_VENDOR_ESS			0x125D
> @@ -312,6 +321,9 @@
>  #define NR_APUS		64
>  #define NR_APU_REGS	16
>  
> +/* steps per hardware volume count */
> +#define HWV_MIXER_STEP	15
> +
>  /* acpi states */
>  enum {
>  	ACPI_D0=0,
> @@ -514,6 +526,7 @@
>  
>  /* --------------------------------------------------------------------- */
>  
> +static void set_mixer(struct ess_card *card,unsigned int mixer, unsigned int val ) ;
>  static void check_suspend(struct ess_card *card);
>  
>  static struct ess_card *devs = NULL;
> @@ -1898,10 +1911,20 @@
>  
>  	if(event&(1<<6))
>  	{
> -		/* XXX if we have a hw volume control int enable
> -			all the ints?  doesn't make sense.. */
> +		unsigned int val;
> +
>  		event = inw(c->iobase+0x18);
> -		outb(0xFF, c->iobase+0x1A);
> +		outb((1<<6), c->iobase+0x1A);
> +
> +		/* read the HW Master Volume Counter
> +                   Bits 7:5       Master Volume Left
> +                   Bits 3:1       Master Volume Right
> +                */
> +		i = inb(c->iobase+0x1f);
> +		val = ((HWV_MIXER_STEP * ((i>>1) & 7)) << 8) | HWV_MIXER_STEP * ((i>>5) & 7);
> +		spin_lock(&s->lock);
> +		set_mixer(c, 0, val);
> +		spin_unlock(&s->lock);
>  	}
>  	else
>  	{
> @@ -3088,8 +3111,10 @@
>  	w&=~(1<<14);		/* External clock */
>  	
>  	w&=~(1<<7);		/* HWV off */
> +	if (hwvol_enable) w|=(1<<7);
>  	w&=~(1<<6);		/* Debounce off */
> -	w&=~(1<<5);		/* GPIO 4:5 */
> +	w&=~(1<<5);		/* GPIO 4:5 ; HVI pin selection */
> +	if (hwvol_input) w|=(1<<5);
>  	w|= (1<<4);             /* Disconnect from the CHI.  Enabling this made a dell 7500 work. */
>  	w&=~(1<<2);		/* MIDI fix off (undoc) */
>  	w&=~(1<<1);		/* reserved, always write 0 */
> @@ -3170,7 +3195,8 @@
>  	outw(w, iobase+0x18);
>  
>  	w=inw(iobase+0x18);
> -	w&=~(1<<6);		/* Harpo off */
> +	w&=~(1<<6);		/* HWV irq off */
> +	if (hwvol_enable) w|=(1<<6);
>  	outw(w, iobase+0x18);
>  	
>  	w=inw(iobase+0x18);
> @@ -3487,6 +3513,7 @@
>  	/* now go to sleep 'till something interesting happens */
>  	maestro_power(card,ACPI_D2);
>  
> +	printk(KERN_INFO "maestro: hardware volume control %senabled\n", (hwvol_enable) ? "" : "not ");
>  	printk(KERN_INFO "maestro: %d channels configured.\n", num);
>  	return 1; 
>  }
> @@ -3593,6 +3620,10 @@
>  MODULE_PARM(dsps_order,"i");
>  MODULE_PARM(use_pm,"i");
>  MODULE_PARM(clocking, "i");
> +
> +MODULE_PARM(hwvol_enable, "i");
> +MODULE_PARM(hwvol_input, "i");
> +
>  
>  void cleanup_module(void) {
>  	M_printk("maestro: unloading\n");
> 
