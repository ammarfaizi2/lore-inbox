Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287487AbSBKHfi>; Mon, 11 Feb 2002 02:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287493AbSBKHf3>; Mon, 11 Feb 2002 02:35:29 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:12496 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S287487AbSBKHfQ>; Mon, 11 Feb 2002 02:35:16 -0500
Message-Id: <200202110735.g1B7Z7LJ002187@tigger.cs.uni-dortmund.de>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch][looking for maintainers] jiffies compare fixups 
In-Reply-To: Message from Tim Schmielau <tim@physik3.uni-rostock.de> 
   of "Sun, 10 Feb 2002 20:21:32 +0100." <Pine.LNX.4.33.0202102019370.30794-100000@gans.physik3.uni-rostock.de> 
Date: Mon, 11 Feb 2002 08:35:07 +0100
From: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau <tim@physik3.uni-rostock.de> said:
> At the end of December, I made a patch to fix comparisons of the jiffies
> counter that would break at jiffies wraparound.

I think you should just forward the remaining bits to Marcelo directly.

[...]

> sent to: bjornw@axis.com Cc: dev-etrax@axis.com
> 
> CRIS PORT
> P:	Bjorn Wesen
> M:	bjornw@axis.com
> L:	dev-etrax@axis.com
> W:	http://developer.axis.com
> S:	Maintained
> 
> --- linux-2.4.18-pre9/arch/cris/drivers/ethernet.c	Mon Oct  8 20:43:54 200
> 1
> +++ linux-2.4.18-pre9-jiffies64/arch/cris/drivers/ethernet.c	Fri Dec 28 15:1
> 6:22 2001
[...]

> @@ -1322,7 +1322,7 @@
>  static void
>  e100_clear_network_leds(unsigned long dummy)
>  {
> -	if (led_active && jiffies > led_next_time) {
> +	if (led_active && jiffies > time_after(jiffies, led_next_time)) {
>  		e100_set_network_leds(NO_NETWORK_ACTIVITY);
> 
>  		/* Set the earliest time we may set the LED */

This hunk is surely wrong.


[...]

> sent to: fibrechannel@compaq.com Cc: compaqandlinux@cpqlin.van-dijk.net
> 
> COMPAQ FIBRE CHANNEL 64-bit/66MHz PCI non-intelligent HBA
> P:      Amy Vanzant-Hodge
> M:      Amy Vanzant-Hodge (fibrechannel@compaq.com)
> L:	compaqandlinux@cpqlin.van-dijk.net
> W:	ftp.compaq.com/pub/products/drivers/linux
> S:      Supported
> 
> --- linux-2.4.18-pre1/drivers/scsi/cpqfcTSstructs.h	Thu Oct 25 22:53:50 200
> 1
> +++ linux-2.4.18-pre1-jiffies64/drivers/scsi/cpqfcTSstructs.h	Fri Dec 28 12:4
> 8:20 2001
> @@ -27,7 +27,7 @@
> 
>  #define DbgDelay(secs) { int wait_time; printk( " DbgDelay %ds ", secs); \
>                           for( wait_time=jiffies + (secs*HZ); \
> -		         wait_time > jiffies ;) ; }
> +		         time_before(jiffies, wait_time) ;) ; }
> 
>  #define CPQFCTS_DRIVER_VER(maj,min,submin) ((maj<<16)|(min<<8)|(submin))
>  // don't forget to also change MODULE_DESCRIPTION in cpqfcTSinit.c

Could use a bit of clarification. Or should be axed: Wait several _seconds_
in a busy loop?!

[...]

> sent to: grif@cs.ucr.edu
> 
> /*
>  * QLogic ISP2x00 SCSI-FCP
>  * Written by Erik H. Moe, ehm@cris.com
>  * Copyright 1995, Erik H. Moe
>  *
> [...]
>  */
> 
> /* Renamed and updated to 1.3.x by Michael Griffith <grif@cs.ucr.edu> */
> 
> --- linux-2.4.18-pre1/drivers/scsi/qlogicfc.c	Thu Oct 25 22:53:51 2001
> +++ linux-2.4.18-pre1-jiffies64/drivers/scsi/qlogicfc.c	Fri Dec 28 13:41:14 200
> 1

[...]

