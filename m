Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129855AbRBXBsp>; Fri, 23 Feb 2001 20:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130028AbRBXBsf>; Fri, 23 Feb 2001 20:48:35 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:54225 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S129855AbRBXBs0>;
	Fri, 23 Feb 2001 20:48:26 -0500
Date: Fri, 23 Feb 2001 17:48:24 -0800
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.mandrakesoft.com>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.4.2-ac3 and wavelan driver
Message-ID: <20010223174824.B27371@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	 Hi Alan (and the others)

	A few notes related to you *-ac* patches, the IrDA stack and
the Wavelan driver.

First, IrDA :
> --- linux.vanilla/net/irda/irlap.c	Thu Feb 22 09:06:21 2001
> +++ linux.ac/net/irda/irlap.c	Wed Feb 21 11:55:26 2001
> @@ -51,6 +51,7 @@
>  hashbin_t *irlap = NULL;
>  int sysctl_slot_timeout = SLOT_TIMEOUT * 1000 / HZ;
>  
> +extern void irlap_queue_xmit(struct irlap_cb *self, struct sk_buff *skb);
>  static void __irlap_close(struct irlap_cb *self);
>  
>  static char *lap_reasons[] = {

	The above patch is unnecessary. The definition of
irlap_queue_xmit() has been added in irlap_frame.h as part of
2.4.2 (I've just checked). So, you can drop this snipset.
	By the way, I'm updating the IrDA patches in the pipeline (USB
driver and co) and will send that to Dag soon.


> --- linux.vanilla/net/irda/irnet/Config.in	Sun Nov 12 02:11:23 2000
> +++ linux.ac/net/irda/irnet/Config.in	Wed Jan 31 22:02:24 2001
> @@ -1 +1,4 @@
> -dep_tristate '  IrNET protocol' CONFIG_IRNET $CONFIG_IRDA
> +if [ "$CONFIG_NETDEVICES" != "n" ]; then
> +   dep_tristate '  IrNET protocol' CONFIG_IRNET $CONFIG_IRDA $CONFIG_PPP
> +fi
> +

	This one is good. As you have it, we won't resend it to Linus.
	By the way, thanks to whoever spent time to correct my
spelling mistakes...


> 2.4.2-ac3
> o       Remove dead wavelan prototype                   (Jeff Garzik)

	I confirm again that I'm totally opposed to this patch of the
wavelan driver you have in your tree (see below).
	Replacing a perfectly valid inline function with a ugly define
it totally backward. If you look closely, the initial code was correct
and clean. I don't know anyone with taste who could advocate such a
patch without remorse.
	As we discussed earlier, this patch is only necessary because
gcc 2.96 miscompile the complex definition of udelay(). If gcc 2.96
miscompile the kernel, people should fix it or use a compiler that
works properly, not uglify my driver ;-)

	On the other hand, thanks infinitely to Jeff for having
updated the wavelan_cs driver (I'm still using Pcmcia outside the
kernel).

> --- linux.vanilla/drivers/net/wavelan.c	Thu Feb 22 09:05:59 2001
> +++ linux.ac/drivers/net/wavelan.c	Fri Feb 16 21:07:55 2001
> @@ -405,16 +405,13 @@
>   * Wait for the frequency EEPROM to complete a command.
>   * I hope this one will be optimally inlined.
>   */
> -static inline void fee_wait(unsigned long ioaddr,	/* I/O port of the card */
> -			    int delay,	/* Base delay to wait for */
> -			    int number)
> -{				/* Number of time to wait */
> -	int count = 0;		/* Wait only a limited time */
> -
> -	while ((count++ < number) &&
> -	       (mmc_in(ioaddr, mmroff(0, mmr_fee_status)) &
> -		MMR_FEE_STATUS_BUSY)) udelay(delay);
> -}
> +
> +#define fee_wait(ioaddr,delay,number) do {				\
> +		int count = 0;		/* Wait only a limited time */	\
> +		while ((count++ < number) &&				\
> +		       (mmc_in(ioaddr, mmroff(0, mmr_fee_status)) &	\
> +			MMR_FEE_STATUS_BUSY)) udelay(delay); 		\
> +	} while (0)
>  


	That's it, have a good week end...

	Jean
