Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267359AbTACBSJ>; Thu, 2 Jan 2003 20:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267361AbTACBSJ>; Thu, 2 Jan 2003 20:18:09 -0500
Received: from qualcomm.com ([199.106.114.68]:58356 "EHLO moria.qualcomm.com")
	by vger.kernel.org with ESMTP id <S267359AbTACBSH>;
	Thu, 2 Jan 2003 20:18:07 -0500
Date: Thu, 2 Jan 2003 03:40:53 -0800 (PST)
From: Max Krasnyansky <maxk@qualcomm.com>
To: <linux-kernel@vger.kernel.org>
cc: <rmk@arm.linux.org.uk>
Subject: Re: [PATCH/RFC] New module refcounting for TTY ldisc
In-Reply-To: <Pine.LNX.4.33.0212251951540.7979-100000@champ.qualcomm.com>
Message-ID: <Pine.LNX.4.33.0301020339350.2038-100000@champ.qualcomm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Any comments on this one ?
I'm holding my Bluetooth patches because of this.

Max


On Wed, 25 Dec 2002, Max Krasnyansky wrote
> Folks,
> 
> Here is the patch that converts TTY ldisc code to the new 
> module refcounting API.
> Tested with Bluetooth UART driver and seemed to work fine.
> Other ldiscs are not affected because their ldisc->owner is
> set to NULL.
> 
> If people are ok with it I'll push it to my BK tree along with
> fixed Bluetooth ldisc.
> 
> # This is a BitKeeper generated patch for the following project:
> # Project Name: Linux kernel tree
> # This patch format is intended for GNU patch command version 2.5 or higher.
> # This patch includes the following deltas:
> #	           ChangeSet	1.889   -> 1.890  
> #	drivers/char/tty_io.c	1.50    -> 1.51   
> #	include/linux/tty_ldisc.h	1.2     -> 1.3    
> #
> # The following is the BitKeeper ChangeSet Log
> # --------------------------------------------
> # 02/12/23	maxk@qualcomm.com	1.890
> # New module refcounting for TTY ldisc
> # --------------------------------------------
> #
> diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
> --- a/drivers/char/tty_io.c	Wed Dec 25 19:49:53 2002
> +++ b/drivers/char/tty_io.c	Wed Dec 25 19:49:53 2002
> @@ -292,6 +292,10 @@
>  
>  	if (tty->ldisc.num == ldisc)
>  		return 0;	/* We are already in the desired discipline */
> +
> +	if (!try_module_get(ldiscs[ldisc].owner))
> +	       	return -EINVAL;
> +	
>  	o_ldisc = tty->ldisc;
>  
>  	tty_wait_until_sent(tty, 0);
> @@ -306,9 +310,13 @@
>  	if (tty->ldisc.open)
>  		retval = (tty->ldisc.open)(tty);
>  	if (retval < 0) {
> +		module_put(tty->ldisc.owner);
> +		
>  		tty->ldisc = o_ldisc;
>  		tty->termios->c_line = tty->ldisc.num;
>  		if (tty->ldisc.open && (tty->ldisc.open(tty) < 0)) {
> +			module_put(tty->ldisc.owner);
> +
>  			tty->ldisc = ldiscs[N_TTY];
>  			tty->termios->c_line = N_TTY;
>  			if (tty->ldisc.open) {
> @@ -320,7 +328,10 @@
>  					      tty_name(tty, buf), r);
>  			}
>  		}
> +	} else {
> +		module_put(o_ldisc.owner);
>  	}
> +	
>  	if (tty->ldisc.num != o_ldisc.num && tty->driver.set_ldisc)
>  		tty->driver.set_ldisc(tty);
>  	return retval;
> @@ -489,6 +500,8 @@
>  	if (tty->ldisc.num != ldiscs[N_TTY].num) {
>  		if (tty->ldisc.close)
>  			(tty->ldisc.close)(tty);
> +		module_put(tty->ldisc.owner);
> +		
>  		tty->ldisc = ldiscs[N_TTY];
>  		tty->termios->c_line = N_TTY;
>  		if (tty->ldisc.open) {
> @@ -1259,6 +1272,8 @@
>  	 */
>  	if (tty->ldisc.close)
>  		(tty->ldisc.close)(tty);
> +	module_put(tty->ldisc.owner);
> +	
>  	tty->ldisc = ldiscs[N_TTY];
>  	tty->termios->c_line = N_TTY;
>  	if (o_tty) {
> diff -Nru a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
> --- a/include/linux/tty_ldisc.h	Wed Dec 25 19:49:53 2002
> +++ b/include/linux/tty_ldisc.h	Wed Dec 25 19:49:53 2002
> @@ -105,6 +105,7 @@
>  	char	*name;
>  	int	num;
>  	int	flags;
> +	
>  	/*
>  	 * The following routines are called from above.
>  	 */
> @@ -129,6 +130,8 @@
>  			       char *fp, int count);
>  	int	(*receive_room)(struct tty_struct *);
>  	void	(*write_wakeup)(struct tty_struct *);
> +
> +	struct  module *owner;
>  };
>  
>  #define TTY_LDISC_MAGIC	0x5403
> 
> --
> 
> Max
> 
> 

