Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261297AbTJHJge (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 05:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbTJHJgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 05:36:33 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:41461 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261239AbTJHJf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 05:35:56 -0400
Date: Wed, 8 Oct 2003 15:13:57 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkcd-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Subject: Re: [PATCH] Poll-based IDE driver
Message-ID: <20031008151357.A31976@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20030917144120.A11425@in.ibm.com> <1063806900.12279.47.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1063806900.12279.47.camel@dhcp23.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Sep 17, 2003 at 02:55:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,
	Thanks for your review comments. I have modified
my code to take care of some of them.

I have couple of more questions:

1. Taking control of the drive
	It is possible that the kernel IDE driver was very _actively_
	using the dump drive when my driver takes over. For ex, there
	may be active DMA requests pending with the drive when 
	my driver takes control ..

	Currently all my drive does to take control of the drive
	is to disable drive interrupts (set nIEN bit). It then
	starts issuing PIO WRITE commands to write data to disk.

	Do I need to do anything else in order to take 
	control of the drive?
	
	Do I need to explicitly program the drive for PIO transfer
	mode before I start issuing it PIO write commands?

2. Power Management
	I found that the drive responds to my PIO write commands
	even when it is in Standby mode. So provided the drive
	is not in Sleep state, I guess I dont have to do anything 
	special to take care of Power Management. 

	Tackling Sleep state may involve a drive reset followed by 
	reinitializing drive parameters which will make my driver 
	more complex (as I may have to take care of reset sequence of 
	various chipsets separately). For now, I would like my driver 
	not supporting the sleep state.

3. Shutdown sequence
	You mentioned that I need to follow proper shutdown sequence
	when I am done writing to the drive. Apart from 
	flushing (if the drive supports it) is there anything
	more to the shutdown sequence?

4. Relinquishing control of the drive
	It is possible that after my dump is over 
	system resumes working as before. This 
	is termed as "non-disruptive" dumping in LKCD
	and is possible, for ex, in case of OOPS.

	In such cases, I have to ensure that the 
	kernel IDE driver continues working
	normally as before wrt the dump drive.
	Kernel IDE driver will have no knowledge
	of the fact that my dump driver had taken 
	control and had done several PIO WRITEs to the
	drive before giving control back.

	Currently all I am doing to give control back to
	the kernel IDE driver is to re-enable the drive
	interrupts (clear nIEN). 
		
	Is there anything more I need to be taking care of?

TIA for your comments ..

FYI I am attaching the modified polled IDE driver below :


~~~~~~~~~~~~~~~~~  BEGIN dump_ideops.c ~~~~~~~~~~~~~~~~~~~~~~~~~~

/*
 * Low-level routines for doing polled I/O to IDE drive
 * ====================================================
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 *
 *  Copyright (C) 1994-1998  Linus Torvalds & authors (see below)
 *  Copyright (C) 1998-2002  Linux ATA Development
 *  			     Andre Hedrick <andre@linux-ide.org>
 *  Copyright (C) 2003       Red Hat <alan@redhat.com>
 *  Copyright (C) IBM Corporation, 2003
 *
 * Started: August 2003 - Srivatsa Vaddagiri (vatsa@in.ibm.com)
 * 	    Based on dump_blockdev.c, IDE Disk Driver and 
 * 	    Rusty's OOPS dump driver
 *
 */


#include <linux/ide.h>
#include <linux/hdreg.h>
#include "dump_ide.h"


int is_valid_ide_hwif(ide_hwif_t *hwif)
{
	int i=0;

	for (i=0; i<MAX_HWIFS; ++i)
		if (hwif == &ide_hwifs[i])
			return 1;

	return 0;
}

void disable_drive_interrupts(ide_drive_t *drive)
{
	if (IDE_CONTROL_REG)
		HWIF(drive)->OUTB(drive->ctl|2, IDE_CONTROL_REG);

}

void enable_drive_interrupts(ide_drive_t *drive)
{
	if (IDE_CONTROL_REG)
		HWIF(drive)->OUTB(drive->ctl&0xfd, IDE_CONTROL_REG);

}

/* Wait for at least N usecs (1 clock per cycle, 10GHz processor = 10000) */
/* ToDo : replace this routine based on loops_per_jiffy?? */
static inline void dump_udelay(unsigned int num_usec)
{
	volatile unsigned int i;
	for (i = 0; i < 10000 * num_usec; i++);
}



/* This is essentially same as 'ide_wait_stat' but 
 * with these changes:
 *
 * 	- Calls to local_irq_set/local_irq_restore removed
 * 	  (Interrupts need to be kept disabled while dump
 * 	  is is in progress)
 * 	- Dont consider max_failures for the drive
 * 
 */
static int 
dump_ide_wait_stat (ide_startstop_t *startstop, ide_drive_t *drive, u8 good, u8 bad, unsigned long timeout)
{
	ide_hwif_t *hwif = HWIF(drive);
	u8 stat;
	int i;
 
	dump_udelay(1);	/* spec allows drive 400ns to assert "BUSY" */
	if ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) {
		i=0;
		while ((stat = hwif->INB(IDE_STATUS_REG)) & BUSY_STAT) {
			dump_udelay(1000);
			i+=1000;
			if (timeout && i>timeout) {
				printk ("dump_ide_wait_stat: Timed out waiting for drive to be ready \n");
				return -ETIMEDOUT;
			}
		}
	}
	/*
	 * Allow status to settle, then read it again.
	 * A few rare drives vastly violate the 400ns spec here,
	 * so we'll wait up to 10usec for a "good" status
	 * rather than expensively fail things immediately.
	 * This fix courtesy of Matthew Faupel & Niccolo Rigacci.
	 */
	for (i = 0; i < 10; i++) {
		dump_udelay(1);
		if (OK_STAT((stat = hwif->INB(IDE_STATUS_REG)), good, bad))
			return 0;
	}

	return -EIO;	// Invalid Status ...

}

