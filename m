Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131557AbRCQGTa>; Sat, 17 Mar 2001 01:19:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131630AbRCQGTY>; Sat, 17 Mar 2001 01:19:24 -0500
Received: from elaine24.Stanford.EDU ([171.64.15.99]:30891 "EHLO
	elaine24.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S131557AbRCQGTJ>; Sat, 17 Mar 2001 01:19:09 -0500
Date: Fri, 16 Mar 2001 22:18:22 -0800 (PST)
From: Junfeng Yang <yjf@stanford.edu>
To: <linux-kernel@vger.kernel.org>
cc: <mc@cs.stanford.edu>
Subject: [CHECKER] 28 potential interrupt errors
Message-ID: <Pine.GSO.4.31.0103162216360.10409-100000@elaine24.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here are yet more results from the MC project.  This checker looks for
inconsistent usage of interrupt functions.  For example, it notices when
interrupts can be either on or off when a function exits.  It tracks
cli(), sti(), save_flags() and so forth.  We've hand-inspected the results
to ensure that the ones you see here are likely to be errors.

As usual, please CC us at mc@cs.stanford.edu if you can verify these
potential errors or show that these bugs are false positives.

Important: The code snippets with each bug here were automatically culled
from the source, not manually selected, so they are sometimes inaccurate
as to the actual location of the bug.  We've included a comment before
each bug to help in understanding what the checker found, but the only way
to know for sure is to inspect the source.

-Junfeng & Andy


Where the errors are:

+------------------------------------------+----------------------------+
| file                                     | fn                         |
+------------------------------------------+----------------------------+
| drivers/cdrom/cm206.c                    | receive_byte               |
| drivers/cdrom/cm206.c                    | send_command               |
| drivers/char/ip2/i2lib.c                 | i2QueueCommands            |
| drivers/char/n_r3964.c                   | add_msg                    |
| drivers/char/rio/rioroute.c              | RIOFixPhbs                 |
| drivers/char/rio/riotable.c              | RIODeleteRta               |
| drivers/i2o/i2o_block.c                  | i2ob_del_device            |
| drivers/ide/ide.c                        | ide_spin_wait_hwgroup      |
| drivers/isdn/hisax/config.c              | checkcard                  |
| drivers/isdn/hisax/isar.c                | isar_load_firmware         |
| drivers/isdn/isdn_ppp.c                  | isdn_ppp_bind              |
| drivers/net/appletalk/cops.c             | cops_rx                    |
| drivers/net/hamradio/soundmodem/sm_wss.c | wss_set_codec_fmt          |
| drivers/net/irda/irport.c                | irport_net_ioctl           |
| drivers/net/irda/irtty.c                 | irtty_net_ioctl            |
| drivers/net/irda/nsc-ircc.c              | nsc_ircc_net_ioctl         |
| drivers/net/irda/toshoboe.c              | toshoboe_net_ioctl         |
| drivers/net/irda/w83977af_ir.c           | w83977af_net_ioctl         |
| drivers/net/pcmcia/wavelan_cs.c          | wavelan_get_wireless_stats |
| drivers/net/tokenring/smctr.c            | smctr_open_tr              |
| drivers/net/wan/comx-hw-mixcom.c         | MIXCOM_open                |
| drivers/net/wan/lmc/lmc_main.c           | lmc_watchdog               |
| drivers/scsi/eata_dma.c                  | eata_queue                 |
| drivers/scsi/qla1280.c                   | qla1280_intr_handler       |
| drivers/sound/ad1848.c                   | ad1848_resume              |
| drivers/sound/emu10k1/midi.c             | emu10k1_midi_callback      |
| drivers/sound/sscape.c                   | sscape_pnp_upload_file     |
| net/irda/irttp.c                         | irttp_proc_read            |
+------------------------------------------+----------------------------+

Listing:

[BUG] sleep_or_timeout will call interruptible_sleep_on, which will save disabled flags and then restore them.

/u2/acc/oses/linux/2.4.1/drivers/cdrom/cm206.c:474:send_command: ERROR:INTR:462:474: Interrupts inconsistent, severity `20':474

  if (!(inw(r_line_status) & ls_transmitter_buffer_empty)) {
    cd->command = command;
Start --->
    cli();			/* don't interrupt before sleep */
    outw(dc_mask_sync_error | dc_no_stop_on_error |
	 (inw(r_data_status) & 0x7f), r_data_control);
    /* interrupt routine sends command */

Save & Restore
flags here --->
    if (sleep_or_timeout(&cd->uart, UART_TIMEOUT)) {
      debug(("Time out on write-buffer\n"));
      stats(write_timeout);

	... DELETED 2 lines ...

    }
    debug(("Write commmand delayed\n"));
  }
  else outw(command, r_uart_transmit);
Error --->
}

uch receive_byte(int timeout)
{
  uch ret;
---------------------------------------------------------
[BUG] sleep_or_timeout will call interruptible_sleep_on, which will save disabled flags and then restore them.

/u2/acc/oses/linux/2.4.1/drivers/cdrom/cm206.c:499:receive_byte: ERROR:INTR:479:494: Interrupts inconsistent, severity `30':494

{
  uch ret;
Start --->
  cli();
  debug(("cli\n"));
  ret = cd->ur[cd->ur_r];
  if (cd->ur_r != cd->ur_w) {
    sti();
    debug(("returning #%d: 0x%x\n", cd->ur_r, cd->ur[cd->ur_r]));
    cd->ur_r++; cd->ur_r %= UR_SIZE;

	... DELETED 5 lines ...

#ifdef STATISTICS
    if (timeout==UART_TIMEOUT) stats(receive_timeout) /* no `;'! */
    else stats(dsb_timeout);
#endif
Error --->
    return 0xda;
  }
  ret = cd->ur[cd->ur_r];
  debug(("slept; returning #%d: 0x%x\n", cd->ur_r, cd->ur[cd->ur_r]));
  cd->ur_r++; cd->ur_r %= UR_SIZE;
---------------------------------------------------------
[BUG] If type != PTYPE_INLINE && type != PTYPE_BYPASS, function will exit with interrupt disabled. need to verify

/u2/acc/oses/linux/2.4.1/drivers/char/ip2/i2lib.c:571:i2QueueCommands: ERROR:INTR:602:753: Interrupts inconsistent, severity `20':753

			case PTYPE_INLINE:
				lock_var_p = &pCh->Obuf_spinlock;
Start --->
				WRITE_LOCK_IRQSAVE(lock_var_p,flags);
				stuffIndex = pCh->Obuf_stuff;
				bufroom = pCh->Obuf_strip - stuffIndex;
				break;
			case PTYPE_BYPASS:
				lock_var_p = &pCh->Cbuf_spinlock;
				WRITE_LOCK_IRQSAVE(lock_var_p,flags);

	... DELETED 141 lines ...
			// Check for overflow
			if (totalsize <= bufroom) {
				// Normal Expected path - We still hold LOCK

				break; /* from for()- Enough room: goto proceed */
			}

	......

	}
#ifdef IP2DEBUG_TRACE
	ip2trace (CHANN, ITRC_QUEUE, ITRC_RETURN, 1, nCommands );
#endif
Error --->
	return nCommands; // Good status: number of commands sent
}

//******************************************************************************
// Function:   i2GetStatus(pCh,resetBits)
---------------------------------------------------------
[BUG] return with int disabled in an error path

/u2/acc/oses/linux/2.4.1/drivers/char/n_r3964.c:1036:add_msg: ERROR:INTR:990:995: Interrupts inconsistent, severity `20':995


      save_flags(flags);
Start --->
      cli();

      pMsg = kmalloc(sizeof(struct r3964_message), GFP_KERNEL);
      TRACE_M("add_msg - kmalloc %x",(int)pMsg);
Return without
enabling interrupt
      --->
      if(pMsg==NULL)
         return;


	... DELETED 44 lines ...

   if(pClient->sig_flags & R3964_USE_SIGIO)
   {
      kill_proc(pClient->pid, SIGIO, 1);
   }
Error --->
}

static struct r3964_message *remove_msg(struct r3964_info *pInfo,
                       struct r3964_client_info *pClient)
{
---------------------------------------------------------
[BUG] doesn't enable interrupt in error path

/u2/acc/oses/linux/2.4.1/drivers/char/rio/rioroute.c:713:RIOFixPhbs: ERROR:INTR:653:707: Interrupts inconsistent, severity `20':707

			PortP = p->RIOPortp[PortN];

Start --->
			rio_spin_lock_irqsave(&PortP->portSem, flags);
			/*
			** If RTA is not powered on, the tx packets will be
			** unset, so go no further.
			*/
			if (PortP->TxStart == 0) {
					rio_dprintk (RIO_DEBUG_ROUTE, "Tx pkts not set up yet\n");

	... DELETED 44 lines ...

		/*
		** Now make sure the range of ports to be serviced includes
		** the 2nd 8 on this 16 port RTA.
		*/
Error --->
		if (link > 3) return;
		if (((unit * 8) + 7) > RWORD(HostP->LinkStrP[link].last_port)) {
			rio_dprintk (RIO_DEBUG_ROUTE, "last port on host link %d: %d\n", link, (unit * 8) + 7);
			WWORD(HostP->LinkStrP[link].last_port, (unit * 8) + 7);
		}
---------------------------------------------------------
[BUG] Reuse the same flags variable

/u2/acc/oses/linux/2.4.1/drivers/char/rio/riotable.c:630:RIODeleteRta: ERROR:INTR:510:626: Interrupts inconsistent, severity `20':626

		HostP = &p->RIOHosts[host];

Start --->
		rio_spin_lock_irqsave( &HostP->HostLock, flags );

		if ( (HostP->Flags & RUN_STATE) != RC_RUNNING ) {
use flags
here  --->
			rio_spin_unlock_irqrestore(&HostP->HostLock, flags);
			continue;
		}

		for ( entry=0; entry<MAX_RUP; entry++ ) {
			if ( MapP->RtaUniqueNum == HostP->Mapping[entry].RtaUniqueNum ) {
				HostMapP = &HostP->Mapping[entry];
				rio_dprintk (RIO_DEBUG_TABLE, "Found entry offset %d on host %s\n",
						entry, HostP->Name);

				/*
				** Check all four links of the unit are disconnected
				*/
				for ( link=0; link< LINKS_PER_UNIT; link++ ) {
					if ( HostMapP->Topology[link].Unit != ROUTE_DISCONNECT ) {
						rio_dprintk (RIO_DEBUG_TABLE, "Entry is in use and cannot be deleted!\n");
						p->RIOError.Error = UNIT_IS_IN_USE;
						rio_spin_unlock_irqrestore( &HostP->HostLock, flags);
						return EBUSY;
					}
				}
				/*
				** Slot has been allocated, BUT not booted/routed/
				** connected/selected or anything else-ed
				*/
				SysPort = HostMapP->SysPort;

				if ( SysPort != NO_PORT ) {
					for (port=SysPort; port < SysPort+PORTS_PER_RTA; port++) {
						PortP = p->RIOPortp[port];
						rio_dprintk (RIO_DEBUG_TABLE, "Unmap port\n");

reuse flags
here  --->
						rio_spin_lock_irqsave( &PortP->portSem, flags );


	... DELETED 106 lines ...

			work_done++;
		}
	}
	if ( work_done )
Error --->
		return 0;

	rio_dprintk (RIO_DEBUG_TABLE, "Couldn't find entry to be deleted\n");
	p->RIOError.Error = COULDNT_FIND_ENTRY;
	return ENXIO;
---------------------------------------------------------
[BUG] forget to restore flag in error path

/u2/acc/oses/linux/2.4.1/drivers/i2o/i2o_block.c:1426:i2ob_del_device: ERROR:INTR:1416:1496: Interrupts inconsistent, severity `20':1496

	int flags;

Start --->
	spin_lock_irqsave(&io_request_lock, flags);

	/*
	 * Need to do this...we somtimes get two events from the IRTOS
	 * in a row and that causes lots of problems.
	 */
	i2o_device_notify_off(d, &i2o_block_handler);

	... DELETED 70 lines ...

	i2ob_media_change_flag[unit] = 1;

	i2ob_dev_count--;

Error --->
	return;
}

/*
 *	Have we seen a media change ?
---------------------------------------------------------
[BUG] need verify. If hwgroup->busy is not true, the io_request_lock will remain locked

/u2/acc/oses/linux/2.4.1/drivers/ide/ide.c:2335:ide_spin_wait_hwgroup: ERROR:INTR:2320:2335: Interrupts inconsistent, severity `30':2335

	unsigned long timeout = jiffies + (3 * HZ);

Start --->
	spin_lock_irq(&io_request_lock);

	while (hwgroup->busy) {
		unsigned long lflags;
		spin_unlock_irq(&io_request_lock);
		__save_flags(lflags);	/* local CPU only */
		__sti();		/* local CPU only; needed for jiffies */

	... DELETED 5 lines ...

		}
		__restore_flags(lflags);	/* local CPU only */
		spin_lock_irq(&io_request_lock);
	}
Error --->
	return 0;
}

/*
 * FIXME:  This should be changed to enqueue a special request
---------------------------------------------------------
[BUG] error path. At line 1194, function exits without enabling intr.

/u2/acc/oses/linux/2.4.1/drivers/isdn/hisax/config.c:926:checkcard: ERROR:INTR:917:1177: Interrupts inconsistent, severity `20':1177


	save_flags(flags);
Start --->
	cli();
	if (!(cs = (struct IsdnCardState *)
		kmalloc(sizeof(struct IsdnCardState), GFP_ATOMIC))) {
		printk(KERN_WARNING
		       "HiSax: No memory for IsdnCardState(card %d)\n",
		       cardnr + 1);
		restore_flags(flags);

	... DELETED 250 lines ...

	}
	if (!(cs->rcvbuf = kmalloc(MAX_DFRAME_LEN_L1, GFP_ATOMIC))) {
		printk(KERN_WARNING
		       "HiSax: No memory for isac rcvbuf\n");
Error --->
		return (1);
	}
	cs->rcvidx = 0;
	cs->tx_skb = NULL;
	cs->tx_cnt = 0;
---------------------------------------------------------
[BUG] need verify. In some error paths, they restore flags, but in others, they don't. gotos?

/u2/acc/oses/linux/2.4.1/drivers/isdn/hisax/isar.c:220:isar_load_firmware: ERROR:INTR:348:424: Interrupts inconsistent, severity `10':424

	cs->BC_Write_Reg(cs, 0, ISAR_IRQBIT, ISAR_IRQSTA);
	save_flags(flags);
Start --->
	sti();
	cnt = 1000; /* max 1s */
	while ((!ireg->bstat) && cnt) {
		udelay(1000);
		cnt--;
	}
	if (!cnt) {

	... DELETED 66 lines ...

		/* disable ISAR IRQ */
		cs->BC_Write_Reg(cs, 0, ISAR_IRQBIT, 0);
	kfree(msg);
	kfree(tmpmsg);
Error --->
	return(ret);
}

extern void BChannel_bh(struct BCState *);
#define B_LL_NOCARRIER	8
---------------------------------------------------------
[BUG] error path

/u2/acc/oses/linux/2.4.1/drivers/isdn/isdn_ppp.c:190:isdn_ppp_bind: ERROR:INTR:170:205: Interrupts inconsistent, severity `20':205


	save_flags(flags);
Start --->
	cli();
	if (lp->pppbind < 0) {  /* device bounded to ippp device ? */
		isdn_net_dev *net_dev = dev->netdev;
		char exclusive[ISDN_MAX_CHANNELS];	/* exclusive flags */
		memset(exclusive, 0, ISDN_MAX_CHANNELS);
		while (net_dev) {	/* step through net devices to find exclusive minors */
			isdn_net_local *lp = net_dev->local;

	... DELETED 25 lines ...

	}
	unit = isdn_ppp_if_get_unit(lp->name);	/* get unit number from interface name .. ugly! */
	if (unit < 0) {
		printk(KERN_ERR "isdn_ppp_bind: illegal interface name %s.\n", lp->name);
Error --->
		return -1;
	}

	lp->ppp_slot = i;
	is = ippp_table[i];
---------------------------------------------------------
[BUG] error path

/u2/acc/oses/linux/2.4.1/drivers/net/appletalk/cops.c:776:cops_rx: ERROR:INTR:763:804: Interrupts inconsistent, severity `20':804


	save_flags(flags);
Start --->
        cli();  /* Disable interrupts. */

        if(lp->board==DAYNA)
        {
                outb(0, ioaddr);                /* Send out Zero length. */
                outb(0, ioaddr);
                outb(DATA_READ, ioaddr);        /* Send read command out. */

	... DELETED 31 lines ...

			dev->name);
                lp->stats.rx_dropped++;
                while(pkt_len--)        /* Discard packet */
                        inb(ioaddr);
Error --->
                return;
        }
        skb->dev = dev;
        skb_put(skb, pkt_len);
        skb->protocol = htons(ETH_P_LOCALTALK);
---------------------------------------------------------
[BUG] error path
/u2/acc/oses/linux/2.4.1/drivers/net/hamradio/soundmodem/sm_wss.c:173:wss_set_codec_fmt: ERROR:INTR:164:186: Interrupts inconsistent, severity `20':186


	save_flags(flags);
Start --->
	cli();
	/* Clock and data format register */
	write_codec(dev, 0x48, fmt);
	if (SCSTATE->crystal) {
		write_codec(dev, 0x5c, fmt2 & 0xf0);
		/* MCE and interface config reg */
		write_codec(dev, 0x49, (fdx ? 0 : 0x4) | (fullcalib ? 0x18 : 0));

	... DELETED 12 lines ...

		if (!(--time)) {
			printk(KERN_WARNING "%s: ad1848 auto calibration timed out (1)\n",
			       sm_drvname);
			restore_flags(flags);
Error --->
			return -1;
		}
	/*
	 * wait for ACI end
	 */
---------------------------------------------------------
[BUG] error path

/u2/acc/oses/linux/2.4.1/drivers/net/irda/irport.c:943:irport_net_ioctl: ERROR:INTR:947:997: Interrupts inconsistent, severity `20':997

	/* Disable interrupts & save flags */
	save_flags(flags);
Start --->
	cli();

	switch (cmd) {
	case SIOCSBANDWIDTH: /* Set bandwidth */
		if (!capable(CAP_NET_ADMIN))
			return -EPERM;
		irda_task_execute(self, __irport_change_speed, NULL, NULL,

	... DELETED 40 lines ...

	}

	restore_flags(flags);

Error --->
	return ret;
}

static struct net_device_stats *irport_net_get_stats(struct net_device *dev)
{
---------------------------------------------------------
[BUG] error path

/u2/acc/oses/linux/2.4.1/drivers/net/irda/irtty.c:963:irtty_net_ioctl: ERROR:INTR:967:1022: Interrupts inconsistent, severity `20':1022

	/* Disable interrupts & save flags */
	save_flags(flags);
Start --->
	cli();

	switch (cmd) {
	case SIOCSBANDWIDTH: /* Set bandwidth */
		if (!capable(CAP_NET_ADMIN))
			return -EPERM;
		irda_task_execute(self, irtty_change_speed, NULL, NULL,

	... DELETED 45 lines ...

	}

	restore_flags(flags);

Error --->
	return ret;
}

static struct net_device_stats *irtty_net_get_stats(struct net_device *dev)
{
---------------------------------------------------------
[BUG] error path

/u2/acc/oses/linux/2.4.1/drivers/net/irda/nsc-ircc.c:1954:nsc_ircc_net_ioctl: ERROR:INTR:1958:1980: Interrupts inconsistent, severity `20':1980

	/* Disable interrupts & save flags */
	save_flags(flags);
Start --->
	cli();

	switch (cmd) {
	case SIOCSBANDWIDTH: /* Set bandwidth */
		if (!capable(CAP_NET_ADMIN))
			return -EPERM;
		nsc_ircc_change_speed(self, irq->ifr_baudrate);

	... DELETED 12 lines ...

	}

	restore_flags(flags);

Error --->
	return ret;
}

static struct net_device_stats *nsc_ircc_net_get_stats(struct net_device *dev)
{
---------------------------------------------------------
[BUG] error path

/u2/acc/oses/linux/2.4.1/drivers/net/irda/toshoboe.c:604:toshoboe_net_ioctl: ERROR:INTR:608:632: Interrupts inconsistent, severity `20':632

	/* Disable interrupts & save flags */
	save_flags(flags);
Start --->
	cli();

	switch (cmd) {
	case SIOCSBANDWIDTH: /* Set bandwidth */
		if (!capable(CAP_NET_ADMIN))
			return -EPERM;
		/* toshoboe_setbaud(self, irq->ifr_baudrate); */

	... DELETED 14 lines ...

	}

	restore_flags(flags);

Error --->
	return ret;
}

#ifdef MODULE

---------------------------------------------------------
[BUG] error path

/u2/acc/oses/linux/2.4.1/drivers/net/irda/w83977af_ir.c:1332:w83977af_net_ioctl: ERROR:INTR:1336:1358: Interrupts inconsistent, severity `20':1358

	/* Disable interrupts & save flags */
	save_flags(flags);
Start --->
	cli();

	switch (cmd) {
	case SIOCSBANDWIDTH: /* Set bandwidth */
		if (!capable(CAP_NET_ADMIN))
			return -EPERM;
		w83977af_change_speed(self, irq->ifr_baudrate);

	... DELETED 12 lines ...

	}

	restore_flags(flags);

Error --->
	return ret;
}

static struct net_device_stats *w83977af_net_get_stats(struct net_device *dev)
{
---------------------------------------------------------
[BUG] error path. this bug is interesting

/u2/acc/oses/linux/2.4.1/drivers/net/pcmcia/wavelan_cs.c:2561:wavelan_get_wireless_stats: ERROR:INTR:2528:2561: Interrupts inconsistent, severity `20':2561


  /* Disable interrupts & save flags */
Start --->
  spin_lock_irqsave (&lp->lock, flags);

  if(lp == (net_local *) NULL)
    return (iw_stats *) NULL;
  wstats = &lp->wstats;

  /* Get data from the mmc */

	... DELETED 23 lines ...


#ifdef DEBUG_IOCTL_TRACE
  printk(KERN_DEBUG "%s: <-wavelan_get_wireless_stats()\n", dev->name);
#endif
Error --->
  return &lp->wstats;
}
#endif	/* WIRELESS_EXT */

/************************* PACKET RECEPTION *************************/
---------------------------------------------------------
[BUG] error path

/u2/acc/oses/linux/2.4.1/drivers/net/tokenring/smctr.c:3655:smctr_open_tr: ERROR:INTR:3594:3661: Interrupts inconsistent, severity `20':3661


        save_flags(flags);
Start --->
        cli();

        smctr_set_page(dev, (__u8 *)tp->ram_access);

        if((err = smctr_issue_resume_rx_fcb_cmd(dev, (short)MAC_QUEUE)))
                return (err);


	... DELETED 57 lines ...

        }

        restore_flags(flags);

Error --->
        return (err);
}

