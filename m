Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278346AbRJWWIi>; Tue, 23 Oct 2001 18:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278351AbRJWWIT>; Tue, 23 Oct 2001 18:08:19 -0400
Received: from relay.EECS.Berkeley.EDU ([169.229.34.228]:6530 "EHLO
	relay.EECS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S278346AbRJWWIG>; Tue, 23 Oct 2001 18:08:06 -0400
Date: Tue, 23 Oct 2001 15:08:40 -0700 (PDT)
From: Jeff Foster <jfoster@cs.berkeley.edu>
To: <linux-kernel@vger.kernel.org>
cc: <tachio@EECS.Berkeley.EDU>
Subject: A small pile of locking bugs
Message-ID: <Pine.LNX.4.33.0110231359530.8770-100000@lagaffe.cs.berkeley.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone.

We've been working on a program analysis tool for finding bugs in C
programs.  As one application we've tried looking for locking bugs in the
linux kernel.  In the process we've found a number of (what we think are)
locking bugs lurking in the 2.4.12 kernel drivers.  Most are new bugs,
though a couple are listed in the Stanford checker database but were never
fixed.

We found two kinds of bugs:

	1. Deadlocks where the same lock is spin_locked twice.
	2. Suspicious inconsistent locking behavior, where a lock may
	   or may not be held at a certain point and the code doesn't
	   seem to handle the two cases.

The details are below.

We think these are all real bugs, but we're not kernel experts.  It would
be great if the experts (you) could confirm the bugs, or let us know if
we're wrong.

Jeff



Potential deadlocks:

drivers/net/de4x5.c
drivers/scsi/aha152x.c
drivers/scsi/NCR5380.c
drivers/scsi/i60uscsi.c
drivers/scsi/pci2220i.c


Inconsistent locking behavior:

drivers/i2o/i2o_proc.c
drivers/isdn/isdn_ppp.c
drivers/scsi/advansys.c
drivers/scsi/ips.c
drivers/sound/cmpci.c
drivers/media/video/saa7110.c
drivers/mtd/chips/cfi_cmdset_0001.c
drivers/net/tokenring/ibmtr.c
drivers/net/wan/lmc/lmc_main.c

------------------------------------------------------------------------------

drivers/net/de4x5.c
	While holding a lock, de4x5_interrupt may call
	de4x5_queue_pkt which locks on the same lock.

In de4x5_interrupt
1639:    lp = (struct de4x5_private *)dev->priv;
         spin_lock(&lp->lock);                             <-- lock acquired
         ...
1682:           de4x5_queue_pkt(de4x5_get_cache(dev), dev);

In de4x5_queue_pkt(struct sk_buff *skb, struct net_device *dev)
1551:    struct de4x5_private *lp = (struct de4x5_private *)dev->priv;
         ...
1566:    spin_lock_irqsave(&lp->lock, flags);           <-- double lock

------------------------------------------------------------------------------

drivers/scsi/aha152x.c
	is_complete holding a lock may call aha152x_error which
	in turn calls show_queues which tried to aquire the same lock.

	NOTE: If this case is ever triggered with AHA152X_DEBUG defined,
	DO_LOCK will print an error message.

In is_complete:
2946:   DO_LOCK(flags);                     <-- acquire lock
	       if(HOSTDATA(shpnt)->in_intr!=0)
                aha152x_error(shpnt, "bottom-half already running!?");
	HOSTDATA(shpnt)->in_intr++;
        DO_UNLOCK(flags);

3052:   static void aha152x_error(struct Scsi_Host *shpnt, char *msg)
        {
          printk(KERN_EMERG "\naha152x%d: %s\n", HOSTNO, msg);
	  show_queues(shpnt);
          panic("aha152x panic\n");
        }

3371:  static void show_queues(struct Scsi_Host *shpnt)
       {
        Scsi_Cmnd *ptr;
	unsigned long flags;

        DO_LOCK(flags);    <-- double lock

------------------------------------------------------------------------------

drivers/scsi/NCR5380.c
	NCR5380_main unlocks io_request_lock and calls
	NCR5380_select which unlocks it again.  NCR5380_select locks
	it at the exit, then NCR5380_main tries to lock it again at
	the exit.

In NCR5380_main
1274:	 spin_unlock_irq(&io_request_lock);         <-- unlocked
         ...
1351:    if (!NCR5380_select(instance, ...)) {
         ...
1427:	 spin_lock_irq(&io_request_lock);           <-- locked again
         /* 	cli();*/
	 main_running = 0;
         }

In NCR5380_select
1838:    spin_unlock_irq(&io_request_lock);         <-- unlocked again
	 while (time_before(jiffies, timeout) && !(NCR5380_read(STATUS_REG) &
					(SR_BSY | SR_IO)));
	 spin_lock_irq(&io_request_lock);           <-- locked

------------------------------------------------------------------------------

drivers/scsi/i60uscsi.c
	orc_device_reset gets pHCB->BitAllocFlagLock and then calls
	orc_alloc_scb(pHCB), which also tries to get
	pHBC (=hcsp)->BitAllocFlagLock.

In orc_device_reset
622:	spin_lock_irqsave(&(pHCB->BitAllocFlagLock), flags);   <-- locked
        ...
648:    if ((pScb = orc_alloc_scb(pHCB)) == NULL) {

In orc_alloc_scb
682: ORC_SCB *orc_alloc_scb(ORC_HCS * hcsp)
     ...
695: spin_lock_irqsave(&(hcsp->BitAllocFlagLock), flags);     <-- double lock

------------------------------------------------------------------------------

drivers/scsi/pci2220i.c
	TimerExpiry may call OpDone while holding io_request_lock,
	then OpDone may call ReconTimerExpiry which locks it again.

In TimerExpiry
1164:   spin_lock_irqsave (&io_request_lock, flags);        <-- locked
	DEB (printk ("\nPCI2220I: Timeout expired "));

        if ( padapter->failinprog )
                {
                DEB (printk ("in failover process"));
		    OpDone (padapter, DecodeError (padapter, inb_p
                (padapter->regSt\atCmd)));
		goto timerExpiryDone;
		     }

723: static void OpDone (PADAPTER2220I padapter, ULONG result)
       {
        Scsi_Cmnd          *SCpnt = padapter->SCpnt;

	   if ( padapter->reconPhase )
	           {
                      padapter->reconPhase = 0;
                      if ( padapter->SCpnt )
                        {
                        Pci2220i_QueueCommand (SCpnt, SCpnt->scsi_done);
                        }
                else
                        {
			if ( padapter->reconOn )
                                {
                                ReconTimerExpiry ((unsigned long)padapter);
		                }
                        }
		   }

1329: static void ReconTimerExpiry (unsigned long data)
      ...
1345: spin_lock_irqsave (&io_request_lock, flags);       <-- double lock

------------------------------------------------------------------------------

drivers/i2o/i2o_proc.c
        In i2o_proc_read_drivers_stored, spinlock not released when
	kmalloc fails.  Also, calling kmalloc with a lock is dangerous.

961:    spin_lock(&i2o_proc_lock);

        len = 0;

        result = kmalloc(sizeof(i2o_driver_result_table), GFP_KERNEL);
        if(result == NULL)
                return -ENOMEM;    <-- lock still held

------------------------------------------------------------------------------

drivers/isdn/isdn_ppp.c
	isdn_ppp_xmit calls isdn_net_get_locked_lp and deals with the
	two return cases correctly.  But then there's still a return
	path where nd->queue->xmit_lock is left locked (if slot < 0 ||
	slot > ISDN_MAX_CHANNELS).

1135:   lp = isdn_net_get_locked_lp(nd);
	if (!lp) {
                printk(KERN_WARNING "%s: all channels busy - requeuing!\n", net\dev->name);
           	return 1;
	}
        /* we have our lp locked from now on */
	      <-- nd->queue->xmit_lock held

	slot = lp->ppp_slot;
	if (slot < 0 || slot > ISDN_MAX_CHANNELS) {
		printk(KERN_ERR "isdn_ppp_xmit: lp->ppp_slot %d\n", lp->ppp_slo\t);
   		kfree_skb(skb);
		return 0;               <-- lock still held
	}

------------------------------------------------------------------------------

drivers/scsi/advansys.c
	advansys_queucommand leaves io_request_lock unlocked when
	asc host is in reset.

5901: ASC_UNLOCK_IO_REQUEST_LOCK

      spin_lock_irqsave(&boardp->lock, flags);

      /*
       * Block new commands while handling a reset or abort request.
       */
      if (boardp->flags & ASC_HOST_IN_RESET) {
	  ASC_DBG1(1,
              "advansys_queuecommand: scp 0x%lx blocked for reset request\n",
              (ulong) scp);
	  scp->result = HOST_BYTE(DID_RESET);

	  /*
           * Add blocked requests to the board's 'done' queue. The queued
           * requests will be completed at the end of the abort or reset
           * handling.
           */
	  asc_enqueue(&boardp->done, scp, ASC_BACK);
	  spin_unlock_irqrestore(&boardp->lock, flags);
	  return 0;             <-- io_request_lock unlocked here
      }
      ...
5971: ASC_LOCK_IO_REQUEST_LOCK

      return 0;   <-- io_request_lock locked on normal return path
      }


------------------------------------------------------------------------------

drivers/scsi/ips.c
	ips_make_passthru unlocks ha->ips_lock on one return path with
	result IPS_FAILURE, but not on another return path with result
	IPS_FAILURE.

2228:  static int
       ips_make_passthru(ips_ha_t *ha, Scsi_Cmnd *SC, ips_scb_t *scb, int intr) {
	IPS_NVRAM_P5    nvram;
        ips_passthru_t *pt;

        METHOD_TRACE("ips_make_passthru", 1);

        if (!SC->request_bufflen || !SC->request_buffer) {
          /* no data */
          DEBUG_VAR(1, "(%s%d) No passthru structure",
		    ips_name, ha->host_num);

		    return (IPS_FAILURE);   <-- ips_lock locked here
	}
        ...
2458:   spin_unlock(&ha->ips_lock);

        return (IPS_FAILURE);               <-- ips_lock unlocked here

------------------------------------------------------------------------------

drivers/sound/cmpci.c
	set_dac_channels returns with s->lock locked sometimes and
	sometimes with s->lock unlocked.  (See, e.g., line if (ret)
	return ret and very end of function.)

886:    spin_lock_irqsave(&s->lock, flags);

        if (ret) return ret;            <-- locked at this return
        ...
921:	spin_unlock_irqrestore(&s->lock, flags);
	return s->curr_channels;        <-- unlocked at this return
        }

------------------------------------------------------------------------------

drivers/media/video/saa7110.c
	saa7110_write_block leaves decoder->bus locked on error exit,
	unlocked on regular exit.  This case doesn't seem to be
	caught.

75: static
    int saa7110_write_block(struct saa7110* decoder, unsigned const char *data, unsigned int len)
    {
	unsigned subaddr = *data;

	LOCK_I2C_BUS(decoder->bus);
	i2c_start(decoder->bus);
	i2c_sendbyte(decoder->bus,decoder->addr,I2C_DELAY);
        while (len-- > 0) {
	      if (i2c_sendbyte(decoder->bus,*data,0)) {
                      i2c_stop(decoder->bus);
                      return -EAGAIN;             <-- lock stil held
		}
              decoder->reg[subaddr++] = *data++;
	}
        i2c_stop(decoder->bus);
	UNLOCK_I2C_BUS(decoder->bus);

	return 0;         <-- lock not held
    }

------------------------------------------------------------------------------

drivers/mtd/chips/cfi_cmdset_0001.c
	do_write_buffer leaves chip->mutex unlocked on most
	return paths, but the last case in the /* Write data */ loop,
	when -EINVAL is returned, leaves chip->mutex locked.


700:	spin_lock_bh(chip->mutex);
        ...
781:    DISABLE_VPP(map);
        return -EINVAL;       <-- chip->mutex locked here
        ...
849:	spin_unlock_bh(chip->mutex);
	return 0;             <-- chip->mutex unlocked here
}

------------------------------------------------------------------------------

drivers/net/tokenring/ibmtr.c
	tok_interrupt may leave ti->lock locked on exit path when
	status & ADAP_CHK_INT hold.

1176:	spin_lock(&(ti->lock));
        ...
1204:	if (status & ADAP_CHK_INT) {
	...
1233:	    return;  <-- ti->lock stil held

------------------------------------------------------------------------------

drivers/net/wan/lmc/lmc_main.c
	In lmc_ioctl, the call to LMC_COPY_FROM_USER may return, but
	we've got lmc_lock.

165:    spin_lock_irqsave(&sc->lmc_lock, flags);

    switch (cmd) {
    /*
         * Return current driver state.  Since we keep this up
         * To date internally, just copy this out to the user.
         */
    case LMCIOCGINFO: /*fold01*/
       LMC_COPY_TO_USER(ifr->ifr_data, &sc->ictl, sizeof (lmc_ctl_t));
				       <-- may return with lock held
       ret = 0;
       break;

lmc_ver.h/109:
	#define LMC_COPY_TO_USER(x, y, z) if(copy_to_user ((x), (y), (z)))  return -EFAULT





