Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTIQN4r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 09:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbTIQN4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 09:56:47 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:44199 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262758AbTIQN4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 09:56:42 -0400
Subject: Re: [PATCH] Poll-based IDE dump driver for LKCD
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: vatsa@in.ibm.com
Cc: lkcd-devel@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
In-Reply-To: <20030917144120.A11425@in.ibm.com>
References: <20030917144120.A11425@in.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063806900.12279.47.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Wed, 17 Sep 2003 14:55:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-17 at 10:11, Srivatsa Vaddagiri wrote:
> 	- Would a reset of the drive be required before talking to it?

We would have configured the device at boot up so it should not be. The
disk may be in power saving states.

> 	- When dump is initiated, I am assuming that the drive will be 
>  	  accessible at the I/O port addresses assigned to it initially 
>           during bootup. Can this assumption be wrong under some circumstances? 

At the moment that is fairly safe because we don't handle hot unplugging
and we don't switch controllers between modes

> 	- What if the drive is in some power-save state when dump is being
> 	  initiated? How to deal with that situation?

You must follow the ATA state diagrams.

> 	- Range of IDE controllers supported:
> 		Ideally I would like this driver to run on all the 
> 		IDE controllers supported in Linux. To this extent, I have 
> 		tried calling the I/O functions (OUTB, INB etc) associated 
> 		with the IDE hwif (I have made an assumption that these I/O 
> 		functions are dump safe).

Currently the code ought to be. We really only have three cases
'unplugged' 'pio' and 'mmio'. Pretty much all PATA controllers on Linux
will behave sanely if you stick to single sector PIO and probably multi
sector PIO (at least I see no reason why not). After the write you must
also follow the shutdown sequence and flush the cache etc to be sure the
dump is all on physical media.

> 		Like this, are there some more measures that I need to take
> 		in order for my driver to run on all the IDE controllers 
> 		supported in Linux?

For the old PATA stuff no - the interface is pretty standardised. For
all the upcoming SATA stuff its likely to be one or more new standards
that won't use the existing IDE layer at all and becomes more like the
scsi dump problem.

> +/* Wait for at least N usecs (1 clock per cycle, 10GHz processor = 10000) */
> +/* ToDo : replace this routine based on loops_per_jiffy?? */
> +static inline void dump_udelay(unsigned int num_usec)
> +{
> +	unsigned int i;
> +	for (i = 0; i < 10000 * num_usec; i++);
> +}

This routine must wait at least the right time delay. Also your delay
code should be volatile. Right now i=10000*num_sec; return is a valid
optimisation of your loop

> +/* Same as 'ata_vlb_sync'.
> + * Has been duplicated to insulate from changes that
> + * can happen there
> + *
> + * ToDo: Remove this duplicate and call the original
> + * 'ata_tlb_sync'?
> + */
> +void dump_ata_vlb_sync (ide_drive_t *drive, unsigned long port)
> +{
> +        (void) HWIF(drive)->INB(port);
> +        (void) HWIF(drive)->INB(port);
> +        (void) HWIF(drive)->INB(port);
> +}

Wouldnt worry about Vesa local bus IMHO. If you drop that and io32 stuff
all will be fine.

At the simplest providing you get no serious errors you could grab the
port numbers and the base IN/OUT op fields and just bang the controller
by hand. Basic PIO is an extremely simple sequence of operations even
for LBA48, and you can obtain the mode to use CHS/LBA28/LBA48 from the
IDE code before the box blows up.

Providing the IDE layer saw it you can be fairly sure the disk is
programmed for a valid PIO mode and matching the controller programming,
know the ports and know the command mode expected. With nIEN set you are
using the polled state machine which also makes stuff really simple.