/* Check for a network adapter of this type, and return '0 if one exists.
 * If dev->base_addr == 0, probe all likely locations.
---------------------------------------------------------
[BUG] error path

/u2/acc/oses/linux/2.4.1/drivers/net/wan/comx-hw-mixcom.c:505:MIXCOM_open: ERROR:INTR:514:562: Interrupts inconsistent, severity `20':562

	}

Start --->
	save_flags(flags); cli();

	if(hw->channel==1) {
		request_region(dev->base_addr, MIXCOM_IO_EXTENT, dev->name);
	}

	if(hw->channel==0 && !(ch->init_status & IRQ_ALLOCATED)) {

	... DELETED 38 lines ...

			procfile->mode = S_IFREG |  0444;
		}
	}

Error --->
	return 0;
}

static int MIXCOM_close(struct net_device *dev)
{
---------------------------------------------------------
[BUG] error path

/u2/acc/oses/linux/2.4.1/drivers/net/wan/lmc/lmc_main.c:728:lmc_watchdog: ERROR:INTR:661:823: Interrupts inconsistent, severity `20':823

    lmc_trace(dev, "lmc_watchdog in");

Start --->
    spin_lock_irqsave(&sc->lmc_lock, flags);

    if(sc->check != 0xBEAFCAFE){
        printk("LMC: Corrupt net_device stuct, breaking out\n");
        return;
    }


	... DELETED 152 lines ...

    spin_unlock_irqrestore(&sc->lmc_lock, flags);

    lmc_trace(dev, "lmc_watchdog out");

Error --->
}

static int lmc_init(struct net_device * const dev) /*fold00*/
{
    lmc_trace(dev, "lmc_init in");
---------------------------------------------------------
[BUG] error path.

/u2/acc/oses/linux/2.4.1/drivers/scsi/eata_dma.c:490:eata_queue: ERROR:INTR:464:506: Interrupts inconsistent, severity `20':506


    save_flags(flags);
Start --->
    cli();

#if 0
    for (x = 1, sh = first_HBA; x <= registered_HBAs; x++, sh = SD(sh)->next) {
      if(inb((uint)sh->base + HA_RAUXSTAT) & HA_AIRQ) {
            printk("eata_dma: scsi%d interrupt pending in eata_queue.\n"
		   "          Calling interrupt handler.\n", sh->host_no);

	... DELETED 32 lines ...

	    printk(KERN_CRIT "eata_queue pid %ld, HBA QUEUE FULL..., "
		   "returning DID_BUS_BUSY\n", cmd->pid));
	done(cmd);
	restore_flags(flags);
Error --->
	return(0);
    }
    ccb = &hd->ccb[y];

    memset(ccb, 0, sizeof(struct eata_ccb) - sizeof(struct eata_sg_list *));
---------------------------------------------------------
[BUG] error path

/u2/acc/oses/linux/2.4.1/drivers/scsi/qla1280.c:1541:qla1280_intr_handler: ERROR:INTR:1522:1594: Interrupts inconsistent, severity `20':1594

    }