> @@ -820,7 +820,7 @@
>  	   some time before recognizing it is attached to a fabric */
> 
>  #if ISP2x00_FABRIC
> -	for (wait_time = jiffies + 5 * HZ; wait_time > jiffies;) {
> +	for (wait_time = jiffies + 5 * HZ; time_before(jiffies, wait_time);) {
>  		barrier();
>  		cpu_relax();
>  	}

Again: Loop for a few seconds?

> sent to: jes@trained-monkey.org Cc: linux-hippi@sunsite.dk
> 
> HIPPI
> P:	Jes Sorensen
> M:	jes@trained-monkey.org
> L:	linux-hippi@sunsite.dk
> S:	Maintained
> 
> --- linux-2.4.18-pre1/drivers/net/rrunner.c	Thu Nov 29 23:29:57 2001
> +++ linux-2.4.18-pre1-jiffies64/drivers/net/rrunner.c	Fri Dec 28 12:15:34 200
> 1
> @@ -770,7 +770,7 @@
>  	 * Give the FirmWare time to chew on the `get running' command.
>  	 */
>  	myjif = jiffies + 5 * HZ;
> -	while ((jiffies < myjif) && !rrpriv->fw_running);
> +	while (time_before(jiffies, myjif) && !rrpriv->fw_running);
> 
>  	netif_start_queue(dev);

Again a long loop?

> sent to: lizzi@cnam.fr Cc: davem@redhat.com
> 
> /*
>   $Id: fore200e.c,v 1.5 2000/04/14 10:10:34 davem Exp $
> 
>   A FORE Systems 200E-series driver for ATM on Linux.
>   Christophe Lizzi (lizzi@cnam.fr), October 1999-March 2000.
> 
> 
> --- linux-2.4.18-pre1/drivers/atm/fore200e.c	Fri Sep 14 00:21:32 2001
> +++ linux-2.4.18-pre1-jiffies64/drivers/atm/fore200e.c	Fri Dec 28 14:36:32 200
> 1
> @@ -252,7 +252,7 @@
>  fore200e_spin(int msecs)
>  {
>      unsigned long timeout = jiffies + MSECS(msecs);
> -    while (jiffies < timeout);
> +    while (time_before(jiffies, timeout));
>  }

Better use <linux/delay.h> or thereabouts?

[...]

> sent to: simon@tk.uni-linz.ac.at Cc: frodol@dds.nl,linux-i2c@pelican.tk.uni-lin
> z.ac.at
> 
> I2C DRIVERS
> P:	Simon Vogl
> M:	simon@tk.uni-linz.ac.at
> P:	Frodo Looijaard
> M:	frodol@dds.nl
> L:	linux-i2c@pelican.tk.uni-linz.ac.at
> W:	http://www.tk.uni-linz.ac.at/~simon/private/i2c
> S:	Maintained
> 
> --- linux-2.4.18-pre1/drivers/i2c/i2c-adap-ite.c	Thu Oct 11 17:05:47 200
> 1
> +++ linux-2.4.18-pre1-jiffies64/drivers/i2c/i2c-adap-ite.c	Fri Dec 28 11:3
> 8:01 2001
> @@ -82,7 +82,7 @@
>          unsigned long j = jiffies + 10;
> 
>  	DEB3(printk(" Write 0x%02x to 0x%x\n",(unsigned short)val, ctl&0xff));
> -	DEB3({while (jiffies < j) schedule();})
> +	DEB3({while (time_before(jiffies, j)) schedule();})
>  	outw(val,ctl);
>  }

schedule_timeout()?

> --- linux-2.4.18-pre1/drivers/i2c/i2c-algo-bit.c	Thu Oct 11 17:05:47 200
> 1
> +++ linux-2.4.18-pre1-jiffies64/drivers/i2c/i2c-algo-bit.c	Fri Dec 28 11:3
> 9:08 2001
> @@ -49,7 +49,7 @@
>  /* respectively. This makes sure that the algorithm works. Some chips   */
>  /* might not like this, as they have an internal timeout of some mils	*/
>  /*
> -#define SLO_IO      jif=jiffies;while(jiffies<=jif+i2c_table[minor].veryslow)\
> +#define SLO_IO      jif=jiffies;while(time_before_eq(jiffies, jif+i2c_table[mi
> nor].veryslow))\
>                          if (need_resched) schedule();
>  */

shedule_timeout() perhaps? In any case, this #define is dangerous, it
should be wrapped in "do {} while(0)" at least. And the behind-the-back
setting of jif is unsocial behaviour. Or just axe it, it is inside a
comment.
-- 
Horst von Brand			     http://counter.li.org # 22616
