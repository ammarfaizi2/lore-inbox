Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261631AbSJJPeC>; Thu, 10 Oct 2002 11:34:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261634AbSJJPeC>; Thu, 10 Oct 2002 11:34:02 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:51598 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S261631AbSJJPdz>; Thu, 10 Oct 2002 11:33:55 -0400
Date: Thu, 10 Oct 2002 10:39:38 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Frank Davis <fdavis@si.rr.com>
cc: linux-kernel@vger.kernel.org, <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] 2.5.41-ac2 : drivers/isdn/hisax/ locking updates
In-Reply-To: <Pine.LNX.4.44.0210092239560.9141-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0210101030210.10911-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Oct 2002, Frank Davis wrote:

>   The following patches replace the cli/save(restore)_flags combo 
> with spin_(un)lock_irqsave/restore . Please review. 
> 
> --- linux/drivers/isdn/hisax/asuscom.c.old	Mon Sep  9 18:43:46 2002
> +++ linux/drivers/isdn/hisax/asuscom.c	Wed Oct  9 22:25:07 2002
> @@ -24,6 +24,7 @@
>  
>  const char *Asuscom_revision = "$Revision: 1.11.6.3 $";
>  
> +static spinlock_t asuscom_lock = SPIN_LOCK_UNLOCKED;
>  #define byteout(addr,val) outb(val,addr)
>  #define bytein(addr) inb(addr)
>  
> @@ -46,13 +47,12 @@
>  readreg(unsigned int ale, unsigned int adr, u_char off)
>  {
>  	register u_char ret;
> -	long flags;
> +	unsigned long flags;
>  
> -	save_flags(flags);
> -	cli();
> +	spin_lock_irqsave(&asuscom_lock, flags);
>  	byteout(ale, off);
>  	ret = bytein(adr);
> -	restore_flags(flags);
> +	spin_unlock_irqrestore(&asuscom_lock, flags);
>  	return (ret);
>  }
>  
> @@ -69,13 +69,12 @@
>  static inline void
>  writereg(unsigned int ale, unsigned int adr, u_char off, u_char data)
>  {
> -	long flags;
> +	unsigned long flags;
>  
> -	save_flags(flags);
> -	cli();
> +	spin_lock_irqsave(&asuscom_lock, flags);
>  	byteout(ale, off);
>  	byteout(adr, data);
> -	restore_flags(flags);
> +	spin_unlock_irqrestore(&asuscom_lock, flags);
>  }
>  
>  static inline void

This looks good so far.

> @@ -263,14 +262,13 @@
>  static void
>  reset_asuscom(struct IsdnCardState *cs)
>  {
> -	long flags;
> +	unsigned long flags;
>  
>  	if (cs->subtyp == ASUS_IPAC)
>  		writereg(cs->hw.asus.adr, cs->hw.asus.isac, IPAC_POTA2, 0x20);
>  	else
>  		byteout(cs->hw.asus.adr, ASUS_RESET);	/* Reset On */
> -	save_flags(flags);
> -	sti();
> +	spin_lock_irqsave(&asuscom_lock, flags);
>  	set_current_state(TASK_UNINTERRUPTIBLE);
>  	schedule_timeout((10*HZ)/1000);
>  	if (cs->subtyp == ASUS_IPAC)
> @@ -286,7 +284,7 @@
>  		writereg(cs->hw.asus.adr, cs->hw.asus.isac, IPAC_MASK, 0xc0);
>  		writereg(cs->hw.asus.adr, cs->hw.asus.isac, IPAC_PCFG, 0x12);
>  	}
> -	restore_flags(flags);
> +	spin_unlock_irqrestore(&asuscom_lock, flags);
>  }
>  
>  static int
> 
> 

This is not right. You cannot hold a spinlock over schedule_timeout(). 
Also, you're calling writereg() with the spinlock held, which will try to 
lock it again -> instant dead lock.

The cli() protection is used due to the register bank switching, i.e. you
first tell the card which register you want to address and then read or
write from it - Only after these two steps are finished, another
concurrent register access is safe. A spinlock as done in the first to
hunks is the right solution. For reset(), you don't really need additional
protection at all, so just remove the save_flags(); sti() there, that's
unnecessary anyway.

Could you please make sure that you 
o do not hold the spinlocks over schedule(), schedule_timeout() etc and
o never call code which might try to acquire the spinlock from a region
  where the lock already is held

and resend?

Thanks,
--Kai