/* Same as 'ata_vlb_sync'.
 * Has been duplicated to insulate from changes that
 * can happen there
 *
 * ToDo: Remove this duplicate and call the original
 * 'ata_tlb_sync'?
 */
static void dump_ata_vlb_sync (ide_drive_t *drive, unsigned long port)
{
        (void) HWIF(drive)->INB(port);
        (void) HWIF(drive)->INB(port);
        (void) HWIF(drive)->INB(port);
}


/* Same as 'ata_output_data' but
 * with these changes:
 *
 * 	- Remove calls to local_irq_save/local_irq_restore.
 *
 */
static void dump_ata_output_data (ide_drive_t *drive, void *buffer, u32 wcount)
{
        ide_hwif_t *hwif        = HWIF(drive);
        u8 io_32bit             = drive->io_32bit;

        if (io_32bit) {
                if (io_32bit & 2) {
                        dump_ata_vlb_sync(drive, IDE_NSECTOR_REG);
                        hwif->OUTSL(IDE_DATA_REG, buffer, wcount);
                } else
                        hwif->OUTSL(IDE_DATA_REG, buffer, wcount);
        } else {
                hwif->OUTSW(IDE_DATA_REG, buffer, wcount<<1);
        }
}


/* Same as 'ata_bswap_data'.
 * Has been duplicated to insulate from changes that
 * can happen there
 *
 * ToDo: Remove this duplicate and call the original
 * 'ata_bswap_data'?
 */
static void dump_ata_bswap_data (void *buffer, int wcount)
{
        u16 *p = buffer;

        while (wcount--) {
                *p = *p << 8 | *p >> 8; p++;
                *p = *p << 8 | *p >> 8; p++;
        }
}


/* Same as 'taskfile_output_data'.
 * Has been duplicated to insulate from changes that
 * can happen there
 *
 * ToDo: Remove this duplicate and call the original
 * 'taskfile_output_data'?
 */
static void
dump_taskfile_output_data(ide_drive_t *drive, void *buffer, u32 wcount)
{
	if (drive->bswap) {
               dump_ata_bswap_data(buffer, wcount);
               dump_ata_output_data(drive, buffer, wcount);
               dump_ata_bswap_data(buffer, wcount);
        } else {
               dump_ata_output_data(drive, buffer, wcount);
        }
}

/* Highly simplified version of 'ide_multwrite' */

static int
dump_ide_multwrite(ide_drive_t *drive, void *buf, unsigned long len)
{
	int tx_words;

        tx_words = len>>2;

        dump_taskfile_output_data(drive, buf, tx_words);

        return len;
}