#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,1,95)
Start --->
    spin_lock_irqsave(&io_request_lock, cpu_flags);
    if(test_and_set_bit(QLA1280_IN_ISR_BIT, &ha->flags))
    {
        COMTRACE('X')
        return;
    }
    ha->isr_count++;

	... DELETED 62 lines ...

        WRT_REG_WORD(&reg->ictrl, ISP_EN_INT + ISP_EN_RISC);

        COMTRACE('i')
        LEAVE_INTR("qla1280_intr_handler");
Error --->
}

/**************************************************************************
 *   qla1280_do_dpc
 *
---------------------------------------------------------
[BUG] error path

/u2/acc/oses/linux/2.4.1/drivers/sound/ad1848.c:2735:ad1848_resume: ERROR:INTR:2732:2769: Interrupts inconsistent, severity `20':2769


	save_flags(flags);
Start --->
	cli();

	/* store old mixer levels */
	memcpy(mixer_levels, devc->levels, sizeof (mixer_levels));
	ad1848_init_hw(devc);

	/* restore mixer levels */

	... DELETED 27 lines ...

		outb((bits | dma_bits[devc->dma1] | dma2_bit), config_port);
	}

	restore_flags(flags);
Error --->
      	return 0;
}

static int ad1848_pm_callback(struct pm_dev *dev, pm_request_t rqst, void *data)
{
---------------------------------------------------------
[BUG] error path( default in a switch)

/u2/acc/oses/linux/2.4.1/drivers/sound/emu10k1/midi.c:426:emu10k1_midi_callback: ERROR:INTR:380:426: Interrupts inconsistent, severity `20':426

	DPF(4, "emu10k1_midi_callback()\n");

Start --->
	spin_lock_irqsave(&midi_spinlock, flags);

	switch (msg) {
	case ICARDMIDI_OUTLONGDATA:
		midihdr = (struct midi_hdr *) pmsg[2];

		kfree(midihdr->data);

	... DELETED 36 lines ...

		wake_up_interruptible(&midi_dev->iWait);
		break;

	default:		/* Unknown message */
Error --->
		return -1;
	}

	spin_unlock_irqrestore(&midi_spinlock, flags);

---------------------------------------------------------
[BUG] error path

/u2/acc/oses/linux/2.4.1/drivers/sound/sscape.c:1009:sscape_pnp_upload_file: ERROR:INTR:962:1011: Interrupts inconsistent, severity `20':1011

	dt = data;
	save_flags(flags);
Start --->
	cli();
	while ( len > 0 ) {
		if (len > devc -> buffsize) l = devc->buffsize;
		else l = len;
		len -= l;
		memcpy(devc->raw_buf, dt, l); dt += l;
		sscape_start_dma(devc->dma, devc->raw_buf_phys, l, 0x48);

	... DELETED 39 lines ...

	if ( !done ) printk(KERN_ERR "soundscape: OBP Initialization failed.\n");

	sscape_write( devc, 2, devc->ic_type == IC_ODIE ? 0x70 : 0x40);
	sscape_write( devc, 3, (devc -> dma << 4) + 0x80);
Error --->
	return 1;
}

static void __init sscape_pnp_init_hw(sscape_info* devc)
{
---------------------------------------------------------
[BUG] error path

/u2/acc/oses/linux/2.4.1/net/irda/irttp.c:1595:irttp_proc_read: ERROR:INTR:1547:1595: Interrupts inconsistent, severity `20':1595


	save_flags(flags);
Start --->
	cli();

	self = (struct tsap_cb *) hashbin_get_first(irttp->tsaps);
	while (self != NULL) {
		if (!self || self->magic != TTP_TSAP_MAGIC)
			return len;


	... DELETED 38 lines ...

		self = (struct tsap_cb *) hashbin_get_next(irttp->tsaps);
	}
	restore_flags(flags);

Error --->
	return len;
}

#endif /* PROC_FS */


