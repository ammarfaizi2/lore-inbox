Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288190AbSAMWUf>; Sun, 13 Jan 2002 17:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288192AbSAMWUd>; Sun, 13 Jan 2002 17:20:33 -0500
Received: from darkwing.uoregon.edu ([128.223.142.13]:32989 "EHLO
	darkwing.uoregon.edu") by vger.kernel.org with ESMTP
	id <S288190AbSAMWUW>; Sun, 13 Jan 2002 17:20:22 -0500
Date: Sun, 13 Jan 2002 14:19:51 -0800 (PST)
From: Joel Jaeggli <joelja@darkwing.uoregon.edu>
X-X-Sender: <joelja@twin.uoregon.edu>
To: <jt@hpl.hp.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wavelan_cs update (Pcmcia backport)
In-Reply-To: <20020111151825.C15515@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.4.33.0201131418390.14538-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wow thanks... it's imminently useful to me.

joelja

On Fri, 11 Jan 2002, Jean Tourrilhes wrote:

> 	Hi,
> 
> 	I was playing with wavelan_cs in the kernel (converting it to
> the new Wireless Extensions), and I realised that it doesn't work at
> all. I had a look at the code and it is so antique that it is scary.
> 	So, I did a backport of the version of the driver in the
> Pcmcia package, which is one year old and which works. The main
> changes are in the log below (many spinlock changes), many other
> changes are because the Pcmcia version is doing the same things
> differently (I made sure no change was lost). Patch is large by having
> both drivers in sync is a bonus.
> 	As a driver that works is better than a driver that doesn't
> work, I would like this patch to be included in the various kernels.
> 
> 	Regards,
> 
> 	Jean
> 
> --------------------------------------------------------------
> 
> diff -u -p -r linux/drivers/net/pcmcia-buggy/wavelan.h linux/drivers/net/pcmcia/wavelan.h
> --- linux/drivers/net/pcmcia-buggy/wavelan.h	Fri Mar  2 11:02:15 2001
> +++ linux/drivers/net/pcmcia/wavelan.h	Fri Jan 11 14:25:31 2002
> @@ -88,6 +88,7 @@ const short	channel_bands[] = { 0x30, 0x
>   */
>  const int	fixed_bands[] = { 915e6, 2.425e8, 2.46e8, 2.484e8, 2.4305e8 };
>  
> +
>  /*************************** PC INTERFACE ****************************/
>  
>  /* WaveLAN host interface definitions */
> @@ -316,6 +317,7 @@ struct mmw_t
>  /* Calculate offset of a field in the above structure */
>  #define	mmwoff(p,f) 	(unsigned short)((void *)(&((mmw_t *)((void *)0 + (p)))->f) - (void *)0)
>  
> +
>  /*
>   * Modem Management Controller (MMC) read structure.
>   */
> @@ -372,6 +374,7 @@ struct mmr_t
>  
>  /* Calculate offset of a field in the above structure */
>  #define	mmroff(p,f) 	(unsigned short)((void *)(&((mmr_t *)((void *)0 + (p)))->f) - (void *)0)
> +
>  
>  /* Make the two above structures one */
>  typedef union mm_t
> diff -u -p -r linux/drivers/net/pcmcia-buggy/wavelan_cs.c linux/drivers/net/pcmcia/wavelan_cs.c
> --- linux/drivers/net/pcmcia-buggy/wavelan_cs.c	Fri Nov  9 15:22:54 2001
> +++ linux/drivers/net/pcmcia/wavelan_cs.c	Fri Jan 11 14:57:51 2002
> @@ -22,7 +22,7 @@
>  #ifdef WAVELAN_ROAMING	
>   * Roaming support added 07/22/98 by Justin Seger (jseger@media.mit.edu)
>   * based on patch by Joe Finney from Lancaster University.
> -#endif :-)
> +#endif
>   *
>   * Lucent (formerly AT&T GIS, formerly NCR) WaveLAN PCMCIA card: An
>   * Ethernet-like radio transceiver controlled by an Intel 82593 coprocessor.
> @@ -37,12 +37,6 @@
>   * Apr 2 '98  made changes to bring the i82593 control/int handling in line
>   *             with offical specs...
>   *
> - * Changes:
> - * Arnaldo Carvalho de Melo <acme@conectiva.com.br> - 08/08/2000
> - * - reorganize kmallocs in wavelan_attach, checking all for failure
> - *   and releasing the previous allocations if one fails
> - *
> - *
>   ****************************************************************************
>   *   Copyright 1995
>   *   Anthony D. Joseph
> @@ -72,6 +66,34 @@
>  
>  /*------------------------------------------------------------------*/
>  /*
> + * Wrapper for disabling interrupts.
> + * (note : inline, so optimised away)
> + */
> +static inline void
> +wv_splhi(net_local *		lp,
> +	 unsigned long *	pflags)
> +{
> +  spin_lock_irqsave(&lp->spinlock, *pflags);
> +  /* Note : above does the cli(); itself */
> +}
> +
> +/*------------------------------------------------------------------*/
> +/*
> + * Wrapper for re-enabling interrupts.
> + */
> +static inline void
> +wv_splx(net_local *		lp,
> +	unsigned long *		pflags)
> +{
> +  spin_unlock_irqrestore(&lp->spinlock, *pflags);
> +
> +  /* Note : enabling interrupts on the hardware is done in wv_ru_start()
> +   * via : outb(OP1_INT_ENABLE, LCCR(base));
> +   */
> +}
> +
> +/*------------------------------------------------------------------*/
> +/*
>   * Wrapper for reporting error to cardservices
>   */
>  static void cs_error(client_handle_t handle, int func, int ret)
> @@ -103,7 +125,7 @@ wv_structuct_check(void)
>  
>  /******************* MODEM MANAGEMENT SUBROUTINES *******************/
>  /*
> - * Usefull subroutines to manage the modem of the wavelan
> + * Useful subroutines to manage the modem of the wavelan
>   */
>  
>  /*------------------------------------------------------------------*/
> @@ -138,7 +160,7 @@ hacr_write_slow(u_long	base,
>  {
>    hacr_write(base, hacr);
>    /* delay might only be needed sometimes */
> -  mdelay(1L);
> +  mdelay(1);
>  } /* hacr_write_slow */
>  
>  /*------------------------------------------------------------------*/
> @@ -529,7 +551,7 @@ void wv_roam_init(struct net_device *dev
>    lp->curr_point=NULL;                        /* No default WavePoint */
>    lp->cell_search=0;
>    
> -  lp->cell_timer.data=(int)lp;                /* Start cell expiry timer */
> +  lp->cell_timer.data=(long)lp;               /* Start cell expiry timer */
>    lp->cell_timer.function=wl_cell_expiry;
>    lp->cell_timer.expires=jiffies+CELL_TIMEOUT;
>    add_timer(&lp->cell_timer);
> @@ -569,18 +591,18 @@ void wv_nwid_filter(unsigned char mode, 
>  #endif
>    
>    /* Disable interrupts & save flags */
> -  spin_lock_irqsave (&lp->lock, flags);
> +  wv_splhi(lp, &flags);
>    
>    m.w.mmw_loopt_sel = (mode==NWID_PROMISC) ? MMW_LOOPT_SEL_DIS_NWID : 0x00;
>    mmc_write(lp->dev->base_addr, (char *)&m.w.mmw_loopt_sel - (char *)&m, (unsigned char *)&m.w.mmw_loopt_sel, 1);
>    
> -  /* ReEnable interrupts & restore flags */
> -  spin_unlock_irqrestore (&lp->lock, flags);
> -  
>    if(mode==NWID_PROMISC)
>      lp->cell_search=1;
>    else
> -	lp->cell_search=0;
> +    lp->cell_search=0;
> +
> +  /* ReEnable interrupts & restore flags */
> +  wv_splx(lp, &flags);
>  }
>  
>  /* Find a record in the WavePoint table matching a given NWID */
> @@ -737,7 +759,7 @@ void wv_roam_handover(wavepoint_history 
>    ioaddr_t              base = lp->dev->base_addr;  
>    mm_t                  m;
>    unsigned long         flags;
> -  
> +
>    if(wavepoint==lp->curr_point)          /* Sanity check... */
>      {
>        wv_nwid_filter(!NWID_PROMISC,lp);
> @@ -749,16 +771,16 @@ void wv_roam_handover(wavepoint_history 
>  #endif
>   	
>    /* Disable interrupts & save flags */
> -  spin_lock_irqsave(&lp->lock, flags);
> -  
> +  wv_splhi(lp, &flags);
> +
>    m.w.mmw_netw_id_l = wavepoint->nwid & 0xFF;
>    m.w.mmw_netw_id_h = (wavepoint->nwid & 0xFF00) >> 8;
>    
>    mmc_write(base, (char *)&m.w.mmw_netw_id_l - (char *)&m, (unsigned char *)&m.w.mmw_netw_id_l, 2);
>    
>    /* ReEnable interrupts & restore flags */
> -  spin_unlock_irqrestore (&lp->lock, flags);
> -  
> +  wv_splx(lp, &flags);
> +
>    wv_nwid_filter(!NWID_PROMISC,lp);
>    lp->curr_point=wavepoint;
>  }
> @@ -775,6 +797,11 @@ static inline void wl_roam_gather(device
>    wavepoint_history *wavepoint=NULL;                /* WavePoint table entry */
>    net_local *lp=(net_local *)dev->priv;              /* Device info */
>  
> +#if 0
> +  /* Some people don't need this, some other may need it */
> +  nwid=nwid^ntohs(beacon->domain_id);
> +#endif
> +
>  #if WAVELAN_ROAMING_DEBUG > 1
>    printk(KERN_DEBUG "WaveLAN: beacon, dev %s:\n",dev->name);
>    printk(KERN_DEBUG "Domain: %.4X NWID: %.4X SigQual=%d\n",ntohs(beacon->domain_id),nwid,sigqual);
> @@ -832,7 +859,9 @@ static inline int WAVELAN_BEACON(unsigne
>  /*------------------------------------------------------------------*/
>  /*
>   * Routine to synchronously send a command to the i82593 chip. 
> - * Should be called with interrupts enabled.
> + * Should be called with interrupts disabled.
> + * (called by wv_packet_write(), wv_ru_stop(), wv_ru_start(),
> + *  wv_82593_config() & wv_diag())
>   */
>  static int
>  wv_82593_cmd(device *	dev,
> @@ -841,74 +870,98 @@ wv_82593_cmd(device *	dev,
>  	     int	result)
>  {
>    ioaddr_t	base = dev->base_addr;
> -  net_local *	lp = (net_local *)dev->priv;
>    int		status;
> +  int		wait_completed;
>    long		spin;
> -  u_long	flags;
>  
>    /* Spin until the chip finishes executing its current command (if any) */
> +  spin = 1000;
>    do
>      {
> -      spin_lock_irqsave (&lp->lock, flags);
> +      /* Time calibration of the loop */
> +      udelay(10);
> +
> +      /* Read the interrupt register */
>        outb(OP0_NOP | CR0_STATUS_3, LCCR(base));
>        status = inb(LCSR(base));
> -      spin_unlock_irqrestore (&lp->lock, flags);
>      }
> -  while((status & SR3_EXEC_STATE_MASK) != SR3_EXEC_IDLE);
> +  while(((status & SR3_EXEC_STATE_MASK) != SR3_EXEC_IDLE) && (spin-- > 0));
>  
> -  /* We are waiting for command completion */
> -  wv_wait_completed = TRUE;
> +  /* If the interrupt hasn't be posted */
> +  if(spin <= 0)
> +    {
> +#ifdef DEBUG_INTERRUPT_ERROR
> +      printk(KERN_INFO "wv_82593_cmd: %s timeout (previous command), status 0x%02x\n",
> +	     str, status);
> +#endif
> +      return(FALSE);
> +    }
>  
>    /* Issue the command to the controller */
>    outb(cmd, LCCR(base));
>  
> -  /* If we don't have to check the result of the command */
> +  /* If we don't have to check the result of the command
> +   * Note : this mean that the irq handler will deal with that */
>    if(result == SR0_NO_RESULT)
> -    {
> -      wv_wait_completed = FALSE;
> -      return(TRUE);
> -    }
> +    return(TRUE);
>  
> -  /* Busy wait while the LAN controller executes the command.
> -   * Note : wv_wait_completed should be volatile */
> -  spin = 0;
> -  while(wv_wait_completed && (spin++ < 1000))
> -    udelay(10);
> +  /* We are waiting for command completion */
> +  wait_completed = TRUE;
>  
> -  /* If the interrupt handler hasn't be called */
> -  if(wv_wait_completed)
> +  /* Busy wait while the LAN controller executes the command. */
> +  spin = 1000;
> +  do
>      {
> -      outb(OP0_NOP, LCCR(base));
> +      /* Time calibration of the loop */
> +      udelay(10);
> +
> +      /* Read the interrupt register */
> +      outb(CR0_STATUS_0 | OP0_NOP, LCCR(base));
>        status = inb(LCSR(base));
> -      if(status & SR0_INTERRUPT)
> +
> +      /* Check if there was an interrupt posted */
> +      if((status & SR0_INTERRUPT))
>  	{
> -	  /* There was an interrupt : call the interrupt handler */
> -#ifdef DEBUG_INTERRUPT_ERROR
> -	  printk(KERN_WARNING "wv_82593_cmd: interrupt handler not installed or interrupt disabled\n");
> -#endif
> +	  /* Acknowledge the interrupt */
> +	  outb(CR0_INT_ACK | OP0_NOP, LCCR(base));
>  
> -	  wavelan_interrupt(dev->irq, (void *) dev,
> -			    (struct pt_regs *) NULL);
> +	  /* Check if interrupt is a command completion */
> +	  if(((status & SR0_BOTH_RX_TX) != SR0_BOTH_RX_TX) &&
> +	     ((status & SR0_BOTH_RX_TX) != 0x0) &&
> +	     !(status & SR0_RECEPTION))
> +	    {
> +	      /* Signal command completion */
> +	      wait_completed = FALSE;
> +	    }
> +	  else
> +	    {
> +	      /* Note : Rx interrupts will be handled later, because we can
> +	       * handle multiple Rx packets at once */
> +#ifdef DEBUG_INTERRUPT_INFO
> +	      printk(KERN_INFO "wv_82593_cmd: not our interrupt\n");
> +#endif
> +	    }
>  	}
> -      else
> -	{
> -	  wv_wait_completed = 0; /* XXX */
> +    }
> +  while(wait_completed && (spin-- > 0));
> +
> +  /* If the interrupt hasn't be posted */
> +  if(wait_completed)
> +    {
>  #ifdef DEBUG_INTERRUPT_ERROR
> -	  printk(KERN_INFO "wv_82593_cmd: %s timeout, status0 0x%02x\n",
> -		 str, status);
> +      printk(KERN_INFO "wv_82593_cmd: %s timeout, status 0x%02x\n",
> +	     str, status);
>  #endif
> -	  /* We probably should reset the controller here */
> -	  return(FALSE);
> -	}
> +      return(FALSE);
>      }
>  
> -  /* Check the return code provided by the interrupt handler against
> +  /* Check the return code returned by the card (see above) against
>     * the expected return code provided by the caller */
> -  if((lp->status & SR0_EVENT_MASK) != result)
> +  if((status & SR0_EVENT_MASK) != result)
>      {
>  #ifdef DEBUG_INTERRUPT_ERROR
> -      printk(KERN_INFO "wv_82593_cmd: %s failed, status0 = 0x%x\n",
> -	     str, lp->status);
> +      printk(KERN_INFO "wv_82593_cmd: %s failed, status = 0x%x\n",
> +	     str, status);
>  #endif
>        return(FALSE);
>      }
> @@ -924,14 +977,16 @@ wv_82593_cmd(device *	dev,
>  static inline int
>  wv_diag(device *	dev)
>  {
> +  int		ret = FALSE;
> +
>    if(wv_82593_cmd(dev, "wv_diag(): diagnose",
>  		  OP0_DIAGNOSE, SR0_DIAGNOSE_PASSED))
> -    return(TRUE);
> +    ret = TRUE;
>  
>  #ifdef DEBUG_CONFIG_ERROR
>    printk(KERN_INFO "wavelan_cs: i82593 Self Test failed!\n");
>  #endif
> -  return(FALSE);
> +  return(ret);
>  } /* wv_diag */
>  
>  /*------------------------------------------------------------------*/
> @@ -951,15 +1006,6 @@ read_ringbuf(device *	dev,
>    int		chunk_len;
>    char *	buf_ptr = buf;
>  
> -#ifdef OLDIES
> -  /* After having check skb_put (net/core/skbuff.c) in the kernel, it seem
> -   * quite safe to remove this... */
> -
> -  /* If buf is NULL, just increment the ring buffer pointer */
> -  if(buf == NULL)
> -    return((ring_ptr - RX_BASE + len) % RX_SIZE + RX_BASE);
> -#endif
> -
>    /* Get all the buffer */
>    while(len > 0)
>      {
> @@ -990,70 +1036,32 @@ read_ringbuf(device *	dev,
>   * wavelan_interrupt is not an option...), so you may experience
>   * some delay sometime...
>   */
> -static inline void wv_82593_reconfig (device * dev)
> +static inline void
> +wv_82593_reconfig(device *	dev)
>  {
> -	net_local *lp = (net_local *) dev->priv;
> -	dev_link_t *link = ((net_local *) dev->priv)->link;
> +  net_local *		lp = (net_local *)dev->priv;
> +  dev_link_t *		link = ((net_local *) dev->priv)->link;
> +  unsigned long		flags;
> +
> +  /* Arm the flag, will be cleard in wv_82593_config() */
> +  lp->reconfig_82593 = TRUE;
>  
> -	/* Check if we can do it now ! */
> -	if (!(link->open)) {
> -		lp->reconfig_82593 = TRUE;
> +  /* Check if we can do it now ! */
> +  if((link->open) && (netif_running(dev)) && !(netif_queue_stopped(dev)))
> +    {
> +      wv_splhi(lp, &flags);	/* Disable interrupts */
> +      wv_82593_config(dev);
> +      wv_splx(lp, &flags);	/* Re-enable interrupts */
> +    }
> +  else
> +    {
>  #ifdef DEBUG_IOCTL_INFO
> -		printk (KERN_DEBUG "%s: wv_82593_reconfig(): delayed (link = %d)\n",
> -			dev->name, link->open);
> +      printk(KERN_DEBUG
> +	     "%s: wv_82593_reconfig(): delayed (state = %lX, link = %d)\n",
> +	     dev->name, dev->state, link->open);
>  #endif
> -	} else {
> -		netif_stop_queue (dev);
> -
> -		lp->reconfig_82593 = FALSE;
> -		wv_82593_config (dev);
> -		netif_wake_queue (dev);
> -	}
> -}
> -
> -#ifdef OLDIES
> -/*------------------------------------------------------------------*/
> -/*
> - * Dumps the current i82593 receive buffer to the console.
> - */
> -static void wavelan_dump(device *dev)
> -{
> -  ioaddr_t base = dev->base_addr;
> -  int i, c;
> -
> -  /* disable receiver so we can use channel 1 */
> -  outb(OP0_RCV_DISABLE, LCCR(base));
> -
> -  /* reset receive DMA pointer */
> -  hacr_write_slow(base, HACR_PWR_STAT | HACR_RX_DMA_RESET);
> -  hacr_write(base, HACR_DEFAULT);
> -
> -  /* dump into receive buffer */
> -  wv_82593_cmd(dev, "wavelan_dump(): dump", CR0_CHNL|OP0_DUMP, SR0_DUMP_DONE);
> -
> -  /* set read pointer to start of receive buffer */
> -  outb(0, PIORL(base));
> -  outb(0, PIORH(base));
> -
> -  printk(KERN_DEBUG "wavelan_cs: dump:\n");
> -  printk(KERN_DEBUG "     00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F");
> -  for(i = 0; i < 73; i++){
> -    if((i % 16) == 0) {
> -      printk("\n0x%02x:", i);
> -      if (!i) {
> -	printk("   ");
> -	continue;
> -      }
>      }
> -    c = inb(PIOP(base));
> -    printk("%02x ", c);
> -  }
> -  printk("\n");
> -
> -  /* enable the receiver again */
> -  wv_ru_start(dev);
>  }
> -#endif
>  
>  /********************* DEBUG & INFO SUBROUTINES *********************/
>  /*
> @@ -1171,6 +1179,8 @@ wv_mmc_show(device *	dev)
>        return;
>      }
>  
> +  wv_splhi(lp, &flags);
> +
>    /* Read the mmc */
>    mmc_out(base, mmwoff(0, mmw_freeze), 1);
>    mmc_read(base, 0, (u_char *)&m, sizeof(m));
> @@ -1181,6 +1191,8 @@ wv_mmc_show(device *	dev)
>    lp->wstats.discard.nwid += (m.mmr_wrong_nwid_h << 8) | m.mmr_wrong_nwid_l;
>  #endif	/* WIRELESS_EXT */
>  
> +  wv_splx(lp, &flags);
> +
>    printk(KERN_DEBUG "##### wavelan modem status registers: #####\n");
>  #ifdef DEBUG_SHOW_UNUSED
>    printk(KERN_DEBUG "mmc_unused0[]: %02X:%02X:%02X:%02X:%02X:%02X:%02X:%02X\n",
> @@ -1265,6 +1277,7 @@ static void
>  wv_dev_show(device *	dev)
>  {
>    printk(KERN_DEBUG "dev:");
> +  printk(" state=%lX,", dev->state);
>    printk(" trans_start=%ld,", dev->trans_start);
>    printk(" flags=0x%x,", dev->flags);
>    printk("\n");
> @@ -1404,7 +1417,7 @@ wv_init_info(device *	dev)
>  	  printk("2430.5");
>  	  break;
>  	default:
> -	  printk("unknown");
> +	  printk("???");
>  	}
>      }
>  
> @@ -1719,7 +1732,7 @@ wv_set_frequency(u_long		base,	/* i/o po
>  	 memcmp(dac, dac_verify, 2 * 2))
>  	{
>  #ifdef DEBUG_IOCTL_ERROR
> -	  printk(KERN_INFO "Wavelan: wv_set_frequency : unable to write new frequency to EEprom (?)\n");
> +	  printk(KERN_INFO "Wavelan: wv_set_frequency : unable to write new frequency to EEprom (??)\n");
>  #endif
>  	  return -EOPNOTSUPP;
>  	}
> @@ -1892,7 +1905,7 @@ wavelan_ioctl(struct net_device *	dev,	/
>  #endif
>  
>    /* Disable interrupts & save flags */
> -  spin_lock_irqsave (&lp->lock, flags);
> +  wv_splhi(lp, &flags);
>  
>    /* Look what is the request */
>    switch(cmd)
> @@ -1968,7 +1981,7 @@ wavelan_ioctl(struct net_device *	dev,	/
>  
>      case SIOCGIWFREQ:
>        /* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable)
> -       * (does it work for everybody XXX - especially old cards...) */
> +       * (does it work for everybody ??? - especially old cards...) */
>        if(!(mmc_in(base, mmroff(0, mmr_fee_status)) &
>  	   (MMR_FEE_STATUS_DWLD | MMR_FEE_STATUS_BUSY)))
>  	{
> @@ -2239,15 +2252,17 @@ wavelan_ioctl(struct net_device *	dev,	/
>  	{
>  	  struct iw_range	range;
>  
> -	  /* Set the length (very important for backward compatibility) */
> -	  wrq->u.data.length = sizeof(struct iw_range);
> +	   /* Set the length (very important for backward compatibility) */
> +	   wrq->u.data.length = sizeof(struct iw_range);
>  
> -	  /* Set all the info we don't care or don't know about to zero */
> -	  memset(&range, 0, sizeof(range));
> +	   /* Set all the info we don't care or don't know about to zero */
> +	   memset(&range, 0, sizeof(range));
>  
> -	  /* Set the Wireless Extension versions */
> -	  range.we_version_compiled = WIRELESS_EXT;
> -	  range.we_version_source = 9;	/* Nothing for us in v10 and v11 */
> +#if WIRELESS_EXT > 10
> +	   /* Set the Wireless Extension versions */
> +	   range.we_version_compiled = WIRELESS_EXT;
> +	   range.we_version_source = 9;	/* Nothing for us in v10 and v11 */
> +#endif /* WIRELESS_EXT > 10 */
>  
>  	  /* Set information in the range struct */
>  	  range.throughput = 1.4 * 1000 * 1000;	/* don't argue on this ! */
> @@ -2517,7 +2532,7 @@ wavelan_ioctl(struct net_device *	dev,	/
>      }
>  
>    /* ReEnable interrupts & restore flags */
> -  spin_unlock_irqrestore (&lp->lock, flags);
> +  wv_splx(lp, &flags);
>  
>  #ifdef DEBUG_IOCTL_TRACE
>    printk(KERN_DEBUG "%s: <-wavelan_ioctl()\n", dev->name);
> @@ -2543,11 +2558,8 @@ wavelan_get_wireless_stats(device *	dev)
>    printk(KERN_DEBUG "%s: ->wavelan_get_wireless_stats()\n", dev->name);
>  #endif
>  
> -  if (lp == NULL) /* XXX will this ever occur? */
> -    return NULL;
> -
>    /* Disable interrupts & save flags */
> -  spin_lock_irqsave (&lp->lock, flags);
> +  wv_splhi(lp, &flags);
>  
>    wstats = &lp->wstats;
>  
> @@ -2573,7 +2585,7 @@ wavelan_get_wireless_stats(device *	dev)
>    wstats->discard.misc = 0L;
>  
>    /* ReEnable interrupts & restore flags */
> -  spin_unlock_irqrestore (&lp->lock, flags);
> +  wv_splx(lp, &flags);
>  
>  #ifdef DEBUG_IOCTL_TRACE
>    printk(KERN_DEBUG "%s: <-wavelan_get_wireless_stats()\n", dev->name);
> @@ -2692,12 +2704,6 @@ wv_packet_read(device *		dev,
>    skb->protocol = eth_type_trans(skb, dev);
>  
>  #ifdef DEBUG_RX_INFO
> -  /* Another glitch : Due to the way the GET_PACKET macro is written,
> -   * we are not sure to have the same thing in skb->data. On the other
> -   * hand, skb->mac.raw is not defined everywhere...
> -   * For versions between 1.2.13 and those where skb->mac.raw appear,
> -   * I don't have a clue...
> -   */
>    wv_packet_info(skb->mac.raw, sksize, dev->name, "wv_packet_read");
>  #endif	/* DEBUG_RX_INFO */
>       
> @@ -2731,9 +2737,7 @@ wv_packet_read(device *		dev,
>  	  wl_roam_gather(dev, skb->data, stats);
>  #endif	/* WAVELAN_ROAMING */
>  	  
> -      /* Spying stuff */
>  #ifdef WIRELESS_SPY
> -      /* Same as above */
>        wl_spy_gather(dev, skb->mac.raw + WAVELAN_ADDR_SIZE, stats);
>  #endif	/* WIRELESS_SPY */
>  #ifdef HISTOGRAM
> @@ -2766,6 +2770,7 @@ wv_packet_read(device *		dev,
>   * called to do the actual transfer of the card's data including the
>   * ethernet header into a packet consisting of an sk_buff chain.
>   * (called by wavelan_interrupt())
> + * Note : the spinlock is already grabbed for us and irq are disabled.
>   */
>  static inline void
>  wv_packet_rcv(device *	dev)
> @@ -2916,7 +2921,7 @@ wv_packet_write(device *	dev,
>    printk(KERN_DEBUG "%s: ->wv_packet_write(%d)\n", dev->name, length);
>  #endif
>  
> -  spin_lock_irqsave (&lp->lock, flags);
> +  wv_splhi(lp, &flags);
>  
>    /* Check if we need some padding */
>    if(clen < ETH_ZLEN)
> @@ -2946,15 +2951,7 @@ wv_packet_write(device *	dev,
>    /* Keep stats up to date */
>    lp->stats.tx_bytes += length;
>  
> -  /* If watchdog not already active, activate it... */
> -  if (!timer_pending(&lp->watchdog))
> -    {
> -      /* set timer to expire in WATCHDOG_JIFFIES */
> -      lp->watchdog.expires = jiffies + WATCHDOG_JIFFIES;
> -      add_timer(&lp->watchdog);
> -    }
> -
> -  spin_unlock_irqrestore (&lp->lock, flags);
> +  wv_splx(lp, &flags);
>  
>  #ifdef DEBUG_TX_INFO
>    wv_packet_info((u_char *) buf, length, dev->name, "wv_packet_write");
> @@ -2963,56 +2960,57 @@ wv_packet_write(device *	dev,
>  #ifdef DEBUG_TX_TRACE
>    printk(KERN_DEBUG "%s: <-wv_packet_write()\n", dev->name);
>  #endif
> -
> -  netif_start_queue (dev);
>  }
>  
>  /*------------------------------------------------------------------*/
>  /*
>   * This routine is called when we want to send a packet (NET3 callback)
> - * In this routine, we check if the hardware is ready to accept
> + * In this routine, we check if the harware is ready to accept
>   * the packet. We also prevent reentrance. Then, we call the function
>   * to send the packet...
>   */
> -static int wavelan_packet_xmit (struct sk_buff *skb,
> -				device * dev)
> +static int
> +wavelan_packet_xmit(struct sk_buff *	skb,
> +		    device *		dev)
>  {
> -	net_local *lp = (net_local *) dev->priv;
> +  net_local *		lp = (net_local *)dev->priv;
> +  unsigned long		flags;
>  
>  #ifdef DEBUG_TX_TRACE
> -	printk (KERN_DEBUG "%s: ->wavelan_packet_xmit(0x%X)\n", dev->name,
> -		(unsigned) skb);
> +  printk(KERN_DEBUG "%s: ->wavelan_packet_xmit(0x%X)\n", dev->name,
> +	 (unsigned) skb);
>  #endif
>  
> -	/*
> -	 * For ethernet, fill in the header.
> -	 */
> +  /*
> +   * Block a timer-based transmit from overlapping a previous transmit.
> +   * In other words, prevent reentering this routine.
> +   */
> +  netif_stop_queue(dev);
>  
> -	netif_stop_queue (dev);
> +  /* If somebody has asked to reconfigure the controller,
> +   * we can do it now */
> +  if(lp->reconfig_82593)
> +    {
> +      wv_splhi(lp, &flags);	/* Disable interrupts */
> +      wv_82593_config(dev);
> +      wv_splx(lp, &flags);	/* Re-enable interrupts */
> +      /* Note : the configure procedure was totally synchronous,
> +       * so the Tx buffer is now free */
> +    }
>  
> -	/*
> -	 * Block a timer-based transmit from overlapping a previous transmit.
> -	 * In other words, prevent reentering this routine.
> -	 */
> -	if (1) {
> -		/* If somebody has asked to reconfigure the controller, we can do it now */
> -		if (lp->reconfig_82593) {
> -			lp->reconfig_82593 = FALSE;
> -			wv_82593_config (dev);
> -		}
>  #ifdef DEBUG_TX_ERROR
> -		if (skb->next)
> -			printk (KERN_INFO "skb has next\n");
> +	if (skb->next)
> +		printk(KERN_INFO "skb has next\n");
>  #endif
>  
> -		wv_packet_write (dev, skb->data, skb->len);
> -	}
> -	dev_kfree_skb (skb);
> +  wv_packet_write(dev, skb->data, skb->len);
> +
> +  dev_kfree_skb(skb);
>  
>  #ifdef DEBUG_TX_TRACE
> -	printk (KERN_DEBUG "%s: <-wavelan_packet_xmit()\n", dev->name);
> +  printk(KERN_DEBUG "%s: <-wavelan_packet_xmit()\n", dev->name);
>  #endif
> -	return (0);
> +  return(0);
>  }
>  
>  /********************** HARDWARE CONFIGURATION **********************/
> @@ -3165,7 +3163,7 @@ wv_mmc_init(device *	dev)
>     */
>  
>    /* Attempt to recognise 2.00 cards (2.4 GHz frequency selectable)
> -   * (does it work for everybody XXX - especially old cards...) */
> +   * (does it work for everybody ??? - especially old cards...) */
>    /* Note : WFREQSEL verify that it is able to read from EEprom
>     * a sensible frequency (address 0x00) + that MMR_FEE_STATUS_ID
>     * is 0xA (Xilinx version) or 0xB (Ariadne version).
> @@ -3223,7 +3221,7 @@ static int
>  wv_ru_stop(device *	dev)
>  {
>    ioaddr_t	base = dev->base_addr;
> -  net_local *lp = (net_local *) dev->priv;
> +  net_local *	lp = (net_local *) dev->priv;
>    unsigned long	flags;
>    int		status;
>    int		spin;
> @@ -3232,35 +3230,35 @@ wv_ru_stop(device *	dev)
>    printk(KERN_DEBUG "%s: ->wv_ru_stop()\n", dev->name);
>  #endif
>  
> +  wv_splhi(lp, &flags);
> +
>    /* First, send the LAN controller a stop receive command */
>    wv_82593_cmd(dev, "wv_graceful_shutdown(): stop-rcv",
>  	       OP0_STOP_RCV, SR0_NO_RESULT);
>  
>    /* Then, spin until the receive unit goes idle */
> -  spin = 0;
> +  spin = 300;
>    do
>      {
>        udelay(10);
> -      spin_lock_irqsave (&lp->lock, flags);
>        outb(OP0_NOP | CR0_STATUS_3, LCCR(base));
>        status = inb(LCSR(base));
> -      spin_unlock_irqrestore (&lp->lock, flags);
>      }
> -  while(((status & SR3_RCV_STATE_MASK) != SR3_RCV_IDLE) && (spin++ < 300));
> +  while(((status & SR3_RCV_STATE_MASK) != SR3_RCV_IDLE) && (spin-- > 0));
>  
>    /* Now, spin until the chip finishes executing its current command */
>    do
>      {
>        udelay(10);
> -      spin_lock_irqsave (&lp->lock, flags);
>        outb(OP0_NOP | CR0_STATUS_3, LCCR(base));
>        status = inb(LCSR(base));
> -      spin_unlock_irqrestore (&lp->lock, flags);
>      }
> -  while(((status & SR3_EXEC_STATE_MASK) != SR3_EXEC_IDLE) && (spin++ < 300));
> +  while(((status & SR3_EXEC_STATE_MASK) != SR3_EXEC_IDLE) && (spin-- > 0));
> +
> +  wv_splx(lp, &flags);
>  
>    /* If there was a problem */
> -  if(spin > 300)
> +  if(spin <= 0)
>      {
>  #ifdef DEBUG_CONFIG_ERROR
>        printk(KERN_INFO "%s: wv_ru_stop(): The chip doesn't want to stop...\n",
> @@ -3287,6 +3285,7 @@ wv_ru_start(device *	dev)
>  {
>    ioaddr_t	base = dev->base_addr;
>    net_local *	lp = (net_local *) dev->priv;
> +  unsigned long	flags;
>  
>  #ifdef DEBUG_CONFIG_TRACE
>    printk(KERN_DEBUG "%s: ->wv_ru_start()\n", dev->name);
> @@ -3300,6 +3299,8 @@ wv_ru_start(device *	dev)
>    if(!wv_ru_stop(dev))
>      return FALSE;
>  
> +  wv_splhi(lp, &flags);
> +
>    /* Now we know that no command is being executed. */
>  
>    /* Set the receive frame pointer and stop pointer */
> @@ -3309,8 +3310,17 @@ wv_ru_start(device *	dev)
>    /* Reset ring management.  This sets the receive frame pointer to 1 */
>    outb(OP1_RESET_RING_MNGMT, LCCR(base));
>  
> +#if 0
> +  /* XXX the i82593 manual page 6-4 seems to indicate that the stop register
> +     should be set as below */
> +  /* outb(CR1_STOP_REG_UPDATE|((RX_SIZE - 0x40)>> RX_SIZE_SHIFT),LCCR(base));*/
> +#elif 0
> +  /* but I set it 0 instead */
> +  lp->stop = 0;
> +#else
>    /* but I set it to 3 bytes per packet less than 8K */
>    lp->stop = (0 + RX_SIZE - ((RX_SIZE / 64) * 3)) % RX_SIZE;
> +#endif
>    outb(CR1_STOP_REG_UPDATE | (lp->stop >> RX_SIZE_SHIFT), LCCR(base));
>    outb(OP1_INT_ENABLE, LCCR(base));
>    outb(OP1_SWIT_TO_PORT_0, LCCR(base));
> @@ -3326,17 +3336,15 @@ wv_ru_start(device *	dev)
>  #ifdef DEBUG_I82593_SHOW
>    {
>      int	status;
> -    unsigned long flags;
> -    int	i = 0;
> +    int	opri;
> +    int	spin = 10000;
>  
>      /* spin until the chip starts receiving */
>      do
>        {
> -	spin_lock_irqsave (&lp->lock, flags);
>  	outb(OP0_NOP | CR0_STATUS_3, LCCR(base));
>  	status = inb(LCSR(base));
> -	spin_unlock_irqrestore (&lp->lock, flags);
> -	if(i++ > 10000)
> +	if(spin-- <= 0)
>  	  break;
>        }
>      while(((status & SR3_RCV_STATE_MASK) != SR3_RCV_ACTIVE) &&
> @@ -3345,6 +3353,9 @@ wv_ru_start(device *	dev)
>  	   (status & SR3_RCV_STATE_MASK), i);
>    }
>  #endif
> +
> +  wv_splx(lp, &flags);
> +
>  #ifdef DEBUG_CONFIG_TRACE
>    printk(KERN_DEBUG "%s: <-wv_ru_start()\n", dev->name);
>  #endif
> @@ -3363,6 +3374,7 @@ wv_82593_config(device *	dev)
>    ioaddr_t			base = dev->base_addr;
>    net_local *			lp = (net_local *) dev->priv;
>    struct i82593_conf_block	cfblk;
> +  int				ret = TRUE;
>  
>  #ifdef DEBUG_CONFIG_TRACE
>    printk(KERN_DEBUG "%s: ->wv_82593_config()\n", dev->name);
> @@ -3457,7 +3469,7 @@ wv_82593_config(device *	dev)
>    hacr_write(base, HACR_DEFAULT);
>    if(!wv_82593_cmd(dev, "wv_82593_config(): configure",
>  		   OP0_CONFIGURE, SR0_CONFIGURE_DONE))
> -    return(FALSE);
> +    ret = FALSE;
>  
>    /* Initialize adapter's ethernet MAC address */
>    outb(TX_BASE & 0xff, PIORL(base));
> @@ -3471,7 +3483,7 @@ wv_82593_config(device *	dev)
>    hacr_write(base, HACR_DEFAULT);
>    if(!wv_82593_cmd(dev, "wv_82593_config(): ia-setup",
>  		   OP0_IA_SETUP, SR0_IA_SETUP_DONE))
> -    return(FALSE);
> +    ret = FALSE;
>  
>  #ifdef WAVELAN_ROAMING
>      /* If roaming is enabled, join the "Beacon Request" multicast group... */
> @@ -3508,14 +3520,17 @@ wv_82593_config(device *	dev)
>        hacr_write(base, HACR_DEFAULT);
>        if(!wv_82593_cmd(dev, "wv_82593_config(): mc-setup",
>  		       OP0_MC_SETUP, SR0_MC_SETUP_DONE))
> -	return(FALSE);
> +	ret = FALSE;
>        lp->mc_count = dev->mc_count;	/* remember to avoid repeated reset */
>      }
>  
> +  /* Job done, clear the flag */
> +  lp->reconfig_82593 = FALSE;
> +
>  #ifdef DEBUG_CONFIG_TRACE
>    printk(KERN_DEBUG "%s: <-wv_82593_config()\n", dev->name);
>  #endif
> -  return(TRUE);
> +  return(ret);
>  }
>  
>  /*------------------------------------------------------------------*/
> @@ -3594,6 +3609,8 @@ wv_hw_config(device *	dev)
>  {
>    net_local *		lp = (net_local *) dev->priv;
>    ioaddr_t		base = dev->base_addr;
> +  unsigned long		flags;
> +  int			ret = FALSE;
>  
>  #ifdef DEBUG_CONFIG_TRACE
>    printk(KERN_DEBUG "%s: ->wv_hw_config()\n", dev->name);
> @@ -3612,50 +3629,78 @@ wv_hw_config(device *	dev)
>    if(wv_pcmcia_reset(dev) == FALSE)
>      return FALSE;
>  
> -  /* Power UP the module + reset the modem + reset host adapter
> -   * (in fact, reset DMA channels) */
> -  hacr_write_slow(base, HACR_RESET);
> -  hacr_write(base, HACR_DEFAULT);
> +  /* Disable interrupts */
> +  wv_splhi(lp, &flags);
>  
> -  /* Check if the module has been powered up... */
> -  if(hasr_read(base) & HASR_NO_CLK)
> +  /* Disguised goto ;-) */
> +  do
>      {
> +      /* Power UP the module + reset the modem + reset host adapter
> +       * (in fact, reset DMA channels) */
> +      hacr_write_slow(base, HACR_RESET);
> +      hacr_write(base, HACR_DEFAULT);
> +
> +      /* Check if the module has been powered up... */
> +      if(hasr_read(base) & HASR_NO_CLK)
> +	{
>  #ifdef DEBUG_CONFIG_ERRORS
> -      printk(KERN_WARNING "%s: wv_hw_config(): modem not connected or not a wavelan card\n",
> -	     dev->name);
> +	  printk(KERN_WARNING "%s: wv_hw_config(): modem not connected or not a wavelan card\n",
> +		 dev->name);
>  #endif
> -      return FALSE;
> -    }
> +	  break;
> +	}
>  
> -  /* initialize the modem */
> -  if(wv_mmc_init(dev) == FALSE)
> -    return FALSE;
> +      /* initialize the modem */
> +      if(wv_mmc_init(dev) == FALSE)
> +	{
> +#ifdef DEBUG_CONFIG_ERRORS
> +	  printk(KERN_WARNING "%s: wv_hw_config(): Can't configure the modem\n",
> +		 dev->name);
> +#endif
> +	  break;
> +	}
>  
> -  /* reset the LAN controller (i82593) */
> -  outb(OP0_RESET, LCCR(base));
> -  mdelay(1);	/* A bit crude ! */
> -
> -  /* Initialize the LAN controller */
> -  if((wv_82593_config(dev) == FALSE) ||
> -     (wv_diag(dev) == FALSE))
> -    {
> +      /* reset the LAN controller (i82593) */
> +      outb(OP0_RESET, LCCR(base));
> +      mdelay(1);	/* A bit crude ! */
> +
> +      /* Initialize the LAN controller */
> +      if(wv_82593_config(dev) == FALSE)
> +	{
>  #ifdef DEBUG_CONFIG_ERRORS
> -      printk(KERN_INFO "%s: wv_hw_config(): i82593 init failed\n", dev->name);
> +	  printk(KERN_INFO "%s: wv_hw_config(): i82593 init failed\n",
> +		 dev->name);
>  #endif
> -      return FALSE;
> -    }
> +	  break;
> +	}
>  
> -  /* 
> -   * insert code for loopback test here
> -   */
> +      /* Diagnostic */
> +      if(wv_diag(dev) == FALSE)
> +	{
> +#ifdef DEBUG_CONFIG_ERRORS
> +	  printk(KERN_INFO "%s: wv_hw_config(): i82593 diagnostic failed\n",
> +		 dev->name);
> +#endif
> +	  break;
> +	}
>  
> -  /* The device is now configured */
> -  lp->configured = 1;
> +      /* 
> +       * insert code for loopback test here
> +       */
> +
> +      /* The device is now configured */
> +      lp->configured = 1;
> +      ret = TRUE;
> +    }
> +  while(0);
> +
> +  /* Re-enable interrupts */
> +  wv_splx(lp, &flags);
>  
>  #ifdef DEBUG_CONFIG_TRACE
>    printk(KERN_DEBUG "%s: <-wv_hw_config()\n", dev->name);
>  #endif
> -  return TRUE;
> +  return(ret);
>  }
>  
>  /*------------------------------------------------------------------*/
> @@ -3675,10 +3720,6 @@ wv_hw_reset(device *	dev)
>    printk(KERN_DEBUG "%s: ->wv_hw_reset()\n", dev->name);
>  #endif
>  
> -  /* If watchdog was activated, kill it ! */
> -  if (timer_pending(&lp->watchdog))
> -    del_timer(&lp->watchdog);
> -
>    lp->nresets++;
>    lp->configured = 0;
>    
> @@ -3786,13 +3827,13 @@ wv_pcmcia_config(dev_link_t *	link)
>  	}
>  
>        /*
> -       * Allocate a 4K memory window.  Note that the dev_link_t
> +       * Allocate a small memory window.  Note that the dev_link_t
>         * structure provides space for one window handle -- if your
>         * device needs several windows, you'll need to keep track of
>         * the handles in your private data structure, link->priv.
>         */
>        req.Attributes = WIN_DATA_WIDTH_8|WIN_MEMORY_TYPE_AM|WIN_ENABLE;
> -      req.Base = 0; req.Size = 0x1000;
> +      req.Base = req.Size = 0;
>        req.AccessSpeed = mem_speed;
>        link->win = (window_handle_t)link->handle;
>        i = CardServices(RequestWindow, &link->win, &req);
> @@ -3803,7 +3844,7 @@ wv_pcmcia_config(dev_link_t *	link)
>  	}
>  
>        dev->rmem_start = dev->mem_start =
> -	  (u_long)ioremap(req.Base, 0x1000);
> +	  (u_long)ioremap(req.Base, req.Size);
>        dev->rmem_end = dev->mem_end = dev->mem_start + req.Size;
>  
>        mem.CardOffset = 0; mem.Page = 0;
> @@ -3817,7 +3858,7 @@ wv_pcmcia_config(dev_link_t *	link)
>        /* Feed device with this info... */
>        dev->irq = link->irq.AssignedIRQ;
>        dev->base_addr = link->io.BasePort1;
> -      netif_start_queue (dev);
> +      netif_start_queue(dev);
>  
>  #ifdef DEBUG_CONFIG_INFO
>        printk(KERN_DEBUG "wv_pcmcia_config: MEMSTART 0x%x IRQ %d IOPORT 0x%x\n",
> @@ -3843,7 +3884,7 @@ wv_pcmcia_config(dev_link_t *	link)
>        return FALSE;
>      }
>  
> -  /* XXX Could you explain me this, Dave ? */
> +  strcpy(((net_local *) dev->priv)->node.dev_name, dev->name);
>    link->dev = &((net_local *) dev->priv)->node;
>  
>  #ifdef DEBUG_CONFIG_TRACE
> @@ -3887,7 +3928,7 @@ wv_pcmcia_release(u_long	arg)	/* Address
>    CardServices(ReleaseIO, link->handle, &link->io);
>    CardServices(ReleaseIRQ, link->handle, &link->irq);
>  
> -  link->state &= ~(DEV_CONFIG | DEV_RELEASE_PENDING | DEV_STALE_CONFIG);
> +  link->state &= ~(DEV_CONFIG | DEV_STALE_CONFIG);
>  
>  #ifdef DEBUG_CONFIG_TRACE
>    printk(KERN_DEBUG "%s: <- wv_pcmcia_release()\n", dev->name);
> @@ -3896,7 +3937,7 @@ wv_pcmcia_release(u_long	arg)	/* Address
>  
>  /*------------------------------------------------------------------*/
>  /*
> - * Sometimes, netwave_detach can't be performed following a call from
> + * Sometimes, wavelan_detach can't be performed following a call from
>   * cardmgr (device still open, pcmcia_release not done) and the device
>   * is put in a STALE_LINK state and remains in memory.
>   *
> @@ -3970,7 +4011,19 @@ wavelan_interrupt(int		irq,
>    lp = (net_local *) dev->priv;
>    base = dev->base_addr;
>  
> -  spin_lock (&lp->lock);
> +#ifdef DEBUG_INTERRUPT_INFO
> +  /* Check state of our spinlock (it should be cleared) */
> +  if(spin_is_locked(&lp->spinlock))
> +    printk(KERN_DEBUG
> +	   "%s: wavelan_interrupt(): spinlock is already locked !!!\n",
> +	   dev->name);
> +#endif
> +
> +  /* Prevent reentrancy. We need to do that because we may have
> +   * multiple interrupt handler running concurently.
> +   * It is safe because wv_splhi() disable interrupts before aquiring
> +   * the spinlock. */
> +  spin_lock(&lp->spinlock);
>  
>    /* Treat all pending interrupts */
>    while(1)
> @@ -4015,8 +4068,6 @@ wavelan_interrupt(int		irq,
>  	  break;
>  	}
>  
> -      lp->status = status0;	/* Save current status (for commands) */
> -
>        /* ----------------- RECEIVING PACKET ----------------- */
>        /*
>         * When the wavelan signal the reception of a new packet,
> @@ -4054,22 +4105,6 @@ wavelan_interrupt(int		irq,
>         * Most likely : transmission done
>         */
>  
> -      /* If we are already waiting elsewhere for the command to complete */
> -      if(wv_wait_completed)
> -	{
> -#ifdef DEBUG_INTERRUPT_INFO
> -	  printk(KERN_DEBUG "%s: wv_interrupt(): command completed\n",
> -		 dev->name);
> -#endif
> -
> -	  /* Signal command completion */
> -	  wv_wait_completed = 0;
> -
> -	  /* Acknowledge the interrupt */
> -	  outb(CR0_INT_ACK | OP0_NOP, LCCR(base));
> -	  continue;
> -    	}
> -
>        /* If a transmission has been done */
>        if((status0 & SR0_EVENT_MASK) == SR0_TRANSMIT_DONE ||
>  	 (status0 & SR0_EVENT_MASK) == SR0_RETRANSMIT_DONE ||
> @@ -4081,10 +4116,6 @@ wavelan_interrupt(int		irq,
>  		   dev->name);
>  #endif
>  
> -	  /* If watchdog was activated, kill it ! */
> -	  if(timer_pending(&lp->watchdog))
> -	    del_timer(&lp->watchdog);
> -
>  	  /* Get transmission status */
>  	  tx_status = inb(LCSR(base));
>  	  tx_status |= (inb(LCSR(base)) << 8);
> @@ -4174,7 +4205,7 @@ wavelan_interrupt(int		irq,
>  	  lp->stats.collisions += (tx_status & TX_NCOL_MASK);
>  	  lp->stats.tx_packets++;
>  
> -	  netif_wake_queue (dev);
> +	  netif_wake_queue(dev);
>  	  outb(CR0_INT_ACK | OP0_NOP, LCCR(base));	/* Acknowledge the interrupt */
>      	} 
>        else	/* if interrupt = transmit done or retransmit done */
> @@ -4185,9 +4216,9 @@ wavelan_interrupt(int		irq,
>  #endif
>  	  outb(CR0_INT_ACK | OP0_NOP, LCCR(base));	/* Acknowledge the interrupt */
>      	}
> -    }
> +    }	/* while(1) */
>  
> -  spin_unlock_irq (&lp->lock);
> +  spin_unlock(&lp->spinlock);
>  
>  #ifdef DEBUG_INTERRUPT_TRACE
>    printk(KERN_DEBUG "%s: <-wavelan_interrupt()\n", dev->name);
> @@ -4196,30 +4227,23 @@ wavelan_interrupt(int		irq,
>  
>  /*------------------------------------------------------------------*/
>  /*
> - * Watchdog : when we start a transmission, we set a timer in the
> - * kernel.  If the transmission complete, this timer is disabled. If
> - * it expire, it try to unlock the hardware.
> + * Watchdog: when we start a transmission, a timer is set for us in the
> + * kernel.  If the transmission completes, this timer is disabled. If
> + * the timer expires, we are called and we try to unlock the hardware.
>   *
> - * Note : this watchdog doesn't work on the same principle as the
> - * watchdog in the ISA driver. I make it this way because the overhead
> - * of add_timer() and del_timer() is nothing and that it avoid calling
> - * the watchdog, saving some CPU... If you want to apply the same
> - * watchdog to the ISA driver, you should be a bit carefull, because
> - * of the many transmit buffers...
> - * This watchdog is also move clever, it try to abort the current
> - * command before reseting everything...
> + * Note : This watchdog is move clever than the one in the ISA driver,
> + * because it try to abort the current command before reseting
> + * everything...
> + * On the other hand, it's a bit simpler, because we don't have to
> + * deal with the multiple Tx buffers...
>   */
>  static void
> -wavelan_watchdog(u_long		a)
> +wavelan_watchdog(device *	dev)
>  {
> -  device *		dev;
> -  net_local *		lp;
> -  ioaddr_t		base;
> -  int			spin;
> -
> -  dev = (device *) a;
> -  base = dev->base_addr;
> -  lp = (net_local *) dev->priv;
> +  net_local *		lp = (net_local *) dev->priv;
> +  ioaddr_t		base = dev->base_addr;
> +  unsigned long		flags;
> +  int			aborted = FALSE;
>  
>  #ifdef DEBUG_INTERRUPT_TRACE
>    printk(KERN_DEBUG "%s: ->wavelan_watchdog()\n", dev->name);
> @@ -4230,21 +4254,21 @@ wavelan_watchdog(u_long		a)
>  	 dev->name);
>  #endif
>  
> -  /* We are waiting for command completion */
> -  wv_wait_completed = TRUE;
> +  wv_splhi(lp, &flags);
>  
>    /* Ask to abort the current command */
>    outb(OP0_ABORT, LCCR(base));
>  
> -  /* Busy wait while the LAN controller executes the command.
> -   * Note : wv_wait_completed should be volatile */
> -  spin = 0;
> -  while(wv_wait_completed && (spin++ < 250))
> -    udelay(10);
> -
> -  /* If the interrupt handler hasn't be called or invalid status */
> -  if((wv_wait_completed) ||
> -     ((lp->status & SR0_EVENT_MASK) != SR0_EXECUTION_ABORTED))
> +  /* Wait for the end of the command (a bit hackish) */
> +  if(wv_82593_cmd(dev, "wavelan_watchdog(): abort",
> +		  OP0_NOP | CR0_STATUS_3, SR0_EXECUTION_ABORTED))
> +    aborted = TRUE;
> +
> +  /* Release spinlock here so that wv_hw_reset() can grab it */
> +  wv_splx(lp, &flags);
> +
> +  /* Check if we were successful in aborting it */
> +  if(!aborted)
>      {
>        /* It seem that it wasn't enough */
>  #ifdef DEBUG_INTERRUPT_ERROR
> @@ -4269,7 +4293,7 @@ wavelan_watchdog(u_long		a)
>  #endif
>  
>    /* We are no more waiting for something... */
> -  netif_start_queue (dev);
> +  netif_wake_queue(dev);
>  
>  #ifdef DEBUG_INTERRUPT_TRACE
>    printk(KERN_DEBUG "%s: <-wavelan_watchdog()\n", dev->name);
> @@ -4322,7 +4346,7 @@ wavelan_open(device *	dev)
>      return FALSE;
>    if(!wv_ru_start(dev))
>      wv_hw_reset(dev);		/* If problem : reset */
> -  netif_start_queue (dev);
> +  netif_start_queue(dev);
>  
>    /* Mark the device as used */
>    link->open++;
> @@ -4348,7 +4372,6 @@ static int
>  wavelan_close(device *	dev)
>  {
>    dev_link_t *	link = ((net_local *) dev->priv)->link;
> -  net_local *	lp = (net_local *)dev->priv;
>    ioaddr_t	base = dev->base_addr;
>  
>  #ifdef DEBUG_CALLBACK_TRACE
> @@ -4356,8 +4379,6 @@ wavelan_close(device *	dev)
>  	 (unsigned int) dev);
>  #endif
>  
> -  netif_stop_queue (dev);
> -
>    /* If the device isn't open, then nothing to do */
>    if(!link->open)
>      {
> @@ -4373,17 +4394,13 @@ wavelan_close(device *	dev)
>      wv_roam_cleanup(dev);
>  #endif	/* WAVELAN_ROAMING */
>  
> -  /* If watchdog was activated, kill it ! */
> -  if(timer_pending(&lp->watchdog))
> -    del_timer(&lp->watchdog);
> -
>    link->open--;
>    MOD_DEC_USE_COUNT;
>  
>    /* If the card is still present */
> -  if (netif_device_present(dev))
> +  if(netif_running(dev))
>      {
> -      netif_stop_queue (dev);
> +      netif_stop_queue(dev);
>  
>        /* Stop receiving new messages and wait end of transmission */
>        wv_ru_stop(dev);
> @@ -4404,21 +4421,6 @@ wavelan_close(device *	dev)
>  
>  /*------------------------------------------------------------------*/
>  /*
> - * We never need to do anything when a wavelan device is "initialized"
> - * by the net software, because we only register already-found cards.
> - */
> -static int
> -wavelan_init(device *	dev)
> -{
> -#ifdef DEBUG_CALLBACK_TRACE
> -  printk(KERN_DEBUG "<>wavelan_init()\n");
> -#endif
> -
> -  return(0);
> -}
> -
> -/*------------------------------------------------------------------*/
> -/*
>   * wavelan_attach() creates an "instance" of the driver, allocating
>   * local data structures for one device (one interface).  The device
>   * is registered with Card Services.
> @@ -4445,24 +4447,8 @@ wavelan_attach(void)
>  
>    /* Initialize the dev_link_t structure */
>    link = kmalloc(sizeof(struct dev_link_t), GFP_KERNEL);
> -  if (!link)
> -	  return NULL;
> -  
> -  /* Allocate the generic data structure */
> -  dev = kmalloc(sizeof(struct net_device), GFP_KERNEL);
> -  if (!dev)
> -	  goto fail_alloc_dev;
> -  
> -  /* Allocate the wavelan-specific data structure. */
> -  lp = (net_local *) kmalloc(sizeof(net_local), GFP_KERNEL);
> -  if (!lp)
> -	  goto fail_alloc_dev_priv;
> -  
> -  memset(lp, 0, sizeof(net_local));
> +  if (!link) return NULL;
>    memset(link, 0, sizeof(struct dev_link_t));
> -  memset(dev, 0, sizeof(struct net_device));
> -
> -  dev->priv = lp;
>  
>    /* Unused for the Wavelan */
>    link->release.function = &wv_pcmcia_release;
> @@ -4492,18 +4478,35 @@ wavelan_attach(void)
>    link->next = dev_list;
>    dev_list = link;
>  
> +  /* Allocate the generic data structure */
> +  dev = kmalloc(sizeof(struct net_device), GFP_KERNEL);
> +  if (!dev) {
> +      kfree(link);
> +      return NULL;
> +  }
> +  memset(dev, 0x00, sizeof(struct net_device));
>    link->priv = link->irq.Instance = dev;
>  
> +  /* Allocate the wavelan-specific data structure. */
> +  dev->priv = lp = (net_local *) kmalloc(sizeof(net_local), GFP_KERNEL);
> +  if (!lp) {
> +      kfree(link);
> +      kfree(dev);
> +      return NULL;
> +  }
> +  memset(lp, 0x00, sizeof(net_local));
> +
>    /* Init specific data */
> -  wv_wait_completed = 0;
> -  lp->status = FALSE;
>    lp->configured = 0;
>    lp->reconfig_82593 = FALSE;
>    lp->nresets = 0;
> +  /* Multicast stuff */
> +  lp->promiscuous = 0;
> +  lp->allmulticast = 0;
> +  lp->mc_count = 0;
>  
> -  /* Set the watchdog timer */
> -  lp->watchdog.function = wavelan_watchdog;
> -  lp->watchdog.data = (unsigned long) dev;
> +  /* Init spinlock */
> +  spin_lock_init(&lp->spinlock);
>  
>    /* back links */
>    lp->link = link;
> @@ -4513,7 +4516,6 @@ wavelan_attach(void)
>    ether_setup(dev);
>  
>    /* wavelan NET3 callbacks */
> -  dev->init = &wavelan_init;
>    dev->open = &wavelan_open;
>    dev->stop = &wavelan_close;
>    dev->hard_start_xmit = &wavelan_packet_xmit;
> @@ -4523,14 +4525,16 @@ wavelan_attach(void)
>    dev->set_mac_address = &wavelan_set_mac_address;
>  #endif	/* SET_MAC_ADDRESS */
>  
> +  /* Set the watchdog timer */
> +  dev->tx_timeout	= &wavelan_watchdog;
> +  dev->watchdog_timeo	= WATCHDOG_JIFFIES;
> +
>  #ifdef WIRELESS_EXT	/* If wireless extension exist in the kernel */
>    dev->do_ioctl = wavelan_ioctl;	/* wireless extensions */
>    dev->get_wireless_stats = wavelan_get_wireless_stats;
>  #endif
>  
>    /* Other specific data */
> -  strcpy(dev->name, ((net_local *)dev->priv)->node.dev_name);
> -  netif_start_queue (dev);
>    dev->mtu = WAVELAN_MTU;
>  
>    /* Register with Card Services */
> @@ -4562,12 +4566,6 @@ wavelan_attach(void)
>  #endif
>  
>    return link;
> -
> -fail_alloc_dev_priv:
> -  kfree(dev);
> -fail_alloc_dev:
> -  kfree(link);
> -  return NULL;
>  }
>  
>  /*------------------------------------------------------------------*/
> @@ -4698,7 +4696,7 @@ wavelan_event(event_t		event,		/* The ev
>  	if(link->state & DEV_CONFIG)
>  	  {
>  	    /* Accept no more transmissions */
> -      	    netif_device_detach(dev);
> +	    netif_device_detach(dev);
>  
>  	    /* Release the card */
>  	    wv_pcmcia_release((u_long) link);
> @@ -4720,7 +4718,7 @@ wavelan_event(event_t		event,		/* The ev
>  	 * obliged to close nicely the wavelan here. David, could you
>  	 * close the device before suspending them ? And, by the way,
>  	 * could you, on resume, add a "route add -net ..." after the
> -	 * ifconfig up XXX Thanks... */
> +	 * ifconfig up ??? Thanks... */
>  
>  	/* Stop receiving new messages and wait end of transmission */
>  	wv_ru_stop(dev);
> @@ -4735,8 +4733,7 @@ wavelan_event(event_t		event,		/* The ev
>      	if(link->state & DEV_CONFIG)
>  	  {
>        	    if(link->open)
> -	      	netif_device_detach(dev);
> -
> +	      netif_device_detach(dev);
>        	    CardServices(ReleaseConfiguration, link->handle);
>  	  }
>  	break;
> @@ -4748,7 +4745,7 @@ wavelan_event(event_t		event,		/* The ev
>  	if(link->state & DEV_CONFIG)
>  	  {
>        	    CardServices(RequestConfiguration, link->handle, &link->conf);
> -      	    if(link->open)	/* If RESET -> True, If RESUME -> False XXX */
> +      	    if(link->open)	/* If RESET -> True, If RESUME -> False ??? */
>  	      {
>  		wv_hw_reset(dev);
>  		netif_device_attach(dev);
> @@ -4838,4 +4835,3 @@ exit_wavelan_cs(void)
>  
>  module_init(init_wavelan_cs);
>  module_exit(exit_wavelan_cs);
> -MODULE_LICENSE("Dual BSD/GPL");
> diff -u -p -r linux/drivers/net/pcmcia-buggy/wavelan_cs.h linux/drivers/net/pcmcia/wavelan_cs.h
> --- linux/drivers/net/pcmcia-buggy/wavelan_cs.h	Tue Jan  8 17:27:48 2002
> +++ linux/drivers/net/pcmcia/wavelan_cs.h	Fri Jan 11 14:58:25 2002
> @@ -34,6 +34,25 @@
>   *	I try to maintain a web page with the Wireless LAN Howto at :
>   *	    http://www.hpl.hp.com/personal/Jean_Tourrilhes/Linux/Wavelan.html
>   *
> + * SMP
> + * ---
> + *	We now are SMP compliant (I eventually fixed the remaining bugs).
> + *	The driver has been tested on a dual P6-150 and survived my usual
> + *	set of torture tests.
> + *	Anyway, I spent enough time chasing interrupt re-entrancy during
> + *	errors or reconfigure, and I designed the locked/unlocked sections
> + *	of the driver with great care, and with the recent addition of
> + *	the spinlock (thanks to the new API), we should be quite close to
> + *	the truth.
> + *	The SMP/IRQ locking is quite coarse and conservative (i.e. not fast),
> + *	but better safe than sorry (especially at 2 Mb/s ;-).
> + *
> + *	I have also looked into disabling only our interrupt on the card
> + *	(via HACR) instead of all interrupts in the processor (via cli),
> + *	so that other driver are not impacted, and it look like it's
> + *	possible, but it's very tricky to do right (full of races). As
> + *	the gain would be mostly for SMP systems, it can wait...
> + *
>   * Debugging and options
>   * ---------------------
>   *	You will find below a set of '#define" allowing a very fine control
> @@ -122,7 +141,7 @@
>   * Yunzhou Li <yunzhou@strat.iol.unh.edu> finished is work.
>   * Joe Finney <joe@comp.lancs.ac.uk> patched the driver to start
>   * correctly 2.00 cards (2.4 GHz with frequency selection).
> - * David Hinds <dhinds@pcmcia.sourceforge.org> integrated the whole in his
> + * David Hinds <dahinds@users.sourceforge.net> integrated the whole in his
>   * Pcmcia package (+ bug corrections).
>   *
>   * I (Jean Tourrilhes - jt@hplb.hpl.hp.com) then started to make some
> @@ -158,8 +177,8 @@
>   *
>   *    This software was originally developed under Linux 1.2.3
>   *	(Slackware 2.0 distribution).
> - *    And then under Linux 2.0.x (Debian 1.1 - pcmcia 2.8.18-23) with
> - *	HP OmniBook 4000 & 5500.
> + *    And then under Linux 2.0.x (Debian 1.1 -> 2.2 - pcmcia 2.8.18+)
> + *	with an HP OmniBook 4000 and then a 5500.
>   *
>   *    It is based on other device drivers and information either written
>   *    or supplied by:
> @@ -174,7 +193,7 @@
>   *	Matthew Geier (matthew@cs.su.oz.au),
>   *	Remo di Giovanni (remo@cs.su.oz.au),
>   *	Mark Hagan (mhagan@wtcpost.daytonoh.NCR.COM),
> - *	David Hinds <dhinds@pcmcia.sourceforge.org>,
> + *	David Hinds <dahinds@users.sourceforge.net>,
>   *	Jan Hoogendoorn (c/o marteijn@lucent.com),
>   *      Bruce Janson <bruce@cs.usyd.edu.au>,
>   *	Anthony D. Joseph <adj@lcs.mit.edu>,
> @@ -349,6 +368,32 @@
>   *	- Fix check for root permission (break instead of exit)
>   *	- New nwid & encoding setting (Wireless Extension 9)
>   *
> + * Changes made for release in 3.1.12 :
> + * ----------------------------------
> + *	- reworked wv_82593_cmd to avoid using the IRQ handler and doing
> + *	  ugly things with interrupts.
> + *	- Add IRQ protection in 82593_config/ru_start/ru_stop/watchdog
> + *	- Update to new network API (softnet - 2.3.43) :
> + *		o replace dev->tbusy (David + me)
> + *		o replace dev->tstart (David + me)
> + *		o remove dev->interrupt (David)
> + *		o add SMP locking via spinlock in splxx (me)
> + *		o add spinlock in interrupt handler (me)
> + *		o use kernel watchdog instead of ours (me)
> + *		o verify that all the changes make sense and work (me)
> + *	- Re-sync kernel/pcmcia versions (not much actually)
> + *	- A few other cleanups (David & me)...
> + *
> + * Changes made for release in 3.1.22 :
> + * ----------------------------------
> + *	- Check that SMP works, remove annoying log message
> + *
> + * Changes made for release in 3.1.24 :
> + * ----------------------------------
> + *	- Fix unfrequent card lockup when watchdog was reseting the hardware :
> + *		o control first busy loop in wv_82593_cmd()
> + *		o Extend spinlock protection in wv_hw_config()
> + *
>   * Wishes & dreams:
>   * ----------------
>   *	- Cleanup and integrate the roaming code
> @@ -368,6 +413,7 @@
>  #include <linux/string.h>
>  #include <linux/timer.h>
>  #include <linux/interrupt.h>
> +#include <linux/spinlock.h>
>  #include <linux/in.h>
>  #include <linux/delay.h>
>  #include <asm/uaccess.h>
> @@ -384,7 +430,7 @@
>  
>  #ifdef CONFIG_NET_PCMCIA_RADIO
>  #include <linux/wireless.h>		/* Wireless extensions */
> -#endif	/* CONFIG_NET_PCMCIA_RADIO */
> +#endif
>  
>  /* Pcmcia headers that we need */
>  #include <pcmcia/cs_types.h>
> @@ -437,7 +483,7 @@
>  #undef DEBUG_RX_INFO		/* Header of the transmitted packet */
>  #undef DEBUG_RX_FAIL		/* Normal failure conditions */
>  #define DEBUG_RX_ERROR		/* Unexpected conditions */
> -#undef DEBUG_PACKET_DUMP	/* Dump packet on the screen */
> +#undef DEBUG_PACKET_DUMP	32	/* Dump packet on the screen */
>  #undef DEBUG_IOCTL_TRACE	/* Misc call by Linux */
>  #undef DEBUG_IOCTL_INFO		/* Various debug info */
>  #define DEBUG_IOCTL_ERROR	/* What's going wrong */
> @@ -452,7 +498,7 @@
>  /************************ CONSTANTS & MACROS ************************/
>  
>  #ifdef DEBUG_VERSION_SHOW
> -static const char *version = "wavelan_cs.c : v21 (wireless extensions) 18/10/99\n";
> +static const char *version = "wavelan_cs.c : v23 (SMP + wireless extensions) 20/12/00\n";
>  #endif
>  
>  /* Watchdog temporisation */
> @@ -557,9 +603,9 @@ typedef u_char		mac_addr[WAVELAN_ADDR_SI
>   */
>  struct net_local
>  {
> -  spinlock_t	lock;
>    dev_node_t 	node;		/* ???? What is this stuff ???? */
>    device *	dev;		/* Reverse link... */
> +  spinlock_t	spinlock;	/* Serialize access to the hardware (SMP) */
>    dev_link_t *	link;		/* pcmcia structure */
>    en_stats	stats;		/* Ethernet interface statistics */
>    int		nresets;	/* Number of hw resets */
> @@ -568,9 +614,7 @@ struct net_local
>    u_char	promiscuous;	/* Promiscuous mode */
>    u_char	allmulticast;	/* All Multicast mode */
>    int		mc_count;	/* Number of multicast addresses */
> -  timer_list	watchdog;	/* To avoid blocking state */
>  
> -  u_char        status;		/* Current i82593 status */
>    int   	stop;		/* Current i82593 Stop Hit Register */
>    int   	rfp;		/* Last DMA machine receive pointer */
>    int		overrunning;	/* Receiver overrun flag */
> @@ -617,8 +661,14 @@ void wv_roam_cleanup(struct net_device *
>  #endif	/* WAVELAN_ROAMING */
>  
>  /* ----------------------- MISC SUBROUTINES ------------------------ */
> +static inline void
> +	wv_splhi(net_local *,		/* Disable interrupts */
> +		 unsigned long *);	/* flags */
> +static inline void
> +	wv_splx(net_local *,		/* ReEnable interrupts */
> +		unsigned long *);	/* flags */
>  static void
> -	cs_error(client_handle_t, /* Report error to cardmgr */
> +	cs_error(client_handle_t,	/* Report error to cardmgr */
>  		 int,
>  		 int);
>  /* ----------------- MODEM MANAGEMENT SUBROUTINES ----------------- */
> @@ -722,16 +772,15 @@ static void
>  	wv_flush_stale_links(void);	/* "detach" all possible devices */
>  /* ---------------------- INTERRUPT HANDLING ---------------------- */
>  static void
> -wavelan_interrupt(int,	/* Interrupt handler */
> -		  void *,
> -		  struct pt_regs *);
> +	wavelan_interrupt(int,	/* Interrupt handler */
> +			  void *,
> +			  struct pt_regs *);
>  static void
> -	wavelan_watchdog(u_long);	/* Transmission watchdog */
> +	wavelan_watchdog(device *);	/* Transmission watchdog */
>  /* ------------------- CONFIGURATION CALLBACKS ------------------- */
>  static int
>  	wavelan_open(device *),		/* Open the device */
> -	wavelan_close(device *),	/* Close the device */
> -	wavelan_init(device *);		/* Do nothing */
> +	wavelan_close(device *);	/* Close the device */
>  static dev_link_t *
>  	wavelan_attach(void);		/* Create a new device */
>  static void
> @@ -744,11 +793,7 @@ static int
>  /**************************** VARIABLES ****************************/
>  
>  static dev_info_t dev_info = "wavelan_cs";
> -static dev_link_t *dev_list;		/* Linked list of devices */
> -
> -/* WARNING : the following variable MUST be volatile
> - * It is used by wv_82593_cmd to syncronise with wavelan_interrupt */ 
> -static volatile int	wv_wait_completed;
> +static dev_link_t *dev_list = NULL;	/* Linked list of devices */
>  
>  /*
>   * Parameters that can be set with 'insmod'
> @@ -761,7 +806,7 @@ static int	irq_mask = 0xdeb8;
>  static int 	irq_list[4] = { -1 };
>  
>  /* Shared memory speed, in ns */
> -static int	mem_speed;
> +static int	mem_speed = 0;
>  
>  /* New module interface */
>  MODULE_PARM(irq_mask, "i");
> @@ -770,9 +815,11 @@ MODULE_PARM(mem_speed, "i");
>  
>  #ifdef WAVELAN_ROAMING		/* Conditional compile, see above in options */
>  /* Enable roaming mode ? No ! Please keep this to 0 */
> -static int	do_roaming;
> +static int	do_roaming = 0;
>  MODULE_PARM(do_roaming, "i");
>  #endif	/* WAVELAN_ROAMING */
> +
> +MODULE_LICENSE("GPL");
>  
>  #endif	/* WAVELAN_CS_H */
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
-------------------------------------------------------------------------- 
Joel Jaeggli	      Academic User Services   joelja@darkwing.uoregon.edu    
--    PGP Key Fingerprint: 1DE9 8FCA 51FB 4195 B42A 9C32 A30D 121E      --
The accumulation of all powers, legislative, executive, and judiciary, in 
the same hands, whether of one, a few, or many, and whether hereditary, 
selfappointed, or elective, may justly be pronounced the very definition of
tyranny. - James Madison, Federalist Papers 47 -  Feb 1, 1788