int dump_ide_pio_write(ide_drive_t *drive, sector_t block, char *buf, int len)
{
	ata_nsector_t	nsectors;
	u8 lba48      = (drive->addressing == 1) ? 1 : 0;
	task_ioreg_t command    = WIN_NOP;
	ide_startstop_t	ret;
        int mcount = drive->mult_count? drive->mult_count: 1;
        int burstlen;
        int actlen;
	int retval;

	/* ToDo : Should we consider making burstlen less than what device
	 * 	  supports?
	 */
	burstlen = mcount<<9;
        actlen = len < burstlen?len:burstlen;

	nsectors.all = actlen >> 9;

	/* ToDo : How safe is it to access the OUTB function below??
	 * 	  In most cases it should just be outb which shld
	 * 	  be safe enough. However, if on some platforms OUTB
	 * 	  does something more complicated, then we need to make
	 * 	  sure that it is dump "safe".
	 *
	 * 	  The same issue holds good for other I/O functions
	 * 	  (like INB, OUTSL etc) assosciated with the IDE interface.
	 *
	 */ 
	HWIF(drive)->OUTB(drive->select.all, IDE_SELECT_REG);

	if (drive->select.b.lba) {
		if (drive->addressing == 1) {
			task_ioreg_t tasklets[10];

			tasklets[0] = 0;
			tasklets[1] = 0;
			tasklets[2] = nsectors.b.low;
			tasklets[3] = nsectors.b.high;

			tasklets[4] = (task_ioreg_t) block;
			tasklets[5] = (task_ioreg_t) (block>>8);
			tasklets[6] = (task_ioreg_t) (block>>16);
			tasklets[7] = (task_ioreg_t) (block>>24);
			if (sizeof(block) == 4) {
				tasklets[8] = (task_ioreg_t) 0;
				tasklets[9] = (task_ioreg_t) 0;
			} else {
				tasklets[8] = (task_ioreg_t)((u64)block >> 32);
				tasklets[9] = (task_ioreg_t)((u64)block >> 40);
			}
			HWIF(drive)->OUTB(tasklets[1], IDE_FEATURE_REG);
			HWIF(drive)->OUTB(tasklets[3], IDE_NSECTOR_REG);
			HWIF(drive)->OUTB(tasklets[7], IDE_SECTOR_REG);
			HWIF(drive)->OUTB(tasklets[8], IDE_LCYL_REG);
			HWIF(drive)->OUTB(tasklets[9], IDE_HCYL_REG);

			HWIF(drive)->OUTB(tasklets[0], IDE_FEATURE_REG);
			HWIF(drive)->OUTB(tasklets[2], IDE_NSECTOR_REG);
			HWIF(drive)->OUTB(tasklets[4], IDE_SECTOR_REG);
			HWIF(drive)->OUTB(tasklets[5], IDE_LCYL_REG);
			HWIF(drive)->OUTB(tasklets[6], IDE_HCYL_REG);
			HWIF(drive)->OUTB(0x00|drive->select.all,IDE_SELECT_REG);
		} else {
			HWIF(drive)->OUTB(0x00, IDE_FEATURE_REG);
			HWIF(drive)->OUTB(nsectors.b.low, IDE_NSECTOR_REG);

			HWIF(drive)->OUTB(block, IDE_SECTOR_REG);
			HWIF(drive)->OUTB(block>>=8, IDE_LCYL_REG);
			HWIF(drive)->OUTB(block>>=8, IDE_HCYL_REG);
			HWIF(drive)->OUTB(((block>>8)&0x0f)|drive->select.all,IDE_SELECT_REG);
		}
	} else {
		unsigned int sect,head,cyl,track;
		track = (int)block / drive->sect;
		sect  = (int)block % drive->sect + 1;
		HWIF(drive)->OUTB(sect, IDE_SECTOR_REG);
		head  = track % drive->head;
		cyl   = track / drive->head;

		HWIF(drive)->OUTB(0x00, IDE_FEATURE_REG);
		HWIF(drive)->OUTB(nsectors.b.low, IDE_NSECTOR_REG);

		HWIF(drive)->OUTB(cyl, IDE_LCYL_REG);
		HWIF(drive)->OUTB(cyl>>8, IDE_HCYL_REG);
		HWIF(drive)->OUTB(head|drive->select.all,IDE_SELECT_REG);
	}

	command = ((drive->mult_count) ?
                           ((lba48) ? WIN_MULTWRITE_EXT : WIN_MULTWRITE) :
                           ((lba48) ? WIN_WRITE_EXT : WIN_WRITE));
        HWIF(drive)->OUTB(command, IDE_COMMAND_REG);

	retval = dump_ide_wait_stat(&ret, drive, DATA_READY, drive->bad_wstat, DUMP_WAIT_DRQ);
	if (retval)
		return retval;

	retval = dump_ide_multwrite(drive, buf, actlen);

	return retval;
}


int dump_do_idedisk_flushcache (ide_drive_t *drive)
{
	int rc;
	ide_hwif_t *hwif = HWIF(drive);
	int lba48 = drive->id->cfs_enable_2 & 0x2400;
	u8  flcmd = lba48?WIN_FLUSH_CACHE_EXT: WIN_FLUSH_CACHE;

	if (!(drive->id->cfs_enable_2 & 0x3000) && !(drive->id->cfs_enable_1 & 0x20) ) {
		printk ("Drive does not support write cache ..Hence nothing to flush ! \n");
		return 0;
	}
		
	/* ToDo : Dont we have to wait till the RDY bit is set before 
	 * 	  issuing a command?
	 */
	hwif->OUTB(drive->select.all, IDE_SELECT_REG);
	hwif->OUTBSYNC(drive, flcmd, IDE_COMMAND_REG);

	rc = dump_ide_wait_stat(NULL, drive, READY_STAT, BAD_STAT, DUMP_WAIT_WORSTCASE);

	if (rc) {
	       if (rc == -ETIMEDOUT)
			printk ("dump_do_idedisk_flushcache: Timedout waiting for response ..\n");
		rc = -EIO;
	}

	return rc;
}


