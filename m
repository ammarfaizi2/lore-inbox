Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266318AbTAJUP4>; Fri, 10 Jan 2003 15:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266322AbTAJUP4>; Fri, 10 Jan 2003 15:15:56 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:54545
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S266318AbTAJUPu>; Fri, 10 Jan 2003 15:15:50 -0500
Date: Fri, 10 Jan 2003 12:22:13 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Ross Biro <rossb@google.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: [2.4.21-pre3] Fix for SMP race condition in IDE code
In-Reply-To: <3E1F0CF5.4000304@google.com>
Message-ID: <Pine.LNX.4.10.10301101215020.31168-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ross,

Sheesh, I know who is a candiated for me to dump the maintainership on in
the future!  This will take a little time to reveiw; however, I know of no
one who runs systems in this scale.

Also "t" is the last drive.

If you need more drives, use the upper half of the current majors
/dev/hdu 3,128
/dev/hdv 3,192

Repeat ... that will make it to 20 channels.

Cheers,


On Fri, 10 Jan 2003, Ross Biro wrote:

> 
> There is a race condition in all versions of the IDE code that I've 
> looked at including 2.4.18 and 2.4.21-pre3. Basically on an SMP system 
> if mutiple IDE channels are on the same interrupt and 1 channel sends 
> has an interrupt pending on 1 processor while the other processor is 
> calling ide_set_handler, then the interrupt can be mistaken for command 
> completion on both channels, and a command can be completed before it is 
> even issued.
> 
> This problem can be triggered with the following code
> 
> cd /proc/ide
> (while true; do for i in hd[a-z]; do for j in 1 2 3 ; do cat 
> $i/smart_values >/dev/null; done; done; done) &
> (while true; do for i in hd[a-z]; do dd if=/dev/$i of=/dev/null bs=4096k 
> skip=0 & done; wait; done) &
> 
> And can be seen by properly instrumenting drive_cmd_intr to check for 
> errors.
> 
> On a dual proc machine with 4 channels on a single interrupt and 2.4.18 
> I expec to see an error about once every twenty minutes with the above 
> code.  I believe it should occur much less often on 2.4.20 and above.  
> 
> Drives react to this problem in different ways.  Often they simply lock 
> up and refuse to talk to the host until they have been properly reset. 
>  Some drives require a power cycle before they will work properly again.
> 
> This problem required the use of over 200 machines, approximately 2000 
> drives, a bus analyzer, and a lot of cooperation from a couple of drive 
> manufacturers to go from "something goes wrong once in a while" to 
> something we could easily reproduce.
> 
> This patch has only been minimally tested and then only with 1 brand of 
> ide hard drive.
> 
> ----- snip ------
> 
> diff -durbB linux-2.4.20/drivers/ide/ide-cd.c 
> linux-2.4.20-p1/drivers/ide/ide-cd.c
> --- linux-2.4.20/drivers/ide/ide-cd.c    Thu Jan  9 11:14:01 2003
> +++ linux-2.4.20-p1/drivers/ide/ide-cd.c    Wed Jan  8 16:25:04 2003
> @@ -863,11 +864,15 @@
>          HWIF(drive)->OUTB(drive->ctl, IDE_CONTROL_REG);
>  
>      if (CDROM_CONFIG_FLAGS (drive)->drq_interrupt) {
> +                unsigned long flags;
>          if (HWGROUP(drive)->handler != NULL)
>              BUG();
> -        ide_set_handler (drive, handler, WAIT_CMD, cdrom_timer_expiry);
> +                spin_lock_irqsave(&io_request_lock, flags);
>          /* packet command */
>          HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
> +        ide_set_handler_nolock (drive, handler, WAIT_CMD, 
> cdrom_timer_expiry);
> +                ide_delay_400ns();
> +                spin_unlock_irqrestore(&io_request_lock, flags);
>          return ide_started;
>      } else {
>          /* packet command */
> diff -durbB linux-2.4.20/drivers/ide/ide-disk.c 
> linux-2.4.20-p1/drivers/ide/ide-disk.c
> --- linux-2.4.20/drivers/ide/ide-disk.c    Thu Jan  9 11:14:01 2003
> +++ linux-2.4.20-p1/drivers/ide/ide-disk.c    Wed Jan  8 16:25:17 2003
> @@ -467,12 +467,15 @@
>  #endif /* CONFIG_BLK_DEV_IDEDMA */
>          if (HWGROUP(drive)->handler != NULL)
>              BUG();
> -        ide_set_handler(drive, &read_intr, WAIT_CMD, NULL);
>  
>          command = ((drive->mult_count) ?
>                 ((lba48) ? WIN_MULTREAD_EXT : WIN_MULTREAD) :
>                 ((lba48) ? WIN_READ_EXT : WIN_READ));
> +                spin_lock_irqsave(&io_request_lock, flags);
>          hwif->OUTB(command, IDE_COMMAND_REG);
> +        ide_set_handler_nolock(drive, &read_intr, WAIT_CMD, NULL);
> +                ide_delay_400ns();
> +                spin_unlock_irqrestore(&io_request_lock, flags);
>          return ide_started;
>      } else if (rq_data_dir(rq) == WRITE) {
>          ide_startstop_t startstop;
> diff -durbB linux-2.4.20/drivers/ide/ide-dma.c 
> linux-2.4.20-p1/drivers/ide/ide-dma.c
> --- linux-2.4.20/drivers/ide/ide-dma.c    Thu Jan  9 11:14:01 2003
> +++ linux-2.4.20-p1/drivers/ide/ide-dma.c    Thu Jan  9 15:32:09 2003
> @@ -655,6 +655,7 @@
>      unsigned int count    = 0;
>      u8 dma_stat = 0, lba48    = (drive->addressing == 1) ? 1 : 0;
>      task_ioreg_t command    = WIN_NOP;
> +        unsigned long flags;
>  
>      if (!(count = ide_build_dmatable(drive, rq, PCI_DMA_FROMDEVICE)))
>          /* try PIO instead of DMA */
> @@ -673,7 +674,6 @@
>      /* paranoia check */
>      if (HWGROUP(drive)->handler != NULL)
>          BUG();
> -    ide_set_handler(drive, &ide_dma_intr, 2*WAIT_CMD, dma_timer_expiry);
>  
>      /*
>       * FIX ME to use only ACB ide_task_t args Struct
> @@ -691,7 +691,11 @@
>      }
>  #endif
>      /* issue cmd to drive */
> +        spin_lock_irqsave(&io_request_lock, flags);
>      hwif->OUTB(command, IDE_COMMAND_REG);
> +    ide_set_handler_nolock(drive, &ide_dma_intr, 2*WAIT_CMD, 
> dma_timer_expiry);
> +        ide_delay_400ns();
> +        spin_unlock_irqrestore(&io_request_lock, flags);
>  
>      return HWIF(drive)->ide_dma_count(drive);
>  }
> @@ -707,6 +711,7 @@
>      unsigned int count    = 0;
>      u8 dma_stat = 0, lba48    = (drive->addressing == 1) ? 1 : 0;
>      task_ioreg_t command    = WIN_NOP;
> +        unsigned long flags;
>  
>      if (!(count = ide_build_dmatable(drive, rq, PCI_DMA_TODEVICE)))
>          /* try PIO instead of DMA */
> @@ -725,7 +730,6 @@
>      /* paranoia check */
>      if (HWGROUP(drive)->handler != NULL)
>          BUG();
> -    ide_set_handler(drive, &ide_dma_intr, 2*WAIT_CMD, dma_timer_expiry);
>      /*
>       * FIX ME to use only ACB ide_task_t args Struct
>       */
> @@ -742,7 +746,13 @@
>      }
>  #endif
>      /* issue cmd to drive */
> +        spin_lock_irqsave(&io_request_lock, flags);
>      hwif->OUTB(command, IDE_COMMAND_REG);
> +    ide_set_handler_nolock(drive, &ide_dma_intr,
> +                               2*WAIT_CMD, dma_timer_expiry);
> +        ide_delay_400ns();
> +        spin_unlock_irqrestore(&io_request_lock, flags);
> +       
>      return HWIF(drive)->ide_dma_count(drive);
>  }
>  
> diff -durbB linux-2.4.20/drivers/ide/ide-floppy.c 
> linux-2.4.20-p1/drivers/ide/ide-floppy.c
> --- linux-2.4.20/drivers/ide/ide-floppy.c    Thu Jan  9 11:14:01 2003
> +++ linux-2.4.20-p1/drivers/ide/ide-floppy.c    Wed Jan  8 16:15:17 2003
> @@ -1123,14 +1123,17 @@
>      }
>     
>      if (test_bit(IDEFLOPPY_DRQ_INTERRUPT, &floppy->flags)) {
> +                unsigned long flags;
>          if (HWGROUP(drive)->handler != NULL)
>              BUG();
> +        /* Issue the packet command */
> +                spin_lock_irqsave(&io_request_lock, flags);
> +        HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
>          ide_set_handler(drive,
>                  pkt_xfer_routine,
>                  IDEFLOPPY_WAIT_CMD,
>                  NULL);
> -        /* Issue the packet command */
> -        HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
> +                spin_unlock_irqrestore(&io_request_lock, flags);
>          return ide_started;
>      } else {
>          /* Issue the packet command */
> diff -durbB linux-2.4.20/drivers/ide/ide-io.c 
> linux-2.4.20-p1/drivers/ide/ide-io.c
> --- linux-2.4.20/drivers/ide/ide-io.c    Thu Jan  9 11:14:01 2003
> +++ linux-2.4.20-p1/drivers/ide/ide-io.c    Wed Jan  8 16:25:37 2003
> @@ -363,14 +363,21 @@
>  void ide_cmd (ide_drive_t *drive, u8 cmd, u8 nsect, ide_handler_t *handler)
>  {
>      ide_hwif_t *hwif = HWIF(drive);
> +        unsigned long flags;
> +
>      if (HWGROUP(drive)->handler != NULL)
>          BUG();
> -    ide_set_handler(drive, handler, WAIT_CMD, NULL);
>      if (IDE_CONTROL_REG)
>          hwif->OUTB(drive->ctl,IDE_CONTROL_REG);    /* clear nIEN */
>      SELECT_MASK(drive,0);
>      hwif->OUTB(nsect,IDE_NSECTOR_REG);
> +
> +        spin_lock_irqsave(&io_request_lock, flags);
>      hwif->OUTB(cmd,IDE_COMMAND_REG);
> +    ide_set_handler_nolock(drive, handler, WAIT_CMD, NULL);
> +        ide_delay_400ns();
> +        spin_unlock_irqrestore(&io_request_lock, flags);
> +
>  }
>  
>  EXPORT_SYMBOL(ide_cmd);
> diff -durbB linux-2.4.20/drivers/ide/ide-iops.c 
> linux-2.4.20-p1/drivers/ide/ide-iops.c
> --- linux-2.4.20/drivers/ide/ide-iops.c    Thu Jan  9 11:14:01 2003
> +++ linux-2.4.20-p1/drivers/ide/ide-iops.c    Wed Jan  8 15:54:18 2003
> @@ -908,13 +908,14 @@
>   * timer is started to prevent us from waiting forever in case
>   * something goes wrong (see the ide_timer_expiry() handler later on).
>   */
> -void ide_set_handler (ide_drive_t *drive, ide_handler_t *handler,
> +
> +/* This version doesn't get the spinlock, so you must call it with a 
> spinlock
> +   on io_request_lock. */
> +void ide_set_handler_nolock (ide_drive_t *drive, ide_handler_t *handler,
>                unsigned int timeout, ide_expiry_t *expiry)
>  {
> -    unsigned long flags;
>      ide_hwgroup_t *hwgroup = HWGROUP(drive);
>  
> -    spin_lock_irqsave(&io_request_lock, flags);
>      if (hwgroup->handler != NULL) {
>          printk("%s: ide_set_handler: handler not null; "
>              "old=%p, new=%p\n",
> @@ -924,6 +925,15 @@
>      hwgroup->expiry        = expiry;
>      hwgroup->timer.expires    = jiffies + timeout;
>      add_timer(&hwgroup->timer);
> +}
> +
> +/* This version grabs and releases the io_request_lock, so must be called
> +   with out the spinlock grabbed. */
> +void ide_set_handler (ide_drive_t *drive, ide_handler_t *handler,
> +              unsigned int timeout, ide_expiry_t *expiry) {
> +    unsigned long flags;
> +    spin_lock_irqsave(&io_request_lock, flags);
> +        ide_set_handler_nolock(drive, handler, timeout, expiry);
>      spin_unlock_irqrestore(&io_request_lock, flags);
>  }
>  
> diff -durbB linux-2.4.20/drivers/ide/ide-tape.c 
> linux-2.4.20-p1/drivers/ide/ide-tape.c
> --- linux-2.4.20/drivers/ide/ide-tape.c    Thu Jan  9 11:14:01 2003
> +++ linux-2.4.20-p1/drivers/ide/ide-tape.c    Wed Jan  8 16:20:09 2003
> @@ -2457,13 +2457,17 @@
>          set_bit(PC_DMA_IN_PROGRESS, &pc->flags);
>  #endif /* CONFIG_BLK_DEV_IDEDMA */
>      if (test_bit(IDETAPE_DRQ_INTERRUPT, &tape->flags)) {
> +                unsigned long flags;
>          if (HWGROUP(drive)->handler != NULL)
>              BUG();
> -        ide_set_handler(drive,
> +
> +                spin_lock_irqsave(&io_request_lock, flags);
> +        HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
> +        ide_set_handler_nolock(drive,
>                  &idetape_transfer_pc,
>                  IDETAPE_WAIT_CMD,
>                  NULL);
> -        HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
> +                spin_unlock_irqrestore(&io_request_lock, flags);
>          return ide_started;
>      } else {
>          HWIF(drive)->OUTB(WIN_PACKETCMD, IDE_COMMAND_REG);
> diff -durbB linux-2.4.20/drivers/ide/ide-taskfile.c 
> linux-2.4.20-p1/drivers/ide/ide-taskfile.c
> --- linux-2.4.20/drivers/ide/ide-taskfile.c    Thu Jan  9 11:14:01 2003
> +++ linux-2.4.20-p1/drivers/ide/ide-taskfile.c    Wed Jan  8 16:25:43 2003
> @@ -173,6 +173,7 @@
>      task_struct_t *taskfile    = (task_struct_t *) task->tfRegister;
>      hob_struct_t *hobfile    = (hob_struct_t *) task->hobRegister;
>      u8 HIHI            = (drive->addressing == 1) ? 0xE0 : 0xEF;
> +        unsigned long flags;
>  
>  #ifdef CONFIG_IDE_TASK_IOCTL_DEBUG
>      void debug_taskfile(drive, task);
> @@ -201,8 +202,14 @@
>  
>      hwif->OUTB((taskfile->device_head & HIHI) | drive->select.all, 
> IDE_SELECT_REG);
>      if (task->handler != NULL) {
> -        ide_set_handler(drive, task->handler, WAIT_WORSTCASE, NULL);
> +                spin_lock_irqsave(&io_request_lock, flags);
>          hwif->OUTB(taskfile->command, IDE_COMMAND_REG);
> +                /* We need to give the drive time to set the busy
> +                   flag, or we may mistake an interrupt from another drive
> +                   for the command completion on this drive. */
> +        ide_set_handler_nolock(drive, task->handler, WAIT_WORSTCASE, NULL);
> +                ide_delay_400ns();
> +                spin_unlock_irqrestore(&io_request_lock, flags);
>          if (task->prehandler != NULL)
>              return task->prehandler(drive, task->rq);
>          return ide_started;
> @@ -1832,6 +1839,7 @@
>      ide_hwif_t *hwif    = HWIF(drive);
>      task_struct_t *taskfile    = (task_struct_t *) task->tfRegister;
>      hob_struct_t *hobfile    = (hob_struct_t *) task->hobRegister;
> +        unsigned long flags;
>  #if DEBUG_TASKFILE
>      u8 status;
>  #endif
> @@ -1929,9 +1937,13 @@
>               if (task->handler == NULL)
>                  return ide_stopped;
>  
> -            ide_set_handler(drive, task->handler, WAIT_WORSTCASE, NULL);
> +                       
>              /* Issue the command */
> +                        spin_lock_irqsave(&io_request_lock, flags);
>              hwif->OUTB(taskfile->command, IDE_COMMAND_REG);
> +            ide_set_handler_nolock(drive, task->handler,
> +                                               WAIT_WORSTCASE, NULL);
> +                        spin_unlock_irqrestore(&io_request_lock, flags);
>              if (task->prehandler != NULL)
>                  return task->prehandler(drive, HWGROUP(drive)->rq);
>      }
> diff -durbB linux-2.4.20/include/asm-i386/ide.h 
> linux-2.4.20-p1/include/asm-i386/ide.h
> --- linux-2.4.20/include/asm-i386/ide.h    Thu Jan  9 11:17:05 2003
> +++ linux-2.4.20-p1/include/asm-i386/ide.h    Fri Jan 10 09:54:07 2003
> @@ -14,6 +14,7 @@
>  #ifdef __KERNEL__
>  
>  #include <linux/config.h>
> +#include <linux/delay.h>
>  
>  #ifndef MAX_HWIFS
>  # ifdef CONFIG_BLK_DEV_IDEPCI
> @@ -22,6 +23,16 @@
>  #define MAX_HWIFS    6
>  # endif
>  #endif
> +
> +
> +
> +/* The ATA spec requires 400ns delays all over the place. */
> +/* Do the same fixed point trick the udelay does to get our delay. */
> +#define IDE_DELAY_400NS
> +static __inline__ void ide_delay_400ns(void)
> +{
> +        __const_udelay (400 * 4);
> +}
>  
>  static __inline__ int ide_default_irq(ide_ioreg_t base)
>  {
> diff -durbB linux-2.4.20/include/linux/ide.h 
> linux-2.4.20-p1/include/linux/ide.h
> --- linux-2.4.20/include/linux/ide.h    Thu Jan  9 11:17:05 2003
> +++ linux-2.4.20-p1/include/linux/ide.h    Thu Jan  9 15:37:22 2003
> @@ -18,6 +18,7 @@
>  #include <linux/bitops.h>
>  #include <linux/highmem.h>
>  #include <linux/pci.h>
> +#include <linux/delay.h>
>  #include <asm/byteorder.h>
>  #include <asm/system.h>
>  #include <asm/hdreg.h>
> @@ -354,6 +355,11 @@
>  
>  #include <asm/ide.h>
>  
> +#ifndef IDE_DELAY_400NS
> +#define IDE_DELAY_400NS
> +static inline void ide_delay_400ns(void) { udelay(1); }
> +#endif
> +
>  /* Currently only m68k, apus and m8xx need it */
>  #ifdef IDE_ARCH_ACK_INTR
>  extern int ide_irq_lock;
> @@ -1282,6 +1288,7 @@
>   * and also to start the safety timer.
>   */
>  extern void ide_set_handler(ide_drive_t *, ide_handler_t *, unsigned 
> int, ide_expiry_t *);
> +extern void ide_set_handler_nolock(ide_drive_t *, ide_handler_t *, 
> unsigned int, ide_expiry_t *);
>  
>  /*
>   * Error reporting, in human readable form (luxurious, but a memory hog).
> 
> 

Andre Hedrick
LAD Storage Consulting Group

