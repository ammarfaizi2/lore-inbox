Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbUJ3QS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbUJ3QS3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 12:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbUJ3QRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 12:17:07 -0400
Received: from mail.kroah.org ([69.55.234.183]:58776 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261248AbUJ3P3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 11:29:38 -0400
Date: Fri, 29 Oct 2004 21:40:56 -0700
From: Greg KH <greg@kroah.com>
To: Germano Barreiro <germano.barreiro@cyclades.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Wanda Rosalino <wanda.rosalino@cyclades.com>
Subject: Re: patch for sysfs in the cyclades driver
Message-ID: <20041030044056.GB1907@kroah.com>
References: <1098989790.6605.3.camel@germano.cyclades.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098989790.6605.3.camel@germano.cyclades.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 04:56:30PM -0200, Germano Barreiro wrote:
> Hi
> 
> This patch implements the sysfs support in the cyclades async driver,
> which is needed by the Cyclades' CyMonitor application. It is based in
> the last one sent (see copied message below), but implements the changes
> asked for that patch by Greg (the array of attributes was eliminated and
> now there is only one file for each value to be exported).
> I hope it is ok to be applied now, but if more changes are needed I
> would be pleased to listen about them. By the way, I'm grateful to
> Marcelo for taking time to examining many "middle" versions of this
> patch, and also to Greg for his comments to the last patch.

Close, it's getting better, but you still have a ways to go...

> --- linux-2.6.10rc1.orig/drivers/char/cyclades.c	2004-10-25 16:40:00.000000000 -0200
> +++ linux-2.6.10rc1/drivers/char/cyclades.c	2004-10-26 17:13:20.000000000 -0200
> @@ -646,6 +646,7 @@ static char rcsid[] =
>  #include <linux/string.h>
>  #include <linux/fcntl.h>
>  #include <linux/ptrace.h>
> +#include <linux/device.h>
>  #include <linux/cyclades.h>
>  #include <linux/mm.h>
>  #include <linux/ioport.h>
> @@ -700,8 +701,36 @@ static void cy_send_xchar (struct tty_st
>  
>  #define	JIFFIES_DIFF(n, j)	((j) - (n))
>  
> +static char _version[150];
>  static struct tty_driver *cy_serial_driver;
>  
> +
> +const static char sysufixes[18][10]={"stat","card","baud","flow","rxfl","txfl","dcd","dsr","cts",
> +                                     "rts","dtr","rx","tx","bdrx","bdtx","par","stop","chlen"};

Ick, this isn't needed.

> +ssize_t (*showfunctions[])(struct device *, char *)={
> +	show_sys_stat,
> +	show_sys_card,
> +	show_sys_baud,
> +	show_sys_flow,
> +	show_sys_rxfl,
> +	show_sys_txfl,
> +	show_sys_dcd,
> +	show_sys_dsr,
> +	show_sys_cts,
> +	show_sys_rts,
> +	show_sys_dtr,
> +	show_sys_rx,
> +	show_sys_tx,
> +	show_sys_bdrx,
> +	show_sys_bdtx,
> +	show_sys_par,
> +	show_sys_stop,
> +	show_sys_chlen
> +};

Why not just do as the i2c chip drivers do?  Use a macro for your
show functions, it's much simpler.

> +        switch(whatinfo){
> +
> +		case STAT: //open/closed

Break this big switch statement up into the individual show functions.
Hm, ok, you can't use a macro for them then, sorry.  But it should be
simpler.

> +			if ( tty == 0 ) 
> +				len = sprintf(buf, "%s:%s\n", cysys_state, cysys_close);
> +			else
> +				len = sprintf(buf, "%s:%s\n", cysys_state, cysys_open);

No, don't put the %s: stuff in there.  The user read from the "stat"
file.  They know what the value should be, you don't have to remind them
again :)

thanks,

greg k-h