int dump_get_ide_power_state(ide_drive_t *drive)
{
	int rc;
	ide_hwif_t	*hwif = HWIF(drive);
	
	/* ToDo : Dont we have to wait till the RDY bit is set before 
	 * 	  issuing a command?
	 */
	hwif->OUTB(drive->select.all, IDE_SELECT_REG);
	hwif->OUTBSYNC(drive, WIN_CHECKPOWERMODE1, IDE_COMMAND_REG);

	rc = dump_ide_wait_stat(NULL, drive, READY_STAT, BAD_STAT, DUMP_WAIT_READY);
	if (rc) {
		printk ("dump_get_ide_power_state: Bad Wait (rc = %d) \n", rc);
		return -EIO;
	}

	rc = hwif->INB(IDE_NSECTOR_REG);

	return rc;
}



~~~~~~~~~~~~~~~~~  END   dump_ideops.c ~~~~~~~~~~~~~~~~~~~~~~~~~~








	
	






	


On Wed, Sep 17, 2003 at 02:55:01PM +0100, Alan Cox wrote:
> On Mer, 2003-09-17 at 10:11, Srivatsa Vaddagiri wrote:
> > 	- Would a reset of the drive be required before talking to it?
> 
> We would have configured the device at boot up so it should not be. The
> disk may be in power saving states.
> 
> > 	- When dump is initiated, I am assuming that the drive will be 
> >  	  accessible at the I/O port addresses assigned to it initially 
> >           during bootup. Can this assumption be wrong under some circumstances? 
> 
> At the moment that is fairly safe because we don't handle hot unplugging
> and we don't switch controllers between modes
> 
> > 	- What if the drive is in some power-save state when dump is being
> > 	  initiated? How to deal with that situation?
> 
> You must follow the ATA state diagrams.
> 
> > 	- Range of IDE controllers supported:
> > 		Ideally I would like this driver to run on all the 
> > 		IDE controllers supported in Linux. To this extent, I have 
> > 		tried calling the I/O functions (OUTB, INB etc) associated 
> > 		with the IDE hwif (I have made an assumption that these I/O 
> > 		functions are dump safe).
> 
> Currently the code ought to be. We really only have three cases
> 'unplugged' 'pio' and 'mmio'. Pretty much all PATA controllers on Linux
> will behave sanely if you stick to single sector PIO and probably multi
> sector PIO (at least I see no reason why not). After the write you must
> also follow the shutdown sequence and flush the cache etc to be sure the
> dump is all on physical media.
> 
> > 		Like this, are there some more measures that I need to take
> > 		in order for my driver to run on all the IDE controllers 
> > 		supported in Linux?
> 
> For the old PATA stuff no - the interface is pretty standardised. For
> all the upcoming SATA stuff its likely to be one or more new standards
> that won't use the existing IDE layer at all and becomes more like the
> scsi dump problem.
> 
> > +/* Wait for at least N usecs (1 clock per cycle, 10GHz processor = 10000) */
> > +/* ToDo : replace this routine based on loops_per_jiffy?? */
> > +static inline void dump_udelay(unsigned int num_usec)
> > +{
> > +	unsigned int i;
> > +	for (i = 0; i < 10000 * num_usec; i++);
> > +}
> 
> This routine must wait at least the right time delay. Also your delay
> code should be volatile. Right now i=10000*num_sec; return is a valid
> optimisation of your loop
> 
> > +/* Same as 'ata_vlb_sync'.
> > + * Has been duplicated to insulate from changes that
> > + * can happen there
> > + *
> > + * ToDo: Remove this duplicate and call the original
> > + * 'ata_tlb_sync'?
> > + */
> > +void dump_ata_vlb_sync (ide_drive_t *drive, unsigned long port)
> > +{
> > +        (void) HWIF(drive)->INB(port);
> > +        (void) HWIF(drive)->INB(port);
> > +        (void) HWIF(drive)->INB(port);
> > +}
> 
> Wouldnt worry about Vesa local bus IMHO. If you drop that and io32 stuff
> all will be fine.
> 
> At the simplest providing you get no serious errors you could grab the
> port numbers and the base IN/OUT op fields and just bang the controller
> by hand. Basic PIO is an extremely simple sequence of operations even
> for LBA48, and you can obtain the mode to use CHS/LBA28/LBA48 from the
> IDE code before the box blows up.
> 
> Providing the IDE layer saw it you can be fairly sure the disk is
> programmed for a valid PIO mode and matching the controller programming,
> know the ports and know the command mode expected. With nIEN set you are
> using the polled state machine which also makes stuff really simple.
> 
> 
> 

-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560033
