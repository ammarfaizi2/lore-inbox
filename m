Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263117AbUK0C1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263117AbUK0C1O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 21:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263116AbUK0CKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 21:10:00 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10692 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262846AbUKZThb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:37:31 -0500
Date: Thu, 25 Nov 2004 10:33:00 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: ChenLi Tien <cltien@cmedia.com.tw>
Cc: ChenLi Tien <cltien@cmedia.com.tw>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cmpci.c fixes for joystick initialization in 2.4.27
Message-ID: <20041125123300.GH16189@logos.cnet>
References: <Pine.LNX.4.44.0410311137110.1383-100000@shampoo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0410311137110.1383-100000@shampoo>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



ChenLi, 

Have you received this patch?

Can you confirm 0x201 is the standard address for the port?

On Sun, Oct 31, 2004 at 12:01:53PM +0100, Michele Debandi wrote:
> Hello,
> 
> I hope you are the current mantainer of cmpci module on 2.4 series kernel.
> 
> I have an integrated CM8738 sound chip on my Asus P4B533 motherboard.
> The lspci -v output is:
> 
> 02:03.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
>         Subsystem: Asustek Computer, Inc.: Unknown device 80e2
>         Flags: bus master, stepping, medium devsel, latency 32, IRQ 21
>         I/O ports at b800 [size=256]
>         Capabilities: [c0] Power Management version 2
> 
> With the cmpci.c driver the joystick will not work. MSDOS initialization
> sets the joystick port at the address 0x201, and windows driver uses also
> this port. The cmpci driver initializes instead the port 0x200, and
> on my chipset at that address thre is nothing. So I modified the driver
> modules to use the port 0x201 but mantaining the 8-port allocation of the
> original driver.
> This is tested and seems to work on a stantard PC/XT style 2-axis/2-button
> joystick.
> 
> Below there is the diff file.
> 
> Greetings
> 
> Mike
> 
> --- drivers/sound/cmpci.c.ORIG	Tue Oct 26 20:55:08 2004
> +++ drivers/sound/cmpci.c	Tue Oct 26 21:01:23 2004
> @@ -3354,7 +3354,7 @@
>  #endif
>  	s->iosynth = fmio;
>  	s->iomidi = mpuio;
> -	s->gameport.io = 0x200;
> +	s->gameport.io = 0x201; /*use standard DOS io port */
>  	s->status = 0;
>  	/* range check */
>  	if (speakers < 2)
> @@ -3443,7 +3443,8 @@
>  #endif
>  	/* enable joystick */
>  	if (joystick) {
> -		if (s->gameport.io && !request_region(s->gameport.io, CM_EXTENT_GAME, "cmpci GAME")) {
> +	        /* need to use port 0x201, but the extent starts at 0x200??? */
> +		if (s->gameport.io && !request_region((s->gameport.io) - 1, CM_EXTENT_GAME, "cmpci GAME")) {
>  			printk(KERN_ERR "cmpci: gameport io ports in use\n");
>  			s->gameport.io = 0;
>  	       	} else
> @@ -3549,8 +3550,13 @@
>  		s->max_channels = 2;
>  	}
>  	/* register gameport */
> -	if (joystick)
> +	if (joystick) {
>  		gameport_register_port(&s->gameport);
> +		/* better write some more info */
> +		printk(KERN_INFO "gameport%d: CMPCI at %#x", s->gameport.number, s->gameport.io);
> +	        printk(" size %d", CM_EXTENT_GAME);
> +		printk(" speed %d kHz\n", s->gameport.speed);
> +	}
>  	/* store it in the driver field */
>  	pci_set_drvdata(pcidev, s);
>  	/* put it into driver list */
> @@ -3576,7 +3582,7 @@
>  	free_irq(s->irq, s);
>  err_irq:
>  	if (s->gameport.io)
> -		release_region(s->gameport.io, CM_EXTENT_GAME);
> +		release_region((s->gameport.io)-1, CM_EXTENT_GAME);
>  #ifdef CONFIG_SOUND_CMPCI_FM
>  	if (s->iosynth) release_region(s->iosynth, CM_EXTENT_SYNTH);
>  #endif
> @@ -3612,7 +3618,7 @@
> 
>  	if (s->gameport.io) {
>  		gameport_unregister_port(&s->gameport);
> -		release_region(s->gameport.io, CM_EXTENT_GAME);
> +		release_region((s->gameport.io)-1, CM_EXTENT_GAME);
>  	}
>  	release_region(s->iobase, CM_EXTENT_CODEC);
>  #ifdef CONFIG_SOUND_CMPCI_MIDI
