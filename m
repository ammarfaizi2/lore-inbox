Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261701AbTANHRe>; Tue, 14 Jan 2003 02:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261724AbTANHRd>; Tue, 14 Jan 2003 02:17:33 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:17670
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S261701AbTANHRa>; Tue, 14 Jan 2003 02:17:30 -0500
Date: Mon, 13 Jan 2003 23:23:21 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Ross Biro <rossb@google.com>
cc: alan@lxorguk.ukuu.org.uk, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: [2.4.21-pre3] IDE error recovery
In-Reply-To: <3E237867.4040009@google.com>
Message-ID: <Pine.LNX.4.10.10301132318090.18906-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Whoa, you need to check whic spec you are refering to first.

 Model=FUJITSU MHJ2181AT, FwRev=D034, SerialNo=01001697
 Config={ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=16383/16/63, TrkSize=0, SectSize=0, ECCbytes=4
 BuffType=unknown, BuffSize=512kB, MaxMultSect=16, MultSect=16
 CurCHS=17475/15/63, CurSects=-78446341, LBA=yes, LBAsects=35433216
 IORDY=yes, tPIO={min:240,w/IORDY:120}, tDMA={min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4
 AdvancedPM=yes: disabled (255)
 Drive Supports : Reserved : ATA-2 ATA-3 ATA-4 ATA-5
 Kernel Drive Geometry LogicalCHS=2205/255/63 PhysicalCHS=37495/15/63

This drive claims ATA2-5 support, and thus it accepts the status quo.
Where are you finding the violations?
If the drive vendor states a range of support they are in violation.
This is clearly the point where the driver core needs to have a

	unsinged long drive->support_bits

The mess this is going to create.

Cheers,

On Mon, 13 Jan 2003, Ross Biro wrote:

> 
> Take this patch with a big grain of salt.
> 
> The current IDE error recovery code will send a IDLEIMMEDIATE in the 
> case when a drive is still busy or has drq set during an error.  This is 
> a violation of the ATA spec and hoses up quite a few drives.  The 
> prefered form of error recovery seems to be a soft reset followed by a 
> set features.  This patch replaces the IDLEIMMEDIATE with a reset, but 
> does not do the set features.  The set features should not be necessary, 
> but at least one drive vendor does most of their testing with the set 
> features.  OK_TO_RESET_CONTROLLER must be set to 1 if this patch is applied.
> 
> I've modified the google kernel to add a desired_speed to ide_drive_t 
> and check to see if current_speed != desired_speed before every read or 
> write request.  This causes a set features after a reset.  I can provide 
> patches to do something similiar for 2.4.21, but I'm not sure it's 
> appropriate.  There are bugs in the way hdparm -X is handled in 2.4.20, 
> and this patch would fix them as well, but it may be too large of a 
> patch for a stable kernel.
> 
> This also fixes drive_cmd_intr to do a little better checking to make 
> sure the device is ready.  The spec requires this, but any device that 
> sends an interrupt before it's ready is probably broken.
> 
> I have no idea what impact this will have on older devices or non disks.
> 
> This patch has only been minimally tested.
> 
> ----- snip -------
> diff -durbB linux-2.4.20-p1/drivers/ide/ide-cd.c 
> linux-2.4.20-p2/drivers/ide/ide-cd.c
> --- linux-2.4.20-p1/drivers/ide/ide-cd.c    Wed Jan  8 16:25:04 2003
> +++ linux-2.4.20-p2/drivers/ide/ide-cd.c    Thu Jan  9 11:38:22 2003
> @@ -644,7 +644,11 @@
>      }
>      if (HWIF(drive)->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
>          /* force an abort */
> -        HWIF(drive)->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
> +                /* This violates the ATA Spec and causes trouble for
> +                   many modern hard drives.  I'm not sure if it is 
> necessary
> +                   for older devices or even modern cd-roms. -- RAB
> +                   HWIF(drive)->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG); */
> +                rq->errors |= ERROR_RESET;
>          }
>      if (rq->errors >= ERROR_MAX) {
>          DRIVER(drive)->end_request(drive, 0);
> diff -durbB linux-2.4.20-p1/drivers/ide/ide-disk.c 
> linux-2.4.20-p2/drivers/ide/ide-disk.c
> --- linux-2.4.20-p1/drivers/ide/ide-disk.c    Wed Jan  8 16:25:17 2003
> +++ linux-2.4.20-p2/drivers/ide/ide-disk.c    Thu Jan  9 11:40:20 2003
> @@ -943,7 +943,11 @@
>      }
>      if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
>          /* force an abort */
> -        hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
> +                /* This violates the ATA Spec and causes trouble for
> +                   many modern hard drives.  I'm not sure if it is 
> necessary
> +                   for older devices or even other modern devices. -- RAB
> +                   hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG); */
> +                rq->errors |= ERROR_RESET;
>      }
>      if (rq->errors >= ERROR_MAX)
>          DRIVER(drive)->end_request(drive, 0);
> diff -durbB linux-2.4.20-p1/drivers/ide/ide-io.c 
> linux-2.4.20-p2/drivers/ide/ide-io.c
> --- linux-2.4.20-p1/drivers/ide/ide-io.c    Wed Jan  8 16:25:37 2003
> +++ linux-2.4.20-p2/drivers/ide/ide-io.c    Mon Jan 13 18:01:52 2003
> @@ -328,7 +328,12 @@
>      }
>      if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
>          /* force an abort */
> +                /* This violates the ATA Spec and causes trouble for
> +                   many modern hard drives.  I'm not sure if it is 
> necessary
> +                   for older devices or even other modern ata devices 
> -- RAB
>          hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
> +                */
> +                rq->errors |= ERROR_RESET;
>      }
>      if (rq->errors >= ERROR_MAX) {
>          if (drive->driver != NULL)
> @@ -397,18 +402,63 @@
>      struct request *rq = HWGROUP(drive)->rq;
>      ide_hwif_t *hwif = HWIF(drive);
>      u8 *args = (u8 *) rq->buffer;
> -    u8 stat = hwif->INB(IDE_STATUS_REG);
> +    u8 stat;
>      int retries = 10;
>  
> +        /* The ATA-6 spec requires a 400ns wait when entering the
> +           HPIOI1: Check_status State from the HI4 state.  We should
> +           only get here coming from the HPIOI0 INTRQ_wait state, but
> +           better safe than sorry.  The spec also says a read of the
> +           alt status register accomplishes this wait. */
> +    if (IDE_CONTROL_REG)
> +        (void)hwif->INB(IDE_ALTSTATUS_REG);
> +    else
> +                ide_delay_400ns();
> +
> +        /* The ATA-6 spec says that the should enter the check status
> +           state when it get's an interrupt for a drive command, so
> +           technically, the device can send an interrupt before it has
> +           finished.  I would consider any device that does this to be
> +           broken, but the spec allows it. --RAB 1/10/03 */
> +    stat = hwif->INB(IDE_STATUS_REG);
> +        if (stat & BUSY_STAT) {
> +                /* We are just supposed to poll from here on out. */
> +                if (HWGROUP(drive)->poll_timeout == 0) {
> +                        
> HWGROUP(drive)->poll_timeout=WAIT_CMD/CMD_POLL_TICKS;
> +                } else if (--HWGROUP(drive)->poll_timeout == 0) {
> +                        return DRIVER(drive)->error(drive,
> +                                                    "drive_cmd timeout",
> +                                                    stat);
> +                }
> +                ide_set_handler(drive, drive_cmd_intr, CMD_POLL_TICKS, 
> NULL);
> +                return ide_started;
> +        }
> +
>      local_irq_enable();
> -    if ((stat & DRQ_STAT) && args && args[3]) {
> +
> +        /* We want to make sure that the device and the command
> +           both agree on wether or not data is returned by the command
> +           that was just issued.  If they do not, it is an error. */
> +        if (args && args[3]) {
>          u8 io_32bit = drive->io_32bit;
> +                /* The software expects some data back.  If the drive does
> +                   not, then it is an error. */
> +                if (!(stat & DRQ_STAT)) {
> +                        return DRIVER(drive)->error(drive, "drive_cmd 
> no data", stat);
> +                }
>          drive->io_32bit = 0;
>          hwif->ata_input_data(drive, &args[4], args[3] * SECTOR_WORDS);
>          drive->io_32bit = io_32bit;
>          while (((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) && 
> retries--)
>              udelay(100);
> +        } else {
> +                /* The software does not expect data, so if the drive
> +                   returns some, then it's an error. */
> +                if (stat & DRQ_STAT) {
> +                        return DRIVER(drive)->error(drive, "drive_cmd 
> unexpected data", stat);
> +                }
>      }
> +
>  
>      if (!OK_STAT(stat, READY_STAT, BAD_STAT))
>          return DRIVER(drive)->error(drive, "drive_cmd", stat);
> diff -durbB linux-2.4.20-p1/drivers/ide/ide-taskfile.c 
> linux-2.4.20-p2/drivers/ide/ide-taskfile.c
> --- linux-2.4.20-p1/drivers/ide/ide-taskfile.c    Wed Jan  8 16:25:43 2003
> +++ linux-2.4.20-p2/drivers/ide/ide-taskfile.c    Fri Jan 10 11:19:07 2003
> @@ -485,7 +485,13 @@
>      }
>      if (hwif->INB(IDE_STATUS_REG) & (BUSY_STAT|DRQ_STAT)) {
>          /* force an abort */
> -        hwif->OUTB(WIN_IDLEIMMEDIATE, IDE_COMMAND_REG);
> +                /* This violates the ATA Spec and causes trouble for
> +                   many modern hard drives.  I'm not sure if it is 
> necessary
> +                   for older devices or even other modern ata devices 
> -- RAB
> +        hwif->OUTB(WIN_IDLEIMMEDIATE,IDE_COMMAND_REG);
> +                */
> +                rq->errors |= ERROR_RESET;
> +
>      }
>      if (rq->errors >= ERROR_MAX) {
>          DRIVER(drive)->end_request(drive, 0);
> diff -durbB linux-2.4.20-p1/include/linux/ide.h 
> linux-2.4.20-p2/include/linux/ide.h
> --- linux-2.4.20-p1/include/linux/ide.h    Thu Jan  9 15:37:22 2003
> +++ linux-2.4.20-p2/include/linux/ide.h    Mon Jan 13 18:04:47 2003
> @@ -271,6 +271,10 @@
>  #define WAIT_WORSTCASE    (30*HZ)    /* 30sec  - worst case when 
> spinning up */
>  #define WAIT_CMD    (10*HZ)    /* 10sec  - maximum wait for an IRQ to 
> happen */
>  #define WAIT_MIN_SLEEP    (2*HZ/100)    /* 20msec - minimum sleep time */
> +#define CMD_POLL_TICKS  (1)     /* How long to wait in ticks between
> +                                   status checks for a drive cmd
> +                                   that set it's interrupt before it
> +                                   was complete. */
>  
>  #define HOST(hwif,chipset)                    \
>  {                                \
> 
> 

Andre Hedrick
LAD Storage Consulting Group

