Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131632AbRCQMCl>; Sat, 17 Mar 2001 07:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131633AbRCQMCc>; Sat, 17 Mar 2001 07:02:32 -0500
Received: from isis.its.uow.edu.au ([130.130.68.21]:46037 "EHLO
	isis.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S131632AbRCQMCU>; Sat, 17 Mar 2001 07:02:20 -0500
Message-ID: <3AB35289.791E6B2C@uow.edu.au>
Date: Sat, 17 Mar 2001 23:03:21 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.3-pre3 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Junfeng Yang <yjf@stanford.edu>
CC: linux-kernel@vger.kernel.org, mc@cs.stanford.edu
Subject: Re: [CHECKER] 28 potential interrupt errors
In-Reply-To: <Pine.GSO.4.31.0103162216360.10409-100000@elaine24.Stanford.EDU>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junfeng Yang wrote:
> 
> ...
> 
> [BUG] sleep_or_timeout will call interruptible_sleep_on, which will save disabled flags and then restore them.
> 
> /u2/acc/oses/linux/2.4.1/drivers/cdrom/cm206.c:474:send_command: ERROR:INTR:462:474: Interrupts inconsistent, severity `20':474
> 
>   if (!(inw(r_line_status) & ls_transmitter_buffer_empty)) {
>     cd->command = command;
> Start --->
>     cli();                      /* don't interrupt before sleep */
>     outw(dc_mask_sync_error | dc_no_stop_on_error |
>          (inw(r_data_status) & 0x7f), r_data_control);
>     /* interrupt routine sends command */
> 
> Save & Restore
> flags here --->
>     if (sleep_or_timeout(&cd->uart, UART_TIMEOUT)) {
>       debug(("Time out on write-buffer\n"));
>       stats(write_timeout);
> 
>         ... DELETED 2 lines ...
> 
>     }
>     debug(("Write commmand delayed\n"));
>   }
>   else outw(command, r_uart_transmit);
> Error --->
> }

Yes, this is a bug.

> ...

> /u2/acc/oses/linux/2.4.1/drivers/net/irda/irport.c:943:irport_net_ioctl: ERROR:INTR:947:997: Interrupts inconsistent, severity `20':997
> 
>         /* Disable interrupts & save flags */
>         save_flags(flags);
> Start --->
>         cli();
> 
>         switch (cmd) {
>         case SIOCSBANDWIDTH: /* Set bandwidth */
>                 if (!capable(CAP_NET_ADMIN))
>                         return -EPERM;
>                 irda_task_execute(self, __irport_change_speed, NULL, NULL,
> 
>         ... DELETED 40 lines ...
> 
>         }
> 
>         restore_flags(flags);
> 
> Error --->
>         return ret;
> }

Your reporting is a little misleading here.

Yes, there's a bug in this function - the `return -EPERM'
doesn't do a `restore_flags()'.  But there is no bug
in the place you've reported.

(Personally, I think *any* C function which has more than
 one `return' statement is a bug, and we see a classic
 instance here of one of the problems which this practice
 can cause.  Religious issue. )


> ...

> [BUG] error path
> 
> /u2/acc/oses/linux/2.4.1/drivers/net/wan/comx-hw-mixcom.c:505:MIXCOM_open: ERROR:INTR:514:562: Interrupts inconsistent, severity `20':562
> 
>         }
> 
> Start --->
>         save_flags(flags); cli();
> 
>         if(hw->channel==1) {
>                 request_region(dev->base_addr, MIXCOM_IO_EXTENT, dev->name);
>         }
> 
>         if(hw->channel==0 && !(ch->init_status & IRQ_ALLOCATED)) {
> 
>         ... DELETED 38 lines ...
> 
>                         procfile->mode = S_IFREG |  0444;
>                 }
>         }
> 
> Error --->
>         return 0;
> }

There's another problem here.  We're calling request_region()
inside cli().  request_region() can sleep.

On SMP, cli() does all sorts of bizarre things which are
quite different between different architectures.  I don't
know if this practice is actually unsafe on any architectures,
but it is really bad practice.  It's certainly the case that
schedue() will enable interrupts for you, so whatever you're
protecting won't be protected!

So I'd add `sleep inside cli()' to your list of things to
look out for.

Does your tool have the ability to track which functions
can and can't sleep?  This is a very common source of bug.
Grab a spinlock, then call a function which calls a function
which calls a function which calls kmalloc(GFP_KERNEL).  Unless
the spinlock is always protected by a semaphore, this can deadlock.

> 
> /u2/acc/oses/linux/2.4.1/drivers/scsi/eata_dma.c:490:eata_queue: ERROR:INTR:464:506: Interrupts inconsistent, severity `20':506
> 
>     save_flags(flags);
> Start --->
>     cli();
> 
> #if 0
>     for (x = 1, sh = first_HBA; x <= registered_HBAs; x++, sh = SD(sh)->next) {
>       if(inb((uint)sh->base + HA_RAUXSTAT) & HA_AIRQ) {
>             printk("eata_dma: scsi%d interrupt pending in eata_queue.\n"
>                    "          Calling interrupt handler.\n", sh->host_no);
> 
>         ... DELETED 32 lines ...
> 
>             printk(KERN_CRIT "eata_queue pid %ld, HBA QUEUE FULL..., "
>                    "returning DID_BUS_BUSY\n", cmd->pid));
>         done(cmd);
>         restore_flags(flags);
> Error --->
>         return(0);
>     }
>     ccb = &hd->ccb[y];

Something's gone a little wrong here.  The bug is in fact about
20 lines higher up.


Generally: yes, everything you've found needs fixing.
