Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317544AbSGYH3i>; Thu, 25 Jul 2002 03:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317639AbSGYH3i>; Thu, 25 Jul 2002 03:29:38 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:33214 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317544AbSGYH3g>;
	Thu, 25 Jul 2002 03:29:36 -0400
Date: Thu, 25 Jul 2002 09:31:54 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Samuel Thibault <samuel.thibault@fnac.net>
Cc: andre@linux-ide.org, martin@dalecki.de, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/ide/qd65xx: no cli/sti (2.4.19-pre3 & 2.5.28)
Message-ID: <20020725093154.A21541@ucw.cz>
References: <Pine.LNX.4.44.0205260248160.17222-400000@youpi.residence.ens-lyon.fr> <Pine.LNX.4.10.10207250128110.4868-100000@bureau.famille.thibault.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.10.10207250128110.4868-100000@bureau.famille.thibault.fr>; from samuel.thibault@fnac.net on Thu, Jul 25, 2002 at 01:45:00AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 01:45:00AM +0200, Samuel Thibault wrote:
> Hello,
> 
> Here are patches for 2.4.19-pre3 & 2.5.28 which free them from using
> cli/sti in qd65xx stuff.

Cool.

> (also using ide's OUT_BYTE / IN_BYTE btw)

In my opinion this doesn't make sense. The qd65xx is a VESA Local Bus
only hardware and is very very unlikely to be used on anything else than
an x86, where these defines are needed. Also, the ports written to are
not a part of the IDE controller region, so the IN_BYTE/OUT_BYTE macros
might not work there if it was ever used on a non-x86 machine. Also, it
makes the code less readable.

> IMHO, it may use its own spinlock, instead of using io_request_lock as
> suggested in pre3-ac, since what we have to protect is this card from
> parallel selectprocing 2 channels at a time which may upset the board (I
> don't know, and don't have a vlb smp system to test)
>
> 2 qd6500 boards may be ok to parallelize it, I don't know (I don't have 
> any)...
> 
> for 2.4.19rc3:
> 
> --- linux-2.4.19rc3/drivers/ide/qd65xx.c	Thu Jul 25 01:03:28 2002
> +++ linux-2.4.19rc3/drivers/ide/qd65xx.c	Thu Jul 25 01:26:33 2002
> @@ -88,14 +88,15 @@
>  
>  static int timings[4]={-1,-1,-1,-1}; /* stores current timing for each timer */
>  
> +static spinlock_t qd_lock = SPIN_LOCK_UNLOCKED; /* lock for i/o operations */
> +
>  static void qd_write_reg (byte content, byte reg)
>  {
>  	unsigned long flags;
>  
> -	save_flags(flags);	/* all CPUs */
> -	cli();			/* all CPUs */
> -	outb(content,reg);
> -	restore_flags(flags);	/* all CPUs */
> +	spin_lock_irqsave(&qd_lock, flags);
> +	OUT_BYTE(content,reg);
> +	spin_unlock_irqrestore(&qd_lock, flags);
>  }
>  
>  byte __init qd_read_reg (byte reg)
> @@ -103,10 +104,9 @@
>  	unsigned long flags;
>  	byte read;
>  
> -	save_flags(flags);	/* all CPUs */
> -	cli();			/* all CPUs */
> -	read = inb(reg);
> -	restore_flags(flags);	/* all CPUs */
> +	spin_lock_irqsave(&qd_lock, flags);
> +	read = IN_BYTE(reg);
> +	spin_unlock_irqrestore(&qd_lock, flags);
>  	return read;
>  }
>  
> @@ -311,13 +311,12 @@
>  	byte readreg;
>  	unsigned long flags;
>  
> -	save_flags(flags);	/* all CPUs */
> -	cli();			/* all CPUs */
> -	savereg = inb_p(port);
> -	outb_p(QD_TESTVAL,port);	/* safe value */
> -	readreg = inb_p(port);
> -	outb(savereg,port);
> -	restore_flags(flags);	/* all CPUs */
> +	spin_lock_irqsave(&qd_lock, flags);
> +	savereg = IN_BYTE(port);
> +	OUT_BYTE(QD_TESTVAL,port);	/* safe value */
> +	readreg = IN_BYTE(port);
> +	OUT_BYTE(savereg,port);
> +	spin_unlock_irqrestore(&qd_lock, flags);
>  
>  	if (savereg == QD_TESTVAL) {
>  		printk(KERN_ERR "Outch ! the probe for qd65xx isn't reliable !\n");
> @@ -336,7 +335,7 @@
>   * return 1 if another qd may be probed
>   */
>  
> -int __init probe (int base)
> +static int __init qd_probe(int base)
>  {
>  	byte config;
>  	byte index;
> @@ -449,5 +448,5 @@
>  
>  void __init init_qd65xx (void)
>  {
> -	if (probe(0x30)) probe(0xb0);
> +	if (qd_probe(0x30)) qd_probe(0xb0);
>  }
> 
> (also corrected silly non-static probe function !)
> 
> for 2.5.28:
> 
> --- linux-2.5.28/drivers/ide/qd65xx.c	Thu Jul 25 01:10:26 2002
> +++ linux-2.5.28/drivers/ide/qd65xx.c	Thu Jul 25 01:09:09 2002
> @@ -85,14 +85,15 @@
>  
>  static int timings[4]={-1,-1,-1,-1}; /* stores current timing for each timer */
>  
> +static spinlock_t qd_lock = SPIN_LOCK_UNLOCKED; /* lock for i/o operations */
> +
>  static void qd_write_reg(byte content, byte reg)
>  {
>  	unsigned long flags;
>  
> -	save_flags(flags);	/* all CPUs */
> -	cli();			/* all CPUs */
> -	outb(content,reg);
> -	restore_flags(flags);	/* all CPUs */
> +	spin_lock_irqsave(&qd_lock, flags);
> +	OUT_BYTE(content,reg);
> +	spin_unlock_irqrestore(&qd_lock, flags);
>  }
>  
>  byte __init qd_read_reg(byte reg)
> @@ -100,10 +101,9 @@
>  	unsigned long flags;
>  	byte read;
>  
> -	save_flags(flags);	/* all CPUs */
> -	cli();			/* all CPUs */
> -	read = inb(reg);
> -	restore_flags(flags);	/* all CPUs */
> +	spin_lock_irqsave(&qd_lock, flags);
> +	read = IN_BYTE(reg);
> +	spin_unlock_irqrestore(&qd_lock, flags);
>  	return read;
>  }
>  
> @@ -309,13 +309,12 @@
>  	byte readreg;
>  	unsigned long flags;
>  
> -	save_flags(flags);	/* all CPUs */
> -	cli();			/* all CPUs */
> -	savereg = inb_p(port);
> -	outb_p(QD_TESTVAL, port);	/* safe value */
> -	readreg = inb_p(port);
> -	outb(savereg, port);
> -	restore_flags(flags);	/* all CPUs */
> +	spin_lock_irqsave(&qd_lock, flags);
> +	savereg = IN_BYTE(port);
> +	OUT_BYTE(QD_TESTVAL,port);	/* safe value */
> +	readreg = IN_BYTE(port);
> +	OUT_BYTE(savereg,port);
> +	spin_unlock_irqrestore(&qd_lock, flags);
>  
>  	if (savereg == QD_TESTVAL) {
>  		printk(KERN_ERR "Outch ! the probe for qd65xx isn't reliable !\n");
> 
> 
> Regards,
> 
> Samuel Thibault
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Vojtech Pavlik
SuSE Labs
